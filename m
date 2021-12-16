Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8430D4771AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhLPMZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:25:56 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56713 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236580AbhLPMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:25:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0BA575805C9;
        Thu, 16 Dec 2021 07:25:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Dec 2021 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iCdKz1fAS9RSq
        r6MdMDps0wFHMwgQu8juRHJqY1g5io=; b=GChqi+D8cj4gCtS9IhMGdER0Zo9Kp
        3kCnbrN4osG7pFZzDsXzqhaY971aXRRCMl/vYHiZ6rQiwg/HMu18eKFWBXSlJP3g
        r9nHvdkPq8BzzCIuXHeSSCzLLR/u6ZsdjhEtFWMm+SZls7QbcubbOFrw5HLYeJOL
        GN3xJWNQgaLxaG317tTaM2d6D7vunPbkuoROGmBt3DrOcI1g98RM9egtOzOYcoFL
        FKcl9QSVWl3ABgXyKSDr9eueilLld7Y122iZenlgO83Cx9T+6Rc4gG01v4LPWu5L
        Fi+1vOz4XkVA3DT71fhCDdz4SnNoF4xnaEInQ09hBselts5VLMmNgSvnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=iCdKz1fAS9RSqr6MdMDps0wFHMwgQu8juRHJqY1g5io=; b=VS9mYzdG
        glPWYoGDjXw91bOZe+zh3xvXJGYaW1OwjSwFHEzBCb+DjH+uv2RuiBfBnHDT9nxu
        LdIyEZ2kWMek6yQXgjKTd3UZsRymywB7MRcf+3OJlmFEjOv+EkHpJwUY0yS4jMmP
        QAiq4wdQy0hFCUXRhz6C4bOYKReARdsozwfb78fp/EWNqwTegORJV2eSVmoP+8Ia
        3jT2mslW4MCGpM65dRkL1jCImiW+MZr+mRUbRmk5DPpqFkUWj8S5nuFABqpkw339
        Z453VaFfk5OoItF8PyIkZsfUaKy7s0rG9F4gXTBpQt9K/jF1YMDewjPlKCRBqEdz
        LLo9Jl1OvMDLKA==
X-ME-Sender: <xms:UjC7YQyDwnSFiWrwTBvWj7NWNl22XT1wo9tZFES_MdCsvPxzKsdJaQ>
    <xme:UjC7YUSwlPfjHfUfJivQILVLwK8vl-BpF0dAc4wDx1Ioa1LEwxTjNLHuxAZLvuLTN
    inbv5Nmox_Wx2AWeRs>
X-ME-Received: <xmr:UjC7YSV9vG4a9Fb2nfaB7IIihEFXeeQQRIHH9aOP34qcDKmEMNHFCDWYixF2Mbh8T2czl-KExUYGFkxkpYSf-dFA7inArnBl2sFe00LPxrP5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:UjC7YejyrzfDcj1CjIUZI4t6NIxTya5nGRUXnkhJsY0CpvzFQHlmww>
    <xmx:UjC7YSChSiTbM9Lyt7-RYbaYSDVatnWiErkrqeVpO5y1TYTdlRtMtQ>
    <xmx:UjC7YfL270pg-X6K-YdzpaLWmjjMfpiJRDN3WCwODrttSW1S6LknHg>
    <xmx:UzC7Ycyz6q2PW7Sv4UAgKSo-1BehkPAO7wqF3Ks-3yhtd5hc7_PFYQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:25:49 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Thu, 16 Dec 2021 22:25:20 +1000
Message-Id: <20211216122525.136139-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
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

