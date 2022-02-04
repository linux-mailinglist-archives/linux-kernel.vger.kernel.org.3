Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377494AA3A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355860AbiBDW4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:56:32 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22906 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355625AbiBDW4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644015391; x=1675551391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sAJLGY3CYWoZ9I7K46EUZ5x5/6daf2o0KT10Pq8KtRw=;
  b=e87qHC1fLKQd30RaloAdY5gINDgl7EaM/gJj9DFf7uf3kJfrjoHT+4t0
   IE5F9MCtpssjKQ8wUVnBNfRsCqC5URK3yXhzHLrf2v/z7HFwazN572FeB
   EiSQKMEwgEw3mWzs8epzIgiuErXIPalbzrIfY2TYCuOAByVNsHyqvLOyU
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Feb 2022 14:56:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:56:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 14:56:29 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 14:56:29 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v4 0/4] Extend pm8941-pwrkey driver
Date:   Fri, 4 Feb 2022 14:55:57 -0800
Message-ID: <20220204225600.1663-1-quic_amelende@quicinc.com>
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

Changes from v3:
  - Fixed dereference issue in 2/4
  - Added Stephen's reviewed by tag for 2/4

Changes from v2:
  - Addressed Stephen's comments
    - Add Stephen's reviewed by tag for 1/4
    - Fixed style for 2/4
    - Corrected function call to use correct function for 3/4

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

 drivers/input/misc/pm8941-pwrkey.c | 124 +++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 14 deletions(-)

-- 
2.34.1

