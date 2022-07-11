Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2456FF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGKKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiGKKol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:44:41 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 02:51:54 PDT
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F76EB033
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:51:54 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8cDTp032346;
        Mon, 11 Jul 2022 09:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=f7srmZS11GEk/ktXxC5qexUAXhI6NoOy8w7yed8afng=;
 b=n2ewcBEccx59/DC1HBpIM0/xAOSJUd4R6mrWehGaGS27ST0gkBxi0QL8P3fG1asUzWjz
 Fb5wn+m5gF2QiOrHaPRqF+2JKz5qftjQzQta0JaQ7gEMlcIDUGeAZ5dtasGcVk6KwWoE
 0yLjKXU6lkyzcdNJeR8Ogz2p/gMgWel5OruJpYqSVOfVY75u4KILbb5yXFYWybNGF05J
 /mSb90Z11wXwX+eGQSjCqkQ4KEnDtaa4BSepKLZBZFLoH5wwE87TgmBq8p+r4VdjmB3/
 rGpIVdBKfZcTnkwaCvB+6zDUZMmUYVAjJbI7FqGI9lHMiuYZLQbsZ4CU9LaTirk0EWMO hQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h6xw5hbqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTTMXs6P3LcH0OMkJVq0dUiEEtsMOsYOQoupHTVe7/piW/+wLMmCcPL7q6zdGHrLX0p0DjuEPzvG46UH5xP/H6qXOev907AHVeAj0MUzKCPlbjNctFiUoCPa07guc/lSoehp8jbbWGFwL/hxOPCNlGeAEB5W9JYq3zJLFoFja2XvlbGYYhcIDWo4fKkIxmcJETy0I9bmJMWIEFssFr47d82xEE8c09Qv6AoUitxLqOWBO7NC+smcgn9L83cSFqSjrGO9wMKstVYuaGvgjq51igFbGT/paqtdT58qvVlXaE7T6acgOHUMYmcLgSS767GtEnw4GYmV0t3ZdOM1EqKdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7srmZS11GEk/ktXxC5qexUAXhI6NoOy8w7yed8afng=;
 b=P0VEUiv3gmFCYY68mhJmf4/Q5GZYIa2NtVbn0rpJWiqm8unggEQTYAFUIrvFLT94vuB6/ZxbPSaTFh75zAAlKopS1ODFFzfZAf5V/LbeR7Zo0JbDjHO6eXJ3vdxlHqWWRDFBGow3Ubpx70uxKzA0MWwF6uo7zdrnVIxpozWoQVR9AyFZThGJvve8GunT4BbPD4bKup9uN9Q/QIdZdwhOzPZDxXC8ippWfs9Z/K68K15oeFmMJUBnjJnijwwH/vC96Nv81TCInp+5D+9SdlW3JFFMpO3JPZDvY4YzDGxLF0HMNIzZ/pjNRZJ10C5lijAMwQmwNNUxsj94fohxPkJ0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 09:49:38 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::e962:2a9c:c503:db56]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::e962:2a9c:c503:db56%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 09:49:38 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH] ARM: uaccess: Disable KASAN for uaccess_with_memcpy.c
Date:   Mon, 11 Jul 2022 17:48:59 +0800
Message-Id: <20220711094859.4769-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e98544b-a6bb-4bef-7326-08da6322aab4
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: doc5aO34v0DXK5HSC2fKGAH5PNx097RHRndS1fPajic/MlTXK9xoMRHxof/Q3Vn1Of1YD08Xm5JeSJHiMpzoiRRFYX/kwdMmEp95wtGZQWAU2oKK9pJTUJIrjQckITy7KRzNvxyyP/cfTxYs6UD4MZqXVFbocS1+GBC2UFUrorg7RcEBYatbbrkqX9bwoKTdT8nwoU49BgQ+VsDku5f9jTeQ4kfE/TNA3LN/SwuQvYDdI+0ZV4UuCwc/Q1O8LKbgxZve5bGGrteAWKl9ERtuweItgutxilOmg7Z/RckrrBJCigIPVKDtiHEqLlqOnHG2aioikQefTGgBJJgLU189RmMVnuHALnI5bUSSWLNNd22yW8eovJeCXcFhKmapq6XXV79BPTOEmvGwDpnbmyzQod4K1IdKgEz1wGGV4V5+LVHUYp6yBSZOlSa8QjKGUgxPAzMEKQQaILdtn8ZHQLzu9YdomOQJXEyBZzqEUUBbxuHFrkzOscCVyagb2cwD9DaoS/G5Fo4RhcJSG+bhHQi4PjXvS3qYQXQvm0TgX6FdrJDhhIzlxagp2QRGKRSa7F87Q0xgCYe0/sZ+m1e0Koo7xoqdULkorwzpgiEUw4g86fRr25YxTvjvCInCybzs9uw1QYRFyEzlqS49IUKVudb1Yntx03ca7pCYFsiYrbErmqxfVWazEMuACSMkCoJ4m8e7Fp21HEPUtSkVMj/bTkLg8fHvK5lMMRgvUtbtVWeXDFI73MfGF2bmolB4DE/hAh9/VxUSBQLOoojPLGFwGyHuR0K0+GAcxeqaYHcsgMuU4MM81ZwCLxmqg7hDFJfAumzk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(396003)(346002)(376002)(136003)(38350700002)(1076003)(38100700002)(2906002)(52116002)(5660300002)(186003)(36756003)(8936002)(8676002)(26005)(2616005)(66476007)(66946007)(66556008)(83380400001)(6486002)(86362001)(6506007)(316002)(41300700001)(478600001)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oym/ZyYeuzPqflnSHcIUSA4HsqLoqGEeOqVE1sHC4Zx8ui7vxkNTNHOQR3DJ?=
 =?us-ascii?Q?5DxO+miIWFKSMzu0YcZJE0WPH5RCNv4FTPdMu/yw/mGcXFWPyZmn7QxS7Hgd?=
 =?us-ascii?Q?uJ2YQe0tIEfoIUDHGK0pQYbZW1UPDAvb5VSdx9pVEQkOPwsIRSDxM5eTy5y5?=
 =?us-ascii?Q?eGhMRV6FOjJYoRITJhCJ4hIVHSNSKJgAbNEZlS36xfQyNt6shhb8MEN/4UnD?=
 =?us-ascii?Q?aLWSl3L8ipbD8WO6OYo+0qfxE3X1M3cVhXp/z50uPY0o6GXEds/3I3QlBNCY?=
 =?us-ascii?Q?BLVdhUG0ct2ipIXyNPiejAXhj6pksls1W2qzaAtA/qsaFnNyaAoY/3HPsKD7?=
 =?us-ascii?Q?87ZDlIy/eHOiFP2VlfkLk2QQKyJ84bESoWaNEuL61jeMbuWom65PxCZstVCh?=
 =?us-ascii?Q?VMdH6X19B1UQuMchuSLOuy1PeOkmYS+LBXkUp8eKaXA6gPzllSptcK1OHnv1?=
 =?us-ascii?Q?rM6NKgUh1mRVA0qNtbAaQ4puPWe2WnG/dom/CWIwQmhBfheRLJY8jhx3FApq?=
 =?us-ascii?Q?oYhRdvl6vcZ/ap4vC76GccLVKvOkhiUJPgrtHw1pPjja+C1f21mH3TX9PEna?=
 =?us-ascii?Q?WkwQHK3TxSyz4Y7ELenciGghJwCbczcJpYLLXlHAyRcm7YrgTnvpCtFCgOj6?=
 =?us-ascii?Q?kQT3musjKvcNHLl0ehL+l+PH3iCZCvW6bdWStJu7VqHccOVBYPL3KSZLk9/J?=
 =?us-ascii?Q?tIqzWlHbHDItInTHZN4cepLqjqDwlXCMbd6g3/Yzrk5tZAu8ex8ndSgn5WLo?=
 =?us-ascii?Q?jVnAtS9E2nVu2Y3bDWHep6oNXsIyvM8FZPrIbfV031/Tdtdyeozt/2RN7RX4?=
 =?us-ascii?Q?6xpnhqcmQ6cPj9ELRhAuSyH3KQaR4Gl2vIrRp5fusLzEVXi5Cf2nmBy1PYam?=
 =?us-ascii?Q?Zn68I1rb2V/440SKhGDHr2i0Kr31VXH0NaHxi4UXSLFpBmGTBFS9akwuAteP?=
 =?us-ascii?Q?Rf0BZQhtDpNVsh7jtvHI/iI/xTgLM8WOVXt5B/opXBmhmYu9UkOLw8ksD9Jf?=
 =?us-ascii?Q?rArDnrZDupNC1D91huFRzk1YUG1i1+jHNcj8SIGcmAy8A53p2k1W5oZzDH6b?=
 =?us-ascii?Q?3FGkhRvxkrG3T+zXzQlF9017CJoR6sBxzXPxPb0xb/7PQEhne75s4StDkzub?=
 =?us-ascii?Q?/LyDprTXotxE5mHUzvFacWvrW4D3zasHOfzyJ9xMlWloIypRU4G3RxlD+PNI?=
 =?us-ascii?Q?QmYzkQXuP2dQP1DuCU+qKfTl0hz3PKpDw0zkkfpfaq9jp6ADFQwfCVm+WN4h?=
 =?us-ascii?Q?03pf0t+CiCa68ioLEKFxxpmbAbMiKN15B/Ffni9aSbUH/kln9FoNktGCmuw/?=
 =?us-ascii?Q?DXbkM2rnY1mfV8QblTo/YOg2cTtzrx9N1yS5dcAtIi3lGw8aR/GPs6AVNMQh?=
 =?us-ascii?Q?Gg3wKtCWUfuxFZoyOeCFNEiZwKPBu+JhYtTAI4/WxTxMlVcE6Fdn95COxxbS?=
 =?us-ascii?Q?2TBaUB2g8Qc84PzfVSx4icfvNkxigUYlgF9MkDnK+1y9jlynzpjGO0jgMwN2?=
 =?us-ascii?Q?KYDFoYKRSLuU/5q0csvRYWe+z2JJ74o4SvdqKCaSoXIEORbyX/oOnKd1hY+N?=
 =?us-ascii?Q?OzUieyRvQwz5ZtOkTVd2wl95s1Vc5bGuiBMoW/nu?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e98544b-a6bb-4bef-7326-08da6322aab4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 09:49:38.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOElTx8GIyAGeTsS4i6jnP3ftGFqxhF/htn/9+ZfMplfmsZ2myqD9AOaqxTUls1gBCF/bLnffzq/pQyE7pjYxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-Proofpoint-ORIG-GUID: a0oOJfcG_9E5sdCBuarb0ZoeOQ2fAI7b
X-Proofpoint-GUID: a0oOJfcG_9E5sdCBuarb0ZoeOQ2fAI7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_15,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=498 clxscore=1011
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uaccess_with_memcpy.c accesses user-space address on purpose. We should
disable KASAN instrumentation for it, otherwise we would have call traces
like the following.

BUG: KASAN: user-memory-access in __clear_user_memset+0x154/0x21c
Write of size 4032 at addr 00501040 by task init/1

CPU: 1 PID: 1 Comm: init Not tainted 5.15.52-yocto-standard #1
Hardware name: Xilinx Zynq Platform
[<80116be8>] (unwind_backtrace) from [<8010ea3c>] (show_stack+0x18/0x1c)
[<8010ea3c>] (show_stack) from [<80fc287c>] (dump_stack_lvl+0x40/0x4c)
[<80fc287c>] (dump_stack_lvl) from [<80391148>] (kasan_report+0x19c/0x1cc)
[<80391148>] (kasan_report) from [<80391b78>] (kasan_check_range+0x20/0x174)
[<80391b78>] (kasan_check_range) from [<8039230c>] (memset+0x20/0x3c)
[<8039230c>] (memset) from [<808112f0>] (__clear_user_memset+0x154/0x21c)
[<808112f0>] (__clear_user_memset) from [<8044a9d4>] (clear_user+0x44/0x5c)
[<8044a9d4>] (clear_user) from [<8044aa0c>] (padzero+0x20/0x38)
[<8044aa0c>] (padzero) from [<8044ca00>] (load_elf_binary+0x994/0x1740)
[<8044ca00>] (load_elf_binary) from [<803b4ed0>] (bprm_execve+0x420/0x8ec)
[<803b4ed0>] (bprm_execve) from [<803b5bc0>] (kernel_execve+0x15c/0x190)
[<803b5bc0>] (kernel_execve) from [<80fb9bf0>] (try_to_run_init_process+0x14/0x40)
[<80fb9bf0>] (try_to_run_init_process) from [<80fccd3c>] (kernel_init+0xc8/0x148)
[<80fccd3c>] (kernel_init) from [<80100130>] (ret_from_fork+0x14/0x24)

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/arm/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..ddeb46efed80 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -27,6 +27,7 @@ endif
 
 # using lib_ here won't override already available weak symbols
 obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
+KASAN_SANITIZE_uaccess_with_memcpy.o := n
 
 lib-$(CONFIG_MMU) += $(mmu-y)
 
-- 
2.17.1

