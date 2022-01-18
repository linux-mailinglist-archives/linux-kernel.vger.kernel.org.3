Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFB492E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348863AbiARTnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:43:37 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:17610 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348857AbiARTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642535014; x=1674071014;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=epAwb4kSa9aNM9KRnbmlhSaoE0blUF/epw/IFB2mcn0=;
  b=oK4E668ZDuH2yz4yksuQ1Pe/tOX0RL3wFrm+b7QWLtQRUNp/qCkpomI7
   bnw+aHnLGU2GVWPRSRUrKwGMAdxLEa6IBs7OFkj12RRXnk0F5RYvzWI//
   3WaixxDYItd95UlP8RR4XdN67BwvnfEecHVoZ9+YxiHg30J5MfZmYk7FA
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jan 2022 11:43:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 11:43:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 11:43:34 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 11:43:31 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V2 0/3] rpmsg and glink signaling API support
Date:   Wed, 19 Jan 2022 01:13:10 +0530
Message-ID: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Change from V1]
Fixed most of the review comments in V1.

Deepak Kumar Singh (3):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support

 drivers/rpmsg/qcom_glink_native.c | 77 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 47 ++++++++++++++++++++++--
 drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 +
 include/linux/rpmsg.h             | 14 +++++++
 5 files changed, 157 insertions(+), 4 deletions(-)

-- 
2.7.4

