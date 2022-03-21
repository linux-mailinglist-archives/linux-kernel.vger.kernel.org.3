Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58F4E22B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbiCUI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbiCUI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:58:06 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AC57485;
        Mon, 21 Mar 2022 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647853001; x=1679389001;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Z7frmisJ/HESWHDo487rDBWlj2TEuAbGN63MQhhGsNg=;
  b=m7ZAwJsA6apSg/4KBR8qdV4kUr9GFaeCDhWOlhQGJ65TP758d4Hby5B1
   M8UhBJONqJh8Ortc6HAHTOxBc42cb7QoR5BWROlJ6Xs2wAuSDWXjQ6+jK
   RKhcFoNWzFV1tzWAznwUF2UKR1qIilNpBhQfVU6KPbhyjHPgBubVKLNJi
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Mar 2022 01:56:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 01:56:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 01:56:39 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 01:56:35 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <krzysztof.kozlowski@canonical.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/3] Update dt-bindings for sc7280 platform
Date:   Mon, 21 Mar 2022 14:26:18 +0530
Message-ID: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
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

This patch set is to update required clocks, power domain names for sc7280 platforms,
and add mic bias supply for wcd938x codec.

Srinivasa Rao Mandadapu (3):
  ASoC: qcom: dt-bindings: Update bindings for clocks in lpass digital
    codes
  ASoC: dt-bindings: wcd938x: Add mic bias supply property
  ASoC: dt-bindings: lpass-cpu: Update clocks and power domain names for
    sc7280 platform

 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml       | 17 ++++++++++++++---
 .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 17 +++++++++++------
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 17 +++++++++++------
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 11 +++++++----
 .../devicetree/bindings/sound/qcom,wcd938x.yaml         |  3 +++
 5 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.7.4

