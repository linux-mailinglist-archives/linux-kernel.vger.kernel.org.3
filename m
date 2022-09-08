Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6000F5B1CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIHMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiIHMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:22:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C41316DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:22:42 -0700 (PDT)
X-QQ-mid: bizesmtp89t1662639758tjqlery3
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:22:37 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: hWIfutFPnzhdGfaSjJO/9RLXml8RanHD0cG/91rhA6FE+aTrN1nr5yLnQrv33
        qdJfCYVe/XNC5x2+JjeM3WanLyMhBd0QAtWj5v4l15vem8ea9iG8TqQbDFIrvynzMKWWQVr
        DoJkgajU7wpGEgxrf7tLpchCUSug2mNQKnGn1s//dKaT8A1oJp4eOKSxT6ogyxGimB8UJt/
        wTrkbOwZQB6DWxPG3ayid6IMTEnEZz6PehCDXdlr0xJq26tDtUrlF+XWEkPikqPNBNnibaD
        lYsCw9dv0XHhvJ3RI1JoSmFXF+bD3t3TPJUlNaQjX7CiWZ2Iqan4ICXp5aGPdvXKcds8Uye
        +JgVkuHe5hZOqJhu/B3EWCzXkdmotA+irNR4L7A5dy6JNGRAc8=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/mtd: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:22:29 +0800
Message-Id: <20220908122229.10814-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mtd/mtdconcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f685a581df48..193428de6a4b 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -836,7 +836,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 
 		/*
 		 * walk the map of the new device once more and fill in
-		 * in erase region info:
+		 * erase region info:
 		 */
 		curr_erasesize = subdev[0]->erasesize;
 		begin = position = 0;
-- 
2.36.1

