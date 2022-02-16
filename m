Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410E4B8E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiBPQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:51:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiBPQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:51:01 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2011.outbound.protection.outlook.com [40.92.98.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18AB29058D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeefnXyZangQRuJoe2ljUqtORahjMh9DWxOxHDW9IN9BqeZrnmTTVvX1aiHBvhEDhDZbBPazC1qjJLhGzySy5ZrunMw7O6ilroE+w0CraeoHKA4KV0cR+xBzouMkXmJgMX4TMWGBKGUvKeMCLll82Q3EOsPksjPnlqMbgPKJ36RMiiWoMkgK0XZci5grfEAA8i7iew6bQli2UjF+gWcy9nq0FVgzX5/yZEbusWwrhFMcHQ5MG3j9NT1mDOmIfuKvrhZJD3CKCBdemEXMO7RYdlaJzIGYySsnmN2ot8rgYiXp3jLEMqUUlUi+0M6HC2PGyYBYClTKhBfxpR0oWhLAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiaqAaTsKB075BmtCRWShQlIbnS4+UhYg6ZQIIVDEv4=;
 b=KzWEPLn+qjNo7cqy/3BzYeERpuexbmTCrp6YnnpeY/UmotBsqedpqmyTn5epXnkYVdeldpbPSvDhorRSsQTfEB2nQa4mQ0KlCZ1u0i730wMXyN5oyZxenQ9a7RJrGSHEknvXBseQwJHTAYhkuU851Jxya2dUw7fhfcTcSW6rw+RhwZdIawRafyAd0JfGmXMrN3uwUmbIBHoSe2ZhYbWfTX3I/h0Y7OSks7iOOgZx6+zEvIoQj21dYgn0n1uLWPYYybdyimDrlm7oMsRzeDBllKG9M/sdlKMO/ASeZFYZoviPGtvw+i6Y35edelIAn1HLzYCPv+clCA2Q77vf9VdILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYYP286MB1474.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Wed, 16 Feb
 2022 16:50:43 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 16:50:44 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] tracing: Fix inconsistent style of mini-HOWTO
Date:   Thu, 17 Feb 2022 00:50:06 +0800
Message-ID: <TYCP286MB19130AA4A9C6FC5A8793DED2A1359@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [KRwbPx+WueinydWPtWxehPw2NoFb5ixI]
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220216165006.2723-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e2f055d-662f-44e3-500b-08d9f16c7933
X-MS-TrafficTypeDiagnostic: TYYP286MB1474:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Aq9V3V+0I/gmqMvKUIxOUgSKGc13zab5mFu1F7W04qO4ljtr3LD4OFv5fvKCfV0k4oMz4z3+bTsvw4j0D//J7Jg7ti7/Fpt5PnUEoeMl7Lm4iGDrlhiaVN2BFayIf5HweNXu1pesnU7HbjMomEO4evo3yatbcjb8bkSF7+/qfjHczZT6X5TUxbvW2eEckJd3XmJN7FJxoEelR0f+FH1MQ3Uo457o/c5qtZ7EgGB35uwKnEUCj6vpemhVGtOkacjAR7WF492zPF11aTit/OyofbA5l25dBkb/iC2vAc/FCZpPN6N6BLFI+jMIdKP5f4QmrbHHWrCbglU0paLTRCH/0t1clzVmrFZJMsemOJ0MKNiqA4KQKXnH7tZ0IoGbneo7UiBJyx/bvjseoG8+BVCfBRyZjMwKbjVfin5J9qyy8Tzfi55hwk+S7QudOP8aQhwIv0eITpkeyPnj15kBzsCYg9jszYDHEMtmJXBkYTbblZx1WVT/Z8v1NiRr+wSdZrgp8a8YpaHn05qphA7YJPDBjvuIwTwmjvzLrm27P5OOkWmrVSYsXRp0sBTvSBz0Y+XLvSFVUfCM+XMgmEGLzAMBw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5A19Eyb/g/9YMCZvfmyFZc+WIbT5uhh8FPM+c89X2MV67Cm+Q3Z8doaWAAh?=
 =?us-ascii?Q?9ukMIqIjIkJAGGnHlmNFyEWjcm4Hk1TUjwRrU0SPF0CXqw1EnclEMyo3urn/?=
 =?us-ascii?Q?HIcpeMjmp1ewHKMS4XqjiiAoXJacJAV/Zxh5K36FfXnagbXW5qVMuzyiDjCa?=
 =?us-ascii?Q?Fvr/AUcXv6xNxd+hrwa1HEkVClgpp1Gy1CtIfOsE9OutXw9Pxj+aOKb/CDut?=
 =?us-ascii?Q?fXz1kpk+SQoJe85KPEMLU4nsgmXDeARuWd3O0pTFEIMYJxnRQgAsC6rV1tYD?=
 =?us-ascii?Q?rFPbhAIYIzS017DlS+rGGA0Tka+X0HSg3mfeb0uZgBOeJxD+QSDrM4wvAdr5?=
 =?us-ascii?Q?cwACEgpHxrBE080unw9+cJxyIR6wl4MWLTjt/PG9z2x31Ki2bENLfbDDr3YZ?=
 =?us-ascii?Q?mYt+5VxwfcuRrjSoxboKNMaP0MdAc/1fQGjwNxXdhGcAQRCauYCQiryPmNG+?=
 =?us-ascii?Q?5+Mnh23pEaqoaTfdPWwLfpLO3wgWJfgkEpe7RhmeIRvkLS0g6+U7lo4T6+B8?=
 =?us-ascii?Q?+XCSjyk9hFQtagXKZVKA8zfoBV4HF99BQSKEV9dGsznuDAP5LRk/5x21eGns?=
 =?us-ascii?Q?5an4GK4cd6fJg6S85jTeOYSQQ5e5/05g0Tz1xNzjucPmis9UzgXsnd3zupuD?=
 =?us-ascii?Q?kIZjtGYAStlDTjQncpts1hulcg1oD7/8DzpZLhodYxUQ1UNozvlMGqgEMPS/?=
 =?us-ascii?Q?NGDuX7CbjzuKWjDaJN3J4/85yhZq69TtNeWgMCTGZmIsnklO6vC7Sght67li?=
 =?us-ascii?Q?wzKfYiupEo+ws2l7ZyA7M0m+AXYr04wdiMgYm1Z4zT5lddx/XQI60sLT5bI2?=
 =?us-ascii?Q?PTAcNOL2MVjTkL2eCM1WX8R4baK5HPt2p0C1Ax7HRMY2xb75wZJAUI2nD2vB?=
 =?us-ascii?Q?3R+lu1aOCgdTJLlATGSFTFdBCOe/xSYSVP8N7vXf/iFcQ+8QXF7NW/c6jpO7?=
 =?us-ascii?Q?OJ//ULUHe+5oAiUAWbIGwg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2f055d-662f-44e3-500b-08d9f16c7933
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 16:50:44.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each description should start with a hyphen and a space. Insert
spaces to fix it.

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c2578efd..a0d10e949 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5458,7 +5458,7 @@ static const char readme_msg[] =
        "  error_log\t- error log for failed commands (that support it)\n"
        "  buffer_size_kb\t- view and modify size of per cpu buffer\n"
        "  buffer_total_size_kb  - view total size of all cpu buffers\n\n"
-       "  trace_clock\t\t-change the clock used to order events\n"
+       "  trace_clock\t\t- change the clock used to order events\n"
        "       local:   Per cpu clock but may not be synced across CPUs\n"
        "      global:   Synced across CPUs but slows tracing down.\n"
        "     counter:   Not a clock, but just an increment\n"
@@ -5467,7 +5467,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_X86_64
        "     x86-tsc:   TSC cycle counter\n"
 #endif
-       "\n  timestamp_mode\t-view the mode used to timestamp events\n"
+       "\n  timestamp_mode\t- view the mode used to timestamp events\n"
        "       delta:   Delta difference against a buffer-wide timestamp\n"
        "    absolute:   Absolute (standalone) timestamp\n"
        "\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
--
2.25.1

