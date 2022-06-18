Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEB55063E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiFRRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiFRRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:05:52 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70E12D3F;
        Sat, 18 Jun 2022 10:05:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 8834F2B04FDC;
        Sat, 18 Jun 2022 12:58:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 18 Jun 2022 12:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655571480; x=1655578680; bh=wX
        v8zViAQQy2r33JlqJ+sonP9YPZMg0dhr1wzFYGYOc=; b=eFKMFdKgCzTB0avSai
        8kkCgBWLSte7BwLkZ0K0+nlP8ISBLKxtn008eTFlt5xut2FhNzlW/BzF9lTGG9T4
        LJNV9EGEeKLKDSqMaNhsVTvwtud/KB0ILaZaqNUAxCWTqLQWxQpZ1cddnhnE9vtv
        xp2B9HAOU8i5FdGjykDDz2n7JJZg8zy7w64W2FLl4WzrfsIq1sVnuZqfuvyWcOhD
        usjTTVEWzH3h80gKga2MHwbRve2GEpgM3VOFKbaoiJOaKU3l4fRl7fj7hYI8q3Ra
        +e1YWWoSBLvaz2jSbgDLPRRjETGARqnYDBmOWcHMbozc4veRd3HtqGI70cHN3NNZ
        leog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655571480; x=1655578680; bh=wXv8zViAQQy2r
        33JlqJ+sonP9YPZMg0dhr1wzFYGYOc=; b=IG8be6hRiwfcDvGUG+Km+KJ/3HcgP
        K4rR20HRg4GsD4PhidO36KnfzvXPsCwzoY/SCkwvQhaMKHnso+1S2vCwc8OQiWe+
        O/nEwcF5ex2rAxSwucd6jVugjQzxqcd6nAQ3CVsrqQIhlzCoTAmQbTMoY3MtjkUO
        iFnDQ6NN2n14IrAjn9x6jJB09Lf0NOxFxFhsGKzS1S+sn3FcIYSNBF/OAv9isch+
        iVv1vStzgujNS3mSnJQ+3E2hJZzf1PhZcQyYgn893w5aOQznWYSIHEyLCIpV8vIf
        WXAyxN6aAf/Jxy1KtVZErGt8//zIu8MrYVceAVFSGcMpjCTN4xZeLMBXA==
X-ME-Sender: <xms:FwSuYpQbQZoJtWbiq_ksX7LHb9D4d1jRRajG3pwoPfaW5EwqJf7-JQ>
    <xme:FwSuYizS5ThBWkNRFLfT-6ir-Qz8TVMHyA6Kgs0hkhRvMQ2rvbT7COAYAe4j5GsKV
    CI7MWib_N8vPj3Chw>
X-ME-Received: <xmr:FwSuYu1cnpQHA6XlNAIAbFhTa3fDG-5XFmJh3KQnSQbWB2Zu6ECVMFI6fmdeKrjx_b2kk6tcEhvQ02_81d-FgkNVf6mCp0aLsdAvgHc15qleAGZz74WfJpiRb8MoWgSa0VljRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeffkeduuefhgefgteegkefhgeeujeelvdeileehleffvedvleet
    heffgfetieeuleenucffohhmrghinhepmhgvghhouhhsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:FwSuYhDrSQTTXznP0FuTiHdoO4BTPMEXlO3w-SBr78B2Xs30SBkMNA>
    <xmx:FwSuYig6rQtxTo0U7jpiz4ZHysL1L7fjkjA9QViVRYJmI1EBunV5Jg>
    <xmx:FwSuYlpPyGi1TV7Ov5JjxZHswNDtTb1f2QRnZ9Pn6KImVzg3rUpJzA>
    <xmx:GASuYj33hJwfo_bGYjjXDjUNvl4DJS_yhSHcgBpwf2gkDcievbG7Pyav6SU>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jun 2022 12:57:58 -0400 (EDT)
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
Subject: [PATCH v4 2/4] Input: pinephone-keyboard - Add PinePhone keyboard driver
Date:   Sat, 18 Jun 2022 11:57:45 -0500
Message-Id: <20220618165747.55709-3-samuel@sholland.org>
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

The official Pine64 PinePhone keyboard case contains a matrix keypad and
a MCU which runs a libre firmware. Add support for its I2C interface.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Rebase to resolve MAINTAINERS merge conflict
 - Add missing newlines in error messages

Changes in v2:
 - Fix missing key release events when FN state changes
 - Add VBAT consumer to ensure enough power is available for the MCU
 - Use a single fixed-size, fixed-contents keymap for both layers

 MAINTAINERS                                 |   6 +
 drivers/input/keyboard/Kconfig              |  10 +
 drivers/input/keyboard/Makefile             |   1 +
 drivers/input/keyboard/pinephone-keyboard.c | 365 ++++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 drivers/input/keyboard/pinephone-keyboard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f52543aedd61..c40d236ba0be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15820,6 +15820,12 @@ F:	Documentation/devicetree/bindings/pinctrl/sunplus,*
 F:	drivers/pinctrl/sunplus/
 F:	include/dt-bindings/pinctrl/sppctl*.h
 
+PINE64 PINEPHONE KEYBOARD DRIVER
+M:	Samuel Holland <samuel@sholland.org>
+S:	Supported
+F:	Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
+F:	drivers/input/keyboard/pinephone-keyboard.c
+
 PKTCDVD DRIVER
 M:	linux-block@vger.kernel.org
 S:	Orphan
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4ea79db8f134..0a84aa4b6209 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -524,6 +524,16 @@ config KEYBOARD_OPENCORES
 	  To compile this driver as a module, choose M here; the
 	  module will be called opencores-kbd.
 
+config KEYBOARD_PINEPHONE
+	tristate "Pine64 PinePhone Keyboard"
+	depends on I2C && REGULATOR
+	select CRC8
+	select INPUT_MATRIXKMAP
+	help
+	  Say Y here to enable support for the keyboard in the Pine64 PinePhone
+	  keyboard case. This driver supports the FLOSS firmware available at
+	  https://megous.com/git/pinephone-keyboard/
+
 config KEYBOARD_PXA27x
 	tristate "PXA27x/PXA3xx keypad support"
 	depends on PXA27x || PXA3xx || ARCH_MMP
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 721936e90290..5f67196bb2c1 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_KEYBOARD_NSPIRE)		+= nspire-keypad.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_OMAP4)		+= omap4-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
+obj-$(CONFIG_KEYBOARD_PINEPHONE)	+= pinephone-keyboard.o
 obj-$(CONFIG_KEYBOARD_PMIC8XXX)		+= pmic8xxx-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
new file mode 100644
index 000000000000..a021c9deee19
--- /dev/null
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#define DRV_NAME			"pinephone-keyboard"
+
+#define PPKB_CRC8_POLYNOMIAL		0x07
+
+#define PPKB_DEVICE_ID_HI		0x00
+#define PPKB_DEVICE_ID_HI_VALUE			'K'
+#define PPKB_DEVICE_ID_LO		0x01
+#define PPKB_DEVICE_ID_LO_VALUE			'B'
+#define PPKB_FW_REVISION		0x02
+#define PPKB_FW_FEATURES		0x03
+#define PPKB_MATRIX_SIZE		0x06
+#define PPKB_SCAN_CRC			0x07
+#define PPKB_SCAN_DATA			0x08
+#define PPKB_SYS_CONFIG			0x20
+#define PPKB_SYS_CONFIG_DISABLE_SCAN		BIT(0)
+
+#define PPKB_ROWS			6
+#define PPKB_COLS			12
+
+/* Size of the scan buffer, including the CRC byte at the beginning. */
+#define PPKB_BUF_LEN			(1 + PPKB_COLS)
+
+static const uint32_t ppkb_keymap[] = {
+	KEY(0,  0, KEY_ESC),
+	KEY(0,  1, KEY_1),
+	KEY(0,  2, KEY_2),
+	KEY(0,  3, KEY_3),
+	KEY(0,  4, KEY_4),
+	KEY(0,  5, KEY_5),
+	KEY(0,  6, KEY_6),
+	KEY(0,  7, KEY_7),
+	KEY(0,  8, KEY_8),
+	KEY(0,  9, KEY_9),
+	KEY(0, 10, KEY_0),
+	KEY(0, 11, KEY_BACKSPACE),
+
+	KEY(1,  0, KEY_TAB),
+	KEY(1,  1, KEY_Q),
+	KEY(1,  2, KEY_W),
+	KEY(1,  3, KEY_E),
+	KEY(1,  4, KEY_R),
+	KEY(1,  5, KEY_T),
+	KEY(1,  6, KEY_Y),
+	KEY(1,  7, KEY_U),
+	KEY(1,  8, KEY_I),
+	KEY(1,  9, KEY_O),
+	KEY(1, 10, KEY_P),
+	KEY(1, 11, KEY_ENTER),
+
+	KEY(2,  0, KEY_LEFTMETA),
+	KEY(2,  1, KEY_A),
+	KEY(2,  2, KEY_S),
+	KEY(2,  3, KEY_D),
+	KEY(2,  4, KEY_F),
+	KEY(2,  5, KEY_G),
+	KEY(2,  6, KEY_H),
+	KEY(2,  7, KEY_J),
+	KEY(2,  8, KEY_K),
+	KEY(2,  9, KEY_L),
+	KEY(2, 10, KEY_SEMICOLON),
+
+	KEY(3,  0, KEY_LEFTSHIFT),
+	KEY(3,  1, KEY_Z),
+	KEY(3,  2, KEY_X),
+	KEY(3,  3, KEY_C),
+	KEY(3,  4, KEY_V),
+	KEY(3,  5, KEY_B),
+	KEY(3,  6, KEY_N),
+	KEY(3,  7, KEY_M),
+	KEY(3,  8, KEY_COMMA),
+	KEY(3,  9, KEY_DOT),
+	KEY(3, 10, KEY_SLASH),
+
+	KEY(4,  1, KEY_LEFTCTRL),
+	KEY(4,  4, KEY_SPACE),
+	KEY(4,  6, KEY_APOSTROPHE),
+	KEY(4,  8, KEY_RIGHTBRACE),
+	KEY(4,  9, KEY_LEFTBRACE),
+
+	KEY(5,  2, KEY_FN),
+	KEY(5,  3, KEY_LEFTALT),
+	KEY(5,  5, KEY_RIGHTALT),
+
+	/* FN layer */
+	KEY(PPKB_ROWS + 0,  0, KEY_FN_ESC),
+	KEY(PPKB_ROWS + 0,  1, KEY_F1),
+	KEY(PPKB_ROWS + 0,  2, KEY_F2),
+	KEY(PPKB_ROWS + 0,  3, KEY_F3),
+	KEY(PPKB_ROWS + 0,  4, KEY_F4),
+	KEY(PPKB_ROWS + 0,  5, KEY_F5),
+	KEY(PPKB_ROWS + 0,  6, KEY_F6),
+	KEY(PPKB_ROWS + 0,  7, KEY_F7),
+	KEY(PPKB_ROWS + 0,  8, KEY_F8),
+	KEY(PPKB_ROWS + 0,  9, KEY_F9),
+	KEY(PPKB_ROWS + 0, 10, KEY_F10),
+	KEY(PPKB_ROWS + 0, 11, KEY_DELETE),
+
+	KEY(PPKB_ROWS + 1, 10, KEY_PAGEUP),
+
+	KEY(PPKB_ROWS + 2,  0, KEY_SYSRQ),
+	KEY(PPKB_ROWS + 2,  9, KEY_PAGEDOWN),
+	KEY(PPKB_ROWS + 2, 10, KEY_INSERT),
+
+	KEY(PPKB_ROWS + 3,  0, KEY_LEFTSHIFT),
+	KEY(PPKB_ROWS + 3,  8, KEY_HOME),
+	KEY(PPKB_ROWS + 3,  9, KEY_UP),
+	KEY(PPKB_ROWS + 3, 10, KEY_END),
+
+	KEY(PPKB_ROWS + 4, 1, KEY_LEFTCTRL),
+	KEY(PPKB_ROWS + 4, 6, KEY_LEFT),
+	KEY(PPKB_ROWS + 4, 8, KEY_RIGHT),
+	KEY(PPKB_ROWS + 4, 9, KEY_DOWN),
+
+	KEY(PPKB_ROWS + 5, 3, KEY_LEFTALT),
+	KEY(PPKB_ROWS + 5, 5, KEY_RIGHTALT),
+};
+
+static const struct matrix_keymap_data ppkb_keymap_data = {
+	.keymap		= ppkb_keymap,
+	.keymap_size	= ARRAY_SIZE(ppkb_keymap),
+};
+
+struct pinephone_keyboard {
+	struct input_dev *input;
+	u8 buf[2][PPKB_BUF_LEN];
+	u8 crc_table[CRC8_TABLE_SIZE];
+	u8 fn_state[PPKB_COLS];
+	bool buf_swap;
+	bool fn_pressed;
+};
+
+static void ppkb_update(struct i2c_client *client)
+{
+	struct pinephone_keyboard *ppkb = i2c_get_clientdata(client);
+	unsigned short *keymap = ppkb->input->keycode;
+	int row_shift = get_count_order(PPKB_COLS);
+	u8 *old_buf = ppkb->buf[!ppkb->buf_swap];
+	u8 *new_buf = ppkb->buf[ppkb->buf_swap];
+	int col, crc, ret, row;
+	struct device *dev = &client->dev;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PPKB_SCAN_CRC,
+					    PPKB_BUF_LEN, new_buf);
+	if (ret != PPKB_BUF_LEN) {
+		dev_err(dev, "Failed to read scan data: %d\n", ret);
+		return;
+	}
+
+	crc = crc8(ppkb->crc_table, &new_buf[1], PPKB_COLS, CRC8_INIT_VALUE);
+	if (crc != new_buf[0]) {
+		dev_err(dev, "Bad scan data (%02x != %02x)\n", crc, new_buf[0]);
+		return;
+	}
+
+	ppkb->buf_swap = !ppkb->buf_swap;
+
+	for (col = 0; col < PPKB_COLS; ++col) {
+		u8 old = old_buf[1 + col];
+		u8 new = new_buf[1 + col];
+		u8 changed = old ^ new;
+
+		if (!changed)
+			continue;
+
+		for (row = 0; row < PPKB_ROWS; ++row) {
+			u8 mask = BIT(row);
+			u8 value = new & mask;
+			unsigned short code;
+			bool fn_state;
+
+			if (!(changed & mask))
+				continue;
+
+			/*
+			 * Save off the FN key state when the key was pressed,
+			 * and use that to determine the code during a release.
+			 */
+			fn_state = value ? ppkb->fn_pressed : ppkb->fn_state[col] & mask;
+			if (fn_state)
+				ppkb->fn_state[col] ^= mask;
+
+			/* The FN layer is a second set of rows. */
+			code = MATRIX_SCAN_CODE(fn_state ? PPKB_ROWS + row : row,
+						col, row_shift);
+			input_event(ppkb->input, EV_MSC, MSC_SCAN, code);
+			input_report_key(ppkb->input, keymap[code], value);
+			if (keymap[code] == KEY_FN)
+				ppkb->fn_pressed = value;
+		}
+	}
+	input_sync(ppkb->input);
+}
+
+static irqreturn_t ppkb_irq_thread(int irq, void *data)
+{
+	struct i2c_client *client = data;
+
+	ppkb_update(client);
+
+	return IRQ_HANDLED;
+}
+
+static int ppkb_set_scan(struct i2c_client *client, bool enable)
+{
+	struct device *dev = &client->dev;
+	int ret, val;
+
+	ret = i2c_smbus_read_byte_data(client, PPKB_SYS_CONFIG);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read config: %d\n", ret);
+		return ret;
+	}
+
+	if (enable)
+		val = ret & ~PPKB_SYS_CONFIG_DISABLE_SCAN;
+	else
+		val = ret | PPKB_SYS_CONFIG_DISABLE_SCAN;
+	ret = i2c_smbus_write_byte_data(client, PPKB_SYS_CONFIG, val);
+	if (ret) {
+		dev_err(dev, "Failed to write config: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ppkb_open(struct input_dev *input)
+{
+	struct i2c_client *client = input_get_drvdata(input);
+	int ret;
+
+	ret = ppkb_set_scan(client, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void ppkb_close(struct input_dev *input)
+{
+	struct i2c_client *client = input_get_drvdata(input);
+
+	ppkb_set_scan(client, false);
+}
+
+static void ppkb_regulator_disable(void *regulator)
+{
+	regulator_disable(regulator);
+}
+
+static int ppkb_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	unsigned int phys_rows, phys_cols;
+	struct pinephone_keyboard *ppkb;
+	struct regulator *vbat_supply;
+	u8 info[PPKB_MATRIX_SIZE + 1];
+	int ret;
+
+	vbat_supply = devm_regulator_get(dev, "vbat");
+	if (IS_ERR(vbat_supply))
+		return dev_err_probe(dev, PTR_ERR(vbat_supply),
+				     "Failed to get VBAT supply\n");
+
+	ret = regulator_enable(vbat_supply);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VBAT\n");
+
+	ret = devm_add_action_or_reset(dev, ppkb_regulator_disable, vbat_supply);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, 0, sizeof(info), info);
+	if (ret != sizeof(info))
+		return dev_err_probe(dev, -ENODEV, "Failed to read device ID\n");
+
+	if (info[PPKB_DEVICE_ID_HI] != PPKB_DEVICE_ID_HI_VALUE ||
+	    info[PPKB_DEVICE_ID_LO] != PPKB_DEVICE_ID_LO_VALUE)
+		return dev_err_probe(dev, -ENODEV, "Unexpected device ID\n");
+
+	dev_info(dev, "Found firmware version %d.%d features %#x\n",
+		 info[PPKB_FW_REVISION] >> 4,
+		 info[PPKB_FW_REVISION] & 0xf,
+		 info[PPKB_FW_FEATURES]);
+
+	phys_rows = info[PPKB_MATRIX_SIZE] & 0xf;
+	phys_cols = info[PPKB_MATRIX_SIZE] >> 4;
+	if (phys_rows != PPKB_ROWS || phys_cols != PPKB_COLS)
+		return dev_err_probe(dev, -EINVAL, "Unexpected keyboard size %ux%u\n",
+				     phys_rows, phys_cols);
+
+	/* Disable scan by default to save power. */
+	ret = ppkb_set_scan(client, false);
+	if (ret)
+		return ret;
+
+	ppkb = devm_kzalloc(dev, sizeof(*ppkb), GFP_KERNEL);
+	if (!ppkb)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, ppkb);
+
+	crc8_populate_msb(ppkb->crc_table, PPKB_CRC8_POLYNOMIAL);
+
+	ppkb->input = devm_input_allocate_device(dev);
+	if (!ppkb->input)
+		return -ENOMEM;
+
+	input_set_drvdata(ppkb->input, client);
+
+	ppkb->input->name = "PinePhone Keyboard";
+	ppkb->input->phys = DRV_NAME "/input0";
+	ppkb->input->id.bustype = BUS_I2C;
+	ppkb->input->open = ppkb_open;
+	ppkb->input->close = ppkb_close;
+
+	input_set_capability(ppkb->input, EV_MSC, MSC_SCAN);
+	__set_bit(EV_REP, ppkb->input->evbit);
+
+	ret = matrix_keypad_build_keymap(&ppkb_keymap_data, NULL, 2 * PPKB_ROWS,
+					 PPKB_COLS, NULL, ppkb->input);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to build keymap\n");
+
+	ret = input_register_device(ppkb->input);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register input\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, ppkb_irq_thread,
+					IRQF_ONESHOT, client->name, client);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	return 0;
+}
+
+static const struct of_device_id ppkb_of_match[] = {
+	{ .compatible = "pine64,pinephone-keyboard" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ppkb_of_match);
+
+static struct i2c_driver ppkb_driver = {
+	.probe_new	= ppkb_probe,
+	.driver		= {
+		.name		= DRV_NAME,
+		.of_match_table = ppkb_of_match,
+	},
+};
+module_i2c_driver(ppkb_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Pine64 PinePhone keyboard driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

