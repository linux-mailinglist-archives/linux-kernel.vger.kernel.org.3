Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2251DE3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444136AbiEFRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352563AbiEFRTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:19:42 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E84D84F465;
        Fri,  6 May 2022 10:15:58 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6016C72C8FA;
        Fri,  6 May 2022 20:15:57 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by imap.altlinux.org (Postfix) with ESMTP id F294E4A46EE;
        Fri,  6 May 2022 20:15:56 +0300 (MSK)
From:   Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH] rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE ioctl request definition
Date:   Fri,  6 May 2022 17:15:34 +0000
Message-Id: <20220506171534.99509-1-glebfm@altlinux.org>
X-Mailer: git-send-email 2.33.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 54f586a91532 ("rfkill: make new event layout opt-in")
---
 include/uapi/linux/rfkill.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/rfkill.h b/include/uapi/linux/rfkill.h
index 283c5a7b3f2c..db6c8588c1d0 100644
--- a/include/uapi/linux/rfkill.h
+++ b/include/uapi/linux/rfkill.h
@@ -184,7 +184,7 @@ struct rfkill_event_ext {
 #define RFKILL_IOC_NOINPUT	1
 #define RFKILL_IOCTL_NOINPUT	_IO(RFKILL_IOC_MAGIC, RFKILL_IOC_NOINPUT)
 #define RFKILL_IOC_MAX_SIZE	2
-#define RFKILL_IOCTL_MAX_SIZE	_IOW(RFKILL_IOC_MAGIC, RFKILL_IOC_EXT_SIZE, __u32)
+#define RFKILL_IOCTL_MAX_SIZE	_IOW(RFKILL_IOC_MAGIC, RFKILL_IOC_MAX_SIZE, __u32)
 
 /* and that's all userspace gets */
 
-- 
glebfm

