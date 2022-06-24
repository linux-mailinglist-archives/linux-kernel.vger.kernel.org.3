Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DC5593EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiFXHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFXHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:03:24 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E174532D0;
        Fri, 24 Jun 2022 00:03:19 -0700 (PDT)
X-QQ-mid: bizesmtp87t1656054183t4cmker1
Received: from localhost.localdomain ( [106.117.98.174])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 24 Jun 2022 15:02:57 +0800 (CST)
X-QQ-SSF: 01000000008000D0J000B00A0000000
X-QQ-FEAT: HoyAXBWgskk8h+Wf0Juv0vFSRMHHvYuQgp9jPvOoFsFJsvUlUUrtZK5U6nCMv
        DBkLRiEcG7ktw0lpUgnNZOX9HA9d/KqrzRfLDnT1uSceX9wFf1ygwmkiX3tKqtc6DcZLV/q
        rM5VlaqrhiYhFqAwXpGYKWdBp4vNWX2dILPyZDTFrj4mfPxVNe25syfBJuKZb+GcHJcXgAr
        jKw8PbkhjdV/DQlRMYUNzcXLv/UD/uwIx8y3K6qHLFp73AnJTVvMFQX3FUsc+kyjfwc0aPJ
        gVE8n4eMKaj4w3M3pVmeAwASrmnmwh+Ba1RfzcGmvExFKllI2eSWXMuZU8mw7xVbnTY5ILI
        Xv6wIgxfTaH8KkVJ5w=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     takedakn@nttdata.co.jp
Cc:     penguin-kernel@I-love.SAKURA.ne.jp, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] tomoyo: Fix typo in comment
Date:   Fri, 24 Jun 2022 15:02:54 +0800
Message-Id: <20220624070254.33998-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'path'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 security/tomoyo/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 1e6077568fde..772f7e1ddf6e 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -286,7 +286,7 @@ static bool tomoyo_check_path_number_acl(struct tomoyo_request_info *r,
 }
 
 /**
- * tomoyo_check_path2_acl - Check permission for path path operation.
+ * tomoyo_check_path2_acl - Check permission for path operation.
  *
  * @r:   Pointer to "struct tomoyo_request_info".
  * @ptr: Pointer to "struct tomoyo_acl_info".
-- 
2.36.1

