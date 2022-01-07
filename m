Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1224948709E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbiAGCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:40:22 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:13523 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbiAGCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:40:20 -0500
Received: from droid10-sz.amlogic.com (10.28.8.20) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 7 Jan 2022
 10:40:17 +0800
From:   Zelong Dong <zelong.dong@amlogic.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <khilman@baylibre.com>, <narmstrong@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: reset: Add compatible for Meson-S4 Reset Controller
Date:   Fri, 7 Jan 2022 10:39:29 +0800
Message-ID: <20220107023931.13251-2-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107023931.13251-1-zelong.dong@amlogic.com>
References: <20220107023931.13251-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.20]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for Amlogic's Meson-S4 Reset Controller

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index 92922d3afd14..494a454928ce 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -17,6 +17,7 @@ properties:
       - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
       - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
       - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
+      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
 
   reg:
     maxItems: 1
-- 
2.34.1

