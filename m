Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DD2475AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhLOOpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:45:13 -0500
Received: from ixit.cz ([94.230.151.217]:57530 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhLOOpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:45:12 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D28812243C;
        Wed, 15 Dec 2021 15:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639579510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KgrfzqPcwcbEdQTP/IsIyd9Cb/Q6naiYwHO1cYZtjmI=;
        b=que4/kenTmNg9ZD/pHL0733A4WZjscxE5vJP7j9zTm703QSbjoe+y1mWc8e7Pm2PgXoT2E
        IR4LLFCnmkbDYdwuHqBGmHmLhGKKnK54+PoEZIpZ38tiA53GHv56gOeQe3+J/EEV+QDoim
        zWKYSxYO2VRSoeImkpaKIxjxVHCgQPg=
From:   David Heidelberg <david@ixit.cz>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: add #size-cells 2 for ARM
Date:   Wed, 15 Dec 2021 15:45:00 +0100
Message-Id: <20211215144500.64284-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's already widely used by dt-schemas, so I blindly assume it's correct.

Fixes warnings as:
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: timer@17c90000: #size-cells:0:0: 1 was expected
        From schema: Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
index cd2176cad53a..c061bb90b8e7 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -30,7 +30,7 @@ properties:
     enum: [1, 2]
 
   '#size-cells':
-    const: 1
+    enum: [1, 2]
 
   ranges: true
 
-- 
2.34.1

