Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C53562FED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiGAJ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiGAJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:06 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5D103F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:04 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DZBQDZvL5iffxkzoFagliDJYFXlBADBoxyhx+MLgEBA?=
 =?us-ascii?q?QEBAQEBAQkvEwQBAT0BAooRJzcGDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4VoDYZDBicLAUYQUVcZgngCAQECgmQBAzCuKDKBAYZaAYE/g?=
 =?us-ascii?q?WWBPolbhSCBQIEQgUiDNYURhW4Emk8KAwkEBwVGFxJOMSECRQscAQgGBgcBC?=
 =?us-ascii?q?AEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINAg4HAQEMD?=
 =?us-ascii?q?wECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECBQICAQMPA?=
 =?us-ascii?q?QgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACGAcCARUBB?=
 =?us-ascii?q?QIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBAggDFgcBA?=
 =?us-ascii?q?iEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vER0NCAQIB?=
 =?us-ascii?q?AkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBAQIBFgIQC?=
 =?us-ascii?q?AIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMFSceKQUHERIbDwQNDQo0I?=
 =?us-ascii?q?BYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYaAQIDIgIQCwkVAgQhC?=
 =?us-ascii?q?AkDFgYiCxwFASIdGZwYgQ5MgV2WIKtmB4NREAGLEJUmhUWRHQKSAJFChTGid?=
 =?us-ascii?q?IRPNYFCM4FMTSODOAlIGQ+XVIUeczsCBgsBAQMJjwUBAQ?=
IronPort-Data: A9a23:XG88/695Xh/3QlCdLmBPDrUDGH6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 WpLCDrUPfmIYWbxfN1zPorl/B9TvpLTy981Gws9rn1EQiMRo6IpJ/zAcxiqb33ORiHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsYkidfic5DnZ74f5fs7Rh2NQw3oDgW1rlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByOQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYowrVtNpQz
 4odid+bYjUsO5DVwegDCSANRkmSPYUekFPGCX22sMjLlgvbdXqpw/hvAEwyN4AC9aB7DAmi9
 9RBcmFLNEjdwbvumPThF7MEascLdaEHOKsEsXFkwCnBAOwOWozeT+PX494d3Doxis1KF/vEa
 IwVZFKDaTyZPUMXYw9JU8JWcOGAryH1T2AImVOugPQUyk+QzAYql+XtP4+AEjCNbZ4JwBrC/
 zquE37CKg4YL9uDwBKK93utgqnEmiaTcI0IGbK79tZugVuO1mIUFRsaXEe6pv//jVSxM/pbK
 koJ6m81saE99UqkZt38RAGj5nqFuAMMHdZdDYUS5lqWwaqS7AeFLm8ZUjpGb99gv8gzLRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDRLoViMA6tjn+Nh1kxTOC9ZuEaK4itf4Az62z
 z3iQDUCa6s7spIg3YS8ogD7wBmHlJ3Mcxds6huNZzfwhu9mX7KNa4ut4FndyP9PKoeFU1WM1
 ETofeDDs4ji6rnQxESwrPUx8KKBu6fZaWWD6bJ7N8l/p2z0k5K2Vd0IuFlDyFFV3tEsVRKBj
 KX7mQ5Q6JJXNnawYsebiKrvWp1wlcAM+fzPX/zZaJ9xyUxraBOK+Stjf0H44owAuE0lkKVnY
 NGGd8fpDXsbBaljxjesSKER3NfHJxzSJ0uNFfgXLDz+j9JygUJ5r59eYDNiichltMu5TP39q
 Yo3Cidz40w3vBfCSifW65UPClsBMGI2A5v7w+QOKLPdfFM9SDp9UKSNqV/ER2CDt/oO/gsv1
 i/gMnK0NHKh1BUr1C3QMiE+NuqxNXqBhSNmZHdE0amUN4gLOtrxsP1GL/PbjJEt+eh80PM8U
 v8EZciaGfVTW3zB9igCaoP+xLGOhzz07T9iyxGNPmNlF7Y+HFOhxzMRVlGynMX4Jnbs6JFWT
 nzJ/l+zfKfvsCwyVJmNNaz+kDtcfxE1wYpPYqcBGfELEG2EzWSgA3eZYiMfSy3UFSj++w==
IronPort-HdrOrdr: A9a23:FN8pb6qMjb2n4t5m1sKyiIEaV5rneYIsimQD101hICG9Kvbo7f
 xHnJwgpH3JYUUqKQwdcLG7Sdi9qBznhPhICOUqXYtKGTOWw1dAT7sSnbcKoQeQYhEWn9Q1vc
 wMH8cRaeEYT2IK9foSizPIdurIteP3l5xA8t2uq0uFIzsaCJ2IpD0JdjpzWncGOzVuNN4cLr
 LZ3Op/zgDLRZx6A/7LdUXtcdKz2eH2qA==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:25:04 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id EB6E4300719FC;
        Fri,  1 Jul 2022 11:25:02 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 3/6] Staging: rtl8192e: Remove unnecessary parentheses
Date:   Fri,  1 Jul 2022 11:24:51 +0200
Message-Id: <0e4e340be3f4c7f35a5381b726b1db5fc6842f10.1656667089.git.f3sch.git@outlook.com>
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

This addresses an issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     Unnecessary parentheses around wrqu->encoding

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 121bf939c6a4..db076e819993 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -277,7 +277,7 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *keybuf)
 {
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	struct net_device *dev = ieee->dev;
 	struct rtllib_security sec = {
 		.flags = 0
@@ -449,7 +449,7 @@ int rtllib_wx_get_encode(struct rtllib_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *keybuf)
 {
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	int len, key;
 	struct lib80211_crypt_data *crypt;
 
-- 
2.36.1

