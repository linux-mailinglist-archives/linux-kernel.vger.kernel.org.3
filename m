Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D564A830F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350197AbiBCLXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:23:46 -0500
Received: from muru.com ([72.249.23.125]:45938 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbiBCLXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:23:43 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0D7368150;
        Thu,  3 Feb 2022 11:23:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 2/3] dt-bindings: clock: ti: Add clock-output-names for clockctrl
Date:   Thu,  3 Feb 2022 13:23:36 +0200
Message-Id: <20220203112337.19821-2-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203112337.19821-1-tony@atomide.com>
References: <20220203112337.19821-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to use clock-output-names for the clockctrl instance
name instead of relying on a custom compatible or non-standard node
names.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/clock/ti-clkctrl.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
--- a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
+++ b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
@@ -21,6 +21,7 @@ Required properties :
 	       "ti,clkctrl-l4-per"
 	       "ti,clkctrl-l4-secure"
 	       "ti,clkctrl-l4-wkup"
+- clock-output-names : from common clock binding
 - #clock-cells : shall contain 2 with the first entry being the instance
 		 offset from the clock domain base and the second being the
 		 clock index
@@ -32,7 +33,8 @@ Example: Clock controller node on omap 4430:
 	l4per: cm@1400 {
 		cm_l4per@0 {
 			cm_l4per_clkctrl: clock@20 {
-				compatible = "ti,clkctrl-l4-per", "ti,clkctrl";
+				compatible = "ti,clkctrl";
+				clock-output-names = "l4_per";
 				reg = <0x20 0x1b0>;
 				#clock-cells = <2>;
 			};
-- 
2.35.1
