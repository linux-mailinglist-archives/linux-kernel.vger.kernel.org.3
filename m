Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124655D8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbiF1IbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbiF1IbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:12 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87FC2655A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:10 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BdBQCEu7piffxkzoFagliDJYFXlBABAQEGjHGHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQFAig8nNQgOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhWgNhkMGJwsBRhBRVxmCeAIBAQKCZAEDMK4uMoEBhloBg?=
 =?us-ascii?q?T+BZYE9iVmFH4FAgRCBSIM1hRGFbgSaBgoDCQQHBUYXEk4xIQJFCxwBCAYGB?=
 =?us-ascii?q?wEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFMg0CDgcBA?=
 =?us-ascii?q?QwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFAgIBA?=
 =?us-ascii?q?w8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMfCAsKAw4DBAMBEAIYBwIBF?=
 =?us-ascii?q?QEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDBQECCAMWB?=
 =?us-ascii?q?wECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICPy8RHQ0IB?=
 =?us-ascii?q?AgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICAwEBAgEWA?=
 =?us-ascii?q?hAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAwwVKR4pBQcREhsPBA0NC?=
 =?us-ascii?q?jQgFiQBAQ4FAwESGREOBxQKUyYhFRAGASsWAwQBAwMCBhoBAgMiAhILCRUCB?=
 =?us-ascii?q?C0FASIdGZtKgQ5MgV2WIKthB4NREAGLEJUmhUWRHQKSAJFAhTCicYRPNYEtA?=
 =?us-ascii?q?UeBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCY8BAQE?=
IronPort-Data: A9a23:84IfO6ud/KY9oxoh2E4ZE1NpXufnVMxeMUV32f8akzHdYApBsoF/q
 tZmKWuHMv2IZmWhKotwO4/k/EoGuZHRytNlSAJk+S5gEn5GgMeUXt7xwmXYZn7NdJ2dECqLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVcMpBwJ1FQywYbVvqYy2YLjW13X6
 YuryyHiEAbNNwBcYzp8B52r9UsHUMTa4Fv0aXRnOJinFHeH/5UkJMp3yZOZdhMUcaEMdgKOf
 Nsv+Znilo/vE7fBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPh0z
 OpP75WbVjwEL7bGo+UkDAdlA3pXaPguFL/veRBTsOSWxkzCKyKq3vNvSUE7PIEV/ux6G24I+
 fFwxDIlN0rSwbjunvTiErEq3Jl5RCXoFNp3VnVI1jrZCfs+WZ3Za77W+NMewTExw8BDHPrTY
 8AUczUpYBmojxhnYwpIUsxmxr/y7pX5Wz5T706Hrpoo2liN1BJ296rxM/TEYPXfEK25mW7D+
 jyapT2hav0AD/SAyyGC7nuEierGnCe9U4UXfJW37PNlg127wm0VFQ0YUka9rfCli0m4HdVFJ
 CQ8/isosLh371CiQdj7UDW8oWWYpVgYWtxNA6s25R/l4qSP+A2ZQGcFUhZGdcAis8g1Azct0
 zehm9LvGCwqs7CPT3+Z3qmboCn0OiUPK2IGIygeQmM4D8LLpYgyikqWCMtlEeu1g9z5FDX6z
 iqF6iQz71kOsSIV/6C/wlKdihmznbXYVQQO5zyIQF+1tSosMeZJeLeUwVTc6P9BKqOQQV+Ao
 GUIlqCiAAYmU8jleMulHbVlIV252xqWGGGN3Qc3QPHN4xz9pS77JOi89RkjfB8BDyoSRdP+S
 GP+0e+7zL9ePXenaaV6eY3Z5y8Ck/m5T4yNuhz8RNNCb540S6RT5j1yaEua0nri+HXAfIk6M
 JafKZ/qEHAbTKRqzTa7Q+0Qy7Btyi1WKYLvqXLTkUTPPVm2PSD9pVI53L2mMr9RAESs+1S9z
 jqnH5HWoyizqcWnCsUtzaYdLEoRMV8wDo3spspce4are1Q7Rjp8V6GLn+16IuSJepi5cM+Wr
 xlRvWcGlDLCaYHvd1Tiho1LMuu+AMgm8xrXwwR8Zgb4s5TcXWpfxPxDKcdtJOFPGB1Lx/NwU
 OQIM9iGA+pCUC/G5yVVa5Ths4t4d3yWafGmYEKYjMwEV8A7HWThpIS7FjYDAQFUU0JbQ+Ni+
 OD6vu4aKLJfLzlf4DH+MqLzkgzp7ChGw4qfnSLge7FuRakly6AyQwSZsxP9C5tkxcnrrtdC6
 zurPA==
IronPort-HdrOrdr: A9a23:e0E6zKFOTps/Wl+npLqE/8eALOsnbusQ8zAXPidKKSC9E/b4qy
 nKpp9w6faaskdyZJheo6HkBEDtex7hHP1Oj7X5X43SPzUO0VHARL2KhrGM/9SPIUHDH+dmpM
 NdT5Q=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:10 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 2761B300084F1;
        Tue, 28 Jun 2022 10:31:10 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 4/7] Staging: rtl8192e: Remove unnecessary parentheses
Date:   Tue, 28 Jun 2022 10:30:53 +0200
Message-Id: <6d0910b89d7d93d9940ebb231097babd8ff31a15.1656402464.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656402464.git.f3sch.git@outlook.com>
References: <cover.1656402464.git.f3sch.git@outlook.com>
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

This addresses an issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     Unnecessary parentheses around wrqu->encoding

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index c8fc66113b41..f1a497ff4aa6 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -288,7 +288,7 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *keybuf)
 {
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	struct net_device *dev = ieee->dev;
 	struct rtllib_security sec = {
 		.flags = 0
@@ -460,7 +460,7 @@ int rtllib_wx_get_encode(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *keybuf)
 {
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	int len, key;
 	struct lib80211_crypt_data *crypt;
 
-- 
2.36.1

