Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5842B534EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbiEZMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEZMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:13:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244BB0A4C;
        Thu, 26 May 2022 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653567205; x=1685103205;
  h=from:to:cc:subject:date:message-id;
  bh=jREdwedU754067LYMBa63BWax5EqcTU09KzqXoXU43s=;
  b=QyP2cOf5DdzLwq0KpxRlBuq7tZdStSepCm5snzXgPO9QWu9u+jnvqDlj
   Cng9RMwlmDcijJ5ADJU2gc8J3J9vChXY5KP/b9i0q2PQRvMijbUgeK/JD
   BUwevOSubG1mAomHF+eFASTxXF9sCExGisWzQzPvPOhNiI3BZsD84fECz
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 05:13:24 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 May 2022 05:13:22 -0700
X-QCInternal: smtphost
Received: from hu-sartgarg-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.105.147])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 May 2022 17:43:08 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 50CA85001B7; Thu, 26 May 2022 17:43:07 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: [PATCH V2 0/2] mmc: Add wakeup functionality support for sdio cards
Date:   Thu, 26 May 2022 17:42:13 +0530
Message-Id: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1:
	- Define a new vendor ops to let vendor enable wakeup capability
	  as per their needs.

Sarthak Garg (2):
  mmc: core: Define a new vendor ops to enable wakeup capability
  mmc: sdhci-msm: Add wakeup functionality to sdio cards

 drivers/mmc/core/bus.c       |  3 +++
 drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
 include/linux/mmc/host.h     |  7 +++++++
 3 files changed, 24 insertions(+)

-- 
2.17.1

