Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9BC57A97B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiGSVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiGSVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:51:53 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B56392B;
        Tue, 19 Jul 2022 14:51:50 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id l24so12933454ion.13;
        Tue, 19 Jul 2022 14:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dcyGfZlm3obzql4ixYHJRhEx8klSCMxz9XKF4iIR0DU=;
        b=AyZzKvRzmOLHiZ7cM7gKFWd86gsF2D3xm8OfTy/oqHkp0kWNziKqHL12qlOl+sFItK
         okzhEP8uYJ7oyNsVsrc06f0WXtDApb1vKBOtXojGYHiwTKv4J1X/CjBko7H1/kCl06s2
         rhjsjWRftuBpcuAFQAsSOxggwpyJlZGNSiE8Hf6I6dqye8HrYpdoCbqy1K2PjxsGU4zE
         XqsyX6fSsF0Bvd7kJaUWd9oLIZ3/t3QkzkR8Hi5XvqADCbzXX7HRtvM07T++s9ECIQqk
         CjB9XXFTi/6T1xTr5B5GNAfa5EYK9inqrJRGYrC0SGNZDwWkMvD/314C6ddA90yZjkSt
         s58A==
X-Gm-Message-State: AJIora9S48+aHwdqR0mLP6oXrLO9BftqsXYjBklkxRTJROSGsVBSigOf
        /weCV34MBSDmq/vT3vudud9CJYEEoA==
X-Google-Smtp-Source: AGRyM1vMHqrd31gyle8h59Be4LgPkz/USD3vqWagBxZkUmUntqsxRzTbYIDZ4BHIcHENl0M9R801aA==
X-Received: by 2002:a02:c90a:0:b0:33e:fde0:b76 with SMTP id t10-20020a02c90a000000b0033efde00b76mr18640286jao.81.1658267509734;
        Tue, 19 Jul 2022 14:51:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j2-20020a056e02124200b002dc9fdbf0a5sm5584640ilq.59.2022.07.19.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:51:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: rtc: microcrystal,rv3032: Add missing type to 'trickle-voltage-millivolt'
Date:   Tue, 19 Jul 2022 15:51:42 -0600
Message-Id: <20220719215143.1877566-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'trickle-voltage-millivolt' is missing a type definition. '-millivolt' is
not a standard unit (should be '-microvolt'). As the property is already
in use, add a type reference.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml
index 9593840a4a2b..60f9027e8299 100644
--- a/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml
@@ -32,6 +32,7 @@ properties:
       - 11000
 
   trickle-voltage-millivolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 1750
       - 3000
-- 
2.34.1

