Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD50055AED7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiFZE2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFZE2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:28:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B9DCDC;
        Sat, 25 Jun 2022 21:28:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 33832320055E;
        Sun, 26 Jun 2022 00:27:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 26 Jun 2022 00:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656217678; x=1656304078; bh=hRF+I95UJxqPYyeXN8EYFMKCR
        8uRybetp/GgkAZvqNY=; b=UgogN9O6ApCHwdLBnlbf6p3Hbmc+RzKkXeY5330e/
        H90NJ2BunN2wS20rCEpWwc6a09sIMpP4K9Wm+Y3mBqYUSBNEw6YkzI9U+gvZvwyK
        IyfZpyvcWH3e8urt2AcPheSzCOKTLh39aOxG2TPGf0kjVZvhl0qyTl0c2krR7GGH
        hvd1Pq7/iOhKVGwTy9sU9K1xt+hDm8EOvar+DOK2K27fZ+cc7g8q4hR24dlmDF9D
        QoXEe8747y94drqBur80fu1+LLPVmpM2zmU+eJfzCk/gj3SLHt14IWjwYJW9xkKz
        fXvuW3SOXNcVHzlSiL9IQataCl7c5gJSZ0X8hG6Fzec7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656217678; x=1656304078; bh=hRF+I95UJxqPYyeXN8EYFMKCR8uRybetp/G
        gkAZvqNY=; b=kBb/Ju001J1aZWFImoH0YeKHuscG7ZSv+E4/6OmzsNXYW5yQfIS
        Ox7KhZYqSykJOM8FZlRBYA+cqtx21i+kceD9bVyXBAuHhcHv1+bThd/nCklXSNlK
        4IlL6C5icg5E1r9mhEFSl+/5k3FR9Wx3TBksyQXA89uAdyZv6OQ4UIoZ7hw4DIKY
        omS8QPPM8+6H5/TOSGadZqEOnKFYaM3kApGM//qgzK2VQTdLOjkaqNnYdi9o/khu
        7evM16ffbL/rYjkuGohx9qUfOx4XUqd25vBzdyNz3ObdnHC8HkxyNvKvw2Vekrov
        UlbdcoNUQ0pEvle+cLtvV2OzBWJYB4qgnOg==
X-ME-Sender: <xms:TuC3YkzYKl2txXJXSuQ7EQxDTHioul3hu0RpQ2DGubt9d6edGg0IRg>
    <xme:TuC3YoR8mL9fNSxtDGLqRPprl8RkRI67So5DPPkyf3mphe9FnCjYARz_OS8dhN2ev
    5xk68InxEBIqf6lWw>
X-ME-Received: <xmr:TuC3YmX028yqqFtezCzYY0zdBPpmm0jHYYIiEv3auPmIbVKK94oKOfdSfemTjYvxQgYuNHGjrYWdr87MlhV5ryTUTtQk4or2QaJ6opmHFsWebiyfwliQEul_RoYAK3RmiCGHLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:TuC3Yig5Of93IMDqqrQwoNSy_IErl1mpNMFWT6ACw0BqLC0XueWSfw>
    <xmx:TuC3YmAK27EbRL4dkl3e-3FzA_jwa41yvmjBohkzel58afPl6amBdg>
    <xmx:TuC3YjJH_NZfSEuD2ytiC_Y_lAxFF9uwcR0n4q45G6DnwZyzoFpNjg>
    <xmx:TuC3Yi3ANJGnY9m4ez287FOmD-y6lCoZxGkq_1Zeq8FysCI7gVdwCQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jun 2022 00:27:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [RESEND PATCH] rtc: sun6i: add support for R329 RTC
Date:   Sat, 25 Jun 2022 23:27:56 -0500
Message-Id: <20220626042756.58961-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner R329 has a RTC with a similar time storage with H616 but a
slightly different clock part.

As we have already handled the R329 RTC clocks in the CCU driver, add a
compatible string to RTC driver to allow probing of the RTC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
Resending this patch separately from Icenowy's R329 series[1] because it
is also needed for D1 (which has R329 as its fallback compatible[2]), so
I would like to get it in to 5.20.

[1]: https://lore.kernel.org/lkml/BYAPR20MB2472C608678F3FAEDA7B7541BCF79@BYAPR20MB2472.namprd20.prod.outlook.com/
[2]: https://lore.kernel.org/lkml/20220203021736.13434-3-samuel@sholland.org/

 drivers/rtc/rtc-sun6i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 57540727ce1c..ed5516089e9a 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -875,6 +875,8 @@ static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun50i-h6-rtc" },
 	{ .compatible = "allwinner,sun50i-h616-rtc",
 		.data = (void *)RTC_LINEAR_DAY },
+	{ .compatible = "allwinner,sun50i-r329-rtc",
+		.data = (void *)RTC_LINEAR_DAY },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.35.1

