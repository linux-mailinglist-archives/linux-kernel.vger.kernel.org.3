Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0153C412
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiFCFQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiFCFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:15:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8E1DA7A;
        Thu,  2 Jun 2022 22:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654233358; x=1685769358;
  h=from:to:cc:subject:date:message-id;
  bh=Ge1gbin2Zi+5E3Ffq8bDJlJUi5gXuH8wLSk+AZeXiqs=;
  b=PxElbT6aSixVPHw291xRZEd+UuK0p/5t0CznhvoPCfyFC+lJbPbqC2K8
   d3a6kAxBftgoTQB36xQHISuEuU18QiGjsNWoyaDqAwI+iafUucLN0mIEr
   rAxtMzxigYjhHOp9/asfJs9mRsRPdZ1TPtlBB4/AS+4Qqu3+oKD92yreB
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 22:15:58 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Jun 2022 22:15:56 -0700
X-QCInternal: smtphost
Received: from hu-sartgarg-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.105.147])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Jun 2022 10:45:42 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 533945001CD; Fri,  3 Jun 2022 10:45:41 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: [PATCH V1 0/2] Introduce new flag to force hardware reset
Date:   Fri,  3 Jun 2022 10:45:31 +0530
Message-Id: <20220603051534.22672-1-quic_sartgarg@quicinc.com>
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

Introduce new flag cqe_recovery_reset_always in mmc_host to allow vendors
to force hardware reset during cqe recovery as per their needs.

Sarthak Garg (2):
  mmc: core: Introduce new flag to force hardware reset
  mmc: sdhci-msm: Enable force hw reset during cqe recovery

 drivers/mmc/core/block.c     | 2 +-
 drivers/mmc/host/sdhci-msm.c | 3 +++
 include/linux/mmc/host.h     | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

