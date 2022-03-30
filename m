Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8034EBDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbiC3Jne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiC3Jn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06C2662D4;
        Wed, 30 Mar 2022 02:41:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D73AC5C0158;
        Wed, 30 Mar 2022 05:41:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Mar 2022 05:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=YWVHnruhGewAl+
        Paza8ux9+8q9vmzM2dPPEB/fzt7c0=; b=E5C2HdR/FlAderKdoGOBPfDi/WNO5k
        bIecBPJUWBRxl/8gNePkVhI3x9WtaHCzOyvaSBbj4Kr9yk8yj0wrCzMZNhIfVXRg
        JOx7P4wYH0ej3J/sw6wq0LucDdU2OybphkF+xR9T47L9ittc1wOYNbVoOuB5bBVL
        OwYqiTaWYu/VVGiHl4+PGN/NKYlI602Zc3eXRLPCdiyvVIYB0iru9Qxc5D4bW247
        1up+y7BEHZ+oREmLE5GsdEF5xtrI8kCnCRwvWyfghC1F+yZpSpUmNzwlGzWVdK1l
        sZGG8F0C3COinfnR7Wy75uGMfHdlwDRMK0k8gsAJLq45yA6ztRmqq3hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YWVHnr
        uhGewAl+Paza8ux9+8q9vmzM2dPPEB/fzt7c0=; b=R6/9NKnVlmd/jk5uyPkt2m
        0i26wa7RHZ/FhxMlhsJfOI3rcvI//wtbH/98vSeKmFOKp2j8H5MVnjnq/MURriBq
        NzRuYDDYkFAOVCyRYGJ1q+6VKMTEI1Y3ssxocxh7rDyIKKhidKoo5aapQ7WUKxoO
        C5fp7cfueY0vrot0V5uyiSWHtnqU/krFe5lw4gxjLwvVW1gcE+FmcyiItdtJ638L
        8VLVKiuaIt2JLvzoKNXfj02tgiTAQVT0rJl6rmR1SI7kdV8yAZnR00wQdz/CK07Q
        A17bMWkNPp/5u1SjS/Gqo/9Dx2NhnaUEo2+2O5OSOOQCr1j2PsqkLOHmZWQcNhOg
        ==
X-ME-Sender: <xms:1iVEYrtAPfWYnthrsc158fcZX6_LP3dmsCtUwdSrAmpkrYJtlofcZw>
    <xme:1iVEYsetlpEk_8RGlw449b5rqfq0HGlxPfgusV1a1N_VE4lap7YJURiI_hhoLPPYH
    uUF6PL_u510pXYT-zg>
X-ME-Received: <xmr:1iVEYuwfHRoulwspFfBCnLxIwj8zudQHEiLgf36RCpQ3kRycbZqW1h9RpGGl3XRyUp8K9hLRFt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:1iVEYqMLiKN4HGwn542S_D6JE-HwttETWy1cwc3x7zvYzGmozuwZ3w>
    <xmx:1iVEYr8q6Sv2LZRuqeZP6Ws9imr_iP-ap9LtwGXCbi5DyACdA7aiAQ>
    <xmx:1iVEYqVpqbmYaOxOJPQGnavlG8NESEGuJw2xJ4pI-SN8Utnz0qIFVQ>
    <xmx:1iVEYu2INBFciDvhdTHwu472dKSFC1PTz-THH36C43Ysy1fLWROVoA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 05:41:36 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-hwmon@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        amitk@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v20 1/4] mfd: silergy,sy7636a: Add config option
Date:   Wed, 30 Mar 2022 19:41:23 +1000
Message-Id: <20220330094126.30252-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330094126.30252-1-alistair@alistair23.me>
References: <20220330094126.30252-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a specific MFD_SY7636A config option.

As part of this change we can use MFD_SY7636A as a dependency for all
SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
it no longer needs to be selectable.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/hwmon/Kconfig     |  1 +
 drivers/mfd/Kconfig       | 12 +++++++++++-
 drivers/regulator/Kconfig |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..74b60d24e740 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1693,6 +1693,7 @@ config SENSORS_SIS5595
 
 config SENSORS_SY7636A
 	tristate "Silergy SY7636A"
+	depends on MFD_SY7636A
 	help
 	  If you say yes here you get support for the thermistor readout of
 	  the Silergy SY7636A PMIC.
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..c47cb755757b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1095,6 +1095,16 @@ config MFD_SPMI_PMIC
 	  Say M here if you want to include support for the SPMI PMIC
 	  series as a module.  The module will be called "qcom-spmi-pmic".
 
+config MFD_SY7636A
+	tristate "Silergy SY7636A voltage regulator"
+	depends on I2C
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Enable support for Silergy SY7636A voltage regulator.
+
+	  To enable support for building sub-devices as modules,
+	  choose M here.
+
 config MFD_RDC321X
 	tristate "RDC R-321x southbridge"
 	select MFD_CORE
@@ -1202,7 +1212,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate "Simple Multi-Functional Device support (I2C)"
+	tristate
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5ef2306fce04..c8ce6e5eea24 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1219,6 +1219,7 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
+	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
-- 
2.35.1

