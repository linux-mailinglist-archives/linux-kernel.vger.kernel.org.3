Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0B57A974
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiGSVv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbiGSVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:51:43 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D5643CB;
        Tue, 19 Jul 2022 14:51:41 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id r70so11807145iod.10;
        Tue, 19 Jul 2022 14:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85HkroyRT6/KmmJdqn8bN9eBoKQ4n7OLsG/Ln9C62EQ=;
        b=kWDJiN3lDToay+j3VSGp792TzIzl5iLfOhyIowWkBj0TI/uuj5FmPyzloOxuDoPRUH
         /jLt2NXQxWWGLgrIBuxYOn6cIpb3a5Yhmz6TCY1tY5d6YVoiwouK6/v0ZAiB49ifGSjT
         BUQwWLGiHsAHVtCcZvueHjIiOVmhlbckUzTd7mlouYUi02aWtQLrWCkkOGteD2Ki0kfF
         Q/hdk/SZBHXhql1rTVL37WCPPJdCIBgLcTmlSgpMJmY++AYH3Fb7Y9z3UI/7DwI7PKkp
         AJlcdKG37RW9A4uXKi74Wjr7/PYhTcQaJAnm/cKW3T5FaoGhuFZdH3PHkegASc3d5B1B
         b8rQ==
X-Gm-Message-State: AJIora9ojL0bLqMAMJzADocA8erFlCI8w0q0F21odtUaEwIWmV55J8oQ
        5+a26QKnEQoUtk+xBV6EEgr/dWiwzA==
X-Google-Smtp-Source: AGRyM1t2dFQzXrBsVPjnPKradNvoFPjaxAi4wE8hmllsMsGhgSvVg8wcKu0IgDqaWk3GBLDOiO9c3A==
X-Received: by 2002:a05:6602:160a:b0:67c:28b:7627 with SMTP id x10-20020a056602160a00b0067c028b7627mr6695610iow.207.1658267500740;
        Tue, 19 Jul 2022 14:51:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id q128-20020a6b8e86000000b00678ea668a39sm7786798iod.36.2022.07.19.14.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:51:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: sgtl5000: Add missing type to 'micbias-voltage-m-volts'
Date:   Tue, 19 Jul 2022 15:51:34 -0600
Message-Id: <20220719215134.1877363-1-robh@kernel.org>
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

'micbias-voltage-m-volts' is missing a type definition. '-m-volts' is
not a standard unit (should be '-microvolt'). As the property is already
in use, add a type reference.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.yaml b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
index e762c320b574..2bc7f00ce4a2 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.yaml
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
@@ -47,6 +47,7 @@ properties:
     description: The bias voltage to be used in mVolts. The voltage can take
       values from 1.25V to 3V by 250mV steps. If this node is not mentioned
       or the value is unknown, then the value is set to 1.25V.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
     enum: [ 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000 ]
 
   lrclk-strength:
-- 
2.34.1

