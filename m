Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8E56192D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiF3Lap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiF3Lac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:32 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566A51B28
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:30 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2CyBQALiL1iffxkzoFagliDJYFXlBABAQEGjHKHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQFAihEnNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhWgNhkMGJwsBRhBRVxmCeAIBAQKCZAEDMK1UMoEBhloBg?=
 =?us-ascii?q?T+BZYE9iVqFIIFAgRCBFTODNYQLgQaFbgSaPgoDCQQHBUYXEk4xIQJFCxwBC?=
 =?us-ascii?q?AYGBwEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFMg0CD?=
 =?us-ascii?q?gcBAQwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFA?=
 =?us-ascii?q?gIBAw8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMdCAsKAw4DBAMBEAIYB?=
 =?us-ascii?q?wIBFQEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDBQECC?=
 =?us-ascii?q?AMWBwECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICPy8RH?=
 =?us-ascii?q?Q0IBAgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICAwEBA?=
 =?us-ascii?q?gEWAhAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAwwVJx4pBQcREhsPB?=
 =?us-ascii?q?A0NCjQgFiQBAQ4FAwESGREOBxQKUyYhFRAGASsWAwQBAwMCBhoBAgMiAhILC?=
 =?us-ascii?q?RUCBCYICQMWBi0FASIdGZwMAYENTpd7q2YHg1EQAYsQlSaFRZEdApIAlnOid?=
 =?us-ascii?q?IRPNYEsSYFMTSODOAlIGQ+XVIUeczsCBgsBAQMJjD2CSAEB?=
IronPort-Data: A9a23:HLPP8qi1Z4U8BnuyiKDwgLPqX161+hAKZh0ujC45NGQN5FlHY01je
 htvCDyCb//eNjTxedkiPI7k8UlQsJbQmtFjTQBr+3hjFC5jpJueD7x1DG+pYnzIfpOfJK5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHWeIcw98z0M58wIFqtQw24LhXVjV4
 YmaT/D3YTdJ5RYlagr41Ire8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatE88tqBe
 gr25OrRElU1X/saIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt/Qv4
 dFJvKWSdT0gDIDrkqcvVAF+PAgraMWq+JefSZS+mcmazkmeKj3xxfQrDEw3MYAc8OttDidC+
 JT0KhhUNEHF3brohuvjEq82255LwMrDZevzvll7xjHdAO4+TIrrWLnX6ZlF2jZ1hs1PEfvab
 ccDZnxjYXwsZjUWZwhJUsNjzbjAan/XUjhnolWIvukL0mXf5i1L7onnLID3Q4nfLSlSth3E+
 D6cpjyR7gshHMOd0j2Z+1qjg+bOmWXwX4d6PLKi+/FpgHWXx2oOGBMRSF23qOW4jUj4XMhQQ
 2QQ+ywzve0p6EWkT9/ydxm5u2Kf+BodXcdAVeE39mmlxPHP6AbfCWkYZjlcdNghs8xwTjsvv
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJTbp+PHmqYA31kuJU9BiVa64j9H4HTv92
 T/MoCVWa6gvYdAj8/uS+VTOuhCQnJH7Yyk/pTfQRkSKx1YsDGK6XLCA5V/e5PdGCY+WSFido
 XQJ8/RyCshTV/lhcwTQEI0w8KGVC+WtbGyA2AYwd3U132Tzqyb6FWxFyGwmfC9U3tA4lSjBT
 GK7Vel5xJJSMHauZ6JtbOpd4Ox0nPG6TbwJutj+Z9ZDZN1O39ud4D1jYESdxW+FraTBuaQ2O
 JPDKICxC3dfCalmwDeyTeoH3vkny0jSJF8/p7ilkHxLMpLHOhZ5rIvp1nPVMYjVC4vY+G3oH
 y53bZfi9vmmeLSWjtPr2YASN0sWCnMwGIr7rcdaHsbafFc4RTt+V6SKmOp+E2CAo0izvrmQl
 p1achEEoGcTeVWZeG1ml1g5MOKyA88hxZ7FFX1xZAfAN4cfjXaHt/tBK8FuJdHLBcRpwPprU
 vRNZsOBHPlVUTXb6nwbYIXiq5ZhHClHdirRVxdJlAMXIcU6LySXoYCMQ+ca3HNTZsZBnZdl/
 ufIO8KyacZrejmO++6PMarylAPp4iNH8A+wNmORSuRulIzX2NACA0TMYjUfeang9T2rKuOm6
 jur
IronPort-HdrOrdr: A9a23:H2L/saFUJeQZFhsgpLqE0ceALOsnbusQ8zAXPidKOHtom62j5q
 STdZEgvnXJYVkqNU3I5urwXpVoLUmyyXcN2/hyAV7AZniChILLFuFfBOLZqlXd8kvFmNK1vp
 0AT0ERMrHN5CBB/KXHCQCDYq8d/OU=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:30:30 +0200
Received: from localhost (dhcp567-177.laptop-wlc.uni-heidelberg.de [147.142.67.177])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id D8565300084F1;
        Thu, 30 Jun 2022 13:30:29 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v2 6/6] Staging: rtl8192e: Added spaces around '+'
Date:   Thu, 30 Jun 2022 13:30:19 +0200
Message-Id: <9b673fce3e6200a9fc0d21ec5a493d59cfe12241.1656587827.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656587827.git.f3sch.git@outlook.com>
References: <cover.1656587827.git.f3sch.git@outlook.com>
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

This addresses two issues raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 778b6b7e0939..1bb94a1fe868 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -767,7 +767,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
 	kfree(ieee->wps_ie);
 	ieee->wps_ie = NULL;
 	if (len) {
-		if (len != ie[1]+2)
+		if (len != ie[1] + 2)
 			return -EINVAL;
 		buf = kmemdup(ie, len, GFP_KERNEL);
 		if (!buf)
-- 
2.36.1

