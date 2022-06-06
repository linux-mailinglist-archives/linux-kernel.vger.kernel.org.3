Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC2653F1A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiFFVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiFFVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:22:37 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65DB5AA50;
        Mon,  6 Jun 2022 14:22:36 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id r3so12867974ilt.8;
        Mon, 06 Jun 2022 14:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhHkTSG9cc6tq0IdzgWJ84xRCi+M4h3eyBzuFUrVZFU=;
        b=ZLyfT3KbE/U42ytZ7SgidOARsB9VbptPX+EjHv7gdkd3kyVU7uLuLrOkaSe9iStHqq
         QVAe8y/rLP/YexvqU527g+8iEV7F5/SKSfg8I0U3paVEzlQYF26i6/E0acHM3Ep5pEJ+
         LEULM0Z9tPeG2G+jFrSf/5PJIp5cDXoHZb0leHiG+NlYdazEacIRaKjaBkvXcnLA9HxG
         6ezm3DDL5gvSMQnTDBJYNwnDFhgMp5w33cZn1wwy0C9LRz3QLNtNSMYm0MoPfs5Ortxo
         EHokUhCfO0OUYG3jac3Sk7AvCJqgnXpycDPi2Hmbz8y/jpj9KR1v4cibxRYIWLiLljhw
         l1Yw==
X-Gm-Message-State: AOAM530aX+tn792LuayiP1USnnV+HX6aYvKbiMgbINYxMm+uhYMBRYDb
        4UZcR1e6HMPWZIuzDVNVfzGaJlxcTA==
X-Google-Smtp-Source: ABdhPJxEC+8bSoXDYo8Ek8VSz5lB40eO3Nc73QuNvGlKSNpMauMI8BW2dpGDD5UFXLsJ8GPn+dVFHg==
X-Received: by 2002:a05:6e02:1c8e:b0:2d3:b072:e423 with SMTP id w14-20020a056e021c8e00b002d3b072e423mr15336209ill.36.1654550556146;
        Mon, 06 Jun 2022 14:22:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id g13-20020a056602248d00b0065abb700feasm5891129ioe.26.2022.06.06.14.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:22:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvme: apple,nvme-ans: Drop 'maxItems' from 'apple,sart'
Date:   Mon,  6 Jun 2022 16:22:30 -0500
Message-Id: <20220606212230.1360617-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 'phandle' type is always a single cell, so 'maxItems: 1' is redundant.

Fixes: 82b96552f15a ("dt-bindings: nvme: Add Apple ANS NVMe")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index ddff9233b159..34dd1cc67124 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -55,7 +55,6 @@ properties:
     maxItems: 1
 
   apple,sart:
-    maxItems: 1
     $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Reference to the SART address filter.
-- 
2.34.1

