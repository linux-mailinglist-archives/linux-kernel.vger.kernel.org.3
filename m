Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D263F5AAA61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiIBInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiIBInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:43:10 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B09E6B9;
        Fri,  2 Sep 2022 01:43:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id EE41FDFEC1;
        Fri,  2 Sep 2022 01:42:39 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QYOPQjR-QD9P; Fri,  2 Sep 2022 01:42:39 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108159; bh=JakZJWZhM51HWNUPYm0nW2ELxI9hOSYdsE72l4TJkxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+nMpyav7GRNkNoPtp3/6UBlJD+4MSrUcutwbCfqPs+0gn95M5Tb4+H811VkucS/T
         UDHMFRMOpw5QrFWmESgi0M/L/pGYrLp7Z8zDbsR/RnW83NjMujwNgoxr0pEroroLAG
         TQHlVW2ye4Y8+0gWnt9COFUQoiG13leS3q/LR/kmDxupevRgDGwazFR2UNfQFAZxBs
         CzzAjtx3IUFL1bv1xl1mh2uVEaQHltkmcmquptvyVbxXYBUOAbA0yIjZ2FA6G5BAA8
         QT1iSxW07QYnDEGJNY1HRTTa2Ty0HwjUf8NPOxDEJqV22JZb2/1xRoVqIZMymp76l2
         1QGVDF1J5AusA==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 4/6] arm64: dts: imx8mq-librem5: add USB type-c properties for role switching
Date:   Fri,  2 Sep 2022 10:42:14 +0200
Message-Id: <20220902084216.1259202-5-martin.kepplinger@puri.sm>
In-Reply-To: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

Add the connector properties to the USB type-c stanza to enable (PD)
role-switching on the Librem 5 phone.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 7e6c4ad438092..f07d1c6e97777 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -773,6 +773,10 @@ typec_pd: usb-pd@3f {
 		interrupt-names = "irq";
 
 		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.30.2

