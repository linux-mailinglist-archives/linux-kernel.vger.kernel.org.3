Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4985554481
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353228AbiFVHaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350562AbiFVH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:29:54 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C434645
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:29:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 75CEB5C00E6;
        Wed, 22 Jun 2022 03:29:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 22 Jun 2022 03:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655882991; x=
        1655969391; bh=pbobVvTrDvCWy60hjRxYkSgR6i7yeenNbIJBAiqpw+g=; b=q
        /Zil05qJ33h7dpV3MibHup/v31TpMY/FtERQi64DfqdrWowZZDGNMfESGbj7Nl+A
        jKF1V2pMk8Ju4Z6tmL2gTaODjhaE7mpelBgXzZLAEDHXzHkAfQAfEDIWi6WG8TSw
        cR2U6/7OpEZoMkJiPgHRyEIMkPBuNdeNx+LIOH2bmQBySB9e6AX9ePjEPvhMlLHe
        XX9kDlWSx1wSMZHY/2afOazzLgNdWxGSuYxTybxZqHls3J1mcA+OsldFD6mNGVHh
        H8SsUTzIneeI4lGD1C1JnuJGQemuIQdTjfxy63zkIwelbyquc58Q3TMbDo0k85J7
        eu3UjKn3gO5BzVH4GbDUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655882991; x=
        1655969391; bh=pbobVvTrDvCWy60hjRxYkSgR6i7yeenNbIJBAiqpw+g=; b=K
        tkUJWWvsRrG5DL3ztZ3ZmjB8RkCYXerkKnJTygmZ5wAmf2jcnsKoxqiiW/2BcUy7
        Hnu/0o3GoO5nGbHDSJrR/mwuG1X/oACqdet061YbXyp/W3YrOdC6g8/SGrht6nkz
        biVEoPAQQg+Sl58gw00q9ALLV9dvVBcgLVlO4mCbrwj2rLlYp1MUb2ndy8mN8dS5
        VdnqdE23pFxV1fHmune2a9vFtjHR5Ba89hiN/CswIEu7w6ougc0q5+0Q+7WKsQJP
        WwReLQx9YIgZqFC1M93QEymluAS5Q7U/2JKnNjrKEsRpAiFcGzV26og3KL6ssBD6
        rCHCXwS9hlZCT1miG2n0A==
X-ME-Sender: <xms:78SyYgr5mF1deCVOWBqAZvVLoI2k2aWhKvdDjiGzz_l3g4jLsp4kBA>
    <xme:78SyYmohD9OsHXRsoXSWKnq4IfM1LJ0p16UOQS9twufx39sNu7zFGanIH05NntHMP
    5P7LiS5G3IeMa7qacI>
X-ME-Received: <xmr:78SyYlPOjibmMY53-5xTnLrfExwzB25KEW0kixmI_X5Wt8vReGwRbEwUH87DMyGMS3Iylh_IFFKYVTYav4Tphj-6L4OpxA94AZvdI1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:78SyYn7XkytEhS4DcBw_8aYoGHsU_bOQiwZiB11Odfugxy3iaWs5vA>
    <xmx:78SyYv64-Yl232jl4V-AFcsm9wnK_nAX9DjdTNxQ2NPHdV9B2ECh3Q>
    <xmx:78SyYniUlmrQSHISlHeDYcw5mNNL5GXifZsBemmTpGlFuK1Ws0Ix4Q>
    <xmx:78SyYibai4saUMSu_0H8eT3YuZcFQL9JoRsuXNjwo34cofquYkkMYg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 03:29:50 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     jiangjian@cdjrlc.com, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, airlied@linux.ie
Subject: Re: (subset) [PATCH] drm/prime: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 09:29:42 +0200
Message-Id: <165588297922.13818.13524716037059627396.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621130210.125461-1-jiangjian@cdjrlc.com>
References: <20220621130210.125461-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 21:02:10 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/gpu/drm/drm_prime.c
> line: 842
> * of the the buffer described by the provided sg_table.
> changed to
> * of the buffer described by the provided sg_table.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
