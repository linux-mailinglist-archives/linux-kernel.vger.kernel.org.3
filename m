Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CEF588E71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiHCOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHCOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:21:44 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2FF15834;
        Wed,  3 Aug 2022 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659536501; x=1691072501;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5jOcz9EyZL1YgSchVG+RA2wlmd33bNCKollLe+eHGBA=;
  b=JGAMEWEKf5eSnsHHRZxuJ6322LO2yG86g33Sz2F9UtcwBTeVdOZfTnbe
   IpHl6/lPpG++oHCzd0b9AroRll49t7Z1ZRx9YJ6G82p8dhz4ph87K9Gx/
   +L9QTCaSZcRDojHgPB5xo7Vd4QKUq6qc+5XD7PTB6o3wMDkETAVssnku7
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Aug 2022 07:21:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:21:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 07:21:40 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 07:21:35 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/8] Update ADSP pil loader for SC7280 platform
Date:   Wed, 3 Aug 2022 19:51:12 +0530
Message-ID: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADSP pil loader driver for SC7280 platforms.

Srinivasa Rao Mandadapu (8):
  dt-bindings: remoteproc: qcom: adsp: Make ADSP pil loader as generic
  dt-bindings: remoteproc: qcom: adsp: Add compatible name for SC7280
  remoteproc: qcom: Add compatible name for SC7280 ADSP
  remoteproc: qcom: Update hard coded values with macros
  remoteproc: qcom: Add efuse evb selection control
  remoteproc: qcom: Add flag in adsp private data structure
  remoteproc: qcom: Add support for memory sandbox
  remoteproc: qcom: Update QDSP6 out-of-reset timeout value

 .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml   | 161 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 --------------------
 drivers/remoteproc/qcom_q6v5_adsp.c                | 145 ++++++++++++++++++-
 3 files changed, 300 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml

-- 
2.7.4

