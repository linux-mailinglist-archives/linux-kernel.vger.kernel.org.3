Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455524E1F28
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbiCUC4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbiCUC4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:56:50 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE0558E6C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:55:25 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 21 Mar
 2022 10:55:17 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 21 Mar
 2022 10:55:16 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>, <straube.linux@gmail.com>,
        <linux@roeck-us.net>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] staging: r8188eu: Fix misspelling in comment
Date:   Mon, 21 Mar 2022 10:55:14 +0800
Message-ID: <1647831314-25511-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original error is as below shows:

CHECK: 'associcated' may be misspelled - perhaps 'associated'?

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1675e2e..e02dd8e 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -819,7 +819,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 
 void associated_clients_update(struct adapter *padapter, u8 updated)
 {
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 	if (updated) {
 		struct list_head *phead, *plist;
 		struct sta_info *psta = NULL;
@@ -972,7 +972,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
 	}
 
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
 
 	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
@@ -1036,7 +1036,7 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
 	}
 
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 
 	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
 
-- 
2.7.4

