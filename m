Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298054771B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhLPM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:26:03 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40131 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236699AbhLPM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:26:02 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4AC925805C9;
        Thu, 16 Dec 2021 07:26:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Dec 2021 07:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gp4qntKo27gpb
        4ncTJpcYD5+aSMDhGRkVYBCdPvwrYs=; b=ni/FssW9YPh/WaRsu6P9ocZhTsSNk
        im0s+qe3g6tQ3u2/ejXE5H/juFXEAb0N8jBdJbRtt5gS+NhvRnKneoL4jSH/5L59
        lob/CWg7QPTDDFaIB4r+6G8e1zko12GXqXBeNhb32qjBEMQ8DkjkkdwmqdVOJR6+
        qHcJY4URr+3lR8f3yhOxxXjoDMEzOoN4EdOc7aiPb5xrlH+AauP0sCbxFAPyn/Ie
        3b6YPCvXjp4sXNO0brj+SFz7uMqqgxrndBERfgyRGUqK3AtMgsnoLPslSNA/dLip
        Ha0qQ0sOZSZp5kwZUNPnAB2YOAQc+ZtvVWIu9DT6Qh0WSeB4+9Fm4KoZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gp4qntKo27gpb4ncTJpcYD5+aSMDhGRkVYBCdPvwrYs=; b=CKh7jhUg
        twm6fn/a4DaerJpOOflr1n80x/9eROOsGCFWfYog1rsZvmX40T5CgOvrF/thj72Z
        EQXUV7IfAblkYCfOJL00rsTjVxePCTYlPW3uEaBYbdBnDmbRkwmZpCME9BLzcUYE
        tluRdL5RzU+d7hq5fVxtJv8oraUg/0O171TBmkPeWgMcea/vvtKXXrRKsCIakgmu
        LElmv6QZx51BHyp+VmKO7nZxBQKJ8v0Rr6Jx6E3XYaVA//yHQVE3jhiPvf0y5vAj
        VAHKxhsq602zOqSFmlCTjGOG8UImQyUSggE0uBJyaSlk9OHIN21PaOANBjTXfrym
        MuzELQFQN314tg==
X-ME-Sender: <xms:WTC7YSC1eUrtYosxFh62PY2U_wOs5BWulCYA3FrLBI148vvAke-bsQ>
    <xme:WTC7Ycj6AhA5Tm_IFHB-2TWiwkVIfboZr0T_diDs7E_HiIIhVGbWLhqFxa6bOu4gg
    urDB6z-qbRhXWrVM3c>
X-ME-Received: <xmr:WTC7YVnPVBYtQkFU8enfB8Rc7mbNWfAvcbWgvwUtVKmjINJ9lHEmrTmbWc9YTzOE9i68G45aYoP3IHcqfXHp7hsqEdgzt5rm69wSnKk8OZP_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:WTC7YQyrVU0gQijo12l0AiTswSQTRqpEee42Jb-i-fdow_hVYjOGDA>
    <xmx:WTC7YXRgejhe4jPRnbI2TmFQP2bmoKOUoxVJkG67sxLr9w4WFSAytg>
    <xmx:WTC7YbblmQLo6qtmBDcX29-5E4v8ux6J3GVB1V28z-lq_TSynfU8qg>
    <xmx:WTC7YYAtsml_LutxKMOro54AW9kPVgsbdFH4uJy-Wf9onwlrfcfWqw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:25:55 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 4/8] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Thu, 16 Dec 2021 22:25:21 +1000
Message-Id: <20211216122525.136139-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig             | 1 -
 drivers/regulator/sy7636a-regulator.c | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6be9b1c8a615..3e515a3fae73 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1199,7 +1199,6 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
-	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 22fddf868e4c..29fc27c2cda0 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -7,11 +7,14 @@
 // Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
 //          Alistair Francis <alistair@alistair23.me>
 
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/mfd/sy7636a.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/regmap.h>
-#include <linux/gpio/consumer.h>
-#include <linux/mfd/sy7636a.h>
 
 struct sy7636a_data {
 	struct regmap *regmap;
-- 
2.31.1

