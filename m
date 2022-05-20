Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B824452F606
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353993AbiETXOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiETXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:13:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949A18628E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:13:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c14so8920438pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRRzBzpTvPKL4ArnfdaUFW1cDfFNVquKut1ZEam2zu8=;
        b=Qn7a9XbSwUWVcls8bMgVqhGcd6+Uwun0qQOM4rQuyzDlHm+4/j7XV0G8dnCzhmutcD
         4ogENdLmRs9/m0jWAb5dgPeXelOheCwNpo2dqZTr/cpMqwyz/+7qy4JelCfRidWzdMeO
         uiA5o4DcC87pPoYpzsQDuH4KvqtDikBFd6dlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRRzBzpTvPKL4ArnfdaUFW1cDfFNVquKut1ZEam2zu8=;
        b=VSCBWd5Oaofpe/W5gv2l02ZJXKPM04rTqLwsgB8Lo1WVkcDPTfX/j31mStzMdFYreq
         6clZAHNVSAZea8QIEz34xEzQrWGWoLHq03BCDrHKyJn2nLhCWSrTAKkgydU9ilaTJ5eM
         x4TpzVVQSSSpSYzMocrq0vpx2SOKU9YMkODXRSvxDHXJWiWSzWIAFW6VOEpk1wO5GIu7
         Qc0UuNgJFL2ma8uoQGryjjfrEaXT3tnJ/cHzhql/cZvvy6Xv9TJAjqaJFFCeN2SfnSqs
         fg2dIB7ym+I+vekew7ThgLtzY4wYA7oo+HnxaTSYTFhw2r7dSzTXBFZQ2qmd/zT9GOgV
         9RfA==
X-Gm-Message-State: AOAM530gVD/95GrVmU/dpuWgJatzikEEbVTnMsWuFcMPNdOCD1jdJVJQ
        JOKso8YmkJlhsBPPeXNkXZ0WxOGTi/nmkQ==
X-Google-Smtp-Source: ABdhPJw94RKVYJtddL2x1+4L2GbIeueEMeZstosPkRJ/Wmtdl9kxiE1lO4z96eViqqe4F3Vs3PWpQA==
X-Received: by 2002:a62:3881:0:b0:4b0:b1c:6fd9 with SMTP id f123-20020a623881000000b004b00b1c6fd9mr12445491pfa.27.1653088437410;
        Fri, 20 May 2022 16:13:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:72c1:e5e8:3ad8:f199])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090ac09000b001d77f392280sm2420777pjs.30.2022.05.20.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:13:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor
Date:   Fri, 20 May 2022 16:13:55 -0700
Message-Id: <20220520231355.1559104-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7180-trogdor-lazor-*.dtsi files all include sc7180-trogdor.dtsi
and sc7180-trogdor-lazor.dtsi, so including it here in the
sc7180-trogdor-lazor.dtsi file means we have a duplicate include after
commit 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in
sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi file in a
board like sc7180-trogdor-lazor-r1.dts so that we can include the
display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi) instead
of making ever increasing variants like
sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.

Fix this by dropping the include and making a note that the
sc7180-trogdor-lazor.dtsi file must be included after
sc7180-trogdor.dtsi

Reported-by: Douglas Anderson <dianders@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Fixes: 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index fe2369c29aad..88f6a7d4d020 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -5,7 +5,7 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor.dtsi"
+/* This file must be included after sc7180-trogdor.dtsi */
 
 &ap_sar_sensor {
 	semtech,cs0-ground;

base-commit: 19794489fa2474a55c00848e00ca3d15ea01d36c
-- 
https://chromeos.dev

