Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40457834D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiGRNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiGRNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:12:42 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2113A22BC8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:12:37 -0700 (PDT)
X-QQ-mid: bizesmtp81t1658149951tqqkp349
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:12:30 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: Chk1D9siCl8k9KKT1n3hLC1LlK3RpZYmJO+KWILg3Ds51wg3gdPDVAk7bP4Is
        WWnEjER6/tnn2v/vcVhgAzNiTCECEXHd8KUB7emXQQ9LMJR2GiTzkwD0C8KLEvmWRhS9Lo6
        eTmZE9dI2zoq1tOb5ZCFb6icX6HgA4MJMn7C7gy7PgnRkpjgiqr0pr9l/jRM6QzKPsrUpxl
        1fC9KhdPykIuJP3Iz7kYo7WpGIqZ1lr01JJKg/OJDglAWQd8n80CXwSrxrAlHgAu/KeNHIs
        fJm2AkEunFcADOFiIaEDo1mneqmPSw8kSE0apHoz8B4CvDGRfMzZVYIV5a4Y+sF9T0ALa+7
        cNbtSL/IxnRw2kf25Ls5G8FIuzBkiBeVaWAvrueFhj0b7/otud1eu2lv06qn+YvKbtnP2BC
        XP5aoBSAY0M=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] init: Fix comment typo
Date:   Fri, 15 Jul 2022 13:10:33 +0800
Message-Id: <20220715051033.27972-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
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

The double `core' is duplicated in line 33, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/base/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/init.c b/drivers/base/init.c
index 397eb9880cec..ae75ed7bbc41 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -30,7 +30,7 @@ void __init driver_init(void)
 	hypervisor_init();
 
 	/* These are also core pieces, but must come after the
-	 * core core pieces.
+	 * core pieces.
 	 */
 	of_core_init();
 	platform_bus_init();
-- 
2.35.1

