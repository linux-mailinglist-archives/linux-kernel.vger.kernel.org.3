Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81A48A139
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbiAJU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:56:00 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5272 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343664AbiAJU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641848159; x=1673384159;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QFi1/F+vvFifG3T4nfiL7puKPut5CaPTAfnm01s61QY=;
  b=y5io9Wh/VRqUK+aoN2Xb9O3GUXaAt4eFKuF4Eicsjclzz6p0hLBPRcbN
   QlXJcxyAjzKyQtl9qNWx/zHGOkp9xVSZyCsTSco8JXJb/kIXB8mQ2DnvA
   ghY63qiaJnmC+frM1etnsgbTIHVQrwYbGjMLrzQBvQOfBg8si/z86FFCR
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jan 2022 12:55:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:55:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 12:55:57 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 12:55:57 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/5] group dp driver related patches into one series
Date:   Mon, 10 Jan 2022 12:55:39 -0800
Message-ID: <1641848144-25147-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group below 5 dp driver related patches into one series.

Kuogee Hsieh (5):
  drm/msm/dp: dp_link_parse_sink_count() return immediately if aux read
    failed
  drm/msm/dp: do not initialize phy until plugin interrupt received
  drm/msm/dp:  populate connector of struct  dp_panel
  drm/msm/dp: add support of tps4 (training pattern 4) for HBR3
  drm/msm/dp: stop link training after link training 2 failed

 drivers/gpu/drm/msm/dp/dp_catalog.c |  12 ++---
 drivers/gpu/drm/msm/dp/dp_catalog.h |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 100 ++++++++++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   8 +--
 drivers/gpu/drm/msm/dp/dp_display.c |  98 ++++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_link.c    |  19 +++++--
 6 files changed, 140 insertions(+), 99 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

