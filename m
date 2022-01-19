Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6817C494058
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357005AbiASTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:06:45 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35851 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356979AbiASTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:06:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67B0C5806EB;
        Wed, 19 Jan 2022 14:06:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 19 Jan 2022 14:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm2; bh=XoGtHOG8AyFnf2S1JWsX18T68L
        iZtgT1QGCS/Lzv0YE=; b=Z0dpaC+CnN0yiYzTq1mRWwOkyRPH017sN6ZHiGIChO
        nmpfDjp8pp8RNPA+LdfgXzQBRUkihXdVIYSYo4szEZcidjaMBMDh+5kvIiubryoi
        66m1R29c339JdNYRLdaaoS6iWxI+4RKk/z/0PsExH/w4UlGPDLIeX5twM+7umkqb
        IhxJMQso5cS9cA87YHayQDC8NC9SF5OQpS19xpa9NpUuBDSy8S0DDv5jSih9f3W+
        IT3pXQYau1KU8WlAQlPy8IbbDN03QhzGotU0zfvn4R4D72hslzoWXk08ltGOGSdY
        okbjZHc7PbKQpsDNVTfhVBbBr2iDGQJeF77f6xB4EgsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XoGtHO
        G8AyFnf2S1JWsX18T68LiZtgT1QGCS/Lzv0YE=; b=gO/I3NtEdFsJenepxchu8j
        UlgO3PKzV+G9z1b9Co4w3dxKEVm8aescI/cx7jrzM1sf2pxuX+4rKKtWucUgeHdK
        7BZSvNyd66wLg8J/snTG92OG7v+luaxfdfUmhdME+MFgkwlJ7svlWfCm6Iyf5eOD
        B0ZJaTfBr8q+eTAcR7vScMOfjuU3BNF+bsUIHlMJENDDitGX4+TwKqH+EUdabudu
        rgBIIbcyivP/RNaj2l/nGgXEspAUhPVgFPmH3eeWw6T+WHpE1MhZk0j/AWOunRrG
        gUyHXW4XSNfQHrsBJCBGOaFlGojH9mVZPiwPLkeuaxxZj/7MqGSO52jyoee8EeWQ
        ==
X-ME-Sender: <xms:OWHoYTW9q79dcH0I_y05ufdpEexSVpQv2pCP8mbq8wKYJQf0uUaNyQ>
    <xme:OWHoYblJ75KeKpx-6iO3DY0uyzHzU1TD5wkPTTdItJ11kgQGTj38zriDpvxr7AKlq
    7VRJ8dtCnSv2f8Otw>
X-ME-Received: <xmr:OWHoYfbxCuhIczX6BzsDCjwxKuhdtcZdv3Hi74rHeFXEvP2XyTBHabpqgP2ZFyoNU58_SAAf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
    oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
    fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:OWHoYeV1t0lxGc4gdWK-ouG9ad45A9L8NCoPoE92P1caNy2KsIL_Zw>
    <xmx:OWHoYdm0aLgpkYzkLFSOMST8y9NsQrWLBjU6CRISanXt_CDFW1Jj0g>
    <xmx:OWHoYbeSAv4kvACI_gTYkmwirMOq5KZfcgqziIj4zC8AjOHNuimYZA>
    <xmx:OmHoYQ8ynrUETe1CpldILj1hXHQkvFnP8Zg-t5StFVxtTXErGBUnvg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:32 -0500 (EST)
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
Subject: [PATCH v4 0/7] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Wed, 19 Jan 2022 14:06:16 -0500
Message-Id: <20220119190623.1029355-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2021-12-29-20-0=
7.

Changelog from RFC
=3D=3D=3D
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


Zi Yan (7):
  mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   7 +-
 include/linux/mmzone.h                     |  16 +-
 include/linux/page-isolation.h             |   3 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/memory_hotplug.c                        |  12 +-
 mm/page_alloc.c                            | 337 +++++++++++----------
 mm/page_isolation.c                        | 154 +++++++++-
 9 files changed, 352 insertions(+), 189 deletions(-)

--=20
2.34.1

