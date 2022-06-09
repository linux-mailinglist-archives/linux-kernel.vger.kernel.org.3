Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4F544D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbiFINT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbiFINT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:19:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98705FED;
        Thu,  9 Jun 2022 06:19:53 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LJl764G4Hz9snJ;
        Thu,  9 Jun 2022 21:19:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 21:19:49 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] platform/mellanox: make symbol 'nvsw_sn2201_i2c_data' static
Date:   Thu, 9 Jun 2022 21:33:03 +0800
Message-ID: <20220609133303.1591300-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/platform/mellanox/nvsw-sn2201.c: symbol 'nvsw_sn2201_i2c_data' was not declared. Should it be static?

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/platform/mellanox/nvsw-sn2201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index 0bcdc7c75007..2923daf63b75 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -326,7 +326,7 @@ static struct resource nvsw_sn2201_lpc_res[] = {
 };

 /* SN2201 I2C platform data. */
-struct mlxreg_core_hotplug_platform_data nvsw_sn2201_i2c_data = {
+static struct mlxreg_core_hotplug_platform_data nvsw_sn2201_i2c_data = {
 	.irq = NVSW_SN2201_CPLD_SYSIRQ,
 };

--
2.31.1

