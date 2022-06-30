Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D0956193C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiF3Lah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiF3La3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:29 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA151B30
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:27 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2ADCACciL1iffxkzoFagliDJYFXlBABAQEGjHKHH4wuA?=
 =?us-ascii?q?QEBAQEBAQEBCS8TBAEBQIoRJzcGDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4VoDYZDBicLAUYQUVcZgngCAQECgmQBAzCtWzKBAYZaAYE/g?=
 =?us-ascii?q?WWBPolZhSCBQIEQgUiDNYURhW4Emj4KAwkEBwVGFxJOMSECRQscAQgGBgcBC?=
 =?us-ascii?q?AEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINAg4HAQEMD?=
 =?us-ascii?q?wECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECBQICAQMPA?=
 =?us-ascii?q?QgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACGAcCARUBB?=
 =?us-ascii?q?QIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBAggDFgcBA?=
 =?us-ascii?q?iEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vER0NCAQIB?=
 =?us-ascii?q?AkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBAQIBFgIQC?=
 =?us-ascii?q?AIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMFSceKQUHERIbDwQNDQo0I?=
 =?us-ascii?q?BYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYaAQIDIgISCwkVAgQmC?=
 =?us-ascii?q?AkDFgYtBQEiHRmcDIEOTIFdliCrZgeDURABixCVJoVFkR0CkgCRQoUxonSET?=
 =?us-ascii?q?zWBQjOBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCY8FAQE?=
IronPort-Data: A9a23:6ok/zaJXZ4lR9HVpFE+RS5UlxSXFcZb7ZxGr2PjKsXjdYENShT1Um
 jYaXm6FOvvfN2ShfYxxYYiwoRhT7MTUy9YyQQAd+CA2RRqmi+KcWIvDfhmsV8+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vrav67xZVF/fngqoDUUIYoAQgsA14+IMsdoUg7wbRh3NUw2YLR7z6l4
 LseneWOYDdJ5BYpagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfnZw0/Df2VhNrXSq
 9AvbF2O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQWxxkRevgvFp8
 ccO6b6PDl0OO4jenvtIBnG0EwkmVUFH0LrOIHzn6IqOyUyDc3btz/hqBkwsMssU946bA0kXr
 61ecmhTKEnb36TsnejTpupE36zPKOHwN4Mbt2l4wCvxFuo7TdbeRaSP5dJZ0Do0jM1UErDSa
 qL1bBI2MkmQM0YRagp/5JQWk8qqwVnELWdjlXmkj/AuylTK0SlW6e24WDbSUofWG5kPxx7wS
 nj913v7GRYGPfSQzDOE9jSngeqntSzhVY0RFJW89/h3kFOU22ofAQEXUl39puO24ma6WtRCO
 wkP5iMhrK493EiqVcXmGRm5pmOU+BIRRbJ4HbYh4wHLxavIywGEGmwDST0HY9sj3OcyRDo3x
 hqKksnvCDhHrrKYUzSe+62SoDf0PjIaRVLufgcBRAoBu4ClvYcyyxLCT9puFKS4lNKzFTyYL
 y22QDYWrJMJr+gW9r2C7xOboQ3r/L/Maxwz+VCCNo661T9RaImgbo2uzFHU6/dcMYqUJmVtW
 lBZwaByC8hTXfmweDyxrPYlQOD1vq7aWNHIqQ4xT8F4n9i40yP7JehtDCdCyFBBHutsldXBQ
 ELStQ5V7pJJMxNGhocpMtvrU6zGIYDKHNjoULXrxQ5UfoR8cQWK5i4GWKJ992XkkUx0yOciP
 5beccutAXseA6l9w3y6So/xMIPHJAhgmgs/priikXxLNIZyglbOFt/p13PSNogEAFus+lm9z
 jqmH5LiJ+9jeOP/eDLL1oUYMEoHK3M2bbiv9ZEJK7TcflE9QTh+YxM0/V/HU9I990iyvrmUl
 kxRpmcGmTITeFWdcVTXNCk9AF8Rdcci9CNT0dMQ0aaAgCR9Pdz2tM/zhrM9cL046eEr0Ph1U
 fQfYMScE7xJRyjY/C4eBaQRX6Q9HClHcTmmYXH/CBBhJMEIeuA80oW5FucZ3HVVU3DfWApXi
 +HI6z43trJaHlw/V5aON6n1p75z1FBE8N9Ps4LzCoE7UC3RHEJCckQdUtdfzxkwFCj+
IronPort-HdrOrdr: A9a23:AVyrp6jIQqwDKBPMnHbAy4I2vnBQXv4ji2hC6mlwRA09TyXBrb
 HLoB1p726StN9xYgBapTnuAsm9qB/nmKKdpLNhWItKPzOWwldATrsSjrcKqgeIc0aVygce79
 YDT0EUMrLN5C1B7PoSlzPXLz9P+rW6GP/Cv5ai854nd3ANV0gp1XYBNu8wKDwLeOBpP+tAKK
 ah
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:30:27 +0200
Received: from localhost (dhcp567-177.laptop-wlc.uni-heidelberg.de [147.142.67.177])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 0573730011A56;
        Thu, 30 Jun 2022 13:30:26 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v2 3/6] Staging: rtl8192e: Remove unnecessary parentheses
Date:   Thu, 30 Jun 2022 13:30:16 +0200
Message-Id: <94845ca3f74e980092b6ba47d283d31c621fd95d.1656587827.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656587827.git.f3sch.git@outlook.com>
References: <cover.1656587827.git.f3sch.git@outlook.com>
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

This addresses an issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     Unnecessary parentheses around wrqu->encoding

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index f8683b914668..49b3d4c8f5d6 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -275,7 +275,7 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *keybuf)
 {
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	struct net_device *dev = ieee->dev;
 	struct rtllib_security sec = {
 		.flags = 0
@@ -447,7 +447,7 @@ int rtllib_wx_get_encode(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *keybuf)
 {
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	int len, key;
 	struct lib80211_crypt_data *crypt;
 
-- 
2.36.1

