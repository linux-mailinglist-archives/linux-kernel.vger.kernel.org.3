Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CED4C5B2C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiB0MpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiB0MpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:45:13 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708176D950;
        Sun, 27 Feb 2022 04:44:37 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6D0758021E;
        Sun, 27 Feb 2022 07:44:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 27 Feb 2022 07:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=dYjo0NnNG1lB5q
        qSoTlhV17crNVzg+0X2uFbXtwvHok=; b=hJKm93ERWnAougpJlsRoKoG7y1NzYN
        qPi4V4ZCemtxxkPCyGnzCffwA7iv81aLUjt4w2EqfYEQtSu/n+fxOsUSFywQ8JTD
        c+2ukhTZFFmQHQtScNBbkhazaeMib0PeNorSUgYSvF3pmPd3YRCzCJO6HWj+HWfg
        zi/J2pWZIi/LBZjfvQcm8MX2EZm2lh/ceteDhUWGoJJejMij+4ItHmpDR+7uKuCI
        dz2QmOTD/hgz/Z/Pk6n3k6i029KT0XPmynnKQIxeBRKlAem9A6zNpyUja/LiNFQc
        /T+OtHiLJNWncnlxXmnvs4d4disGodw1YvKt8tTuRN4X19Ggm7PeTtmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dYjo0N
        nNG1lB5qqSoTlhV17crNVzg+0X2uFbXtwvHok=; b=dJdHW4G1fD7tn0/XbNYk5d
        CqcY7WQrHcBvF0GQFQ/6ea0vZ/2E8ckTBrbfAl7NCWT4R8tt5EBEuYSeJRYIvrcZ
        PB2gjk3nQlHNOmBaHI32in//6TPIGGk7/gaMdmeA0xf3DZKa7WpuyIt65O206XF8
        V+Yw3ZGQtXkyYjnXXeCvvGvBoz0AJ3Ap46kLm1mKjBRXGuyWSWJBFKzTCXV2vFbo
        4yZSUtgceVN0BD440A54olOXfHoH4id0pCqZqU6li6POqy6i99HsF4BD0Pa23dKA
        +CjbWar9rJmX/9ixCgYS9yHmkmnzWKnOglVoO2xltIczPVeTdVKKvyiGcPZxD2Lg
        ==
X-ME-Sender: <xms:NHIbYlwtl7EFg1zb1RcCJ0LYRBa-0cbHQAWDYdZiU3Suu4cDmbOE0g>
    <xme:NHIbYlQU5VBTdzRQMrS01Znm_RhOX_JDE8TMlj-OUy-PeyLKvzf8cKwUG0Ia3PFDb
    HAZ60cy2lAyDDahAvQ>
X-ME-Received: <xmr:NHIbYvV3nc4iSEG5ZZgp0GwRWZrmQ-mdxkm58wAQEzWX4VnV9xVwFK4GhJHvLWjE0tEWjUUnj5SrkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:NHIbYnidkcMUOQcaY0MLZ-dpQdn1YUXR2C5VCn3aQ7f7yavhfEy7AQ>
    <xmx:NHIbYnCgXY-cwplij6_gKGcTPfFxWD94jrJJN1yVWaNsLheAFuh_Ew>
    <xmx:NHIbYgKMKLHrU4XoFegS7zxIAxmukzYhQMkOxabVaBXr-7pgzEeGYg>
    <xmx:NHIbYjsMqULnRM7KX41uarXnQs7LBYEdqIha0JhRFB39tpe55dZNZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:44:32 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, s.hauer@pengutronix.de, linux-imx@nxp.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v19 1/3] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Sun, 27 Feb 2022 22:44:23 +1000
Message-Id: <20220227124425.331030-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220227124425.331030-1-alistair@alistair23.me>
References: <20220227124425.331030-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.34.1

