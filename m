Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFA4A7BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiBBXvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:51:11 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46345 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348134AbiBBXu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:50:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A099F5C0114;
        Wed,  2 Feb 2022 18:50:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 18:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=Y4Guu71RDilBzG
        o2ggKBceNSjzOtu1j8s5y8c9QFFGs=; b=REJlAgpV/D931cY5p/+UCEaeFRCcbQ
        CVCXeXMAEOrRqLagTfw0+oxg+uFY7Z+vz6vM6JreAE00qEsibBCspLpvO4kUaHEI
        nrV8ZLlFcNpJU/T/Wl6RhpUTTvg5a4EAmFLIuGURWRw/l+ZhU6NuXMiBN/AuCWhW
        EuoiSoE2M432MSdDO5NS6j4zXGok10EL/DWaqWjImmDx6FZP+4dBu7oHoGsXJJGL
        67CyvXmuNHRpYEPTHGkmkuMDRwJ1LJMHoquUuBUZDoMgB7BNzxxJnfCsDN5gC0Uz
        mGJfZeBxj8xHVhCyprKjVbleZ4EsjL7vZOdV407cupcvD8huepm7RkbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Y4Guu71RDilBzGo2ggKBceNSjzOtu1j8s5y8c9QFF
        Gs=; b=Goy9bjzJcCXGDrNV+AtxUP5YgXSq+/UE8rKKpHnE4v5HaEnY/z/Ubh10B
        y8bazeN0e0YQs6MmXIZlrIokJhkynjykFS4hZ1g0iUSodVnTqqrClQ8ZccfJ6ewu
        +DvYD0f6JefwDKZHJ9d5tvYAz14TYiDP5VfBkj2nlAgX8uWU93EYNgRka+HbgoRC
        iL4ghDQte9isKXcE2kfbeaPFNMEJbRiZIpbNkbW7SV/aJWhEvbZ2cR7WDJDYTu/e
        zFAV0s/LxHvaNAYgOvAJzXiZ0vkIGeXRNHseqxUStbMmEjUALh0k1+l+Zm1oATcT
        rlE8wzE7pLLRVBtY97D1DawWTK/jg==
X-ME-Sender: <xms:3xj7Ybu0m0_ErmP8qvXoyLLpNXqAC2RAJ9fHqw14l_o5rOXKIm8VAw>
    <xme:3xj7YccRBtgvx5Qs5aoHeDuVgex0vycx6UEb9wW4sw0lrAOIXk1l3j_o81Zclb8jB
    mCUW2BAfgbQCUXLuA>
X-ME-Received: <xmr:3xj7YeyzYls_SHxoxEagUz5U3f3z8luy9ywmxP3ObA_YTcqBSK4IfvNohhSGFJvBNQycwb56vlxpOpt8Juq3zxXr8YgvzwZjlECd4YWnjTICkKMpPQVPKiwnmbzEWha-MhBumw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeettdejhfejjedvfeelieffteduueevgeethedvjefhkeeigfejhfet
    udffiefhfeenucffohhmrghinheplhhinhhugidqtghhvghngihinhhgrdhorhhgpdhsih
    hithgvkhdrtghomhdrtghnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3xj7YaMPIGERppAblI-ufCKsrTZnCymi9TkLbQvnRZ9ukrt8ffH-xA>
    <xmx:3xj7Yb_eOinzwDRbgZmkGj0wJimr4-M92fUkVl9tvrK4pifgXZBm8A>
    <xmx:3xj7YaUNK-2mMC4hm6BZfhYcOSMA0BJNsqkgY1jgLLGl8TAvtS8mIg>
    <xmx:3xj7YcObQ4a0M-Lu4BBQi0pA1PQb89_bLUBWDCazaRECe419TcK3qg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 18:50:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/3] iio: accel: st_accel: Add support for Silan SC7A20
Date:   Wed,  2 Feb 2022 17:50:48 -0600
Message-Id: <20220202235049.8051-4-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220202235049.8051-1-samuel@sholland.org>
References: <20220202235049.8051-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip appears to be register-compatible with the LIS2DH. The new
description is a copy of the LIS2DH's description with a different WAI
value.

Datasheet: http://linux-chenxing.org/silan/SC7A20-SilanMicroelectronics.pdf
Datasheet: http://www.siitek.com.cn/Upfiles/down/SC7A20说明书_0.92(智能穿戴).pdf
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Add a comment about the WAI value
 - Update commit messages

 drivers/iio/accel/st_accel.h      |  2 +
 drivers/iio/accel/st_accel_core.c | 83 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 3 files changed, 90 insertions(+)

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
index 31ea19d0ba71..2ada8d6fb503 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1087,6 +1087,89 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		/*
+		 * Not an ST part. Register-compatible with the LIS2DH, even
+		 * though the WAI value is different.
+		 */
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

