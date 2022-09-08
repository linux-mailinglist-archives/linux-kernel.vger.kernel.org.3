Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF25B2973
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIHWjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIHWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:39:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC71BD152
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:39:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAy-0003rz-TP; Fri, 09 Sep 2022 00:39:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAw-004hx0-BN; Fri, 09 Sep 2022 00:39:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAx-00H0Pe-0o; Fri, 09 Sep 2022 00:39:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel@pengutronix.de
Subject: [PATCH 2/2] kallsyms: Specify copyright using SPDX
Date:   Fri,  9 Sep 2022 00:38:50 +0200
Message-Id: <20220908223850.13217-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jzafaDwCy+SJkXDC801rpct9voGSo1lsZgU5hrVaBmE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjGm73teYTTHTeDETZhGFMsNfGzmHy2FFWuSueWST9 HPR1/eqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYxpu9wAKCRDB/BR4rcrsCXozCA CMGx5PZ9eTP95m4JzsEP1vSJ24c5xDBeL60lUDfAaiNzKOnVm3VJSyasE0AgliTQUx6Xy7NaBxYUFb D7Kl97Qlv43dxcJ4QFO2fuxy1W3sm8EJimJV748vMSB68RqJTifH6ooQfZhFwjlLG7xRu9Tl+VExuB JcTwEABpTBh1I4UhC4JmaNsTvsexgl0u+UKYk+93n3R1SiLdmOgN9xCrrMUk/0A2FbCd47GFU8epiv XxNa1cLM9IDKdR+EePw5YXbxI1V77+mjLWU9I6HR9SPEFb5UGm1J7od2wHcTw8lb8cOFYVkJdu48dB G3vUUIZbUD4PymXJJe2fldMqoWNZBr
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

Convert the copyright statement to a machine readable format following
the SPDX specification.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 scripts/kallsyms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 94c082f2c4db..73f6b9e8087e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: 2002 Kai Germaschewski
 
 /* Generate assembler source containing symbol information
- *
- * Copyright 2002       by Kai Germaschewski
  *
  * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
  *
-- 
2.37.2

