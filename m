Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613847EFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353121AbhLXQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:03:33 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55249 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241840AbhLXQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640361812; x=1671897812;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gvW8BpWYYoD49GMjS+kF2ZpKIYY2ofh32Rb4TnVOEYc=;
  b=Bwz+Lf9z/XvCKrLpCrn1PL+g+E7RyxsvTtvAbbb4P0rY/E0FRQqGRlRZ
   g8DVFO/w6RAzryET0NdFwHHxTSWIxSptwfeikdNZ8/Mrq7VTdp3HsbVjI
   lg5nPOHIiacok/9jlclFlEcgeb9cAysUX3NX8bK7Oflg0CuJulns18aBW
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Dec 2021 08:03:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 08:03:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 08:03:31 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 08:03:26 -0800
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>
Subject: [PATCH v5 0/4] arm: dts: qcom: sc7280: Add display DT nodes for sc7280
Date:   Fri, 24 Dec 2021 21:33:09 +0530
Message-ID: <1640361793-26486-1-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add display devicetree support for sc7280 platform. 

Krishna Manikandan (1):
  arm64: dts: qcom: sc7280: add display dt nodes

Kuogee Hsieh (1):
  arm64: dts: qcom: sc7280: Add Display Port node

Rajeev Nandan (1):
  arm64: dts: qcom: sc7280: Add DSI display nodes

Sankeerth Billakanti (1):
  arm64: dts: qcom: sc7280: add edp display dt nodes

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 390 ++++++++++++++++++++++++++++++++++-
 1 file changed, 388 insertions(+), 2 deletions(-)

-- 
2.7.4

