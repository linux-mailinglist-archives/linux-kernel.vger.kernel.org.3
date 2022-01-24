Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B511D497CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiAXKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:12:33 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2744 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiAXKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1643019152; x=1674555152;
  h=from:to:cc:subject:date:message-id;
  bh=KsBJ1kPN+Zx14KRVlqmqrYbNjd8boivm53GBH0FmqyQ=;
  b=QTWSbOTNcNEnX8teZ05bEm7VsyOGWsnnoqAw6cisuMi9CR6/ANAitu7D
   KIZf7urZGlEm2vzqjt5vOxf61C7hJL/YAttjhJQ7xg3GyGpwXyX9ImKYV
   8eOrG4gJfePAdAo6nonH+NkaQs46Z76LMPvsCQEsgG/EgtvBWxa7Hac2Z
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jan 2022 02:12:32 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jan 2022 02:12:30 -0800
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Jan 2022 15:42:18 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 2E2D644ED; Mon, 24 Jan 2022 15:42:17 +0530 (+0530)
From:   Dikshita Agarwal <dikshita@qti.qualcomm.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Subject: [PATCH v1 0/2] Intra-refresh type control
Date:   Mon, 24 Jan 2022 15:41:57 +0530
Message-Id: <1643019119-8309-1-git-send-email-dikshita@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add a new intra-refresh type control for encoders.
this can be used to specify which intra refresh to be enabled,
random, cyclic or none.

Change since v0:
 Dropped INTRA_REFRESH_TYPE_NONE as it was not needed.
 Intra refresh period value as zero will disable the intra
 refresh.

Thanks,
Dikshita

Dikshita Agarwal (2):
  media: v4l2-ctrls: Add intra-refresh type control
  venus: venc: Add support for intra-refresh mode

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 23 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/venc.c           |  3 ++-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  8 ++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 +++++++++
 include/uapi/linux/v4l2-controls.h                 |  5 +++++
 6 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.7.4

