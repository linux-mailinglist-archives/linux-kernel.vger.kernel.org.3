Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A103C533C10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiEYL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243040AbiEYL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:56:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C03EB;
        Wed, 25 May 2022 04:56:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 447E75C0271;
        Wed, 25 May 2022 07:56:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 25 May 2022 07:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653479769; x=
        1653566169; bh=kt7gBjbCcDTHFl2EAtfoonuQ7hMGpdwGw7NIY5UTUX0=; b=P
        yj2o+6t+1UKDCLtYYzx8uXvGamhGWb4KoqYy52GkDPUGg7Fh0DU6gpBeFfGMs641
        cSNjqo+cztjOhHcRexdwLDecionZNxsJIIo8GzmqXGcLAESancAjbyU1sfDOMuy4
        C3H632lmMudoHag9yzVxa6bGhpchLBuh4kk71hc8YSVOfPI4h5qLJdcXeWmtzvQt
        l81iLHJhzzuP5Hj4y4vu6dszJvJNtfBOtTw2EgYTFSxT4JVwXnPIoOxjiAWDheSt
        G9mfEPOXn76rxCFHDYxgvttr2epCs+HkbZVlALyvxUlkm2RUHRD4T9cQ41qebD5s
        74sEaTXBPQcoK4X4CrWHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653479769; x=1653566169; bh=kt7gBjbCcDTHF
        l2EAtfoonuQ7hMGpdwGw7NIY5UTUX0=; b=KrBhGVYz9uY+QEIb6uoN45eNRQGby
        i9VtYizyswbGnz6xENeCJ+2EL5gYimGQKbI3L+FNlLQTQZ4G8t4e0uZxbLL9ierg
        vg2Q9ez1W/dQ0YjVfRvhR5piZhDM3Z1P3Ap2FNiXlXLw+2I8Ke2EGeSNLm3YLc0a
        cgGao8kzSV9BoxokBgLpC5ioIw40fLOeCUafEjjhmI6J+6W4GN3iExrtBTZ8Mi5F
        jDC3DKyp/q1q+9wgITME7ynh6zgBj2CfPcl9xP0jpxfalgnCRXdAUMbBtJ39vzCR
        sSMvpTUY2b1Vr7tlYGsYrxXXE3DgPrrAGVIvNTk+ysp2zRv17DSUemLHw==
X-ME-Sender: <xms:WRmOYnHAY7tVlKx2oFUC_Woezp2T_XPoJrlQ8YTqPPiuIdVcuY1Q6A>
    <xme:WRmOYkWSgBZz1sPgpNIT_5HFcdP1DkJOmtlBXXG5srXMvOM_B9PYow289_VBOyXHn
    9ji-XaT5IvzxB1SA9w>
X-ME-Received: <xmr:WRmOYpKdJL2o7FNfIomwbgpX91j38lDh6SyA28h1vMd7U9Buzt32JQp6x-C4zfiIWX6ywmESQBtz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:WRmOYlGvo5EXpSo46PBEJ3sWCxeMjHWK9C77i4qpbjRkwzI1KFlhNQ>
    <xmx:WRmOYtUvJCvVWMxUicvrKx4aobO9xX6EJwmMTC1bCC_J9glF4OPe1Q>
    <xmx:WRmOYgNYpDA27uTi8MIYzbnEMKvH2F8xhTDHOOwqJkH7sgGeDV7HPw>
    <xmx:WRmOYkP8VnzZiaTm10OKHkjvwDHdVLxBPfFodfeEx6r1HiKRfJ_5fg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 07:56:03 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, lee.jones@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v21 1/4] mfd: silergy,sy7636a: Add config option
Date:   Wed, 25 May 2022 21:55:51 +1000
Message-Id: <20220525115554.430971-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525115554.430971-1-alistair@alistair23.me>
References: <20220525115554.430971-1-alistair@alistair23.me>
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig     |  1 +
 drivers/mfd/Kconfig       | 12 +++++++++++-
 drivers/regulator/Kconfig |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 590d3d550acb..a3a3b73b0a87 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1740,6 +1740,7 @@ config SENSORS_SIS5595
 
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
index cbe0f96ca342..25041cc2f605 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1236,6 +1236,7 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
+	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
-- 
2.35.3

