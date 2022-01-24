Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A39497EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiAXMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:10:51 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35445 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238472AbiAXMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 49142580355;
        Mon, 24 Jan 2022 07:10:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 24 Jan 2022 07:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=iCdKz1fAS9RSqr
        6MdMDps0wFHMwgQu8juRHJqY1g5io=; b=tC9OKnSnl/fhfkdwHftdcxVStMD3qw
        0AqfNaq2gXfJuefS/XgoWGknnXkjt2IevzUl6TneM6B6jQeZVQ88BUHlgEK+Ka1t
        jxGjqXu27D5JNd8jlVcPqBRY2suN1JwzLRb41SHQOvuLwPAF0VQsDtcZ3japcdJ7
        0r1qt3CnPlsQknHzLTUl84b6YIAdv6Ro+4b1eVex9YSAsqgmsxwUxTZ7chSnpL0z
        MGlfMEXkkgQxluOS8vgwcXQOQNx9MUnVC6OmFK5CTLML4eIyA8rWeQe81ExS+l8H
        i49gSPhdWc2xvRs32FriNF/AmxJ7YF6vYyGxI3SWFq6wFwmeNuRlzzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iCdKz1
        fAS9RSqr6MdMDps0wFHMwgQu8juRHJqY1g5io=; b=MjhIC3VlaI5jQlDUqsjtsa
        DJZxRG5NWiZ1tzlaP5ZY3KrKe1SM60m/1uFbav9DhGuEKETLOdX9hfsUQVdSU1lo
        yzpFNAr674IPCPQiyzjKczaGUK9u8SRz7l6VUCwhaHfn8DCOPs8V2G584JO6j31z
        5Aor3pq65XacT7pKzjabb27LNuvo1K+Bttb4op1CqdonYX1ZSQlJ3Xi7ozhT9eRb
        cPrgNwtUAFJEjakDBF+uqON9G2h4S2bfhE2bXoG/8I2tIcLNmsJa5BIC5FiPnlwp
        psNXjeAx+eV5xVnrQQGI+57SUcNKxFPkUggYWEwPm0Kz8cotf/SgnG2FkPQRlC9Q
        ==
X-ME-Sender: <xms:PJfuYVq7FboRXBrhHNAQAIuC_De371G8JlQTnAKbrrRjzD52hAYdog>
    <xme:PJfuYXq9gcwbUnd6EGQoEJPqXwW8rXuxtSeMwwHbV7JIy5y_5cyKhqOQJkyGmHP2m
    ZITo2KU2RansnAl7ck>
X-ME-Received: <xmr:PJfuYSOhURMg4Id5eKJJOgvaP2WGTJg_FP3-7JhXEijXGyVZQ1efqRKrhezGtMeJNK866XwO2tslAyxpeEE1S95dpDJoOPXLcfhQpvL8eV4X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:PJfuYQ56rrv1Aili_sF7PO3Tu1Uz8geolVe3Ujg9O_bQOM6g5A7KWA>
    <xmx:PJfuYU5QHpDAHVhB4df0JrW28FNX6wOFc9q7LAQR8INorWMrOcSnnQ>
    <xmx:PJfuYYjh3MVUXpzyValax4VrhIi12c4MIAKujDmW42Z0LsGCsG7b-A>
    <xmx:PZfuYQoFsv0F9NTCsf5l2xYrjCPM1MEb1vWkU11_UpbFm74oh_eLag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:30 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Mon, 24 Jan 2022 22:10:04 +1000
Message-Id: <20220124121009.108649-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
 include/linux/mfd/sy7636a.h  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 51536691ad9d..f4c8fc3ee463 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -62,8 +62,19 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
+static const struct mfd_cell sy7636a_cells[] = {
+	{ .name = "sy7636a-regulator", },
+	{ .name = "sy7636a-temperature", },
+};
+
+static const struct simple_mfd_data silergy_sy7636a = {
+	.mfd_cell = sy7636a_cells,
+	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
new file mode 100644
index 000000000000..22f03b2f851e
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Functions to access SY3686A power management chip.
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ */
+
+#ifndef __MFD_SY7636A_H
+#define __MFD_SY7636A_H
+
+#define SY7636A_REG_OPERATION_MODE_CRL		0x00
+/* It is set if a gpio is used to control the regulator */
+#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)
+#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
+#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
+#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
+#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
+#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
+#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
+#define SY7636A_REG_FAULT_FLAG			0x07
+#define SY7636A_FAULT_FLAG_PG			BIT(0)
+#define SY7636A_REG_TERMISTOR_READOUT		0x08
+
+#define SY7636A_REG_MAX				0x08
+
+#define VCOM_ADJUST_CTRL_MASK	0x1ff
+// Used to shift the high byte
+#define VCOM_ADJUST_CTRL_SHIFT	8
+// Used to scale from VCOM_ADJUST_CTRL to mv
+#define VCOM_ADJUST_CTRL_SCAL	10000
+
+#define FAULT_FLAG_SHIFT	1
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.1

