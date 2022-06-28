Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433255C463
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiF1Ibc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245628AbiF1IbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:18 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499C26542
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:16 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BkBACEu7piffxkzoFagliDJYFXlBABAQEGjHGHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQFAig8nNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhWgNhkMGJwsBRhBRVxmCeAIBAQKCZAEDMK4uMoEBhloBg?=
 =?us-ascii?q?T+BZYE9iVmFH4FAgRCBFTODNYQLgQaFbgSaBgoDCQQHBUYXEk4xIQJFCxwBC?=
 =?us-ascii?q?AYGBwEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFMg0CD?=
 =?us-ascii?q?gcBAQwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFA?=
 =?us-ascii?q?gIBAw8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMfCAsKAw4DBAMBEAIYB?=
 =?us-ascii?q?wIBFQEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDBQECC?=
 =?us-ascii?q?AMWBwECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICPy8RH?=
 =?us-ascii?q?Q0IBAgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICAwEBA?=
 =?us-ascii?q?gEWAhAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAwwVKR4pBQcREhsPB?=
 =?us-ascii?q?A0NCjQgFiQBAQ4FAwESGREOBxQKUyYhFRAGASsWAwQBAwMCBhoBAgMiAhILC?=
 =?us-ascii?q?RUCBC0FASIdGZtKAYENTpd7q2EHg1EQAYsQlSaFRZEdApIAlnCicYRPNYEsS?=
 =?us-ascii?q?YFMTSODOAlIGQ+XVIUeczsCBgsBAQMJjDmCSAEB?=
IronPort-Data: A9a23:ACpbUq+G6j8vTQhpLJ4vDrUDGn6TJUtcMsCJ2f8bNWPcYEJGY0x3x
 zYZC2yDM66CNGT2e491bY+w9RlTvsTRyNRnQAY5/3xEQiMRo6IpJ/zAcxiqb33ORiHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsYkidfic5DnZ74f5fs7Rh2NQw34LpW1rlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByOQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxeAwPB76
 YwTibihWQtyL7LjuOI5UgYNRkmSPYUekFPGCX22sMjLlgvbdXqpw/hvAEwyN4AC9aB7DAmi9
 9RBcmFLNEjdwbvumPThF7MEascLdaEHOKsEsXFkwCnBAOwOWozeT+PX494d3Doxis1KF/vEa
 IwVZFKDaTyZPUASYwtOV85WcOGAwUTmKQxahXmplbMcpEmO3g1b84TAGY+AEjCNbZ4JwBrC/
 zquE37CKg4YL9uDwBKK93utgqnEmiaTcI0IGbK79tZugVuO1mIUFRsaXEe6pv//jVSxM/pbK
 koJ6m81saE99UqkZt38RAGj5nqFuAMMHdZdDYUS5lqWwaqS7AeFLm8ZUjpGb99gv8gzLRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDRLoViMA6tjn+Nh1kxTOC9ZuEaK4itf4Az62z
 z3iQDUCa6s7r8dU96+apA77pyO8qsPYUSEV4CHWQTfwhu9mX7KNa4ut4FndyP9PKoeFU1WM1
 ETofeDAtYji6rnQxESwrPUx8KKBu6fZaWWD6bJ7N8l/p2z0k5K2Vd0IuFlDyFFV3tEsVRKBj
 KX7mQ5Q6JJXNnawYsebiKrvWp1wlcAM+fzPX/zZaJ9xyUxraBOK+Stjf0H44owAuE0lkKVnY
 NGGd8fpDXsbBaljxjesSKER3NfHJxzSJ0uNFfgXLDz+j9JygUJ5r59ZbzNiichivcu5TP39q
 Yo3Cidz40w3vBfCSifW65UPClsBMGI2A5v7w+QOKLPdeVc6Rjt/VaSIqV/ER2CDt/oE/gsv1
 i/hMnK0NHKh1BUr1C3QMiE+NuqxNXqBhSJgbXxE0amUN4gLOtrxsP1GL/PbjJEt+eh80PM8U
 v8EZciaGfVTW3zB9igCaoP+xLGOhzz07T9iyxGNPmNlF7Y+HFOhxzMRVlGynMX4Jnbs6JFWT
 nzJ/l+zfKfvsCw4XJqLN6r+nwjq1ZXf8corN3b1zhBoUB2E2OBXx+bZ15fb/+lkxc3/+wan
IronPort-HdrOrdr: A9a23:/yYrSKGn8inyCg2npLqExMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcL+7V5VoLUmskqKdpLNhW4tKPzOJhILLFu1fBOLZqlWKdhEWtNQtsJ
 uIGJIfNDSfNykZsS+32miFOudl6OW70eSTpd629R1QpW0GUdAa0ztE
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:16 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 129EF30011A5C;
        Tue, 28 Jun 2022 10:31:15 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 7/7] Staging: rtl8192e: Added spaces around '+'
Date:   Tue, 28 Jun 2022 10:30:56 +0200
Message-Id: <89740728c6b1f5c89baf72dcb2ef499e73ca693d.1656402464.git.f3sch.git@outlook.com>
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
     CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 9945f3f136d1..52e5e4e5977b 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -780,7 +780,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
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

