Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B656192B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiF3Lan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiF3Lab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:31 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A0751B2A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:29 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2B6CQCciL1iffxkzoFagliDJYFXlBABAQEGjHKHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQE9AQKKESc1CA4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBBwQUAQEjPCeFaA2GQwYnCwFGEFFXGYJ4AgEBAoJkAQMwrVsygQGGW?=
 =?us-ascii?q?gGBP4FlgT2JWoUggUCBEIFIgzWEC4EGhW4Emj4KAwkEBwVGFxJOMSECRQscA?=
 =?us-ascii?q?QgGBgcBCAEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINA?=
 =?us-ascii?q?g4HAQEMDwECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECB?=
 =?us-ascii?q?QICAQMPAQgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACG?=
 =?us-ascii?q?AcCARUBBQIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBA?=
 =?us-ascii?q?ggDFgcBAiEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vE?=
 =?us-ascii?q?R0NCAQIBAkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBA?=
 =?us-ascii?q?QIBFgIQCAIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMFSceKQUHERIbD?=
 =?us-ascii?q?wQNDQo0IBYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYaAQIDIgISC?=
 =?us-ascii?q?wkVAgQmCAkDFgYtBQEiHRmcDAGBDUyBXZYgq2YHg1EQAYsQlSaFRZEdApIAk?=
 =?us-ascii?q?UKFMaJ0hE81gS0BR4FMTSODOAlIGQ+XVIUeczsCBgsBAQMJjD2CSAEB?=
IronPort-Data: A9a23:pIhIHK+1w8VHfFXQWscjDrUDGn6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 mAWDGmHO6yDa2Wgf4t2PoWx9hkD7JXQyNYySwU9+CtEQiMRo6IpJ/zAcxiqb33ORiHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsYkidfic5DnZ74f5fs7Rh2NQw34PhW1nlV
 e7a+qUzBnf0g1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByOQrr1vIwKPb
 72rIIdVXo/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxSKruxB5
 YRgiYOLbgAoNIKcwM0GQxYNRkmSPYUekFPGCX22sMjLlgvbdXqpw/hvAEwyN4AC9aB7DAmi9
 9RBcmFLNEjdwbvumPThF7MEascLdaEHOKsEsXFkwCnBAOwOWozeT+PX494d3Doxis1KF/vEa
 IwVZFKDaTyZPUAfagxJWchWcOGAoF6kbzp2gVKpu40F/ELTkRIq/bq1P4+AEjCNbZ4JwBrC/
 zquE37CKg4YL9uDwBKK93utgqnEmiaTcI0IGbK79tZugVuO1mIUFRsaXEe6pv//jVSxM/pbK
 koJ6m81saE99UqkZt38RAGj5nqFuAMMHdZdDYUS5lqWwaqS7AeFLm8ZUjpGb99gv8gzLRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDRLoViMA6tjn+Nh1kxTOC9ZuEaK4itf4Az62z
 z3iQDUCa6s7rM0665WWrH37nAmLoZnDYV5tzx7HUTfwhu9mX7KNa4ut4FndyP9PKoeFU1WM1
 ETofeDDtoji6rnQxESwrPUx8KKBu6fZaWWD6bJ7N8l/p2z0k5K2Vd0IuFlDyFFV3tEsVRKBj
 KX7mQ5Q6JJXNnawYsebiKrvWp1wlcAM+fzPX/zZaJ9xyUxraBOK+Stjf0H44owAuE0lkKVnY
 NGGd8fpDXsbBaljxjesSKER3NfHJxzSJ0uNGvgXLDz+j9JygUJ5r59ebzNiichltMu5TP39q
 Yo3Cidz40w3vBfCSifW65UPClsBMGI2A5v7w+QOKLPdf1A5RDp6UqaOqV/ER2CDt/oN/gsv1
 i/hMnK0NHKh1BUr1C3QMiE+NuqxNXqBhSNmZH1E0amUN4gLOtrxsP1GL/PbjJEt+eh80PM8U
 v8EZciaGfVTW3zB9igCaoP+xLGOhzz07T9iyxGNPmNlF7Y+HFOhxzMRVlGynMX4Jnbs6JFWT
 nzJ/l+zfKfvsCw7VZ6LM6L3kAjr1ZXf8corN3b1zhBoUB2E2OBXx+bZ15fb/+lkxc3/+wan
IronPort-HdrOrdr: A9a23:8At+76G3yns1jZXopLqFaZHXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdrZJkh8erwW5VoMkmsj6KdgLNhdotKOTOLhILGFvAE0WKP+Vzd8mjFh5ZgPM
 RbAuJD4b/LfD5HZK/BiWHWferIguP3iZxA7t2urUuFODsaD52ImD0JbzpzfHcXeCB2Qb4CUL
 aM7MtOoDStPV4NaN6gO3UDV+/f4/XWiZPPe3c9dlIawTjLqQntxK/xEhCe0BtbeShI260e/W
 /MlBG8zrm/ssu81gTX2wbonttrcZrau5V+7f63+4gowwbX+0WVjUNaKv+/VQUO0aCSAZAR4Z
 zxSlkbToBOAjjqDxyISFPWqnXdOXAVmjLfIBaj8ATeiN28SzQgB8Vbg4VFNhPf9ko7pdl5lL
 lGxmSDqvNsfGX9dQnGlqz1vitR5z2JiGtnlfRWg21UUIMYZrMUpYsD/FlNGJNFGC7h8ogoHO
 RnEcmZvZ9tABunRmGcunMqzM2nX3w1EBvDSk8eutaN2zwTmHxi1UMXyMEWg39F/pMgTJtP4f
 jCL81T5fhzZ95Tabg4CPYKQMOxBGCISRXQMHiKKVCiD60DM2Klke+D3F0fjNvaBqDgDKFC6q
 gpfGkoxVLaIXieePFm9Kc7gSzwfA==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:30:29 +0200
Received: from localhost (dhcp567-177.laptop-wlc.uni-heidelberg.de [147.142.67.177])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 8F10330074960;
        Thu, 30 Jun 2022 13:30:28 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v2 5/6] Staging: rtl8192e: Remove unnecessary blank line
Date:   Thu, 30 Jun 2022 13:30:18 +0200
Message-Id: <b4fab2e16f35ee09d0c9e1ee1deeb22f4cc98d30.1656587827.git.f3sch.git@outlook.com>
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
     CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 3db29f6eeb89..778b6b7e0939 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -599,7 +599,6 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 			goto done;
 		}
 		*crypt = new_crypt;
-
 	}
 
 	if (ext->key_len > 0 && (*crypt)->ops->set_key &&
-- 
2.36.1

