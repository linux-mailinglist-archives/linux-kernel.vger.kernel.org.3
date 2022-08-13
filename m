Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A46591BD6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbiHMQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiHMQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:01:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC1C640A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:01:04 -0700 (PDT)
X-QQ-mid: bizesmtp89t1660406454thm69xfw
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 14 Aug 2022 00:00:41 +0800 (CST)
X-QQ-SSF: 0100000000000080H000000A0000020
X-QQ-FEAT: LE7C6P2vL8T99D5vTKTlaAJZ4EFWc2MlBQ3xk5yMOCWXUpiEykI4b0NlUoiBT
        pY7l9UNq61HM3LM48LdsGdLb9Am3ayWxkPiaxH+OwhB6G5qclxA5uvwfEZpPw96UsLZr6yh
        UuylhxdtfhxjWjXk38U8lN/wGcTQrO6GG3uFgR6CovvGsq05QmmYy2s3E6MlKYax1X6RJH5
        NexbOvWprjfJ6ZP2KpNcmoTFelx7vkpnLeSszZ+tRZpA9CFKt+zhz+UtZBkiZbwjT6hyEQp
        Y7xjRUGgvWM845d4gmII9Lo/OdVEl0abzmOUvyz4XO8Am7Mk5Bea4ddy74UN0gqbnVly7Qp
        uPT/Za8U9a8sBCZTnM=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     pjones@redhat.com, konrad@kernel.org
Cc:     linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] iscsi_ibft: Unneeded semicolon
Date:   Sun, 14 Aug 2022 00:00:29 +0800
Message-Id: <20220813160029.5493-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no semicolon after '}' in line 803.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/firmware/iscsi_ibft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 6e9788324fea..3c52fde713ce 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -800,7 +800,7 @@ static void ibft_unregister(void)
 		ibft_kobj = boot_kobj->data;
 		if (ibft_kobj->hdr && ibft_kobj->hdr->id == id_nic)
 			sysfs_remove_link(&boot_kobj->kobj, "device");
-	};
+	}
 }
 
 static void ibft_cleanup(void)
-- 
2.17.1

