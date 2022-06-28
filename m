Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4855E141
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbiF1Ib1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245478AbiF1IbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:13 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B826540
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:12 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BlBACEu7piffxkzoFagliDJYFXlBABAQEGgUKLL4cfi?=
 =?us-ascii?q?ieCBwEBAQEBAQEBAQkvEwQBAUCKDyc0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBBwQUAQEjPCeFaA2GQwYnCwFGEFFXGYJ4AgEBAoJkAQMwri4ygQGGW?=
 =?us-ascii?q?gGBP4FlgT2JWYUfgUCBEIFIgzWFEYVuBJoGCgMJBAcFRhcSTjEhAkULHAEIB?=
 =?us-ascii?q?gYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOB?=
 =?us-ascii?q?wEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCA?=
 =?us-ascii?q?gEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx8ICwoDDgMEAwEQAhgHA?=
 =?us-ascii?q?gEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIA?=
 =?us-ascii?q?xYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdD?=
 =?us-ascii?q?QgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECA?=
 =?us-ascii?q?RYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUpHikFBxESGw8ED?=
 =?us-ascii?q?Q0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGGgECAyICEgsJF?=
 =?us-ascii?q?QIELQUBIh0Zm0MHAYENToF9lX6rYQeDURABixCVJoVFkR0CkgCWcKJxhE81g?=
 =?us-ascii?q?SxJgUxNI4M4CUgZD5dUhR5zOwIGCwEBAwmPAQEB?=
IronPort-Data: A9a23:ENeQ46IZ+nGNfaIjFE+RS5UlxSXFcZb7ZxGr2PjKsXjdYENS1zQAn
 WAWXTzUbKqOZGOgft90Otu39koGvJSAy9VkSAUd+CA2RRqmi+KcWIvDfhmsV8+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vrav67xZVF/fngqoDUUIYoAQgsA14+IMsdoUg7wbRh3NQ42YHR7z6l4
 LseneWOYDdJ5BYpagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfnZw0/Df2VhNrXSq
 9AvbF2O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQVx10GmWxfc28
 txQl5qNZSotYqHRyetIBnG0EwkmVUFH0LrOIHzn6IqOyUyDc3btz/hqBkwsMssU946bA0kXr
 61ecmhTKEnb36TsnejTpupE36zPKOHwN4Mbt2l4wCvxFuo7TdbeRaSP5dJZ0Do0jM1UErDSa
 qL1bBI2MUuaPUUVYgd/5JQWxfalwVSuXixjhG25j4MG0lHz3lRb6e24WDbSUofWG5kPxx7wS
 nj913v7GRYGPfSQzDOE9jSngeqntSzhVY0RFJW89/h3kFOU22ofAQEXUl39puO24ma6WtRCO
 wkP5iMhrK493EiqVcXmGRm5pmOU+BIRRbJ4HbYh4wHLxavIywGEGmwDST0HY9sj3OcyRDo3x
 hqKksnvCDhHrrKYUzSe+62SoDf0PjIaRVLufgcBRAoBu4ClvYcyyxLCT9puFKS4lNKzFTyYL
 y22QDYWnJdI0dFR8OKB9E3lhQ+Ai5yVQhNk6VCCNo661T9RaImgbo2uzFHU6/dcMYqUJmVtW
 lBawqByC8hTXfmweDyxrPYlQOD1vq7aWNHIqQ4xT8F4n9i40yP7JehtDCdCyFBBHutsldXBQ
 ELStQ5V7pJJMxNGhocpMtvrU6zGIYDKHNjoULXrxQ5UfoR8cQWK5i4GWKJ992XkkUx0yOciP
 5beccutAXseA6l9w3y6So/xMIPHJAhglQs/priikXxLNIZyglbJFt/p13PVP4gEAFus+lm9z
 jqmH5LiJ+9jeOP/eDLL1oUYMEoHK3M2bbiv9ZEJLbPffFA4Rjp4YxM0/V/HU9I090iyvrmUl
 kxRpmcGmTITeFWdcVTXNCk9AF8RdcYk/SJT0dMQ0aaAgCR9Pdz2tM/zhrM9cL046eEr0Ph1U
 fQfYMScE7xJRyjY/C4eBaQRX6Q9HClHcTmmYXH/CBBhJMEIeuA80oW5FucZ3HVVU3DfWApXi
 +HI6z43trJZF1g/U56HOKn0p75z1FBE8N9Ps4LzCoE7UC3RHEJCckQdUtdfzxkwFCj+
IronPort-HdrOrdr: A9a23:3gwbhaGE4RKpk3BtpLqExMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcL+7V5VoLUmskqKdpLNhW4tKPzOJhILLFu1fBOLZqlWKdhEWtNQtsJ
 uIGJIfNDSfNykZsS+32miFOudl6OW70eSTpd629R1QpW0GUdAa0ztE
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:12 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id C26E1300084F1;
        Tue, 28 Jun 2022 10:31:11 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 5/7] Staging: rtl8192e: Added braces around else
Date:   Tue, 28 Jun 2022 10:30:54 +0200
Message-Id: <8f84f68eaf229f50a89a6d61c084cfd83a815639.1656402464.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656402464.git.f3sch.git@outlook.com>
References: <cover.1656402464.git.f3sch.git@outlook.com>
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

This addresses two issues raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: braces {} should be used on all arms of this statement
     CHECK: Unbalanced braces around else statement

The coding style rule with not using unnecessary braces around if/else
does not apply if only one branch is a single statement.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index f1a497ff4aa6..976d81f0d7a6 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -315,8 +315,9 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 			netdev_dbg(ieee->dev,
 				   "Disabling encryption on key %d.\n", key);
 			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
-		} else
+		} else {
 			netdev_dbg(ieee->dev, "Disabling encryption.\n");
+		}
 
 		/* Check all the keys to see if any are still configured,
 		 * and if no key index was provided, de-init them all
@@ -735,8 +736,9 @@ int rtllib_wx_set_auth(struct rtllib_device *ieee,
 		} else if (data->value & IW_AUTH_ALG_LEAP) {
 			ieee->open_wep = 1;
 			ieee->auth_mode = 2;
-		} else
+		} else {
 			return -EINVAL;
+		}
 		break;
 
 	case IW_AUTH_WPA_ENABLED:
-- 
2.36.1

