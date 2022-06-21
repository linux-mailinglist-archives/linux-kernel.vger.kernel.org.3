Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF927552F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349612AbiFUJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349571AbiFUJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:45:30 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A827B15;
        Tue, 21 Jun 2022 02:45:26 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655804705tocof5u4
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 17:45:00 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: rCzLTtzQ0geY+1AMB0PrV2Bh5I3EEKgRkGab8r6id2Ijbf/GqRI5ZyKlHP4pv
        b5JSPyzkhfY578k0NzjAH6GvMVPD88AtyInmZj3j9YPFjxQGjTdtTUawFRH0EG8CNLpEtRm
        QNJ61ztZV411N4vHSvJTFD4G97lrwtehKQlduC+YR6NyWQrLCLEJR1EiOVQWsCg//xsIGdv
        mFkTVTJGHnWYFZIpCVK20QSWT61HMwADsDYEMX4BH5omv0YCxrEApYUJXi7cZdxxux2NLqH
        Noj2k7pf70nWR4yzzAnBomBxSNHXmnE5XHjzI/LcOHvclut9UYBJw4qqcbD7j9JgRhwwuRL
        OiURoN3TYPQUeaFBBW7zf5E5oPuhQ==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangjian@cdjrlc.com
Subject: [PATCH] mmc: sdhci-acpi: remove unexpected word "the"
Date:   Tue, 21 Jun 2022 17:44:59 +0800
Message-Id: <20220621094459.80271-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be removed

*       instead use the the SDR104 preset register.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c0350e9c03f3..93fe6e5a5f9f 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	 *       in reading a garbage value and using the wrong presets.
 	 *
 	 *       Since HS400 and HS200 presets must be identical, we could
-	 *       instead use the the SDR104 preset register.
+	 *       instead use the SDR104 preset register.
 	 *
 	 *    If the above issues are resolved we could remove this quirk for
 	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
-- 
2.17.1

