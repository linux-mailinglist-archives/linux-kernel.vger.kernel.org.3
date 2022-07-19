Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0157A95F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiGSVu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiGSVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:50:18 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C70121272;
        Tue, 19 Jul 2022 14:50:16 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id x64so4591129iof.1;
        Tue, 19 Jul 2022 14:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gK0kv8pzfi7sBWv/sRFwiBZu8X91coIITSZKvB6RExY=;
        b=BIJ4JJ1Rv9DJUQ1tTgVtEDg8l6dyq8t86XClcH4rnqhwO7T0k+MX9zoGvjEkU/1phY
         sRo0+4eDzXAZ27l2tmLIG9fAqnbLh662hMiiyqMnJ3SgauscVjsnC7pKDa5IKu7oCvOQ
         1gcpn+b4h2V3DZod5jL6szOdr3HyG1rNphtYQGbA9H46JMmRJO1jaEnVDE1Kga6+6YGb
         jyZ1VX+a3qqKJZB+sVmjlD9q/FhrERXJJ9nnBSj474Cd37WkQSXfxfs1wPGcdRwqL2m8
         CyCCbgWF3hZzSZHGMGnToMDteUZQ5oWCryUfX2r00qOl9tQz2oQjxBmUw08DebzTLwMx
         d9Dw==
X-Gm-Message-State: AJIora8pCZS9GrkRcymvhDAf+2EjgXMEjRpBIcJMMrT0aNYhGWGwCjMa
        w1/roMzSMjNCNb5yWZheKw==
X-Google-Smtp-Source: AGRyM1v5qelrR/U10kjLdrLXUQpTQ0//gcja8OXPSL+u6Un5VXnugNdh62IsZdi/+Y/01zw+rO7vZw==
X-Received: by 2002:a05:6602:168d:b0:67c:44c3:9ba5 with SMTP id s13-20020a056602168d00b0067c44c39ba5mr39474iow.190.1658267415685;
        Tue, 19 Jul 2022 14:50:15 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id y17-20020a92d811000000b002dd0875c67asm364937ilm.69.2022.07.19.14.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:50:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: regulator: Add missing type for 'regulator-microvolt-offset'
Date:   Tue, 19 Jul 2022 15:50:09 -0600
Message-Id: <20220719215010.1875363-1-robh@kernel.org>
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

'regulator-microvolt-offset' is missing a type definition. The type should
be 'uint32'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/regulator.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index a9b66ececccf..6e8aa9eed3aa 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -23,6 +23,7 @@ properties:
 
   regulator-microvolt-offset:
     description: Offset applied to voltages to compensate for voltage drops
+    $ref: "/schemas/types.yaml#/definitions/uint32"
 
   regulator-min-microamp:
     description: smallest current consumers may set
-- 
2.34.1

