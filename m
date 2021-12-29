Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11614813AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbhL2Nya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:54:30 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:37701 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhL2Ny3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:54:29 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Wed, 29 Dec 2021
 21:54:19 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V2 3/6] dt-bindings: serial: meson: Support S4 SoC uart. Also Drop compatible = amlogic,meson-gx-uart.
Date:   Wed, 29 Dec 2021 21:53:47 +0800
Message-ID: <20211229135350.9659-4-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211229135350.9659-1-yu.tu@amlogic.com>
References: <20211229135350.9659-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecated, don't use anymore because compatible = amlogic,meson-gx-uart
don't differentiate between GXBB and GXL which have different
revisions of the UART IP. So it's split into GXBB and GXL.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 75ebc9952a99..b03040a83a9f 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -28,14 +28,20 @@ properties:
               - amlogic,meson6-uart
               - amlogic,meson8-uart
               - amlogic,meson8b-uart
-              - amlogic,meson-gx-uart
+              - amlogic,meson-gxbb-uart
+              - amlogic,meson-gxl-uart
+              - amlogic,meson-g12a-uart
+              - amlogic,meson-s4-uart
           - const: amlogic,meson-ao-uart
       - description: Everything-Else power domain UART controller
         enum:
           - amlogic,meson6-uart
           - amlogic,meson8-uart
           - amlogic,meson8b-uart
-          - amlogic,meson-gx-uart
+          - amlogic,meson-gxbb-uart
+          - amlogic,meson-gxl-uart
+          - amlogic,meson-g12a-uart
+          - amlogic,meson-s4-uart
 
   reg:
     maxItems: 1
-- 
2.33.1

