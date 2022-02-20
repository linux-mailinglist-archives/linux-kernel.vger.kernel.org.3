Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F264BCE62
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbiBTMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:12:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBTMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:12:50 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2081.outbound.protection.outlook.com [40.92.99.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997EEE0B4;
        Sun, 20 Feb 2022 04:12:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0kWhfXfhzk8kUdQXWkK8wFqSqfEdX0eeShYk+ued1ZyCOrRGHZDd3TVWA4oEgDvkvanmpqyKUGSmUk33iOBFV20kI4mfGvcOhm98YHzGn5m/7xSuli8qI230Q3P/G/xdKL8AUUcq8wLS1ayXpSjRPFW6lUGKvFgOZCP86lQa4rAfY9zrdoN5+zJha8g+ZuFvG+c8+WC3YYY3S+b17ZycOSUviaMBPEXAjH9C5rxv9xBMZwC5bs6EB056BDSHH+I3RBMDaukKZ4qX//AeXwlyHaCoUhInYJJGcRWi1nuhkkCJWdsSo6hpZrjGknJ2E9NJMjVuTSnt8W/BHUNXiFKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAVQBWJcBmzPJnyHodAde/LBsy4IzsRz0NB+n68iIek=;
 b=ZzVA4UBhujpHk2OPSAHe3HO1GfOfozPkFge2OdrSq8t+fNY9sZ8in997+gNyQRC4/K/LJ749PAajPOl56sxdjclOunUZrw55/hPBYWl0UalagXIcnhn5nCqoVgbT4yoZ7WqKhTKqNPw2v5knw5M17TUoTZoiP+0qPaZzZPa51rYc6JiRLEM/GzCQbe0d9dZqH6dIBkvlzLWRSNPStfPzscDsQZfSsaFCRd87RFliSWX1+k79kHG/VHeAUBUCs9o9xm1VsMOYzCL2lJCJGEH6AmmDTxMRVzTF8niJxR6AjdVXLSe3nJbawvX43TwT+nv/mVM2Zc24/5aqPq3erQjTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYYP286MB1595.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sun, 20 Feb
 2022 12:12:25 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 12:12:25 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [PATCH] docs: Remove duplicated words in trace/osnoise-tracer
Date:   Sun, 20 Feb 2022 20:12:00 +0800
Message-ID: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [2H/pLpdKsBr39ha6eF6HS+0Z8FDEK+N6]
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220220121200.6314-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe334db-7e56-4119-08b5-08d9f46a4110
X-MS-TrafficTypeDiagnostic: TYYP286MB1595:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68QqYNrqXcn7YXT1hbrN3MVQp6Jp10IS+Zv/wtfX9xO1Fu1A8MIN+FT6OHsXaDgyPLITSM8u5ZtsJqjl06Rdj4CttH836iM/hsFTHzwH6Z/w/oMjM3MBH/ALovsWdaeR/7SG7jXGywqp60oMHmoABCIrNeFqcoA1HSCJyhz6LeD/R7VVjhrY/cqFYMZOwO8jS/ZAfekbkHkdZ8vcJkLEVc08xSORWqh55JXbb47bqCZRgIfauFDxs/pTxqxFvGw2AzoN+wdyNoBgwZHMP7jdTTj0dsFxwHXIo/arEqoNy7y9iZGF9Phdx5l1moXID0PAeWBD04SlHBUdGkwby67kDnwFh8db7RJkDomYQtdnKe/ob8ub9EgmZsG0yf97d/3CcqKU4zxew5w9aaLO5V8LWUR4WdvIdBJRn8VCSljpcvaVlLGPEoCHKJC1U9V9DJvlWtlCMB51ZRggEdY+ZuBInuAShGJzHIQzJdUHv6dWkjlzeae2d33R1HKTEPpj5tWhxNKbbvJhz1FAbi6WoIR5HpApB/FOq92X2RrcAu8+3HVa8QulzpofrQ1awjZwB+J5HtZTx/bg68nwffXEccRxsw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67TWhU2hU/7TYJBq1v0WMgXGYiqUz7fA79kjlk17NLdJN12jebCkwoB/wffs?=
 =?us-ascii?Q?mEVSUe3NIvZWSZsGFOfyZzxq+Z6Js3ujrLkjgb2HwDE1lg60fW4sXNWJYv/s?=
 =?us-ascii?Q?csy5i2KZa1hPQI1EgjflrIDv6iCiTnmYsBhjC/1ulPQy+GbI3kLG8M26UNg0?=
 =?us-ascii?Q?rTeRJefNkFiqbkb4Dxv7RqA5K05VlPhfAszuNCRoM/FcLJZ7PAQ07hFY0lg9?=
 =?us-ascii?Q?JZmRcrdBUL4bRmX00RyHEdbXA8LJdAVSCGIvn3PeKaWAmlhXzsNS9Qdi4Vh/?=
 =?us-ascii?Q?01NEdBC/ZR2r7AFeNW/wwsGcrKu+ddch64mT74erY3Q7tBLPMSX9AFWTAkFc?=
 =?us-ascii?Q?JexYmyPaYp1bvn9n2pw6Z0yX4fy48ft7a8WhAbAmTgthSHF6+egUgJStY8Hu?=
 =?us-ascii?Q?lMIDUYKVY95SB8RIZK/yLjHzRvejUFmRjxZJ4sjClwpOqFee5sVg0asrvbcr?=
 =?us-ascii?Q?YNPGvsvnC0jv9URXe14TAuIu6JIyFH4gds3t8PiriP4hD/eu+y5CvyOghAfh?=
 =?us-ascii?Q?uJ5DQcqkCvSmW8VdjzoIzvR8kcwyqn9YBa51xVOp4yj4r5fXr4fn+aqxQgw4?=
 =?us-ascii?Q?3vEhHDDIwbSDkP9hyeu5IHnX/U+84PSqfxRAIbCdqrpUzdm1XnZnKED1D2/9?=
 =?us-ascii?Q?kv4as/serqIp96Z/c7nNM9zV2/zdDMbXo9EFlEUZE5AKTJRuGuAmmmHx1g/L?=
 =?us-ascii?Q?QBxxf8PAvt+uwOtUxXmmV8NobY6Lk8LJQbD+OJsTUi64pitQr8dfslUkJnTf?=
 =?us-ascii?Q?yWXf21ALrwxAsAVFBD2TELOxhYMFT1eD8OBDGDfJHZ5ZFhldXkG9fPxhonX6?=
 =?us-ascii?Q?DCBcgDYfFwB73f8NAQNRC6BVQCa287AFS+2DdmL6ONbaGYC6+zo9528Q9dJN?=
 =?us-ascii?Q?5PXYrx4qBGFbBXrDF/05xpiYpKsAGVTHyiaKPeh9zlamiPvNtpFXg/Qw4ds+?=
 =?us-ascii?Q?bzsf4ckV84y7ENfb/vvRyA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: abe334db-7e56-4119-08b5-08d9f46a4110
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 12:12:25.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1595
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 duplicated words found in osnoise tracer documentation.
This patch removes them.

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
---
 Documentation/trace/osnoise-tracer.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index b648cb9bf..963def9f9 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -51,7 +51,7 @@ For example::
         [root@f32 ~]# cd /sys/kernel/tracing/
         [root@f32 tracing]# echo osnoise > current_tracer
 
-It is possible to follow the trace by reading the trace trace file::
+It is possible to follow the trace by reading the trace file::
 
         [root@f32 tracing]# cat trace
         # tracer: osnoise
@@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    option.
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
-   will be used, which is currently 5 us.
+   be used, which is currently 5 us.
 
 Additional Tracing
 ------------------
-- 
2.25.1

