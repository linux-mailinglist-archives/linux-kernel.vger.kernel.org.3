Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E3525201
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356259AbiELQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356243AbiELQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:05:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084062233
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:05:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e24so5627242pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbSRgAHPMNC/X2wlUF7Gj7zDd8gMnDr9lDlCc2SsIbU=;
        b=HsGNk+tIq1CXWQWX7A47zIqaVvJ2lqwZlXACjuweeCspKx/HNbCeJsM+2OHdHJairR
         pcWyIE8GE/xddDorBVRL+TsibJQyvTSM/8KVv98aUCogK9uQPq832hcewj+VaA8ZPhoW
         TMeeQdl/yw6oSHUuTPc4TO6SD4pWcey2Gz2sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbSRgAHPMNC/X2wlUF7Gj7zDd8gMnDr9lDlCc2SsIbU=;
        b=vM7f0PAmb2kzvg1eDOaY6yy2AfD9/vAuqddJxMvGObXnXZG9UV5DTZJ7k24pAd17fC
         zJTkNNyS2fjvH0aRUGLpuhJT7oGoRmFYyYDz9GALiQZlwFPuzTSRqsLo15gMUNAuYFGe
         wG7YYxxVPDTPtBmFlnN6qVGPl4OlJdnnIXgC/fTmaoRB9badpHp+SfrCc7ErJFv8ZHaj
         P+1hxsGwqpCZvi9P2w8FN92GXjomQrvENhNN1fTvtCp0WxvANUWbKaV55e5AbgfsY/T6
         YWUEOD729Qb0E+GRPcxxMaoEiHq5RN0O8KavitFS1AwGqSDmYEP0+PBjzyRb/dMQd4+P
         Ob9A==
X-Gm-Message-State: AOAM530yTDFnMEwBhtRNDir2DxeX4HDCHnmwIRYhl07a++i/DUIl5H2T
        E/9JB1KUYjfEoCrrq43sPOzXDQ==
X-Google-Smtp-Source: ABdhPJxI8g383YGwOPBz8JL/+JxZRN19m8yXZC8ZfFvscJJahn/sF9LfJIeac9SKUlM9N1apF/IAJg==
X-Received: by 2002:a17:90b:38cd:b0:1dc:1ebe:2c6c with SMTP id nn13-20020a17090b38cd00b001dc1ebe2c6cmr262857pjb.149.1652371509653;
        Thu, 12 May 2022 09:05:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:504e:720d:de58:4f66])
        by smtp.gmail.com with ESMTPSA id b15-20020a62a10f000000b0050dc762817esm21381pff.88.2022.05.12.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:05:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
Date:   Thu, 12 May 2022 09:04:45 -0700
Message-Id: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This copy-pastes compatibles from sc7180-based boards from the device
trees to the yaml file so that `make dtbs_check` will be happy.

NOTES:
- I make no attempt to try to share an "item" for all sc7180 based
  Chromebooks. Because of the revision matching scheme used by the
  Chromebook bootloader, at times we need a different number of
  revisions listed.
- Some of the odd entries in here (like google,homestar-rev23 or the
  fact that "Google Lazor Limozeen without Touchscreen" changed from
  sku5 to sku6) are not typos but simply reflect reality.
- Many revisions of boards here never actually went to consumers, but
  they are still in use within various companies that were involved in
  Chromebook development. Since Chromebooks are developed with an
  "upstream first" methodology, having these revisions supported with
  upstream Linux is important. Making it easy for Chromebooks to be
  developed with an "upstream first" methodology is valuable to the
  upstream community because it improves the quality of upstream and
  gets Chromebooks supported with vanilla upstream faster.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/arm/qcom.yaml         | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..399be67eb5d2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -214,11 +214,191 @@ properties:
               - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
+      # Qualcomm Technologies, Inc. SC7180 IDP
       - items:
           - enum:
               - qcom,sc7180-idp
           - const: qcom,sc7180
 
+      # Google CoachZ (rev1 - 2)
+      - items:
+          - const: google,coachz-rev1
+          - const: google,coachz-rev2
+          - const: qcom,sc7180
+
+      # Google CoachZ (newest rev)
+      - items:
+          - const: google,coachz
+          - const: qcom,sc7180
+
+      # Google CoachZ with LTE (rev1 - 2)
+      - items:
+          - const: google,coachz-rev1-sku0
+          - const: google,coachz-rev2-sku0
+          - const: qcom,sc7180
+
+      # Google CoachZ with LTE (newest rev)
+      - items:
+          - const: google,coachz-sku0
+          - const: qcom,sc7180
+
+      # Google Homestar (rev2)
+      - items:
+          - const: google,homestar-rev2
+          - const: google,homestar-rev23
+          - const: qcom,sc7180
+
+      # Google Homestar (rev3)
+      - items:
+          - const: google,homestar-rev3
+          - const: qcom,sc7180
+
+      # Google Homestar (newest rev)
+      - items:
+          - const: google,homestar
+          - const: qcom,sc7180
+
+      # Google Lazor (rev0)
+      - items:
+          - const: google,lazor-rev0
+          - const: qcom,sc7180
+
+      # Google Lazor (rev1 - 2)
+      - items:
+          - const: google,lazor-rev1
+          - const: google,lazor-rev2
+          - const: qcom,sc7180
+
+      # Google Lazor (rev3 - 8)
+      - items:
+          - const: google,lazor-rev3
+          - const: google,lazor-rev4
+          - const: google,lazor-rev5
+          - const: google,lazor-rev6
+          - const: google,lazor-rev7
+          - const: google,lazor-rev8
+          - const: qcom,sc7180
+
+      # Google Lazor (newest rev)
+      - items:
+          - const: google,lazor
+          - const: qcom,sc7180
+
+      # Google Lazor with KB Backlight (rev1 - 2)
+      - items:
+          - const: google,lazor-rev1-sku2
+          - const: google,lazor-rev2-sku2
+          - const: qcom,sc7180
+
+      # Google Lazor with KB Backlight (rev3 - 8)
+      - items:
+          - const: google,lazor-rev3-sku2
+          - const: google,lazor-rev4-sku2
+          - const: google,lazor-rev5-sku2
+          - const: google,lazor-rev6-sku2
+          - const: google,lazor-rev7-sku2
+          - const: google,lazor-rev8-sku2
+          - const: qcom,sc7180
+
+      # Google Lazor with KB Backlight (newest rev)
+      - items:
+          - const: google,lazor-sku2
+          - const: qcom,sc7180
+
+      # Google Lazor with LTE (rev1 - 2)
+      - items:
+          - const: google,lazor-rev1-sku0
+          - const: google,lazor-rev2-sku0
+          - const: qcom,sc7180
+
+      # Google Lazor with LTE (rev3 - 8)
+      - items:
+          - const: google,lazor-rev3-sku0
+          - const: google,lazor-rev4-sku0
+          - const: google,lazor-rev5-sku0
+          - const: google,lazor-rev6-sku0
+          - const: google,lazor-rev7-sku0
+          - const: google,lazor-rev8-sku0
+          - const: qcom,sc7180
+
+      # Google Lazor with LTE (newest rev)
+      - items:
+          - const: google,lazor-sku0
+          - const: qcom,sc7180
+
+      # Google Lazor Limozeen (rev4 - rev8)
+      - items:
+          - const: google,lazor-rev4-sku4
+          - const: google,lazor-rev5-sku4
+          - const: google,lazor-rev6-sku4
+          - const: google,lazor-rev7-sku4
+          - const: google,lazor-rev8-sku4
+          - const: qcom,sc7180
+
+      # Google Lazor Limozeen (newest rev)
+      - items:
+          - const: google,lazor-sku4
+          - const: qcom,sc7180
+
+      # Google Lazor Limozeen without Touchscreen (rev4)
+      - items:
+          - const: google,lazor-rev4-sku5
+          - const: qcom,sc7180
+
+      # Google Lazor Limozeen without Touchscreen (rev5 - rev8)
+      - items:
+          - const: google,lazor-rev5-sku5
+          - const: google,lazor-rev5-sku6
+          - const: google,lazor-rev6-sku6
+          - const: google,lazor-rev7-sku6
+          - const: google,lazor-rev8-sku6
+          - const: qcom,sc7180
+
+      # Google Lazor Limozeen without Touchscreen (newest rev)
+      - items:
+          - const: google,lazor-sku6
+          - const: qcom,sc7180
+
+      # Google Pompom (rev1)
+      - items:
+          - const: google,pompom-rev1
+          - const: qcom,sc7180
+
+      # Google Pompom (rev2)
+      - items:
+          - const: google,pompom-rev2
+          - const: qcom,sc7180
+
+      # Google Pompom (newest rev)
+      - items:
+          - const: google,pompom
+          - const: qcom,sc7180
+
+      # Google Pompom with LTE (rev1)
+      - items:
+          - const: google,pompom-rev1-sku0
+          - const: qcom,sc7180
+
+      # Google Pompom with LTE (rev2)
+      - items:
+          - const: google,pompom-rev2-sku0
+          - const: qcom,sc7180
+
+      # Google Pompom with LTE (newest rev)
+      - items:
+          - const: google,pompom-sku0
+          - const: qcom,sc7180
+
+      # Google Trogdor (newest rev)
+      - items:
+          - const: google,trogdor
+          - const: qcom,sc7180
+
+      # Google Trogdor (newest rev) with LTE
+      - items:
+          - const: google,trogdor-sku0
+          - const: qcom,sc7180
+
       - items:
           - enum:
               - qcom,sc7280-crd
-- 
2.36.0.550.gb090851708-goog

