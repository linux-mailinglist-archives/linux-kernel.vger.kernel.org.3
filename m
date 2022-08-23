Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DAC59E441
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiHWNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiHWNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:11:14 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D432134223
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:12:00 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u24so7460169lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NT1MdaiiRgNNPmqthPsgEEr8eAf1OtODyvfC9Tez9jE=;
        b=d24AUdC2zPUgd6lTx38GCpKnI0tTonPkL/qz4kouYg3AoGNTke4nCB4BkFXP8UdoXm
         NnANB9WAmrgV39AqWqOVeBT9U7jCVE1RI8ph602wo2TBenMiheVSZSomxVv67hqniiE/
         sasY/1pB8N9k1YwqWDcSbr1MVJoS9CHohekJGJlWjIZGAbK7cmQHJoKoE7DbIdFHSX49
         h8fNlZ9+ORtRz9MdMRYeglTknssPo6/83lMswQUO5VX8mlUAu+jWBMrPGBgoedg2GHDQ
         8DS5Ell0Jx3Es8VISpQ/r0autuLlz6yaZMPXEYCvFncwnVTQiOcjMx9UqylQrqKtURjP
         FRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NT1MdaiiRgNNPmqthPsgEEr8eAf1OtODyvfC9Tez9jE=;
        b=FYiRuBCiMmDb+Ji1jI0wC2onIGKaYEwGf23XpYm0LwQX+qL5Epce25B1hj+IgpEGGm
         kw4C3OEltZwxzZDpUtWOYoL6hLoLOwhyZnQC2fu9LyNj8xH9cm2y5j/U7HVHFDGdFNhU
         KQXpCadXHksJdZxxMGBqBw10DaMBM2C96rRzcekJYNlMz3CzXtV80M+FZjJ6VdecPrgr
         AqtV8n59pVS0e/yaalNdeKJnQiCIJ8htCeEP+XkhC8mFVimKwtMdZXYwZ4x3IbgBT8AE
         npLdcEx1LwavIm7wOpgFXnxLt6Tm+OFrm4tRdBAnquqS/jNbhFLCQQA1g56EgpQaogrE
         Gc6w==
X-Gm-Message-State: ACgBeo26aXtAu9X2F2bbtl2u0WO8PKCAs4sqCsiZsmnFGBBPoEB5C6wL
        1N/D0w92+pIur0sZAkkHyh8QOg==
X-Google-Smtp-Source: AA6agR4x9HadMmuOlofp0PRb7+HJm0Tgt7RCUUlor0M2WSkzU/nuFxZEGkfwoOuVnq8W/4obs0Getw==
X-Received: by 2002:a05:651c:238b:b0:261:d3dd:3aa6 with SMTP id bk11-20020a05651c238b00b00261d3dd3aa6mr1403084ljb.348.1661249404252;
        Tue, 23 Aug 2022 03:10:04 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b00492db3caa0dsm1415846lfr.295.2022.08.23.03.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 03:10:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: serial: samsung_uart: drop ref from reg-io-width
Date:   Tue, 23 Aug 2022 13:10:00 +0300
Message-Id: <20220823101000.386927-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg-io-width is a standard property, so no need for defining its type

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 901c1e2cea28..8dbf5885488a 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -37,7 +37,6 @@ properties:
     description: |
       The size (in bytes) of the IO accesses that should be performed
       on the device.
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 1, 4 ]
 
   clocks:
-- 
2.34.1

