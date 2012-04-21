cimport cython
from cpython cimport bool
from cpython.string cimport *
from libc.stddef cimport *
from libc.stdint cimport *
from libc.stdlib cimport *
from libc.string cimport *

cdef extern from "dnstable.h":
    ctypedef enum dnstable_res:
        dnstable_res_failure
        dnstable_res_success

    ctypedef enum dnstable_entry_type:
        DNSTABLE_ENTRY_TYPE_RRSET
        DNSTABLE_ENTRY_TYPE_RRSET_NAME_FWD
        DNSTABLE_ENTRY_TYPE_RDATA
        DNSTABLE_ENTRY_TYPE_RDATA_NAME_REV

    ctypedef enum dnstable_query_type:
        DNSTABLE_QUERY_TYPE_RRSET
        DNSTABLE_QUERY_TYPE_RDATA_NAME
        DNSTABLE_QUERY_TYPE_RDATA_IP
        DNSTABLE_QUERY_TYPE_RDATA_RAW

    struct dnstable_entry:
        pass
    struct dnstable_iter:
        pass
    struct dnstable_query:
        pass
    struct dnstable_reader:
        pass

    # entry
    void dnstable_entry_destroy(dnstable_entry **)
    dnstable_entry_type dnstable_entry_get_type(dnstable_entry *)
    dnstable_res dnstable_entry_get_rrname(dnstable_entry *, uint8_t **, size_t *)
    dnstable_res dnstable_entry_get_rrtype(dnstable_entry *, uint16_t *)
    dnstable_res dnstable_entry_get_bailiwick(dnstable_entry *, uint8_t **, size_t *)
    dnstable_res dnstable_entry_get_num_rdata(dnstable_entry *, size_t *)
    dnstable_res dnstable_entry_get_rdata(dnstable_entry *, size_t, uint8_t **, size_t *)
    dnstable_res dnstable_entry_get_time_first(dnstable_entry *, uint64_t *)
    dnstable_res dnstable_entry_get_time_last(dnstable_entry *, uint64_t *)
    dnstable_res dnstable_entry_get_count(dnstable_entry *, uint64_t *)

    # iter
    void dnstable_iter_destroy(dnstable_iter **)
    dnstable_res dnstable_iter_next(dnstable_iter *, dnstable_entry **)

    # query
    dnstable_query * dnstable_query_init(dnstable_query_type)
    void dnstable_query_destroy(dnstable_query **)
    char * dnstable_query_get_error(dnstable_query *)
    dnstable_res dnstable_query_set_data(dnstable_query *, char *)
    dnstable_res dnstable_query_set_rrtype(dnstable_query *, char *)
    dnstable_res dnstable_query_set_bailiwick(dnstable_query *, char *)

    # reader
    dnstable_reader * dnstable_reader_init_fname(char *)
    void dnstable_reader_destroy(dnstable_reader **)
    dnstable_iter * dnstable_reader_iter(dnstable_reader *)
    dnstable_iter * dnstable_reader_query(dnstable_reader *, dnstable_query *)