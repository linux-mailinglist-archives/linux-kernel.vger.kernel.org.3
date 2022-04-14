Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C048D5002EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiDNAMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDNAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:12:14 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B9120B0;
        Wed, 13 Apr 2022 17:09:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B86E5C020A;
        Wed, 13 Apr 2022 20:09:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 Apr 2022 20:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649894987; x=1649981387; bh=EOJgXwczx3Vjm6TzLyaxLENE2
        ryJMOOvfK5s3AOiSPY=; b=JXvcQwatb7sNB8VTI1v7K7C4Aa8LvMyGJZr0eKAaG
        5m0NbE72ybXA0slhi/1dz6HZX3hNokgIxRAPtjsL3zxll0gOpigZxvz5j0vrQKnO
        LnyJfaw+y+ADddC3WDG/5+qbZ0MfvlCvdpnujXqOipfVPxDnt3oqQqXW8XueqmC0
        IDtkBIbqXmTfGRB2fDEBixp3pU5+9KNztrS3b6/0V2K+4eGuNOcKeLUgpPZwIqft
        qzDUPJky9V6nBQRf7AmoW9m+qWmxDtMNPusxjBPGw/9lcRUEp/hbvez0/SIpE0Tu
        AjxGuj/FWkZ14GpzAhZMRV7ZRls2A6CH2Oaf9DJy4YUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1649894987; x=1649981387; bh=E
        OJgXwczx3Vjm6TzLyaxLENE2ryJMOOvfK5s3AOiSPY=; b=e7EXW59Df3iBiANyk
        OQmUnZ8UEeHtqnsN9UBdjvQbSPwVYZjpky9YbIkLr1+FYmtPbm1w9TvSxJEofM4f
        Uq6OfL+eRJvuzIIXeUx/aWTgO7DaZxUVlyhnJhKnNESCWNkBXJ/K/NLOuWBem/OP
        Uupqq+ml+lFHH3riGkvymEhqaj9tc0/KKhr0hFkpjKtQ4zbUSg319lqJLdgCcXHl
        mqiOoqFHLYNO/ezIJVRYEhBlJpLFagdjgiBL7PELD8COgQkoNZVASZB+3pF+6uwa
        Ml9GPxSGESnod1rsYyEZU6kvP2uqQQSID7H6oc2d9zAcilCzJvdUY4XqozIxI5hQ
        kmPYA==
X-ME-Sender: <xms:SWZXYjqsJQRME26XZdKplHgNSPjoABGmCKLhYZtJOiGMpe1jqoJSHA>
    <xme:SWZXYtqMNPa3Th_CkLCGlAAEhICGS0qxm7kLr7T1gssTPQ7017z9zVzAl4LhKhDl_
    RtN5csF4hdFCD2RZA>
X-ME-Received: <xmr:SWZXYgMtROeWTgCI1BEdPV8jkITAxcL96omh7QI4QdpStPC9AMK7CfF7M0fgbVY03S3N8eijWfJlFt9BGEuGMJAaQmu2u_bSdz2eakE6lkF1XsE7eFPAhIXo9fG1g2lk0Xa8YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:SWZXYm5IHxa4Ff82jsI8C7AviOP37U98R-PORU6GlhfI7rFXO9AWdQ>
    <xmx:SWZXYi5vEOxs6yFcWGxWTT4DPlVzBVuHU-w6SB-cJtSUAYC6efvFeg>
    <xmx:SWZXYuhGMSpgCdk4qw4PoTUFnGvP-NIf5oQNm-zlicbF_t7V48ueAw>
    <xmx:S2ZXYktctP2op4tCR2gNuqYE-rxE_Kjo4bTOtcM_DYuI8BQueX2KEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 20:09:45 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH resend v4] Input: sun4i-lradc-keys -  Add wakup support
Date:   Wed, 13 Apr 2022 19:09:44 -0500
Message-Id: <20220414000944.43388-1-samuel@sholland.org>
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

From: Ondrej Jirman <megous@megous.com>

Allow the driver to wake the system on key press if the "wakeup-source"
property is provided in the device tree. Using the LRADC as a wakeup
source requires keeping the AVCC domain active during sleep. Since this
has a nontrivial impact on power consumption (sometimes doubling it),
disable the LRADC wakeup source by default.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
  - Only mark device as wakeup capable if setting the wakeirq succeeds
  - An entirely different, but equivalent, DT binding patch was merged,
    so there is only one patch left

Changes in v3:
  - Dropped unnecessary pr_err in platform_get_irq() error path
  - Dropped patch 3 (DT update) as it was merged
  - Added Acked-by/Reviewed-by tags

Changes in v2:
  - Add requisite DT binding change
  - Only add wakeup capability if "wakeup-source" is present
  - Warn but do not error out if setting the wake IRQ fails
  - Add "wakeup-source" property to PinePhone device tree

 drivers/input/keyboard/sun4i-lradc-keys.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 4a796bed48ac..781f9b053115 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/pm_wakeup.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -226,8 +228,7 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 {
 	struct sun4i_lradc_data *lradc;
 	struct device *dev = &pdev->dev;
-	int i;
-	int error;
+	int error, i, irq;
 
 	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
 	if (!lradc)
@@ -272,8 +273,11 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	error = devm_request_irq(dev, platform_get_irq(pdev, 0),
-				 sun4i_lradc_irq, 0,
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	error = devm_request_irq(dev, irq, sun4i_lradc_irq, 0,
 				 "sun4i-a10-lradc-keys", lradc);
 	if (error)
 		return error;
@@ -282,6 +286,14 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		error = dev_pm_set_wake_irq(dev, irq);
+		if (error)
+			dev_warn(dev, "Failed to set wake IRQ\n");
+		else
+			device_set_wakeup_capable(dev, true);
+	}
+
 	return 0;
 }
 
-- 
2.35.1

