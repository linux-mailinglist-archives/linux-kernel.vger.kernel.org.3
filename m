Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC9495591
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377687AbiATUm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:42:26 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:29437 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377625AbiATUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642711341; x=1674247341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hBqGHWmF6+FBl2MOZaRLl1N1kSXW8IuLzw3JcOYlYm4=;
  b=OqXCThhimrMJQRvyKHtLnZK15rCeXdXl4Ju0x9XTpT3v4RKbMr79VACu
   jqtxoNxbCvEi1c0sX7hc5kaYYucbXGw60/ZPUFhFoksQH6L/c0NncD1u0
   XDCKwI5873ta4kO/tnrnQZXQmaOQpLFoVG0uTAHpBMDL2pX2GG6Du/hb3
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 12:42:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 12:42:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 12:42:19 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 12:42:19 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 0/3] Add support for pm8941-pwrkey.c 
Date:   Thu, 20 Jan 2022 12:41:30 -0800
Message-ID: <20220120204132.17875-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change series includes support and fixes in pm8941-pwrkey.c.
Change details and description can be found in each patch. Thanks!

David Collins (3):
  input: misc: pm8941-pwrkey: simulate missed key press events
  input: misc: pm8941-pwrkey: add software key press debouncing support
  input: misc: pm8941-pwrkey: avoid potential null pointer dereference

 drivers/input/misc/pm8941-pwrkey.c | 130 ++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 10 deletions(-)

-- 
2.34.1

