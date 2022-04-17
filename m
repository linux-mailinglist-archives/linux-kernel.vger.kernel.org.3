Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7782504612
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiDQCT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 22:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiDQCTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 22:19:14 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9A369D6;
        Sat, 16 Apr 2022 19:16:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 83EB15C0143;
        Sat, 16 Apr 2022 22:16:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 16 Apr 2022 22:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650161799; x=1650248199; bh=6J
        gcVzNBocdJbfij3rAV6h60mZBiCIj+Qc5YuHgWbgI=; b=cE9RSajH4LYQcUxkMJ
        dgyRP5hOvog5xDEYesFct+5ocADpHT0dv9HUqvMd2VkVgpYt3vNDivB7pKDxnt0z
        3YsmOArTh4cxA6zyQ1jdtwLkbbPzGSt/X+z1S8F9SZgjRTNTpCcrZRxCaPcZHY+3
        4lfLW5m+laj82/A3nkleP8GPH9mRQ9GCLXzMVj1rOzDh5/OePcDBi6/JbrM2ZJvS
        fHUgb47D+8TJco+5RpD9RaGgrdI1d4TTzoS8u1E0CPF5XEAfz2pDcOvdO8fVidWK
        vd09X7hp35rvsxKoyBSpE4gK3mj67smC5ndSVlGKenqwK0iZrZvs37lW/zW9ZE75
        Te4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650161799; x=1650248199; bh=6JgcVzNBocdJbfij3rAV6h60mZBiCIj+Qc5
        YuHgWbgI=; b=MDaA9xmEhVe4Ib3J9sRM1OXLB26dbjVJdp7ngFFOkICKe6FEba4
        5YxnNbqVpzaqLvtG/0j52Gj0jZmVpb/js/Uz2MwDPSciJjrpu4f/VopFMlTbCvEK
        ZV9j3IveSjoi6Z55m8d7FrNCVg6CnVaji0im1RNeBonVUwQcKZRsGME6BGN5n9dj
        QTQZUMWUtp0eexDNg6ZdXGlRfPMVEBer1LrS2hx7qN3FYDrP8uBc+2BJiKy8a9il
        Jy2YiFLytNxhTvvtvXJQfDX5yCtEUAdUpr4fjE6RbZTZ5cmKOczxpRWmlJ30YmPJ
        yvFYqHhewDN0JmlZIBrh1rF0tdWzS9kGvsg==
X-ME-Sender: <xms:h3hbYnMalI8E4WURn06XVND6bhDqzXslljZE-w_wJ15iqBYVTdX2iw>
    <xme:h3hbYh-xzJWuD-v5taIBPYHkLHtpSOK_dgvSTXGugT_wQdN0Giug4A7EmH07dvjUa
    SAVU2ccdEEIe2QN_Q>
X-ME-Received: <xmr:h3hbYmScPdGvZBVtUMiM8EugjtWS3_vqVuKgt4sJMCRLmpe74C_NNLZ2Bb0jDSbvGeJFg1Owxno0EvcERZIUX5PBOdttl30wmkL3NWgYQn6gXMfEcOpGYZEwHJ5gF4nLS4QLdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:h3hbYrva0JrB94Xf9HiZGsS8ivWGL1PYMRUFekb-_n4jovSvAKfc9A>
    <xmx:h3hbYvfnGJp9NNzQsbQrV2hbucOIa7_Lzdf12nVub-dld00x_-QPmA>
    <xmx:h3hbYn1KnYfnuIwOdwaO9ljpge0argRsmJtMRVxbzKQejpJZVUFBJg>
    <xmx:h3hbYnQCWWQNbAfBR2v5pGc3lTFfnZy6Bu2NnQjOuKs5z3P43wqCJQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Apr 2022 22:16:38 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/4] Input: pinephone-keyboard - Support the proxied I2C bus
Date:   Sat, 16 Apr 2022 21:16:31 -0500
Message-Id: <20220417021633.56127-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417021633.56127-1-samuel@sholland.org>
References: <20220417021633.56127-1-samuel@sholland.org>
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

(no changes since v1)

 drivers/input/keyboard/pinephone-keyboard.c | 73 +++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index 2ee74cbe68dd..9e486be582f0 100644
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
 
+	i2c_bus = of_get_child_by_name(dev->of_node, "i2c-bus");
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

