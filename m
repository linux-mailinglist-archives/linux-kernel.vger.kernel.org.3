Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120350FF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiDZNjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351043AbiDZNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:38:36 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F86380;
        Tue, 26 Apr 2022 06:35:27 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id a10so20648591oif.9;
        Tue, 26 Apr 2022 06:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OygyeH4rfmUuZsXmWAEGnr/ZlA2kUw1LkTJEURaNg9M=;
        b=ak6JwVWG8OHulFUMcWJkL3kMLQ2pwk5zPc4oM587uF1nXrI2rEUTerGW0IrnabexEs
         /LPqEm4MnEv8diLzX+xI9ID7W5nCNlLdWaG3CRgasG6wpRFqYAkr6ctYkxt5vy5CN1Vs
         RTVv/2pqx5R81kj65Yt/zSNKaXJObsEFtIG7ZFWMlT8ME8WS36+85ho5rr06+9CF1lxt
         5u7JQXi1Ba28DPoa3Sv3FHq+y96+KhcRaQl+qaJyasDyi42uE8hmt0g0Z/XobJoVao8y
         nYm73WaSdpyH/oOVBP00xkt/254qJTEOYBQj/wN3ZIW13Mb76F83nGTHeDld57HkTZ+U
         XMKg==
X-Gm-Message-State: AOAM533ZCVTn8kee9cq5evQNG1Xo3KZICjEdQ4cwrfIlmnYKVUE6di7h
        Cug+sWyGM9pOKJ+v5opurg==
X-Google-Smtp-Source: ABdhPJxh7Jprs4lrGBymoDiRReBL7R7uytG+LGnCHdclTxGBoQgU9QJ18XdD5KDldb2alZ+K9kVR2w==
X-Received: by 2002:a05:6808:124a:b0:2da:3588:6d35 with SMTP id o10-20020a056808124a00b002da35886d35mr10804716oiv.269.1650980126381;
        Tue, 26 Apr 2022 06:35:26 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id 65-20020aca0544000000b002f980b50140sm4891611oif.18.2022.04.26.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:35:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds-mt6360: Drop redundant 'unevaluateProperties'
Date:   Tue, 26 Apr 2022 08:35:08 -0500
Message-Id: <20220426133508.1849580-1-robh@kernel.org>
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

The binding has both 'unevaluateProperties: false' and
'additionalProperties: false' which is redundant. 'additionalProperties'
is the stricter of the two, so drop 'unevaluateProperties'.

Fixes: e05cab34e417 ("dt-bindings: leds: Add bindings for MT6360 LED")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/leds/leds-mt6360.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6360.yaml b/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
index b2fe6eb89389..10f95bf1d666 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
@@ -43,8 +43,6 @@ patternProperties:
           - 4 # LED output FLASH1
           - 5 # LED output FLASH2
 
-unevaluatedProperties: false
-
 required:
   - compatible
   - "#address-cells"
-- 
2.34.1

