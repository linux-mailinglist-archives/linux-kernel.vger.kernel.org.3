Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F00492DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348345AbiARSsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:48:02 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:45776 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbiARSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642531663; x=1674067663;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LmCJQZH2grvqeHDN4RYFay6rviTPDGALX/f1SgKOvLs=;
  b=s46DyFq8DQGYaZT+ARkmigU5iYhZyqV/kg8dPxqGJlEQMzsOfCRuftfL
   0mT+xincX/V+1tW2EUtXm9acHRlw3w6wz4HAF6XHAUUZtQDlrs+SbnMer
   eL4T4R21ph2PgKDOk3aDECgowL/O8sa0Nth5r9zZfySiIJjJBmvDPMm+L
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 18 Jan 2022 10:47:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 10:47:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 10:47:41 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 10:47:40 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 0/4] group dp driver related patches into one series
Date:   Tue, 18 Jan 2022 10:47:24 -0800
Message-ID: <1642531648-8448-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group below 4 dp driver related patches into one series.

Kuogee Hsieh (4):
  drm/msm/dp: do not initialize phy until plugin interrupt received
  drm/msm/dp: populate connector of struct dp_panel
  drm/msm/dp: add support of tps4 (training pattern 4) for HBR3
  drm/msm/dp: stop link training after link training 2 failed

 drivers/gpu/drm/msm/dp/dp_catalog.c |  12 ++--
 drivers/gpu/drm/msm/dp/dp_catalog.h |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 100 ++++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   8 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 116 +++++++++++++++++++-----------------
 5 files changed, 119 insertions(+), 119 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

