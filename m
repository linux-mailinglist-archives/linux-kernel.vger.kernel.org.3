Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553655EC74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiF1SWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiF1SWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:22:13 -0400
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63020BD3;
        Tue, 28 Jun 2022 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656440518; bh=BwXMWIySOBrUTHj5EzTw/IjmxzQAGV/KhWD2NQgBX8U=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=dh2quHRrdkd17nyMObFeABozwAa6nmA2E9vHEkyCc8nm7XulgH9bwdik9TltK05c7
         laE5mQ0U+CLLjVVK54PEtGt5DcnUMfCTFjCHCrUdFWg4nk3NlsbL+WWyxWhvSUrpsR
         E2nUrumntWXwugrGLy3mEpsZu0UA/lFUvuaiMBpo=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Tue, 28 Jun 2022 20:21:58 +0200 (CEST)
X-EA-Auth: oizRUETPIpBP5pyOwA8CVbiq+6BHYnBPAaeUc57JFlCpERlLazx1GaTQH90VvTnQEro/M/zB7TiyNbI4YflLLsF8c4EZZZJheGDecljj6Ok=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v1 RESEND 2/7] dt-bindings: leds: is31fl319x: Add missing si-en compatibles
Date:   Tue, 28 Jun 2022 20:21:40 +0200
Message-Id: <20220628182147.2837180-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add si-en compatibles for all chip variants.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 0d684aeeb8cd..155df2e5cbd5 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -28,6 +28,10 @@ properties:
       - issi,is31fl3193
       - issi,is31fl3196
       - issi,is31fl3199
+      - si-en,sn3190
+      - si-en,sn3191
+      - si-en,sn3193
+      - si-en,sn3196
       - si-en,sn3199
 
   reg:
-- 
2.35.3



