Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAD562FEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiGAJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiGAJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:03 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DDE735A7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:01 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DbBADZvL5iffxkzoFaHgEBCxIMggQLgyWBV5QQAwaBQ?=
 =?us-ascii?q?oswhnKKVIIHAQEBAQEBAQEBCS8TBAEBQIoRJzYHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEGAQEBAQEHBBQBASM8J4VoDYZDBicLAUYQUVcZgngCAQECgmQBAzCuK?=
 =?us-ascii?q?DKBAYZaAYE/gWWBPYlchSCBQIEQgUiBCYIshRGFbgSXaIJnCgMJBAcFRhcST?=
 =?us-ascii?q?jEhAkULHAEIBgYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobB?=
 =?us-ascii?q?wcDCwUyDQIOBwEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDF?=
 =?us-ascii?q?gkHCAIBAgUCAgEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx0ICwoDD?=
 =?us-ascii?q?gMEAwEQAhgHAgEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDG?=
 =?us-ascii?q?AgDFAMFAQIIAxYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCB?=
 =?us-ascii?q?hUGAgI/LxEdDQgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCB?=
 =?us-ascii?q?gQDAgIDAQECARYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUnH?=
 =?us-ascii?q?ikFBxESGw8EDQ0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGG?=
 =?us-ascii?q?gECAyICEAsJFQIEIQgJAxYGIgscBQEiHRmbJXMBehNMgWSTDIMNixOgUweDU?=
 =?us-ascii?q?RABixCVJoN1gVCKc4YqApIALZZGonSETzWBMwY8gUxNI4M4CUgZD5dUhR5zO?=
 =?us-ascii?q?wIGCwEBAwmPBQEB?=
IronPort-Data: A9a23:ZHoxDKDHtTwVHhVW/7Hjw5YqxClBgxIJ4kV8jS/XYbTApDwj3jwCm
 DMXWWnUMvbbYjH9co8kaIq38U0G7JeEmtYwOVdlrnsFo1Bi8JeaX4THci8cHM8wwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgH2eIdA970Ug5w7Fh29Yx6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pHTU2FFEYUd6EPdgKMq
 0Yv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9IsZUxyyG2GpOp95
 /9sjaKKbD8pPrflzbF1vxlwS0mSPIVD8b7DeSH5rMqSik3Lcnfhx/9jFk5wMYBwFuRfWDsfs
 6ZAdnZUNkjF3b/sqF64YrAEasALN8LrOI4Honx65SrFEPpgXJbCBqXH5NNV2D09nM8IEfu2i
 88xMGQxNE2YPUcQUrsRIJsRh7aLlkblShJFtm+ygJsaw1XPzyUkhdABN/KOJoLWH5wN9qqCn
 UrZ/X/+HhgyO9mWyD7D+XWp7sfAhy70W4I6ELy+6+5kh0CVymUPCRoQE1yhrpGRjk+4RsIaM
 FAd9SsoooA29Ve3VZ/5XhulsDiIswB0c9QLCOY6rg6M1oLT/hqdAW8HCDVGbbQOsM4wWCxv1
 VKTmd7tLSJgvafTSn+H8LqQ6zSoNkAowXQqYCYFSVNcpcTlocQzgxPDQ9JpHbS6yNH4cd3t/
 9yUhBgyjJBQ1cEw7amU13H/vQiJnpjJVCdgs207QVmZxg9+YYekYamh5l7a8etMIe6lor+p4
 Sdsdy+2sbBmMH2dqMCeaLlcQOjxuJ5pJBWM3w43RvHN4hzwoybLQGxG3N1pDGtEWiruUR/kY
 UPevQlc/pA70JCCM/4uOdrZ5ygC56HsGNKgaVsAdMZSb517eRWIlByCiGaV1mHpyBFqjKc+f
 JeWcMqhCXwXE6shwDfeqwYhPV0DmHBWKYD7HM6TI/GbPVy2Py79pVAtbAPmUwzBxPnYyDg5C
 v4GXydw9z1RUfflfg7c+pMJIFYBIBATXM6r9ZIOLb7YflE9RAnN7sM9J5t/IOSJeIwLy4/1E
 o2VBB4wJKfX3yWWdFvTNBiPlpu+AM8kxZ7EAcDcFQ30hSR5ON7HAFY3fZYzYqQqvPFlzOB5V
 eIEZ9TIBPlTVTPd+FwggWrV8+RfmOCQrVzVZUKNPmNgF6OMsiSTp7cIiCOzr3RUZsd23ONiy
 4CdOvTzEcJcHFk8XZm+hTDG5wrZgEXxUdlaByPgSuS/sm22mGS2A0QdVsMKHvw=
IronPort-HdrOrdr: A9a23:+HF47a9Ypiiqp1+Q2BJuk+DPI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HLoB1173HJYVoqMk3I3OrwW5VoIkmskKKdn7NxAV7KZmCP01dAbrsSj7cKqAeOJ8SRzINgPN
 9bE5RDNA==
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:25:00 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id BF802300719FC;
        Fri,  1 Jul 2022 11:24:59 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 1/6] Staging: rtl8192e: Refactored rtllib_modes
Date:   Fri,  1 Jul 2022 11:24:49 +0200
Message-Id: <4dbc4939e88a2c94f1819b4b0cc2c81dc332710b.1656667089.git.f3sch.git@outlook.com>
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
 drivers/staging/rtl8192e/rtllib_wx.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index cf9a240924f2..b7f19b38b0e1 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -17,17 +17,9 @@
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
+
+static const char * const rtllib_modes[] = {
+	"a", "b", "g", "?", "N-24G", "N-5G"
 };
 
 #define MAX_CUSTOM_LEN 64
@@ -72,10 +64,9 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
-		if (network->mode&(1<<i)) {
-			sprintf(pname, rtllib_modes[i].mode_string,
-				rtllib_modes[i].mode_size);
-			pname += rtllib_modes[i].mode_size;
+		if (network->mode & BIT(i)) {
+			strcpy(pname, rtllib_modes[i]);
+			pname += strlen(rtllib_modes[i]);
 		}
 	}
 	*pname = '\0';
-- 
2.36.1

