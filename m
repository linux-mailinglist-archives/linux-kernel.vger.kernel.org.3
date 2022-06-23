Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9314C558A09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiFWU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFWU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:29:19 -0400
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 13:29:18 PDT
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6753A7E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:29:17 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2CxBgBfzLRiffxkzoFaHgEBCxIMggQLhHyUDwEBAQaMb?=
 =?us-ascii?q?QOHHIonggcBAQEBAQEBAQEJQgQBAT0BAooPJzYHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEGAQEBAQEHBBQBASM8J4V1hkMGJwsBRhBRVxmCeAIBAYJmAQMwrT4yg?=
 =?us-ascii?q?QGGWQGBP4FlgT2JVoUfgUCBEIEVM4M1hRGFbgSZQwoDCQQHBUYXEk4xIQJFC?=
 =?us-ascii?q?xwBCAYGBwEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFM?=
 =?us-ascii?q?g0CDgcBAQwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCA?=
 =?us-ascii?q?QIFAgIBAw8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMdCAsKAw4DBAMBE?=
 =?us-ascii?q?AIYBwIBFQEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDB?=
 =?us-ascii?q?QECCAMWBwECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICP?=
 =?us-ascii?q?y8RHQ0IBAgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICA?=
 =?us-ascii?q?wEBAgEWAhAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAw4VJx4pBQcRE?=
 =?us-ascii?q?hsPBA0NCjQgFiQBAQ4FAwESGREOBxQKUyYiFRAGASsYAwQBAwMCBh4BAgMlA?=
 =?us-ascii?q?hkFASIdGZpqIHsTgUSTeK5uB4NREAGgNJZiApIAlnCibYRONYEzCDqBTE0jg?=
 =?us-ascii?q?zhRGQ+ccnM7AgYLAQEDCY8BAQE?=
IronPort-Data: A9a23:/59NrK0LEDsXVMtbC/bD5Vpxkn2cJEfYwER7XKvMYLTBsI5bp2QEz
 2MWDGiGbv2CZWv0c49yYYrn9UkA68PVx99rQVZl3Hw8FHgiRejtXInGdBeuY0t+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILas1htZGEk1Ek/NtTo5w7Rj2tAy2oDja++wk
 YqaT/P3aQfNNwFcbzp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonpR5fMebS4K8bhL
 wr1IBFVyUuCl/slIovNfr8W6STmSJaKVeSFoiI+t6RPHnGuqwRqupvXOsbwZm9Lmgib2PdMw
 +xRkq6bQCcVDInRv+A0Bkww/yFWZcWq+ZfCKHm76ZXV0kvHNnvhwvljCEs7J4Je9usf7WNmr
 KZJbmpVMFba37rwmu/hIgVvrp1LwM3DJ4gfvnx41TzDJe06XJyFXqPLoN9V3Ts9gspDB/mYa
 8dxhT9HNUmeM0YRYAlNYH44tOj4nmHcUAZakliymLI5/UTh/RAy+be4ZbI5ffTRGZsJxB/Az
 o7cxEz2GBwVN9y3zTuD72KigfLJkSrnWYUUUrqi+ZZChFyV23xWEwEfWlq9rtG9i1WiQJRbK
 koJ6mwioLZa3ELwVdL9GRK5vFaDowIYXN1TVeY97WmlzqvS/hbcBWUeSDNFQMIpudVwRjEw0
 FKN2dTzClRSXKa9THuc8u/N6y60OG0VIG4OaCsOQBEKpdXuyG0usv7RZspyLbzyqeD+IC3X8
 RuDjBQMo6g0iedegs1X4mv7qz6ro5HISCs86QPWQn+p42tFiGiNOtPABb/zsKcoEWqJcrWSl
 CRVx5HGs4jiGbndynzVGY3hCZn0v67tDdHKvbJ4N7UMn9hH016ufIxd5DtzPkgB3i0sJ26wO
 he7Ve95zpZfMX3vUgSjeZ6tBsEgwLLvfekJu9jRZ9tKOsE3aQmGuSFjZEKd22rgikdqnaxX1
 XannSSEUyZy5UdPlWTeqwIhPVkDnXxWKYT7GcmT8vhf+eDCDEN5sJ9cWLd0Usg37bmfvCLe+
 MtFOs2Bxn13CbOjPHGPoNZJfAhRdhDX4KwaTeQJLIZvxSI4Rgkc5wP5nutJl3FNxfwEy7mRo
 BlRpGcBkAah2RUr1jlmmlg4NO2zB88nxZ7KFSYhOUm11jA+Z4ex4b0EdocmNb8q6PNk1/0cc
 hX2U5roPxi7cRyZoG51Rcem8+RfmOGD31/m09yNPGNiJfaNhmXhprfZQ+cY3HhRX3vv6JVmy
 1BivyuCKac+q81ZJJ6+QJqSI5mZ5xDxRMoas5P0H+Ru
IronPort-HdrOrdr: A9a23:o7K7RaO1PIHICsBcTsyjsMiBIKoaSvp037BL7TEXdfUxSKalfq
 +V7ZcmPHPP6Ar5O0tApTnjAtjjfZq0z/ccirX5Vo3SOTUO1lHYSL2KLrGP/9QjIUDDHyJmup
 uIupIRNOHN
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 22:28:02 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id E92D7300719FC;
        Thu, 23 Jun 2022 22:28:02 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
Date:   Thu, 23 Jun 2022 22:27:55 +0200
Message-Id: <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655975970.git.f3sch.git@outlook.com>
References: <cover.1655975970.git.f3sch.git@outlook.com>
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

