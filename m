Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38155E377
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbiF1IbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiF1IbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:10 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE926540
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:08 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DBBQCEu7piffxkzoFagliDJYFXlBABAQEGjHGHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQFAig8nNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhWgNhkMGJwsBRhBRVxmCeAIBAQKCZAEDMK4uMoEBhloBg?=
 =?us-ascii?q?T+BZYE9iVmFH4FAgRCBSIM1hAuBBoVuBJoGCgMJBAcFRhcSTjEhAkULHAEIB?=
 =?us-ascii?q?gYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOB?=
 =?us-ascii?q?wEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCA?=
 =?us-ascii?q?gEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx8ICwoDDgMEAwEQAhgHA?=
 =?us-ascii?q?gEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIA?=
 =?us-ascii?q?xYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdD?=
 =?us-ascii?q?QgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECA?=
 =?us-ascii?q?RYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUpHikFBxESGw8ED?=
 =?us-ascii?q?Q0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGGgECAyICEgsJF?=
 =?us-ascii?q?QIELQUBIh0Zm0oBgQ1Ol3uLDqBTB4NREAGLEJUmhUWRHQKSAJZwonGETzWBM?=
 =?us-ascii?q?wJAgUxNI4M4CUgZD5dUhR5zOwIGCwEBAwmMOYJIAQE?=
IronPort-Data: A9a23:Q+yrlaxjgot6gQYK1mh6t+etxirEfRIJ4+MujC+fZmUNrF6WrkVTz
 GYfCmmFb//fZjahf493O4mw80lUupTWzIM3SgBrqlhgHilAwSbnLY3EcR2gYX/6wu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsacUsxKbVIiGX1JZS5LwbZj2NY224jhWmthh
 PuryyHhEA79s9JLGj9Mg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdxMUdrJp8tuSH
 I4v+l0ZElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSiEais4G2PQghUh/qjzKh/NLj
 993jZmzThYVE5TctdpDTEwNe81+FfUuFL7vJHG+tZTKiVDAcj7szvRiAUU8MJcXvOp6aY1M3
 aVCeXZXNk7F3rruhujmEIGAhex6RCXvFJgUunVt1SnUF949XY3PBbjM5JpY0TY8i8REEOzRI
 cYUAdZqRE2ePkAWZg5KU/rSms+jl1TjTAF6kmu/rKMG+XX09B12jODUZY+9ltuiHpkLwhzB/
 goq5V/RHRMBM8CW4TWA+3OowOTImEvTV5gfG7643vprhkCDyGsODhEfSVq8p7++kEHWc9ZeL
 VEEvzEypKcz8kODStjmQwb+pH+Cow5aV9dOe8U0sxqGyuzb4hqxAXUYSjlGa5ots8pebTgr0
 EKZ2tDkHzpitJWLRn+HsLSZtzW/PW4SN2BqWMMfZQ4M4t27+ccuiBOKTttiHKOxhNDvFnf8z
 lhmsRTSmZ0yhI0T9J/892r/hjGrt6Tkdx4Y2FvICzfNAhxCWKapYImh6F7+5PlGLZqEQlTpg
 JTis5bHhAzpJczd/BFhUNnhD5n1tqrcaGK0bUpHT8dxr23FF2uLINgIiAySMnuFJe4oVFcFi
 mfztAJd6ZtZMWGlBUOcS9zgUp5ypUQMPf7sWv3SK+XltoJtaAKC9ix0aiatM43FlUEtlflmf
 4qdcIOsAHcWBKBtwSC5AesQuVPK+szc7T2DLXwY5035uVZ7WJJzYetaWLdpRrtohJ5oWC2Pr
 75i2zKikn2zqtHWbCjN6pI0JlsXN3U9Dp2eg5UJK7DYf1Y4Qj9/UKa5LVYdl2pNwfU9egDgo
 C3VZ6Ok4ASu7ZE6AV/SOy09Me2HsWhX/SlrbUTAwmpEK1B4Pdjztv5HH3fGVbMq8PN+wLZpS
 fgbdt+bA+heAjLK5ysad5qVkWCRXEvDuO56BAL7O2JXV8A7GGT0FirMJFaHGN8mUnHq76PTY
 tSIimvmfHb0b14yUJuJMKP/lAjZULp0sLsaYnYk6+J7IC3EmLWG4QSr5hPrC6ng8Sn++wY=
IronPort-HdrOrdr: A9a23:z/KNfq8m18YpnA8M7zVuk+DPI+orL9Y04lQ7vn2ZLiY0TiX4ra
 GTdZEgvnXJYVkqKRMdcK+7Scy9qB/nmKKdgrN+AV7BZniEhILAFugL0WKI+VLd8kPFmtK13J
 0QF5RDNA==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:08 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id D7C19300084F1;
        Tue, 28 Jun 2022 10:31:06 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 2/7] Staging: rtl8192e: Added spaces around binary operators
Date:   Tue, 28 Jun 2022 10:30:51 +0200
Message-Id: <627de456888fe0b665a04078081abc0418f4aba0.1656402464.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656402464.git.f3sch.git@outlook.com>
References: <cover.1656402464.git.f3sch.git@outlook.com>
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

This addresses two issues raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: spaces preferred around that '&' (ctx:VxV)
     CHECK: spaces preferred around that '<<' (ctx:VxV)

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 3b81a3395527..7bd1e829ff7e 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -74,7 +74,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
-		if (network->mode&(1<<i)) {
+		if (network->mode & (1 << i)) {
 			sprintf(pname, rtllib_modes[i].mode_string,
 				rtllib_modes[i].mode_size);
 			pname += rtllib_modes[i].mode_size;
-- 
2.36.1

