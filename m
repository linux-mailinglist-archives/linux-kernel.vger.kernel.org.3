Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971C4FB31F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiDKFDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDKFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:03:17 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE893668A;
        Sun, 10 Apr 2022 22:01:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 090853201DA0;
        Mon, 11 Apr 2022 01:01:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Apr 2022 01:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649653261; x=1649739661; bh=3FHnb4Cp18Y2LEkoS1WKw6+37
        m2cFQoTwhF2MLKmC/w=; b=YQglM7b1OaG6yKb7vCNnryOcqE4cTBWx6iwlmHuDB
        qCm1/CfTZH8tVCt6bBV4RAWOo9daFIJkg/6MbJobk1+v1vyAwmIRPUbJTptHzNvO
        ihXTTvAlGltHyfvb9cnR4xNgxT9X9m8WyhAdiiHc132QqOHIOm7zFUoEEGo9RF1n
        2p8RnfLjY0kFkP5NBSBO7LyVEpHpXxCE4HGHik9Den3zyVSKg0LY3CGpyyJv4gj+
        RpJKHpzXm0x/ZCQcxw+nctOv3cZpeFpa5nwEOCBCDKQ1SuKPfLmD8aPQpY55KmeG
        rcxqIsMf9wexUN6lET9Mz24Jcav2EQmmub72lc6cZiEZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649653261; x=1649739661; bh=3
        FHnb4Cp18Y2LEkoS1WKw6+37m2cFQoTwhF2MLKmC/w=; b=bnzl9FDRGFlxJ9fCC
        CPx36tV1Qm6cl9vXlZ4sqrUqZpYKaEjn9Q1mguLUm5isG5DXAx2NOSd0HL0jGU9x
        /qjHv7Q5vFLc8/iVaNvsDsgMWA3hj+GD0SMNj3Dfhdn9TGWhV/6+dnY4wvEVPTjx
        mhOexhhBd/fqpR75MsBA7PlItZcJCeGtJq3LCkLaLL6JUZueWzjYi91yAjPYOm80
        fsmWf2nJFQshQvDRSGy+FP1ADB5S4gmVSsrNu0vsK9v+oQaGxWYwARatK+1ExG4P
        GxjiulwepTnmbSHiK07g3guWYlBvlMwQVsutBSQvHpj+spy2kHZJKIj/rAG6N3f2
        HftpQ==
X-ME-Sender: <xms:DbZTYrTZxqHBi12UjGcn0DxqPCHp1b_1B-AiuNkvkCgvG_SuVbWzMQ>
    <xme:DbZTYsyFKJs5MzPI5yCn4uHRfBkzYHJQ4shNbMQEvcZB8IZES0l67OAdk-Njw4N0O
    vuTHGSjkCgdtSQ4AA>
X-ME-Received: <xmr:DbZTYg2Y5q8kOfZOFcam_ZABdcDps87WHIVsZCtgFgCF9uI87DOm0UeNIFl3AJ-Foe9_-kZzZuL9kANZKjcU8GLh2tbLh-Y6KmkGBwHuNqCAeOYRQGGCxYvPzruk_qKIfNKKgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DbZTYrDXqcjk8JATPB836J7RVkbL85HOYcdtMW-5oNQVQOIYt_PJOQ>
    <xmx:DbZTYki6nLrQipo1VDNW2L3z_FcNSivDbexyHZJUK3ss3XwtCRumyw>
    <xmx:DbZTYvqcXu97qR6Z2PnI_R7A2EVgqrXG5_evXmUGtyEIXBqiDZ54nw>
    <xmx:DbZTYnNEpB-jgaQez46rBiXST_MzTOwfkH2ksu0kQKyCLfI4V_pBcw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 01:01:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi-ng: sun6i-rtc: Mark rtc-32k as critical
Date:   Mon, 11 Apr 2022 00:00:59 -0500
Message-Id: <20220411050100.40964-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because some newer hardware variants have multiple possible parents for
the RTC's timekeeping clock, this driver models it as a "rtc-32k" clock.
However, it does not add any consumer for this clock. This causes the
common clock framework to disable it, preventing RTC time access.

Since the RTC's timekeeping clock should always be enabled, regardless
of which drivers are loaded, let's mark this clock as critical instead
of adding a consumer in the RTC driver.

Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 8a10bade7e0d..3d9c9ce5a3db 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -241,6 +241,7 @@ static struct clk_init_data rtc_32k_init_data = {
 	.ops		= &ccu_mux_ops,
 	.parent_hws	= rtc_32k_parents,
 	.num_parents	= ARRAY_SIZE(rtc_32k_parents), /* updated during probe */
+	.flags		= CLK_IS_CRITICAL,
 };
 
 static struct ccu_mux rtc_32k_clk = {
-- 
2.35.1

