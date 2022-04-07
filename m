Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF54F7806
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiDGHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242174AbiDGHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:47:42 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E76E6A27FB;
        Thu,  7 Apr 2022 00:45:41 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Apr 2022 16:45:41 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 641502058B50;
        Thu,  7 Apr 2022 16:45:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Apr 2022 16:45:41 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 941D3B6395;
        Thu,  7 Apr 2022 16:45:40 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: thermal: uniphier: Use unevaluatedProperties and common bindings
Date:   Thu,  7 Apr 2022 16:45:33 +0900
Message-Id: <1649317533-21139-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds common bindings thermal-sensor.yaml and this is preferred for
unevaluatedProperties instead of additionalProperties.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/thermal/socionext,uniphier-thermal.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
index c5b25ce44956..537c93da1397 100644
--- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -14,6 +14,9 @@ description: |
 maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
+allOf:
+  - $ref: "thermal-sensor.yaml#"
+
 properties:
   compatible:
     enum:
@@ -40,7 +43,7 @@ required:
   - interrupts
   - "#thermal-sensor-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1

