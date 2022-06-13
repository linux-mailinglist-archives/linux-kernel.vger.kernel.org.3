Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C854A233
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiFMWn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFMWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:43:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5932831229
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:43:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdhir014557;
        Mon, 13 Jun 2022 22:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=i1Eh9Pai4GhkXhcUKGCA2nx6hmrUlauJAcefAWwohhA=;
 b=kcw4Tv+mC/yRw1byk7nC9d906yiquiw09+AY5SJV0nG+oJ5RJQsbzWYqZHsRAHYQy119
 Mnz1mgSGPIfLipAimc5y9yFo/dcFrvhGa0TFirEPvqipvCnCCljWgcZ+pBUr/AuOXtCP
 KXaay2AZ2vD2s+m15HSHGrUjIOj3XvxQ+ZDn8mTQCWXBJoj1DZ5kOEMCCydlBK6sdlXx
 u+jq8puLfhSewv6FsPjXq8FMHX3YeYsQGoi6m6EVwD6560E5PK7Zng64zA/UXIvYcxmJ
 B4ju4d/KnWIDwXRO5+av38BTkjunzHsS9SrlWVPRi7iLeh0SKvI/Rw2nC2XwYLHDc4ts Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktcaf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMehqh014918;
        Mon, 13 Jun 2022 22:43:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r47h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+vAbQxtJNXfTf5cEIMxh7IW7VSrHrIj8FRjyk8AmJATPJ58+iln8WmYcdplkq8vMT6fsx7T2hKDFnjUoz8aqxXWdcSWYpSFx2MrOyrKgPZhEX6tpWDkfn3YgpKk6e22akoNzJN4MReHeLS73rXyYBJwrLkQUfbB3k0mMSKqMfWsim5E3ID6LIdk3s3Fraibf74S8ofoym1UsoBmCGAb/A7hd/yyggsuYEvi6+ytjcNKSKdGzthj3Y/c/hubrDVhArQMaW85BvfTjXKqnRpq87kj7F97WVtffrxk+ZAmq+sJkbmlZnlODmmkHMg2OWGJWQPycuELT1Xxflx9rEKWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1Eh9Pai4GhkXhcUKGCA2nx6hmrUlauJAcefAWwohhA=;
 b=Eqcbz5VV/l4PWAcJGCTmre5hs73tQyndk6JKHU6ICVjc1603/RcQMh9PZ15ylrNyvqxVprIwbSGDux5HpfzXq+c+VVs0HCX/Ff1jE5NmZlF4288Ajg7pNJqRbFmtoou3Jk2o7K0eFIPlwZfrXmIKbd9IuNSV2NsZm1ecPV9ekRwv2L6Q2m/F5JOco6rP2n+dLDC8YyASubYRh2RVRT6RYG994w2XG7fKGo3k214ny04K63aUU4CAmoXpBOD0VRSpP0hQuHP0sN2MY1lZg/BmdXNo3MBbhdODQht/5vnXPQ5xYZu5/xTFJ4whankQK6nvij3Syhc5uAoqeod0PvzP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1Eh9Pai4GhkXhcUKGCA2nx6hmrUlauJAcefAWwohhA=;
 b=dI8IFc9M1aPTwNHNYU2Q2O1rJ8QCMYsvPLOyJw+eWjjtCYky7x5sFh4LesLYBsXb0TJtBar2b3i6nuvUD6WpEM5/30aUlmJdTTlUS83DIFOpzlM0RPhbGQtA20VwqhuE9CeMKFTC+8jIL5EVhFUBYCdhr3JZoaa19/NPLfxoFu0=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:11 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:11 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v9 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Mon, 13 Jun 2022 18:42:37 -0400
Message-Id: <20220613224240.79400-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b094af7e-d3fa-464b-8d33-08da4d8e17df
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3824BD71B45D80AC138CF48597AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxXihZ1OmdX1S+iwr9a7hqI3PpiWSIdEFXZyXV1TENXR6bx/1jd3FmV9apwuLW0TPc1uSmOseH8Zvr/ui41VyjRewxqBGjGQaRoR6zO+yKHl/ctGqZZ/dliqnVm71HIcDttjuBGLX7gqrRocFouVcyDqHx6Jj2wDTSKyDAz3U0/Dd/czJhvu9+OAFjs4T68+K/+OsN01DC4g4agrgR4LGaLaX/RWf1rbv+XGW0PZbczcOVjdlpTm15N09BfqtPYpEfEQe1hE74dwRLHn2FWb2AWj4MdolekmQt6a0s+DNn+CXW6Ja9VkV6O8S2JfOSulZowLxHtad2lXZfsdlmSq1/7/o3HBa+sVILs8gj2SMc3MjChF+GpejYR79UknvAl/MHZUCpNjoGFWRskjtsbqggxfwt8hQ+kLxYiHkgBwJb4k4cGhSqnRMcJuP//7KPCvg4dai0jvIppz35SjJbbF0HYgEMSW4K6sha6LUTixVU0VO12jSekq1ynE5osX/YgPWbjBIeYW/rK4ljYenKV+Mpa58iPKcfgtgGCX8SkZAXKXRR8DAZv6pW5KahB1zKX3GjaKqyZZ3bGJv/rlx8y+WdlOpFrHjiQhETeRtzIbI7SZunsU7HtqvSQJzhb3nUeuEoUqMYsEZBIfk+BcKKsMLgKtKnG4VAUETLzbC9T0+KOLtccRFrGXPkUO8fFK0T3T+0pTpO2zdxVXjV3nfhgQqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPTFCfSlvggYFJR/ySaFDhCnu9PSrXuG2aaFjces6z4Vzpproh3MuTYG5Jd8?=
 =?us-ascii?Q?S9fPNelhowGfZ+JWTOG5Ldsl2ISEptCFfxRPWvZlB5vpnygIbW3HqSs7cjb4?=
 =?us-ascii?Q?4U0J08xPfJYui0k0FBfMg3jb8WAL9vRSQgXfU8ITDgVJHQlE/raG/pMwk/4D?=
 =?us-ascii?Q?yyCiI/gdFYFq1EcWxQlC7/0VxNvJomJNZBOOFd1XxanG7FNkVHdw960uVwhM?=
 =?us-ascii?Q?IWh14JzODl/ndDVuTIDt/PY9DuUDDCQkiPxS8PYHBxyIGl3EgC6Qi7NQMoy5?=
 =?us-ascii?Q?wqBQRN4eLAeZpd2Zzjs9QE0qaxqrDNNh2atHf3rKER5QIqcXgLbbf/V/cIu2?=
 =?us-ascii?Q?m9s8CajmBabkqYWv0L+IsypZ3csXtQKOA7dV+aRTvt2e1vis/RpIJgR1flJi?=
 =?us-ascii?Q?thqBqLmuiP8bVppgPD3hwvF+jNYzYsBROMGbLoVsZ2xR0+dv3mle7r1s6Tyu?=
 =?us-ascii?Q?FWKRvoBjIXuxqL/9xcDEBnXvIeRVLo8oxp6XnloLQ1ARND+xGGu5xzYvaudo?=
 =?us-ascii?Q?jsH4vV6sakOCfE2sDuSJVwjqrMxq7FsyK0IILEGCInouFCwfd9n7NFWFbqJy?=
 =?us-ascii?Q?WP1AUolzdeLaUXvUBvWR8Y+HaII4eTkNHuTb+4LRniiS+pvmbrBLth9b6lzg?=
 =?us-ascii?Q?e0AdRCBz4XSAqVgBKsU4PPeS2FCFpVr5USA6CuSqohe5FmuDZUcoAdOhfssi?=
 =?us-ascii?Q?lmIUD1C1YLyhlrj20xagymtCIodDlHtYrwYh6xe8VyBgyp0WFxwVe9C8BByR?=
 =?us-ascii?Q?L1P9gHvW70TIwIkYioZ3pubH2M3W+nxHfjxymYpFT6tzCL4wZg9lSGy49Bhu?=
 =?us-ascii?Q?9eAxu/UVnCPg4X5G3sC1pAieKV/CBpnxnJ8G167yoC7rEBGel0qUc+yFmwXC?=
 =?us-ascii?Q?RYqQSz8GSVzOEXKz/af7yTR8F3GGuW6LNxTwIHDBqy7ETa0K+Z/OHOvYpjn0?=
 =?us-ascii?Q?RJtJLIjTH0PHjtK0vlBPe9VKkV9ReciCLxkWTMwt7aZatLKX+LRhSzvNmrkq?=
 =?us-ascii?Q?6GU8NQRv1DwK26hm2F0ZQ5NG+T8+M6S6nkoWiT8Rriggw2DLTw86+ltYkQk0?=
 =?us-ascii?Q?RGOrIjRjAT5M8zn4AhGYmYz/1u5NtyxXTUP/CZ5Ep/N7NPQGr/RcAhLLjmZp?=
 =?us-ascii?Q?j2jJAHbFVA0dMc1Lfj0NIAdIPEPIc0PhZ0BTu4LQ73JV375cGqcmluSrh1v9?=
 =?us-ascii?Q?xzeiu9cFMir9AdTh/hGChq6dBe3wqpLLspnoyN0ijobDl7diwarC1nGjxg3s?=
 =?us-ascii?Q?cVtFlggzQE3CVZQ93a4s/nRGhnOKZ1UWxoZi9v/uqUky3nZRuz0dp2SSc8s8?=
 =?us-ascii?Q?APsnANEWow5CCTMUw2oGbhFtyRIFvjFbzKgJbCQPhJ4/EjnJTNHxGw7K97eP?=
 =?us-ascii?Q?CHeeNSXesDa9fhpQEeYzQ5OGWr+ed7Lx9aPAKuXycqmuMQKrW58/fbBmOmr/?=
 =?us-ascii?Q?E2U6vRrtuL7ChwHsBNYryHVwmsP95odV8UhzRjx8AtJctTykj8reWRSCLGo6?=
 =?us-ascii?Q?twUMwVV1i8MOJc7uiFddcGSL9j2RD7/9YoNFjuBpg1q2U+17aDaMdUCfKuaa?=
 =?us-ascii?Q?Yvg5Vo6ohLmLhbz6QFx40Uy0rXaIF9nXYMtqvN94zPYA4zY4NZczgT2hpPGP?=
 =?us-ascii?Q?J1pN7l0DhJa4yKrI+JN542Gj4BsdxE1uKWOvTeNECncSxXyuSf+qWIF5mqH3?=
 =?us-ascii?Q?6a+EbXmrRcdR6Q6wwTTAw3nRjPwfdd+S84jmMFxKjq4FOam3Si+qlNEBMl6u?=
 =?us-ascii?Q?4CRzln1KPsWUuthYs27sbNaLHVYnLEQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b094af7e-d3fa-464b-8d33-08da4d8e17df
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:11.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gTxH1AnZwgthPbuW5UwcRd/M1UY3B5W4amqHRq8ozRb8nHWpSUXD/6kfhbWlBIuijgaYWjEt+10U1oGJfUq3Fw9sUSGmaG79/vnyqktG9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-GUID: oT7Vo6f5xgsY0xUQ_bS5sHMroCuL6fxc
X-Proofpoint-ORIG-GUID: oT7Vo6f5xgsY0xUQ_bS5sHMroCuL6fxc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 7adf883c091c..ae1d3295dfdd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

