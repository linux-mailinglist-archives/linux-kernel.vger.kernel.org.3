Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10826562FF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiGAJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiGAJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:08 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2573907
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:06 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2CGBABPvL5iffxkzoFagliDJYFXlBADBoxyhx+KJ4IHA?=
 =?us-ascii?q?QEBAQEBAQEBCS8TBAEBQIoRJzUIDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4VoDYZDBicLAUYQUVcZgngCAQECgmQBAzCuJzKBAYZaAYE/g?=
 =?us-ascii?q?WWBPYlchSCBQIEQgUiDNYQLgQaFbgSaTwoDCQQHBUYXEk4xIQJFCxwBCAYGB?=
 =?us-ascii?q?wEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFMg0CDgcBA?=
 =?us-ascii?q?QwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFAgIBA?=
 =?us-ascii?q?w8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMdCAsKAw4DBAMBEAIYBwIBF?=
 =?us-ascii?q?QEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDBQECCAMWB?=
 =?us-ascii?q?wECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICPy8RHQ0IB?=
 =?us-ascii?q?AgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICAwEBAgEWA?=
 =?us-ascii?q?hAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAwwVJx4pBQcREhsPBA0NC?=
 =?us-ascii?q?jQgFiQBAQ4FAwESGREOBxQKUyYhFRAGASsWAwQBAwMCBhoBAgMiAhALCRUCB?=
 =?us-ascii?q?CEICQMWBiILHAUBIh0ZnBgBgQ1MgV2WIKtmB4NREAGLEJUmhUWRHQKSAJFCh?=
 =?us-ascii?q?TGidIRPNYEuAkWBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCYw9gkgBAQ?=
IronPort-Data: A9a23:awLbQ6yA/5Vw8wMi/M96t+evxirEfRIJ4+MujC+fZmUNrF6WrkUOy
 WodX2mGPKzeajb2fNAlOo7i9h9VvsXXmt9qTQFlrVhgHilAwSbnLY3EcR2gYX/6wu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsacUsxKbVIiGX1JZS5LwbZj2NY32YHhWmthh
 PuryyHhEA79s9JLGj9Mg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdxMUdrJp8tuSH
 I4v+l0ZElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSiEais4G2PQghUh/lw2Nwv1Xy
 YV07d+zGQwgAquTw8AtakwNe81+FfUuFL7vJHG+tZTKiVDAcj7szvRiAUU8MJcXvOp6aY1M3
 aVCeXZXNk7F3rruhujmEIGAhex6RCXvFJgUunVt1SnUF949XY3PBbjM5JpY0TY8i8REEOzRI
 cYUAdZqRE2dPEISYA1KU/rSms+YtGvhXxZ6p2mxoKxw8jjs3SN085LUZY+9ltuiHpkLwhzB/
 goq5V/RHRMBM8CW4TWA+3OowOTImEvTV5gfG7643vprhkCDyGsODhEfSVq8p7++kEHWc9ZeL
 VEEvzEypKcz8kODStjmQwb+pH+Cow5aV9dOe8U0sxqGyuzb4hqxAXUYSjlGa5ots8pebTgr0
 EKZ2tDkHzpitJWLRn+HsLSZtzW/PW4SN2BqWMMfZQ4M4t27+ccuiBOKTttiHKOxhNDvFnf8z
 lhmsRTSmZ0PtcpW+oO6rWmfwDH8rZH1SFFuwjXuCzfNAhxCWKapYImh6F7+5PlGLZqEQlTpg
 JTis5XBhAzpJczd/BFhUNnhD5n1tqrcaGK0bUpHT8dxr23FF2uLINgIiAySMnuFJe4oVFcFi
 mfztAJd6ZtZMWGlBUOcS9zgUp5ypUQMPf7sWv3SK+XltoJtaAKC9ix0aiatM43FlUEtlflmf
 4qdcIOsAHcWBKBtwSC5AesQuVPK+szc7T2DLXwY5035uVZ7WJJzYexVWLdpRrxhhJ5oWC2Pr
 75i2zKikn2zqtHWbCjN6pI0JlsXN3U9Dp2eg5UJK7Dde1E2Qz16UKO5LVYdl2pNwf89egDgo
 CzVZ6Ok4ASu7ZE6AV/SOy09Me2HsWhX/C9iZkTAwmpEK1B4Pdjztv5HH3fGVbMq8PN+wLZpS
 fgbdt+bA+heAjLK5ysad5qVkWCRXEvDuO56BAL7O2JXV8A7GGT0FirMJFaHGN8mUnHq76PTY
 tSIimvmfHb0b1Q6U52LNqPwp75z1FBE8N9Ps4LzCoE7UC3RHEJCdUQdUtdfzxkwFCj+
IronPort-HdrOrdr: A9a23:vTioMKOLaTM5oMBcTu+jsMiBIKoaSvp037By7TEUdfUnSL3+qy
 nOpoVi6faaslYssR0b9OxofZPwJE80lqQFmrX5X43SPzUO0VHAROoJ0WKh+UyDJ8SUzIFgPN
 JbEpSWf+efMbEVt6rHCFbSKadb/DDNytHPuQ6X9QYVcejBUdAc0ztE
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:25:06 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 3A50A300719FC;
        Fri,  1 Jul 2022 11:25:06 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 5/6] Staging: rtl8192e: Remove unnecessary blank line
Date:   Fri,  1 Jul 2022 11:24:53 +0200
Message-Id: <f3c6bd5c79331e82f006fb2694f791030b07c5ba.1656667089.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656667089.git.f3sch.git@outlook.com>
References: <cover.1656667089.git.f3sch.git@outlook.com>
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
     CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index b949e7234150..6b11908032d7 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -601,7 +601,6 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 			goto done;
 		}
 		*crypt = new_crypt;
-
 	}
 
 	if (ext->key_len > 0 && (*crypt)->ops->set_key &&
-- 
2.36.1

