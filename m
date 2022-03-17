Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6544DCA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiCQPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiCQPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:51:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5941A160FE3;
        Thu, 17 Mar 2022 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647532193; x=1679068193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lgB7Dw2BwddEDYPs9mtAFioKNcLPg0RPHlBadh0LRnI=;
  b=oPji4/QWY7VmIe47P6JGk8OET5gAbc5feTfYpLwBQsf4zaLh85F67IV9
   14P2xge5pG54t9JNwsW8Ef+ZnXVlNa2MSL7QQwvksNjS1lLCvmglmbvy4
   ypTmHQyUGkBNDhBhk4bqnXCQNwrwJPmox5gLszwjWjD6M1ua9yFv5Dt2i
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 17 Mar 2022 08:49:53 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 17 Mar 2022 08:49:51 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 17 Mar 2022 21:19:33 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 25D4C4CAF; Thu, 17 Mar 2022 21:19:32 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Add reset entries for SDCC controllers
Date:   Thu, 17 Mar 2022 21:19:25 +0530
Message-Id: <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc hardware reset entries for eMMC and SD card.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c07765d..cd50ea3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -881,6 +881,10 @@
 			mmc-hs400-1_8v;
 			mmc-hs400-enhanced-strobe;
 
+			/* gcc hardware reset entry for eMMC */
+			resets = <&gcc GCC_SDCC1_BCR>;
+			reset-names = "core_reset";
+
 			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
@@ -2686,6 +2690,10 @@
 
 			qcom,dll-config = <0x0007642c>;
 
+			/* gcc hardware reset entry for SD card */
+			resets = <&gcc GCC_SDCC2_BCR>;
+			reset-names = "core_reset";
+
 			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

