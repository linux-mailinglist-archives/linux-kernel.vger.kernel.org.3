Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8D561933
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiF3Lai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiF3La3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:29 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72651B24
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:27 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AoCgCciL1iffxkzoFagliDJYFXlBABAQEGgUKLMIcfi?=
 =?us-ascii?q?ieCBwEBAQEBAQEBAQkvEwQBAT0BAooRJzYHDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEGAQEBAQEHBBQBASM8J4VoDYZDBjIBRhBRVxmCeAIBAQKCZAEDMK4NgQGGW?=
 =?us-ascii?q?gGBP4FlgT2JWoUggUCBEIFIgQmCLIQLgQaFbgSXWYJlCgMJBAcFRhcSTjEhA?=
 =?us-ascii?q?kULHAEIBgYHAQgBBQgoBAIBAQEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDC?=
 =?us-ascii?q?wUyDQIOBwEBDA8BAg8DAQIRAQcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHC?=
 =?us-ascii?q?AIBAgUCAgEDDwEIChwSEBQCBA0EHgkCCAECGR4sBwICBA4DIx0ICwoDDgMEA?=
 =?us-ascii?q?wEQAhgHAgEVAQUCBAgEAQMGAwgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDF?=
 =?us-ascii?q?AMFAQIIAxYHAQIhBQomCQQNAwEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGA?=
 =?us-ascii?q?gI/LxEdDQgECAQJEhwjAQIMAQQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDA?=
 =?us-ascii?q?gIDAQECARYCEAgCCCcXBxMzGQEFNxQODwEDBggZHCIHCQcFBhYDDBUnHikFB?=
 =?us-ascii?q?xESGw8EDQ0KNCAWJAEBDgUDARIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGGgECA?=
 =?us-ascii?q?yICEgsJFQIEJggJAxYGLQUBIh0ZnAwBWTRMW5NrgzerZgeDURABixCVJoVFk?=
 =?us-ascii?q?R0CkgCWc6J0hE81gTMCQIFMTSODOAlIGQ+XVIUeczsCBgsBAQMJjD2CSAEB?=
IronPort-Data: A9a23:c0tsdaAuJRvkwRVW/7Pjw5YqxClBgxIJ4kV8jS/XYbTApDgn0WQPz
 WJLWWjTPfjeMWT9eIx3Od62/RwAuZfXm9Q3OVdlrnsFo1Bi8JeaX4THci8cHM8wwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgH2eIdA970Ug5w7Bi2tYy6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pHTU2FFEYUd6EPdgKMq
 0Yv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9Iabh9tiw+3r+lD8
 4tzm5iAcj82APLlzbF1vxlwS0mSPIVD8b7DeSH5rMqSik3Lcnfhx/9jFk5wMYBwFuRfWDsfs
 6ZAdnZUNkjF3b/sqF64YrAEasALN8LrOI4Honx65SrFEPpgXJbCBqXH5NNV2D09nM8IEfu2i
 88xMGQyPESbPU0VUrsRIJtihM6KvCP9ShhnqgO/h5g7/nbxzAMkhdABN/KOJoLWH5wN9qqCn
 UrZ/X/+HhgyO9mWyD7D+XWp7sfAhy70W4I6ELy+6+5kh0CVymUPCRoQE1yhrpGRjk+4RsIaM
 FAd9SsoooA29Ve3VZ/5XhulsDiIswB0c9QLCOY6rg6M1oLT/hqdAW8HCDVGbbQOsM4wWCxv1
 VKTmd7tLSJgvafTSn+H8LqQ6zSoNkAowXQqYCYFSVNcpcTlocQzgxPDQ9JpHbS6yNH4cd3t/
 9yUhC45348Tt/A77peAo27phwKXnof3ESdgs207QVmZxg9+YYekYamh5l7a8etMIe6lor+p4
 SJsdy+2sbBmMH2dqMCeaLlcQOjxuJ5pJBWM3w43RvHN4hzwoybLQGxG3N1pDGtEWiruUR/kY
 UPevQlc/pA70JCCM/4uOdrZ5ygC56HsGNKgaVsAdMZSb517eRWIlByCiGaV1mHpyBFqjKc+f
 JeWcMqhCXwXE6shwDfeqwYhPV0DmH9WKYD7HM6TI/GbPVy2PyH9pVAtbAPmUwzBxPnYyDg5C
 v4GXydw9z1RUfflfg7c+pMJIFYBIBATXM6r9ZENKbLYeVM/RwnN7sM9J5t/I+SJeIwLyo/1E
 o2VBB4wJKfX3yWWdFvTNBiPlpu+AM8uxZ7EAcDcFQ30hSR5ON7HAFY3fZYzYqQqvPFlzOB5V
 eIEZ9TIBPlTVTPd+FwggWrV8+RfmOCQrVzVZUKNPmNgF6OMsiSTp7cIiCOzr3RUZsd23ONiy
 4CdOvTzGMNbGl8yVJmNMppCDTqZ5BAgpQ67ZGOQSvE7Rakm2NICx/DZ5hPvH/wxFA==
IronPort-HdrOrdr: A9a23:bh6cuqG8q+ApW2vQpLqFaZHXdLJyesId70hD6qkvc3Fom52j/f
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
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:30:25 +0200
Received: from localhost (dhcp567-177.laptop-wlc.uni-heidelberg.de [147.142.67.177])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id A21BE30074960;
        Thu, 30 Jun 2022 13:30:24 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v2 2/6] Staging: rtl8192e: Avoid multiple assignments
Date:   Thu, 30 Jun 2022 13:30:15 +0200
Message-Id: <ac0fbb67e93991614423dbc0f43f690c16fb10be.1656587827.git.f3sch.git@outlook.com>
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
     CHECK: multiple assignments should be avoided

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 1e420230d029..f8683b914668 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -147,7 +147,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
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

