Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B05562FE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiGAJ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiGAJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:05 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47724F2E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:03 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2A5BQBPvL5iffxkzoFagliDJYFXlBADBoFCizCHH4wuA?=
 =?us-ascii?q?QEBAQEBAQEBCS8TBAEBQIoRJzcGDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4VoDYZDBjIBRhBRVxmCeAIBAQKCZAEDMK5ZgQGGWgGBP4Flg?=
 =?us-ascii?q?T6JW4UggUCBEIFIgQmCLIQLgQaFbgSXaIJnCgMJBAcFRhcSTjEhAkULHAEIB?=
 =?us-ascii?q?gYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOB?=
 =?us-ascii?q?wEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCA?=
 =?us-ascii?q?gEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx0ICwoDDgMEAwEQAhgHA?=
 =?us-ascii?q?gEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIA?=
 =?us-ascii?q?xYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdD?=
 =?us-ascii?q?QgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECA?=
 =?us-ascii?q?RYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUnHikFBxESGw8ED?=
 =?us-ascii?q?Q0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGGgECAyICEAsJF?=
 =?us-ascii?q?QIEIQgJAxYGIgscBQEiHRmcGAFZNExbk2uDN6tmB4NREAGLEJUmhUWRHQKSA?=
 =?us-ascii?q?JZzonSETzWBQjOBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCYw9gkgBAQ?=
IronPort-Data: A9a23:OcpnLK5xlzWZDWutNNglfAxRtKDHchMFZxGqfqrLsTDasY5as4F+v
 mcZWjqHOP6IMTTzKo8naIyw9xhUvZPRnNZqHgFv/iE9Zn8b8sCt6faxdxqvZXPMcqUvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EngZqTRMFWFw03qPp8Zj2tQy2YfhWlvU0
 T/Pi5S31GGNimYc3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOgKmVgJdNWc
 s6YpF2PEsM1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2rwc9K9
 Y9upKboCi4rOL3Jx8c7djxhRnQW0a1uoNcrIFC6uM2XlxSAbn3thvVjDU07OYcV4OkxDWwmG
 f4wcWpcKErb2aTvmOr9ELQ27iggBJCD0Ic3oXpgyTzBFfs8aYvfXqmM+NlZmTc9h8xDGfzTf
 cVfZTcHgBHoOkAQZQpNUslk9AuurlTVUQZds0ycnKU241j6kAUv3pLQG+OAL7RmQu0OwhjE/
 Duel4jjOTkFNseY1TOt/Xelh+uJliT+MKodDrC39f5ChFyV23wdDwAQWVKnoP6/zEmkVLp3L
 00S5zprtrQ7+02tQfH5XgakuziAvxgBS5xcHvNSwA/W0aHUpQmYGkADUyJFb9sl8sQxQFQC0
 l6PgsOsBjF1trCRYWyS+63Srj6oPyURa2gYakc5oRAt5tDipNlqyA/JT5NjHa+5g9n/FCv/h
 TyHxMQju1kNpexVyJ6Gp3PWuWrvj5rPXgtqxSPye1vwu2uVe7WZT4Cv7FHa69NJI4CYUkSNs
 RA4dy62sb9m4XalyXzlfQkdIF26z6rUbGSE3jaDC7FxqWT1ohZPaKgNuGkWGat/DioTURPEC
 KM5kSNc5ZNeOHGnd6Afj2mZVZVzl/CI+TjNfPnYY9wLXTOlbhOb8SRkaFSft10BfWApmKA7Y
 c7dbMCtSHYXCKhqyDC7Xehb3bJDKsECKYH7G8CTI/ePiOT2iJuppVEtawvmggcRsPvsnekt2
 4wDX/ZmMj0GOAEEXgHZ8JQIMXcBJmUhCJb9pqR/L7DefFQ/QzF6V6SKndvNnrCJeYwLzY8kG
 VnjBydlJKbX2yyvxfiiMCgyNe22A/6TU1pqYHV3VbpX55TTSd3zsvtFLsNfkUgP/uFn0uN5B
 +QDetuNGO9OViWP/TkBcp7nr+RfmOeD2mqz096eSGZkJfZIGVeWkuIIiyO1qUHi+ALr7pZky
 1BhvyuHKac+q/NKXJ6JM6/xngzZULp0sLsaYnYk6+J7IC3EmLWG4QSq5hPrC6ng8Sn++wY=
IronPort-HdrOrdr: A9a23:ezhoN6Ni1UGGwsBcTtyjsMiBIKoaSvp037BN7S5MoH1uHvBw8v
 rEoB11726XtN98YhEdcLO7V5VoP0mskKKdiLN5Vd3OYOCMggqVxe9ZnOjf/wE=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:25:01 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 4F140300719FC;
        Fri,  1 Jul 2022 11:25:01 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 2/6] Staging: rtl8192e: Avoid multiple assignments
Date:   Fri,  1 Jul 2022 11:24:50 +0200
Message-Id: <899a1010643a05668465069951518e5dcab9c77e.1656667089.git.f3sch.git@outlook.com>
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

This addresses an issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: multiple assignments should be avoided

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index b7f19b38b0e1..121bf939c6a4 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -149,7 +149,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 			max_rate = rate;
 	}
 	iwe.cmd = SIOCGIWRATE;
-	iwe.u.bitrate.fixed = iwe.u.bitrate.disabled = 0;
+	iwe.u.bitrate.disabled = 0;
+	iwe.u.bitrate.fixed = 0;
 	iwe.u.bitrate.value = max_rate * 500000;
 	start = iwe_stream_add_event_rsl(info, start, stop, &iwe, IW_EV_PARAM_LEN);
 	iwe.cmd = IWEVCUSTOM;
-- 
2.36.1

