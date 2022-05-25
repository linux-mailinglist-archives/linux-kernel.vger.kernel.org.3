Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F0533C16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiEYL4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbiEYL4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:56:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3EC38A7;
        Wed, 25 May 2022 04:56:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D8F475C027E;
        Wed, 25 May 2022 07:56:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 May 2022 07:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653479775; x=
        1653566175; bh=2+KoNBAK1Qn+kzqXC6ldLIVvqsTMBGa618ttf6rHbrk=; b=T
        Jvt693/Gnxlsr/vT5AEvcnbUr56DtwGGanP+3OmQ7VBAm6HiFF0e/HDcXaeHOUzF
        C32k7fnHZ/05ncV3d8VLJVwDnWJuAV3o5SXx9q/KiL0GEg8IQWaev6meLcNVOSjE
        DixdnTojb0OOysqqQVaWHmdNPm7MKz8yLUmGjlqAbM6ZUMV/v47JVAI9xt/hmYGK
        v3TGfLcZNR2sJtWRmyC1cRlL5CmxQglhHEEzA1fIBgKrkFThl9cfIWpcqtb5fmG7
        GzIyULByxA0v3v/0kwONt9xSaM6kebNdpIa3z5XoFk2+Kq2ItwTA+Q32ldIIijEL
        AyCAIsMJ1VO59cDxVjTGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653479775; x=1653566175; bh=2+KoNBAK1Qn+k
        zqXC6ldLIVvqsTMBGa618ttf6rHbrk=; b=OfFFrq8s1YvhhuWhfLp6jHgvpmw16
        sRAm5KHVRUhCxgi1ShB8ng05NNRtuvW1slPX4zWhn3qZ6sfnOXYN1SoX8WKNgs4z
        qd//xqWZO09Ev3v7i1x1sFWl5ZwNnRcAQCucD7tgp4K+px5T+pJ6oXkFzgVcMd3C
        DOMJGFFhuLclE7w9hHf44igeHYC1yBSAosjGKlI3m5SY/Yxj7kVMjtFOmrWSbtKl
        +/qXgypIHyyfsc9K+LIWxXde934TfNhKxiN/mwE0OQvjsRQUeJnCjexKDYt+TFFd
        KTwQnEW7xFjou9ldibRmOovhwNLmP61SUXhuri2lDjim1jz9wlAfzVMqA==
X-ME-Sender: <xms:XxmOYgrVZ-NsIuT5R_8rTaW7t5EP_z2HexxdqznQbjgLNtKrYIZ4wQ>
    <xme:XxmOYmrNynVlZ7ftqHXPmqM1ijLWERU6dT4yqGxr2_Qh08Z_j00O62Hrq5WkmOdNt
    UMuvr6nU_fHXg018LI>
X-ME-Received: <xmr:XxmOYlMK_5wvYpGaMqZ6WKPAAcwfZOE9hlDQXGgwdLmSQRd1HnJg8J4SXhPsg9HZvqSiXH_QG4UX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:XxmOYn5jRb_acCPrKkTaa-DKhQoZcMJ4FnXR-q1QqW08fUHgI9iZyQ>
    <xmx:XxmOYv5UWgBmeRPWVHd0ureaiK9iT0vGoTyox0DSSssA2Qp3VU0LIg>
    <xmx:XxmOYngA4W20hVL4Q8PJQFYV-J8Ivk_ZCrNE3g7AmE2VYa7sVrzOKQ>
    <xmx:XxmOYswh-hsDUW2lyClI460elVXeTIZ9rKJlcj76JbcYsZWsmrBvyQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 07:56:09 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, lee.jones@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v21 2/4] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Wed, 25 May 2022 21:55:52 +1000
Message-Id: <20220525115554.430971-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525115554.430971-1-alistair@alistair23.me>
References: <20220525115554.430971-1-alistair@alistair23.me>
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
2.35.3

