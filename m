Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3664A339C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 04:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353949AbiA3DpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 22:45:01 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48187 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353926AbiA3Do5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 22:44:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C9AAE320167D;
        Sat, 29 Jan 2022 22:44:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 29 Jan 2022 22:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=kK2U+mdU12rx5tRGN21QFrTCFOKPO9
        nuqkez8Dekhy8=; b=oZ71AkN+cHDUSGHiri2Z2yTOYRp8ht+X40eNJfO8EIVdC+
        NCiGJ//t7Whz8JbdrJjGlM7Z/GdbQkts0RdEpyeLu6VEuoz54Pm42s5A5pX+kkPY
        HUBuuDAlgmg1taDxb0HhH95PAChY5YqgaTTI6+Ar/+147MvEGbHdQm0nZ8Vsio7A
        OUhTwmfd+Re5tjpGtDBR5pxAHfUxRcGTTlzNpiUhihOrtHe8M7iLCGnNYpW1ZaWJ
        adEHD9kgPUyalfPE9cflKk+cWUlBKS1JdNaVKdSXIQJ9t/C4SS/+wIxQc1bgyuV5
        NAV7q6X+GWb0fLAq5kfpuCSzyigfXA1UlvJqC3Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kK2U+m
        dU12rx5tRGN21QFrTCFOKPO9nuqkez8Dekhy8=; b=f+u4N1gzjm8vqDlHnFi0is
        dM/o51La+zQHMvtKYKktIoEaCcYmhEZoJeMyO2HlqbyCJl79PDkZrCTW1EQDsrOX
        hfUF5zwZJ1A1+xR3PKLItjQAcxQK9Is4arM5QqTujO8xdX2UmXNq96y2eZZE5C9c
        zLaS8EHvIIUtjDUuig+CzBfFi6VCqjQs5hRyxK4H93AUJgknGn6kKdul6W3RHTvL
        53tBHL1PSKI6S+nw69Pb3NPPXjyCztrC8/KYHUu3LAUpcg8mz25F/ZYTCbjyh8Pb
        fQcW8mPCtPHtzjN577QBpQqW3MuGNfCWUFz1GKY9SmqjQCq7niQzz/+ePErWyVMA
        ==
X-ME-Sender: <xms:uAn2YccHukd3DUyQQLmLXYnTw_VIaY3Kuv1EkYLnydSO4RxgafgH1A>
    <xme:uAn2YeM1nLLgNW8p4UXM9fcmCfJ6jRLYGitAlnIwVJaU9scBZU5bnMQJROnIWP3tW
    aC9-MHCK1dA-UH-fw>
X-ME-Received: <xmr:uAn2Ydg7keN0V2Z_peaLe2-eY4IpFTB9GsvGMUvIFRkMLNOF9qzt5U8XLUoy-rxHyH8_IGZ8iOl1l9uvlRm5s6T7Ps3gHW5Ea4ecKpuGUc7kKRRQGm7j-x42G1Pj1t_JXRgQSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:uAn2YR_3nSDv-8aIqj-ThWns9L37WtZSSSq94-cEnljCUcaBE_UojQ>
    <xmx:uAn2YYvWH74SzZHPuXOriih4_8kJHB_d0onwuIR5SLxZNirP8Bvugw>
    <xmx:uAn2YYHXWWH7J5ephqMzMbiBEWTxhvnrzcrO2Jsey0ho24S0fRG4sw>
    <xmx:uAn2Yd_-Wg93zVEK_hsKkAfm8P_J8A_szbYxIVhe9KC1IDaU66lrkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 22:44:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/3] iio: accel: st_accel: Add support for Silan SC7A20
Date:   Sat, 29 Jan 2022 21:44:41 -0600
Message-Id: <20220130034441.15474-4-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220130034441.15474-1-samuel@sholland.org>
References: <20220130034441.15474-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip appears to be a clone of the LIS2DH. The new description is a
copy of the LIS2DH's description with a different WAI value.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/iio/accel/st_accel.h      |  2 +
 drivers/iio/accel/st_accel_core.c | 79 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 3 files changed, 86 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 8750dea56fcb..00e056c21bfc 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -36,6 +36,7 @@ enum st_accel_type {
 	LIS3DHH,
 	LIS2DE12,
 	LIS2HH12,
+	SC7A20,
 	ST_ACCEL_MAX,
 };
 
@@ -61,6 +62,7 @@ enum st_accel_type {
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
+#define SC7A20_ACCEL_DEV_NAME		"sc7a20"
 
 #ifdef CONFIG_IIO_BUFFER
 int st_accel_allocate_ring(struct iio_dev *indio_dev);
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 31ea19d0ba71..d9aa0ff1922b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1087,6 +1087,85 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x11,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = SC7A20_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01, },
+				{ .hz = 10, .value = 0x02, },
+				{ .hz = 25, .value = 0x03, },
+				{ .hz = 50, .value = 0x04, },
+				{ .hz = 100, .value = 0x05, },
+				{ .hz = 200, .value = 0x06, },
+				{ .hz = 400, .value = 0x07, },
+				{ .hz = 1600, .value = 0x08, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(1000),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(2000),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(4000),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(12000),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = 0x80,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x25,
+			.mask_ihl = 0x02,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x07,
+			},
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 };
 
 /* Default accel DRDY is available on INT1 pin */
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c0ce78eebad9..7f5888570e87 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -107,6 +107,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2hh12",
 		.data = LIS2HH12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "silan,sc7a20",
+		.data = SC7A20_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -142,6 +146,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS2DE12_ACCEL_DEV_NAME },
 	{ LIS2HH12_ACCEL_DEV_NAME },
+	{ SC7A20_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
-- 
2.33.1

