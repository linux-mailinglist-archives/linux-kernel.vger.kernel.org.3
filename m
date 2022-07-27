Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA7581EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiG0EYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbiG0EYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:24:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C23C8ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:24:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c6so11049807plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUsDOahpnQXuwfiv7piuKaQU+gbZMugDFvRrrXb0znU=;
        b=gkaFuqwJET03QJPwHa82iFYWOiNEyWLSWccz/sr4p3FBrtjX5Ff1K1UlIIn8AFhQQo
         cKji9z3xJQTjwwZogEqq++1FE90GhC4w8hgmdnGbfHsC+F8AYyGUOwE++pSR9mWPORDW
         kWD7rcO+Foiz3e71MzAT7JyVkzoxbRbcCYcJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUsDOahpnQXuwfiv7piuKaQU+gbZMugDFvRrrXb0znU=;
        b=CGhuPqRONNtFcyH9itilwrsphFyCShAL90r3H3A2vEyAsa/BbB0ic/MNYu+EQSY66q
         2aQjZXyT56iA7Fui8NJOQyBEpLvym3xBIIjGusRrxr2s6TWOs7ePiOx+uC8qnHAKBVrn
         qrjlk1vvE616ZyYsAXZA02JBfjcS9gdJVdE8Rv/vjr4xuGV9M7F4IFZlI+/YBFAzF2P0
         q/GKARyEi6WUP/VF1A94fugXOgktuEsrxItasxnVPTMzJJ3mukYO5hbw4NqbHTPim9Q/
         jqwSVgZb0a/MWLTpUJqAPKNmD2t1iSmmKrBZl2OFN52CE4LKrD07r66I70a9xDnZl3pU
         uk+Q==
X-Gm-Message-State: AJIora/ub1DPvqaCuGEYHMc/kb4y/QVHCUcHqL7UE5LVpZjef49tj+Zq
        uiAKMUCfUOdaTyKPakfnbjJ9hgSTWNwXdA==
X-Google-Smtp-Source: AGRyM1ujhKcdHgh8MTnoxrqF9h+AItjMHVVf0e//dI+pg2gpUzuEN42xOWYPv3fRu8qqu9ey8yaiAw==
X-Received: by 2002:a17:903:2151:b0:16d:2dcf:fa2e with SMTP id s17-20020a170903215100b0016d2dcffa2emr19812689ple.124.1658895880321;
        Tue, 26 Jul 2022 21:24:40 -0700 (PDT)
Received: from moragues-cloud.c.googlers.com.com (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b0016d5a356b31sm8058538plf.116.2022.07.26.21.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 21:24:39 -0700 (PDT)
From:   Bob Moragues <moragues@chromium.org>
X-Google-Original-From: Bob Moragues <moragues@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document zoglin board
Date:   Tue, 26 Jul 2022 21:24:31 -0700
Message-Id: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
Zoglin is identical to Hoglin except for the SPI Flash.
The actual SPI Flash is dynamically probed at and not specified in DTS.

Signed-off-by: Bob Moragues <moragues@chromium.org>

Signed-off-by: Bob Moragues <moragues@google.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 581485392404..63091df3cbb3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -475,6 +475,7 @@ properties:
 
       - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
         items:
+          - const: google,zoglin
           - const: google,hoglin
           - const: qcom,sc7280
 
-- 
2.37.1.359.gd136c6c3e2-goog

