Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375A550D31B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiDXQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiDXQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:08:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4792A6;
        Sun, 24 Apr 2022 09:05:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 073565C018B;
        Sun, 24 Apr 2022 12:05:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Apr 2022 12:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650816307; x=1650902707; bh=CH
        D60LWMnUy3K/GAGBKkSJRQzFg1faw0PDFU+ZrmbKU=; b=BxnQcljzj94w+iDDgB
        TJnC9l5sh+3HxJBpeV6Rvi6MTPY4NKmZvakGBXxikTFfTyWAm6fW+4gxt231FRY/
        RbJf8sU3VVwXYiIzTTPmX3LVbJ6KKodAD+3pVxGcqcMz7eydGmT43xgBnf55ZlGC
        S+K8Jm+AqzjBw6sRGApxDbGwp4b9hldtpVm7mbMCg2XvKZmhXXKBcs3QtvMmLR7t
        hNdA8kDNv1W5ovKttRT4dhNb8826yiHAIWPTmw5oBXu5TqY/16oGps/Hr3yEVzbz
        LFdAW5xyHka+TnEDnFaKTPLJcN+5NCg41WPkNNdZOtqpHOCL+nD3esH9GRUIB8rJ
        F+Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650816307; x=1650902707; bh=CHD60LWMnUy3K/GAGBKkSJRQzFg1faw0PDF
        U+ZrmbKU=; b=og0z1bUYgaBeOjTLtuU616uJy6YUMNMpVGrCsgt7VdOXaYu0Gfw
        1Kv8OL8Vm6T4p05ZsYRgKmJDAo5zmw5ZswTqIDuXbMnqv8FWTe4kKYFm9oYJLSfW
        5VTVbi6fRgaFHX9d7AvuECuHR/JDH3QKNZlV5xqelZbZXvoxOeYFW5mtvy2Id/5A
        CIpzP4SOvX0aV50lgjHAc8pcGTWH/QN/uW6spQe6sECx0fgRMDu7KOqcgND1Lplk
        Uoqovl95T1ya8MN3bDzXPywinrZzF1VouNSKu9403/cfqj9BG1+TzK3SlGzai580
        DYX+cxrnhNJJq01wmvkIzHTw8uBEW0gu3PQ==
X-ME-Sender: <xms:MnVlYg2Vaxn149HKK-f9uSMNNcoDM6O-cekNBswvedqLXrNP5QGxkw>
    <xme:MnVlYrFAqnAXvPrakcOg8R2eQOcWI4bE4rvx5SDXUci3zCOZsRt1e0o_Gxe9pSpAQ
    2oC_0iesuQhIuvsIA>
X-ME-Received: <xmr:MnVlYo7pKAcN4GHskjLlfcYvskm494jUJTxO3oejb2Y3OsRBy8AFHYtIM3b7tKQ7FOaL_lCrrKRxmTJU1q_I1JKQo8dNixkeuhpaWRi9xs0WKScYxH0et0rc5lpeauRz9CFzww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:MnVlYp1xDIYT27fmi8FqhIET69UWS5BSH4jwHI9C9RDYBKOdOxeTLg>
    <xmx:MnVlYjEyX2AX3yjDwAiCdnejhvWI5Z33ZQtII0WCc1nY8Bvq4sjbOg>
    <xmx:MnVlYi8Bs9OXa3krKrAoau6KA4ixnaUK44OL-UsEuSBtW9pj-V0G2w>
    <xmx:M3VlYo5XzGBN9KKDRJOEuDrOcXJTCH9VZv5fw9JORU1bp8JRCQKilw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:05:06 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/4] Input: pinephone-keyboard - Support the proxied I2C bus
Date:   Sun, 24 Apr 2022 11:04:56 -0500
Message-Id: <20220424160458.60370-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424160458.60370-1-samuel@sholland.org>
References: <20220424160458.60370-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:
 - Rename i2c-bus to i2c

 drivers/input/keyboard/pinephone-keyboard.c | 73 +++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index 2ee74cbe68dd..008e1322bd2d 100644
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

