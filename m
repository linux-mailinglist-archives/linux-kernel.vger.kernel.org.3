Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AB847E5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbhLWPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:45:07 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:4656 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239999AbhLWPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640274305; x=1671810305;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Oh98BGL0Ky1zM/VAImD+Q5qMni8l0RoncCdARsVlijI=;
  b=qHRsC/WhqgWee+hE1UHhF1EDZYnKmwLR1AjmxF9gPfeYb3A3GbWbk9Dx
   lvkwXvhhIjHZ3dmCVkXGAzgBlf5ljMjiFaWwBAr35EMIjqeEGqFgTDbqU
   +3cPRK3/XymaBc9A6VpvEWeoHgL95zCyIZflqx2t7PHw31NsYamICJ44l
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Dec 2021 07:45:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:45:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:45:04 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:45:00 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/3] Add soundcard support for sc7280 based platforms.
Date:   Thu, 23 Dec 2021 21:14:45 +0530
Message-ID: <1640274288-14399-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add bolero digital macros, WCD and maxim codecs nodes
for audio on sc7280 based platforms.

This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1638551345-24979-2-git-send-email-srivasam@codeaurora.com/
	--https://patchwork.kernel.org/project/alsa-devel/patch/1639503391-10715-10-git-send-email-quic_srivasam@quicinc.com/
	-- Lpass clock dts nodes yet to be upstreamed.
	-- MSM DP node yet to be upstreamed.

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and
    external codecs
  arm64: dts: qcom: sc7180: Add lpass cpu node
  arm64: dts: qcom: sc7280: add sound card support

 arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   8 ++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 173 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 173 +++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)

-- 
2.7.4

