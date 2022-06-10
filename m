Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187415459AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiFJBtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiFJBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:49:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9F1A6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:49:38 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LK3ht2vXFzRhZl;
        Fri, 10 Jun 2022 09:46:22 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 09:49:36 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 09:49:35 +0800
From:   Wang Jingjin <wangjingjin1@huawei.com>
To:     <gerg@linux-m68k.org>, <geert@linux-m68k.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] m68k: coldfire: make symbol m523x_clk_lookup static
Date:   Fri, 10 Jun 2022 10:07:55 +0800
Message-ID: <20220610020755.187733-1-wangjingjin1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
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

arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol 'm523x_clk_lookup' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
---
 arch/m68k/coldfire/m523x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/m523x.c b/arch/m68k/coldfire/m523x.c
index 193c178162c1..83a997313393 100644
--- a/arch/m68k/coldfire/m523x.c
+++ b/arch/m68k/coldfire/m523x.c
@@ -28,7 +28,7 @@
 DEFINE_CLK(pll, "pll.0", MCF_CLK);
 DEFINE_CLK(sys, "sys.0", MCF_BUSCLK);

-struct clk_lookup m523x_clk_lookup[] = {
+static struct clk_lookup m523x_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "pll.0", &clk_pll),
 	CLKDEV_INIT(NULL, "sys.0", &clk_sys),
 	CLKDEV_INIT("mcfpit.0", NULL, &clk_pll),
--
2.25.1

