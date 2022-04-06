Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6A4F66E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiDFRVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiDFRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:21:09 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9FB465F88
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:19:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1C80E32020CE;
        Wed,  6 Apr 2022 11:19:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Apr 2022 11:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm3; bh=1YF7m4613MXNe8p8MqrCssfe9obIC+
        Hv5MZ4GZZfmqM=; b=YKUzVxNYG2cvhjeiXBzWzrVkxVOWKhCC/CqHsO4rL3YX8l
        XlGY6qKkq8UFG8XwzsV6zfHooSS58WEaEttKo7JjFLcZN/ZTG3dz2H30Xp9EBIZY
        xg4E5sJJB/9n8Squ8e6ofAP/Py0uROYA8i1g5LYodfr2QysMFu06mJF8thiS2GAR
        5Yr64p02izwtFzGv/NijRWSZBrTK04tcpVoCybjHvtqrNHsJsKhiEqi+M3ETmohr
        MmQhMs1YAgaZGuFkGypXkZRtsmB93sqJMBnOmqjkr0BQPkiivN4i3PrxjHdfyPGg
        PGPlB9iFLek36vqLMYv1DKJV4T+8P9hbY+vgYrKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1YF7m4613MXNe8p8MqrCssfe9obIC+Hv5MZ4GZZfmqM=; b=O4ZZ3LQC
        7itLMYN3x/E6kFNYn1i13LgQ/gLxOLgn1Gg18HR3x3c67LxhTzhyG5SGQ7lmqlPX
        p+7ol/z976hvfhsMPlOkXTqUHk2UdY7EQUcDI5NCDvueXw1Xc4OdWcR0Zlq2awdz
        DKbuvEvFsRG83q99oOxzMavu28bZePxrO6DUv45A5IXBwyWyW/wNuRRn3UrBfcmn
        KyB6Dc+XEKS+yOcsQDbmX1DBcAXuygKd+BSDVze0cLy2p6Oz5EDuCDyo2XcuxpjE
        y6qyu8h5bSL9V1c0p21XZf7xM39BE5EOogRYwz3NFj//1lfbzWnUy/FAKalwmU23
        Mn01rk9hxNcxpA==
X-ME-Sender: <xms:iK9NYgtRd1HR7lt50a0pJCggSyX_27N6niqDniR38vT_kovXzAsxrg>
    <xme:iK9NYtd_t2oow_NLaroZTnKktTQr5QKMVWblBp2yXspjaZGBd1bDjiR8A0W4mIW9a
    4YGb-vDCHWIAhe96A>
X-ME-Received: <xmr:iK9NYrzwkJBwEgPT7vwtjfkdOYbxTfxxyj-5SCns09mkw927emmz2ZB8bGtOHnbp4KIcFpW5iPqsbSwf5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetteejtd
    eigeejuefgleduhefgueffjeevhfelvedvtddugfeiueejveduleeuvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:iK9NYjPUMgCTbKPDrGa3CRew5tbpXdfcxBEqlExSE56iIxR2o-ti9A>
    <xmx:iK9NYg_wkdUQggxAZfqvmKVWAnLgFnKMMwi1NcPpk7QPSbt283GbWA>
    <xmx:iK9NYrVMi92KKH-Ze1x2Cme9pnPawHKZMHfUWkvwkmGlfNFka-fAeg>
    <xmx:iK9NYrZnwdbPKOqSkkpYfka-y0cmTTMzvK61WuP8Ry9mmkinFegl6A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 11:19:36 -0400 (EDT)
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
Subject: [PATCH v10 0/5] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Wed,  6 Apr 2022 11:18:53 -0400
Message-Id: <20220406151858.3149821-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-04-05-15-5=
4.

I also added "Content-Type: text/plain; charset=3DUTF-8" to all email bodies
explicitly, please let me know if you still cannot see the emails in a
proper format.

Changelog
=3D=3D=3D
V10
---
1. Reverted back to the original outer_start, outer_end range for
   test_pages_isolated() and isolate_freepages_range() in Patch 3,
   otherwise isolation will fail if start in alloc_contig_range() is in
   the middle of a free page.

V9
---
1. Limited has_unmovable_pages() check within a pageblock.
2. Added a check to ensure page isolation is done within a single zone
   in isolate_single_pageblock().
3. Fixed an off-by-one bug in isolate_single_pageblock().
4. Fixed a NULL-deferencing bug when the pages before to-be-isolated pagebl=
ock
   is not online in isolate_single_pageblock().

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
 include/linux/page-isolation.h |   6 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                | 191 +++++-------------
 mm/page_isolation.c            | 348 +++++++++++++++++++++++++++++++--
 8 files changed, 395 insertions(+), 174 deletions(-)

--=20
2.35.1

