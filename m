Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90E4DCA25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiCQPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCQPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:39:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D820C194
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:37:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 880825C052B;
        Thu, 17 Mar 2022 11:37:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 17 Mar 2022 11:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=CBY5vO+va2Zc2XbVGFNeciCFi/umhOLunZ1gGY
        GvWFU=; b=yMeUHG9lq9BhmhQ5fQTv1MksPhU2a0v/p6iPol8Qct0fD9cXj612z1
        +t4DIZYbVqLHVxjEeMO/YOzoTSpvMLZvJFa1Mqs5e+aSvT5PSIjK/1QB7OSu70ai
        E7aRBvhw2NE09urdHmBPP1w3SQHaNpKJMgHtiIND8CaobJEK8pvYwgf5yVXWZ4XW
        jfboV/hDJfavaW+L+z3auBw1NenmebLZMFgDufaeorW5IDs/bie2VfiIvp2n+5fV
        REhO2oasmY0toRnxglBQ4YGSC6gFrlow+Yw/rREFZvI00MQU+pPcOnP6aWUecyWT
        QPPO0hXJmvEljnG3Reedn6c++jjIxO7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=CBY5vO+va2Zc2XbVGFNeciCFi/umh
        OLunZ1gGYGvWFU=; b=EjsD2XT+zMxBLmgNVJkByzrpLjZ5DIvX//6iX1cRnf56c
        TDHXES0v2Dj7/Y3sQNzA4UwjpF3t17RsiTdEh+LHs0Ce2zBDp1ShH8iwSY+CFITH
        h4/vGvpFnpehiy/7jZBuGSH8mle5vCKmF2eBj0i1QvNOecJ5V5kRN0idwo9DqxOo
        ePtsKIAtgaVgzuN/99h66LWOqAnvVqkl2h0zbwhHu22ZnLsLCJKF9ZxCA1lPKXc3
        xtzEhxiaqtHkvohvTbBtsezNYw0DmZTPBphq2KNd/HbPa0L6Rk+n19J0CzIJL00O
        vqPrBaIsSz9Q7z+Fpf9vjjAXV2f7HixNPepanG+OA==
X-ME-Sender: <xms:ylUzYhdrCyqXmTjfphT2nEFmaIxYYQwbHavuRjOOJUCQIeH18WJMgA>
    <xme:ylUzYvNePRzHa7IPwLXFQ6XbYKJStZPI-64vYRItNzcvP2YV_JC2c4WlwOrn3dINi
    rKGwGi5cNKmFM_N2Q>
X-ME-Received: <xmr:ylUzYqgX1GJoudEzyAYjrUVfT5zroJYkdLcpBO7dBa0GuzXy1CJu-HZzi7sckUvh_dYbIRaejiQGJ7mN8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
    fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:ylUzYq9uUmUPxIGuzBQtund_tLEnmzcTM10u_KHTjOc9qruRvf-ZAw>
    <xmx:ylUzYtseIjvBgPl697Ogjxdxjhq1XX6rcaxq02HICsEj2HfgYrVquA>
    <xmx:ylUzYpGBCrKPHHVJ-i6p673lLKW54qLItTnv1Ew8VpPCb2YXAFgyNw>
    <xmx:ylUzYjKZLEMjUcz62z6l4UTULiY7u2qRtloOieK8P4SwXlL-eWTJdw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 11:37:45 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v8 0/5] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Thu, 17 Mar 2022 11:37:28 -0400
Message-Id: <20220317153733.2171277-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
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

Hi David,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-03-16-17-4=
2.

Changelog
=3D=3D=3D
V8
---
1. Cleaned up has_unmovable_pages() to remove page argument.

V7
---
1. Added page validity check in isolate_single_pageblock() to avoid out
   of zone pages.
2. Fixed a bug in split_free_page() to split and free pages in correct
   page order.

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
2.35.1

