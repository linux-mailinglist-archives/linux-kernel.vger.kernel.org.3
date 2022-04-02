Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE84EFED9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353754AbiDBFO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353277AbiDBFOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:14:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2718B78B;
        Fri,  1 Apr 2022 22:12:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gb19so4127783pjb.1;
        Fri, 01 Apr 2022 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ASkqhn+Ws2GVvPf0vS7kIuEFmBPDha4A2HzB935p68=;
        b=e1lbEdiZdq0PAQTQCZasXGcZ1mBQ7Rm595RwbHP2YRyUDnaOtCFK8PRKIczZHAqjT0
         p7S4T+3UCYunkuTAO7DKF+750Mo1af4vnUqKP90m4zY7ePKvLLUdZkGKf5FV+lsiN17g
         kunqPEKoEcSygm/+cyQKcbUxtCQSLA7GPKbE6EQprl09/bRWduZjmeJAx1Fz43kbwm0b
         w6XwqZbjBdQHDR5eXGgv2TyZRBgSloLLhYEAt9QpN3pckh9ylJlo8NweHM6db2GB0r+E
         HyD65SF+kmIPZQOAvqnR8wQ+tvfqveVyKUa8HirQ3huz6G/gJPrDezLFe9GeLkDYQCoS
         oujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ASkqhn+Ws2GVvPf0vS7kIuEFmBPDha4A2HzB935p68=;
        b=EmKB++C7ft34d8v7V0YHSFi9pNCIAvVuyRE4f/UsmN6ku8SmwSMettRyoi46hUHg1J
         kxgIBxQ0+OBpQ037DU5HANq7rJJuIYw1ppQ1wC7xSXqD1hI5DYpe2RXtnRXaKgElaXbG
         HHPNyHXmfe4idQZKkJUhmIWSqpBy0HS6aPl1uk3ldFEtvsSwFAAafI/dWBb3Jdh0r9//
         Uop7WqczMUPkzdh1GceiHR20ZTF5FXPYk/ms14Rg/c68PAdkeBlo/kaej7rSOpIs9QUI
         LwPHDlK4rPnodaIn056ciwkr5F5BSEx34+MXa+7tWOgLCfBZZHjt/Xc+yNE9OdJz/Pe0
         OFFA==
X-Gm-Message-State: AOAM531LtI40VsHOacwC1PPorhgtsMlY90dZ1RLd8tCr9+9AIr8hrAG2
        nqVK3pUyrWXR/Rjj2DMA68md8m24+mo=
X-Google-Smtp-Source: ABdhPJwODUyh9G4mZ4HaUXUpjheGq7uMjknjcI/TIrFlOJnyoZ7qX0lsOa4bvQD0jWP0aJTOmnIXbw==
X-Received: by 2002:a17:90b:4c44:b0:1c7:1326:ec90 with SMTP id np4-20020a17090b4c4400b001c71326ec90mr15330351pjb.87.1648876347460;
        Fri, 01 Apr 2022 22:12:27 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm3834721pgo.6.2022.04.01.22.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:12:27 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: qcom: geni-se: Update uart schema reference
Date:   Sat,  2 Apr 2022 10:42:05 +0530
Message-Id: <20220402051206.6115-5-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have geni based QUP uart controller binding in place as
dt-bindings/serial/qcom,serial-geni-qcom.yaml similar to other
controllers, update reference in parent schema and while at it, also
remove properties defined for the controller from commown wrapper.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 .../bindings/soc/qcom/qcom,geni-se.yaml        | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index e6073923e03a..9f72c676b22c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -133,23 +133,7 @@ patternProperties:
   "serial@[0-9a-f]+$":
     type: object
     description: GENI Serial Engine based UART Controller.
-    $ref: /schemas/serial.yaml#
-
-    properties:
-      compatible:
-        enum:
-          - qcom,geni-uart
-          - qcom,geni-debug-uart
-
-      interrupts:
-        minItems: 1
-        items:
-          - description: UART core irq
-          - description: Wakeup irq (RX GPIO)
-
-    required:
-      - compatible
-      - interrupts
+    $ref: /schemas/serial/qcom,serial-geni-qcom.yaml#
 
 additionalProperties: false
 
-- 
2.25.1

