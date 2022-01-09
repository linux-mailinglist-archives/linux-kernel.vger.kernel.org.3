Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2F4888EC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiAILlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:41:44 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43059 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235315AbiAILln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:41:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 11EED580184;
        Sun,  9 Jan 2022 06:41:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 09 Jan 2022 06:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=nG8bOs8F336LG
        PIsiLK/Afxk6tT8J6l6oaR6iuHcX3Y=; b=rSfe0ATSzZZDQpE82n3l6oGld/DoS
        N/WUt60XIBbTT90LTMbxwhwrvkWXrhlr9zlWimYpIbHBIbgLqRmvieSgrFPbfId7
        lPN/yNwP2VFor7B7H+bJkrAPA3Kv1a2DoTVMvhHpn2zq2vQJsXukQV0rVXc7ZbEd
        tgmH6ua8cWc6JB3nLMPlINhT/2rEkuUhQRWFP1zXqORwcwz1eAR86kFss9qsexon
        sv/XtoJT35GVLV1MOFLnZrZJ4apXVTkr39e5fGjzaEQpWiBdv883IFDeIkUQUDqf
        49DPksYZpHuusfobksaPytoIXrT5tQcckjq0NPlT849bDxAOcFgtnLb1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nG8bOs8F336LGPIsiLK/Afxk6tT8J6l6oaR6iuHcX3Y=; b=QlMJ7kJ7
        rcCaGoGsAVHCkCF73X7GprlxzhSz1guXsP3Q/l1De0DOFCvhwNDHHIL+lfoYMltK
        bXbr8dnhujqQvQ7XZcQ43Px6J+gjdfW4RxreFSE9VvVno4FT5y85fBk49GE1aLmj
        DB4yHlA7t/tm96f0TK5nhq4yr5Ma0RPMwZ59jKed/kZTfD7Jam7bdSso9/iFEZQK
        cHuU32qinpvIkmywexZNyN+2NAC69EAvXRfBKQ5mHPT4h3Jd4ufXeslDS/MNjYui
        M/PdtaX9kzVzCCUGN15mKj5V9IkF2245zJ9vRrZmN9h1g7IPlEcs3ZzpHVgvBLy0
        eTsGqyU4/5ZklQ==
X-ME-Sender: <xms:9snaYVppNXSO84PHVlLzCySe17gjwOFEfczfeGf2zIn1C6L8xI5NlA>
    <xme:9snaYXrTUup6sWOS5Q7ONoZxmSLvGCSIzVIYuu5Jl0TlcZxHOYII4FPWWMTwo0d52
    1RAOqVp7TBkP10Gedg>
X-ME-Received: <xmr:9snaYSP_G-ch1cRd05TT8dYxlWVDjj7VZ9NXe2PH0flDVpaebdjrx4ROJCLu8gRd5QcgHghYrkuJY2D9ODGzbsGlDTR6gs6c69E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:9snaYQ6ATGHykdl66fi7MMLg-eEEcD2RXbRpGjE5R3Op-3YBhEd7Ag>
    <xmx:9snaYU7eypXeowZG1GZV6HX-SQel08th3YH0Nr_UVwUPp3bxxVqgrA>
    <xmx:9snaYYhX6R8j5bberhI5Eaj7y14IyrNzBMEnUDGIvE8WV8diC7FQ1w>
    <xmx:98naYUhcJNX7XPJKs6DC0dZDDIFiHwpJKLpdcNA7XRQtJwd0mPVLBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:41:36 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        shawnguo@kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/2] ARM: dts: imx7d: remarkable2: set ping-during-suspend for watchdog
Date:   Sun,  9 Jan 2022 21:41:20 +1000
Message-Id: <20220109114120.386013-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109114120.386013-1-alistair@alistair23.me>
References: <20220109114120.386013-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ping-during-suspend for the reMarkable watchdog timer to avoid the
device rebooting when asleep.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 89cbf13097a4..99a453108af7 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -115,6 +115,7 @@ &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
 	fsl,ext-reset-output;
+	fsl,ping-during-suspend;
 };
 
 &iomuxc {
-- 
2.31.1

