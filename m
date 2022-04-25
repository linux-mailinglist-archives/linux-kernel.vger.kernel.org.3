Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949BF50E32E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiDYOeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiDYOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:33 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A3286EF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E915A5C0164;
        Mon, 25 Apr 2022 10:31:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Apr 2022 10:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1650897087; x=1650983487; bh=x7
        A+uv1DHn44uc7oELJvXdZnUv/WQkraxvObDiVEKec=; b=PTesVBn+Ug8U9urNin
        6QAcfvoQXAxxJCd4y95lYpNOg634K7G8jZ89Ima64kWmbP46hwNmqyyVGk/iN+RQ
        S68iD/TD980uYO4/P3P9V8x5NTnbgg412VBG7s1drkLELHjIcdXd8gdfNPFpTfTV
        z2W98zwGvn0nZsNx7Vpsf4wC1wTiEePFseH5n6FtmaDzt6eZicUfRixVTsDrQV3Y
        ZFf+w3PbLMxqK6XbfyKhg4ssxgWTY4VuEzL+nM++XIqhaA4oQyncYATToB3J8UZl
        cfJqCJAeuEmuIoNJqA8LwGOCFQY7FIbZBDwQyLjId+dQ8KsLmhLO/lX9kYDTCisC
        Qa1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1650897087; x=1650983487; bh=x7A+uv1DHn44uc7oELJvXdZnUv/W
        QkraxvObDiVEKec=; b=hUsFZeldnKjQgsLjbdHjCUfcHHyiBsDm37lZM1oC/qDI
        85hJz/A5YkrNQWiyjlOrkvLUiR6Q0ekxYrV1TcOAvqvW4EG+2BszM6aZDUEc31c3
        Q8S8HxToUtgweamsnVX6isFN8d3wZOu8uNzaQG3soL6wbCeg6KLrYDBxwwajQ+RZ
        i6B/LX/5g8T7z47FjQ1+Fx93hIn9traxjvB1TLqrjnd0dgIBnS+I1Rti4wkuRJL3
        WAJ/FV/zqZWveK0TFEs1Ql42LwAda7R3oqgxXcDG+0TExe3KZGnkxmiiE53d3ObT
        dY9HYweg+NQvHpQ1wNI4tzyoSIwYEh/st2sCscxnOQ==
X-ME-Sender: <xms:vrBmYg295apXXumHwQjwB8TKLNqW7wU7TNnrkNxbThOOD8pSSZxUNg>
    <xme:vrBmYrFInQEh-tFPX0-iOd8HO-34CeWOJQuIrKaDfrRgpO08B7PjG8uimIfWaY0SP
    7mxqeHmGqAQ5GR0ag>
X-ME-Received: <xmr:vrBmYo5R03ewoBRwE-sWrHa9CHedDQWeK_QXqDDg_B7SuJ-FPanTWiSBqz5Yhzo5Fg5GnvgCs75WGX_vbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtqhertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeefgffhgf
    fgtdetfeefjeduvdeugeejjeeiffejfffhgeevgfffueefieektedukeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:vrBmYp25Cng4DDz0P1MxbzzColPUaqASvR71bELIf24NuzZFD4jWhQ>
    <xmx:vrBmYjHaUz5PMjeD2X9octgVKXtvpn9PnsS8SIc8jG8Zdcs-ulGHgA>
    <xmx:vrBmYi-JzgMW4Vx1oHl95IrkfZh17GScf2V2iQCPqiMVNylXEideHA>
    <xmx:v7BmYr9amUlz__So1tT3q7uAoVggKu7NVRRmkVgatbkYnWRS4pRt-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 10:31:26 -0400 (EDT)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Mon, 25 Apr 2022 10:31:12 -0400
Message-Id: <20220425143118.2850746-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi David,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-04-20-17-1=
2.

Changelog
=3D=3D=3D
V11
---
1. Moved start_isolate_page_range()/undo_isolate_page_range() alignment
   change to a separate patch after the unmovable page check change and
   alloc_contig_range() change to avoid some unwanted memory
   hotplug/hotremove failures.
2. Cleaned up has_unmovable_pages() in Patch 2.

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

Zi Yan (6):
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: page_isolation: enable arbitrary range page isolation.
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
 mm/page_isolation.c            | 345 +++++++++++++++++++++++++++++++--
 8 files changed, 392 insertions(+), 174 deletions(-)

--=20
2.35.1

