Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B785E4C5B14
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiB0Mlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB0Mlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:41:35 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747206D1BB;
        Sun, 27 Feb 2022 04:40:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CD30D580225;
        Sun, 27 Feb 2022 07:33:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 27 Feb 2022 07:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=oa3rt+5mRji0qS
        Zmd+ZP6PfKE+At2xRfDzTBnRo+c+Q=; b=PYt/bWUWDHeAEQ4JHkBJICv5+7Q3rT
        T1gv6zhDeKz8TMWy3flqrErB+Ea8s9WLDKVQ+i4YOO2nDr/TXLsLJoyLk8bkghAF
        T8exCgDYha5N8Z7CU4oQnI5sbkKpaZmb4gmjJfKmeEDLcPIQCzJi28LSEbuL77IH
        YQYA8L6RcQKvRJIaOmBf12cJXEHZ8lA7CDT5O8DaXMHczKB2eL4+p/FjSlW9RC8+
        O5+0b9rV69QVSPKrPlb1cjlTWT2ctcPGkf51pfLrXqiIdvmCPD1m9rhAaiex0it3
        pdnCfS1PubxC3jcSeZ75phIdg0ozfHUZiG4htKmipTR3vJSHmu9s3SRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oa3rt+
        5mRji0qSZmd+ZP6PfKE+At2xRfDzTBnRo+c+Q=; b=Vp+rQpiz3rmIT/vyov766P
        5RhL1jLK/JuaXS6MtE1u3opIo+vtVG1uCcdlj0riJ00Y09+6N4yScjuYRQMA8X+R
        bcBm9pwQZCsiDF+rufgQOSWN16OMdWWUVUgrZhHVrd1/EhyGXx18sIra0zWbBpiU
        WAopL7mG5mUPBdFEHK+eCJbnS1X/KX6UUn5BUyiEy/+D4/3DwkN11vIjPa0+EGWl
        /sqPbMtRayfiyyPMuR5HEhqmcqtlN/oveIcNXBeULRpVAhyj6XLiO4rtH2NDbsJW
        RMh2J8j9IaXjY7f2yfxzEn7T+bP7YeQgfXa0GH7HYrIqKvP8O1Y8fkh0DcFGueUg
        ==
X-ME-Sender: <xms:o28bYmlqrMOkNpXc-jUbwxZDSHN22mXIe-GdVH7Ab8OGFDZ76BAQ7w>
    <xme:o28bYt3AxaZAbFDSi_PGraUrgd6Z__jXItcsSwvCXZo1jrt5XczyHjN4urKmqIp8v
    nquXg6PiHmuiGTzn1w>
X-ME-Received: <xmr:o28bYkoElhYKbOjdVeycjsMwZyZB8-o5dgvvx_vFzB_t1ug-6OM76AqtsFSCntFDxXPsoocrwYde8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:o28bYqm71cphNT5BuJF-VKbFJsX-FxY3s1fFxx16AJcPNJZ7VnEYkQ>
    <xmx:o28bYk2Bqi1MrePYwCaQV086Hc80cL65280r1fzE3fUP9-1IFZzXFg>
    <xmx:o28bYhvYphvQQywdURw2OduD3vPBbxak8TxEBHjKW_H1n90EHU87Lw>
    <xmx:o28bYqwYZbEflYj9LrnbCG6i8m7JaNeBfmKaTNA8dfvyfY00WLxsTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:33:35 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Sun, 27 Feb 2022 22:33:17 +1000
Message-Id: <20220227123318.313009-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220227123318.313009-1-alistair@alistair23.me>
References: <20220227123318.313009-1-alistair@alistair23.me>
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

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f7498df08dfe..f5d263e79aa5 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_AD7879=y
 CONFIG_TOUCHSCREEN_AD7879_I2C=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_CYTTSP5=y
 CONFIG_TOUCHSCREEN_DA9052=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_GOODIX=y
-- 
2.34.1

