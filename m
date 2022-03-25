Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24D4E7288
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357840AbiCYMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbiCYMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:00:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4E1A381;
        Fri, 25 Mar 2022 04:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648209524; x=1679745524;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=pKquGY5uLlSOXOR6qdG8IX9n3sJJk5qeB1+hezt5VJA=;
  b=gEVFsQZGWJ2Ubq55RApXaZegn13olS6s7WtK332zVpDqksrmcFY0/flI
   vqa//x+qxGuf+Tj1+RahEOPDGQGnzzqoQ2jwjbByvd7Y6Pn1JG6VMagYG
   vP467vhLnR6qG9mZ+4mg4oiC1oCWwYo4XFuMqZAB1hMLxwLzx/wF10mal
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 04:58:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:58:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:58:42 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:58:37 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V8 0/7] Add Qualcomm Technologies, Inc. PM8008 regulator driver
Date:   Fri, 25 Mar 2022 17:28:04 +0530
Message-ID: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Satya Priya (7):
  dt-bindings: mfd: pm8008: Modify the compatible as per driver
  dt-bindings: mfd: pm8008: Add pm8008 regulator bindings
  mfd: pm8008: Add mfd cell struct to register LDOs
  regulator: Add a regulator driver for the PM8008 PMIC
  arm64: dts: qcom: pm8008-infra: Add base dts file for pm8008 infra
  arm64: dts: qcom: pm8008-regulators: Add base dts file for pm8008
    regulators
  arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp

 .../bindings/mfd/qcom,pm8008-regulators.yaml       |  87 +++++++++
 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  15 +-
 arch/arm64/boot/dts/qcom/pm8008-infra.dtsi         |   9 +
 arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi    |  37 ++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  70 +++++++
 drivers/mfd/qcom-pm8008.c                          |  94 +++++++++-
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-pm8008-regulator.c          | 205 +++++++++++++++++++++
 9 files changed, 513 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008-infra.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c

-- 
2.7.4

