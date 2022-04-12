Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F2A4FE26D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356219AbiDLNZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355956AbiDLNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:24:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F82C13F;
        Tue, 12 Apr 2022 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649769324; x=1681305324;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=KRwOq5mfpCz05TtDePHTpU6eHexJLhKjTnWDKxqmvWA=;
  b=ZwvfVpmNoS7N+M4yr7xa2S9Hcr1Hthq4qztogW2lTR3fMhL1+RxPXs5b
   6rlWfPIAZxc83IRoZnXyAG3EDrV8s0Eh48R+/krN2LAX/K4N0v9rJBz8J
   Jl4lcFK7hrupbFFioflVdTImNZKq3qgCXiqHWyEkxNVe9HvXRPXFHItoH
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Apr 2022 06:15:24 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:15:23 -0700
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 06:15:22 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_vgarodia@quicinc.com>
Subject: [PATCH v2 0/2] Venus fixes 
Date:   Tue, 12 Apr 2022 18:45:09 +0530
Message-ID: <1649769311-22622-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in this version since v1 includes:
* addressed comments from Stanimir.

Vikash Garodia (2):
  media: venus: do not queue internal buffers from previous sequence
  media: venus: vdec: ensure venus is powered on during stream off

 drivers/media/platform/qcom/venus/helpers.c | 34 +++++++++++++++++++++--------
 drivers/media/platform/qcom/venus/vdec.c    |  2 ++
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

