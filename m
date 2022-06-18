Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAAA550634
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiFRRFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiFRRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:05:52 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1913CCB;
        Sat, 18 Jun 2022 10:05:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 60C7D2B04FE0;
        Sat, 18 Jun 2022 12:58:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 18 Jun 2022 12:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655571483; x=1655578683; bh=f4
        9f/XjlWb6yUqj3Q/Hp+u61iLGTlIGKm84rPezAGeA=; b=F7ZvoNWp5VZB1R7my1
        1nyQrPuqRi13i/gcWPOfO3fPchclhyvS1jTDZLiL0d9HlifU35iUk+QV7qq2GqdT
        6xAa1nxLFFbYj66WQnNH6FEPpyFN1kz24p+jRAY0SeNztWSPvtwbKuiFomvLDWFQ
        0WgsC0aYK731Tc5zazhmLGpdpGpCknn4zqP/THGu7oqMpEqKZuKoIfgkoF+TDRk6
        aGqMmpsdCGrw8h54iUCZ0h3ACfyUd9+nTnGqEyPuznKkQC3XyxSl5D3KRLD4Uw4w
        fcdLWwLpA9YugSu5iml1ON53nt7IRYLg/5EtzORQbFzO6b3h1H+Bqsja84PJXqmZ
        Fetw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655571483; x=1655578683; bh=f49f/XjlWb6yU
        qj3Q/Hp+u61iLGTlIGKm84rPezAGeA=; b=r5/+ceDIvzxb7kt+WgJGFjyx4x5vU
        nCD7muVNhvQuNuCQYGuBAiTwQ1iOcqiBiW9G4DEfcNhJZXIhV46DDzOqksUPDJzg
        J2VIy7yQLmRZHprvGziWGlbGk/TjUqMl03hXAcIWHs9pj/PdHbJVDPjxehHU6e8c
        wqY2oZUuE0giFtVH1//hcULzDIbxjKVmJSV7/Js4g/9TtyAL8k2OrCMKdJvOvfAC
        IdAmR0nMDjnbj/1nQ8f/M6w6NtRV0v6emgYAUby6cHLAtlTaFZMRLQMkTAge1+oL
        aOmJdM+VCgb6Gxn8Arg+HxzLJ5jhcCNtbaHG/dlrAwv1bglEWI5v91Isg==
X-ME-Sender: <xms:GwSuYrw2eQxYe9dCDTx3ySVsO3itxE7E7-jFL9YfoHEdVXbMWar3Og>
    <xme:GwSuYjRSD_wd9oc5WYCWc9fxTkSD-P9X2o_0vVf_ctl3qe1Dq3ZxIk_9D5AmbDHis
    -JL2qd6fRUM_HPpPg>
X-ME-Received: <xmr:GwSuYlUQse3GXYE3H6CoEWMu0WGbIixLDhI8dt8jy7FDtsrHnnTyNPZzy5DjXDPkgSuKhCaI9okgQGQgPvBVCJ-0fw74yh4Xh6izEAB_yFbN2fRflM8gD_3b5cJw0S4ZWqAnog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GwSuYli-T1L7nmjjrkz6th2-FYNcavxz-OTArmN8LWYTaWNnlcY0IA>
    <xmx:GwSuYtDfWra6M1iebenJ_mjMuoPx3dqBcvJxFCxB3vc4TuSyfOTzfg>
    <xmx:GwSuYuLHbH7dSIJBSJKAgJOs_ag8bc1XLBV1Z1OUyTcvFG6UuDWFuQ>
    <xmx:GwSuYsVq4MBrx9tbgC26qiPKscBKM9412POnSBKB2Sn2t_usPso3VaRFb6c>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jun 2022 12:58:02 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <x@xff.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Colin Ian King <colin.king@intel.com>,
        David Gow <davidgow@google.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "fengping.yu" <fengping.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 3/4] Input: pinephone-keyboard - Support the proxied I2C bus
Date:   Sat, 18 Jun 2022 11:57:46 -0500
Message-Id: <20220618165747.55709-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220618165747.55709-1-samuel@sholland.org>
References: <20220618165747.55709-1-samuel@sholland.org>
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

The PinePhone keyboard case contains a battery managed by an integrated
power bank IC. The power bank IC communicates over I2C, and the keyboard
MCU firmware provides an interface to read and write its registers.
Let's use this interface to implement a SMBus adapter, so we can reuse
the driver for the power bank IC.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

Changes in v3:
 - Rename i2c-bus to i2c

 drivers/input/keyboard/pinephone-keyboard.c | 73 +++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index a021c9deee19..c22a1e306a71 100644
--- a/drivers/input/keyboard/pinephone-keyboard.c
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -3,6 +3,7 @@
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 #include <linux/crc8.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/interrupt.h>
@@ -24,6 +25,11 @@
 #define PPKB_SCAN_DATA			0x08
 #define PPKB_SYS_CONFIG			0x20
 #define PPKB_SYS_CONFIG_DISABLE_SCAN		BIT(0)
+#define PPKB_SYS_SMBUS_COMMAND		0x21
+#define PPKB_SYS_SMBUS_DATA		0x22
+#define PPKB_SYS_COMMAND		0x23
+#define PPKB_SYS_COMMAND_SMBUS_READ		0x91
+#define PPKB_SYS_COMMAND_SMBUS_WRITE		0xa1
 
 #define PPKB_ROWS			6
 #define PPKB_COLS			12
@@ -132,6 +138,7 @@ static const struct matrix_keymap_data ppkb_keymap_data = {
 };
 
 struct pinephone_keyboard {
+	struct i2c_adapter adapter;
 	struct input_dev *input;
 	u8 buf[2][PPKB_BUF_LEN];
 	u8 crc_table[CRC8_TABLE_SIZE];
@@ -140,6 +147,57 @@ struct pinephone_keyboard {
 	bool fn_pressed;
 };
 
+static int ppkb_adap_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	struct i2c_client *client = adap->algo_data;
+	u8 buf[3];
+	int ret;
+
+	buf[0] = command;
+	buf[1] = data->byte;
+	buf[2] = read_write == I2C_SMBUS_READ ? PPKB_SYS_COMMAND_SMBUS_READ
+					      : PPKB_SYS_COMMAND_SMBUS_WRITE;
+
+	ret = i2c_smbus_write_i2c_block_data(client, PPKB_SYS_SMBUS_COMMAND,
+					     sizeof(buf), buf);
+	if (ret)
+		return ret;
+
+	/* Read back the command status until it passes or fails. */
+	do {
+		usleep_range(300, 500);
+		ret = i2c_smbus_read_byte_data(client, PPKB_SYS_COMMAND);
+	} while (ret == buf[2]);
+	if (ret < 0)
+		return ret;
+	/* Commands return 0x00 on success and 0xff on failure. */
+	if (ret)
+		return -EIO;
+
+	if (read_write == I2C_SMBUS_READ) {
+		ret = i2c_smbus_read_byte_data(client, PPKB_SYS_SMBUS_DATA);
+		if (ret < 0)
+			return ret;
+
+		data->byte = ret;
+	}
+
+	return 0;
+}
+
+static u32 ppkg_adap_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_BYTE_DATA;
+}
+
+static const struct i2c_algorithm ppkb_adap_algo = {
+	.smbus_xfer		= ppkb_adap_smbus_xfer,
+	.functionality		= ppkg_adap_functionality,
+};
+
 static void ppkb_update(struct i2c_client *client)
 {
 	struct pinephone_keyboard *ppkb = i2c_get_clientdata(client);
@@ -266,6 +324,7 @@ static int ppkb_probe(struct i2c_client *client)
 	struct pinephone_keyboard *ppkb;
 	struct regulator *vbat_supply;
 	u8 info[PPKB_MATRIX_SIZE + 1];
+	struct device_node *i2c_bus;
 	int ret;
 
 	vbat_supply = devm_regulator_get(dev, "vbat");
@@ -311,6 +370,20 @@ static int ppkb_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ppkb);
 
+	i2c_bus = of_get_child_by_name(dev->of_node, "i2c");
+	if (i2c_bus) {
+		ppkb->adapter.owner = THIS_MODULE;
+		ppkb->adapter.algo = &ppkb_adap_algo;
+		ppkb->adapter.algo_data = client;
+		ppkb->adapter.dev.parent = dev;
+		ppkb->adapter.dev.of_node = i2c_bus;
+		strscpy(ppkb->adapter.name, DRV_NAME, sizeof(ppkb->adapter.name));
+
+		ret = devm_i2c_add_adapter(dev, &ppkb->adapter);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add I2C adapter\n");
+	}
+
 	crc8_populate_msb(ppkb->crc_table, PPKB_CRC8_POLYNOMIAL);
 
 	ppkb->input = devm_input_allocate_device(dev);
-- 
2.35.1

