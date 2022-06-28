Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09455C27D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiF1IbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbiF1IbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:10 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD5227152
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:09 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DBBQCEu7piffxkzoFagliDJYFXlBABAQEGgUKLL4cfi?=
 =?us-ascii?q?ieCBwEBAQEBAQEBAQkvEwQBAUCKDyc2Bw4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBBwQUAQEjPCeFaA2GQwYyAUYQUVcZgngCAQECgmQBAzCuYIEBhloBg?=
 =?us-ascii?q?T+BZYE9iVmFH4FAgRCBSIEJgiyEC4EGhW4ElyiCXgoDCQQHBUYXEk4xIQJFC?=
 =?us-ascii?q?xwBCAYGBwEIAQUIKAQCAQEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFM?=
 =?us-ascii?q?g0CDgcBAQwPAQIPAwECEQEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCA?=
 =?us-ascii?q?QIFAgIBAw8BCAocEhAUAgQNBB4JAggBAhkeLAcCAgQOAyMfCAsKAw4DBAMBE?=
 =?us-ascii?q?AIYBwIBFQEFAgQIBAEDBgMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDB?=
 =?us-ascii?q?QECCAMWBwECIQUKJgkEDQMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICP?=
 =?us-ascii?q?y8RHQ0IBAgECRIcIwECDAEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICA?=
 =?us-ascii?q?wEBAgEWAhAIAggnFwcTMxkBBTcUDg8BAwYIGRwiBwkHBQYWAwwVKR4pBQcRE?=
 =?us-ascii?q?hsPBA0NCjQgFiQBAQ4FAwESGREOBxQKUyYhFRAGASsWAwQBAwMCBhoBAgMiA?=
 =?us-ascii?q?hILCRUCBC0FASIdGZtJAQFZNExbk2uDN6thB4NREAGLEJUmhUWRHQKSAJZwo?=
 =?us-ascii?q?nGETzWBMwo4gUxNI4M4CUgZD5dUhR5zOwIGCwEBAwmMOYJIAQE?=
IronPort-Data: A9a23:j/klo65Lk+yzeuc3TKB+iwxRtKLHchMFZxGqfqrLsTDasY5as4F+v
 mNNW23VafuJY2qmLYgkPIy1oRwC657cndZlTQRv/nwyZn8b8sCt6faxdxqvZXPMcqUvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EngZqTRMFWFw03qPp8Zj2tQy2YbjU1vU0
 T/Pi5S31GGNimYc3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOgKmVgJdNWc
 s6YpF2PEsM1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2DntVsx
 89x7qXoVDomNIyP3786UUFXRnQW0a1uoNcrIFC6uM2XlxSAbn3thvVjDU07OYcV4OkxDWwmG
 f4wcWpcKErb2aTvmOr9ELQ27iggBJCD0Ic3oXpgyTzBFfs8aYvfXqmM+NlZmTc9h8xDGfzTf
 cVfZTcHgBHoOkAQYAlPUcNk9Auurn7tKRNbrlLKnIgqs0bI4FdP+YTnEdWAL7RmQu0OwhjE/
 Duel4jjOTkFNseY1TOt/Xelh+uJliT+MKodDrC39f5ChFyV23wdDwAQWVKnoP6/zEmkVLp3L
 00S5zprtrQ7+02tQfH5XgakuziAvxgBS5xcHvNSwA/W0aHUpQmYGkADUyJFb9sl8sQxQFQC0
 l6PgsOsBjF1trCRYWyS+63Srj6oPyURa2gYakc5oRAt5tDipNlqyA/JT5NjHa+5g9n/FCv/h
 TyHxMQju1kNpcQK0ri052ycumqxm5fDb01yvSLVBm3wu2uVe7WZT4Cv7FHa69NJI4CYUkSNs
 RA4dy62srlm4XalyXzlfQkdIF26z6rUbGSE3jaDC7FxqWT1ohZPaKgNuGkWGat/DioTURPEC
 KM5kSNc5ZNeOHGnd6Afj2mZVZVzl/CI+TjNfPnYY9wLXTOlbhOb8SRkaFSft10BfWApmKA7Y
 c7dbMCtSHYXCKhqyDC7Xehb3bJDKsECKYH7G8CTI/ePiOT2iJuppVEtbATmggcRt/Lsnekt2
 4wDX/ZmMj0GOAEEXgHZ8JQIMXcBJmUhCJb9pqR/L7DefFE7RD97VaGKmNvNnrCJeYwLx48kG
 VnjBidlJKbX2yyvxfiiMCgyNe22A/6TU1prZnx8VbpX55TTSd3zsvtFLsNfkUgP/uFn0uN5B
 +QDetuNGO9OViWP/TkBcp7nr+RfmOeD2mqz096eSGZkJfZIGVeWkuIIiyO1qUHi+ALr7pZky
 1BhvyuHKac+q/NKVpaKNa33ngPq5hDwWotaBiP1HzWaQ220mKACFsA7pqNfzx0kQfkb+gan6
 g==
IronPort-HdrOrdr: A9a23:BAXzd6pr49EYeXHteAmKfCYaV5rqeYIsimQD101hICF9WMqeis
 yogbA/2Rj7lTd5YgBbpTnmAsm9qBLnlKKdhLN7AV7MZniDhILFFvAA0WKm+UyYJ8SBzJ876U
 4QSdkdNDSYNzET4qjHCUuDYrAdKbK8gcWVbInlvg9QpHlRGtpdxjY8MCC9MmczaStnId4CNL
 S6j/AsmxOQPU4QacSwQl0rNtKumzWe/KiKXSI7
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:09 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 829A830011A5C;
        Tue, 28 Jun 2022 10:31:08 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 3/7] Staging: rtl8192e: Avoid multiple assignments
Date:   Tue, 28 Jun 2022 10:30:52 +0200
Message-Id: <046bce9ab52db0c5a37430fbb138870c05a48f61.1656402464.git.f3sch.git@outlook.com>
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
     CHECK: multiple assignments should be avoided

This patch does not change the logical of the assignments.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 7bd1e829ff7e..c8fc66113b41 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -160,7 +160,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 			max_rate = rate;
 	}
 	iwe.cmd = SIOCGIWRATE;
-	iwe.u.bitrate.fixed = iwe.u.bitrate.disabled = 0;
+	iwe.u.bitrate.disabled = 0;
+	iwe.u.bitrate.fixed = iwe.u.bitrate.disabled;
 	iwe.u.bitrate.value = max_rate * 500000;
 	start = iwe_stream_add_event_rsl(info, start, stop, &iwe, IW_EV_PARAM_LEN);
 	iwe.cmd = IWEVCUSTOM;
-- 
2.36.1

