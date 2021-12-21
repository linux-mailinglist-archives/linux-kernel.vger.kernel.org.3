Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2500947B8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhLUDBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:01:51 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:34005 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhLUDBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:01:50 -0500
Received: from droid04.amlogic.com (10.18.11.246) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 21 Dec 2021
 11:01:47 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V2] dt-bindings: serial: amlogic, meson-uart: support S4
Date:   Tue, 21 Dec 2021 11:01:45 +0800
Message-ID: <20211221030146.522-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.246]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add serial bindings support menson S4 SoC family.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
V1 -> V2 : update author name
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 7487aa6ef849..72e8868db3e0 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -29,6 +29,7 @@ properties:
               - amlogic,meson8-uart
               - amlogic,meson8b-uart
               - amlogic,meson-gx-uart
+              - amlogic,meson-s4-uart
           - const: amlogic,meson-ao-uart
       - description: Everything-Else power domain UART controller
         enum:
@@ -36,6 +37,7 @@ properties:
           - amlogic,meson8-uart
           - amlogic,meson8b-uart
           - amlogic,meson-gx-uart
+          - amlogic,meson-s4-uart
 
   reg:
     maxItems: 1

base-commit: 84184107c39ae65d08f6d449a57ec58734ff535a
-- 
2.30.2

