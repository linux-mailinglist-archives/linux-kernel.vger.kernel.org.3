Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7B564BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiGDCxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDCxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:53:10 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11F9E2ADA;
        Sun,  3 Jul 2022 19:53:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 60E2F1E80CCF;
        Mon,  4 Jul 2022 10:51:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k-tZ0YIiSzKU; Mon,  4 Jul 2022 10:51:12 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8A1391E80C90;
        Mon,  4 Jul 2022 10:51:12 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] keys/keyctl: Fix typo in string
Date:   Mon,  4 Jul 2022 10:52:48 +0800
Message-Id: <20220704025248.3695-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 security/keys/keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 96a92a645216..2be09642dd13 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1175,7 +1175,7 @@ static long keyctl_instantiate_key_common(key_serial_t id,
 	void *payload;
 	long ret;
 
-	kenter("%d,,%zu,%d", id, plen, ringid);
+	kenter("%d,%zu,%d", id, plen, ringid);
 
 	if (!plen)
 		from = NULL;
-- 
2.18.2

