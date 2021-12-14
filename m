Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF5474AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhLNS1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45120 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhLNS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE8A616A0;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BA2C34607;
        Tue, 14 Dec 2021 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506420;
        bh=aJHCgMacXpRVWXn7mJ31w116FEaIhCRiKhktss7HZbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYMZ6+Bt/zCVqdRA+Rh0iZsLtwNlVo+eKollD1MKnL0fiBjDfiwuXqaz42qGsp3Sy
         l1QOpa2NrPI9WOsDNoQdd/NOTcFH+m80hKBUzeusFzDKyj7IgDP2gZ6mUnMU/4UIHK
         wceTSjdjS4xTmVT5XkshAvSWtPZOA+HhTe8+eNnQl9GVCjVh9ZtwOr5mJ2DwiE3NdU
         HmIxMJU+Rhls+92yo1NS0IUBbzvWCrgwAOMT+GY7wyt/zkbaxI6Ee4TTQMAnjv/dcB
         iDwCssNDYidOTEpYjxpUGPqcewHo/soG+SxQUHWEaMESzinclrISshFesPVMTOKRod
         w64T7dNcygNrQ==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVu-00C7Tq-Hc; Tue, 14 Dec 2021 18:26:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 01/10] dt-bindings: arm-pmu: Document Apple PMU compatible strings
Date:   Tue, 14 Dec 2021 18:26:25 +0000
Message-Id: <20211214182634.727330-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214182634.727330-1-maz@kernel.org>
References: <20211214182634.727330-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to add support fur the Apple PMUs, document the compatible
strings associated with the two micro-architectures present in the Apple M1.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index e17ac049e890..1a6986b4e552 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -20,6 +20,8 @@ properties:
     items:
       - enum:
           - apm,potenza-pmu
+          - apple,firestorm-pmu
+          - apple,icestorm-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu
-- 
2.30.2

