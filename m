Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0555EB30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiF1RnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiF1Rm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:42:27 -0400
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90AA2B1BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656438121; bh=BwXMWIySOBrUTHj5EzTw/IjmxzQAGV/KhWD2NQgBX8U=;
        h=X-EA-Auth:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=QynlLMBjb1qAeVnlLgKgnZUZX6vSceM1hOwWDYsT3cYvkHmI69ibA99WQXEhIyhOA
         oP4Qa2tUMM2Zt0J8kINgsT8OocvJS/3zPRfkbpeTn0C4ralr3bibe0EUUojykiiHxw
         4YR9Lr3Zmi/e6W0POEiHedBunzMIHbtzb99jSqTM=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Tue, 28 Jun 2022 19:42:01 +0200 (CEST)
X-EA-Auth: eHiO7pkjdp6iKmf0wfbyHAAfez79KEvdzp+NIk361foUH2t28prp8lfg0M+BeS4IldoZVQVleZ6P0K7Kcat3p3XMaVJjGqosUHYKcLMktzA=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] dt-bindings: leds: is31fl319x: Add missing si-en compatibles
Date:   Tue, 28 Jun 2022 19:41:17 +0200
Message-Id: <20220628174124.2819238-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628174124.2819238-1-vincent.knecht@mailoo.org>
References: <20220628174124.2819238-1-vincent.knecht@mailoo.org>
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



