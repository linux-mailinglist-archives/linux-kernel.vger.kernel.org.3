Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ED05002FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbiDNA0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiDNA0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:26:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446721EC72;
        Wed, 13 Apr 2022 17:23:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A77305C02D9;
        Wed, 13 Apr 2022 20:23:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Apr 2022 20:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649895834; x=1649982234; bh=UX
        20EKkihaXFR6pu5BIT9N5isu1yVemyQBEm7qLnXTM=; b=tlIfJ8zhf44HVqPslI
        tmi6bD4D8Z/oy9dnNqpGqRAbI1cvqmVi+17zGR29X+Qz+9JtWHmquBgNO11GQsDv
        dbsXyqhwab/xcr5XmJLe290aq9Hy+vQ4N6zDWhgEiDMgWE3WpRE3WaPTdq/ofGZk
        HlFSVxc3cSXDaSLuoF/v+fvM/WX2XOXNKwNIOxcbdqSjIdcEiFInTBRUN8kQuLwC
        Io8J3tZsAwMDg1CquG+yNpAIoo02lOV8aloZZ8ZxL6hMtpOjbXPzqwfUt6ehfB1q
        Hba6Kq2f6hBqFm1l4GfPHJVa4Eup3Pg8h9HWqycOcrYGI/yovLficthOKafy2sdY
        Ln+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649895834; x=1649982234; bh=UX20EKkihaXFR6pu5BIT9N5isu1yVemyQBE
        m7qLnXTM=; b=dkenoMvsI7QjPiyaUzBeHoLYbRgzMX3BdkzHKcnms+wY76m4ULu
        GN3ijxMGOPw9MJSPB0V3S1WG1GWabBW+5CqgduIsBfrcpSKI311pvZbC9PWg6Fge
        biNuKA9kegpO/gdcp8vMp3MJ9L9pWKFVo7XOj2/adub6ZaK/9bQkTGTXzv/atwak
        yquaOtkeJQrXjpTreb8Lj0TmgrxVqWnmdu4sLOrNXoAyEaCuoXcTS/4fAFok4IiK
        toFrGbDJA6tuK7nGPLAf512qlzHJEwu+KzjDbDF29393U+YMQb9fB3lxl9EbM2AD
        1uhh0Wk2UNo0AzJvNGz7VqWp6wVQoRqlxVA==
X-ME-Sender: <xms:mWlXYjoUZaz0yj1f0Bb5mp76KjMjLtKnsy_M8Yk2dNWHY8t5r0hQxQ>
    <xme:mWlXYtrUo3CNXH8mRaBCwwmKEkhh3aPOgLu56F_rGCngQ-_nNttmJOTnyDdzGE8qF
    ML709UbaJCDsorsVQ>
X-ME-Received: <xmr:mWlXYgPVVWPCQKjBPEG42E1PS9afQIF5DQ-r97sOOdz13-WgOvyuhIdFEA5bue3LRySbPOYQbb7PRtaPBJt9GCZHDVviLSxLRIDAv9QoeYfB1CqqQToxsUvQEmn6rtBMDvruXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mWlXYm7Qk6YsDVZlIc2XGn87aoAuZ48rCKbZRwnjrokBf52UBBSeLw>
    <xmx:mWlXYi5X3n_afHEkMDWDbAmFvqedAaCb0nqYrR0WgZopmzOye1LKtA>
    <xmx:mWlXYugOTffaSMMU3DYSneYIYS6leKbepCeV3_pUnTl9Dex44ubD1Q>
    <xmx:mmlXYhRIQsrKfQSRxTtxEC1-_ZN_c25aIPvwwQpCpG2APR1y1rDqGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 20:23:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 2/3] Input: sun4i-lradc-keys: Add optional clock/reset support
Date:   Wed, 13 Apr 2022 19:23:47 -0500
Message-Id: <20220414002349.24332-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414002349.24332-1-samuel@sholland.org>
References: <20220414002349.24332-1-samuel@sholland.org>
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

Until the R329, the LRADC hardware was always active. Now it requires
enabling a clock gate and deasserting a reset line. Add support for this
variant of the hardware.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Guard the code with a flag instead of using "_optional" variants.

 drivers/input/keyboard/sun4i-lradc-keys.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 4a796bed48ac..5630334a6c09 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -14,6 +14,7 @@
  * there are no boards known to use channel 1.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -23,6 +24,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #define LRADC_CTRL		0x00
@@ -58,10 +60,12 @@
 /* struct lradc_variant - Describe sun4i-a10-lradc-keys hardware variant
  * @divisor_numerator:		The numerator of lradc Vref internally divisor
  * @divisor_denominator:	The denominator of lradc Vref internally divisor
+ * @has_clock_reset:		If the binding requires a clock and reset
  */
 struct lradc_variant {
 	u8 divisor_numerator;
 	u8 divisor_denominator;
+	bool has_clock_reset;
 };
 
 static const struct lradc_variant lradc_variant_a10 = {
@@ -83,6 +87,8 @@ struct sun4i_lradc_data {
 	struct device *dev;
 	struct input_dev *input;
 	void __iomem *base;
+	struct clk *clk;
+	struct reset_control *reset;
 	struct regulator *vref_supply;
 	struct sun4i_lradc_keymap *chan0_map;
 	const struct lradc_variant *variant;
@@ -140,6 +146,14 @@ static int sun4i_lradc_open(struct input_dev *dev)
 	if (error)
 		return error;
 
+	error = reset_control_deassert(lradc->reset);
+	if (error)
+		goto err_disable_reg;
+
+	error = clk_prepare_enable(lradc->clk);
+	if (error)
+		goto err_assert_reset;
+
 	lradc->vref = regulator_get_voltage(lradc->vref_supply) *
 		      lradc->variant->divisor_numerator /
 		      lradc->variant->divisor_denominator;
@@ -153,6 +167,13 @@ static int sun4i_lradc_open(struct input_dev *dev)
 	writel(CHAN0_KEYUP_IRQ | CHAN0_KEYDOWN_IRQ, lradc->base + LRADC_INTC);
 
 	return 0;
+
+err_assert_reset:
+	reset_control_assert(lradc->reset);
+err_disable_reg:
+	regulator_disable(lradc->vref_supply);
+
+	return error;
 }
 
 static void sun4i_lradc_close(struct input_dev *dev)
@@ -164,6 +185,8 @@ static void sun4i_lradc_close(struct input_dev *dev)
 		SAMPLE_RATE(2), lradc->base + LRADC_CTRL);
 	writel(0, lradc->base + LRADC_INTC);
 
+	clk_disable_unprepare(lradc->clk);
+	reset_control_assert(lradc->reset);
 	regulator_disable(lradc->vref_supply);
 }
 
@@ -243,6 +266,16 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (lradc->variant->has_clock_reset) {
+		lradc->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(lradc->clk))
+			return PTR_ERR(lradc->clk);
+
+		lradc->reset = devm_reset_control_get_exclusive(dev, NULL);
+		if (IS_ERR(lradc->reset))
+			return PTR_ERR(lradc->reset);
+	}
+
 	lradc->vref_supply = devm_regulator_get(dev, "vref");
 	if (IS_ERR(lradc->vref_supply))
 		return PTR_ERR(lradc->vref_supply);
-- 
2.35.1

