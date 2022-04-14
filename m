Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E0500D82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbiDNMdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243302AbiDNMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E027FE3;
        Thu, 14 Apr 2022 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649939454; x=1681475454;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AfWxrk3Y1bZ1ztYlbooWmctcbxPBWx/GSAjEuBb/3Gs=;
  b=j8g4PEz50L8CvqfnQKxIf9Raam/dxJvSpfz94cB7vS30x7puj5camxbm
   DAT6VQpuiAEJwfQ9EmdUauvzg6fSsp8OFRNIM4zjMr12unXSdxHME6AlI
   OGKhYPfu295uI9mRMbY3xhTbAWWGKhI5dDEQEVTjb01VBcvcO16IIrt9M
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2022 05:30:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:30:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:30:52 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:30:48 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V10 0/9] Add Qualcomm Technologies, Inc. PM8008 regulator driver
Date:   Thu, 14 Apr 2022 18:00:09 +0530
Message-ID: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Satya Priya (9):
  dt-bindings: mfd: pm8008: Add reset-gpios
  dt-bindings: regulator: pm8008: Add pm8008 regulator bindings
  dt-bindings: mfd: pm8008: Add regulators
  mfd: pm8008: Add reset-gpios
  mfd: pm8008: Use i2c_new_dummy_device() API
  mfd: pm8008: Add mfd_cell struct to register LDOs
  regulator: Add a regulator driver for the PM8008 PMIC
  arm64: dts: qcom: pm8008: Add base dts file
  arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  24 +++
 .../bindings/regulator/qcom,pm8008-regulators.yaml |  40 ++++
 arch/arm64/boot/dts/qcom/pm8008.dtsi               |  42 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  68 +++++++
 drivers/mfd/qcom-pm8008.c                          |  76 +++++++-
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-pm8008-regulator.c          | 201 +++++++++++++++++++++
 include/linux/mfd/qcom_pm8008.h                    |  13 ++
 9 files changed, 464 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulators.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c
 create mode 100644 include/linux/mfd/qcom_pm8008.h

-- 
2.7.4

