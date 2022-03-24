Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC54E6389
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350267AbiCXMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350255AbiCXMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:45:56 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA03916C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t13so2498881pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLVt+LP5JlIBRjXydemyTJQgjjrmA7sE29HqyrFPgYU=;
        b=o1iPt0Kzh/aZygLvoGUzfUh5P2m2ASuWdnPFEclHMemAGBXk45lP+UiRZNctpixQMf
         1tm1akMN40R10d41d30DU3Jhs2ftnoEUInbHz08qMk1soQTQlFq7rmoshpDbmJNNDHmF
         lU3QaqQepvZYNdKmuHD/3/SaBvWWAxutuJkeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLVt+LP5JlIBRjXydemyTJQgjjrmA7sE29HqyrFPgYU=;
        b=m6U4slSNA1bIhuzTTR/ber1N6Rp1kIa81Lt5U8+Dmo1Yjsd3uOzADqFEyL7hOruzx8
         q4llxMDP89glYIF+Bje3Kj2K3HBLIRPvCZdXoRfqMeGMJeq5yevfNtELTJ1/3uV/hTGI
         r9JGm6JS35mwCpywclUw0ZcOgE8h1mMz7gHI+6tn3LuBzYgm+/nVtlJkDGV+SOfmzbaD
         1IXt981lcnZRQwgiSKDT/DbkyJfeeXNC7m7i4auhCfqkicVVGH7n7LdpLIovDLMjl0cr
         WpFYpUzaAqcQKpmB9wVKiED6nb/tD0obRwtmnnRD9yC+tv8aTNhSckqFKdzkafgV324+
         BnwA==
X-Gm-Message-State: AOAM532zQDZY/z+tWB8nuu2Fp+d01qWDlzj50oN8I07uYClRj5G9GJDV
        zbn0wOMoc1l/+2qMw6f6qIrVFQ==
X-Google-Smtp-Source: ABdhPJxCHkBGZ3KgXajz2GetPxKcpCh8kcbeG4/uD1RX7HLgooBcQxqBPmxkrHhsygwWEJZzCdpNtg==
X-Received: by 2002:a05:6a00:2354:b0:4fa:f195:b0c9 with SMTP id j20-20020a056a00235400b004faf195b0c9mr2365161pfj.33.1648125864708;
        Thu, 24 Mar 2022 05:44:24 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:24 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/4] dt-bindings: serial: snps-dw-apb-uart: Add MStar MSC313 uarts
Date:   Thu, 24 Mar 2022 21:43:59 +0900
Message-Id: <20220324124402.3631379-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the MStar MSC313 uarts.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 12137fe80acf..486e9deaef0f 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -45,6 +45,9 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
           - const: snps,dw-apb-uart
+      - items:
+          - const: mstar,msc313-uart
+          - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 
   reg:
-- 
2.35.1

