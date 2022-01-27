Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA249ECF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiA0VB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:01:58 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:57617 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbiA0VB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643317317; x=1674853317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y1w9+HTy7myGydcWghzBQgNGlHnxReAtUIQ4LYTOxWk=;
  b=M7CA4yn5K47EOXOV2euqbNJZEkxu9EdZq+LI0o75kpEhGO09ogyUXrMW
   4ueW+esW8JZ432IsFa6fRwapYtNyJYT/VLfADKGT7vSTT8r3xtJmm0zdO
   zV/uUvfusWCxZGbyv2cgCX0ktje0hIFIr1MbyjPAdFCjVei8KYUuJQQOZ
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 13:01:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:01:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 13:01:56 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 13:01:56 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 0/4] Extend pm8941-pwrkey driver
Date:   Thu, 27 Jan 2022 13:00:21 -0800
Message-ID: <20220127210024.25597-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
  - Removed Change-Id from all patches
  - Updated subject line of cover letter
  - Addressed Stephen's comments for v1 1/3
    - Separated error message fix to own patch (v2 1/4)
    - Separated PON GEN3 base address changes to own patch (v2 2/4)
    - Added new variables and functions to make code more readable
  - Removed v1 3/3 as per Bjorn's comments

Anjelique Melendez (2):
  input: misc: pm8941-pwrkey: fix error message
  input: misc: pm8941-pwrkey: add support for PON GEN3 base addresses

David Collins (2):
  input: misc: pm8941-pwrkey: add software key press debouncing support
  input: misc: pm8941-pwrkey: simulate missed key press events

 drivers/input/misc/pm8941-pwrkey.c | 125 +++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 14 deletions(-)

-- 
2.34.1

