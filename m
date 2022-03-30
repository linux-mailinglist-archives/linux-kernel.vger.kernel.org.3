Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77384EC913
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiC3QFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347537AbiC3QFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:05:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57D6D943;
        Wed, 30 Mar 2022 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648656201; x=1680192201;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=a5vYtPQQN52jG3RKmFp6BjZbLeVvmnj0PyCiaeGjnLQ=;
  b=MhZARAvYjwlxl5xvU/0SfWNU/GXgsZE2OlA37aZjIIooP1uOSRS8xWb2
   SxFIfQ57Ra1GDS3KaEEacdtGDuYUoru8+IU+z7SuzAJHimVfAs0Wx+lKg
   uRvxa0950Ps72g6a/l1WuiIxjtPRT0cfC7W41IvR63NoRo4XgK7YuYFec
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Mar 2022 09:03:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 09:03:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:03:19 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:03:13 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <bjorn.andersson@linaro.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>, <quic_vproddut@quicinc.com>,
        <quic_aravindh@quicinc.com>
Subject: [PATCH v6 0/8] Add support for the eDP panel over aux_bus
Date:   Wed, 30 Mar 2022 21:32:51 +0530
Message-ID: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
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

This series adds support for generic eDP panel over aux_bus.

These changes are dependent on the following series in order:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=620127&state=*
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=616587&state=*
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613654&state=*


Sankeerth Billakanti (8):
  drm/msm/dp: Add eDP support via aux_bus
  drm/msm/dp: wait for hpd high before aux transaction
  drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP
  drm/msm/dp: avoid handling masked interrupts
  drm/msm/dp: prevent multiple votes for dp resources
  drm/msm/dp: remove unnecessary delay during boot
  drm/msm/dp: Support edp/dp without hpd
  drm/msm/dp: Handle eDP mode_valid differently from dp

 drivers/gpu/drm/msm/dp/dp_aux.c     | 13 ++++-
 drivers/gpu/drm/msm/dp/dp_aux.h     |  3 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c | 35 ++++++++++---
 drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 99 ++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_drm.c     | 10 ++--
 drivers/gpu/drm/msm/dp/dp_parser.c  | 21 +-------
 drivers/gpu/drm/msm/dp/dp_parser.h  |  1 +
 8 files changed, 143 insertions(+), 40 deletions(-)

-- 
2.7.4

