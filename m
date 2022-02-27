Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD34C5B33
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiB0MrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiB0MrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DB6D388
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 04:46:26 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RCCbQ3008597;
        Sun, 27 Feb 2022 12:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GVU2BLy85D6f0oy7jMhBRboP2rTrKP4Z/6QXLi2+Bo4=;
 b=SpvH/VlFGMAOFcf8so/KUqx1gTFyYK5LdUoZEaazSh35FRVaSpt8tSjCqmomq6URNBQ7
 +yc3XyoM5qKiItUfeJu16NWEc/3I8Yu+MmAnuQrn7UubfHekxJd5xfbNZ6QN7KRCWUxu
 I/dCjOAG5DnmmrIhtFKV3IuzEX4mHqACr02mZgJ3bd8pSBhyTIY+3Sj61kR71yLhwMxR
 wxakN42tsjPNlzrV8rsyqvngkA5C9q8ZVUmDpQM95wgXyARV8MYIht8v/K/nSpS0uJA8
 tngK21q31olt2lisTiwzN0PIp/+Yg+ajmYje/qEaaT4zeG3MGx5bsfEfr+ny8NfPBvED wg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eg93vgf28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 12:46:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21RCbc0c008419;
        Sun, 27 Feb 2022 12:46:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu94qat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 12:46:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21RCkEua28967368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Feb 2022 12:46:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66BB3AE053;
        Sun, 27 Feb 2022 12:46:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD64AE045;
        Sun, 27 Feb 2022 12:46:14 +0000 (GMT)
Received: from localhost (unknown [9.171.27.131])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Feb 2022 12:46:14 +0000 (GMT)
Date:   Sun, 27 Feb 2022 13:46:12 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Message-ID: <your-ad-here.call-01645965972-ext-7155@work.hours>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01645924312-ext-0398@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EuiajMlsQV0lseD6uBvHahFHUD0vLPeQ
X-Proofpoint-ORIG-GUID: EuiajMlsQV0lseD6uBvHahFHUD0vLPeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-27_05,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202270089
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 02:11:52AM +0100, Vasily Gorbik wrote:
> Hi Liam,
> 
> there is an endianness issue with maple_metadata. This is broken on
> all big endian architectures. Tests are crashing. See potential fixup
> below. Feel free to apply it or fix the issue in your own way. This does
> not resolve all the issues with the patch series though.

Besides this obvious endianness issue there could be synchronization
issue(s) which manifest on s390 with maple tree tests.

I've double checked that:
- userspace-rcu 13.1 I'm using passes unit and regression tests
- maple tree tests are also crashing with asan/ubsan disabled

If I disable check_rcu_simulated() then in most -Og/-O2 asan
enabled/disabled combinations the rest of the tests happen pass for me now.
But otherwise I see "random" crashes not specific to check_rcu_simulated().

I'll try to find time to look into that and isolate issues further.

E.g. with -O2:
==441271==ERROR: AddressSanitizer: heap-use-after-free on address 0x61c00240fd24 at pc 0x000001003c62 bp 0x03ffb58fe8b0 sp 0x03ffb58fe8a8                                                                    [0/9325]
READ of size 4 at 0x61c00240fd24 thread T1
    #0 0x1003c61 in mas_dead_walk ../../../lib/maple_tree.c:5403
    #1 0x101bbcb in mt_free_walk ../../../lib/maple_tree.c:5428
    #2 0x3ffb9c841e5 in call_rcu_thread /userspace-rcu/src/urcu-call-rcu-impl.h:369
    #3 0x3ffb919cf8b in start_thread pthread_create.c:435
    #4 0x3ffb92164fd  (/lib64/libc.so.6+0x1164fd)

0x61c00240fd24 is located 1060 bytes inside of 1536-byte region [0x61c00240f900,0x61c00240ff00)
freed by thread T1 here:
    #0 0x3ffb9db005b in __interceptor_free ../../../../libsanitizer/asan/asan_malloc_linux.cpp:127
    #1 0x10fa17f in kmem_cache_free /devel/src/kernel/tools/testing/radix-tree/linux.c:116

previously allocated by thread T0 here:
    #0 0x3ffb9db0f59 in __interceptor_posix_memalign ../../../../libsanitizer/asan/asan_malloc_linux.cpp:226
    #1 0x10faa21 in kmem_cache_alloc_bulk /devel/src/kernel/tools/testing/radix-tree/linux.c:162
    #2 0x3fffdb7e6af  ([stack]+0xc36af)

Thread T1 created by T0 here:
    #0 0x3ffb9d5a28f in __interceptor_pthread_create ../../../../libsanitizer/asan/asan_interceptors.cpp:216
    #1 0x3ffb9c827d9 in call_rcu_data_init /userspace-rcu/src/urcu-call-rcu-impl.h:434

SUMMARY: AddressSanitizer: heap-use-after-free ../../../lib/maple_tree.c:5403 in mas_dead_walk
Shadow bytes around the buggy address:
  0x100c3800481f50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481f60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481f70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481f80: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481f90: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
=>0x100c3800481fa0: fd fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481fb0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481fc0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481fd0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x100c3800481fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x100c3800481ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==441271==ABORTING

Or even stall on rcu_barrier() with default -Og:

Thread 2 (Thread 0x3ffa5bff800 (LWP 439996) "maple"):
#0  futex_wait (private=0, expected=2, futex_word=0x3ffa5bfea40) at ../sysdeps/nptl/futex-internal.h:146
#1  __GI___lll_lock_wait (futex=futex@entry=0x3ffa5bfea40, private=<optimized out>) at lowlevellock.c:50
#2  0x000003ffa94202e8 in lll_mutex_lock_optimized (mutex=0x3ffa5bfea40) at pthread_mutex_lock.c:49
#3  ___pthread_mutex_lock (mutex=0x3ffa5bfea40) at pthread_mutex_lock.c:89
#4  0x000000000102180e in mt_free_walk (head=0x61c00240e908) at ../../../lib/maple_tree.c:5425
#5  0x000003ffa9f041e6 in call_rcu_thread (arg=0x60c000000040) at urcu-call-rcu-impl.h:369
#6  0x000003ffa941cf8c in start_thread (arg=<optimized out>) at pthread_create.c:435
#7  0x000003ffa94964fe in thread_start () at ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:67
Thread 1 (Thread 0x3ffaaa6f980 (LWP 439995) "maple"):
#0  syscall () at ../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:37
#1  0x000003ffa9f03c0a in futex (val3=0, uaddr2=0x0, timeout=0x0, val=-1, op=0, uaddr=0x602000000554) at ../include/urcu/futex.h:72
#2  futex_noasync (timeout=0x0, uaddr2=0x0, val3=0, val=-1, op=0, uaddr=0x602000000554) at ../include/urcu/futex.h:81
#3  call_rcu_completion_wait (completion=0x602000000550) at urcu-call-rcu-impl.h:279
#4  urcu_memb_barrier () at urcu-call-rcu-impl.h:895
#5  urcu_memb_barrier () at urcu-call-rcu-impl.h:840
#6  0x00000000010bfc0a in maple_tree_seed () at ../../../lib/test_maple_tree.c:37385
#7  0x00000000010c0280 in maple_tree_tests () at maple.c:47
#8  0x00000000010c02a0 in main () at maple.c:54
