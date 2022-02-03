Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63244A8313
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbiBCLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:23:42 -0500
Received: from muru.com ([72.249.23.125]:45928 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbiBCLXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:23:42 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6404180EE;
        Thu,  3 Feb 2022 11:23:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 1/3] dt-bindings: omap: Add clock-output-names and #clock-cells
Date:   Thu,  3 Feb 2022 13:23:35 +0200
Message-Id: <20220203112337.19821-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to use clock-output-names for the clock manager instance
name instead of relying on non-standard node names.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/arm/omap/prcm.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -31,12 +31,17 @@ Required properties:
 		(base address and length)
 - clocks:	clocks for this module
 - clockdomains:	clockdomains for this module
+- #clock-cells: From common clock binding
+- clock-output-names: From common clock binding
+
 
 Example:
 
-cm: cm@48004000 {
+cm: clock@48004000 {
 	compatible = "ti,omap3-cm";
 	reg = <0x48004000 0x4000>;
+	#clock-cells = <0>;
+	clock-output-names = "cm";
 
 	cm_clocks: clocks {
 		#address-cells = <1>;
-- 
2.35.1
