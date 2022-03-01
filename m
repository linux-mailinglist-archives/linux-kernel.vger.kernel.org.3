Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608764C9884
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiCAWwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiCAWv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:51:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5E9026F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:51:15 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221Md7TT002131;
        Tue, 1 Mar 2022 22:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RgWumwIeFBq7UrM0hRmuSPmHVtrZcQnPtSI8wgRxDAY=;
 b=Udc5OR9siEu7jeeFnRHeDBhoWg3y37wggN0StZwisjSGalImW5b3Lr9WVYOLPUHevOIj
 38Po0nXqdWdOVP9tL3KUp8cHGNUiCCJGsacbUGLXaUfYaTF2hrA+9dEfEB0cOn9Yp0QP
 AWAR9jdsZ57mG4ASTWrwkY8MneagpYqZBLnv9O532ienLMD+selsvs42IZ/vyq2qAJ4L
 8OOolsSHuxZZYtPKScdgHZy1YBU52We3Vvq8tkT/geXiyKHLUTW3ZLn6ErKdmfYjFE6K
 lMmeA2fi5z5rPw5YPPJMtsecGZLEfm1La1Pa9CHXnuSGHuNWBn4b7ZbE0HQ8s1/jEzyn 5A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehv32reex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 22:51:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221Ml512011806;
        Tue, 1 Mar 2022 22:51:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3efbfjmwpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 22:51:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221Mp0qC46530870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 22:51:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DA7311C04A;
        Tue,  1 Mar 2022 22:51:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3907411C054;
        Tue,  1 Mar 2022 22:51:00 +0000 (GMT)
Received: from localhost (unknown [9.171.95.195])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 22:51:00 +0000 (GMT)
Date:   Tue, 1 Mar 2022 23:50:58 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Message-ID: <your-ad-here.call-01646175058-ext-9349@work.hours>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
 <20220228143633.r4zoemgtmrq4uzvb@revolver>
 <your-ad-here.call-01646100074-ext-8278@work.hours>
 <20220301203935.r74qjc7p6qbno4xw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301203935.r74qjc7p6qbno4xw@revolver>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rPLTOQqNwHcY7CQdFyrYpUNRVyCagx_0
X-Proofpoint-ORIG-GUID: rPLTOQqNwHcY7CQdFyrYpUNRVyCagx_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:39:44PM +0000, Liam Howlett wrote:
> * Vasily Gorbik <gor@linux.ibm.com> [220228 21:01]:
> > This condition is not present in mas_dead_leaves() where we potentially
> > iterate over all 16 slots, simply checking that we have a "valid" node pointer
> > with:
> > 
> > entry & ~MAPLE_NODE_MASK != 0
> 
> I have fixed this and another issue that Hugh pointed out [1].  I have
> been working on an s390 VM since you reported your issue and have been
> getting strange behaviour and have been able to detect the bug reported
> by Hugh with the config KASAN option.  With the fix I described above
> and fixing the do_mas_align_munmap() splitting order I broken in my
> linked list removal, I am now able to boot my s390 VM and log in with
> KASAN, VM debug, maple tree debug, rbtree debug, debug page flags, and
> Poison pages after freeing all set in the config I use.  I've pushed the
> fix to a tag on my branch [2] and I'd appreciate it if you could test it
> on your side.

Great, I gave it a spin and it looks much better now! I'll go run some stress
tests.

BTW, since you've made efforts to isolate mapple tests in userspace I
wonder how much sense it would make to use libfuzzer to give API some good
coverage-guided exercise.

I've written a minimal libfuzzer test (just a hack) for the "Normal API" and got
couple of flavours of crashes. Just rebased onto your latest branch state
and still get them. Please have a look if those are valid findings.

I use it the following way:
$ ./fuzz-maple
$ ./fuzz-maple -minimize_crash=1 ./crash-abdc5d14045d52b920d17c6818db7383e1a3ac84
$ V= ./fuzz-maple ./minimized-from-351a4f19a3b166974009662f657daba183e1ff0e

V= or V=1 for API calls trace:
mt_init_flags(&tree, 0);
// mtree_insert(&tree, 88, 0xb1, GFP_KERNEL);
   mtree_insert(&tree, 88, 0xb1, GFP_KERNEL); // 0
// mtree_insert(&tree, 84, 0xa9, GFP_KERNEL);
   mtree_insert(&tree, 84, 0xa9, GFP_KERNEL); // 0
// mtree_insert(&tree, 2, 0x5, GFP_KERNEL);
   mtree_insert(&tree, 2, 0x5, GFP_KERNEL); // 0
// mtree_insert(&tree, 4, 0x9, GFP_KERNEL);
   mtree_insert(&tree, 4, 0x9, GFP_KERNEL); // 0
// mtree_insert(&tree, 14, 0x1d, GFP_KERNEL);
   mtree_insert(&tree, 14, 0x1d, GFP_KERNEL); // 0
// mtree_insert(&tree, 7, 0xf, GFP_KERNEL);
   mtree_insert(&tree, 7, 0xf, GFP_KERNEL); // 0
// mtree_insert(&tree, 12, 0x19, GFP_KERNEL);
   mtree_insert(&tree, 12, 0x19, GFP_KERNEL); // 0
// mtree_insert(&tree, 18, 0x25, GFP_KERNEL);
   mtree_insert(&tree, 18, 0x25, GFP_KERNEL); // 0
// mtree_store_range(&tree, 8, 18, 0x11, GFP_KERNEL);
../../../lib/maple_tree.c:518:25: runtime error: member access within null pointer of type 'struct maple_node'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../../lib/maple_tree.c:518:25 in
../../../lib/maple_tree.c:518:25: runtime error: member access within null pointer of type 'union maple_node::(anonymous at ./linux/../../../../include/linux/m
aple_tree.h:273:2)'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../../lib/maple_tree.c:518:25 in
../../../lib/maple_tree.c:518:25: runtime error: member access within null pointer of type 'struct maple_node::(anonymous at ./linux/../../../../include/linux/
maple_tree.h:274:3)'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../../lib/maple_tree.c:518:25 in
../../../lib/maple_tree.c:518:25: runtime error: load of null pointer of type 'struct maple_pnode *'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../../lib/maple_tree.c:518:25 in
AddressSanitizer:DEADLYSIGNAL
=================================================================
==2657920==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x0000005525c3 bp 0x7ffccbdd93c0 sp 0x7ffccbdd93a0 T0)
==2657984==Hint: address points to the zero page.
    #0 0x5525c3 in mte_parent /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:518:33
    #1 0x5809e6 in mas_new_child /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:1716:7
    #2 0x57e619 in mas_descend_adopt /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:2013:23
    #3 0x5776be in mas_wmb_replace /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:2627:3
    #4 0x56a63a in mas_spanning_rebalance /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:2966:2
    #5 0x55b328 in mas_wr_spanning_store /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:3920:9
    #6 0x542cca in mas_wr_store_entry /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:4251:3
    #7 0x54bda7 in mtree_store_range /devel/src/kernel/tools/testing/radix-tree/./../../../lib/maple_tree.c:6000:2
    #8 0x596ae8 in maple_tree_tests /devel/src/kernel/tools/testing/radix-tree/fuzz-maple.c:77:8
    #9 0x557907 in LLVMFuzzerTestOneInput /devel/src/kernel/tools/testing/radix-tree/fuzz-maple.c:122:2
    #10 0x444354 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) /devel/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:595:17  
    #11 0x42bf03 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) /devel/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:323:21
    #12 0x431972 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) /devel/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriv
er.cpp:848:19
    #13 0x41eba2 in main /devel/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:30
    #14 0x7f057f5241e1 in __libc_start_main (/lib64/libc.so.6+0x281e1)
    #15 0x41ebfd in _start (/devel/src/kernel/tools/testing/radix-tree/fuzz-maple+0x41ebfd)

V=2 for API calls trace + tree dumps
   mtree_insert(&tree, 18, 0x25, GFP_KERNEL); // 0
 ------------------------------------------------
 maple_tree(0x7fff6d216160) flags 8, height 2 root 0x617000000116
 0-18446744073709551615: node 0x617000000100 depth 0 type 2 parent 0x7fff6d216161 contents: 0x61700000040c 14 0x61500000060c 18446744073709551615 (nil) 0 (nil)
 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 0x1
   0-14: node 0x617000000400 depth 1 type 1 parent 0x617000000106 contents: (nil) 1 0x5 2 (nil) 3 0x9 4 (nil) 6 0xf 7 (nil) 11 0x19 12 (nil) 13 0x1d 14 (nil) 0
 (nil) 0 (nil) 0 (nil) 0 (nil) 0 0x9
     0-1: (nil)
     2: value 2 (0x2) [0x5]
     3: (nil)
     4: value 4 (0x4) [0x9]
     5-6: (nil)
     7: value 7 (0x7) [0xf]
     8-11: (nil)
     12: value 12 (0xc) [0x19]
     13: (nil)
     14: value 14 (0xe) [0x1d]
   15-18446744073709551615: node 0x615000000600 depth 1 type 1 parent 0x61700000010e contents: (nil) 17 0x25 18 (nil) 83 0xa9 84 (nil) 87 0xb1 88 (nil) 0 (nil)
 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 (nil) 0 0x6
     15-17: (nil)
     18: value 18 (0x12) [0x25]
     19-83: (nil)
     84: value 84 (0x54) [0xa9]
     85-87: (nil)
     88: value 88 (0x58) [0xb1]
 // mtree_store_range(&tree, 8, 18, 0x11, GFP_KERNEL);
 ../../../lib/maple_tree.c:518:25: runtime error: member access within null pointer of type 'struct maple_node'

---
 tools/testing/radix-tree/.gitignore   |   2 +
 tools/testing/radix-tree/Makefile     |  17 +++-
 tools/testing/radix-tree/fuzz-maple.c | 128 ++++++++++++++++++++++++++
 tools/testing/radix-tree/linux.c      |   7 ++
 tools/testing/radix-tree/linux/slab.h |   1 +
 5 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/radix-tree/fuzz-maple.c

diff --git a/tools/testing/radix-tree/.gitignore b/tools/testing/radix-tree/.gitignore
index c901d96dd013..6a1ff525bb8d 100644
--- a/tools/testing/radix-tree/.gitignore
+++ b/tools/testing/radix-tree/.gitignore
@@ -7,4 +7,6 @@ multiorder
 radix-tree.c
 xarray
 maple
+fuzz-maple
+crash-*
 ma_xa_benchmark
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 3e0fa6ae0e0a..c74e6422aff7 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address \
 	  -fsanitize=undefined
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder xarray maple
+TARGETS = main idr-test multiorder xarray maple fuzz-maple
 CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o maple.o
 OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
 	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
@@ -30,6 +30,21 @@ xarray: $(CORE_OFILES)
 
 maple: $(CORE_OFILES)
 
+fuzz-maple: fuzz-maple.c linux.c ../../../lib/maple_tree.c
+	clang $(CFLAGS) -fsanitize=fuzzer $(LDLIBS) -o fuzz-maple fuzz-maple.c linux.c
+
+CFLAGS_AFL += -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE
+AFL_HOME = /devel/src/afl-2.52b/
+LLVM_HOME = /devel/src/llvm-project
+AFL_LLVM_RT = $(AFL_HOME)/llvm_mode/afl-llvm-rt.o.c
+LLVM_AFL_DRIVER = $(LLVM_HOME)/compiler-rt/lib/fuzzer/afl/afl_driver.cpp
+
+afl-maple: fuzz-maple.c linux.c ../../../lib/maple_tree.c $(AFL_LLVM_RT) $(LLVM_AFL_DRIVER) generated/map-shift.h
+	clang $(CFLAGS_AFL) -fsanitize-coverage=trace-pc-guard -c -o afl-maple.o fuzz-maple.c
+	clang $(CFLAGS_AFL) -fsanitize-coverage=trace-pc-guard -c -o afl-linux.o linux.c
+	clang -c -w $(AFL_LLVM_RT) -o afl-llvm-rt.o
+	clang++ $(LLVM_AFL_DRIVER) afl-maple.o afl-linux.o afl-llvm-rt.o $(LDLIBS) -o afl-maple
+
 multiorder: multiorder.o $(CORE_OFILES)
 
 clean:
diff --git a/tools/testing/radix-tree/fuzz-maple.c b/tools/testing/radix-tree/fuzz-maple.c
new file mode 100644
index 000000000000..f47ec5d3440f
--- /dev/null
+++ b/tools/testing/radix-tree/fuzz-maple.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define CONFIG_DEBUG_MAPLE_TREE
+#define CONFIG_MAPLE_SEARCH
+#include "test.h"
+
+#define module_init(x)
+#define module_exit(x)
+#define MODULE_AUTHOR(x)
+#define MODULE_LICENSE(x)
+#define dump_stack()	assert(0)
+
+#include "../../../lib/maple_tree.c"
+#undef CONFIG_DEBUG_MAPLE_TREE
+
+static int gotdata = 1;
+static char *buf, *p;
+
+static unsigned long getl()
+{
+	char *tok = strtok(p, " ");
+	p = NULL;
+
+	if (!tok) {
+		gotdata = 0;
+		return 0;
+	}
+
+	return atol(tok);
+}
+
+#define v(x) (xa_mk_value(x & LONG_MAX))
+
+#define trace(...) printv(1, __VA_ARGS__)
+
+static void maple_tree_tests()
+{
+	unsigned long l1, l2;
+	void *e, *rl;
+	int r;
+	DEFINE_MTREE(tree);
+	trace("mt_init_flags(&tree, 0);\n");
+	mt_init_flags(&tree, 0);
+
+	while (gotdata) {
+		if (test_verbose > 1) {
+			pr_info("------------------------------------------------\n");
+			mt_dump(&tree);
+		}
+		switch (getl() % 7) {
+		case 0:
+			l1 = getl();
+			trace("// mtree_load(&tree, %lu);\n", l1);
+			rl = mtree_load(&tree, l1);
+			trace("   mtree_load(&tree, %lu); // %p\n", l1, rl);
+			break;
+		case 1:
+			l1 = getl();
+			e = v(l1);
+			trace("// mtree_insert(&tree, %lu, %p, GFP_KERNEL);\n", l1, e);
+			r = mtree_insert(&tree, l1, e, GFP_KERNEL);
+			trace("   mtree_insert(&tree, %lu, %p, GFP_KERNEL); // %d\n", l1, e, r);
+			break;
+		case 2:
+			l1 = getl();
+			l2 = getl();
+			e = v(l1);
+			trace("// mtree_insert_range(&tree, %lu, %lu, %p, GFP_KERNEL);\n", l1, l2, e);
+			r = mtree_insert_range(&tree, l1, l2, e, GFP_KERNEL);
+			trace("   mtree_insert_range(&tree, %lu, %lu, %p, GFP_KERNEL); // %d\n", l1, l2, e, r);
+			break;
+		case 3:
+			l1 = getl();
+			l2 = getl();
+			e = v(l1);
+			trace("// mtree_store_range(&tree, %lu, %lu, %p, GFP_KERNEL);\n", l1, l2, e);
+			r = mtree_store_range(&tree, l1, l2, e, GFP_KERNEL);
+			trace("   mtree_store_range(&tree, %lu, %lu, %p, GFP_KERNEL); // %d\n", l1, l2, e, r);
+			break;
+		case 4:
+			l1 = getl();
+			e = v(l1);
+			trace("// mtree_store(&tree, %lu, %p, GFP_KERNEL);\n", l1, e);
+			r = mtree_store(&tree, l1, e, GFP_KERNEL);
+			trace("   mtree_store(&tree, %lu, %p, GFP_KERNEL); // %d\n", l1, e, r);
+			break;
+		case 5:
+			l1 = getl();
+			trace("// mtree_erase(&tree, %lu);\n", l1);
+			rl = mtree_erase(&tree, l1);
+			trace("   mtree_erase(&tree, %lu); // %p\n", l1, rl);
+			break;
+		case 6:
+			trace("mtree_destroy(&tree);\n");
+			trace("mt_init_flags(&tree, 0);\n");
+			mtree_destroy(&tree);
+			mt_init_flags(&tree, 0);
+			break;
+		default:
+			break;
+		}
+	}
+
+	trace("mtree_destroy(&tree);\n");
+	mtree_destroy(&tree);
+}
+
+extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
+	char *v = getenv("V");
+	if (v)
+		test_verbose = atoi(v) ?: 1;
+	if (!size)
+		return 0;
+	buf = p = malloc(size + 1);
+	if (!buf)
+		return 0;
+	buf[size] = 0;
+	memcpy(buf, data, size);
+	gotdata = 1;
+	maple_tree_init();
+	maple_tree_tests();
+	rcu_barrier();
+	if (nr_allocated)
+		printf("nr_allocated = %d\n", nr_allocated);
+	kmem_cache_destroy(maple_node_cache);
+	free(buf);
+	return 0;
+}
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 3383d748c650..8d28f09caa8d 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -227,6 +227,13 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 	return ret;
 }
 
+void kmem_cache_destroy(struct kmem_cache *s)
+{
+	if (!s)
+		return;
+	free(s);
+}
+
 /*
  * Test the test infrastructure for kem_cache_alloc/free and bulk counterparts.
  */
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tree/linux/slab.h
index d7aed1cc6978..f440658b34cb 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -23,6 +23,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp);
 struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
+void kmem_cache_destroy(struct kmem_cache *s);
 
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
-- 
2.35.1

