Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF794C0B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiBWEbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBWEbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:31:12 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF93191A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:30:46 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 42B94580055;
        Tue, 22 Feb 2022 23:30:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 22 Feb 2022 23:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=ETC2AAf47GJ+iGkmCj4k43U6GvDQMOzkmXEXAA
        ZFQiE=; b=moTacVGxwQE7c3T9nkxC0XjeIrAoEmvXOQC6Eo3J/3XXfZ26exoKAT
        /QsARQD9yWNIh3jhTbxVulurxuo/F6T30nnZylLM6Dohzj7dnHCSbD4BmmS4zRio
        yR8K4wAJb76Rstdbh1K6WwR4ZE80ibQLj7S0hmS24CPmlcDOUP/MDVVxy1uJkQjA
        BahzsRtK5VLT8eeGTx9Ni+YN+fzMloOa1Vz4jSxEq542dW5ZKPZNB3kT7JVK0+Sl
        BFfBUVn4ESU+tSGh+uQbnlW12UyImkmR30R8Yri7sBxl9/TvLjQmpu+1G1XtQLi9
        taOqjBQzYJmbwvBTR2VcnlETcaOgGKiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ETC2AAf47GJ+iGkmCj4k43U6GvDQM
        OzkmXEXAAZFQiE=; b=Os0hmMfzfgNY/B8oGtvV6Jd9ITb3gcMUIKPpKDNXNoU2N
        Cyt23PLwW1ebDpqR9nZ9SshDsT8+3kJXAhllhWPX7d5WRbw1sEy4rKaf/6yuG9SN
        hEcbE+u8GPX/+GWlQa8r7oqN2KAb1S9BdtunW6oAW9NL0T8tz93HGOS8m8zK+Yul
        +cB/OGwzOFvytXnMOhFPyKiLJR/bLQigqfq1UBlWTLah2QmxGA/sH3ypL1HpOkAS
        oJvGmAYN3487umX+YXwjj9xU65Ke57gK03Fa7LOhV+JY1dzmpEetKK1cjzZ/Xv7/
        yhfjSKAXsN4wsyKJEq8NeTVivVednNXUVTEIyD3Qw==
X-ME-Sender: <xms:dLgVYsCpZZWNlf23WFuQPTHx2zdIcIxL0CRuIvWs3Usv9F4RmTiu_A>
    <xme:dLgVYujiwTdRsCBGPK6Mbs1axfLEP3WwlBGFFljGXBj3dIRQrilhVL7b8JtH4jLnr
    CQP5HewyF0xMHDBcA>
X-ME-Received: <xmr:dLgVYvlkqkTJ_Em9cN0jQ66_ZDW5tetVG1hkFpxi-2yhi0DxzzL8HwXZ_iRW5SiTGbowahMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
    oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
    fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:dLgVYiwgtJsC4TTp-NgRiUs4LlTbG2OEF9FvT_y7h4N_dEBfqlnuhw>
    <xmx:dLgVYhT_bC3TztO9W9pyWxBtw8SRE7X240RoPGvzrOO6zUfTkhE9Gw>
    <xmx:dLgVYtYv60Pf2HZz4ovPownyKi1ix78bnmjL1YPXDmVr4DXSS2_U6A>
    <xmx:dbgVYqhDWi2mKIPAZo2N-TZw9MeRB7_ZPObODmzTAaQ0kglhZtI2xQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:43 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v6 0/5] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Tue, 22 Feb 2022 23:30:32 -0500
Message-Id: <20220223043037.715205-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-02-14-17-4=
6.

Changelog
=3D=3D=3D
V6
---
1. Resolved compilation error/warning reported by kernel test robot.
2. Tried to solve the coding concerns from Christophe Leroy.
3. Shortened lengthy lines (pointed out by Christoph Hellwig).

V5
---
1. Moved isolation address alignment handling in start_isolate_page_range().
2. Rewrote and simplified how alloc_contig_range() works at pageblock
   granularity (Patch 3). Only two pageblock migratetypes need to be saved =
and
   restored. start_isolate_page_range() might need to migrate pages in this
   version, but it prevents the caller from worrying about
   max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) alignment after the page ran=
ge
   is isolated.

V4
---
1. Dropped two irrelevant patches on non-lru compound page handling, as
   it is not supported upstream.
2. Renamed migratetype_has_fallback() to migratetype_is_mergeable().
3. Always check whether two pageblocks can be merged in
   __free_one_page() when order is >=3D pageblock_order, as the case (not
   mergeable pageblocks are isolated, CMA, and HIGHATOMIC) becomes more com=
mon.
3. Moving has_unmovable_pages() is now a separate patch.
4. Removed MAX_ORDER-1 alignment requirement in the comment in virtio_mem c=
ode.

Description
=3D=3D=3D

The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
isolates pageblocks to remove free memory from buddy allocator but isolating
only a subset of pageblocks within a page spanning across multiple pagebloc=
ks
causes free page accounting issues. Isolated page might not be put into the
right free list, since the code assumes the migratetype of the first pagebl=
ock
as the whole free page migratetype. This is based on the discussion at [2].

To remove the requirement, this patchset:
1. isolates pages at pageblock granularity instead of
   max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages);
2. splits free pages across the specified range or migrates in-use pages
   across the specified range then splits the freed page to avoid free page
   accounting issues (it happens when multiple pageblocks within a single p=
age
   have different migratetypes);
3. only checks unmovable pages within the range instead of MAX_ORDER - 1 al=
igned
   range during isolation to avoid alloc_contig_range() failure when pagebl=
ocks
   within a MAX_ORDER - 1 aligned range are allocated separately.
4. returns pages not in the range as it did before.

One optimization might come later:
1. make MIGRATE_ISOLATE a separate bit to be able to restore the original
   migratetypes when isolation fails in the middle of the range.

Feel free to give comments and suggestions. Thanks.

[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.c=
om/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@r=
edhat.com/

Zi Yan (5):
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.

 drivers/virtio/virtio_mem.c    |   6 +-
 include/linux/cma.h            |   4 +-
 include/linux/mmzone.h         |   5 +-
 include/linux/page-isolation.h |  14 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                | 246 +++++++--------------------
 mm/page_isolation.c            | 296 +++++++++++++++++++++++++++++++--
 8 files changed, 367 insertions(+), 213 deletions(-)

--=20
2.34.1

