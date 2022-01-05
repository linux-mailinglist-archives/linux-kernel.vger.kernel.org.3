Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66AC485AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiAEVs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:48:27 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37469 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234070AbiAEVsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:48:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3F36858050E;
        Wed,  5 Jan 2022 16:48:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jan 2022 16:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm2; bh=XuWtzwLjwrz+Pbdt4BURzbEzIj
        SMHmc6+71DP0kr+2E=; b=uXAApkQxB/AHFvFh1fVn4pkg+KKcnsaui9GQg+9dH2
        SFYnWmEe/ldaxJywT/GwaCyzOGCO7m3X3o7M2ae4OZ5FwshRwxYqmF2HHcYSBN+l
        9cN0zSWwU+iJgj48GoYpZARjxLtIxBz/MEaf4nXDalkH9VxbNETon9AOq2B6V5Yn
        R8ua7i82K3DpMMPVPOF/w6LsKrCuyc6TjyNOvKROMMETe9xzLO5cC3Ffps0owCmH
        QYsGLqdUmE4xmYJmg2PhMyrjcINl8V8GMjpIKvOphS/M1lNkpn6mljULn5plg5Iq
        noSas0MQqxTl2XI75bT9fLaUwmm2bgOM6d0/rSYCDrow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XuWtzw
        Ljwrz+Pbdt4BURzbEzIjSMHmc6+71DP0kr+2E=; b=HvGpC6u6DuKlQgEP1Gev3q
        Rgt0hQDTeg3WsXqtwHcudSdbaKQu8JDpLAweDlFjaFqFA7lBZ/9bDgR795dTixy1
        f7V42zwWZwyXcowz+luRUA+bGINa/MWHjF86ilacqzjFnEC+fuqbVISuOs6o3llr
        KHjupyMVFFsCrGDqF96lDXqj2pt/0rnU+UBL3KtG+8VkyeP4l1hjavc8D11hjFy8
        zY+IhJp6cdJJxerPIaHnBgnoxlLPg5S12HwGq8A/So6NCYMGFgywYRAJ56G4DFsE
        zMSvfMWf6lZgS8RlKZvtuQs77mBhI1iFNJO38LfEOHPApe271dGpBTxzAZKPzi8g
        ==
X-ME-Sender: <xms:JhLWYVKXz0XA-qpUi52ORQJ3b_vlMtwapPHJBVHKj_u8hnWMqZtHDw>
    <xme:JhLWYRI25R7Exx_bhZKo2mRzyd3q9dVvcisZIUCr31t90YK1E4xvbWaGsmUPpj_de
    BJetflZTamAnZXawQ>
X-ME-Received: <xmr:JhLWYduJJIK6sAiI5lQNR2rS0BCbdvheZt-9dhfIDkum0PZ9kGFM9vJpYTRMPYLLxXF9xtHR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
    fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:JhLWYWbgMIL6YDHpejS7gaz3xF3GYtJHhXnUYyFsNUqmiljYKpIE3Q>
    <xmx:JhLWYcbztubtuPOSHETmw9gpNOrWQHFUkEEHVSpmQ4TOAFs0hRhHMw>
    <xmx:JhLWYaBLWIq4Yx8-4V6VLWCHmTnK9L_CQAWAl-5CipObOrjm1hOrNA>
    <xmx:JxLWYYT6deCytecTH9xSlMQ4YWXiP-dvNcZMaqJzj3Q7ESFepFN1pw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:21 -0500 (EST)
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
        Eric Ren <renzhengeek@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v3 0/8] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Wed,  5 Jan 2022 16:47:48 -0500
Message-Id: <20220105214756.91065-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset tries to remove the MAX_ORDER - 1 alignment requirement for C=
MA
and alloc_contig_range(). It prepares for my upcoming changes to make MAX_O=
RDER
adjustable at boot time[1]. It is on top of mmotm-2021-12-29-20-07.

The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
isolates pageblocks to remove free memory from buddy allocator but isolating
only a subset of pageblocks within a page spanning across multiple pagebloc=
ks
causes free page accounting issues. Isolated page might not be put into the
right free list, since the code assumes the migratetype of the first pagebl=
ock
as the whole free page migratetype. This is based on the discussion at [2].

To remove the requirement, this patchset:
1. still isolates pageblocks at MAX_ORDER - 1 granularity;
2. but saves the pageblock migratetypes outside the specified range of
   alloc_contig_range() and restores them after all pages within the range
   become free after __alloc_contig_migrate_range();
3. only checks unmovable pages within the range instead of MAX_ORDER - 1 al=
igned
   range during isolation to avoid alloc_contig_range() failure when pagebl=
ocks
   within a MAX_ORDER - 1 aligned range are allocated separately.
3. splits free pages spanning multiple pageblocks at the beginning and the =
end
   of the range and puts the split pages to the right migratetype free lists
   based on the pageblock migratetypes;
4. returns pages not in the range as it did before.

Isolation needs to be done at MAX_ORDER - 1 granularity, because otherwise
either 1) it is needed to detect to-be-isolated page size (free, PageHuge, =
THP,
or other PageCompound) to make sure all pageblocks belonging to a single pa=
ge
are isolated together and later restore pageblock migratetypes outside the
range, or 2) assuming isolation happens at pageblock granularity, a free pa=
ge
with multi-migratetype pageblocks can seen in free page path and needs
to be split and freed at pageblock granularity.

One optimization might come later:
1. make MIGRATE_ISOLATE a separate bit to avoid saving and restoring existi=
ng
   migratetypes before and after isolation respectively.

Feel free to give comments and suggestions. Thanks.


[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.c=
om/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@r=
edhat.com/

Zi Yan (8):
  mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
  mm: compaction: handle non-lru compound pages properly in
    isolate_migratepages_block().
  mm: migrate: allocate the right size of non hugetlb or THP compound
    pages.
  mm: make alloc_contig_range work at pageblock granularity
  mm: page_isolation: check specified range for unmovable pages during
    isolation.
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   3 +-
 include/linux/mmzone.h                     |  11 +-
 include/linux/page-isolation.h             |   3 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/compaction.c                            |  10 +-
 mm/memory_hotplug.c                        |  12 +-
 mm/migrate.c                               |  11 +-
 mm/page_alloc.c                            | 328 +++++++++++----------
 mm/page_isolation.c                        | 148 +++++++++-
 11 files changed, 353 insertions(+), 185 deletions(-)

--=20
2.34.1

