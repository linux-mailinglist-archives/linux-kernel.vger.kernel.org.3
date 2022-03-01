Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD904C80A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiCACER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiCACEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:04:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87C3BBEB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:03:35 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2210mam2011987;
        Tue, 1 Mar 2022 02:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gpNPazCw1JDwVIueADQv29xBWWCetVtkVRf+nZQ3mKA=;
 b=p0I6q7qtrnHR8zk7jc86wf6EHrIkKHziFZG6P/QNbd3XJfFYhHh8k1rwgnGEyNG+QEDy
 OsbSeTaHfzGU/x702RF32h4Pk78uaeHARlcnn/fas/gVbnUwZBPancBV2WZYyjSykYkb
 kvhO5v9jBoPdaEuzdRgT4EtSpWSeY/uDmXJZloELRhAeuaDD7RM/ClS6tlfoer84PIcG
 TAMobm0biV8BUcB/8OPg9y4jA9lDIiZgbzkicdlQPNdDsvmZUTrPWLh19dneRqmUQaa3
 jj9FyDGnkL1q9LiLCJoLxkKtTzkyiWKZSK+Qs3Nyk7d7p3DPpTwENeNMSmeW1ABAwQuV hw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eh996h793-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 02:01:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2211hNEx024250;
        Tue, 1 Mar 2022 02:01:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3efbu918kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 02:01:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22121G2551970304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 02:01:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7320111C058;
        Tue,  1 Mar 2022 02:01:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28EAA11C04C;
        Tue,  1 Mar 2022 02:01:16 +0000 (GMT)
Received: from localhost (unknown [9.171.53.31])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 02:01:16 +0000 (GMT)
Date:   Tue, 1 Mar 2022 03:01:14 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Message-ID: <your-ad-here.call-01646100074-ext-8278@work.hours>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
 <20220228143633.r4zoemgtmrq4uzvb@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228143633.r4zoemgtmrq4uzvb@revolver>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ronGQoVyKppgr6H8OPcgoyREV573J_-F
X-Proofpoint-ORIG-GUID: ronGQoVyKppgr6H8OPcgoyREV573J_-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:36:40PM +0000, Liam Howlett wrote:
> * Vasily Gorbik <gor@linux.ibm.com> [220226 20:12]:
> > there is an endianness issue with maple_metadata. This is broken on
> > all big endian architectures. Tests are crashing. See potential fixup
> > below. Feel free to apply it or fix the issue in your own way. This does
> > not resolve all the issues with the patch series though.
> 
> The endianness isn't what's causing the issues.  The slots hold a
> pointer.  Either we can use the entire slot or none of the slot
> space.  You are just moving the metatdata around in the last slot.

Fair, it is either or, but shouldn't maple_metadata->end be aligned with
MAPLE_NODE_MASK?

> You may have been confused about my comment, which I believe is
> outdated, that talks about maple_arange_64, not maple_range_64.  I added
> maple_range_64 metadata and use the previous pivot to see if the slot
> contains data or not. If piv[14] == 0 or mas->max means we can use the
> slot for metadata.

This condition is not present in mas_dead_leaves() where we potentially
iterate over all 16 slots, simply checking that we have a "valid" node pointer
with:

entry & ~MAPLE_NODE_MASK != 0

This doesn't work on big endian without the fix.

maple_tree(0x121eaa0) flags 8, height 2 root 0x61a00004c316
0-18446744073709551615: node 0x61a00004c300 depth 0 type 2 parent 0x121eaa1 contents: 0x61a00002710c 14 0x61a00002a10c 29 0x61a00002d10c 44 0x61a00003070c
59 0x61a00003370c 74 0x61a00003670c 89 0x61a00003970c 104 0x61a00003c70c 119 0x61a00003f70c 134 0x61a00004270c 149 0x61a00004570c 164 0x61a00004870c
179 0x61a00004b70c 194 0x61a00004cf0c 203 0x61a00004c90c 18446744073709551615 0xe00000000000000
										^^^^^^^^^^^^^^^

==564249==ERROR: AddressSanitizer: SEGV on unknown address 0xe00000000000000 (pc 0x00000100ce72 bp 0x61a00004c300 sp 0x03fffe87de00 T0)
==564249==The signal is caused by a UNKNOWN memory access.
    #0 0x100ce72 in mte_set_node_dead ../../../lib/maple_tree.c:294
    #1 0x100ce72 in mas_dead_leaves ../../../lib/maple_tree.c:5381
    #2 0x100ce72 in mt_destroy_walk ../../../lib/maple_tree.c:5496
    #3 0x1069af3 in mte_destroy_walk ../../../lib/maple_tree.c:5543
    #4 0x1069af3 in __mt_destroy ../../../lib/maple_tree.c:6279
    #5 0x1069b77 in mtree_destroy ../../../lib/maple_tree.c:6294
    #6 0x106cf19 in check_dfs_preorder ../../../lib/test_maple_tree.c:35732
    #7 0x106d011 in maple_tree_seed ../../../lib/test_maple_tree.c:37188
    #8 0x1073ef9 in maple_tree_tests /devel/src/kernel/tools/testing/radix-tree/maple.c:47
    #9 0x1073f1f in main /devel/src/kernel/tools/testing/radix-tree/maple.c:54
    #10 0x3ffa1833731 in __libc_start_call_main (/lib64/libc.so.6+0x33731)
    #11 0x3ffa183380d in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3380d)
    #12 0x1001d99  (/devel/src/kernel/tools/testing/radix-tree/maple+0x1001d99)
