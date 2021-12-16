Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C574771BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhLPM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:26:18 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52371 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236768AbhLPM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:26:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1D14A5805EC;
        Thu, 16 Dec 2021 07:26:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Dec 2021 07:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=V8tCZDVlOk3rk
        cprQ+2KQBwTR6cMGYHthIRm9/6DahY=; b=JcdhJljj22Ojqqdqv2/SQjsMI935v
        tEYQLIoT+nEKg1O7Y1gmx8Wnbcpc2XEGNsS0pdDU52dY4Y7fEog85niQr6cBK+LX
        9DRtGlJ3sTV+qYzUoyP5awjdEXi6wGTAhtu6SmnyGGZwg4pZpmGYIdcNS/+dLf34
        EzYFoOLv/fJn2/fra/KUvm6RjDobaZ4O4ZA9ZQI2eU+BzgKCgaurBWBZmpuYk2ZY
        3vh6WRx1bADiGl/+DPQ7iHIKH4vpCeZW6eCBRNj7Fv0lCXv8Qj4qoTf4u5X67yzF
        mMPMuLhev74ACZ0GUWIcrG6ViWqGOeXkIeWjLpXQIFwsw8ZGMICrLOHdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=V8tCZDVlOk3rkcprQ+2KQBwTR6cMGYHthIRm9/6DahY=; b=E4r/O9fH
        GVwWJ9gSpW9KLQ1lL4eEPrIQvN6/zO8bEFx2q8siTgAlUbt2eOtZzRV1UUrG+5w+
        uJTm7LTsgAs+H7iRFHUT7xqazl4Uvp4aKMi84W94TpkMmPGE72BOTOU27UrMdl6J
        0MyqA6rpo0OVubvBRouqIXFnGOP2OodhMvdKci06y6EiHMB+ZGPJVxViYV6jBIC3
        JSLInE2vvKqpR/3PD+8ltK0o70j+iyQcyf0S4VqS7VAmgC/0DssDRDhPGtDXxcHH
        OaDybTe/5Z2hTBPh8T2EeHTy/8zLePgQXuYDIVz29Vvpx23kcr0MhUoA9vfcJc8P
        y6+P37lwJw0EIg==
X-ME-Sender: <xms:ZTC7YUEUQxgmVi1-KvZcyR7vV2UOS-iVB6sMc5ii06Gf5OOMBiEDqw>
    <xme:ZTC7YdUhpOpoozstXzMhSRwc5FDJ3HapTLBT7PKjN6QUf5wbA2TbSMEaSyXBP2mT_
    GKnLpcX19KQkwZi53I>
X-ME-Received: <xmr:ZTC7YeIdBDxNK5kSlPMO9zpFiMDkscjw8Kvt1p7ERJylkUjCVkLuuhkzNj_HjYZhFmGLfg8npmTP7Xn6_8HQSBBldtWHeTqlMBpLfA8KrX7e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:ZTC7YWEx1Q2tWFAuQmWq1gB4KA7gAgYI6ULCLVKQQje5Goukp2yhTQ>
    <xmx:ZTC7YaXw0k3XhzT5-044bIDw9sk77bODVViNw5RCoo6t26d5tV-hQg>
    <xmx:ZTC7YZNQBxZe6XJEljIVzPH97x0rJbN308LZi_uv10w6JkDKvX-BZQ>
    <xmx:ZjC7YWlgLqJ4avKqZvS3htnmyYS_wR0LhvEBPBQZKnsW1a_0hYV5MQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:26:07 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 6/8] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Thu, 16 Dec 2021 22:25:23 +1000
Message-Id: <20211216122525.136139-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
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

