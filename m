Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F45B2972
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIHWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIHWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:39:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A1BCCF6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:39:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAy-0003ry-HP; Fri, 09 Sep 2022 00:39:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAv-004hwx-R3; Fri, 09 Sep 2022 00:39:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAw-00H0Pb-S6; Fri, 09 Sep 2022 00:39:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel@pengutronix.de
Subject: [PATCH 1/2] kallsyms: Specify license using SPDX
Date:   Fri,  9 Sep 2022 00:38:49 +0200
Message-Id: <20220908223850.13217-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HJqdIzeRjDmniJYd+YOYAzQ/IcgkQKhLF0CyS5udIhs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjGm70r5OdUQ+4GRIEb21jir0S/BnyKxLvREZua3qU nyZy8BaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYxpu9AAKCRDB/BR4rcrsCREtB/ 4gGB+G15jI8ejdwmmp2/ivezaRqd5CjjS8SgzcmS5QkQ5kOfQ2ITiIs6nD68dDcCyRM7LucgyQkbVA 3vkEAHg1UX6vYLZgLccxcHD76TgWrJOLg5TcfCgbGgA7e9ZzY/IW7A+r22k0MzFP8rSQ1iW1aEdRo0 k1o9xeIHTf825MjYCzTMsgvwD346kOGcvUKt3V/0cSS25y8Di/wzK5TrPDQHtg8+P55QzAYm2lVwrn hnuiVF5H67UWngWx729cITSGePvBs7rj0snsqRSYCo9b/eGN27ajMTOeOaHP1nRV7VFwouyJsP7c16 qe38vM+iBiHm7/jm2B2izuas2J6Tqq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original license specification is a bit fuzzy about the actual
version of the GPL. Also it promises to include the license, but it
doesn't. Interpret that as GPL-2.0-only.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 scripts/kallsyms.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..94c082f2c4db 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 /* Generate assembler source containing symbol information
  *
  * Copyright 2002       by Kai Germaschewski
  *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- *
  * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
  *
  *      Table compression uses all the unused char codes on the symbols and
-- 
2.37.2

