Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65872500268
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiDMXUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDMXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:19:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF6220FD;
        Wed, 13 Apr 2022 16:17:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F1F55C01AF;
        Wed, 13 Apr 2022 19:17:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 Apr 2022 19:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649891855; x=1649978255; bh=tSItXHrLBGUs0XQQKjEhwuPtZ
        neu6+UIkfbjKrNGmVg=; b=vJa5eSRn1eWA9g9V/7EuRF+K+uCmBh4GtXhDoMRXd
        P39S0dSPX+fnwvGsWxlRbmV8alijOSmIGYeZ2IbzJThnnz4wHNoufY5dK6N4rfE7
        TrxxCTl24HSzUu2Hsc7zmVO5YEUaYfEiN7RiXMLfp9kU9HAFHNccVohuCSh3BDjC
        i0/AZKwtOmpT8aMCWRWGsQZbeH/5LtXH/xq6sIOxBvkB0ex9ErUMpUEAYrTYUSoD
        YWj6RZ7+Uy1H7r1Li1/UBtmNyuz0zHhBxsrCUNh5QdqlHQibQzzvsta52aQeF5eG
        DxjIEJ0f94vsqG2U0oJHRler3VkUis//TlgBQET6qGhHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1649891855; x=1649978255; bh=t
        SItXHrLBGUs0XQQKjEhwuPtZneu6+UIkfbjKrNGmVg=; b=kEeM1zYFMo+TuNHId
        ZD2DuLK7heKqI6EpgMSY8/EYZMw+ncUPywOi/ZWcpgmDK3zPHGAvy0RIWdvni8ef
        TjNQ9vjlW9ZcLkwbxwxEJ8SA5L7RBk07K4D0QdhXZOWcoS2eSIJdTwJY//HeASGp
        paciplQWXR51UrMmLesiqgpXiGhCLeUg7qf8GmcgKgbb82VZAmYw6VafX0dGro4p
        nn2VxAUxnecVHyAJNKBU7tUN2hoGNdAs3a0kfLJjXeHvcb1NmQWL4XTxxxgsmgu5
        vpAHaAuq6eNxEiKTrCWx8k99moogtVuB35Rbqpx4IpmGl0gfBIF5LKlbN1wIfV4z
        0Z49A==
X-ME-Sender: <xms:DlpXYqtk_m3XQYofEduY_QFiACCgbvuS8EofE1ac1XjQAJZ52dwGWw>
    <xme:DlpXYveaXMOd0DQjWPxjI4bRi8HqiNE7I_o1i51TwuYir-cTQ4fs76R0zi9CyPGoZ
    FloUEL1JaN7k1Tb_Q>
X-ME-Received: <xmr:DlpXYlw9vGYUPfZ1tJIzH2cuoNsMxufAgpZlim_L33Z0VV0xh-0_yJfWpkcTTBUrRsseNr_2EZHPCHu3nU3w6RZLLpTD6BUhuY6cx1lIotZGN8_zhz5f7q9bNLusOkEEd7roiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DlpXYlM0-npvWJrT4SqgFD9WrRN5Dq7NVmZZajtGD_fZJ5q794B2fA>
    <xmx:DlpXYq-dUpqK3Ff7XFSSPSq7yckssJMfEOYjM63hbVlfqasfcLfc4A>
    <xmx:DlpXYtX5Eo97c9Uzbp5TmiSbsIMued8wjG3bixd7R5dZ2ue7CwFXDA>
    <xmx:D1pXYvPQDh5qD2GYcO-t679xKKtOcvk6AaJgcafLqazUEIPcB73i0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 19:17:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] rtc: sun6i: Add NVMEM provider
Date:   Wed, 13 Apr 2022 18:17:30 -0500
Message-Id: <20220413231731.56709-1-samuel@sholland.org>
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

The sun6i RTC provides 32 bytes of general-purpose data registers.
They can be used to save data in the always-on RTC power domain.
The registers are writable via 32-bit MMIO accesses only.

Expose them with a NVMEM provider so they can be used by other drivers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/rtc/rtc-sun6i.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 5b3e4da63406..755aeb82a285 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -71,6 +71,10 @@
 #define SUN6I_LOSC_OUT_GATING			0x0060
 #define SUN6I_LOSC_OUT_GATING_EN_OFFSET		0
 
+/* General-purpose data */
+#define SUN6I_GP_DATA				0x0100
+#define SUN6I_GP_DATA_SIZE			0x20
+
 /*
  * Get date values
  */
@@ -662,6 +666,39 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
 	.alarm_irq_enable	= sun6i_rtc_alarm_irq_enable
 };
 
+static int sun6i_rtc_nvmem_read(void *priv, unsigned int offset, void *_val, size_t bytes)
+{
+	struct sun6i_rtc_dev *chip = priv;
+	u32 *val = _val;
+	int i;
+
+	for (i = 0; i < bytes / 4; ++i)
+		val[i] = readl(chip->base + SUN6I_GP_DATA + offset + 4 * i);
+
+	return 0;
+}
+
+static int sun6i_rtc_nvmem_write(void *priv, unsigned int offset, void *_val, size_t bytes)
+{
+	struct sun6i_rtc_dev *chip = priv;
+	u32 *val = _val;
+	int i;
+
+	for (i = 0; i < bytes / 4; ++i)
+		writel(val[i], chip->base + SUN6I_GP_DATA + offset + 4 * i);
+
+	return 0;
+}
+
+static struct nvmem_config sun6i_rtc_nvmem_cfg = {
+	.type		= NVMEM_TYPE_BATTERY_BACKED,
+	.reg_read	= sun6i_rtc_nvmem_read,
+	.reg_write	= sun6i_rtc_nvmem_write,
+	.size		= SUN6I_GP_DATA_SIZE,
+	.word_size	= 4,
+	.stride		= 4,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /* Enable IRQ wake on suspend, to wake up from RTC. */
 static int sun6i_rtc_suspend(struct device *dev)
@@ -795,6 +832,11 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	sun6i_rtc_nvmem_cfg.priv = chip;
+	ret = devm_rtc_nvmem_register(chip->rtc, &sun6i_rtc_nvmem_cfg);
+	if (ret)
+		return ret;
+
 	dev_info(&pdev->dev, "RTC enabled\n");
 
 	return 0;
-- 
2.35.1

