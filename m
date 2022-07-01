Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9F562FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiGAJ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiGAJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:09 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEAC31
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:08 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2C0AwDZvL5iffxkzoFagliDJYFXlBADBoxyhx+KJ4IHA?=
 =?us-ascii?q?QEBAQEBAQEBCS8TBAEBQIoRJzQJDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4VoDYZDBicLAUYQUVcZgngCAQECgmQBAzCuKDKBAYZaAYE/g?=
 =?us-ascii?q?WWBPYlchSCBQIEQgRUzgzWEC4EGhW4Emk8KAwkEBwVGFxJOMSECRQscAQgGB?=
 =?us-ascii?q?gcBCAEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINAg4HA?=
 =?us-ascii?q?QEMDwECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECBQICA?=
 =?us-ascii?q?QMPAQgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACGAcCA?=
 =?us-ascii?q?RUBBQIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBAggDF?=
 =?us-ascii?q?gcBAiEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vER0NC?=
 =?us-ascii?q?AQIBAkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBAQIBF?=
 =?us-ascii?q?gIQCAIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMFSceKQUHERIbDwQND?=
 =?us-ascii?q?Qo0IBYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYaAQIDIgIQCwkVA?=
 =?us-ascii?q?gQhCAkDFgYiCxwFASIdGZwYAYENTpd7q2YHg1EQAYsQlSaFRZEdApIAlnOid?=
 =?us-ascii?q?IRPNYEsSYFMTSODOAlIGQ+XVIUeczsCBgsBAQMJjD2CSAEB?=
IronPort-Data: A9a23:jgRW9awj7/0KDc1J2MF6t+evxirEfRIJ4+MujC+fZmUNrF6WrkVSm
 DQXUWqHbPiONzemLYogYdyxpk8OuMWByNcyTAJvqVhgHilAwSbnLY3EcR2gYX/6wu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsacUsxKbVIiGX1JZS5LwbZj2NY32YHhWmthh
 PuryyHhEA79s9JLGj9Mg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdxMUdrJp8tuSH
 I4v+l0ZElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSiEais4G2PQghUh/tRDOnZNhz
 9536p22TgE3ZJ/qsu8STEwNe81+FfUuFL7vJHG+tZTKiVDAcj7szvRiAUU8MJcXvOp6aY1M3
 aVCeXZXNk7F3rruhujmEIGAhex6RCXvFJgUunVt1SnUF949XY3PBbjM5JpY0TY8i8REEOzRI
 cYUAdZqRE2ePUUWYglKUfrSms+s3kTNTmV2jmi+oKs6ylne3hx2l+PyZY+9ltuiHpkLwhzB/
 goq5V/RHRMBM8CW4TWA+3OowOTImEvTV5gfG7643vprhkCDyGsODhEfSVq8p7++kEHWc9ZeL
 VEEvzEypKcz8kODStjmQwb+pH+Cow5aV9dOe8U0sxqGyuzb4hqxAXUYSjlGa5ots8pebTgr0
 EKZ2tDkHzpitJWLRn+HsLSZtzW/PW4SN2BqWMMfZQ4M4t27+ccuiBOKTttiHKOxhNDvFnf8z
 lhmsRTSmZ0tqIkJlLW89mqYgjSroIaTfCgf7QrICzfNAhxCWKapYImh6F7+5PlGLZqEQlTpg
 JTis5XBhAzpJczd/BFhUNnhD5n1tqrcaGK0bUpHT8dxr23FF2uLINgIiAySMnuFJe4oVFcFi
 mfztAJd6ZtZMWGlBUOcS9zgUp5ypUQMPf7sWv3SK+XltoJtaAKC9ix0aiatM43FlUEtlflmf
 4qdcIOsAHcWBKBtwSC5AesQuVPK+szc7T2DLXwY5035uVZ7WJJzYexVWLdpRrxhhJ5oWC2Pr
 75i2zKikn2zqtHWbCjN6pI0JlsXN3U9Dp2eg5UJK7Dde1E2Qz16UKO5LVYdl2pNwf89egDgo
 CzVZ6Ok4ASu7ZE6AV/SOy09Me2HsWhX/C9iZkTAwmpEK1B4Pdjztv5HH3fGVbMq8PN+wLZpS
 fgbdt+bA+heAjLK5ysad5qVkWCRXEvDuO56BAL7O2JXV8A7GGT0FirMJFaHGN8mUnHq76PTY
 tSIimvmfHb0b1Q6U52LNqPwp75z1FBE8N9Ps4LzCoE7UC3RHEJCcEQdUtdfzxkwFCj+
IronPort-HdrOrdr: A9a23:2vOqoq89weDyueqXAK1uk+GRdb1zdoMgy1knxilNoERuA6ilfr
 OV7ZMmPH7P+U0ssRQb8+xoV5PwI080y6QFq7X5UY3SFDUPlgOTXfdfBKHZskjd8xSXzJ8r6U
 +LG5IOQeEYdGIK+foSgzPIaerIouP3lZxA3t2uvUuFJDsCA8oMg2gWNu/8KDw8eOBoP+t1KH
 P23Ls3m9PUQwV1Ui3NPBk4tob4xuEiVfrdEG47Li9iwg+IkD+u9frUEx2E0gwTXndl0d4ZgB
 b4ekfCl8OeWrmAu2bhP+C61eUkpPLRjuBYHcSJh4wsNjnxhkKJae1aKsK/lQFwm/u34FIm1O
 PBuAgtJK1Img7sV1DwmwLk3wSl6zo193r+oGXo/UcLj/aJPA4HNw==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:25:09 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id D5892300719FC;
        Fri,  1 Jul 2022 11:25:07 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 6/6] Staging: rtl8192e: Added spaces around '+'
Date:   Fri,  1 Jul 2022 11:24:54 +0200
Message-Id: <87628a2dd08ec0e5b02090485e7a9a1d91b7d2a5.1656667089.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656667089.git.f3sch.git@outlook.com>
References: <cover.1656667089.git.f3sch.git@outlook.com>
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
     CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 6b11908032d7..da2c41c9b92f 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -769,7 +769,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
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

