Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710594D7C41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiCNHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiCNHyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:54:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028623192F;
        Mon, 14 Mar 2022 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647244410; x=1678780410;
  h=from:to:cc:subject:date:message-id;
  bh=o1UQvzKZoiUWF4YP06oEd55LjzuE1zwUru0Akp28pt0=;
  b=QmsYVPcvb+hbwdcuRcfs8AC00rXyXGWM4QHNgbYdbJSACGVa6wQWmriW
   IGyvlkJZkvFCHfMPOqN3WfuICMZvbWe47FUmD9lpcTRndoPJmrmcmvp/P
   Xd/iKmeXvWxZnsOaqUsnSr3UUN3pPWHcht1M0cP5vT7phSPsKUXU2Lnbk
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Mar 2022 00:53:29 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Mar 2022 00:53:28 -0700
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Mar 2022 13:23:14 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 9F77E4679; Mon, 14 Mar 2022 13:23:12 +0530 (+0530)
From:   quic_dikshita@quicinc.com
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 0/2] Intra-refresh type control
Date:   Mon, 14 Mar 2022 13:23:02 +0530
Message-Id: <1647244384-19918-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Hi,

This series add a new intra-refresh type control for encoders.
this can be used to specify which intra refresh to be enabled,
random, cyclic or none.

Change since v0:
 Dropped INTRA_REFRESH_TYPE_NONE as it was not needed.
 Intra refresh period value as zero will disable the intra
 refresh.

Change since v1:
 Updated the control name for better undestanding.
 Also updated the documentation accordingly.

Thanks,
Dikshita

Dikshita Agarwal (2):
  media: v4l2-ctrls: Add intra-refresh type control
  venus: venc: Add support for intra-refresh mode

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 27 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/venc.c           |  3 ++-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  8 +++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 ++++++++
 include/uapi/linux/v4l2-controls.h                 |  5 ++++
 6 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.7.4

