Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB625A89FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIAAtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIAAtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:49:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A411BE2A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:49:03 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJ2SK28mxzHnVx;
        Thu,  1 Sep 2022 08:47:13 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 08:49:00 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] ARM: mmp: Make mmp2_resource_gpio static
Date:   Thu, 1 Sep 2022 08:45:24 +0800
Message-ID: <20220901004524.81383-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol is not used outside of the file, so mark it static.

Fixes the following warning:

./arch/arm/mach-mmp/mmp2.c:157:17: warning: symbol 'mmp2_resource_gpio' was not declared. Should it be static?

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 arch/arm/mach-mmp/mmp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index bbc4c2274de3..696bc1856e6d 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -154,7 +154,7 @@ MMP2_DEVICE(asram, "asram", -1, NONE, 0xe0000000, 0x4000);
 /* 0xd1000000 ~ 0xd101ffff is reserved for secure processor */
 MMP2_DEVICE(isram, "isram", -1, NONE, 0xd1020000, 0x18000);
 
-struct resource mmp2_resource_gpio[] = {
+static struct resource mmp2_resource_gpio[] = {
 	{
 		.start	= 0xd4019000,
 		.end	= 0xd4019fff,
-- 
2.25.1

