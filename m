Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B25A7877
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiHaIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiHaIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:04:33 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82BC2763;
        Wed, 31 Aug 2022 01:04:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C8533DF7B9;
        Wed, 31 Aug 2022 01:03:39 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NOHJfuXF6lx0; Wed, 31 Aug 2022 01:03:39 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661933019; bh=DQ/1CIw/oRT/yUMubPfJpRx1jO/PQf/biyb80OqjBJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SG1iU1elUMM+QptXN2jE4eC1tK1riPbTd+IC5o9p4/nlRI6mGFU/B/aFMbEhBfyjW
         7UhChIxdzbbO7WFg+/igCv0TauSSpBzbIuY2iHBsHha8u17r1DTm2qKbIMMI0NzqkF
         mjIXOadbrhwdOVnTQaQsMGsCc7Oe+j3MJK0Klj2q5kZ3e7D7tk4wacyNo/9bbrb2F/
         5m0NOeuuc8agqGTO0MVT987CE9EIhBr1lb7BVYM881oCZusi9PRAVJSRZqfiy6wp24
         6GIeseCS99nzoWHz6y/316gtN3lHPLqDRHfkZ3LQKp7p0fuYVwfG3vW4fA0kOOBJki
         OpvWOmX/cN60g==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v1 4/5] arm64: dts: imx8mq-librem5: add USB type-c properties for role switching
Date:   Wed, 31 Aug 2022 10:03:00 +0200
Message-Id: <20220831080301.1092737-5-martin.kepplinger@puri.sm>
In-Reply-To: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
References: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
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
index 996930d72d209..d5c7c35d2e85f 100644
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

