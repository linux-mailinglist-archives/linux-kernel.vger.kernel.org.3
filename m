Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03154DB73E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357620AbiCPRho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiCPRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:37:38 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4630674C2;
        Wed, 16 Mar 2022 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647452184; x=1678988184;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6OkD05aTFFl6nKh8qWXKe8mQvXhUbnZbplyfxqxmbEs=;
  b=GvRZB4znZOx0qtVKNaoCAehyXIvL49p1qKgxQPZSYDu8w40Z1SYKlRKb
   pYJAldd+r8Xed0sa1UrORI4r+za2I5Iw/JWbT9NJUMVaf9C/hNabxiovj
   CNFhMj951ffCvrw5QJfPaRzOwg+hk/8INZrJ4rnjbDgdqKl4HEcUoqyq6
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Mar 2022 10:36:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:36:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 10:36:23 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 10:36:16 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <sean@poorly.run>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <thierry.reding@gmail.com>, <sam@ravnborg.org>,
        <dmitry.baryshkov@linaro.org>, <quic_vproddut@quicinc.com>
Subject: [PATCH v5 0/9] Add support for the eDP panel on sc7280 CRD
Date:   Wed, 16 Mar 2022 23:05:45 +0530
Message-ID: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com>
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

This series adds support for eDP on sc7280 CRD platform.

These changes are dependent on the following series in order:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=620127&state=*
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=616587&state=*
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613654&state=*

Sankeerth Billakanti (9):
  arm64: dts: qcom: sc7280: rename edp_out label to mdss_edp_out
  arm64: dts: qcom: sc7280: Add support for eDP panel on CRD
  arm64: dts: qcom: sc7280: Enable backlight for eDP panel
  drm/panel-edp: add LQ140M1JW46 edp panel entry
  drm/msm/dp: Add eDP support via aux_bus
  drm/msm/dp: wait for hpd high before any sink interaction
  drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP
  drm/msm/dp: Handle eDP mode_valid case
  drm/msm/dp: Support edp/dp without hpd

 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 111 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi    |   2 +-
 drivers/gpu/drm/msm/dp/dp_aux.c         |   6 ++
 drivers/gpu/drm/msm/dp/dp_catalog.c     |  38 ++++++++---
 drivers/gpu/drm/msm/dp/dp_catalog.h     |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c     |  95 +++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_drm.c         |  10 +--
 drivers/gpu/drm/msm/dp/dp_parser.c      |  21 +-----
 drivers/gpu/drm/msm/dp/dp_parser.h      |   1 +
 drivers/gpu/drm/msm/dp/dp_reg.h         |   7 +-
 drivers/gpu/drm/panel/panel-edp.c       |   1 +
 11 files changed, 254 insertions(+), 39 deletions(-)

-- 
2.7.4

