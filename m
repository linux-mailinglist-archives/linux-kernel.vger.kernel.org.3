Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90995497EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiAXMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:10:59 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47813 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238940AbiAXMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B93F158035C;
        Mon, 24 Jan 2022 07:10:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 24 Jan 2022 07:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=2vNSWDzHD+EnJU
        o4FEA3VIpc1U/nFYsPa1ZA7cxtu88=; b=i2PzK9/i2SitTFv6E0z3aBq22vgSfy
        QL6pmz3mzaYdK0JVbeUKrPQJtxsUVjqTjf+BHv6P9l30KuP0ZCtcKxe5CggA1/cr
        nn0taX5gx1cgVELGBHsXwqBT7eRz2VbHIUJAR+nAStkZXiVarpYtsRYo5GCbkM5X
        gAsmS86pJjmUN1rIA6mLa6kQHwF3Q1x33HDzRzxGwrFCbhGXksQ1HoJriUsQboQt
        eqW8j6l5Ks4IQz7ejjrDReozzP6MLeEQV6LPP7uLHTdC1OTe3TZ0vQ09gt6dw4Gh
        SaCjqNEQRcFsui9d7GCb5DHUt9OvdrD5tVLNENrld6MNreGrTIiaVcEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2vNSWD
        zHD+EnJUo4FEA3VIpc1U/nFYsPa1ZA7cxtu88=; b=A0WqUx8993EeYj9IVN0ETV
        nArUMGFnS9KkWvAxw718Vy69EwXKRtBNW+QZMgpTOfW7ypZs7PzzF8n2JJryARpz
        kmElmzpUmqhLNivs8Ms/Pi7NwBZcWvqFwatFdYFEnyNiion4M9V2uvTZbTGO8wHS
        bO/AWJ8umOjowikJhubGi+CuyqKvx5oEFNKbRASkk8Sju+9T5yHiY2NV1z4yvBlE
        YncURa1/yUnq7JqWX9nipd3oYe5BhDQB9sQrGOHuiCqrXe4TqYVAe1Si5fEpTfxd
        9sks6FYNf/icKzZS4qERAWV1KgP8r9K8Cc2MIEMzYHwI4xw9ES4fhFwRML8TGYZQ
        ==
X-ME-Sender: <xms:Q5fuYd98TL92Gm9wW-GK1i1SDcnNRFX2lmBEhaUtVwgyDOh5nrefSQ>
    <xme:Q5fuYRuhS_NEYXht0aXIAhb_LwqFsTHmIsn_w0S4D08AMYERTXTcIWSMtehYb3OAl
    Ym69cN8jll3g35fhLg>
X-ME-Received: <xmr:Q5fuYbAyNnA8EtHSbzx_W63bIt73qG7R0V-NljMlAhX5N2beyILYQQas4_0L5VeGwNPMcA3KjTsxRUK_Gmg-36-L8Ws_5IbcLih1vO-IouyC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:Q5fuYRchwReeNWJO937xbjVz32tWmd4ZUAaUZr_rlPqE4mFMxISBtg>
    <xmx:Q5fuYSOFbVBiGZDvVCKLtYPgtBM-MlMk2ZXdQWLm6TFuPj-DHZWq9g>
    <xmx:Q5fuYTm-aTvHoai7I8_mN5cq5mk-pdbW5uoehcnzYtlSFD3VduPPQQ>
    <xmx:Q5fuYXdAlgK9RklVSFu3rPOmVt5HUGNmn1xUfAXcrSs_-ZBbFElw0w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:37 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 4/8] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Mon, 24 Jan 2022 22:10:05 +1000
Message-Id: <20220124121009.108649-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
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
index 1c35fed20d34..25ae5f087ff9 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1208,7 +1208,6 @@ config REGULATOR_STW481X_VMMC
 
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

