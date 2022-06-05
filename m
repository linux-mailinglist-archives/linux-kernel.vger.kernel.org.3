Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41753DAB7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350812AbiFEHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiFEHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:33:08 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730F289AB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:33:06 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id xkkpnsBMh0JImxkkpnSyhV; Sun, 05 Jun 2022 09:33:03 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 05 Jun 2022 09:33:03 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: x86/camellia - Replace kernel.h with the necessary inclusions
Date:   Sun,  5 Jun 2022 09:32:53 +0200
Message-Id: <65634fb748cc0ce2cc5bafaf904cb5f76bd4edc4.1654414362.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/x86/crypto/camellia.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/crypto/camellia.h b/arch/x86/crypto/camellia.h
index 1dcea79e8f8e..547fb7e30928 100644
--- a/arch/x86/crypto/camellia.h
+++ b/arch/x86/crypto/camellia.h
@@ -4,7 +4,7 @@
 
 #include <crypto/b128ops.h>
 #include <linux/crypto.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #define CAMELLIA_MIN_KEY_SIZE	16
 #define CAMELLIA_MAX_KEY_SIZE	32
-- 
2.34.1

