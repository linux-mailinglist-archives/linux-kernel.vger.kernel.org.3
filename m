Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63184713D1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 13:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhLKMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 07:40:53 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51681 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhLKMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 07:40:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 673DB320210E;
        Sat, 11 Dec 2021 07:40:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 11 Dec 2021 07:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=etmSmuHQy4+c+u468+BrAn+HWX
        TE3u6TRE2AWVtCPec=; b=hLkzpOLJUeQTTDloTTW8r95Jd2qpOCr3VYM9l8aNPl
        YKv7551ZWn6YQQM+WWPARwioNSvU/fjJuii4YJKG62hl8HseTKwDL2UfVEuma/rP
        eoQacD+Rf2osiCBWo12xQCf069Uyn3vEzdIsZ8oCRENCEuN7C6UHliZ9GsjWyqBU
        G7n8OPAGxRXZLWbW7Cb2jdb3DhvPnfbh+2mcc9KCWCTMDV6QUnv8RfSaSkDZKbSO
        H0poKA372wV4ptqs/woF9p0V1rLpuh4a/0du+WYvkAfFpWF+BJ9Rx0+rLWmyYTcd
        kPjjNb5D/EAPr6ipbBeqqIp0YmYjvGWTic81Lz+0oGFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=etmSmuHQy4+c+u468
        +BrAn+HWXTE3u6TRE2AWVtCPec=; b=EzmLr2Bdfy5V1fHSuQyJ+mjztj67S5Mqo
        2dXNOW1Zh0dNjw2kbudvd0j0Ompou6RFMqid5fOZKa0124ShleNRnUT21QuY9vF0
        lcVvI4OEHfPTRdX0MFWZMA0+orxPMjcuz8JyA+hMHC/aJJOnzI90t5XVq3Gk13J+
        nsG+978q5fKAmZCK6zg42QxOfj8ntzYXbsT+Ks/MkcZcwyat+/JDJKrf/EmbRSDr
        PZOkqXduQ3mUMnpgiILWQhBEDkNbjGyxvHfqCUXFD/sV1ogonHHa23nZlCwtY4Bj
        lFiL4jAKXMNcrtG93U1rK15XAxYNadN6YTp5v+ekCFMm/lHBCXj+g==
X-ME-Sender: <xms:Upy0YaZiuBBaIQ5iR8Q8CnXx9f41L42Q480Bm8tunPVxVxzb02o9Ag>
    <xme:Upy0YdZAIfSKAe6yOSmWy23huv7P7lS_6RKPZ2XSrvfvZ2rkN-BR3XhEx1VKCrvDO
    6dCcJsk76XUAdRGWXU>
X-ME-Received: <xmr:Upy0YU83ESMHaSa0rRV3NMvCi9clM32CYiCKC32K_XrDZW60fTCSC6nrm7gS80Eb6gXkpHA-tZNcZKdfgkcwpgJQhLGmPzsp5zV4XdlUjRi3XSRrw9mgaqtL0ff2NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    eugfelkedvtdejffefjeehveelfeevkefgudduhfeghfefgedtheevjeefffffgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhessh
    hvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Upy0YcryvClt63K1SLj-MEFa8kDLUeuAq4Rx_bg2ag5QLTMmqgXoTA>
    <xmx:Upy0YVqgEMKPLSGgmJb0d5nuw_67yt6PUF6jU6O7312QbooGWS1ILQ>
    <xmx:Upy0YaS-A_Egw4UD5aey5oY2_1pdCQjWTzpzdXbJttHwvxbMeq3GIg>
    <xmx:Upy0YeAJNsg2cdeYdI-8qcl8R3aBcCeFpgebveCIfPz3FmPnJ3ixBw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Dec 2021 07:40:49 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: apple: t8103: Add watchdog node
Date:   Sat, 11 Dec 2021 13:40:44 +0100
Message-Id: <20211211124044.4697-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the watchdog node which also enables reboot support on the t8103.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index fc8b2bb06ffe..6ef28d833e4f 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -199,6 +199,14 @@ pinctrl_nub: pinctrl@23d1f0000 {
 				     <AIC_IRQ 336 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		wdt: watchdog@23d2b0000 {
+			compatible = "apple,t8103-wdt", "apple,wdt";
+			reg = <0x2 0x3d2b0000 0x0 0x4000>;
+			clocks = <&clk24>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 338 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pinctrl_smc: pinctrl@23e820000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3e820000 0x0 0x4000>;
-- 
2.25.1

