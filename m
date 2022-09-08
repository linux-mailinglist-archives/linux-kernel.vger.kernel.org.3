Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2205B2642
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiIHSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiIHSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:51:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE9FE4A1;
        Thu,  8 Sep 2022 11:51:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so18757114plq.12;
        Thu, 08 Sep 2022 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FWmlh2yojHtL2OQ0rHu6CbD2eXHTcufw4oWIJCcOon8=;
        b=GDr+fUXJz91IpMO/pIHRQ3t9rZOhXF58tzim33qqwkyXlKO1JLSQoii7gJ4wWYWhp8
         qThoOfBQZ3p9434HRdNhTlasw4vbHtxzOtWJyg6eWoYKMNYFpLz45eiqa+A35bG1lk0Q
         UKurN1InZh6ZyN+l6anrMcUJoNyU6UplQ98oEPPpeA6UZvEOx0rorpNpehdPdiSeiEen
         d+HtdV8QNdZ7omJUZIf9piRvMicvpsoLaeSDgU/rk3TAOlfOz6ejv9f6PGjbZXGv5ALM
         nqZ2H1R2QfNm6BC/sTa2YEIbjhbxeZTbycA3GSbTDJCJDixsbIp7B65ZnYEAwspHF3Ld
         a+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FWmlh2yojHtL2OQ0rHu6CbD2eXHTcufw4oWIJCcOon8=;
        b=VtUufyEhS/LIYMgGybxN5XQW9fUh0W9T0yE/skJl6kAS+SvTOxdDwGr8T/VRlbUlrI
         Fv1FHslYgs5MGOqDmS61Dx984Ix/Wq/s8eIaTl1tToQVOhBhVmVo46rGjZLYjaEQZ0C7
         L4YVcwT4HprH8YExXxn/jHrYFi/kbetMwSfftWgJhLtRZgHTzzFFFyiuWHVJtQkqoVVV
         FPF8hGPStWze0sUJvQpSyIFDdXhI3IhIMNKUOdqk8eb55jUB6wXryB20+bQhs/VjeQrl
         IHqlIjbyU3CEo6PH4F11CteqPHwjdxx6VH/voIpTa1mDUHabqtJ+SUGA4JqWzJnjvCxs
         UgKw==
X-Gm-Message-State: ACgBeo1XqNnet93Nf1dQC8F40Me2zQ6BGQ7TxcE7Udj323rLr2h31KEg
        b8eac2KSWaHfKrGGNPusj063jmbjp9ci6M0B
X-Google-Smtp-Source: AA6agR5H6jpOP0uXQRmOgG+aty9TBH/fHeIUQp30kYGBJOH+qdhz9+9MLK255a2PusqY23+SXNeN6w==
X-Received: by 2002:a17:90b:4a08:b0:200:e221:e98a with SMTP id kk8-20020a17090b4a0800b00200e221e98amr5605333pjb.55.1662663067284;
        Thu, 08 Sep 2022 11:51:07 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:ce83:3779:42da:b5f7:bc9e])
        by smtp.googlemail.com with ESMTPSA id 21-20020a170902c11500b001714c36a6e7sm8746030pli.284.2022.09.08.11.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:51:05 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     bjorn.andersson@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
Date:   Fri,  9 Sep 2022 00:19:24 +0530
Message-Id: <20220908184925.2714098-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,pronto compatible is used in the wcn36xx driver to determine
which register to access. However, this compatible was not documented.
This patch documents the existing compatible as is, since it isn't
immediately clear why the wcn36xx driver uses this extra compatible,
rather than relying directly on the regular compatible string.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index bc18139fdb91..5e4a97e9d330 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -15,10 +15,18 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,riva-pil
-      - qcom,pronto-v1-pil
-      - qcom,pronto-v2-pil
+    description:
+      Append "qcom,pronto" if the device is actually pronto, and not riva
+    oneOf:
+      - items:
+          - enum:
+              - qcom,pronto-v1-pil
+              - qcom,pronto-v2-pil
+          - enum:
+              - qcom,pronto
+      - items:
+          - enum:
+              - qcom,riva-pil
 
   reg:
     maxItems: 3
-- 
2.37.2

