Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4848E135
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiAMXxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:53:50 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19874 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbiAMXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642118029; x=1673654029;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cLZfx71HsIHMJqhxNxw2OQZF1FgZr0sHYUmOJh/12/Q=;
  b=hpv5mvNdVaMOnZNhxPu1C97NN1mxpKBtEItPRZQ5KrNnamDtVbcuVaJx
   VEyWmpUvQu0YLGmS0JfR+UqjGzlFBI5A4oi9VFteqWdO8wRsDYIjsS6Rn
   9h1j7eCasoL4zwoXHT7w2Mk6N/nlfZLXRatoLSqWsoqefosC7jJM0+bJG
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jan 2022 15:53:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:53:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 13 Jan 2022 15:53:48 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 13 Jan 2022 15:53:47 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 0/4] group dp driver related patches into one series
Date:   Thu, 13 Jan 2022 15:53:35 -0800
Message-ID: <1642118019-18673-1-git-send-email-quic_khsieh@quicinc.com>
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
  drm/msm/dp:  populate connector of struct  dp_panel
  drm/msm/dp: add support of tps4 (training pattern 4) for HBR3
  drm/msm/dp: stop link training after link training 2 failed

 drivers/gpu/drm/msm/dp/dp_catalog.c |  12 ++---
 drivers/gpu/drm/msm/dp/dp_catalog.h |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 100 ++++++++++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   8 +--
 drivers/gpu/drm/msm/dp/dp_display.c |  90 +++++++++++++++++++++-----------
 5 files changed, 116 insertions(+), 96 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

