Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9B4DAA63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353826AbiCPGJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353777AbiCPGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:08:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177160AAB;
        Tue, 15 Mar 2022 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647410865; x=1678946865;
  h=from:to:cc:subject:date:message-id;
  bh=Vjl2X9ApUon1cijHUX4swxDHJkO1zzzPSR7XugavMIc=;
  b=MIdTBl30FNNyUecMKaAAoweGkneYEC/uLNnlVzBZsSDyIbtu7cAB57qb
   w73/07hK6/YsbgEYpl75fBmUcIhJWfyVBAWTzSheUQM1/uMkYeWIf3m4o
   N9DkKdXVyynXsVTKMV1tFXNmbpzCfZIHMopdHVbwCrnG5t1tcMH6Hy/1E
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:07:45 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:07:43 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:37:21 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 373144495; Wed, 16 Mar 2022 11:37:20 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/6] Add Power Domains and Regulators in SDX65
Date:   Wed, 16 Mar 2022 11:37:11 +0530
Message-Id: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds driver and dt-bindings related changes
in SDX65 to add power domains and regulators.

Thanks,
Rohit.

Rohit Agarwal (6):
  regulator: dt-bindings: Add PMX65 compatibles
  regulator: qcom-rpmh: Add support for SDX65
  dt-bindings: power: Add rpm power domain bindings for SDX65
  soc: qcom: rpmhpd: Add SDX65 power domains
  dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65 support
  pinctrl: qcom-pmic-gpio: Add support for pmx65

 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  2 ++
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  2 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  1 +
 drivers/regulator/qcom-rpmh-regulator.c            | 37 ++++++++++++++++++++++
 drivers/soc/qcom/rpmhpd.c                          | 16 ++++++++++
 include/dt-bindings/power/qcom-rpmpd.h             |  8 +++++
 7 files changed, 67 insertions(+)

-- 
2.7.4

