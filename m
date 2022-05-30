Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA5537B11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiE3NJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiE3NI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:08:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08370904
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:08:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u30so16636729lfm.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+pzy9SDgwlLKqsqL0oBtRcoKaOTRyZQ9Q60hk5By48=;
        b=xLfsGBLRyM0zlUowQPJtZ60H3StxVqy8Lqev4bSZAFy0amMHwqRiLBFGA8qK+qWlwK
         l18ufKZ4AWRQq7kDXz9Wtx4O6YN4phZRnzUdMM1LXjVfoqj350pbYMONPB9yLEOBfLtN
         R+dqGwFfDh+G5DPe8qWmOrywVdGa290EVd9yJ4JJ4yvKBVVmNxpt4r9w1HMI4d3HJQC0
         vtEWSQ9Dj+05IoYkh5v5FIxACOMnrWENLm/DPfOOyJYnMd05WJcDdp1pGsUXqR6igeV2
         Oz8kU/UVoNCeKU981jzAAXyKyx1HZIH07mPSSM/EkPIlqNcWl1O41LAemsr6uarD082O
         gy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+pzy9SDgwlLKqsqL0oBtRcoKaOTRyZQ9Q60hk5By48=;
        b=wgZHnvTV/G/en4Uwlmqlo4+ru16rmj3xOD/7k0MlvEc1WEpIBUQpa2CDA03ulZcWvU
         xA87b7gsobYgoTXUuwZsFFL+Z00uwgOn2iwOdYE32hbDoc0V5RLYhaT8o7dq3egaYCA/
         CWuol1ltJFsY1KOimn6nKdlc7t2xoA32DACEZ/BvOhsDDZqssGcZN76trCDtzCGFIoNn
         gepwEX39Y3RwMsEnRdBUHJWI4qTgN2v2hjBImoX+hHLuTDrLnHs2EO+hX+iSHW0IFqDp
         MCbex3+gc/vRnlhBRfkwgtRCxsLzhwd7du77auc6X3LGzVpWoiFgjLwje+5cYPNlZKOh
         VVcQ==
X-Gm-Message-State: AOAM530tW7AqfFDfyKZMnYMhEZNyBrFZ1oQYcPG5aDS2jop9wpO+IfBq
        yFcUsslooAP4F4CTbMWI8FyLEg==
X-Google-Smtp-Source: ABdhPJxtZA3zoQCpEe2nZfqwlqRtuL4USD5PjImrVtzpcb+6U5nJP7UJY9wlvi9z7SOKd3rbjU89zQ==
X-Received: by 2002:a05:6512:3da0:b0:478:5b79:d76e with SMTP id k32-20020a0565123da000b004785b79d76emr33233584lfv.540.1653916132727;
        Mon, 30 May 2022 06:08:52 -0700 (PDT)
Received: from panikiel.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id d22-20020ac25456000000b00477a7c8a0f0sm2295701lfn.295.2022.05.30.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:08:51 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 3/3] dt-bindings: altera: Update Arria 10 boards
Date:   Mon, 30 May 2022 15:08:39 +0200
Message-Id: <20220530130839.120710-4-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220530130839.120710-1-pan@semihalf.com>
References: <20220530130839.120710-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mercury+ AA1 is not a standalone board, rather it's a module with
an Arria 10 SoC and some peripherals on it.

The Google Chameleon v3 is a base board for the Mercury+ AA1.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 5e2017c0a051..c6e198bb5b29 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -25,7 +25,7 @@ properties:
         items:
           - enum:
               - altr,socfpga-arria10-socdk
-              - enclustra,mercury-aa1
+              - google,chameleon-v3
           - const: altr,socfpga-arria10
           - const: altr,socfpga
 
-- 
2.36.1.124.g0e6072fb45-goog

