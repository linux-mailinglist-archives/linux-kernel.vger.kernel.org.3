Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7850E201
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbiDYNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbiDYNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:38:42 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17432E08D;
        Mon, 25 Apr 2022 06:35:36 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e922e68b0fso4941586fac.1;
        Mon, 25 Apr 2022 06:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWDdwifgZhaME7/9bbYcbOyDoL5Cm/Iis4lrqeTNv8s=;
        b=tn3fSVS47TBsKRCxOIqqui//Z9Tux0QAAaHTg/y5UfpHhywOh+mrqPMPC6D3VC+Cta
         9W/77W7HkEWql1U/TelW+l5olfDerL9Xmq2GGI2nUyi6l8RFU9m74vsGLSFIcgm4x6I1
         mn4fE9/urlLrb5N/MWpMW0CwNXHEBTMJNtOFe8HlTuWVUEtj/bfGO/mhmxx5OeyTJU9C
         uhUCSMXlrIfbGqSMINWzpWQUj4/NsBJ2LXfXWPKPEVtBkyFbZnNYlFHlCH6CSQoKPBlj
         qXShzgns2vQezzCsFmeMEOt7CAFHjbjrXXfxtuvUc386sfUE/hEjgQZoqlw3/32/GNBd
         Ig5Q==
X-Gm-Message-State: AOAM532/bCM9GqyxQIQP8Y33XGtAOFYJhsfmZrTSsFf39crAUsLR7kjV
        xuAcGPXVEv9wB2xPGx/14A==
X-Google-Smtp-Source: ABdhPJwNQwgIz1IVtFAES7n46O++bDNiPj2rnMysprTANu14ErWz1Q6f87G3aAAFyOMd5ZuGKxYgqg==
X-Received: by 2002:a05:6871:1d4:b0:de:6122:2bbb with SMTP id q20-20020a05687101d400b000de61222bbbmr6919422oad.210.1650893735279;
        Mon, 25 Apr 2022 06:35:35 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id ex10-20020a056870ed4a00b000e9373e2864sm1285077oab.34.2022.04.25.06.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:35:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible string
Date:   Mon, 25 Apr 2022 08:35:27 -0500
Message-Id: <20220425133527.3723233-1-robh@kernel.org>
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

The compatible string should be 'qcom,gcc-apq8064', not
'qcom,gcc-apq8084'. Found by enabling undocumented compatible checks.

Cc: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 97936411b6b4..9910a3e033bb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -25,7 +25,7 @@ description: |
 
 properties:
   compatible:
-    const: qcom,gcc-apq8084
+    const: qcom,gcc-apq8064
 
   nvmem-cells:
     minItems: 1
-- 
2.34.1

