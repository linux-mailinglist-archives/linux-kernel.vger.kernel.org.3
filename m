Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8413538AED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiEaFgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiEaFgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:36:31 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677016FA1F;
        Mon, 30 May 2022 22:36:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AF27F3200980;
        Tue, 31 May 2022 01:36:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 31 May 2022 01:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653975388; x=1654061788; bh=tm
        ZUhbGe1qgGOQi2mlcP7S/bCwsecr4Iiwm5l88IWmk=; b=G9fZCPXSeiwhKI5QOa
        xgOBhzyYzNLCWfOyrA3WPCXDCsqdiLohbnQXA6hyh3M0K4iI77NAiTr+H7Y4RocS
        JcmdznxXuOxjTN8Cp1xePMUwVZy4BKZVOjHgxk1E+UVz9NSMN9fIKe12FFUTXeQO
        P1d0X+sMi5IobV3MrhOQrgqH5w0k4QUwdLL6DcYrJLpR1o7eQm/spuIgGaDoeW/8
        ghK0p/cl4jF8fSheH5chRFCuxGcO7xmyP4j0pVRBJlLTN7g2umqQwq0NldVgTJ3K
        6MiW439zb53OqbfVzgeH/qghUs3Ucp4vD4jdL7Ysb51JPzwwCNJpP5x0A5MQuKu7
        rr/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653975388; x=1654061788; bh=tmZUhbGe1qgGO
        Qi2mlcP7S/bCwsecr4Iiwm5l88IWmk=; b=DmjzbFoG0yoS1pMqO3dSAl58MMhhl
        OxHBHOvqsLzuOXQcGfbNZiwv6s7a7QvDvh1zIdmLAndmqXATrX+yD3dugnHraAmm
        c9qg7f9HEBXgjVfykT/IjEAQrqk2vU7+SmldnutUF0BdHGhLNlJd366LxczImls+
        7wUjXETI04Y9lWwxm1yD51MkVhQaub97A1jR8Fzsmio66cSAwyyOGgDSKz6tcc9v
        11BUHHFgsbZExZTSD7AnTQ/9L9s/RM5cQpBPOQGDQpFl9pbO1dBxMo1/+4r5DiwQ
        CenXW99ZBScMGBsCeZf42BCIRWNfp0CNwQRH+SOav8A+OVtX7fqVlJitQ==
X-ME-Sender: <xms:W6mVYobQWXKMYyUNgN5nYhAWa37z--bpeKNQgaAeAhgwEZ2sjV1o1Q>
    <xme:W6mVYjZJFBmXG0dR8fmD-2FpAJ_37B8bVD4Inf1ZZ1-qy3gcj0Gm5a3qovErNWT-6
    LKxF9TL9ldqB9tS_w>
X-ME-Received: <xmr:W6mVYi8IkjA_H-ESKFAWFzO_FEBBx0S7WZjkNH9jT6rCfqJ17ivQz8D7Q_Okjve_106CSuJ-kKH6hH1WUwCYnkTP1lcCkQPh0Ywt803z386WoFbt8PUdTTLn1rz5w8EzzkarXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:W6mVYioiv3M7i97uK7reLadhiC5_E32MmD17SL4isMXvLbD1HRFffw>
    <xmx:W6mVYjoMDyiGZOLHdn3FX6xyDKCQmrAT-x9rgTvxXH2u3YRi95MvUw>
    <xmx:W6mVYgTtwqWV-IMNL737lofqriaCGHLCrCuez6YJpeXBclundxvR7A>
    <xmx:XKmVYhiX3_vI_lddwNq08KEVv3fqRk-_GNF1PUmNapRq4344615VmQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 01:36:27 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/3] pinctrl: sunxi: Remove reset controller consumers
Date:   Tue, 31 May 2022 00:36:21 -0500
Message-Id: <20220531053623.43851-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531053623.43851-1-samuel@sholland.org>
References: <20220531053623.43851-1-samuel@sholland.org>
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

None of the sunxi pin controllers have a module reset line. All of the
SoC documentation, where available, agrees. The bits that would be used
for the PIO reset (i.e. matching the order of the clock gate bits) are
always reserved, both in the CCU and in the PRCM. And experiments on
several SoCs, including the A33, confirm that those reserved bits indeed
have no effect.

Let's remove this superfluous code and dependency, and also remove the
include statement that was copied to the other r_pio drivers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/Kconfig                 |  3 ---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c  |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c   |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c   | 22 +---------------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c   | 25 +------------------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c  |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c   |  1 -
 8 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 33751a6a0757..7a7bcdc198a3 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -29,7 +29,6 @@ config PINCTRL_SUN6I_A31
 config PINCTRL_SUN6I_A31_R
 	bool "Support for the Allwinner A31 R-PIO"
 	default MACH_SUN6I
-	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_A23
@@ -55,7 +54,6 @@ config PINCTRL_SUN8I_A83T_R
 config PINCTRL_SUN8I_A23_R
 	bool "Support for the Allwinner A23 and A33 R-PIO"
 	default MACH_SUN8I
-	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_H3
@@ -81,7 +79,6 @@ config PINCTRL_SUN9I_A80
 config PINCTRL_SUN9I_A80_R
 	bool "Support for the Allwinner A80 R-PIO"
 	default MACH_SUN9I
-	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN50I_A64
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
index e69c8dae121a..ef261eccda56 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
@@ -24,7 +24,6 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
index c7d90c44e87a..487a76c45f7e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
index 8e4f10ab96ce..c39ea46046c2 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
@@ -12,7 +12,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index a00246d3dd49..2486cdf345e1 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -17,7 +17,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
@@ -111,26 +110,7 @@ static const struct sunxi_pinctrl_desc sun6i_a31_r_pinctrl_data = {
 
 static int sun6i_a31_r_pinctrl_probe(struct platform_device *pdev)
 {
-	struct reset_control *rstc;
-	int ret;
-
-	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rstc)) {
-		dev_err(&pdev->dev, "Reset controller missing\n");
-		return PTR_ERR(rstc);
-	}
-
-	ret = reset_control_deassert(rstc);
-	if (ret)
-		return ret;
-
-	ret = sunxi_pinctrl_init(pdev,
-				 &sun6i_a31_r_pinctrl_data);
-
-	if (ret)
-		reset_control_assert(rstc);
-
-	return ret;
+	return sunxi_pinctrl_init(pdev, &sun6i_a31_r_pinctrl_data);
 }
 
 static const struct of_device_id sun6i_a31_r_pinctrl_match[] = {
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
index 9e5b61449999..4fae12c905b7 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
@@ -98,29 +97,7 @@ static const struct sunxi_pinctrl_desc sun8i_a23_r_pinctrl_data = {
 
 static int sun8i_a23_r_pinctrl_probe(struct platform_device *pdev)
 {
-	struct reset_control *rstc;
-	int ret;
-
-	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-		dev_err(&pdev->dev, "Reset controller missing err=%d\n", ret);
-		return ret;
-	}
-
-	ret = reset_control_deassert(rstc);
-	if (ret)
-		return ret;
-
-	ret = sunxi_pinctrl_init(pdev,
-				 &sun8i_a23_r_pinctrl_data);
-
-	if (ret)
-		reset_control_assert(rstc);
-
-	return ret;
+	return sunxi_pinctrl_init(pdev, &sun8i_a23_r_pinctrl_data);
 }
 
 static const struct of_device_id sun8i_a23_r_pinctrl_match[] = {
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
index 6531cf67958e..0cb6c1a970c9 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
@@ -27,7 +27,6 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
index a191a65217ac..f11cb5bba0f7 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
@@ -14,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
-- 
2.35.1

