Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D459A4A7602
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbiBBQfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:35:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38165 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbiBBQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643819729; x=1675355729;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=GF8786NcjTUkQ45yr3Y6C8c0uWFsOEVJPM5o966ltR8=;
  b=yo90xMikOVJ4uAZpsTe7fFN3eyacUi3ynXvMtuxWD8pwivSlFQ+p2Fho
   qJB38Y5gVAPBezqx5L48TTLFQhcHNexcEsD+TGT15zBYx41NRP2DB32Ds
   mr/Qlae0PfmW2rhacD1wRWUyn2zMrI5W3JyjzMfu44YrirvxG3W8CB+d9
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Feb 2022 08:35:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:35:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 08:35:28 -0800
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 08:35:25 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/2] Drop the clock-frequency property from the MMIO timer node
Date:   Wed, 2 Feb 2022 22:05:07 +0530
Message-ID: <1643819709-5410-1-git-send-email-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the clock-frequency property from the MMIO timer node in both IPQ8074
and IPQ6018 DTSI. There are couple of reasons for this change

1) As per the DT binding, this property should be present only if the
firmware is not configuring the clock frequency properly. In both IPQ8074
and IPQ6018, bootloader is configuring it properly.

2) For IPQ6018, clock frequency should be 24MHz, not 19.2MHz. Rather than
correcting it, drop it based on the above mentioned point.

Kathiravan T (2):
  arm64: dts: qcom: ipq8074: drop the clock-frequency property
  arm64: dts: qcom: ipq6018: drop the clock-frequency property

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 -
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 -
 2 files changed, 2 deletions(-)

-- 
2.7.4

