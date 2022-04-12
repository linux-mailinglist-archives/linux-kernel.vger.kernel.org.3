Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A14FDEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiDLLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355007AbiDLLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3D2193;
        Tue, 12 Apr 2022 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649759555; x=1681295555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2HueON56JbqPuKljYuCapeExQ/BmLqOCss/TXcZPavo=;
  b=i6EPpNJ9ZX4Kac3UfuAXf8p7aLyg7zOwo43UYpfYYDkXSu8i6Nh3Hj/W
   89gdVrmavhM9BrdaghdIWJ7yEy7PY4UxVz7vf4H4my78QiVrhkj2a5bLu
   N+4oZRQb3J7W8iUc8UWgaEKgFvmwAm3qkKkk6xZyLg5MiWY1OqCGJpDre
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 03:32:34 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 03:32:32 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:02:14 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id E48665963; Tue, 12 Apr 2022 16:02:13 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V4 2/2] arm64: dts: qcom: sc7280: Add reset entries for SDCC controllers
Date:   Tue, 12 Apr 2022 16:02:08 +0530
Message-Id: <1649759528-15125-3-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc hardware reset entries for eMMC and SD card.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be..e2393d1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -881,6 +881,8 @@
 			mmc-hs400-1_8v;
 			mmc-hs400-enhanced-strobe;
 
+			resets = <&gcc GCC_SDCC1_BCR>;
+
 			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
@@ -2686,6 +2688,8 @@
 
 			qcom,dll-config = <0x0007642c>;
 
+			resets = <&gcc GCC_SDCC2_BCR>;
+
 			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

