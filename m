Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B75B2645
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiIHSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiIHSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:51:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B4F56B9F;
        Thu,  8 Sep 2022 11:51:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so17562381pgi.10;
        Thu, 08 Sep 2022 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=//ahTCx3bhYNJd5yPM2nHuiCGNaCYjPsuZnXD1+4jjc=;
        b=MHMdLh0ved+WU+eOWTR4tEZ0DUZJkXuFx1lK8j881yoCK+dg6Hbvi4Y/NELQjjPfNg
         KP1LuZVcsiK4shcEdgTJ9/Ui81qG3QoAp20rYz2CnAnp4H4nMhH2BhbUye9zUa5hqtOn
         F2ch39sbPvqUO1sNJ3jklpOG3k+DcbM2IcnBrmwZGAImM9z4NyNUxwfFPkjcWQcz+bQ0
         151l/353PhIZ1RZgmXrwBS7KYbyht5D5ogSnDKzUno98KiZHRXNbm35IGaljKaYSEMrM
         qZcIsaDl2x8ZxP3l9w4e6Af1U0Ji5i2DNjJQ+O4Zo0LAgw8cRTXYXTZpBNWp44OBpcwq
         Y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=//ahTCx3bhYNJd5yPM2nHuiCGNaCYjPsuZnXD1+4jjc=;
        b=a/WsmB8n5vzvFLrZoNQmvRZJBRYJ/uZSeGTtvQbDiyn3zN4o7FNcHvY6J3afHwqbbK
         bnr6kSeqg1eO9zAwXAUBSt9s4MeaqyBiXzGNp2T2jqAqaQ84AhsJPWYK1QnaTf9MT1+M
         /saMMQr13PVV96XwV1/2NuxdvHf2IObEwV6GVIccZQqU/2yZ9YAY1uyiaVzTEa+64F5E
         K8H9jbWXSHuVpy+sU+gPqB89L2bZJc7O9aXM8ZgKNwZDrCsj7xvja+WHsH9rKhl6IZnh
         DBNvDM6sKucdfAHM8v3ybIiTKyo2KyG7e0gfkUCbeSTgKIiF8NDbe4hitBEvirnyQbaX
         uezg==
X-Gm-Message-State: ACgBeo2iZyVFwJ/12qrzHcS9bpjyX15CPGYwkKydnikLqBM8fH6EaSZ7
        MeUDL6CpxPE2X61W0vYUV70eBQGq/t1qC+Tg
X-Google-Smtp-Source: AA6agR528LJU3DYP6R8ldvcXBcBCtWMQW/nj6if1gifReTsaEeEhycVZH6QkWiQ3KrMUKYhYauWlOQ==
X-Received: by 2002:a63:f40e:0:b0:434:e565:3304 with SMTP id g14-20020a63f40e000000b00434e5653304mr8670112pgi.111.1662663075020;
        Thu, 08 Sep 2022 11:51:15 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:ce83:3779:42da:b5f7:bc9e])
        by smtp.googlemail.com with ESMTPSA id 21-20020a170902c11500b001714c36a6e7sm8746030pli.284.2022.09.08.11.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:51:13 -0700 (PDT)
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
Subject: [PATCH v2 4/4] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
Date:   Fri,  9 Sep 2022 00:19:25 +0530
Message-Id: <20220908184925.2714098-5-sireeshkodali1@gmail.com>
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

The pronto v3 remoteproc is similar to pronto v2. It is found on the
MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
other SoCs. Since the configuration is same on all SoCs, a single
compatible is used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 5e4a97e9d330..becd9c611798 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,pronto-v1-pil
               - qcom,pronto-v2-pil
+              - qcom,pronto-v3-pil
           - enum:
               - qcom,pronto
       - items:
@@ -200,6 +201,22 @@ allOf:
         - power-domains
         - power-domain-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pronto-v3-pil
+    then:
+      properties:
+        vddpx-supply: false
+        vddmx-supply: false
+        vddcx-supply: false
+
+      required:
+        - power-domains
+        - power-domain-names
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.37.2

