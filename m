Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2002483041
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiACLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:13:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27136 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbiACLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641208397; x=1672744397;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=G9f+78crbVTuU8Y67dkvPF5zWKsFchuQ3ACy88ud7w8=;
  b=eGH8l3rJQY8unTWZRVTBw8v7nMDdp3/fjmRSCbjUoDnK9BCu6lGtEQcE
   e3BsY5J6UTJeFiIBvbCb8VaLUh7K3DPNMnvtB8dGbXUKzMd5XjK4X+voe
   abpkuCEOMcQEEOMExZK5BPA46oAcTMwK7ec6St/sasQMcjyEXklWF0lcY
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Jan 2022 03:13:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 03:13:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 3 Jan 2022 03:13:16 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 3 Jan 2022 03:13:12 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 0/3] Add soundcard support for sc7280 based platforms.
Date:   Mon, 3 Jan 2022 16:42:57 +0530
Message-ID: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add bolero digital macros, WCD and maxim codecs nodes
for audio on sc7280 based platforms.

This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1638551345-24979-2-git-send-email-srivasam@codeaurora.com/
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1639503391-10715-10-git-send-email-quic_srivasam@quicinc.com/
	-- Lpass clock dts nodes yet to be upstreamed.
	-- MSM DP node yet to be upstreamed.

Changes Since V1:
    -- Update the commit message of cpu node patch.
    -- Add gpio control property to support Euro headset in wcd938x node.
    -- Fix clock properties in lpass cpu and digital codec macro node.

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and
    external codecs
  arm64: dts: qcom: sc7280: Add lpass cpu node
  arm64: dts: qcom: sc7280: add sound card support

 arch/arm64/boot/dts/qcom/sc7280-crd.dts  |  12 +++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 173 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 173 +++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)

-- 
2.7.4

