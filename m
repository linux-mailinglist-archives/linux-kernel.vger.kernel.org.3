Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4AD558A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiFWU3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:29:19 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4617D54BC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:29:18 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2CyBgCJzLRiffxkzoFagliEfJQPAQEBBoxtA4cciieCB?=
 =?us-ascii?q?wEBAQEBAQEBAQlCBAEBPQECig8nNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhXWGQwYnCwFGEFFXGYJ4AgEBgmYBAzCtPjKBAYZZAYE/g?=
 =?us-ascii?q?WWBPYlWhR+BQIEQgRUzgzWFEYVuBJlDCgMJBAcFRhcSTjEhAkULHAEIBgYHA?=
 =?us-ascii?q?QgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOBwEBD?=
 =?us-ascii?q?A8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCAgEDD?=
 =?us-ascii?q?wEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx0ICwoDDgMEAwEQAhgHAgEVA?=
 =?us-ascii?q?QUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIAxYHA?=
 =?us-ascii?q?QIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdDQgEC?=
 =?us-ascii?q?AQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECARYCE?=
 =?us-ascii?q?AgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDhUnHikFBxESGw8EDQ0KN?=
 =?us-ascii?q?CAWJAEBDgUDARIZEQ4HFApTJiIVEAYBKxgDBAEDAwIGHgECAyUCGQUBIh0Zm?=
 =?us-ascii?q?wqBDoFEwmYHg1EQAaA0lmICkgCWcKJthE41gTMLN4FMTSODOFEZD5xyczsCB?=
 =?us-ascii?q?gsBAQMJjwEBAQ?=
IronPort-Data: A9a23:UBm1g6ivUczpmetcNeW3A4yuX1616RAKZh0ujC45NGQN5FlHY01je
 htvWTvTP6yPMWH1ctp0Pdm+ph4EuJGBn9IxGgM6/3hnQXhjpJueD7x1DG+pYnzIfpOfJK5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHWeIcw98z0M58wIFqtQw24LhXVnW4
 YmaT/D3YTdJ5RYlagr41Ire8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatE88tqBe
 gr25OrRElU1X/saIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt8h+x
 sVr6az3cyswPfyWuecUSTYBEz4raMWq+JefSZS+mcmazkmeKj3xxfQrDEw3MYAc8OttDidC+
 JT0KhhUNEHF3brohuvjEq82255LwMrDZevzvll7xjHdAO4+TIrrWLnX6ZlF2jZ1hs1PEfvab
 ccDZnxjYXwsZjUWZApPWcpuzL/Aan/XNC1zpFm1rIUL32no0RIsyv/QK+fvU4nfLSlSth3E+
 D6cpjyR7gshHNOFxDWG8lqoh+nSjS38RYQeHaG58fgsh0ecrkQXCRsLRR6gvfC2i0ixc9ZeM
 FAPvC4vq7UiskCmULHVUUajq37CsR8Ac91ND+k97wLLwa3Riy6dB24ZXntCZcYgucseWzMnz
 BmKksnvCDgpt6eaIU9x7Z+RpDK2YXFTMGkDIC8JTAcI59Puuo51gh+nostf/LCdltL7CRes8
 3ewgDE91u8yjscR+Py74gWS696znaThQgkw7wTRe2uq6AJleYKoD7BED3CGsp6sy67EHzG8U
 Gg4d9u2sLFSVMnS/MCZaLVTTOnwjxqQGGCE2TZS848dGyOF11PLkWp4wDx/KEptOMsedlcFi
 2eN6FoLvPe/0FOAZKN6ZceOoBAw0bTtEN7oTP+8UzajSp14dQvfpWdzY0/V323snEUom6wlN
 tGXfK5A7Er264w5nFJapM9Ej9fHIxzSI0uIGfgXKDz7iNKjiIa9E+ttDbd3RrlRAFm4iAvU6
 c1DEMCB1g9SVubzCgGOr9NNdQhbdSJqXcutwyCySgJlClQ8cI3GI6GPqY7Nh6Q6x8y5a8+Sp
 iDgBBYGoLYBrSSfdVvWApycVF8fdc0j8y5hZHRE0aeA0XUnfpuipLoZdoU6Z6Im6P0ry/NoU
 P4feK297gdnFVz6F8AmRcem9uRKKk/07T9iygL/PVDTibY8HFGTkjIlFyOznBQz4t2f5JRv8
 uX9iFuzrFhqb10KMfs6ocmHlzuZ1UXxUsoiN6cUCrG/oHnRzbU=
IronPort-HdrOrdr: A9a23:wAuv5Kv+9g13he4+zUqQRnNS7skDYdV00zEX/kB9WHVpmwKj+/
 xG+85rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1MmZPTUO0VHAROpfBMnZsl/d8kbFmdK1u5
 0MT0EHMr3NMWQ=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 22:28:02 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 66D69300719FC;
        Thu, 23 Jun 2022 22:28:01 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 2/3] Staging: rtl8192e: Using kzalloc and delete memset
Date:   Thu, 23 Jun 2022 22:27:54 +0200
Message-Id: <9727fe31c675f2f3052ca2fa586d137dd856ac91.1655975970.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655975970.git.f3sch.git@outlook.com>
References: <cover.1655975970.git.f3sch.git@outlook.com>
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

