Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957C59AD7D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbiHTLcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344174AbiHTLcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:32:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331067F261;
        Sat, 20 Aug 2022 04:32:16 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M8xG93bnyz1N7Rk;
        Sat, 20 Aug 2022 19:28:49 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 20 Aug
 2022 19:32:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc: qcom: Make QCOM_RPMPD depend on OF
Date:   Sat, 20 Aug 2022 19:32:02 +0800
Message-ID: <20220820113202.23940-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
  Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
  Selected by [m]:
  - QCOM_RPMPD [=m] && PM [=y] && QCOM_SMD_RPM [=m]

PM_GENERIC_DOMAINS_OF depends on OF, so QCOM_RPMPD also depends on it.

Fixes: 7d0221fb5912 ("soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e0d7a5459562..024e420f1bb7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -129,7 +129,7 @@ config QCOM_RPMHPD
 
 config QCOM_RPMPD
 	tristate "Qualcomm RPM Power domain driver"
-	depends on PM
+	depends on PM && OF
 	depends on QCOM_SMD_RPM
 	select PM_GENERIC_DOMAINS
 	select PM_GENERIC_DOMAINS_OF
-- 
2.17.1

