Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28607562FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiGAJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiGAJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:07 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1470E76
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:05 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AmBABPvL5iffxkzoFagliDJYFXlBADBoFCizCHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQE9AQKKESc0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBBwQUAQEjPCeFaA2GQwYnCwFGEFFXGYJ4AgEBAoJkAQMwricygQGGW?=
 =?us-ascii?q?gGBP4FlgT2JXIUggUCBEIFIgzWFEYVuBJpPCgMJBAcFRhcSTjEhAkULHAEIB?=
 =?us-ascii?q?gYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOB?=
 =?us-ascii?q?wEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCA?=
 =?us-ascii?q?gEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx0ICwoDDgMEAwEQAhgHA?=
 =?us-ascii?q?gEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIA?=
 =?us-ascii?q?xYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdD?=
 =?us-ascii?q?QgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECA?=
 =?us-ascii?q?RYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUnHikFBxESGw8ED?=
 =?us-ascii?q?Q0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGGgECAyICEAsJF?=
 =?us-ascii?q?QIEIQgJAxYGIgscBQEiHRmcEQcBgQ1OgX2VfqtmB4NREAGLEJUmhUWRHQKSA?=
 =?us-ascii?q?JZzonSETzWBLEmBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCY8FAQE?=
IronPort-Data: A9a23:ek5zY6Dz58XgORVW/7Hjw5YqxClBgxIJ4kV8jS/XYbTApDt0gmcAz
 mAaX2HUM67cM2Ohe41xPYu0809U7ZeEytZjOVdlrnsFo1Bi8JeaX4THci8cHM8wwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgH2eIdA970Ug5w7Fh29Yx6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pHTU2FFEYUd6EPdgKMq
 0Yv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9IVdFxK1RaWxexg5
 9ZJ8p2MTBl3PbHTzbF1vxlwS0mSPIVD8b7DeSH5rMqSik3Lcnfhx/9jFk5wMYBwFuRfWDsfs
 6ZAdnZUNkjF3b/sqF64YrAEasALN8LrOI4Honx65SrFEPpgXJbCBqXH5NNV2D09nM8IEfu2i
 88xMGcwM0maOUEUUrsRIKIlmun1pynCSD5dsUiF+rgw00bIwQMkhdABN/KOJoLWH5wN9qqCn
 UrZ/X/+HhgyO9mWyD7D+XWp7sfAhy70W4I6ELy+6+5kh0CVymUPCRoQE1yhrpGRjk+4RsIaM
 FAd9SsoooA29Ve3VZ/5XhulsDiIswB0c9QLCOY6rg6M1oLT/hqdAW8HCDVGbbQOsM4wWCxv1
 VKTmd7tLSJgvafTSn+H8LqQ6zSoNkAowXQqYCYFSVNcpcTlocQzgxPDQ9JpHbS6yNH4cd3t/
 9yUhCEjnKhNrtFR67SU/lSAgg6puMbKUhFgs207QVmZxg9+YYekYamh5l7a8etMIe6lor+p4
 Sdsdy+2sbBmMH2dqMCeaLlcQOjxuJ5pJBWM3w43RvHN4hzwoybLQGxG3N1pDGtEWiruUR/kY
 UPevQlc/pA70JCCM/4uOdrZ5ygC56HsGNKgaVsAdMZSb517eRWIlByCiGaV1mHpyBFqjKc+f
 JeWcMqhCXwXE6shwDfeqwYhPV0DmHBWKYD7HM6TI/GbPVy2Py79pVAtbAPmUwzBxPnYyDg5C
 v4GXydw9z1RUfflfg7c+pMJIFYBIBATXM6r9ZIOLb7YflE9RAnN7sM9J5t/IOSJeIwLy4/1E
 o2VBB4wJKfX3yWWdFvTNBiPlpu+AM8kxZ7EAcDcFQ30hSR5ON7HAFY3fZYzYqQqvPFlzOB5V
 eIEZ9TIBPlTVTPd+FwggWrV8+RfmOCQrVzVZUKNPmNgF6OMsiSTp7cIiCOzr3RUZsd23ONiy
 4CdOvTzEcJcHFk8XZm+hTDG5wrZgEXxUdlaByPgSuS/sm22mGS2A0QdVsMKHvw=
IronPort-HdrOrdr: A9a23:8v1SC66rrnpy046vcAPXwNXXdLJyesId70hD6qkXc3Jom62j+/
 xG+c5x6faaskdyZJhNo7C90cq7Lk80i6QFhLX5VI3KNGOKhILCFuBfBOXZsl7dJxE=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:25:05 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 920F2300719FC;
        Fri,  1 Jul 2022 11:25:04 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 4/6] Staging: rtl8192e: Added braces around else
Date:   Fri,  1 Jul 2022 11:24:52 +0200
Message-Id: <651f51d9f92e8a445ceaf9f2073f16dd10458a74.1656667089.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656667089.git.f3sch.git@outlook.com>
References: <cover.1656667089.git.f3sch.git@outlook.com>
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
index db076e819993..b949e7234150 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -304,8 +304,9 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 			netdev_dbg(ieee->dev,
 				   "Disabling encryption on key %d.\n", key);
 			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
-		} else
+		} else {
 			netdev_dbg(ieee->dev, "Disabling encryption.\n");
+		}
 
 		/* Check all the keys to see if any are still configured,
 		 * and if no key index was provided, de-init them all
@@ -724,8 +725,9 @@ int rtllib_wx_set_auth(struct rtllib_device *ieee,
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

