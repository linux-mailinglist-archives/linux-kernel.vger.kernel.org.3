Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ACF50E6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiDYRRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbiDYRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:16:56 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F2D1707E;
        Mon, 25 Apr 2022 10:13:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b17so12246795qvf.12;
        Mon, 25 Apr 2022 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLU7Byu++ueSPleKFASenNUYu4xE0XjTscVJ1fB23CI=;
        b=bCDXpHkDeJiwI3/+FK6eKtKKvdVw+nWM0xwrlOLYBuSZYGKWgtGiUBRF6SWicWNrQY
         VCtWoNmzt8hYvVyaqGjG2EhMOuv/0LH9d5aEjh5Ywo9vXRxGwO4jhV+U4OXwdsL2AUxZ
         DGHD1kQP4S33ULejyh3VniTF1vCqwYvFNm6IzUnM9dlCRhYT0Iamdmr01IXFdKHIug2d
         HhhJRnosHLzkEV38kSQtymjuNOHfeJr2Tq9rEUSbmpX9EyuBGfvW8LaqwX++LY8dr247
         T9TXLNVVAeynqOmR9HQbAXqtP06x7XLz8y4vGn3kDfHWn3ra5ac9qBQNCr9dJCf1GJye
         kbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLU7Byu++ueSPleKFASenNUYu4xE0XjTscVJ1fB23CI=;
        b=BGaQE0v0m713L5+tn/3X9X2hBBEI+ukci2uKtxLGNVsm8LlG1eaWo2dVXDZDukAaxw
         YI1j/mDGvVOUNwBhCXBJAOCc2FQlkKDVr3cfHm/t+Eoe8LmdAVtDUXTxeYT/TN7tqqTT
         tpAH4VseLNNOXHMFe0/UGOp5W0gWH6foThQdcvqcJlyvzMEZL8yXCuvvwOJYxxheJwwM
         KF6xAyZZjwpc5OFqqLTzeQioOkgB8UXdZt9fQRyVgvENnH9uuUr7cOrt79xUZ7Eco10C
         sxa1SUQoEljwd5wNcMUyMv9CtKz27/DpE1t1s9FC58O7QcOP4D2O0Vrg/Bb7gOy/g3Ct
         9pdg==
X-Gm-Message-State: AOAM530XNvP93OmD4hOXur5WZT3LLQiIEKFmDe6/6wZvJMGClpmQOux7
        b3B8OzcKyREHfwKctSbt9gUKbEjObWR0XA==
X-Google-Smtp-Source: ABdhPJwHRDB8KYA8NTouw9jD9sdzZIhMtIUI7b9FLcMDA0XemGjLUmgWw0wblhuNPVxnEKQimCdJzw==
X-Received: by 2002:a05:6214:2388:b0:441:37e5:baec with SMTP id fw8-20020a056214238800b0044137e5baecmr13665169qvb.66.1650906827628;
        Mon, 25 Apr 2022 10:13:47 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm7154928qtw.64.2022.04.25.10.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:13:47 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] dt-bindings: arm: rockchip: Add Pine64 Quartz64 Model B
Date:   Mon, 25 Apr 2022 13:13:38 -0400
Message-Id: <20220425171344.1924057-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425171344.1924057-1-pgwipeout@gmail.com>
References: <20220425171344.1924057-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64 Model B is a compact single board computer from Pine64
based on the rk3566 SoC. It outputs on uart2 for the debug console.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index eece92f83a2d..d6650a366753 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -507,6 +507,11 @@ properties:
           - const: pine64,quartz64-a
           - const: rockchip,rk3566
 
+      - description: Pine64 Quartz64 Model B
+        items:
+          - const: pine64,quartz64-b
+          - const: rockchip,rk3566
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.25.1

