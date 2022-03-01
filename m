Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCD4C8A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiCALNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiCALNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:13:11 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C14425E5;
        Tue,  1 Mar 2022 03:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646133146; x=1677669146;
  h=from:to:cc:subject:date:message-id;
  bh=KqktSACkqjI7XXFCEKdNf7BXOn9rd2j3s7ltokrP7u4=;
  b=BppDK/yhE2Q1LZL4Khkgc3BDhRP1KZzg3mTXeOEaYh9fAvLpZ3eoyDj1
   bnDUqgUdJtjuCUNnchISxXvrICRCI3pOf7wo/lYr6TKFlECG3iiWUf7fp
   bIiZg17qN39fITOAFrPbd5uTNs5rKUBDGJ6iizuw1xlwIudHbZp5lg0eU
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 03:12:26 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Mar 2022 03:12:24 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 01 Mar 2022 16:42:05 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id DF90E58A9; Tue,  1 Mar 2022 16:42:04 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V1] arm64: dts: qcom: sc7280: Add GCC hardware register dt entry
Date:   Tue,  1 Mar 2022 16:42:03 +0530
Message-Id: <1646133123-22256-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GCC hardware register dt entry for eMMC and SD card.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c07765d..2b8461d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -881,6 +881,9 @@
 			mmc-hs400-1_8v;
 			mmc-hs400-enhanced-strobe;
 
+			/* Add dt entry for gcc hw reset */
+			resets = <&gcc GCC_SDCC1_BCR>;
+			reset-names = "core_reset";
 			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
@@ -2686,6 +2689,9 @@
 
 			qcom,dll-config = <0x0007642c>;
 
+			/* Add dt entry for gcc hw reset */
+			resets = <&gcc GCC_SDCC2_BCR>;
+			reset-names = "core_reset";
 			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

