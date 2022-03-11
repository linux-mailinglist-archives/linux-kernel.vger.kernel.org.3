Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A84D61E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbiCKM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348707AbiCKM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:56:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC11C1AD6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:55:26 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFQqC5WkTzfYvL;
        Fri, 11 Mar 2022 20:53:59 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 20:55:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <lukas.bulwahn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mfd: db8500-prcmu: Remove unused inline function
Date:   Fri, 11 Mar 2022 20:55:18 +0800
Message-ID: <20220311125518.31064-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b0e846248de5 ("mfd: db8500-prcmu: Remove dead code for a non-existing config")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/mfd/dbx500-prcmu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 2a255362b5ac..e7a7e70fdb38 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -561,10 +561,6 @@ static inline unsigned long prcmu_qos_get_cpufreq_opp_delay(void)
 	return 0;
 }
 
-static inline void prcmu_qos_set_cpufreq_opp_delay(unsigned long n) {}
-
-static inline void prcmu_qos_force_opp(int prcmu_qos_class, s32 i) {}
-
 static inline int prcmu_qos_requirement(int prcmu_qos_class)
 {
 	return 0;
-- 
2.17.1

