Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E08464B59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbhLAKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:15:33 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:19115 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242748AbhLAKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638353530; x=1669889530;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=37+h5/yfbKV3ScL3bbanTaHVYxBBcBPpZQjE90BZzLo=;
  b=jGC+2zU6eWfyqRrIKu3K/4A5opKA2ck8di6KTZ0kp0GhukejD/uihT/V
   9L4h3Y8yErV8gVkiRbTXiDvMpPEOphL62sg0mbvwRTnRRkbm/6Bw+4WCy
   1+XOApbFziVV4wQyW0eEi8JWc97K60Q8ZRzoKU6EKQSG/XPdm/hWgADfY
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 02:12:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 02:12:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:12:04 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:12:01 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 0/4] arm64: dts: qcom: Add support for the sc7280 CRD board
Date:   Wed, 1 Dec 2021 15:41:38 +0530
Message-ID: <1638353502-23640-1-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sc7280 CRD (Compute Reference Design) Board.
It shares the same EC and H1 as the IDP2 boards, comes with an eDP
display and supports both touch and trackpad.
Since the EC and H1 nodes are identical across CRD and IDP2 this
series also adds support for EC/H1 on IDP2 devices.

Kshitiz Godara (2):
  arm64: dts: qcom: sc7280: Define EC and H1 nodes for IDP/CRD
  arm64: dts: qcom: sc7280-crd: Add Touchscreen and touchpad support

Rajendra Nayak (2):
  dt-bindings: arm: qcom: Document qcom,sc7280-crd board
  arm64: dts: qcom: sc7280-crd: Add device tree files for CRD

 Documentation/devicetree/bindings/arm/qcom.yaml |   6 +-
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sc7280-crd.dts         |  93 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi  | 105 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts        |   1 +
 5 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-crd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi

-- 
2.7.4

