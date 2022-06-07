Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3566B53F36D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiFGBkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiFGBkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:40:03 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 18:40:01 PDT
Received: from rpt-glb-asav6.external.tpg.com.au (rpt-glb-asav6.external.tpg.com.au [60.241.0.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 423AF590AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:40:00 -0700 (PDT)
IronPort-SDR: 6uKlUIOSJ/80kgzO4A1+7s97jzF09i4WnHGmrKXvyybFVLQiJKm5QwK7XqeGYW64ASb1xKQ0Tx
 asysNJHPvIQ05qIM9BhLnalq9LC/22jeeJ2lZkgkO8lJ5KCRasV97EO2btks2n4lEYJ3rz3//G
 LhOBrETtUnwU0YekWrBvWmjqHmT86nEIzSAHoGPHZ+p/hf23o2KW/5Vqx81icy3gJDTCeh3xkQ
 YlnDjdDfeA6Fm8Sqma2OV1qwUqvnlSc3h5fIwIssK7QaVVqTdySecQh7Zp/7wyfoVl0iXZZK6I
 a7c=
X-Ironport-Abuse: host=210-185-107-108.tpgi.com.au, ip=210.185.107.108, date=06/07/22 11:38:57
X-SMTP-MATCH: 0
X-IPAS-Result: =?us-ascii?q?A2GUAwCtq55i/2xrudJagRKBRoR6lVyDFodoLwKROoF8C?=
 =?us-ascii?q?wEDAQEBAQFLBAEBPAGERYVKJjQJDgECBAEBAQEDAgMBAQEBBQEBAQUBAQEBA?=
 =?us-ascii?q?QEGAwEBAQKBGIUvRoI1IoN3NgEpHSZcAk2CfYJkAQOtfAUXgQGEbYFtChkoD?=
 =?us-ascii?q?WcDgWKBPYRNgUmDMYdsgRWDaIEFAYEagnGFbgSNRolZBAUKGgMDAhAUAwkEB?=
 =?us-ascii?q?wVRAgIBAQsCBgYEBgMBAQYDCQIEAhICAgQHGAoSCBQDAgUBAiAFAQcFAQQDE?=
 =?us-ascii?q?gYMEQEIBgYBBAIKAQICBQUMAwERAQQCBgIEBAQYFAQCBAcGAgkJBwUWCwQKA?=
 =?us-ascii?q?hYBChICBgwIAgICAgIEFQcBDQUCAgQBDgIHBgMLAgMFBwMDBAcCCgMDDA4BA?=
 =?us-ascii?q?wEHAQQFAw0EAQEGAgEKAwUKAgECAgEMAQEBBgICCAEBAgIBAwYCAQQCBwECB?=
 =?us-ascii?q?QMCAwgDAgMDAgIBAQQJCAIDBAMEAgMBBQEBBQMCBQEDAwIBAwMDAgEEAwYJC?=
 =?us-ascii?q?gQIAQQEAQEBEQIHBwIGAwMCAgICBQECDQECAQIEAwgGAgMUAQIEAQoBBQIDC?=
 =?us-ascii?q?QIHAwEBAgcFCgIHBQIHAgIEAQUDDQEDBQIDAQEDAwIEAQIBAwMJAQMCAwMCA?=
 =?us-ascii?q?gICBQIDAgICCQMGAQcDAgEBBAUBBAMBAgoEBAMEAgQCBwIHAgQHAgEEBgMHB?=
 =?us-ascii?q?gQCAQcBAQQKBAMDAwEBBwECBQICAwIGEgYHAgQBAwQECgICDAIBBgEBAgEBA?=
 =?us-ascii?q?QECAwIHBQ4BAQEDAgMGAgUCAgEBAwgIAwIBBAEFAwEEBQMHAgEFCQIJAwMJA?=
 =?us-ascii?q?wEBBQEDAQkDAwMCCQMBAgICCwQDCAMDAgMEAgICAgEDAgcFCAQBBAoCAQECA?=
 =?us-ascii?q?QICBgIBAxoBAgMFAgIJDAEEAgIDAQMBAQIIBAkEAgMEAgEBAwIBAgIBBQIDD?=
 =?us-ascii?q?QYBAQEBAgMDAQIDAQEGBwIIAhccFQEDAwIBAgICBQICAQIDAgINAQEBBAIBA?=
 =?us-ascii?q?gECBgEDAQICAwEDAQICBgIMAwgCBwEFAwMCAgMBAQUQBQIBBAIBAgYFAgEBA?=
 =?us-ascii?q?QQBAwQECAICAQMDAg4CBAEEAQIBASMDBAIDAQMXAQIBAgMDAwQGBwYCAQITA?=
 =?us-ascii?q?QIBAQEFAQIBAQQCBAQBBgoDAgICAQUDAwUBAQIDAgEBAQcMAgICEwIECgkDA?=
 =?us-ascii?q?QYBAwcFAQYBFAMCBAICAQICAgoCAQECAgEDAgkCAQIBBQgBGwMBAQ8kAQECA?=
 =?us-ascii?q?gECAgMEBwIBBAYDDQICAQEBBQYNAwIDCAwCCQMCAgMFAwICBAECBAwKAQICA?=
 =?us-ascii?q?QICBAUFAgECAQgDAQUKAwUJBQIEAQICAQMIAQQDCwYCBgIBAgMFAwMCAQYEB?=
 =?us-ascii?q?QIDAQIBAQMBBAEDBAYBAQIDAgIBCAICAQEDAwQBAgECBAICAggCAwIBBAIBA?=
 =?us-ascii?q?gMBAQEEAgICAgIEAwgDAgEIBwUBAgQBAgEEAwICAQIHAQICAQkCAQMDBQMEA?=
 =?us-ascii?q?QMFAw8DBQMBAwMCBQgCBgYGIQEGF02YPRIQL0+Bbw6BfAEBlEyqZ0AhCQEGA?=
 =?us-ascii?q?liBSnQVJZoThWMaMahbLZY8kQeREU2FA4EsghZNI4EBbYFKURkPjjeOS2M7A?=
 =?us-ascii?q?gYLAQEDCY90AQE?=
IronPort-PHdr: A9a23:3SdS2RWhJU4g/xdoC7wBmUF2l3vV8KyxUjF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB96dsqoYwLaG+4nbGkU4qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtGiTanfL9+M
 Bq7oQreu8QVnIBvNrs/xhzVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3Q
 rJEAjsmNXs15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRTiv6
 bpgRRn1gykFKjE56nnahMxugq9FvRyvqR9xzYnbb4+aL/dyYqDQcMkGSWdbQspdSypMCZ68Y
 YsVCOoBOP5VoY36p1sIsBCwAhOjBezhyzBWgn/22bAx3uMjEQHDxgMhENwPv2rQrNXxOqofU
 /u4zKbNzTrZbvNW3S3x55TPchAkuPyBW697fsXNx0c1DQzFkkmQppL/PzOTzukAs2iV4uR9W
 O+shWApqw58rzqxysojl4TFmJwYx1TE+Chn3Is4JdK1RkFmbdCrEZZcqzyWOoV5TM0tQmxmt
 yU3x7sbspC4ZCgH0IorywPDZ/CdboSF4RLuWPyMLTtkhn9pYq+ziwqx/EWm1+byTNO70ExQo
 SpAitTMs3cN2AHN5cWfUft9+1uh2S6I1wDO9uFIOUA0mrTfK54m2rMwlJ8Tvl7MHy74hkr2i
 KuWel849eiv7uTrerTmppmCOI9okgzyLLkiltClDeglMQUDX3KX9fmg2LDh50H1XalGg/4un
 qncqp/aJMAbpqCjAw9S14Yu8xS/DzK839UXk3gIMlZFeBaJgoXrIFzOL/X4Au2+g1Soijtk2
 /fGPrj5DpXLNXfMiK3hcqpl605A1AozyshS6pJMBrEbPP3zQlPxtMDfDhIhNwy0wuDnCMhy1
 48HWmKAHLWZMKXMvl+M/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH+gEvR8P0qZe
 WbsgssGEWoSowUxVvLqh0OHUTNIenm9Rbw86S8+CIKiCofDSJytjKaH3CilAp1afnpGBUyUE
 Xf0a4WEXO8BZziOIsB/lDwLT6KhS5M62BGtqgD60bxnIfTQ+iECspLjztd16/XJlR4u7Tx0E
 9id02aVQm5onGMHWSQ53LhioUNm0VqD3q14jOZZFdxX/f9GTgA6NZvEw+xgF9/yQh7BfsuOS
 Fu+QNWmBCs+T90/wtAQZ0Z9H9uvgxLY0iqlBr8ajb2LBJgu/q3A2HjxIpU193GT0KgnkkljQ
 cZVM2CirrBw+hKVBIPTlUid0aGwevcyxinIoUWEyyKrtVFHXQp0GfHHWHkPeUbSqY+mzkzHR
 r6qT78gN10Smoa5NqJWZ4ix3h19T/D5NYGGC18=
IronPort-Data: A9a23:Ss0CQ684sqyz0xeStr35DrUD/H+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 jBLUWyHaf2JY2GjeY9wO461pE8FupbQmN5gQQNprnsxFiIbosfsO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zuIQUBUjclkfJKlYAL/En03FFYMpBsJ00o5wbZn2tAw27BVPivU0
 T/Mi52HULOa82MsWo4kw/rrRMRH5amaVJsw5zTSVNgT1LPsvyB94KE3fMldG0DFrrx8RYZWc
 QphIIaRpQs19z91Yj+suuqgKBVSGtY+NyDW4pZdc/DKbhSvOkXee0v0XRYRQR4/ttmHozx+4
 NZXp7m9by0VAp3RtrtMQkYDESNdIbITrdcrIVDn2SCS50/DemvzzvFqSkoxOOX0+M4tWDkIr
 KxFbmlVMVba37LeLLGTE4GAguwhKcD7I44bvio/5T7cBPciB5vERs0m4PcBh2lo1pERR6+2i
 8wxUTdAbT2aWQV0BU4VKINm29mliCPHbGgNwL6Sje9ti4TJ9yR10b7wIJ/Wd8aMSMF9gEmVv
 CTF8n7/DxVcM8aQoRKJ+2yhg8fDlD32XYYVGqH+8PN26HWa2mEVAQcKfVi2u/+0jgi5Qd03A
 0cW9yA2sKIa+0miT927VBq9yFaGuxcMRNdUF7ZlwA6Iw6vQpQ2eAwA5oiVpMoV+8ZZmGHlzj
 gDMxou5QyB3v7zTQnWYsL6Jxd+vBRUowaY5TXdsZWM4DxPL+unfUjqnoh1f/GJZQzE79fwcA
 9xHkcTmu4gusA==
IronPort-HdrOrdr: A9a23:n5V/pK4AWsR3tTUGvQPXwNHXdLJyesId70hD6qm+c3Fom6uj5q
 OTdZsguiMc5Ax7ZJhCo7C90de7L080nKQdibX5Vo3PYOCJggGVxflZjLff/w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,282,1647262800"; 
   d="scan'208";a="136089721"
Received: from 210-185-107-108.tpgi.com.au (HELO jmaxwell.com) ([210.185.107.108])
  by rpt-glb-asav6.external.tpg.com.au with ESMTP; 07 Jun 2022 11:38:57 +1000
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, atenart@kernel.org, cjebpub@gmail.com,
        jmaxwell37@gmail.com
Subject: [PATCH net-next] net: bpf: fix request_sock leak in filter.c
Date:   Tue,  7 Jun 2022 11:38:44 +1000
Message-Id: <20220607013844.213446-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer reported a request_socket leak in a Calico cloud environment. We 
found that a BPF program was doing a socket lookup with takes a refcnt on 
the socket and that it was finding the request_socket but returning the parent 
LISTEN socket via sk_to_full_sk() without decrementing the child request socket 
1st, resulting in request_sock slab object leak. This patch retains the 
existing behaviour of returning full socks to the caller but it also decrements
the child request_socket if one is present before doing so to prevent the leak.

Thanks to Curtis Taylor for all the help in diagnosing and testing this. And 
thanks to Antoine Tenart for the reproducer and patch input.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
Tested-by: Curtis Taylor <cjebpub@gmail.com>
Co-developed-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/filter.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5af58eb48587..f7d74acfef5a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6514,13 +6514,14 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 {
 	struct sock *sk = __bpf_skc_lookup(skb, tuple, len, caller_net,
 					   ifindex, proto, netns_id, flags);
+	struct sock *sk1 = sk;
 
 	if (sk) {
 		sk = sk_to_full_sk(sk);
-		if (!sk_fullsock(sk)) {
-			sock_gen_put(sk);
+		if (!sk_fullsock(sk1)) 
+			sock_gen_put(sk1);
+		if (!sk_fullsock(sk))
 			return NULL;
-		}
 	}
 
 	return sk;
@@ -6551,13 +6552,14 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 {
 	struct sock *sk = bpf_skc_lookup(skb, tuple, len, proto, netns_id,
 					 flags);
+	struct sock *sk1 = sk;
 
 	if (sk) {
 		sk = sk_to_full_sk(sk);
-		if (!sk_fullsock(sk)) {
-			sock_gen_put(sk);
+		if (!sk_fullsock(sk1))
+			sock_gen_put(sk1);
+		if (!sk_fullsock(sk))
 			return NULL;
-		}
 	}
 
 	return sk;
-- 
2.31.1

