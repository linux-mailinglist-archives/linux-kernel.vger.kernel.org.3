Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D060946EB48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhLIPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:36:01 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20427 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbhLIPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639063942; x=1670599942;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=9Rct1wLQL1fJvi9jPEvNdFgfEzsI0bRRcgiQJR+yhmY=;
  b=ezNQaTN2Vp75Ggpzc9bM2xzc1T+/i6j/0VfJZUl0x/MJEcjtiwEOTS7F
   ZQifPLQiCDDo8ff8cgI9eUd69MmKmInHrMcP4yhBGhBS6G2LrIL0qRebA
   wXS9Aq8pJQSvxa0+yXGM5Rk08EK4+ZIOOmSpLEH85JiwibtZWsCt3og4+
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Dec 2021 07:32:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 07:32:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 07:32:21 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 07:32:18 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 0/4] soc: qcom: rpmhpd: Cleanups and fixups for sc7280/sm8450
Date:   Thu, 9 Dec 2021 21:01:53 +0530
Message-ID: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
* used the _w_<parent-name>_parent suffix instead of _no_parent
* Added a minor fix for sm8450 while rebasing 

v2:
* Fixed the wrong assumption in v1 that only sdm845 needed mx to be
parent of cx, turned out all existing upstream SoCs need it except sc7280
* Added another cleanup patch to sort power-domain defines and lists in
alphabetical order as suggested by Matthias

Mostly cleanups, with a fixup to remove the parent/child relationship
across mx/cx for sc7280 SoC, and a fixup to add missing .peer for sm8450

Rajendra Nayak (4):
  soc: qcom: rpmhpd: sm8450: Add the missing .peer for sm8450_cx_ao
  soc: qcom: rpmhpd: Rename rpmhpd struct names
  soc: qcom: rpmhpd: Remove mx/cx relationship on sc7280
  soc: qcom: rpmhpd: Sort power-domain definitions and lists

 drivers/soc/qcom/rpmhpd.c | 358 +++++++++++++++++++++++-----------------------
 1 file changed, 181 insertions(+), 177 deletions(-)

-- 
2.7.4

