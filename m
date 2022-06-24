Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB7559568
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiFXI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:27:36 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86371766BE;
        Fri, 24 Jun 2022 01:27:35 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 49D671E80D59;
        Fri, 24 Jun 2022 16:27:07 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ehf10wjBOl_v; Fri, 24 Jun 2022 16:27:04 +0800 (CST)
Received: from nfschina.com.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7FEA01E80D1A;
        Fri, 24 Jun 2022 16:27:04 +0800 (CST)
From:   zhoun <zhounan@nfschina.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, lutovinova@ispras.ru,
        jakobkoschel@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhoun <zhounan@nfschina.com>
Subject: [PATCH] usb: remove unnecessary mv_u3d* type casting
Date:   Fri, 24 Jun 2022 04:26:51 -0400
Message-Id: <20220624082651.6804-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.27.0
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

remove unnecessary mv_u3d* type casting.

Signed-off-by: zhoun <zhounan@nfschina.com>
---
 drivers/usb/gadget/udc/mv_u3d_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 598654a3cb41..102278a71307 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -175,7 +175,7 @@ void mv_u3d_done(struct mv_u3d_ep *ep, struct mv_u3d_req *req, int status)
 	__releases(&ep->udc->lock)
 	__acquires(&ep->udc->lock)
 {
-	struct mv_u3d *u3d = (struct mv_u3d *)ep->u3d;
+	struct mv_u3d *u3d = ep->u3d;
 
 	dev_dbg(u3d->dev, "mv_u3d_done: remove req->queue\n");
 	/* Removed the req from ep queue */
-- 
2.27.0

