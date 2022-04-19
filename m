Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF450646D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348798AbiDSGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348777AbiDSGbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:31:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1E24083;
        Mon, 18 Apr 2022 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650349718; x=1681885718;
  h=from:to:cc:subject:date:message-id;
  bh=M+iVN4fwQTn36HnCCg+Xt3JEcDHOc7j1oA7S7p6wcZ0=;
  b=xn9p/nRQLlCHbw8/Q9xAtHsjqDPOQz7PGqfa4epO92FSR+WeFh23uwKi
   +83YdyaKKVfyZobWyj+C8lVJGyhW3zRhBPJkP8y4djqAVM7w0/IjqvisK
   ncGHYe0X2EpKoXTp7usQQ1jEmPcE9fhk7Ki87m9j6DEPghr5f3wE7okge
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 23:28:37 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Apr 2022 23:28:35 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 19 Apr 2022 11:58:23 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 8ACD53C01; Tue, 19 Apr 2022 11:58:21 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V4 0/2] arch: arm64: dts: qcom: Configure cts sleep pinctrl to bias-bus-hold
Date:   Tue, 19 Apr 2022 11:58:15 +0530
Message-Id: <1650349697-13540-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN rail was leaking power during RBSC/sleep even after turning BT off.
Change pinctrl configuration to handle same.

---
v4: modify subject of each patch to indicate what it is applying to
v3: apply same change to active state and other sc7280*.dts* as well
v2: used bias-bus-hold as per review comments
v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
---

Vijaya Krishna Nivarthi (2):
  arch: arm64: dts: qcom: sc7280-idp: Configure cts pinctrl to
    bias-bus-hold
  arch: arm64: dts: qcom: sc7280-qcard: Configure cts pinctrl to
    bias-bus-hold

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 12 ++++++------
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 13 ++++++++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

