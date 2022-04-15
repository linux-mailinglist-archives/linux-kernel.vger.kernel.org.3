Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD33501FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348302AbiDOBBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbiDOBA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:00:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26906B91B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:58:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k62so101268pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nivLXuALlDwZeTeyTShIS0npp9UwNHyhe5LyhEGbsc0=;
        b=kFQYbYQs4nKlAoV4Qnt5y82rIon3SBCqqdy2FFOMcp5eA1+6CMzfmv17aqRfLeuqCd
         nHX9AYJtLzEWIpkncGyy7Fgsrr5YEu4Bh+ShPtYgQ4HXJXXcCjA9698rJAHeE0FYVkAF
         NFfRZv12a2o1qEDhG7Q+3kZaKME+8BbmEHsow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nivLXuALlDwZeTeyTShIS0npp9UwNHyhe5LyhEGbsc0=;
        b=muXY7v6lV856oBwYUIhg3TOOcGZm+/qswZkFHkEkLP/OWXQujg9X41CBvgTdKWBc1Z
         kgHeX1YwTGdFIG8qAN4J3Z1Eno+HDASG22TiabBO1R0L4h3w1T23ju9Js7BqTxrv+/KE
         tn9si1uiMAWk0AbJu8BCZwRmgoNhir7yvwIT8nrDK1laI9+ONJIQwLd6XapUdXlVR6xZ
         MP8ZAQFrDlsYrUEbStibNGBs538B8H7BvJ+4gzCWHM+hyMyw3BdimJnjrRi97CShutAw
         wJmtFgJosvv8MXaPlVVko8Vf6RAdSmr0CFHIUhFG6DBDCeQyAG3djiyOs1X/dyxnc+e7
         Nrlg==
X-Gm-Message-State: AOAM5321HpyE528W25XoKA+7uv0gjofTiv7K9kJrBDkpw3pQgbi2x4M1
        74USuEEmk/1nB1WDDsjZIBXMPA==
X-Google-Smtp-Source: ABdhPJxMW6DDQ/+8KjI8q0QY302MBkgPITxHqt8bk7gZFm2Gnr9CY/LpE6g2GhkUvZxl7WwDmgXm/A==
X-Received: by 2002:a63:5c43:0:b0:39d:5e18:9d98 with SMTP id n3-20020a635c43000000b0039d5e189d98mr4386181pgm.145.1649984310604;
        Thu, 14 Apr 2022 17:58:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e3e0:734:f81a:d2c1])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79d84000000b00505f920ffb8sm996704pfq.179.2022.04.14.17.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:58:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH 3/2] arm64: dts: qcom: sc7180: Remove ipa interconnect node
Date:   Thu, 14 Apr 2022 17:58:26 -0700
Message-Id: <20220415005828.1980055-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220412220033.1273607-1-swboyd@chromium.org>
References: <20220412220033.1273607-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device node is unused now that we've removed the driver that
consumed it in the kernel. Drop the unused node to save some space.

Cc: Alex Elder <elder@linaro.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e1c46b80f14a..1ff96ef30e3f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1421,13 +1421,6 @@ mmss_noc: interconnect@1740000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
-		ipa_virt: interconnect@1e00000 {
-			compatible = "qcom,sc7180-ipa-virt";
-			reg = <0 0x01e00000 0 0x1000>;
-			#interconnect-cells = <2>;
-			qcom,bcm-voters = <&apps_bcm_voter>;
-		};
-
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sc7180-ipa";
 
-- 
https://chromeos.dev

