Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23E656631A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGEGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGEGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:25:50 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F3B2A1AB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:25:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4424C1E80D71;
        Tue,  5 Jul 2022 14:23:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qn9P1TPTa_QX; Tue,  5 Jul 2022 14:23:41 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3864D1E80D19;
        Tue,  5 Jul 2022 14:23:41 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     sudipm.mukherjee@gmail.com
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] parport: Fix spelling mistake in comments
Date:   Tue,  5 Jul 2022 14:25:42 +0800
Message-Id: <20220705062542.13945-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of don' t.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/parport/share.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 62f8407923d4..c1a45b950f3d 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -770,7 +770,7 @@ parport_register_dev_model(struct parport *port, const char *name,
 	/* Chain this onto the list */
 	par_dev->prev = NULL;
 	/*
-	 * This function must not run from an irq handler so we don' t need
+	 * This function must not run from an irq handler so we don't need
 	 * to clear irq on the local CPU. -arca
 	 */
 	spin_lock(&port->physport->pardevice_lock);
-- 
2.34.1

