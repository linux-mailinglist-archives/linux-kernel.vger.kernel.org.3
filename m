Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E107546B874
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhLGKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:12:22 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38460 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234236AbhLGKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638871731; x=1670407731;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Ns4w7ToX6iyZrJvuaNdDtj0enc2fEgjC14n2E+1QA74=;
  b=qH3sMC0RCmq5RzL823Zbd+7E7lozt/RH2jyrs8PfirHReJ5L7Yjn6ehH
   a6msI9diOqN5ZvfSHLVKbesK6MZ7NKR8pjjJJr7P4+I0TyrcARR3G4hkm
   XKFlENR4bYjpot1v8OFcrfn6RikyzmZx5NFtZHGsh9HpuyhdHbTXaot/U
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 02:08:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:08:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 02:08:50 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 02:08:48 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 0/3] soc: qcom: rpmhpd: Cleanups and mx/cx fixup for sc7280
Date:   Tue, 7 Dec 2021 15:38:29 +0530
Message-ID: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
* Fixed the wrong assumption in v1 that only sdm845 needed mx to be
parent of cx, turned out all existing upstream SoCs need it except sc7280
* Added another cleanup patch to sort power-domain defines and lists in
alphabetical order as suggested by Matthias

Mostly cleanups, with a fixup to remove the parent/child relationship
across mx/cx for sc7280 SoC.

Rajendra Nayak (3):
  soc: qcom: rpmhpd: Rename rpmhpd struct names
  soc: qcom: rpmhpd: Remove mx/cx relationship on sc7280
  soc: qcom: rpmhpd: Sort power-domain definitions and lists

 drivers/soc/qcom/rpmhpd.c | 287 ++++++++++++++++++++++++----------------------
 1 file changed, 152 insertions(+), 135 deletions(-)

-- 
2.7.4

