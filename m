Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0905295CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350555AbiEQAGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350574AbiEQAFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:05:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961240A0C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:05:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GL5Vep024500;
        Tue, 17 May 2022 00:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=P2acWHvsbaWdCjwrx6soSgyHLSGlI1kgeZzQ1Eo0IIo=;
 b=k0ef1h54CMzcjW62uf5pADpl1nUvmAmBouUrnRNYeRSNjSBleOYxS9/McllHwEay62qD
 47UimoxO8s0ZXcAwpRj1IIQiv15p21yVJ87oxPhwhsrmOMHJmEIjZ6v/XFNMxwv9Js9K
 DtL0SexkT/HkT/cf4a3JS+yiELeSiJV6N35vho/MpS+i+RxAxRFqeYBr9e37rejM56ld
 Yf3+jw24NoqR2GfoEcBf0qDVnEO5sM6kO/BS7MlMCXrjn8moMpTWC5TWbcnTwyq4aGMB
 6Og83noBAszJA8ntRKipuN3H2JKtlbsoJWabAZhsP7JwORMoX6CmJ20Wn+v+eaKmzSS1 ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc4nyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 00:05:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H0100W017819;
        Tue, 17 May 2022 00:05:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v2g98b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 00:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUZGdf4ipiR3vyZ0mGfHZfX6uRJGkqT1l3px+kHp085uGZgV6bmAN9x2KRajAgMnd0LxGiPLVDtQM9esNxzZeJ95y6DCom4W8u09MZjIJWlWDkgdVMEN5jVdA1TwVRPF4xxvujNUvlU+Ik/uqUf2Q9mgtl8Z3cckYXpuqi2oSdsNT4c1VW1DRn1HoCiu8w7zxuBNXIL8kRrQnzE2aIgCLrUbPxu/Rs52LIaIOAoq+LfJFwwUWfhwtIAj8zuQLBNHYP/Xo+s20IYwLYZD/lWbJ+HkLJt8Vzp5XiIksD+agwrbaJo6lIHlFeWIDi3I5hguCJQnvoiYiLyZJ+/SnBHMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2acWHvsbaWdCjwrx6soSgyHLSGlI1kgeZzQ1Eo0IIo=;
 b=K6l1xSKI1JAbfKwRRjfsoKfWeBFq2KHJcKQOw6ZxL11hAJzzAsGbyysrWITmywbAr56RaiTqMWZ73dqzqqpLJU35U2eWE1u87uWOS+N5f0U2M+/KWgvchgnNpsOfAXAhiIl8dKbU+ivxSuQAi1HSeR/RoXTPyJwRwV85hlKqbvSD7m/6ilBRk0wgq7NVR2fqS2Yun7ixTdMvamvmHnsMfVBE+PJ7Ldl52g5Us/wHJH8+OD4Yv6og6eiT4EnOizdc2W74SH0c4o3ZR4KUEhbEHhAc/5jQFNdfM2VuyhAzjrKeGKblBK6oQEw2Eblw3kjLZq3KvFfB6YuaJzjPd3Iwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2acWHvsbaWdCjwrx6soSgyHLSGlI1kgeZzQ1Eo0IIo=;
 b=MHzWRJ7069/5qZg6Ja18YTwKjAn1suBitbLK3vNweNhPg9WPJws+xNaWNQ6VRdkFxWsxIsjWqSGWtosc9nlkQKW0r+Kv3YBeaqPDqgApmohmbVqyEaIHzdchEW0IO+aZHQ7Jr4NNi3S41l0wKrjjwjR9mKGJ+pgD2SZw3k1nujQ=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 00:05:14 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 00:05:14 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 2/2] vmcoreinfo: Include kallsyms symbols
Date:   Mon, 16 May 2022 17:05:08 -0700
Message-Id: <20220517000508.777145-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad6fc99-0bb6-46e7-a553-08da3798eb0e
X-MS-TrafficTypeDiagnostic: CO6PR10MB5572:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5572F02D4C27831A97FEFF93DBCE9@CO6PR10MB5572.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NGXPnHpKjZfwKUezhx77qzYvOShWWZUOrU6zibfH3vNE39JuTBcIHsOAg2WK3CTLCtkwlRylaGvrXz1XwcjrQjD3J18dAf8DtUl317hbpPApVBSQmqbtxZ4nXXQgrNpdSaqrCwozmy2pH9+qrIj/Z1rbGuV9G9UsTEWYe5OUiUe0gC7+27y1CpKULcbNg7BrPSiWWYM5mHQuIPbE+K1brujkZ9ECFTjdGF4JLDBOqnJMqRNGXToJdoOMXHcKaohZGYSvgRStUa1h3wxHo7kVlPsz2QxZg8/POOyKFbCtdgmYcSLbcfqFBYwpDvC71f4Ve1hK8E82DEq6kEWM/cNIMt5ks8+IpVbPnR2g8qgF+xgVNQw1WZUbixSI4xa97SFIuN3kD1aP7cWGiYAwWWwXBCa3NAfh5YWCgDUo9W26YH6PEFnCWltEkjY4BcFQFtpG74DRcNfc9jIoZnQbPrZsI7GYlo2kKB7HPXtJvnEDmmoj8+aHapstfETUrjzTAJbBRmZK1GA1ZkZ1gzXJrALirY1jFpR/a92CpjD1dxsunPQDnTi2jIC3TZHyX8C7LvMJHB/KXCKzg3nGDAnA8iXnasxxcmR5PcTy2KZ0kheJ/X2IDcqcTUE2TNZ6oDzKcSVAuBm1oNzJK9+4APkjQsAwCGJtl6iJ5Z1dp1BWggWlRDVOuSPeDwanOr5QWOD8jdEzvZBeSSjCfQlE0ewF3IWw5b2waD4/jZNV6oGZVqjk0kv8zIGfAJCXQXv81Tahc3tWofrIhiKcENAROFo3SYSc0JTMjNC58Atnx5CGqF2dE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(66946007)(1076003)(2906002)(54906003)(186003)(6506007)(6916009)(26005)(103116003)(8936002)(508600001)(38350700002)(83380400001)(52116002)(7416002)(316002)(36756003)(5660300002)(2616005)(66476007)(966005)(6486002)(8676002)(4326008)(86362001)(6666004)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDXht1fjxyUiOoA5tA7nO26hTiS6/m4Tw/BCvBXAztFCh98VEKOY+tmzF2ZB?=
 =?us-ascii?Q?8kM+cx0mtrlvJxHf2QmkcR96tl7pxgJTRBJFwpBrpntqX5FOC4c3veqia37x?=
 =?us-ascii?Q?oVDTquxBjbyOns9RyaceETl8C/CHnBxoTKf0W0LJP16Po5uQw3yykcYC5SQv?=
 =?us-ascii?Q?KWD3nQ3m9ZiYtYlWyUz/SkhewV5xfZfnlglF+gN7yg/EDt2Dfa0Vj5j/0WSo?=
 =?us-ascii?Q?j1z0tBS9B0SI6NvrGgEJvvpPvZbguMzfYTkrCug+JpZ3XtnKXP8dyBbTPb9P?=
 =?us-ascii?Q?zhzCZSdK46QwGBcCEGTYIsypCSQ3xEX0HCeI6fbKo9ysR1pUQKdHfwRhY+8s?=
 =?us-ascii?Q?hCpY48Qa+RxjeCNfrysqKiHKhLYFK9um1WkJE5Si4WuCWYMo2VsgZRVBWZfF?=
 =?us-ascii?Q?YWDmqAaBM9dFctWtfbNzZ4wHamky6H0nuqUT9a2mI9h94fkjoqqUrsjO9hp2?=
 =?us-ascii?Q?bVgIXSbrEgbX4sAxt8h2MkE8B07RMQHYx7Bh37S3Tg1+D+2eG7/yyOZRzb2T?=
 =?us-ascii?Q?26SFp/6XzdlrWkD+fILBT0qG6bK/wYr1Htq6Ng0Z9f1pvBoOSfKMpYKK/0le?=
 =?us-ascii?Q?wvL+oUAu7yQGZVwGahKUOMc2/LIL+4OqAJ1auZKQ9yd/QBGwJf8qQmVgZ1iN?=
 =?us-ascii?Q?pNUTl9o1N3ou+4TBQy/IBX4b458v4fsn30Gl0WdDBWu6Facty6mbCu3kvJxo?=
 =?us-ascii?Q?n3Qe9+weSfLkvk7XyB53140HapBGHyJkRlUeRy4Iv/e2RpspzFK3jYvsqbrX?=
 =?us-ascii?Q?n6y+C1RX2cK6iyKtXz/p7WHVwIWuwNEbWWbrYlQGIoM3Fz+rt+vwjrII7bss?=
 =?us-ascii?Q?8JxvcnZ/PKQGEQrGs6qAbiShGtytuKkvGdcSSqtKqOzNQI4jVJFBAROW04Y4?=
 =?us-ascii?Q?Anv2bURHiTvZTv+/a1TYacEZX2lvzXOUmkXvE2KjgX9jgPUSsCMdM87aL85x?=
 =?us-ascii?Q?RBBzvnAlLIv76M09Lu9xeOuYZPWt5dipOkzgAzBTQO6z+StmfyiYJu1guY6U?=
 =?us-ascii?Q?LewkvdXcCDHuRQNyEqzofw8J/CLX4MLjzjDUau2X2NdGW6B6lwPk2mEldUld?=
 =?us-ascii?Q?SCkNVaWstISBnns8s9SwjHm+uF+Mr8XyQjvgUvogTqcWxmoCErKeFcI6ME4b?=
 =?us-ascii?Q?lcBpsZqnZ19pMOJF8wkhYpgbMaUM0/+GPezF/xRhBwGc+LLP2h2lQbr5Kovg?=
 =?us-ascii?Q?bIU3f/G6S+D+Nh1T350HX6dhzrw08pZR8/E3KbYngMBh+LAgOSDYv6Q7w3+g?=
 =?us-ascii?Q?9Eo1hfw/cnqp1ovBxX2kT++VY+csGr8lNNsElpinlGlzdI1mNlOaX6a9TYPm?=
 =?us-ascii?Q?yeQFHtBcFC9QTk+07bYpCufaRop+2+oEeVe+lSwRz8MrdfZCB/1nloV3IxqH?=
 =?us-ascii?Q?X4kqXEsWbutH0ukRo2yuGqzpON6Z01b1sQY0Fqf4A9XDBO/xGpZHopVQVTOz?=
 =?us-ascii?Q?oQ+8RhZlW44bb8oG5stsxXLgBX01B+3erjOJ/0pvIqs3DQcP5x31mK0UXJH5?=
 =?us-ascii?Q?MYCnIAZOaRju4EBnvECaiRLXBhbw+nLVdVDi3e3lDlSjCBKhUqYfZ/FHwS+h?=
 =?us-ascii?Q?7gvUEJrcYFU7XbSYixAt7Ez73BVQTHj9NXDebrSXwRCAujK6XnZGJCHkc1u4?=
 =?us-ascii?Q?rcREmG7Upws88pl0PnlwAMK53IctRmWgjLwLu4CT5fdiIEORd/kyJFScsXr+?=
 =?us-ascii?Q?WSCXb+BDEKnU9GS5wABurO6EHGy/nKnt9NkwETEjjP4/LQYYlBFJt9xmK8US?=
 =?us-ascii?Q?I4jTgXadzBrie68CZ/Wtjig2KZKqRtY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6fc99-0bb6-46e7-a553-08da3798eb0e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 00:05:14.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvAJxCRX/IiqROdNIRyGFrPeUuIoED4Al8rliLaoqTxLlCrkVHnH/vIBqYNjCwYzMZz9aFUynBB69JqJzTv1wi9zKH10N0rey/WxoiXjpzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160132
X-Proofpoint-GUID: rxGGkH56-SRzw4ftr0Lyz_qKyKOQIHHA
X-Proofpoint-ORIG-GUID: rxGGkH56-SRzw4ftr0Lyz_qKyKOQIHHA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal kallsyms tables contain information which could be quite
useful to a debugging tool in the absence of other debuginfo. If
kallsyms is enabled, then a debugging tool could parse it and use it as
a fallback symbol table. Combined with BTF data, live & post-mortem
debuggers can support basic operations without needing a large DWARF
debuginfo file available. As many as five symbols are necessary to
properly parse kallsyms names and addresses.  Add these to the
vmcoreinfo note.

CONFIG_KALLSYMS_ABSOLUTE_PERCPU does impact the computation of symbol
addresses. However, a debugger can infer this configuration value by
comparing the address of _stext in the vmcoreinfo with the address
computed via kallsyms. So there's no need to include information about
this config value in the vmcoreinfo note.

To verify that we're still well below the maximum of 4096 bytes, I
created a script[1] to compute a rough upper bound on the possible size
of vmcoreinfo. On v5.18-rc7, the script reports 3106 bytes, and with
this patch, the maximum become 3370 bytes.

[1]: https://github.com/brenns10/kernel_stuff/blob/master/vmcoreinfosize/

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/crash_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..b9c89b80856d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -15,6 +15,8 @@
 
 #include <crypto/sha1.h>
 
+#include "kallsyms_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -484,6 +486,18 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 #endif
 
+#ifdef CONFIG_KALLSYMS
+	VMCOREINFO_SYMBOL(kallsyms_names);
+	VMCOREINFO_SYMBOL(kallsyms_token_table);
+	VMCOREINFO_SYMBOL(kallsyms_token_index);
+#ifdef CONFIG_KALLSYMS_BASE_RELATIVE
+	VMCOREINFO_SYMBOL(kallsyms_offsets);
+	VMCOREINFO_SYMBOL(kallsyms_relative_base);
+#else
+	VMCOREINFO_SYMBOL(kallsyms_addresses);
+#endif /* CONFIG_KALLSYMS_BASE_RELATIVE */
+#endif /* CONFIG_KALLSYMS */
+
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
-- 
2.30.2

