Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467B4993CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387191AbiAXUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:36:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379804AbiAXUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:12:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 510AFB810AF;
        Mon, 24 Jan 2022 20:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF883C340EB;
        Mon, 24 Jan 2022 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055158;
        bh=46GvYvu2qBY0XJLufv8o7VnMQWHTSSvKJFHbggT3hWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzqZtHU43pqSF9cnPOVi8OzU/ekycmEQngryg7+eDdRwKqRJX2qpAum18krWHJGuf
         5GqY3AfzVo+a5osEltJIsNqoz6lIsgLpVcAImdP7V5wvCkHZEsK7iswC2qVdhLy5NB
         TVv3rzPluMu3sGx9D/eX39AR5Evih3nlB6i1DFMJBB1iTYunHgWMUQqNnqmvHxTP7U
         PtzOuGJV0TEQPEzosRtaaa+/2Gl6FA9rCQ6ZIY6zfmyPyhL9m6G4sxfdU8DNBcARDt
         c5IYIPwMeWVuEfg5J6eKvKjZ2sTsQsXeZi9lLj5n+YScKJgy/UXjuAwmYEyhhScvpL
         bUOkTXBBFCMSg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hc-002Y3f-0D; Mon, 24 Jan 2022 20:12:36 +0000
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
Subject: [PATCH v4 01/10] dt-bindings: arm-pmu: Document Apple PMU compatible strings
Date:   Mon, 24 Jan 2022 20:12:22 +0000
Message-Id: <20220124201231.298961-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
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
index 981bac451698..7a04b8aaaec3 100644
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

