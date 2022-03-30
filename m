Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A898E4ECF61
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351480AbiC3WOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351475AbiC3WOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:14:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A209427FD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:12:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AB3A23200D98;
        Wed, 30 Mar 2022 18:12:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 30 Mar 2022 18:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=VafuHBoZUzeSxeYTXUmAINKRMraZTcsVMF+kik
        9kRS8=; b=D48d5msTfHW2+sZdc2uTI4B2sz6GNQT1thu8W6z0+/qRf/SlHg/t7f
        se1yGjjdHLGvpCRO1s00lt9/UtUODmENcVimzrg2oEbW8unmhZHbQga+UEQHtqKm
        dOLFquqqulEpBA33ByjSKPL3JVGBTQ5dQqIiYxd1/ajWvxsC7WRMJk4Txc/Niv10
        a0tKF0pV3tZrhailrjmg9NpOAho95yeCk8kuMZT0kBBxKLmxunehb/Zkd8s61w5c
        YWNc+BhBaW7QrKLwmzzg2bUezDo1UUPJoQvh48CbDt68MjMsni5LRHz8Z3t4+Li4
        NzmKf8GAM4xK7/xIB3QFgZia/TdzDxsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=VafuHBoZUzeSxeYTXUmAINKRMraZT
        csVMF+kik9kRS8=; b=i85FOJef4YHfcyIo37PzgfhHuMaNe1MmPiroCz/ADhnFI
        gLsFQUpkOkaDwksKTYTMQv4BuGydKSbdPjH9hqp7pFIOKms1bxcC7oG6Qed+OeMZ
        Tpqhlb4RLHIV6kEju2K+Ug7HK+wsxLvVbjLXmnTvqrD9Co2qoKCrSOvgTgvsPF7b
        C4zpkhoCYq543FsB6lNDXsatm+cqJiil8xk+MJF5qYMLomgIiS/e9EWfdRdxs55q
        nWksVR/Wli38Jq56r5aSeVEGPlGcQfBwKShCeqZIHuWqGSaKrN5uebTxuAcQjXgL
        gULoKf3aTd3bII3Ya4OitzU4Ge7L5ay/+Y1x1hOyA==
X-ME-Sender: <xms:49VEYqRZEwoCaI_LgfrfAOTGH5vkxDGqYbQgMyeutviG-0bOa0bWEw>
    <xme:49VEYvye7M8kgMnJoA1nCF9jg2etPHFx2R18ybDqCjDqEpTAiUHkGFZq-s6MEmpoJ
    oBo7fQuKHgDV3LEyQ>
X-ME-Received: <xmr:49VEYn1xRi416aNxROum6HnuPLv52iuUpQBkrWFFJsUgZwh3fjH4Lujas15tg74l4nVzfV60TKhJr-hvJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeifedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepleetvddtvd
    dttdetffdvkeehffdtjefhkedtheffjeehvdejueektedukedufeffnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnth
    drtghomh
X-ME-Proxy: <xmx:49VEYmAMFEjFe6RLrzrvy7BWsgB2qOA2U882u2i-OUK0oIxUyn-JRA>
    <xmx:49VEYjhJa5gpDVaNVbDuEkLohrI-M5rEV9VzIhBV7fQAcvUcgs3IqA>
    <xmx:49VEYioZ_dkYmCH9RXwErcNFy1ugoWFcpVj8OOhgeSxD5Fd6HmdkxQ>
    <xmx:5NVEYiMFxS2gJ3SH06l6hd6-Ze9Jj7vwwZvosmjDCiuD_dQGVxtLoA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 18:12:51 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
Date:   Wed, 30 Mar 2022 18:12:38 -0400
Message-Id: <20220330221238.396357-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
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

Whenever a buddy page is found, page_is_buddy() should be called to
check its validity. Add the missing check during pageblock merge check.

Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable pagebl=
ocks with others")

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdc8f60ae462..6c6af8658775 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1108,6 +1108,9 @@ static inline void __free_one_page(struct page *page,
=20
 		buddy_pfn =3D __find_buddy_pfn(pfn, order);
 		buddy =3D page + (buddy_pfn - pfn);
+
+		if (!page_is_buddy(page, buddy, order))
+			goto done_merging;
 		buddy_mt =3D get_pageblock_migratetype(buddy);
=20
 		if (migratetype !=3D buddy_mt
--=20
2.35.1

