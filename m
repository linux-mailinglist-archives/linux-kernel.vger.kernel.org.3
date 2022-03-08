Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205824D1A66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbiCHOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbiCHOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:25:23 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D249F92;
        Tue,  8 Mar 2022 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749467;
  x=1678285467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tK6Q1jDnBvijOHqCEkvoL00vEaJl4FM8rW1EITUDKrs=;
  b=ltNCn1criIAwWcvhYb4S7NnaH3fluZAvXzh65Pd3+sMtsNZHFChXA4Ro
   IypkuG9vitQ6QjH931nPRNR2WNMAhtpWHNWtEMq7zivlDuOTviqIcIvDU
   54OXk1IWIYHSQv0i15Fd2fzMNzMpE5qLtJ/BzgWSeOxCEgHlO51wkDtX9
   gXQeMQ39X0EAAYAZli70R2DZPC8FjDd8iLJtZMEiUZ2Qrn7eEe5Dl/hOl
   B79ggAr8nAbtCpbYevD5GfGSv2sOqnUUBM4jHmeWQ40Lg/JODeh/3zU3N
   rSpy6QSBsBdRVucbluuEmmF2J7FaY/R13PT/oGQpT724BqWk+NFmCretc
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@canonical.com>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT
Date:   Tue, 8 Mar 2022 15:24:07 +0100
Message-ID: <20220308142410.3193729-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SoC has an MCT with 4 global and 8 local timer interrupts, add a
specific compatible to match it as is done for the other platforms with
this hardware block.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2: New.  Requires Krzysztof's "dt-bindings: timer: exynos4210-mct: describe
        hardware and its interrupts".

 .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 1584944c7ac4..dce42f1f7574 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -25,6 +25,7 @@ properties:
           - samsung,exynos4412-mct
       - items:
           - enum:
+              - axis,artpec8-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -102,6 +103,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec8-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
-- 
2.34.1

