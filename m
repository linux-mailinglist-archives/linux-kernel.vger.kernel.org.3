Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7259090D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiHKXRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiHKXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B70A0243
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EF4A5C015E;
        Thu, 11 Aug 2022 19:16:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Aug 2022 19:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1660259805; x=1660346205; bh=Bg
        lT4qc1w1x8AVsv4V7eNfTzEYdPHnAtOkQttta3jos=; b=JhNPHD54B9V4uEleVy
        Z7EoCwoBKHa5MepofQ355mPzDqh8i8FW5GwPjn2YqGvKoIDJWbOVAKWHjFPvnJjQ
        uE5i7ox+Ssm379wK1hz6bntO9xyGKdIshHw/frfUTZyjooX0Y3xiWo5GqSQGbe12
        isfDgxIaKgE1AJKXL7bdPRq3VeAc/vQMe0nakXhdAqJNbMqdJw8O4y5uzZsD2Kuc
        7+pouuz9tXzOMHM6tV6iGVYjESm+oRTYgKrCver21RQ/V8Jd6FQj8tnXnqw6uWFj
        VuS9IrVamiwGriFByZTdxzWpyOp7CTPpMTjpBDUo0jBlCF4xOzHw2wDXzYQCYpnB
        4CiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259805; x=1660346205; bh=B
        glT4qc1w1x8AVsv4V7eNfTzEYdPHnAtOkQttta3jos=; b=V5BNVd4B6U7Y37Sra
        SVEt23KHdpRGpWiFL+tXAIc+sJM4FO1cRcsKkEN+yRFUe4U9uYWmatBKx65K2VMK
        4Yc8mi9Sdq0EEKWP5tX9bN7GZo2E0IG0iX6qHm5FY82YzGTmfRFMQbyxRyOAbauA
        DMth/pNZeD9V/07sA3oYIx4D4Zc7a8ny5Y9hlEOYPkfPzJTnLWs5oA/u+g0Ontaw
        fZRCdp/jjKB7ZDNaAQJ0DQNUdGkbZF/cuuo7JY7o8JOuhaI1PLdPzqS+KJ2vfiyk
        F5ZqRLk2/SWy5a0PIoXpvt0bNcIMC8J4wHcPxucfqIzBqBEKX6kybxUdIw+7KmU1
        dY2AQ==
X-ME-Sender: <xms:3I31YlN7nYGL15X7bYHLVYikphev6_JlcN3mlVYybty6Wb9EhCEwJQ>
    <xme:3I31Yn8wVJ-SEBPUg9v3RmFEqEizcWDvZ9mqi_8I8XFr8I9Cmu_jFtFgSOO33ScX4
    E81cUxQYK-oEtuj8Q>
X-ME-Received: <xmr:3I31YkQY30iOkED9OPAw26lY3sZya7sm5Ec8Fj3n4yYIc9b5-_IF5ktaf7TBgEZj6-r8Valo1lCtQLLlhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthhqredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepfefghf
    fggfdtteeffeejuddvueegjeejieffjeffhfegvefgffeufeeikeetudeknecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:3I31YhvZXRIf0eJXHOTfzlVa-kBlhWuPek1GINHg-XzJeS3QWg1Jew>
    <xmx:3I31Ytd2K-6kjpFx8GVLT_YMXL3kjAl4PIaHwR2KtOff3kT1elu3lg>
    <xmx:3I31Yt1fYfbOGwYqdQRjqxXcPaQRG5mZh5M4hl8ip0cyJ5RpdBWCSg>
    <xmx:3Y31YuVsydm3iVt2R5m1FsBTs2uXNttg30BdZW0hQBki-I-R5VLjZA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:43 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/12] Make MAX_ORDER adjustable as a kernel boot time parameter.
Date:   Thu, 11 Aug 2022 19:16:31 -0400
Message-Id: <20220811231643.1012912-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset adds support for kernel boot time adjustable MAX_ORDER, so th=
at
user can change the largest size of pages buddy allocator allocates.
It is on top of mm-everything-2022-08-11-02-10.

Motivation
=3D=3D=3D

This enables kernel to allocate 1GB pages and is necessary for my ongoing w=
ork
on adding support for 1GB PUD THP[1]. This is also the conclusion I came up=
 with
after some discussion with David Hildenbrand on what methods should be used=
 for
allocating gigantic pages[2], since other approaches like using CMA allocat=
or or
alloc_contig_pages() are regarded as suboptimal.

In addition, make MAX_ORDER a kernel boot time parameter can enable user to
adjust buddy allocator without recompiling the kernel for their own needs, =
so
that one can still have a small MAX_ORDER if he/she does not need to alloca=
te
gigantic pages like 1GB PUD THPs.

Background
=3D=3D=3D

At the moment, kernel imposes MAX_ORDER - 1 + PAGE_SHFIT < SECTION_SIZE_BITS
restriction. This prevents buddy allocator merging pages across memory sect=
ions,
as PFNs might not be contiguous and code like page++ would fail. But this w=
ould
not be an issue when SPARSEMEM_VMEMMAP is set, since all struct page are
virtually contiguous. So boot time adjustable MAX_ORDER depends on
SPARSEMEM_VMEMMAP.

Description
=3D=3D=3D

I tested the patchset on both x86_64 and ARM64 at 4KB base pages. The syste=
ms
boot and run. It definitely needs more tests and reviews.

In terms of the concerns on performance degradation if MAX_ORDER is increas=
ed,
I run vm-scalability from lkp comparing current system, my patchset with
MAX_ORDER=3D11 and my patchset with MAX_ORDER=3D20 on a x86_64 VM and saw
almost no performance difference, please attached vm-scalability reports.

Patch 1 renames FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER for a more
precise description.

Patch 2 changes MAX_ORDER to represent the max order of pages allocated
by buddy allocator. right now MAX_ORDER - 1 represents that and it is
confusing. Suggested by Vlastimil Babka.

Patch 3 replaces MAX_ORDER with MAX_PHYS_CONTIG_ORDER when it is used to
indicate the maximum number of physically contiguous pages.

Patch 4 fixes deferred struct page initialization when MAX_ORDER is
bigger than a memory section size.

Patch 5-8 convert the use of MAX_ORDER to pageblock_order. Since
pageblock_order is a constant when MAX_ORDER can be changed at boot time
and close to current MAX_ORDER value. I separate changes to different patch=
es
for easy review and can merge them into a single one if that works better.

Patch 9 adds a new Kconfig option SET_MAX_ORDER to allow specifying MAX_ORD=
ER
when ARCH_FORCE_MAX_ORDER is not used by the arch, like x86_64.

Patch 10 converts statically allocated arrays with MAX_ORDER length to dyna=
mic
ones if possible and prepares for making MAX_ORDER a boot time parameter.

Patch 11 adds a new MIN_MAX_ORDER constant to replace soon-to-be-dynamic
MAX_ORDER for places where converting static array to dynamic one is causing
hassle and not necessary, i.e., ARM64 hypervisor page allocation and SLAB.

Patch 12 changes MAX_ORDER to be a kernel boot time parameter and it is
opt-in as an mm/Kconfig option.


Any suggestion and/or comment is welcome. Thanks.


[1] https://lore.kernel.org/linux-mm/20200928175428.4110504-1-zi.yan@sent.c=
om/
[2] https://lore.kernel.org/linux-mm/e132fdd9-65af-1cad-8a6e-71844ebfe6a2@r=
edhat.com/

Performance comparison
=3D=3D=3D=3D

Only the changed stats is shown below. If you do not see some stats,
they are the same across three.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/small-allocs/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
   1266004            -0.3%    1262674            +1.1%    1279441        v=
m-scalability.median

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/small-allocs-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
     76016            +0.2%      76178            +1.2%      76936        v=
m-scalability.median
   1216312            +0.2%    1218252            +1.2%    1231465        v=
m-scalability.throughput
 3.653e+08            +0.2%  3.659e+08            +1.3%  3.701e+08        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
   1574020 =C2=B1  2%      +0.1%    1576169            -2.3%    1537232 =C2=
=B1  2%  vm-scalability.median
  25184277 =C2=B1  2%      +0.1%   25218477            -2.3%   24595646 =C2=
=B1  2%  vm-scalability.throughput
 7.567e+09 =C2=B1  2%      +0.1%  7.575e+09            -2.3%  7.395e+09 =C2=
=B1  2%  vm-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/mmap-pread-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      2.28 =C2=B1 11%     -21.0%       1.80 =C2=B1 11%     -18.2%       1.8=
7 =C2=B1 11%  vm-scalability.free_time
      8.58 =C2=B1  9%      +3.4       11.95 =C2=B1  7%      +1.1        9.6=
9 =C2=B1 13%  vm-scalability.stddev%
   1541489            -0.2%    1539102            +1.3%    1561678        v=
m-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/mmap-pread-rand-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
     94376            +0.4%      94716            +1.8%      96103        v=
m-scalability.median
     12.96 =C2=B1  3%     +11.9       24.88 =C2=B1 80%      +0.3       13.3=
0 =C2=B1  5%  vm-scalability.stddev%
   1509455            +0.8%    1522093            +1.8%    1536886        v=
m-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    433656            -5.3%     410460 =C2=B1  2%      -4.8%     412737    =
    vm-scalability.median
  13879867            -5.5%   13118050 =C2=B1  2%      -4.8%   13212361    =
    vm-scalability.throughput
 4.164e+09            -5.5%  3.935e+09 =C2=B1  2%      -4.8%  3.964e+09    =
    vm-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    488915 =C2=B1  3%      -2.3%     477658 =C2=B1  6%     -11.7%     43177=
1 =C2=B1  6%  vm-scalability.median
    120.69 =C2=B1 35%     -39.0       81.65 =C2=B1 84%     -89.1       31.5=
6 =C2=B1154%  vm-scalability.stddev%
   8106774 =C2=B1  4%      -3.3%    7835670 =C2=B1  7%     -13.9%    698107=
8 =C2=B1  8%  vm-scalability.throughput
 2.435e+09 =C2=B1  4%      -3.4%  2.353e+09 =C2=B1  7%     -13.8%  2.099e+0=
9 =C2=B1  8%  vm-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/anon-rx-rand-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    196783            -0.8%     195189 =C2=B1  2%      -2.8%     191323    =
    vm-scalability.median
     53.88 =C2=B1  3%      -4.9       48.96 =C2=B1  2%     -43.9        9.9=
5 =C2=B1 35%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/anon-r-seq-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
     50.03 =C2=B1 29%     -15.9       34.08 =C2=B1 12%      -2.4       47.6=
6 =C2=B1 32%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/qemu-vm/anon-r-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      3.82            -0.8%       3.79            -0.6%       3.79 =C2=B1  =
3%  vm-scalability.free_time
    172116            +0.3%     172685            -2.1%     168557        v=
m-scalability.median
     75.53 =C2=B1 12%     -15.6       59.88 =C2=B1 13%     -60.9       14.6=
4 =C2=B1 17%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/8T/qemu-vm/anon-wx-seq-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    798340            +0.8%     804861            -3.0%     774082        v=
m-scalability.median
      1.55 =C2=B1 28%      -0.1        1.47 =C2=B1 32%      +0.6        2.1=
9 =C2=B1 14%  vm-scalability.median_stddev%
      1.55 =C2=B1 28%      -0.1        1.47 =C2=B1 32%      +0.6        2.1=
9 =C2=B1 14%  vm-scalability.stddev%
  12773455            +0.8%   12877783            -3.0%   12385319        v=
m-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/8T/qemu-vm/anon-w-seq/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      0.13            +4.1%       0.14 =C2=B1  3%     +37.0%       0.18    =
    vm-scalability.free_time
    923091            -0.6%     917275 =C2=B1  2%      +3.7%     957298    =
    vm-scalability.median
      4.57 =C2=B1  2%      -1.7        2.89 =C2=B1 15%      -3.9        0.6=
8 =C2=B1  7%  vm-scalability.median_stddev%
  14811265            -0.5%   14731710            +1.8%   15079698        v=
m-scalability.throughput
 3.173e+09            -0.5%  3.156e+09 =C2=B1  2%      -1.2%  3.134e+09    =
    vm-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/8T/qemu-vm/anon-w-seq-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      0.07            +1.1%       0.07            +3.6%       0.07        v=
m-scalability.free_time
    667055            -1.6%     656481            -1.4%     657861        v=
m-scalability.median
      2.22 =C2=B1  4%      -0.1        2.12 =C2=B1  6%      +0.4        2.6=
0 =C2=B1 14%  vm-scalability.median_stddev%
  10817276            -1.3%   10673638            -2.3%   10568517        v=
m-scalability.throughput
 2.022e+09            -1.0%  2.002e+09            -1.5%  1.991e+09        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/8T/qemu-vm/anon-cow-seq/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    475554            -0.5%     473278            +2.6%     487908        v=
m-scalability.median
      4.20 =C2=B1  2%      -1.5        2.73 =C2=B1  6%      -3.3        0.8=
9 =C2=B1  6%  vm-scalability.median_stddev%
      3.58 =C2=B1  3%      -1.0        2.58 =C2=B1  5%      -1.7        1.8=
8 =C2=B1  9%  vm-scalability.stddev%
   7533010            +0.4%    7559545            +1.7%    7663820        v=
m-scalability.throughput
 1.764e+09            +1.8%  1.795e+09            +1.2%  1.785e+09        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/8T/qemu-vm/anon-cow-seq-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      1.13 =C2=B1 14%      -0.3        0.85 =C2=B1 15%      -0.5        0.6=
6 =C2=B1 32%  vm-scalability.median_stddev%
      1.13 =C2=B1 14%      -0.3        0.85 =C2=B1 15%      -0.5        0.6=
6 =C2=B1 32%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/512G/qemu-vm/anon-wx-rand-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
     72308            -1.4%      71294 =C2=B1  3%      -7.9%      66569    =
    vm-scalability.median
      0.96 =C2=B1 11%      -0.0        0.94 =C2=B1 14%      -0.5        0.4=
4 =C2=B1  5%  vm-scalability.stddev%
 2.743e+08            -0.0%  2.743e+08           +12.7%   3.09e+08        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/512G/qemu-vm/anon-w-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      0.09            +0.8%       0.09 =C2=B1  3%      +5.9%       0.10 =C2=
=B1  3%  vm-scalability.free_time
     67458 =C2=B1  2%      -6.0%      63414 =C2=B1  2%     -11.3%      5980=
5        vm-scalability.median
      4.66 =C2=B1 36%      +4.7        9.38 =C2=B1 34%      -2.2        2.5=
0 =C2=B1 23%  vm-scalability.median_stddev%
    971866            -1.3%     959227            -2.3%     949434        v=
m-scalability.throughput
 2.469e+08            -0.0%  2.469e+08           +11.1%  2.743e+08        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/512G/qemu-vm/anon-w-rand-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      0.12 =C2=B1  2%      +2.8%       0.13           +10.5%       0.14 =C2=
=B1  3%  vm-scalability.free_time
     65926 =C2=B1  3%      -1.8%      64711 =C2=B1  4%      -9.3%      5977=
0        vm-scalability.median
      4.51 =C2=B1 38%      +1.3        5.83 =C2=B1 48%      -3.1        1.4=
4 =C2=B1 31%  vm-scalability.median_stddev%
      1.24 =C2=B1 24%      -0.3        0.93 =C2=B1 25%      -0.8        0.4=
8 =C2=B1 17%  vm-scalability.stddev%
 2.395e+08            +1.5%  2.432e+08           +11.5%   2.67e+08        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
     63519 =C2=B1  3%      -2.3%      62074 =C2=B1  2%     -12.2%      5577=
5        vm-scalability.median
    914972            -1.2%     904135            -2.4%     893097        v=
m-scalability.throughput
 2.323e+08            -0.0%  2.323e+08           +11.1%  2.582e+08        v=
m-scalability.workload

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
     64719 =C2=B1  2%      -1.7%      63626 =C2=B1  2%      -7.4%      5995=
3        vm-scalability.median
      3.32 =C2=B1 77%      +1.3        4.64 =C2=B1 64%      -2.3        1.0=
2 =C2=B1 60%  vm-scalability.median_stddev%
      0.83 =C2=B1 27%      -0.1        0.74 =C2=B1 53%      -0.7        0.1=
8 =C2=B1 43%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/2T/qemu-vm/shm-xread-seq/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    346505            +2.5%     355073            +1.8%     352797        v=
m-scalability.median
      1.29 =C2=B1 26%      +0.4        1.73 =C2=B1 11%      +0.2        1.4=
7 =C2=B1 22%  vm-scalability.median_stddev%
      1.29 =C2=B1 26%      +0.4        1.73 =C2=B1 11%      +0.2        1.4=
7 =C2=B1 22%  vm-scalability.stddev%
   5544053            +2.5%    5681145            +1.8%    5644734        v=
m-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/2T/qemu-vm/shm-pread-seq/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      3.06           +10.8%       3.40           +11.5%       3.42        v=
m-scalability.free_time
    344737            +3.5%     356824            +2.0%     351766        v=
m-scalability.median
   5515773            +3.5%    5709150            +2.0%    5628245        v=
m-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/2T/qemu-vm/shm-pread-seq-mt/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    363265            +2.4%     371881            +2.0%     370384        v=
m-scalability.median
   5807625            +2.4%    5948137            +2.0%    5922313        v=
m-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    124686 =C2=B1  4%      +2.9%     128345            +9.0%     135953    =
    vm-scalability.median
     19.68 =C2=B1  9%      -1.2       18.47 =C2=B1  6%      -5.0       14.6=
7 =C2=B1  3%  vm-scalability.median_stddev%
     18.87 =C2=B1  9%      -1.5       17.38 =C2=B1  9%      -6.1       12.7=
6 =C2=B1  4%  vm-scalability.stddev%
   2047903 =C2=B1  2%      +2.1%    2090681            +4.4%    2138545    =
    vm-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/256G/qemu-vm/lru-shm-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      0.03            -0.4%       0.03            -2.0%       0.02        v=
m-scalability.free_time
      7.02 =C2=B1 18%      +0.7        7.68 =C2=B1 12%      -5.4        1.6=
5 =C2=B1 13%  vm-scalability.median_stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/1T/qemu-vm/lru-shm/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      2.36 =C2=B1  4%      -0.5        1.90 =C2=B1 13%      -1.6        0.8=
0 =C2=B1 20%  vm-scalability.median_stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/16G/qemu-vm/shm-xread-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    168.32 =C2=B1  6%      -0.1      168.24 =C2=B1 17%    -114.4       53.9=
4 =C2=B1 59%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/16G/qemu-vm/shm-pread-rand/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
    172.46 =C2=B1  8%     -14.2      158.30 =C2=B1 20%    -106.4       66.0=
4 =C2=B1 74%  vm-scalability.stddev%

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase/unit_size:
  gcc-11/defconfig/debian/300s/16G/qemu-vm/shm-pread-rand-mt/vm-scalability=
/1G

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      0.06 =C2=B1  4%      +5.0%       0.07 =C2=B1  5%     +38.6%       0.0=
9 =C2=B1  6%  vm-scalability.free_time

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/defconfig/debian/300s/128G/qemu-vm/truncate-seq/vm-scalability

commit:=20
  5.19.0-rc4-mm-everything+
  5.19.0-rc4-boot-time-max-order-10+
  5.19.0-rc4-boot-time-max-order-20+

5.19.0-rc4-mm-ev 5.19.0-rc4-boot-time-max-or 5.19.0-rc4-boot-time-max-or=20
---------------- --------------------------- ---------------------------=20
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \=20=20
      9.00 =C2=B1 15%      +1.6       10.59 =C2=B1 11%      -2.6        6.3=
5 =C2=B1  8%  vm-scalability.median_fault_stddev%
      9.00 =C2=B1 15%      +1.6       10.59 =C2=B1 11%      -2.6        6.3=
5 =C2=B1  8%  vm-scalability.stddev_fault%


Zi Yan (12):
  arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
  mm: rectify MAX_ORDER semantics to be the largest page order from
    buddy allocator
  mm: replace MAX_ORDER when it is used to indicate max physical
    contiguity.
  mm: adapt deferred struct page init to new MAX_ORDER.
  mm: prevent pageblock size being larger than section size.
  fs: proc: use pageblock_nr_pages for reschedule period in read_kcore()
  virtio: virtio_balloon: use pageblock_order instead of MAX_ORDER
  mm/page_reporting: set page_reporting_order to -1 to prevent it
    running
  mm: Make MAX_ORDER of buddy allocator configurable via Kconfig
    SET_MAX_ORDER.
  mm: convert MAX_ORDER sized static arrays to dynamic ones.
  mm: introduce MIN_MAX_ORDER to replace MAX_ORDER as compile time
    constant.
  mm: make MAX_ORDER a kernel boot time parameter.

 .../admin-guide/kdump/vmcoreinfo.rst          |   4 +-
 .../admin-guide/kernel-parameters.txt         |   9 +-
 arch/Kconfig                                  |   4 +
 arch/arc/Kconfig                              |   6 +-
 arch/arm/Kconfig                              |  14 +-
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig      |   2 +-
 arch/arm/configs/oxnas_v6_defconfig           |   2 +-
 arch/arm/configs/sama7_defconfig              |   2 +-
 arch/arm64/Kconfig                            |  18 ++-
 arch/arm64/include/asm/sparsemem.h            |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |   2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |   2 +-
 arch/csky/Kconfig                             |   4 +-
 arch/ia64/Kconfig                             |  10 +-
 arch/ia64/include/asm/sparsemem.h             |   6 +-
 arch/ia64/mm/hugetlbpage.c                    |   2 +-
 arch/m68k/Kconfig.cpu                         |  10 +-
 arch/mips/Kconfig                             |  24 ++--
 arch/nios2/Kconfig                            |  12 +-
 arch/powerpc/Kconfig                          |  32 ++---
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |   2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config     |   2 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |   2 +-
 arch/powerpc/mm/hugetlbpage.c                 |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |   2 +-
 arch/sh/configs/ecovec24_defconfig            |   2 +-
 arch/sh/mm/Kconfig                            |  22 ++-
 arch/sparc/Kconfig                            |  10 +-
 arch/sparc/kernel/pci_sun4v.c                 |   2 +-
 arch/sparc/kernel/traps_64.c                  |   2 +-
 arch/sparc/mm/tsb.c                           |   4 +-
 arch/um/kernel/um_arch.c                      |   4 +-
 arch/xtensa/Kconfig                           |  10 +-
 drivers/base/regmap/regmap-debugfs.c          |   8 +-
 drivers/crypto/hisilicon/sgl.c                |   6 +-
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |   2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |   7 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  72 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 drivers/irqchip/irq-gic-v3-its.c              |   4 +-
 drivers/md/dm-bufio.c                         |   2 +-
 drivers/misc/genwqe/card_utils.c              |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.h            |   2 +-
 drivers/video/fbdev/hyperv_fb.c               |   6 +-
 drivers/virtio/virtio_balloon.c               |   2 +-
 drivers/virtio/virtio_mem.c                   |   8 +-
 fs/proc/kcore.c                               |   2 +-
 fs/ramfs/file-nommu.c                         |   2 +-
 include/drm/ttm/ttm_pool.h                    |   4 +-
 include/linux/hugetlb.h                       |   2 +-
 include/linux/mmzone.h                        |  36 ++++-
 include/linux/pageblock-flags.h               |  21 ++-
 include/linux/slab.h                          |   8 +-
 kernel/crash_core.c                           |   2 +-
 kernel/dma/pool.c                             |   8 +-
 mm/Kconfig                                    |  33 ++++-
 mm/compaction.c                               |   8 +-
 mm/debug_vm_pgtable.c                         |   4 +-
 mm/huge_memory.c                              |   2 +-
 mm/hugetlb.c                                  |   4 +-
 mm/internal.h                                 |  10 +-
 mm/memblock.c                                 |   8 +-
 mm/memory.c                                   |   4 +-
 mm/memory_hotplug.c                           |   6 +-
 mm/page_alloc.c                               | 128 +++++++++++++-----
 mm/page_isolation.c                           |  14 +-
 mm/page_owner.c                               |   6 +-
 mm/page_reporting.c                           |   8 +-
 mm/shuffle.h                                  |   2 +-
 mm/slab.c                                     |   2 +-
 mm/slub.c                                     |   6 +-
 mm/vmscan.c                                   |   1 -
 mm/vmstat.c                                   |  14 +-
 net/smc/smc_ib.c                              |   2 +-
 scripts/checkpatch.pl                         |   8 ++
 security/integrity/ima/ima_crypto.c           |   2 +-
 tools/testing/memblock/linux/mmzone.h         |   6 +-
 78 files changed, 451 insertions(+), 270 deletions(-)

--=20
2.35.1

