Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1CD47E5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbhLWPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:44:24 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:42231 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbhLWPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640274208; x=1671810208;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=sQDSX24wJEDimyw1mkiYGrkhTO3eTMz3qcz+aDmYCPE=;
  b=BpWkl8bEv3l0FpfU0ztjmlHWbmiHA+WR8CUSVqznzLZ9ysycsfQIV1yc
   M0LIl2utEvxpVyIfSIoW97MiEmeYfNDehGakgA8NHvSkzkxwEn1ZCct1p
   gWtqQyUCuv8su38UQCEHbmDD8hWEmab6uVqJqwrGnoAINZvZ63T0xFuod
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Dec 2021 07:43:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:43:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:43:27 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:43:23 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/3] Add lpass pin control support for audio on sc7280 based targets
Date:   Thu, 23 Dec 2021 21:13:06 +0530
Message-ID: <1640274189-14120-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add lpass pin control support for Audio over I2S,
wcd codec and digital mics.

This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com/

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
  arm64: dts: qcom: sc7280: add lpass lpi pin controller node
  arm64: dts: qcom: sc7280: Add wcd9380 pinmux

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  38 ++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 204 +++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)

-- 
2.7.4

