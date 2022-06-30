Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A68E561935
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiF3Lad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiF3La2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:28 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7684B51B2F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:26 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BzBwCciL1iffxkzoFaHgEBCxIMggQLgyWBV5QQAQEBB?=
 =?us-ascii?q?oFCizCGcopUggcBAQEBAQEBAQEJLxMEAQFAihEnNgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQYBAQEBAQcEFAEBIzwnhWgNhkMGJwsBRhBRVxmCeAIBAQKCZAEDM?=
 =?us-ascii?q?K1bMoEBhloBgT+BZYE9iVqFIIFAgRCBSIEJgiyFEYVuBJdZgmUKAwkEBwVGF?=
 =?us-ascii?q?xJOMSECRQscAQgGBgcBCAEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMC?=
 =?us-ascii?q?hsHBwMLBTINAg4HAQEMDwECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALA?=
 =?us-ascii?q?gMWCQcIAgECBQICAQMPAQgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLC?=
 =?us-ascii?q?gMOAwQDARACGAcCARUBBQIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFA?=
 =?us-ascii?q?QMYCAMUAwUBAggDFgcBAiEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECA?=
 =?us-ascii?q?wIGFQYCAj8vER0NCAQIBAkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBF?=
 =?us-ascii?q?gIGBAMCAgMBAQIBFgIQCAIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMF?=
 =?us-ascii?q?SceKQUHERIbDwQNDQo0IBYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDA?=
 =?us-ascii?q?gYaAQIDIgISCwkVAgQmCAkDFgYtBQEiHRmbGXMBehNMgWSTDIMNixOgUweDU?=
 =?us-ascii?q?RABixCVJoN1gVCKc4YqApIALZZGonSETzWBMw01gUxNI4M4CUgZD5dUhR5zO?=
 =?us-ascii?q?wIGCwEBAwmPBQEB?=
IronPort-Data: A9a23:henVVa/KcLxxT8wS1/UkDrUDGn6TJUtcMsCJ2f8bNWPcYEJGY0x3x
 mIeWm+FbPiMMTHwe910PNmyphgAucXTm9JjSlA//ilEQiMRo6IpJ/zAcxiqb33ORiHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsYkidfic5DnZ74f5fs7Rh2NQw34PhW1nlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByOQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxeAkMFX6
 Y9Nj8Dzbip5YvzSl7gACDANRkmSPYUekFPGCX22sMjLlgvbdXqpw/hvAEwyN4AC9aB7DAmi9
 9RBcmFLNEjdwbvumPThF7MEascLdaEHOKsEsXFkwCnBAOwOWozeT+PX494d3Doxis1KF/vEa
 IwVZFKDaTyZPUAfagxJWMpWcOGAun7dfmZJkk2s++kVuEz51FFz7Kq9L4+AEjCNbZ4JwBrC/
 zquE37CKg4YL9uDwBKK93utgqnEmiaTcI0IGbK79tZugVuO1mIUFRsaXEe6pv//jVSxM/pbK
 koJ6m81saE99UqkZt38RAGj5nqFuAMMHdZdDYUS5lqWwaqS7AeFLm8ZUjpGb99gv8gzLRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDRLoViMA6tjn+Nh1kxTOC9ZuEaK4itf4Az62z
 z3iQDUCa6s7r8cExoOap1D933GLi8iVHxA6uhiMdzfwhu9mX7KNa4ut4FndyP9PKoeFU1WM1
 ETofeDDtoji6rnQxESwrPUx8KKBu6fZaWWD6bJ7N8l/p2z0k5K2Vd0IuFlDyFFV3tEsVRKBj
 KX7mQ5Q6JJXNnawYsebiKrvWp1wlcAM+fzPX/zZaJ9xyUxraBOK+Stjf0H44owAuE0lkKVnY
 NGGd8fpDXsbBaljxjesSKER3NfHJxzSJ0uNGvgXLDz+j9JygUJ5r59ebzNiichltMu5TP39q
 Yo3Cidz40w3vBfCSifW65UPClsBMGI2A5v7w+QOKLPdf1A5RDp6UqaOqV/ER2CDt/oN/gsv1
 i/hMnK0NHKh1BUr1C3QMiE+NuqxNXqBhSNmZH1E0amUN4gLOtrxsP1GL/PbjJEt+eh80PM8U
 v8EZciaGfVTW3zB9igCaoP+xLGOhzz07T9iyxGNPmNlF7Y+HFOhxzMRVlGynMX4Jnbs6JFWT
 nzJ/l+zfKfvsCw7VZ6LM6L3kAjr1ZXf8corN3b1zhBoUB2E2OBXx+bZ1Jfb/+lkxc3/+wan
IronPort-HdrOrdr: A9a23:jGYqgqyqp1/EZY/z36myKrPwCL1zdoMgy1knxilNoERuA6ilfr
 OV7ZMmPH7P+U0ssR4b+exoVJPsfZqYz+8R3WBzB8bZYOCFghrKEGgK1+KLqFfd8m/Fh4xgPM
 xbHJSWfeeQMbEMt6jHCWeDf+rJn7K8gd2VbKzlvhFQpElRGthdBq1Ce3qm+2NNNXF7OaY=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:30:24 +0200
Received: from localhost (dhcp567-177.laptop-wlc.uni-heidelberg.de [147.142.67.177])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 4B14F300084F1;
        Thu, 30 Jun 2022 13:30:23 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v2 1/6] Staging: rtl8192e: Refactored rtllib_modes
Date:   Thu, 30 Jun 2022 13:30:14 +0200
Message-Id: <82c9da336bf9bb7dbf5378efc9be20ea268eeb3c.1656587827.git.f3sch.git@outlook.com>
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

The initial reason for looking at this code was an
issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: Please use a blank line after function/struct/union/enum
     declarations

The additional blank line above the struct/before the headers is
just cleaner.

However, as it turns out since there is no str formatting required
One can replace the error prone str + size struct with a char array.
The rest of this patch fixes the usecases.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index cf9a240924f2..1e420230d029 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -17,18 +17,8 @@
 #include <linux/module.h>
 #include <linux/etherdevice.h>
 #include "rtllib.h"
-struct modes_unit {
-	char *mode_string;
-	int mode_size;
-};
-static struct modes_unit rtllib_modes[] = {
-	{"a", 1},
-	{"b", 1},
-	{"g", 1},
-	{"?", 1},
-	{"N-24G", 5},
-	{"N-5G", 4},
-};
+
+static const char *rtllib_modes[] = { "a", "b", "g", "?", "N-24G", "N-5G" };
 
 #define MAX_CUSTOM_LEN 64
 static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
@@ -72,10 +62,9 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
-		if (network->mode&(1<<i)) {
-			sprintf(pname, rtllib_modes[i].mode_string,
-				rtllib_modes[i].mode_size);
-			pname += rtllib_modes[i].mode_size;
+		if(network->mode & BIT(i)){
+			strcpy(pname, rtllib_modes[i]);
+			pname += strlen(rtllib_modes[i]);
 		}
 	}
 	*pname = '\0';
-- 
2.36.1

