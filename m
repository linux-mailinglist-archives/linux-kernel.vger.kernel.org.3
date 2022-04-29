Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5473514837
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358474AbiD2LeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358442AbiD2Ldw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:33:52 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A74969C;
        Fri, 29 Apr 2022 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651231833; x=1682767833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Hg0uCg94FoPp6VeLHVBX2DwzaPDmymWHaQWVzyJfGqc=;
  b=xnCJEmJ3N5zfLep2m8gAWXk7UAPO7Ju80F8g7Skpsh8sgCQF7bl239g2
   9rAyH/x0dma3tV5/YC8kvJHeQsD7oo8FaDlT/98wxAbQdHV+SGaPbjXxJ
   xzDl+oxmJMlcI6loT74oMGxtYqikdPkYWu0OEyhciu0nJSXHVXRhfdmhG
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2022 04:30:33 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:30:32 -0700
Received: from bgodavar-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:30:28 -0700
From:   Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
To:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <mka@chromium.org>, <linux-bluetooth@vger.kernel.org>,
        <quic_hemantg@quicinc.com>, <quic_saluvala@quicinc.com>,
        <quic_rjliao@quicinc.com>, <mcchou@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: [PATCH v1 2/3] arm64: dts: qcom: sc7280: Add wlan enable gpio to bluetooth node
Date:   Fri, 29 Apr 2022 15:57:52 +0530
Message-ID: <1651228073-1999-3-git-send-email-quic_bgodavar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wlan_enable gpio details in bluetooth node, As wlan enable gpio
status is required to enable bt.

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..c556e8a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -341,6 +341,7 @@
 		pinctrl-0 = <&bt_en>, <&sw_ctrl>;
 		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
 		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
+		wlan-gpio = <&tlmm 84 GPIO_ACTIVE_HIGH>;
 		vddaon-supply = <&vreg_s7b_0p9>;
 		vddbtcxmx-supply = <&vreg_s7b_0p9>;
 		vddrfacmn-supply = <&vreg_s7b_0p9>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

