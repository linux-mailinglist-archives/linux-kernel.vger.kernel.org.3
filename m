Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013A6559AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiFXNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiFXNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:55:12 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C246152
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:55:08 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DwBAA6wbViffxkzoFagliEfJQQAQEBBoxvA4cciieCB?=
 =?us-ascii?q?wEBAQEBAQEBAQlCBAEBPQECig8nNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhXWGQwYnCwFGEFFXGYJ4AgEBgmYBAzCsfTKBAYZZAYE/g?=
 =?us-ascii?q?WWBPYlXhR+BQIEQgRUzgzWFEYVuBJlHCgMJBAcFRhcSTjEhAkULHAEIBgYHA?=
 =?us-ascii?q?QgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOBwEBD?=
 =?us-ascii?q?A8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCAgEDD?=
 =?us-ascii?q?wEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx0ICwoDDgMEAwEQAhgHAgEVA?=
 =?us-ascii?q?QUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIAxYHA?=
 =?us-ascii?q?QIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdDQgEC?=
 =?us-ascii?q?AQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECARYCE?=
 =?us-ascii?q?AgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDhUnHikFBxESGw8EDQ0KN?=
 =?us-ascii?q?CAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGHAECAyUCEgYOBQEiH?=
 =?us-ascii?q?RmbD4EOgUTCZQeDURABoDWWYgKSAJZwom6ETjWBMws3gUxNI4M4URkPnHJzO?=
 =?us-ascii?q?wIGCwEBAwmPAQEB?=
IronPort-Data: A9a23:KrJBhqKNiM92xgSkFE+RWpUlxSXFcZb7ZxGr2PjKsXjdYENS1zwCm
 GIYDDvUaP7eMGahc9FyOtng/UhVvMOGy95lHVAd+CA2RRqmi+KcWIvDfhmsV8+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vrav67xZVF/fngqoDUUIYoAQgsA14+IMsdoUg7wbRh3NQ02YLR7z6l4
 LseneWOYDdJ5BYpagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfnZw0/Df2VhNrXSq
 9AvbF2O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQR9IgCmYkf519
 OhEvsauEgEbPJeVmM1IBnG0EwkmVUFH0LrOIHzn6IqOyUyDc3btz/hqBkwsMssU946bA0kXr
 61ecmhTKEnb36TsnejTpupE36zPKOHwN4Mbt2l4wCvxFuo7TdbeRaSP5dJZ0Do0jM1UErDSa
 qL1bBI2MkmZPE0RZQ9/5JQWm7ezwSD0enpjp0uvp5gGx0LM3jVV+e24WDbSUofWG5kPxx7wS
 nj912vjDx4ZNPSbyDyY4nyrm+nDlD/6X4RUE6e3ntZugVuO1ikIFBQZVF20if24kVKlHdZeL
 VEEvCYjs8Aa+hewRdm7UBykiHmZohobXNkWGOo/gCmJy6zJ80OaC3ICQzppdtMrrok1SCYs2
 1vPmMnmbQGDq5WQQHOZru7SsDWzfCgYLGMPYSUJVwRD79SLTJwPYgznFsloDL+7oNnJJDj7m
 S7Rqho8vewTpJtev0mkxmzvjzWpr5nPawc64ATLQ26ohj+Vgqb4OOREDnCGvJ59wJalokqp4
 ClYwpDBhAwaJcHTxHTUKAkYNOzxv5643CvgbUlHM7RJG96F23OicY1U6jxkKy+F2e5aKGazO
 Cc/VSt77ZNeOj6Vxnttf568Ds4n16eIKDgIfvXdb94WO95scg7C/CxvaUOU1W33nw4gnMnT2
 Kt3k+7yXR726ow+klJaotvxN5dwmkjSIkuPHPjGI+yPi+b2WZJsYe5t3KGyRu449riYhw7e7
 sxSMcCHoz0GDrCgOnGGqdRCdQtRRZTeOXwQg5INHgJkClQ4cFzN99eOmdvNhqQ/x/UIyL6Wl
 p1DchYAlASj7ZE4Fel6Qis/Nu+1BM4XQYMTNyEoIkulk2UlYJii9rwea4p/e7Q76+t5zpZJo
 wotJK297gB0YmqcoVw1M8KixLGOgTzx2GpiyQL5O2VlF3OhLiSVkuLZkvzHrnhQV3Tr6ppl/
 dVNFGrzGPI+euirN+6OANrH8r97lSF1dD5aN6cQHuRuRQ==
IronPort-HdrOrdr: A9a23:QRT4sKGk2ddMwRW3pLqE0ceALOsnbusQ8zAXPiFKOGVom6mj/f
 xG885rsCMc5AxhOk3I3OrwW5VoIkm8yXcW2/h0AV7KZmCP01dAbrsD0WKI+UyGJ8SRzJ866U
 6iScRD4R/LYGSSQfyU3OBwKbgd/OU=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2022 15:55:02 +0200
Received: from localhost (ip2505f6aa.dynamic.kabel-deutschland.de [37.5.246.170])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 4005830011A5C;
        Fri, 24 Jun 2022 15:55:02 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v5 2/3] Staging: rtl8192e: Using kzalloc and delete memset
Date:   Fri, 24 Jun 2022 15:54:54 +0200
Message-Id: <9727fe31c675f2f3052ca2fa586d137dd856ac91.1656078068.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656078068.git.f3sch.git@outlook.com>
References: <cover.1656078068.git.f3sch.git@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using kzalloc, we can delete a memset.  The practical difference
is that using kzalloc() will zero out the txb->fragments[] array.
The original code worked fine, but zeroing everything seems nicer.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index f2ef32e943ae..1307cf55741a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,11 +205,10 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
+	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-	memset(txb, 0, sizeof(struct rtllib_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = cpu_to_le16(txb_size);
 
-- 
2.36.1

