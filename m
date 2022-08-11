Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB895590915
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiHKXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiHKXQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB4A1A4E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:16:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 476FF5C016D;
        Thu, 11 Aug 2022 19:16:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Aug 2022 19:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660259809; x=
        1660346209; bh=tt6jId4iDxONEi40HuzS8jeXRqOseXM3BtI6NV+Ndgc=; b=W
        Tgbgmg7N1ETpGczX0PYaZkoekKvHlvQP6u/5NV4zNueSNzesxv53I7Kin6hB3SjX
        x82du9nZlp3uY9i6l79aj4wYlZtyFiqdgyN0N4UrdV44xKEtU+bTbAsiU2AMC9RB
        WtLrQZfDN3Tu7oW6G25rkWVc3EFolHXzwAjGBVi0pZLQDDIjwdo2mNHHMF7OJjjt
        cWQpw7Nb482VaSwyCIYrrxSp5Lk0610xWfpZwZWm0k1gzNm9/CNYKPFUf9fM7ZU1
        UpDfsBQY9K+Posy/7o5b+BwNwnY0aVh68SOB+A8Gg71g+xGWUtveD90NDpxoltZM
        wVeqrM/c8yl1c/kQQyhsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660259809; x=1660346209; bh=t
        t6jId4iDxONEi40HuzS8jeXRqOseXM3BtI6NV+Ndgc=; b=R8BJEVgGcUJVB2sgf
        MCpg0SHu4nrjsCt/2RI+W2OoP5UnYmK4wNWmkU3XEsYAHoDps02pSz+PL1sn1efK
        0ha62gCDXQ3yirK31sE/jQRWeVWxEuzR4/p1tLb1HY4MkSOmeLoEcKPfeIpCfx1N
        wnlChwVf+szOFJTZsA8HPb+Z1PHitKSzCp5lZvpzbvQOOhe3aDOvqyUc43gS95d4
        YkAuxI/0tiuy/DtoKlA6LEvp09406HWyz2+QMOkNmRXyhuGzJamKmnTiHPTWPmL6
        2i+OtpUnzYhAzyMMNWYKwctnj7a6lhlKMue6xp4dXx4UYKwwAIfGftTeBlwzYvMh
        DnQJw==
X-ME-Sender: <xms:4Y31Yt3kIZTXRFOzJxkq3bbfNCU1wLkP2d7qFRt_HV_Lac4Yf8l2KA>
    <xme:4Y31YkEcv29jhSejV_RsXJslh5kqqL3lrgYRJCr52jOr1OPucJT29AOw6Ug9Y6DMR
    GFwG_ZPZXl90ABXTA>
X-ME-Received: <xmr:4Y31Yt7FDamTlSx7i_c2rX7ratNWlr3P62n3QVt-4hqTqgh0_B5nzDXRq8zABBKuwnKRq6Xp4aAw2S6A_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:4Y31Yq0fLoxCFM3JoJ3Z8bRkdJAmWHk0ekTedqz0a8QLjGgIOJ2yXw>
    <xmx:4Y31YgGv2JX5O7anSKWcSlpFVqvUVDNwVH-GLcv4Ma0m4RoYR3rJbQ>
    <xmx:4Y31Yr8FUC7X6nv6hyNNs9MzwVG_hNTfxglJu6cl5Siu-Q7rVKrVXw>
    <xmx:4Y31Yo8DPfqrMG-NuNhPw1rqFY67e6jlbJJwSs8D_EO5SAcgUQ85ww>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 19:16:48 -0400 (EDT)
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
Subject: [RFC PATCH v2 06/12] fs: proc: use pageblock_nr_pages for reschedule period in read_kcore()
Date:   Thu, 11 Aug 2022 19:16:37 -0400
Message-Id: <20220811231643.1012912-7-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811231643.1012912-1-zi.yan@sent.com>
References: <20220811231643.1012912-1-zi.yan@sent.com>
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

MAX_ORDER_NR_PAGES can be increased when it becomes a boot time parameter
in later commits. To make sure read_kcore() reschedule its work in a
constant period, use pageblock_nr_pages instead for reschedule period,
since pageblock_nr_pages is a constant and either the same or half of
MAX_ORDER_NR_PAGES.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Ying Chen <chenying.kernel@bytedance.com>
Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index dff921f7ca33..7dc09d211b48 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -491,7 +491,7 @@ read_kcore(struct file *file, char __user *buffer, size=
_t buflen, loff_t *fpos)
 			}
 		}
=20
-		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES =3D=3D 0) {
+		if (page_offline_frozen++ % pageblock_nr_pages =3D=3D 0) {
 			page_offline_thaw();
 			cond_resched();
 			page_offline_freeze();
--=20
2.35.1

