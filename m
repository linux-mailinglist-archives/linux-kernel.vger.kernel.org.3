Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299055DC04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiF1Iba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245576AbiF1IbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:15 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED426540
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:14 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BdBQCEu7piffxkzoFagliDJYFXlBABAQEGjHGHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQFAig8nNQgOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhWgNhkMGJwsBRhBRVxmCeAIBAQKCZAEDMK4uMoEBhloBg?=
 =?us-ascii?q?T+BZYE9iVmFH4FAgRCBSIM1hAuBBoVuBJoGCgMJBAcFRhcSTjEhAkULHAEIB?=
 =?us-ascii?q?gYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOB?=
 =?us-ascii?q?wEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCA?=
 =?us-ascii?q?gEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx8ICwoDDgMEAwEQAhgHA?=
 =?us-ascii?q?gEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIA?=
 =?us-ascii?q?xYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdD?=
 =?us-ascii?q?QgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECA?=
 =?us-ascii?q?RYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUpHikFBxESGw8ED?=
 =?us-ascii?q?Q0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGGgECAyICEgsJF?=
 =?us-ascii?q?QIELQUBIh0Zm0oBgQ1MgV2WIKthB4NREAGLEJUmhUWRHQKSAJFAhTCicYRPN?=
 =?us-ascii?q?YEuAkWBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCYw5gkgBAQ?=
IronPort-Data: A9a23:aFfgo6LZWdLH/AfsFE+RS5UlxSXFcZb7ZxGr2PjKsXjdYENSgzxRn
 zdJDTuCPqyDZjakc91ybNzno0wG7cPUz9EyTAMd+CA2RRqmi+KcWIvDfhmsV8+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vrav67xZVF/fngqoDUUIYoAQgsA14+IMsdoUg7wbRh3NQ42YHR7z6l4
 LseneWOYDdJ5BYpagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfnZw0/Df2VhNrXSq
 9AvbF2O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQWALkD6Vje918
 owTiLqzcUQkJYzMhM1IBnG0EwkmVUFH0LrOIHzn6IqOyUyDc3btz/hqBkwsMssU946bA0kXr
 61ecmhTKEnb36TsnejTpupE36zPKOHwN4Mbt2l4wCvxFuo7TdbeRaSP5dJZ0Do0jM1UErDSa
 qL1bBI2MUuaPUUVYw1/5JQWgruYi3nZUxphsl+L+IEL7k3O7y5/z+24WDbSUofWG5kPxx7wS
 nj913v7GRYGPfSQzDOE9jSngeqntSzhVY0RFJW89/h3kFOU22ofAQEXUl39puO24ma6WtRCO
 wkP5iMhrK493EiqVcXmGRm5pmOU+BIRRbJ4HbYh4wHLxavIywGEGmwDST0HY9sj3OcyRDo3x
 hqKksnvCDhHrrKYUzSe+62SoDf0PjIaRVLufgcBRAoBu4ClvYcyyxLCT9puFKS4lNKzFTyYL
 y22QDYWoOkIhtIZ6KGBpA76pTGU5ZXSbw4pz1CCNo661T9RaImgbo2uzFHU6/dcMYqUJmVtW
 lBawqByC8hTXfmweDyxrPYlQOD1vq7aWNHIqQ4xT8F4n9i40yP7JehtDCdCyFBBHutsldXBQ
 ELStQ5V7pJJMxNGhocpMtvrU6zGIYDKHNjoULXrxQ5UfoR8cQWK5i4GWKJ992XkkUx0yOciP
 5beccutAXseA6l9w3y6So/xMIPHJAhglQs/priikXxLNIZyglbJFt/p13PVP4gEAFus+lm9z
 jqmH5LiJ+9jeOP/eDLL1oUYMEoHK3M2bbiv9ZEJLbPffFA4Rjp4YxM0/V/HU9I090iyvrmUl
 kxRpmcGmTITeFWdcVTXNCk9AF8RdcYk/SJT0dMQ0aaAgCR9Pdz2tM/zhrM9cL046eEr0Ph1U
 fQfYMScE7xJRyjY/C4eBaQRX6Q9HClHcTmmYXH/CBBhJMEIeuA80oW5FucZ3HVVU3DfWApXi
 +HI6z43trJZF1g/U56HOKn0p75z1FBE8N9Ps4LzCoE7UC3RHEJCcUQdUtdfzxkwFCj+
IronPort-HdrOrdr: A9a23:TfYeXaDsQMAJEkrlHemA55DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I9uruBEDtewK6yXcx2/h2AV7AZmfbUQmTQL2KhLGKq1aMJ8S9zJ856U
 4KSchD4bPLfDpHZIrBgTWQIpIJ/OSntJqJvI7lpUuEIWxRGtpd0zs=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:14 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 6C582300084F1;
        Tue, 28 Jun 2022 10:31:13 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 6/7] Staging: rtl8192e: Remove unnecessary blank line
Date:   Tue, 28 Jun 2022 10:30:55 +0200
Message-Id: <601b61a92ee4836314cd79fc9bfd69d48d94b23b.1656402464.git.f3sch.git@outlook.com>
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

This addresses an issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 976d81f0d7a6..9945f3f136d1 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -612,7 +612,6 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 			goto done;
 		}
 		*crypt = new_crypt;
-
 	}
 
 	if (ext->key_len > 0 && (*crypt)->ops->set_key &&
-- 
2.36.1

