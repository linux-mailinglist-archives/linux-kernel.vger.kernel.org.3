Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2986558A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiFWU3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiFWU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:29:19 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049C53A7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:29:17 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2D0BQCJzLRiffxkzoFaHgEBCxIMggQLhHyUDwEBAQaMb?=
 =?us-ascii?q?QOHHIwuAQEBAQEBAQEBCUIEAQFAig8nNwYOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QYBAQEBAQcEFAEBIzwnhXWGQwYyAUYQUVcZgngCAQGCZgEDMK1wgQGGWQGBP?=
 =?us-ascii?q?4FlgT0BiVWFH4FAgRCBFTODNYURhW4EmUMKAwkEBwVGFxJOMSECRQscAQgGB?=
 =?us-ascii?q?gcBCAEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINAg4HA?=
 =?us-ascii?q?QEMDwECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECBQICA?=
 =?us-ascii?q?QMPAQgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACGAcCA?=
 =?us-ascii?q?RUBBQIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBAggDF?=
 =?us-ascii?q?gcBAiEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vER0NC?=
 =?us-ascii?q?AQIBAkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBAQIBF?=
 =?us-ascii?q?gIQCAIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMOFSceKQUHERIbDwQND?=
 =?us-ascii?q?Qo0IBYkAQEOBQMBEhkRDgcUClMmIhUQBgErGAMEAQMDAgYeAQIDJQIZBQEiH?=
 =?us-ascii?q?RmadxOBDsQqB4NREAGgNJZiApIALZZDom2ETjWBQjOBTE0jgzhRGQ+ccnM7A?=
 =?us-ascii?q?gYLAQEDCY8BAQE?=
IronPort-Data: A9a23:zOtco6/WHMXq1wVAO9wtDrUDCX6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 mFNWm3QbqqJMzT2Lt5xa9nn9U0DvcXVyYA1G1c4+H9EQiMRo6IpJ/zAcxiqb33ORiHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsYkidfic5DnZ74f5fs7Rh2NQw34LiW1nlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByOQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYo2SgsspQ7
 OphjriTQzVuF6vhs79adRYNRkmSPYUekFPGCX22sMjLlgvbdXqpw/hvAEwyN4AC9aB7DAmi9
 9RBcmFLNEjdwbvumPThF7MEascLdaEHOKsEsXFkwCnBAOwOWozeT+PX494d3Doxis1KF/vEa
 IwVZFKDaTyZPUAXaw9HV8xWcOGAqSLUSj1VpGivm40J2HqIyQdq8orBGY+AEjCNbZ4JwBrC/
 zquE37CKh4AOdOcyRKB83SxluHIgCX3UZ4TE7v+8eRl6HWXx2oOGFgNSVK0oP+2okq/QM5Eb
 UgV/Dc+66Q/6iSDQILmVB3+r3+YlhkBR95XFO584waIooLQ4gCEFi0HQyRHZdgOqsA7X3op2
 0WPktevAiZg2IB5UlqY/7aQ9Wr0JC4UaG8PZCMJSQEI+dalrIxbYg/zoshLQYeYlPzRJh3L5
 xOAnm8XgZg41okt2PDulbzYuA6Eqp/MRw8zwwzYWGO58w90DLJJgaT1tjA3Ct4dfe6kokm9U
 Gssx5nCtbhRZX2ZvHzTEL1UdF28z6vdaFXhbUhT844J2xnFF5SLXY1R7Dx6LkpzPa7okhe3M
 RaJ4Wu9CLd5NXena+pIyFarF9gnyKLtD9uNaxw5Rt9HY5wpLUma+iArZUOR023pmkU2nuczN
 P93kPpA715EWcyLLxLvGY/xNIPHIAhlmQs/orinlnyaPUK2PiL9dFv8GALmghoFxK2Fuh7J1
 N1UKtGHzR5SOMWnPHSJqdZCdQpbdSNgbXwTlyCxXrDZSuaBMD9/Y8I9PZt+I+SJYowPzraVo
 CjjMqOm4AOn2SObQel1VpyTQOizA8ol9CpT0d0EN1usxGUuKZup7bkSbYA2Yahv8uF/0vluT
 JE4lzaoXZxypsD802pGN/HV8tc9HClHcCrUYkJJlhBjJMM6L+EIk/e4FjbSGN4mX3Xm5JNj/
 eXIO8GyacNrejmOxf3+MJqHp25dd1BD8A6udyMk+uVuRXg=
IronPort-HdrOrdr: A9a23:E50h2KqXUHyPP8IhgMFUTr4aV5o8eYIsimQD101hICG9vPb1qy
 nIpoV+6faaslgssR0b8+xofZPwIk80lqQFhLX5Q43CYOCOggLBR72Kr7GSoQEIcBeQygcy78
 pdmtBFaOHNMQ==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 22:28:01 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id C156030011A56;
        Thu, 23 Jun 2022 22:27:59 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 1/3] Staging: rtl8192e: Use struct_size
Date:   Thu, 23 Jun 2022 22:27:53 +0200
Message-Id: <54ea62a2b7628d3bdd5aa52df82c3e91704a2127.1655975970.git.f3sch.git@outlook.com>
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

