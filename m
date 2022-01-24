Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D959E497EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiAXMLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:11:09 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48253 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238406AbiAXMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id AEA8158018C;
        Mon, 24 Jan 2022 07:10:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 24 Jan 2022 07:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=mRrQFEjNbkGy0s
        JZ9IwlrTMAQp56obpeO5eszroii5o=; b=SM/WKMXdz7mOiS4UnlIQUNCV1n7MjN
        ZppMuaxyKZUqXyouBiBypy0/44fkXdqXf09oIH8a8OsAuZR8qwC9+FzrYG2y4uRK
        iUX+oadLsyneMgif6IQUlGYRIfZbwYJ25U4ey8efYubVEeTDGe5HhhdUwrYDk+SL
        PUdJ9F8V/UND9GrWpmfy76ziBeQj6yJmNq/ivfGxJZP0Zv/ecKc8NUqx4QnIYCp3
        ln9FiziEArdoR0l3rr9HjuC6+vd/4JYzfpCR5rRtpSBLVe9nrH9AxSXQt1E8K0vD
        4bHli5RIAijHYMOkguq/OqEASOQPuCyh4Ts8/AuTd6bCbyEsuVaSQwlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mRrQFE
        jNbkGy0sJZ9IwlrTMAQp56obpeO5eszroii5o=; b=UppeTISKUbay0q0KKvNEkv
        bfDqGk0kZfYqiUqfDAtBNeVUmEx7fv+IvbX+6dFFIjhsu//PzYtazrWJP7ox6K44
        A1YLojsiXQ6Ec28IV5vr0ZWHTp1k1vxCKViHWfXaMLnWuMwjR5a8zQNTkv6EI0ck
        xhWVFGaFYSpBneNkRfw2OFi6TgjJMTDjiXB5FoFXVmG0eRwZ/KalHeXhhDASxDQ3
        cwgb/nnsFQEje4sbow/YwkCf8rS4eOOrwyLLYmEp5YA3kcMBjumPgdQT+X2FtrO2
        C4rIOJfLMS9KkB+/dSN23+4+1XGGxlcebIVTulw4vcpmFHDC2lakaCx1q0D6nt7g
        ==
X-ME-Sender: <xms:UJfuYZ3v_uF_tLteKiSrSG_mpF8SjwNCH1CR0g46mEjLhn0Vf_rQrw>
    <xme:UJfuYQEwhZdxLvblRjecHupalNQCZi1krNKcTHOSA8ghMDJX7HO2DmEz8FSGlVCKj
    jmFWFheXXoUBFLtGxo>
X-ME-Received: <xmr:UJfuYZ6uIkOuEnDPx5P8STyNPjusY7sRfuxj2z0AntH657xPbgCDK17PATqCSiWLkylHPGSAO-uleMoJltkYiNra3viX7Xfmqt9MXJs2yU4n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:UJfuYW25MQHE6KDDo_m-FyfEJq_DCM09SNMgzE38oPzxGrUc2UGcDQ>
    <xmx:UJfuYcGlg-Fcw-eDXXKGnrFn7X7qR6FBX5Azw1YL6mSTU4RRJwryyA>
    <xmx:UJfuYX-Vy_h4wR8FbvjEky3P4G5EF_pjcL6JcbsSLjXSB_yQhbNmlA>
    <xmx:UJfuYaVTk0bEXdmumbjq5XodSK9Jfe27WBjXXnQzAKyLInpd3Zi4yQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:50 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 6/8] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Mon, 24 Jan 2022 22:10:07 +1000
Message-Id: <20220124121009.108649-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
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
index f7498df08dfe..37ec95fce3be 100644
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

