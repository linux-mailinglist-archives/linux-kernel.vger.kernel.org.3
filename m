Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D56487803
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiAGNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:12:27 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:65434 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiAGNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641561146; x=1673097146;
  h=from:to:cc:subject:date:message-id;
  bh=ffI7Hi0JpP4eF3pXBsfDbjI+KQUWpO3SykudXjPeFsA=;
  b=Z1v5ojLenVH4MMhnpgRru9yytkyOPrEJQ5NZ9WZAricc94xlzpFdBkdx
   08ADmPuekR4uchnvOTFM4uLbNgZ769trU+yqaRykPDzfbqMKJo0yxSk56
   Lcc6HoIt2NQDYxJ26egmaNSOTMpjxnFFzGoTYgFKuzHCGWbMa0i67slZv
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Jan 2022 05:12:25 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jan 2022 05:12:24 -0800
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Jan 2022 18:42:13 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id B5BBA422C; Fri,  7 Jan 2022 18:42:11 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH 0/2] Intra-refresh type control
Date:   Fri,  7 Jan 2022 18:42:02 +0530
Message-Id: <1641561124-19476-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add a new intra-refresh type control for encoders.
this can be used to specify which intra refresh to be enabled,
random, cyclic or none. 

Thanks,
Dikshita

Dikshita Agarwal (2):
  media: v4l2-ctrls: Add intra-refresh type control
  venus: venc: Add support for intra-refresh mode

 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 27 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/venc.c           |  3 ++-
 drivers/media/platform/qcom/venus/venc_ctrls.c     | 10 ++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 10 ++++++++
 include/uapi/linux/v4l2-controls.h                 |  6 +++++
 6 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.7.4

