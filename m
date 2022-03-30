Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D384EBDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiC3Jnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244909AbiC3Jnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2801265E96;
        Wed, 30 Mar 2022 02:41:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 41D895C0108;
        Wed, 30 Mar 2022 05:41:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Mar 2022 05:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=68UmTFqIO831cq
        tqfLENUpFjsheRuDoRkQc2LFDMqM0=; b=rmivBDtuHpYnTGJBZhmD9ohnq0tblW
        MkGOfEK3FYYd06MXq7WH+BSN1F+oik3dkV2nv0Jl3dkX20vSxOnBxCpfNeQltYZR
        wdpLFmyMnUpS/kopxNncmkuY/7ERhraMcuftprvlOpIMiIl5TaYKgseKYYSV0/MV
        oSZfnN84vDOzPNUOewbAP1WwJ0676my2llxhb95AjSX1yAXJNZT//HdNpF0Nywuo
        FTBz8KmZNmWGBGvVCZqQx9cJvgj5nlVpakXE1xnIjc20B9ZhtQV6Ou0DVkG1l/Wr
        0viYBTeGpxO7E5c/Cun0Lwmjdqa5kVBd4YwwKh2LYyz0+qQouAcSC3gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=68UmTF
        qIO831cqtqfLENUpFjsheRuDoRkQc2LFDMqM0=; b=k8KfsjJQfFTdg8BNwtKNhC
        2uXDOgYkfnAZ6g1KFjQ+OiLrY0CCgBAUOj0wThWA99X3X1LloAIAh9PgSQSbzqnh
        J7QzvjKq7AAwqB93hL+p1yicT6lCePpq6rPs4FI9z29UFqKMX89mUAhPeYGm+Q1o
        fZkROmHZmFPE3Z0O0mld8rjMOQGXFPfCG1faOq3H09I8Ts0sFo63ODi2cJ/PzRZh
        aiaNtglEZapEkd+WRv6lXhUVFCydjoL6ZJuJq6dJm7T4CjHZEH7jEUjg06IN8/Jd
        KauvCKVmFhMHbHaXxzikpXL8xDo1RkeiDxtgc97wlURz6VtNlNwPZmZW9BFhqisw
        ==
X-ME-Sender: <xms:3SVEYvYb0O3f8smePeRuSWyCDy50-5B-EzY_XE2scf9zqPZgCYiOnA>
    <xme:3SVEYuYHeZ1-HkL46YMLg7XQ3Mz_PiIMipEP4WZoXUCb5OSPeV10gbajkYHRYkzXJ
    r-exBXpObtvL_kndTg>
X-ME-Received: <xmr:3SVEYh9ZCX1I5-eLz_rmqaaCH0uIKzhn240DDGWFv7gGJ98VENupvuSM6UqC0i9dT94LyUGQI38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:3SVEYlo4hPLlN_Q-RQ-g_3GcCCEGi3-34dWAuI0CHGxqoE0CrQkCWQ>
    <xmx:3SVEYqqeKEiUnxXG-EVR6cmqxKkIQ1KeZSCJyF3Df9i8rF09KCWPAQ>
    <xmx:3SVEYrTmdmlJaStGhA8PxFbEIBB9svt4sJ1c06wOvNQFwlqphEMAXA>
    <xmx:3iVEYviXGl8eBLHj0yav_4BP7lYukt2gPefRVCkiftu7KJ6lEyYmbA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 05:41:43 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-hwmon@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        amitk@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v20 2/4] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Wed, 30 Mar 2022 19:41:24 +1000
Message-Id: <20220330094126.30252-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330094126.30252-1-alistair@alistair23.me>
References: <20220330094126.30252-1-alistair@alistair23.me>
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
index f7498df08dfe..81fe604bf4ec 100644
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
@@ -238,6 +239,7 @@ CONFIG_MFD_DA9062=y
 CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
+CONFIG_MFD_SY7636A=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -251,6 +253,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.35.1

