Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3B46633E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbhLBMNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:13:43 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37415 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357758AbhLBMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:12:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A2838580342;
        Thu,  2 Dec 2021 07:08:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 Dec 2021 07:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=V8tCZDVlOk3rk
        cprQ+2KQBwTR6cMGYHthIRm9/6DahY=; b=njqRf0mgDUyDEY4VuVpSXS4eKCwlL
        dGCvwl1rctqeYjiRIa2Yzt3GCNEDSVMUahMEvwzBF6+lDuMqp5/eA6mHPEp6aqY4
        phc0c/Nxl4I/xDQN6kWzH0LyZpPkjn9lwZUTGlQPhoCiPZiBOv3Rvqh2xxfNZpkN
        kxn5ivc5ScaDGlwMqB930xLuXqLe8Mrkpcjl0om4PKPArOuuaBF0Yn1AOF8WWDkj
        vxnlXnbqDDinht9TJwfItGt+duuR2ssIctFqNWiiLDpTDaYsY0N2OTqF950TgnTq
        GdKyRDFItqgHN2Wk2zLEMq2iwUkPGmO4OpSdjiCzpNpEf5rBwAUr8t13A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=V8tCZDVlOk3rkcprQ+2KQBwTR6cMGYHthIRm9/6DahY=; b=bXjl+zBR
        rePqBEN4nkXy5Pwv7ZQPkPv2IJ0NI2Du8DZBrKCa0Jpyh+TDD8DqqtisLNgXMr8y
        x00QrzR8lylgQJc0o3nUZebCyPnWhWdGiwstdKTB51fmJXr+zfs5zZaQLmvH+tlx
        o6DYWqX36uOcsH1ywUKbKmvdoGLcMuSLdkT5FMymOivXaq1ChzAOa6W0XeJjdZAt
        Vvcc4lM5mUl7wr/htK2u/GEVu93AsWL3i4E9dLTYIUagzGj9lI5skTnEH3zUBBjE
        NFpilBdwdawJPQpCS1ERlfPRUXj1HURJXLh54sTxihkb84aNgI7VjiOjTXltBSkI
        ay8SwxfrZazf8Q==
X-ME-Sender: <xms:UbeoYQhqA6kPho_rmrF4iaCawAZhNEKjj0KSs9mSo3gN73_AqNPo1A>
    <xme:UbeoYZBxDf8sLxxLHXIMIkuONbFz6UswjQhYt04jICvqfD3ydy1GZBgiuepqCJS8c
    ciUjyRD01A4Lm4um_I>
X-ME-Received: <xmr:UbeoYYES4TQ4_JgCJsW-swUnAm5vJ50ACzEU0sT8wDhYuzS4nj4qAr_hIYlgatFC95y5bjqYuWAQpvge39Oc89xPB3C1lZJpPPTkLkUtkcz0fmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:UbeoYRQzROzIlvuF0f2mv0mHohSgxL-KgN7MmHqHsOYfxMjyhkMQdQ>
    <xmx:UbeoYdx7oYkoKWfcHsrw7flSYF2nrKNO7w3gXcX3i_28r2U6gYtZdQ>
    <xmx:UbeoYf4AwCbWywugvZj30eRSIeMJR9jxLBTMipYM64vCh9NvMl2Wig>
    <xmx:UbeoYagHBeAtDJysB_a8JpUedtiRetxSpqDBAdWX4pwaZfESUCg9dA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:42 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 6/8] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Thu,  2 Dec 2021 22:07:56 +1000
Message-Id: <20211202120758.41478-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1fbb8e45e604..6add186e189e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -223,6 +223,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
@@ -239,6 +240,7 @@ CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
+CONFIG_MFD_SIMPLE_MFD_I2C=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
@@ -251,6 +253,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

