Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA8650A4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390375AbiDUP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390351AbiDUP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:59:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E440E76;
        Thu, 21 Apr 2022 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650556588; x=1682092588;
  h=from:to:cc:subject:date:message-id;
  bh=yAuVAqWxYWEe5NqjErVFK/4t+1iFYT/C7MQ8E9+btfM=;
  b=LZ9hXAnqLnERd82S/y6+/QrxxkLi+Seo+CbZ1fsc3geGGw5E2ZTSYNua
   9+7AsiQ6hfO1wV9LUrSiu2caD9vMk5Hl6Jo9rEdEMAbt4EPKqM5zzvqFo
   Aj4vqJFAzq44vjkgv6ppVjnSw1wVRM4QY8UrH2Il0yLtBneIs+YOqy4bs
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Apr 2022 08:56:28 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Apr 2022 08:56:27 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Apr 2022 21:26:12 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 9DC983C77; Thu, 21 Apr 2022 21:26:10 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V6 0/2] arm64: dts: qcom: Configure CTS pin to bias-bus-hold for bluetooth
Date:   Thu, 21 Apr 2022 21:26:05 +0530
Message-Id: <1650556567-4995-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN rail was leaking power during RBSC/sleep even after turning BT off.
Change pinctrl configuration to handle same.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v6: add code comments about how bias-bus-hold could save power
v5: modify subject to include bluetooth
v4: modify subject of each patch to indicate what it is applying to
v3: apply same change to active state and other sc7280*.dts* as well
v2: used bias-bus-hold as per review comments
v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
---

Vijaya Krishna Nivarthi (2):
  arm64: dts: qcom: sc7280-idp: Configure CTS pin to bias-bus-hold for
    bluetooth
  arm64: dts: qcom: sc7280-qcard: Configure CTS pin to bias-bus-hold for
    bluetooth

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 18 ++++++++++++------
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 19 ++++++++++++++-----
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

