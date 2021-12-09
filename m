Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5746E1C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhLIFOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:14:01 -0500
Received: from marcansoft.com ([212.63.210.85]:35016 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhLIFN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:13:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 79A7A41EA2;
        Thu,  9 Dec 2021 05:10:21 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: pinctrl: apple,pinctrl: Add apple,t6000-pinctrl compatible
Date:   Thu,  9 Dec 2021 14:10:01 +0900
Message-Id: <20211209051001.70235-5-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209051001.70235-1-marcan@marcan.st>
References: <20211209051001.70235-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new SoC uses the same pinctrl hardware, so just add a new per-SoC
compatible.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 6ca59974664e..d3b11351ca45 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -17,7 +17,9 @@ description: |
 properties:
   compatible:
     items:
-      - const: apple,t8103-pinctrl
+      - enum:
+          - apple,t8103-pinctrl
+          - apple,t6000-pinctrl
       - const: apple,pinctrl
 
   reg:
-- 
2.33.0

