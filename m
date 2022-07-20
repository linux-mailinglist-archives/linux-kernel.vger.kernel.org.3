Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A04657BED3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiGTTp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGTTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:45:52 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF21145B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:45:47 -0700 (PDT)
X-QQ-mid: bizesmtp91t1658346343t1sr5yvd
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:45:26 +0800 (CST)
X-QQ-SSF: 0100000000200030C000C00A0000020
X-QQ-FEAT: FL7fsQr89f8plxF81EDIW7tFv2NlejBAABXE4pDqwsdYIrEo0ujDrBrH4Q4Nj
        /Z06ovsGHcPofMa/xXoVB+BPMckdAwbtulfTL7Vrg1z5aR1LPaDVP/j3QpSjN3ppOB2oo1s
        rdPV9axOPix8zYddIAQN49NYGKbj4tKwHdqiKj00CJoKoIiWXCYnMa9dfOuQ6wzGnMn4moJ
        sMTxgp+Ozhh7+eQeK3ji6uchqjt+3pLdE6T4ajfBDE3xDK6Q0ArpaWyCkW+Lg6hP0nyMuRN
        QmtxgfuGZvfVevRjMqCF0DjjfJAY00P7dpk0u80H5N+tlIufhdoTl7kd21nVV+Thtehhb+Q
        bmkj/5d16zj2XaBhTmQz9tu9TVH14m00fzC926s7UD1+kGgosI=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] w1:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:45:25 +0800
Message-Id: <20220720194525.8620-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..bb28e36993d6 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -32,7 +32,7 @@ static int w1_timeout = 10;
 module_param_named(timeout, w1_timeout, int, 0);
 MODULE_PARM_DESC(timeout, "time in seconds between automatic slave searches");
 
-static int w1_timeout_us = 0;
+static int w1_timeout_us;
 module_param_named(timeout_us, w1_timeout_us, int, 0);
 MODULE_PARM_DESC(timeout_us,
 		 "time in microseconds between automatic slave searches");
-- 
2.30.2

