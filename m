Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57512547F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiFMGNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiFMGNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:13:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A713F22;
        Sun, 12 Jun 2022 23:13:04 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM1PP3ybmzRj08;
        Mon, 13 Jun 2022 14:09:45 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 14:13:01 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 14:13:00 +0800
From:   Jin Xiaoyun <jinxiaoyun2@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jin Xiaoyun <jinxiaoyun2@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] thermal: k3_j72xx_bandgap: Make k3_j72xx_bandgap_j721e_data and k3_j72xx_bandgap_j7200_data static
Date:   Mon, 13 Jun 2022 14:31:11 +0800
Message-ID: <20220613063111.654893-1-jinxiaoyun2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/thermal/k3_j72xx_bandgap.c:532:36: sparse: sparse: symbol 'k3_j72xx_bandgap_j721e_data' was not declared. Should it be static?
drivers/thermal/k3_j72xx_bandgap.c:536:36: sparse: sparse: symbol 'k3_j72xx_bandgap_j7200_data' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 64e323158952..f8ff20feb120 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -529,11 +529,11 @@ static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
 	return 0;
 }

-const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
+static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
 	.has_errata_i2128 = 1,
 };

-const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
+static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
 	.has_errata_i2128 = 0,
 };

--
2.25.1

