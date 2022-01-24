Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7B498806
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbiAXSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:15:38 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57481 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiAXSPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643048135; x=1674584135;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HeIuTTRkmQp//ZfP0Om+hezoS0mWtlzYxT3Nse5gEDc=;
  b=Xf1Rg6jMyDFA4ciWAhIL2FvG181rNkWeMZ9c7/PIwsNr3QajMsqKjkLq
   eE22jxWXHMdjCEM3IlZEh9g6jENJ6eivPAhtyLYokY8578wuJOgwJgoIL
   FUOKQA4J6h9KMU3ZOxwkmprBj842cVV+8Jj7/6wGGIIV5rTJXbNRuMz7t
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jan 2022 10:15:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:15:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 10:15:33 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 10:15:28 -0800
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>
Subject: [PATCH v1 0/2] Add support for the eDP panel on sc7280 CRD
Date:   Mon, 24 Jan 2022 23:45:12 +0530
Message-ID: <1643048114-2996-1-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the eDP panel on sc7280 CRD platform.

These changes are dependent on the following series:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=586263&archive=both&state=*
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=560587&state=%2A&archive=both


Sankeerth Billakanti (2):
  ARM64: dts: qcom: enable eDP panel support for sc7280
  drm/panel-edp: Add sharp panel support for sc7280

 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 127 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c       |  11 +++
 2 files changed, 138 insertions(+)

-- 
2.7.4

