Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEEA53D73F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiFDOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFDOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:33:36 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064D1A83B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:33:30 -0700 (PDT)
X-QQ-mid: bizesmtp62t1654353184taw8o99y
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 22:32:56 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: ACkb0FcbxRnyithG9SoP1M+IBOZkFbMg1M1leq8xB+WX1xn4ElrvJq5Nl3hSx
        YellU0xAq7AeDkN55tE03L7qaU0T9Zy2NWqc5ROgfhREzpk3Mp2buJHfacm87B7fFJSSYQB
        raf1C98pr6WW8CIVgYI1Lh3jyTf0T6/z02VPD+CW3b5mFun5x6oDV2uOBd1Kzj6nnr5HKyn
        6gsaQHaznV3x9d6HNgq5vj5c2EhqYLiKV+IRSDVBe/6t+3izsNsb/ptzcDrqGWwKUvh/4LX
        s6PPHbGhz/daemHvoNrCouTpAvC+l6QkK0KYUk3LbV2fS5ld7AzCu5xC1ntvAxTkRxrwelD
        2JPUVLmNDLdpdKUTnk=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] nvme: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 22:32:54 +0800
Message-Id: <20220604143254.15638-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'be'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c..c4746f140516 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -140,7 +140,7 @@ enum nvme_quirks {
 	NVME_QUIRK_DMA_ADDRESS_BITS_48		= (1 << 16),
 
 	/*
-	 * The controller requires the command_id value be be limited, so skip
+	 * The controller requires the command_id value be limited, so skip
 	 * encoding the generation sequence number.
 	 */
 	NVME_QUIRK_SKIP_CID_GEN			= (1 << 17),
-- 
2.36.1

