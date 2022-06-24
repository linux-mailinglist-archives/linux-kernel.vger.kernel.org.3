Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A3559AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiFXNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiFXNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:55:08 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD346653
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:55:03 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BIBQA6wbViffxkzoFaHgEBCxIMggQLhHyUEAEBAQaMb?=
 =?us-ascii?q?wOHHIwuAQEBAQEBAQEBCUIEAQFAig8nNwYOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QYBAQEBAQcEFAEBIzwnhXWGQwYyAUYQUVcZgngCAQGCZgEDMK0vgQGGWQGBP?=
 =?us-ascii?q?4FlgT0BiVaFH4FAgRCBFTODNYURhW4EmUcKAwkEBwVGFxJOMSECRQscAQgGB?=
 =?us-ascii?q?gcBCAEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINAg4HA?=
 =?us-ascii?q?QEMDwECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECBQICA?=
 =?us-ascii?q?QMPAQgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACGAcCA?=
 =?us-ascii?q?RUBBQIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBAggDF?=
 =?us-ascii?q?gcBAiEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vER0NC?=
 =?us-ascii?q?AQIBAkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBAQIBF?=
 =?us-ascii?q?gIQCAIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMOFSceKQUHERIbDwQND?=
 =?us-ascii?q?Qo0IBYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYcAQIDJQISBg4FA?=
 =?us-ascii?q?SIdGZp8E4EOxCkHg1EQAaA1lmICkgAtlkOiboRONYFCM4FMTSODOFEZD5xyc?=
 =?us-ascii?q?zsCBgsBAQMJjwEBAQ?=
IronPort-Data: A9a23:UnO6TKB0ZtIXrhVW/6Ljw5YqxClBgxIJ4kV8jS/XYbTApGxx1zVUz
 jBKUGvTM/veZGv3f48jO9jl/E4H78LUy9NrOVdlrnsFo1Bi8JeaX4THci8cHM8wwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgH2eIdA970Ug5w7Bj3tYy6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pHTU2FFEYUd6EPdgKMq
 0Yv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9IdN3ZuqBOvrup/x
 dhTq4buYDt1EoDlzbF1vxlwS0mSPIVD8b7DeSH5rMqSik3Lcnfhx/9jFk5wMYBwFuRfWDsfs
 6ZAdnZUNkjF3b/sqF64YrAEasALN8LrOI4Honx65SrFEPpgXJbCBqXH5NNV2D09nM8IEfu2i
 88xMGQyNUuQPUMRUrsRILQErriixWPuSWFR60qlrvUMyELO4jUkhdABN/KOJoLWH5wN9qqCn
 UrJ5Wn2AREyMN2Z1CqL9W+qiubTnCT9HoUIG9WQ8v9snU3W3XAaBxwQWnO/oOKlkQi6WtRCO
 woY9zRGhaZp70erCNb8QzW/vWKAuRkfHdFXFoUS7ACL17qR4AuDAGUAZiBOZcZgt8IsQzEuk
 FiTkLvU6SdHtbSUTSrEsKqSrHayNCkZIGsIaDULCwcIizX+nG0tphORf+9ANoiEtNP4FC/u2
 W6jkHQSqpxG2KbnyJ6H1VzAhjutoL3AQQg0+hjbUwqZAuVROdHNi2uAtAmz0BpQEGqKZgXQ4
 CFcxKBy+MheU8HVzURhVc1QROnB2hqTDNHLqXJCd3XL3xSg+nKueYpd+j4WyKxBbJddI2eBj
 KP7kwpd6ZkWA9B+d7Nrboe7Bt4lpZUM+PzgX/HQNoMIf55wMQ+K/S1jYUSdxW+rnEVEfUAD1
 XWzL5bE4ZUyUPoPIN+KqwE1iuNDKscWmTq7eHwD5077uYdynVbMIVv/DHOAb/oi8ISPqxjP/
 tBUOqOikksCDrWmM3GNoNZIdjjmyETX47io8aS7kcbdfGJb9J0JVKe5LU4JIdQ0wvoMyI8kA
 FnkAhMGlDITekEr2S3RNi4/Muq3NXqOhXg2OTMxMB613Xk9bJy07bsOP506YaYg7u8L8BKHZ
 6ZtRil0OdwREW6v02pGMvHAQHlKLknDafSmY3H4OlDSvvdIG2T0xzMTVlG+qnBQUnXm7pVWT
 n/J/lqzfKfvjj9KVK7+AM9DBXvr1ZTBsIqeh3f1H+Q=
IronPort-HdrOrdr: A9a23:+zj75qDIQ4/UplnlHemN55DYdb4zR+YMi2TDtnoBMCC9F/byqy
 nAppomPHPP5Qr4dhkb+Oxoe5PwI080lqQFgrX5X43SOjUO0VHAROtfBODZrAEIdReTygcT79
 YET0HSMqyVMXFqyezByE2TFdI4xdmO96qlwd3Z02xmQWhRC52Iqz0JbTqmLg==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2022 15:55:00 +0200
Received: from localhost (ip2505f6aa.dynamic.kabel-deutschland.de [37.5.246.170])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 82C1330011A56;
        Fri, 24 Jun 2022 15:55:00 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v5 1/3] Staging: rtl8192e: Use struct_size
Date:   Fri, 24 Jun 2022 15:54:53 +0200
Message-Id: <54ea62a2b7628d3bdd5aa52df82c3e91704a2127.1656078068.git.f3sch.git@outlook.com>
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

Using struct_size is encouraged because it is safer
than using sizeof and calculations by hand.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 37715afb0210..f2ef32e943ae 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,8 +205,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
-		      gfp_mask);
+	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-- 
2.36.1

