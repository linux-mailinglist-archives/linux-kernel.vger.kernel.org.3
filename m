Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24AE46F72B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhLIXIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:08:12 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36665 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232635AbhLIXIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:08:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE8A6580231;
        Thu,  9 Dec 2021 18:04:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Dec 2021 18:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm2; bh=NSbPeTFmC3VX/ha0W/GXZKCwx7
        d2S9q3uKceYNqXMuU=; b=Kc7pBU31o8EbMxFXphV9zG6IiT+0lU3sHlVTVDJUhN
        838c2vFfjgqO41QJ4mrUwBwF0dYW1pR04fr+sFab8ANkVOEBeq2FrG+3B/SpYjXc
        vrs1yru1XjUF9VtzoCsmTc3YlMaOwP8pd7F8iFWHglZ7uZxIjm7q8dj6KDtaBgYF
        6MYK/MJS8gRNHY8rDq07wKmdQMAP/SRTwYMb2LI5hOCLQZ9iOWw6Or4uXI6recCV
        LkphAh+xx7La0uSVlm03JtVOBKs7YjYo19BDsSEWLLr97ZA3YjXYQYYqGlFRfxcb
        MEKRwha4KpDNRD/fP1U8WBn2UybgF6xuBrCIkCPankfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NSbPeT
        FmC3VX/ha0W/GXZKCwx7d2S9q3uKceYNqXMuU=; b=iKm2mq+zRARqu6Az24pOud
        6cYie2iC8A2n77TsKaeKbYjyVdUFbvHGVRB/sy5b38R1fHtkxGTXQ58tgWsW2eOV
        NBnoRR1sxESACauibFV6K5D7ass+nLZGPdOpPXsoQ5h9kTesYKp94ZOCLsUC0mmK
        d08HILFUYVE/ExBdrNYAMmNBMN0Mgxvrq0XNr0POOzMZWS0Ht8TDrsw+yMCLqzUK
        daaeGy+yClJcboe60hfEOdDkm8gZ5lxHRVomoOXs7SbGtQx3cP6sqGc+wXFXjv/z
        dv064kjkv+5kpRPO4hqP9Yu+SKqDSwKQaPKzrvNeGJo1qFCu2hv91xKoxEirtbLw
        ==
X-ME-Sender: <xms:hIuyYW7KJ2VGvmwWyftbYGKwWK5HJvCSFmJcGjK5tF1EAOU1NiOcxw>
    <xme:hIuyYf4gLhuzV8STMC4PJkvPi2eNA8vecJ4xHCQIisM3hcF3m2zeF1UyvMQdYjLBg
    Z0szHSqPdFTpxRSUQ>
X-ME-Received: <xmr:hIuyYVeY0KnyI8D_rgHPH8k1jJQ-_Cj2aDK-HWDCitfV9QvSilgzQcaWfMxPKP3kae2Tu-lh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
    oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
    fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:hIuyYTJzxt05EzsOOhpkGX-Qdg3ntRF66l4AebHbDrJ0S27qmDccxQ>
    <xmx:hIuyYaK8WYPLDvA2xw1NU47aotgeBqzt0NNUNsSTBpe9FRmeXlZTSw>
    <xmx:hIuyYUx57W7-ctHGwgaG8T3SVd_sb9nShRzXsMRaaOGHnxLfxB8kmA>
    <xmx:hIuyYcD79eHf97d9tBbwlV2NsHtpEe_KPv6XHDW2Z65FuIIXa_dDcg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:35 -0500 (EST)
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
Subject: [RFC PATCH v2 0/7] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Thu,  9 Dec 2021 18:04:07 -0500
Message-Id: <20211209230414.2766515-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
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
adjustable at boot time[1].

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
3. splits free pages spanning multiple pageblocks at the beginning and the =
end
   of the range and puts the split pages to the right migratetype free lists
   based on the pageblock migratetypes;
4. returns pages not in the range as it did before this patch.

Isolation needs to happen at MAX_ORDER - 1 granularity, because otherwise
1) extra code is needed to detect pages (free, PageHuge, THP, or PageCompou=
nd)
to make sure all pageblocks belonging to a single page are isolated togethe=
r=20
and later pageblocks outside the range need to have their migratetypes rest=
ored;
or 2) extra logic will need to be added during page free time to split a fr=
ee
page with multi-migratetype pageblocks.

Two optimizations might come later:
1. only check unmovable pages within the range instead of MAX_ORDER - 1 ali=
gned
   range during isolation to increase successful rate of alloc_contig_range=
().
2. make MIGRATE_ISOLATE a separate bit to avoid saving and restoring existi=
ng
   migratetypes before and after isolation respectively.

Feel free to give comments and suggestions. Thanks.


[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.c=
om/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@r=
edhat.com/


Zi Yan (7):
  mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
  mm: compaction: handle non-lru compound pages properly in
    isolate_migratepages_block().
  mm: migrate: allocate the right size of non hugetlb or THP compound
    pages.
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   6 +-
 include/linux/mmzone.h                     |  11 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/compaction.c                            |  10 +-
 mm/migrate.c                               |   8 +-
 mm/page_alloc.c                            | 203 +++++++++++++++++----
 8 files changed, 196 insertions(+), 54 deletions(-)

--=20
2.33.0

