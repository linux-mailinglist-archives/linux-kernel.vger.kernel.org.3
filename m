Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B23466334
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357677AbhLBMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:13:17 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39893 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357744AbhLBMMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:12:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 392D1580337;
        Thu,  2 Dec 2021 07:08:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 07:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gp4qntKo27gpb
        4ncTJpcYD5+aSMDhGRkVYBCdPvwrYs=; b=cxT3cWkS4BBDHHStro6DyzZmBnvaw
        Ex6s9FadPrpBaCpP2DrvDjq/54QJtMafiRDFpjh9bDY6C9X5CQRLMzDZ3GkfliPV
        xDeRBT1nKw/MOST2CzpstZzLpuGPkM+Xmqligrz8OEYqF5ByRDM5fApdJ6MQx04q
        BC26gw6V1gRP2xJXI7XYcSgHltawbRvoToWAo4SavJevJpWRsJzPOGuYpxS2XSDz
        Xjb5eAs6z5sdIz/v/ovwR/jlyHEJVaudXolg1cg443W2UnFPtEEad7PeU80cFTRC
        ZdukK39Om+jcNmDnM4LwfztaeI6wbHo+Xgo1+pzcvSsQ9eMfroTIPoLYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gp4qntKo27gpb4ncTJpcYD5+aSMDhGRkVYBCdPvwrYs=; b=Z9SPO82Q
        FtRUDOypvZPynhYZPqA7BY2yEIhbbL1KlSutQlLhXfxUV0+cIgK9Zz5DKVovohrP
        25mja0XRYK+uleJICNTRSQotZaf8hCCyyMS/R5x3i+At5F6ci7MyTy0mcm9EkvHc
        KvkNNbpmRv5DbQaXN8WINBgJ4adrRw6rnVRv1YVpjB8sdr2Cz6pLf+2CoIt7UPRV
        W9M1z2Q+xKAo5BKiPeaTAfeoLnSC4VyLNpglT79ujHuz73GL5htEjwgZYub8jifa
        7FQ2qgUHy7lUj87ainnmCPoVJ13CvuRE0Gl2gHEtAlPjMa9KbV9JDm+DO2wJ9TEb
        tMajDyYzgrGowg==
X-ME-Sender: <xms:RLeoYWsdCZnj06KYMa6gNbsxcRKtxj6DJD69M3xuHeExfriko6DEpw>
    <xme:RLeoYbfE6Yko6rY7rg6Lv53LVNg9hNx8qEBGpTPmguPM4qIC1665IqEpN5E8q6wnv
    X4Plv7EEiP2e7_VTkU>
X-ME-Received: <xmr:RLeoYRyEWcGmD2Y1j00_2nc13pxmktZ8BoeX2B1cipsCzUDdAL9vwTxkdWO_bxZo_VdXehSiP6hnSGQGeABraZzp9C3l4JeaRmjdNEOcyKhZilE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:RLeoYRPUgRZuNuw9lmFAbD1pGiZEJFKgWWK1kkpUH0Vr8mrskfiDlw>
    <xmx:RLeoYW8imHFWsL_hHd4-s-R0Trj3M-SbVulNdyL70WmMnGWRIBN37w>
    <xmx:RLeoYZX_8I1x1oh4WK0uXNR01BQahoIMyo7uAhsdL6-dH6WAF3sq8Q>
    <xmx:RLeoYWNmTDkpWrsG8a6pNFJWY_Q_jKa-Iohl3RFL7VXyWTAxotqfRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:29 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 4/8] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Thu,  2 Dec 2021 22:07:54 +1000
Message-Id: <20211202120758.41478-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
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

