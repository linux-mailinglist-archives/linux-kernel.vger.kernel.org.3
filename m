Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA038559AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiFXNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiFXNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:55:07 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297946152
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:55:04 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DwBAA6wbViffxkzoFaHgEBCxIMggQLhHyUEAEBAQaMb?=
 =?us-ascii?q?wOHHIonggcBAQEBAQEBAQEJQgQBAT0BAooPJzYHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEGAQEBAQEHBBQBASM8J4V1hkMGJwsBRhBRVxmCeAIBAYJmAQMwrH0yg?=
 =?us-ascii?q?QGGWQGBP4FlgT2JV4UfgUCBEIEVM4M1hRGFbgSZRwoDCQQHBUYXEk4xIQJFC?=
 =?us-ascii?q?xwBCAYGBwEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFM?=
 =?us-ascii?q?g0CDgcBAQwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCA?=
 =?us-ascii?q?QIFAgIBAw8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMdCAsKAw4DBAMBE?=
 =?us-ascii?q?AIYBwIBFQEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDB?=
 =?us-ascii?q?QECCAMWBwECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICP?=
 =?us-ascii?q?y8RHQ0IBAgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICA?=
 =?us-ascii?q?wEBAgEWAhAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAw4VJx4pBQcRE?=
 =?us-ascii?q?hsPBA0NCjQgFiQBAQ4FAwESGREOBxQKUyYhFRAGASsWAwQBAwMCBhwBAgMlA?=
 =?us-ascii?q?hIGDgUBIh0Zmm8gexOBRJN4rm0Hg1EQAaA1lmICkgCWcKJuhE41gTMIOoFMT?=
 =?us-ascii?q?SODOFEZD5xyczsCBgsBAQMJjwEBAQ?=
IronPort-Data: A9a23:UZY6FK6sPbwuOpiRlBCorAxRtKXHchMFZxGqfqrLsTDasY5as4F+v
 jMWXWrTa/yMM2D9ftl+Ydu19ElT65bQyIdkGVE/rSw0Zn8b8sCt6faxdxqvZXPMcqUvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EngZqTRMFWFw03qPp8Zj2tQy2YbjX1vX0
 T/Pi5S31GGNimYc3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOgKmVgJdNWc
 s6YpF2PEsM1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2tgdRu1
 edWlKCIcl80GaTwxMsHEBhHRnQW0a1uoNcrIFC6uM2XlxSAbn3thvVjDU07OYcV4OkxDWwmG
 f4wcWpcKErb2aTvmOr9ELQ27iggBJCD0Ic3oXpgyTzBFfs8aYvfXqmM+NlZmTc9h8xDGfzTf
 cVfZTcHgBHoOkARaw1IUs5v9AuuriPSSjZKpwqKn61t30rf6xND7YbfH/OAL7RmQu0OwhjE/
 Duel4jjOTkVLtGQyjqt9nOqm//Bmj79VIsOFbq+sPlwjzW7wm0VFQ1TTkeyrvi/hWa6WslDM
 AoQ+ywzve4++VLDZtemRBa45nGFojYbRsZUFOo5rgqKz8L85wefG3hBTTNbbtEinNE5SCZs1
 VKTmd7tQzt1v9WopWm1876VqWvrfzUTLCoCaC4IQA8P7sPs5o0+5v7Scjp9OIqrisLoKyrR/
 wix9DUZjolPotRI1rruqDgrnAmQjpTOSwc04CDeUWSk8h51aeaZi2qAtAezARFocdfxc7WRg
 JQXs5TPsLlWUvlhgATdHrVVRdlF8t7YaGW0vLJ5I3U23xiAk5JJVaBd4T1zIE1kKMlsldTBP
 h6K41s5CHN7FnKmYKkyXCllEdg2wK3qGM7qPs04g/JLa5l1LFbB4SdvIE6d3mzglEIhi655N
 ZrznSeQ4ZQyV/QPINmeHrl1PVoXKsYWnj+7qXfTk03P7FZmTCTJIYrpymemYOEj97+jqw7I6
 dtZPMbi40wBDbOmOniPq99LdgtiwZ0H6Xbe9ZY/mgmrfFQOJY3dI6CJqV/cU9Y9zvkLz7mgE
 o+VAxcElgaXaYL7xfWiMSw9NOm2Bf6TXFoxMCgzIFvgxn4if4u196YDZtMxcKU48/ZgpcOYv
 NFaE/hs9s9nFG+dkxxDNsaVkWCXXE727SqUITGfaSQyF7Y4AVOUkjMSVle0qXNm4+venZdWn
 oBMISuBEMRaGVg9XZ2IAB9tpnvo1UUgdCtJdxOgCrFulI/EquCG9wSZYicLHvwx
IronPort-HdrOrdr: A9a23:+S/gpqkzBCbdZSkcJUV8eFEVXGfpDfIV3DAbv31ZSRFFG/Fw9v
 re5cjzsCWftN9/YgBEpTntAtjjfZqYz+8X3WBzB9aftWvdyQ+VxehZhOOI/9SjIU3DH4VmpM
 BdmsZFebvN5JtB4foSIjPULz/t+ra6GWmT69vj8w==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2022 15:55:04 +0200
Received: from localhost (ip2505f6aa.dynamic.kabel-deutschland.de [37.5.246.170])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id D408330011A56;
        Fri, 24 Jun 2022 15:55:03 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v5 3/3] Staging: rtl8192e: Cleaning up error handling
Date:   Fri, 24 Jun 2022 15:54:55 +0200
Message-Id: <13b32131cd00a1f0b8793657a24ada71240a8350.1656078068.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656078068.git.f3sch.git@outlook.com>
References: <cover.1656078068.git.f3sch.git@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved error handling to one common block.
This removes double checking if all txb->fragments[]
were initialized.
The original code worked fine, but this is cleaner.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1307cf55741a..42f81b23a144 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -214,19 +214,19 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 
 	for (i = 0; i < nr_frags; i++) {
 		txb->fragments[i] = dev_alloc_skb(txb_size);
-		if (unlikely(!txb->fragments[i])) {
-			i--;
-			break;
-		}
+		if (unlikely(!txb->fragments[i]))
+			goto err_free;
 		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
 	}
-	if (unlikely(i != nr_frags)) {
-		while (i >= 0)
-			dev_kfree_skb_any(txb->fragments[i--]);
-		kfree(txb);
-		return NULL;
-	}
+
 	return txb;
+
+err_free:
+	while (--i >= 0)
+		dev_kfree_skb_any(txb->fragments[i]);
+	kfree(txb);
+
+	return NULL;
 }
 
 static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
-- 
2.36.1

