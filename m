Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1B466328
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhLBMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:12:52 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48075 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357731AbhLBMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:11:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 83EF858032F;
        Thu,  2 Dec 2021 07:08:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 07:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iCdKz1fAS9RSq
        r6MdMDps0wFHMwgQu8juRHJqY1g5io=; b=NwLVO+RJDjkGrc2KeKaXNOe+m7rop
        SQWwBCb31Iw0pvd7GP7a7ZjXodsKotr4l5N6jmLxwoxgay4Ye8WvaBJFhjM0bLQt
        B+RrDGpTNUsP/mMai+slumi2KRi0/mUdnQj1zt7UuK/Nx+SFVfR7WeKBGT5rkuiF
        FVk0I4OZ9tlsgmwl8RajGs0K2UCYYWkQ49CbFxR1tZk6Kd1An2TM2kRYQZutJP9w
        kUG+cTmRwxbP8pjZ2m7O+XuTdSmpUa1leBeiH/OB3cCqdnDgcHFIwP5tibfDwZ79
        YbyxuiHfM1qCp//ri13fOnZ+kX4EGdzSKxziZ3gYd52HJZHOucZgxmCBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=iCdKz1fAS9RSqr6MdMDps0wFHMwgQu8juRHJqY1g5io=; b=eylTYX9R
        1oZQjgdC+6yoYSVMdCaiNsTpW/v7UZMEgrcIKa2MzYzqCGEDFtsYn0UGxH07188c
        JslPKQmQTiffva7fN+lFZ+IYmyp4N0JbyC48wHAt1zqxLaSIzH0KKRZ7QnmzpRwO
        S2J0abt7qClZEqEoLD8VzSxCjD8lrCUlV4njjIEjLgiGYnkVBOLIc1+x12qDa37j
        joAdCAfTX0Bf990xsBwFCtCBM6swXJidSH9KkRfoN0rqh39STodu8a/CmzPkiTrW
        xeOQPvLffkuK+Iytvm9o7/Ul2sZik/VAd7z52SOOfbFIhwXz0vl6OOP7AltKhgva
        6fUF9J5RvPWLYA==
X-ME-Sender: <xms:PbeoYRUwA0DYDEd-ipdUyZ6qlRlSiMSgxLC_IZ-BHZPC9krkN2s7OA>
    <xme:PbeoYRlz4O_EzQNtl3oaVXGi5dy8lH7Ys-ZLxnNz_i1JgMKQRDvBhUIe9elE1t5E-
    yM2yo4gUNO7AV2bDCk>
X-ME-Received: <xmr:PbeoYdbPZYpXD46CbX6kDauvKaEJAM6egYKC0Y9s-SAQWCh6wxHAi7RNiferdCmCF5DCx3Y1CiK-zwHTvZl429ht0rmxT3o7bV7kzz4NK3JwAxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:PbeoYUUuP9gYI7-y2JviTK9DmdJsqT3VtAHoQPnoLb5DY1qcln0SNQ>
    <xmx:PbeoYbl1WJBj3_cYRFRmjsPAwOugPLsTwWs1oxTo5-snkD0tdO3XUA>
    <xmx:PbeoYRfy4GTgFHL1EryOXmpj19sfYQF0uwXeeyYMwLN3XpWbSQzZNw>
    <xmx:PbeoYd3huHBQCr0KNQ4oEh4P9YUG0hEM338aPZKotMDNhf7tO71N0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:23 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Thu,  2 Dec 2021 22:07:53 +1000
Message-Id: <20211202120758.41478-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
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

