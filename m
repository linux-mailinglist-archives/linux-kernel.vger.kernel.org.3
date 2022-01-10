Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87FE489692
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiAJKmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:42:50 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:41675 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbiAJKmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:42:47 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 10 Jan 2022
 18:42:44 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V5 1/5] dt-bindings: serial: meson: Drop legacy compatible.
Date:   Mon, 10 Jan 2022 18:42:10 +0800
Message-ID: <20220110104214.25321-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110104214.25321-1-yu.tu@amlogic.com>
References: <20220110104214.25321-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecated, don't use anymore because legacy amlogic,meson-gx-uart
compatible. Don't differentiate between GXBB, GXL and G12A which
have different revisions of the UART IP. So it's split into
GXBB,GXL and G12A.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 72e8868db3e0..ad9f1f4537a0 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -28,7 +28,10 @@ properties:
               - amlogic,meson6-uart
               - amlogic,meson8-uart
               - amlogic,meson8b-uart
-              - amlogic,meson-gx-uart
+              - amlogic,meson-gx-uart # deprecated, use revision specific property below
+              - amlogic,meson-gxbb-uart
+              - amlogic,meson-gxl-uart
+              - amlogic,meson-g12a-uart
               - amlogic,meson-s4-uart
           - const: amlogic,meson-ao-uart
       - description: Everything-Else power domain UART controller
@@ -36,7 +39,10 @@ properties:
           - amlogic,meson6-uart
           - amlogic,meson8-uart
           - amlogic,meson8b-uart
-          - amlogic,meson-gx-uart
+          - amlogic,meson-gx-uart # deprecated, use revision specific property below
+          - amlogic,meson-gxbb-uart
+          - amlogic,meson-gxl-uart
+          - amlogic,meson-g12a-uart
           - amlogic,meson-s4-uart
 
   reg:
-- 
2.33.1

