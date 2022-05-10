Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8AA5215D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiEJMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiEJMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9C1A0750
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k27so19873607edk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkJdI54e0iw+j0SubUNETqHu76mK4u9Bb+TpmNhQfJk=;
        b=WcQESiMaelNFY4q4rRbkObJfFwbtVisQ/QjNSdC2B1kHTjKTB/HKEPrJ68Ar3s0cGC
         vMvdLkCkffbKCDL0asmj+yMcyxwTdEBjOQ6OfPsp+CZwW7soGLWi/q8/VZfFV9jA1a0l
         4elH/LTIugjEjVCP+herNH7fH9lrVsosG3NSRmTDk2wzhFvHNTuxQcXFfr/hc3Ah5JJS
         atgRNfZzyUXdY58lBoVJF01UZbDk5nO+hyyiwRNf+JWS2jbQPM/hIFBC6vsrqA5xSPsZ
         sybZDR21taCdULQ2yzm/rtqkNwCBxoDFYp4o2+jPPPFqvksBb6+QiIYKe5rWe/A7z44N
         n5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkJdI54e0iw+j0SubUNETqHu76mK4u9Bb+TpmNhQfJk=;
        b=Yw1mmI2gHg4Tah/t8s3MmcrvJzDJ2q3hRYrE7RxmrQLqmuQNFdPRVjrH8MwQwN/pK/
         dF4F657wqg2anfOocU79zbDIUCko5noCZ3jliSHfIiK7r6rrTVwK8/+xd1phUH+Cn3NJ
         e6/FFFVmPZJClbs183pXm5zivOlrEzYg/fwekD4x475uc/t4FtVcA6UJ9kNriWl8tCmr
         5gVLjn1ZjoAYUtQK4JgnLfBopRAf0We4ziCfjX6VjO8SV8xVchdADR8nbsCfbf+pzwgv
         wnamPnTfEITcaba8tBjR7+MtzkQC2kn/w4/JfSfk7T9BCxmSRPkoBl0uw3WkIrxBYgeK
         waJw==
X-Gm-Message-State: AOAM5316wX39xtdzoEGNbT+ggPnt/LzQoGKz0+H4oFbXG3hcuu4nBRH4
        tZX1Gjc5e7HL1Isu1q1T6H+WIr0APpQhoFWK
X-Google-Smtp-Source: ABdhPJxtXVk31Azba6nGHM86/peUdBPMSNyGDp3aDe/i4YnfTlGxc5OUae5y5syCyuUmkTmroh9LBA==
X-Received: by 2002:a05:6402:1a26:b0:425:d3cf:d7f0 with SMTP id be6-20020a0564021a2600b00425d3cfd7f0mr23438469edb.251.1652186975008;
        Tue, 10 May 2022 05:49:35 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:34 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/11] dt-bindings: vendor-prefixes: add Methode Electronics
Date:   Tue, 10 May 2022 14:49:19 +0200
Message-Id: <20220510124929.91000-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Methode Electronics, Inc. (https://www.methode.com)

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..e5ec476f54cd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -764,6 +764,8 @@ patternProperties:
     description: Cisco Meraki, LLC
   "^merrii,.*":
     description: Merrii Technology Co., Ltd.
+  "^methode,.*":
+    description: Methode Electronics, Inc.
   "^micrel,.*":
     description: Micrel Inc.
   "^microchip,.*":
-- 
2.36.1

