Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262D4F780B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiDGHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiDGHsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:48:51 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3310E9C8A;
        Thu,  7 Apr 2022 00:46:51 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Apr 2022 16:46:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 24A852058443;
        Thu,  7 Apr 2022 16:46:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Apr 2022 16:46:51 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5DD5DB62B7;
        Thu,  7 Apr 2022 16:46:50 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: watchdog: uniphier: Use unevaluatedProperties
Date:   Thu,  7 Apr 2022 16:46:46 +0900
Message-Id: <1649317606-21267-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refers common bindings, so this is preferred for
unevaluatedProperties instead of additionalProperties.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
index a059d16cb4f2..90698cfa8f94 100644
--- a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
@@ -19,7 +19,7 @@ properties:
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1

