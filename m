Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5757B650
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiGTM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGTM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:27:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2015.outbound.protection.outlook.com [40.92.99.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2161738
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXSLqM/4fFJdqjTmr0T2SMKMfvczP8hVGPd8YJ4Hu6xB+/UOLNOYrDIGMuRlXj7pQGO073ogl1hN4+TWvbRP5AOuBxZQaEc5awBb1QoB/2O9SxrQ4aXWpkZJoJeI9lZuyy2GvgvrYIat6H5LymARtP97f6M7zX7SysjO52kTFgZMk5DOftmgw0OrxNWIOAbbmXyvG7tTIxhUeXRdsRkUFiFXTWpwFawkmsDyV11yZo5K33aZlsyjvQ6YQrCnBcniMuMzFUC17S2BK6HyuUt62eY0CWVcMlVO8g9HXkoYxhRuFC9ze7H4AEBQFOH1gIugeP98O/pp3BC58+dlrJRYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGj9Y4k+KuaW1+DDYGk0yqmRvdxLOWGg28yzhlzjG/s=;
 b=N7O8v1q4ANkV9khqphAiJ3Xj/1kisjV+3dpbq9k3y4oXC/woTpAXlyJr68nffilidDH1u3jxY7Rjf9lHJaXPuf3T8Ixrn6HOOcPhYHqmx8M5Vx5LmoM5HsCdcf2pjeIWSh8d9k3tekiz+ltTAFCcYnCoyi0zEpUHs/QJgNKJ4BhpbMJ8zu1JErAO0R3l5Sy+XxRafEl241dkWExK2bTkVE6Fc9SkxzsdMIMqqUYmDbJoiL+Np4+ax00clv5iVw6hdiyxoEaL3KAUMI6n9c4tjvtvYtmzPdmis7W6zY4Wl8Uq4SumlgmsIbZ00Dsz7fwonPa0uE7E5xY70aCgNY9WYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGj9Y4k+KuaW1+DDYGk0yqmRvdxLOWGg28yzhlzjG/s=;
 b=h4NVtsKRLtLkOTKdUsh6J05s7vh4G394SxCT2ASdTheYFV+z1kY8EyzQI0/c6jJNdM7yICNs2lwXPcI4bIn3NjgJ1I797qzf07yVSieY80v+KteD42WldG7+0fzVSL79K6M8hWy67JChWgvkAUIW9wkO9h+EAW2nhPTfwmyprMZCS/cHhOZJAcb7HPuOc4ccnaylnXMlbEPejMceq/XI5fRaJfNuIeD1cH0bCmvgRGL/OBmQDpZiL7ysXJfiPlracNajujebtkuaF/WxREMPUSQ3YWpXgKDFNYiramJchH3GLI3E4O5t6cFXJvUM7bkshi1+NvaMYd2VitI8etKj6Q==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 TY3P286MB2818.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:253::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Wed, 20 Jul 2022 12:27:21 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2143:ec0d:667b:2175]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2143:ec0d:667b:2175%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 12:27:21 +0000
From:   pngliu@hotmail.com
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
Subject: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Date:   Wed, 20 Jul 2022 20:27:10 +0800
Message-ID: <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720122711.6174-1-pngliu@hotmail.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [x6tEFCs/L2BEOKWNpSJz7KoXNzlCxloLupMx2iDYJThM+qGl0hulii8ZUUxulUia]
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <20220720122711.6174-2-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5dc4725-03c3-4f51-25ed-08da6a4b3166
X-MS-TrafficTypeDiagnostic: TY3P286MB2818:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTP6aWps6LDkhoi3k+oOVT8iFsryu/4tDkTKqeJabJSkT/Y81Do+3fZcE+qAYNOHAkLblRg18uh5X005q5vS8ARDJDc9dq8JgfOK9+FDS0W1ak9/pfWgSY/GQ5G6dj1xEFIVGQJ35bdpuHAMTIePifQCaKAmiRTikrIMSisbgKxdj8NgjS+9zNzcCPN2PcBsgOmHv1YeeCQTvu46J6bpACGnr+FVffXS8PTD/1w0bMWww7Y56uRrmrnqbS87O5BcoSEJcUEcN2+jumpkNCaU+WrW9QC5yyKbmyPM9T8moQziacqeU1bsyXbECJqKtB4IMvAGA1z54sMU28Qom2cfDoSnPfT6I29S0AWKPNXIEZs27xnJ7B8kg5BbNUBw1z0INQ+e2sA5hESJjQrojJn78mO1tDvWNtnArBDGHY+ORfLWf4l0BrNMMtuGx1k8KF6sf37CV5iDVC1VtvzwQzVeUQEsI/jMgL+i81a0kbUhvHyWtIyCHmY72fmkQiCOsyzB4ZepUf1O2xcojvaxXFpyH8CYhFgoXLSUvAK8rJ2DViqo5WCVju1/qjlfwS1ppQXPRJ5czrYeNoe+XzkdzNeQpXFzuAyv0GMu1ds0HVSngl0RqRNzcC9L6LmtzQIBwksQmLfZE9NWiQaAp+E5St07bQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEkEDqijOohvc+IAnIJ3O1rotRl7BUn4jJ2ZDosZuT7pmaFdAB6BBBfOPG9J?=
 =?us-ascii?Q?UIQMOxRgtNoUbf1SvVGz7U0TdKtOWQ8DYjHBFeJubz32gojnsSdtTlKJTcAk?=
 =?us-ascii?Q?jqAtaOyjZpupjh3HMHKqgz+rR11OsMH+lEfG+DZOKD0M3aoXZhprnxBFerb+?=
 =?us-ascii?Q?Ap2AMSsB7whhVRsSiyOoldizJD1f6BWTsh7BP9cbYFwUi5iojLA0zrWhn4gd?=
 =?us-ascii?Q?A1PfUOaMCGKpKdofhnCEde9XjEmge/1qdTCy6xFacU0XXVndXnMW7Q4GsDHE?=
 =?us-ascii?Q?R8Quf5aGxahpVNVc4hF5hgLMx62tUPVCaibiPR7hJr6i8nZOrVKzD2i3afNB?=
 =?us-ascii?Q?wRRjQotLGBINKrJuYioz4qrl+1+CFckcZBBJeKXNiWva5A76clyItuHmXwvK?=
 =?us-ascii?Q?lztnP9vb2FA3g4iEsPyEN0gQgw7Uw7c+JG+AlYi3bdXZWimwiY5WWLavZoWm?=
 =?us-ascii?Q?NiDv1eCttZcgGCEps6dBnqiFOY46GELLCesOJ6UqRXG7Lc9Gd7jal8GgQxLJ?=
 =?us-ascii?Q?aBOwK6VeKuTmIamGaQUDjEkc3/1ZY2cRPcxhuOEJsCpNBWjN9S0/LuTLBzZx?=
 =?us-ascii?Q?JDgInNXbAXeiIXlArul8vICK/A5t3C0j1lnpu0hRou/GOBwOJ2YGAM/5vq2/?=
 =?us-ascii?Q?c0vKgW8cHT2rO3IUmUd6PgA5ul4zhYQ0fvm46rfmgOaZkuCczC0cXSeuDqu0?=
 =?us-ascii?Q?dWIIWDhlDL6VkoMxXroNZhqJjI1qs9mP6dLEOqivCFANfsLCOD6JkdWfxLmJ?=
 =?us-ascii?Q?9RS1fyIk1KJajqK1+3YmAFii/VMhoQBtl8mPHiHAda5ewFEtk20281eKDpna?=
 =?us-ascii?Q?MT4BjxANc2iPWFjXwTWGVZIBdT04F4MLRtkXwrvmVks2VRkjBOaM4DH3kcVK?=
 =?us-ascii?Q?07Ybn9j7dT9Iw9BVqy4QN4OCTtLmTSJ8labf+sKPO4mo8CV4w3nGSv1Vi87c?=
 =?us-ascii?Q?pd9vXn5VzfRKdZDfh0Xf/dtwxSyB/IqnRU0pCoMxiiCgZ5+e4GhxsrICmGO2?=
 =?us-ascii?Q?MfnbMuAn528B5krtdOqcbSv/6iv+9tAo8Pw4GANomLeuFTcCXcuzoKVjYDLl?=
 =?us-ascii?Q?qns9fD8TTUaZx1H9CZ2lz5hKjB6A/RsTetbXUBOjtEFab8eAwLby9Lr8PtHN?=
 =?us-ascii?Q?wdMXo/UEaFnxk1VD4ZIz5D0Vw6APIcVGssmao2JnuZ1hmT5V7fJ8UguQAYDN?=
 =?us-ascii?Q?yxUmYUB6OgPIU0RgLHenCPX4aQLFovCIuxHlqpA3jSLs6a1CXhiGsxUjfMCy?=
 =?us-ascii?Q?p6kQFSGRJdzYL9fgXPF2lsw/NxRxGleuSoySb1SnKKhtzs7IF473AGnpqgrv?=
 =?us-ascii?Q?teiBb+w/v77fd57v0AA7gmA6m2Bq9FteeMRqXEp4DbN8Dg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc4725-03c3-4f51-25ed-08da6a4b3166
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:27:21.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

Below incompatibilities between Python2 and Python3 made lx-timerlist
fail to run under Python3.

o xrange() is replaced by range() in Python3
o bytes and str are different types in Python3
o the return value of Inferior.read_memory() is memoryview object in
  Python3

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
---
 scripts/gdb/linux/timerlist.py | 4 +++-
 scripts/gdb/linux/utils.py     | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 44e39dc3eb64..8281da068c5b 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
 
@@ -157,6 +157,8 @@ def pr_cpumask(mask):
     num_bytes = (nr_cpu_ids + 7) / 8
     buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
     buf = binascii.b2a_hex(buf)
+    if type(buf) is not str:
+        buf=buf.decode()
 
     chunks = []
     i = num_bytes
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index ff7c1799d588..db59f986c7fd 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -89,7 +89,10 @@ def get_target_endianness():
 
 
 def read_memoryview(inf, start, length):
-    return memoryview(inf.read_memory(start, length))
+    m = inf.read_memory(start, length)
+    if type(m) is memoryview:
+        return m
+    return memoryview(m)
 
 
 def read_u16(buffer, offset):
-- 
2.25.1

