Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E080147641F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhLOVDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhLOVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:01 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FADC06173F;
        Wed, 15 Dec 2021 13:03:01 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 8so23249808qtx.5;
        Wed, 15 Dec 2021 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qtvoh3tWKPnOw1Z92Liu2Y3L35YeCARO/v2RhKvSqa0=;
        b=mtzYePaF3q6HIoiwUrD0Qpoz7PMauWz+vbmYJ+etGbJ+OJRihIBkniO1SJtHiYRvBA
         IWAyQW69QJiqB8j5Nx4u0aivp7TATGW+K6mrQAjEeEDN5q1V5kbNCR9vDoKFgOGr47Ol
         NXJcJIpg6es+Ku0I6+uFDD2KW2nx3T0zXhQKr5sOuZ3d6pZ1ntQ3lY86HAy/4NCQEess
         bpOhLYfvUo5wSZFFowYAcCig4XlKqjKf99PPPd1cZdXk6dsnBv/USG70cVj9Rfrzm/65
         FqunVFl+qqIxwchUM4kipSLPbISHrIKn4BdcgWzz1bUbQPIGW06zFWJCpuMfjYuzsb6R
         xNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qtvoh3tWKPnOw1Z92Liu2Y3L35YeCARO/v2RhKvSqa0=;
        b=gF28N8VZcVcWeTcKejLoSbsVfoIMJICbATmPq88u5EaUqbURYf9lzLUmiQ/GDs2TcR
         wf1+12HpSA0pAY6BFOliC+Yvn6tZnbeoPLf4poFtQOdek4fGmibeNi7SEcWOLuRXXvOR
         1sPcLpH7/ZBjPNsnP9llu0TbTdTnYSgVvqVJA974gB91J4zzUKAAJDZusVs+a0r/CxKS
         W0X/KGY0SItprqroD7ELeuDF4y4jNlK2BA7SZ0PZjFULBYmn/Cb6Peib/QQ85Qzt1CHB
         tn9CuYX/qGDBSGHpplVSXsP8CTVQAIOcR5vCisqofNnalyCOFV/o9bVUjPH3LseaNm0J
         JAhQ==
X-Gm-Message-State: AOAM531HmoVyLiX1l3sGTrXHn58XJcgTT0LDYFlNE76DVFRdhBwfBXxN
        nSEhiotBgI9AEeMs8C8ouGs=
X-Google-Smtp-Source: ABdhPJzCgrybsdVfbHcMg+6x0kMS2UAJKkjdtqiz97/N6CuLvJ+knNOQtRgNMNMWkdBoAQCjKsaXuA==
X-Received: by 2002:ac8:5e4a:: with SMTP id i10mr14343170qtx.569.1639602180345;
        Wed, 15 Dec 2021 13:03:00 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:02:59 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
Date:   Wed, 15 Dec 2021 16:02:46 -0500
Message-Id: <20211215210252.120923-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy node is a standalone node with a single muxed
interrupt.
Add documentation for it to phy-rockchip-inno-usb2.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

This was the best solution I've come up with for this.
I avoided creating another binding since this is such a simple change to
the actual driver and would likely require renaming the existing
binding.
I've tested that this correctly flags if the interrupts are missing or
incorrectly assigned on both rk356x and rk3399.

Thank you Johan and Rob for your constructive feedback.

 .../bindings/phy/phy-rockchip-inno-usb2.yaml  | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index 5bebd86bf8b6..4b75289735eb 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -18,6 +18,7 @@ properties:
       - rockchip,rk3328-usb2phy
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
+      - rockchip,rk3568-usb2phy
       - rockchip,rv1108-usb2phy
 
   reg:
@@ -50,6 +51,10 @@ properties:
     description:
       Phandle to the extcon device providing the cable state for the otg phy.
 
+  interrupts:
+    description: Muxed interrupt for both ports
+    maxItems: 1
+
   rockchip,usbgrf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -67,6 +72,7 @@ properties:
 
       interrupts:
         description: host linestate interrupt
+        maxItems: 1
 
       interrupt-names:
         const: linestate
@@ -78,8 +84,6 @@ properties:
 
     required:
       - "#phy-cells"
-      - interrupts
-      - interrupt-names
 
   otg-port:
     type: object
@@ -109,8 +113,6 @@ properties:
 
     required:
       - "#phy-cells"
-      - interrupts
-      - interrupt-names
 
 required:
   - compatible
@@ -120,6 +122,40 @@ required:
   - host-port
   - otg-port
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-usb2phy
+
+    then:
+      properties:
+        host-port:
+          properties:
+            interrupts: false
+
+        otg-port:
+          properties:
+            interrupts: false
+
+      required:
+        - interrupts
+
+    else:
+      properties:
+        interrupts: false
+
+        host-port:
+          required:
+            - interrupts
+            - interrupt-names
+
+        otg-port:
+          required:
+            - interrupts
+            - interrupt-names
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

