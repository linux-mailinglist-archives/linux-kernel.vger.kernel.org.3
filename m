Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638D4575E58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiGOJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiGOJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:18:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0EE15FFD;
        Fri, 15 Jul 2022 02:18:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CA52C1E80D19;
        Fri, 15 Jul 2022 17:15:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J2h_zqWIEWNU; Fri, 15 Jul 2022 17:15:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1BDF21E80D11;
        Fri, 15 Jul 2022 17:15:14 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kernel@nfschina.com,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] keys/keyrings: Fix typo in string
Date:   Fri, 15 Jul 2022 17:18:42 +0800
Message-Id: <20220715091842.4419-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 security/keys/request_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2da4404276f0..190608719f3d 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -375,7 +375,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	key_ref_t key_ref;
 	int ret;
 
-	kenter("%s,%s,,,",
+	kenter("%s,%s",
 	       ctx->index_key.type->name, ctx->index_key.description);
 
 	*_key = NULL;
-- 
2.18.2

