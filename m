Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7534EF9DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351114AbiDASde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiDASdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:33:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159291DE6F1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231G1jvV018556;
        Fri, 1 Apr 2022 18:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=W5tb8Y4EZrqE+buBQyCcqLXXj8lp3IVe7AD+EuH3Rx/Jc37gOpc9voQqR4EuXugE+M7J
 riiN/j/LqzCSGE8TFmYdo4BqER2R1OC7lmHnJeLHwO2m/xstwKm3yUXszrteoDY30mg8
 vJYJBW+8Y7jxbE1I0oCVT55laZG9DDCoc2IifFwI6hbLwBC68mtZx/r19TwfzW0Evy+B
 9p8EaE44JhdWuzlhTk/UjdlfMnFPlJnikFZCgs0Km9iNsXVGRr0VDBOzxt7cGgTWUQKs
 IMKX2I4vIdh8E9tnAt14mwqYDskISRuCbJkwyYeUL+5hTVlYpNmhIHJGqvsKDOBII2DF ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0qs26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IBOsM011970;
        Fri, 1 Apr 2022 18:31:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxpNMk0zZbloJWosLLGOusrwLeHTSxDl7QVvLQ2h5JDeF960S9zX3lmtcbmZkWjb16EIAhaRYs2FMgJ/vfQ5xum/DhVRnjHw05APJRYW/SjbPhXdJ8P2+96Oo1RHuijWNfU0oYFc/X87n63YG0wXf2hfhQ5icVHEi9Jdh7URNdo1dJQ8Cq9PncmE24MAZ5vQjhbLt5OGCKpLpETpIsN0jAqtUxtJJ0IXiknN/hVvaTJ6K9q3IawfYpMzH73dBRJNITJa76ZdgJvDf0rCNZGjJpCtv2SeYBWzuZ6/Ltzg8/OIeZ7zIOy/v1aKT7gBF8ddbf/8bDDlhFikxkHG1HANBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=NvEKjPgWD8kqL/DJlj6rBTOUUEfz3WrcsnIjeAh6BfsregbC2SWSPkyB/E1NEsHY8hJXUyhFz1o7XTdsnor6LKjvb8YZcXVJ1FAGoXm0f6oMgmfjJ/soUNB0s4u4L8z2hDWT4z/Oe7gtBqcYpYWgvxdchXzUqX71qNNvNJMjFZfusUSu6zwGs49ljVvGtFw4sQDT/yQrIWiJzDhSfmezEPpyPO52nSIiVZjYx8Aj1WZsmwssFYT7x2GSyKKL8ziA8Tdj0kORfM7VxMZZnp41Fbq/H/ECrLGD03OZABGOfQn4IoAccm43pX7qQ4ofb+bio93FsNG+jnydNV2glkq3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=cRiIHzwRcnJtuNDd6/z7qUll7yHwmb9xbd/PU9SPM4UHgbfaLFOWEZEPyuAxfcNxYglnm96XqA+UbCzMM1m9osBuwJsLrLfTBFrxLl+UAObTxWWT19A5No1sn3AxCQgdxBfsDVAB8LmpUs3ypSmO952IXWAYf2aISc6rE2ezeyk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:30:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:30:59 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v6 1/8] x86/crash: fix minor typo/bug in debug message
Date:   Fri,  1 Apr 2022 14:30:33 -0400
Message-Id: <20220401183040.1624-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf80a395-0ad6-4d46-5810-08da140dc4b0
X-MS-TrafficTypeDiagnostic: BN0PR10MB5502:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB55024B61E4518E9FF095D3C397E09@BN0PR10MB5502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4bu/ITpIu+vCo/7uQSTqSWLJKxvnJ+RgIi5ubkujUuVv5v3kiLssTSAx18rmHAR+JFzsmBlE3/0IRVOdQ+dh7H9tFI8ljK9l7ylP16eIUUSH/gQM4lSNEKBReoGMB1iBEQnfvZyOSH/KfnoDIjVDzFzJd5bxrrCDN7jWcYiKvMu81MsJKSLXQ8Knh4O9pfWUvGti5v3Nkmy3YKnZ9aM6VATtmSNnAx6HGSAfqL4iSpOryEtxyfl8MyDA9cqCTuDlww+1R2HogXzvn61Xsvh/RykAs17ygzxDFaSidogj7AzvowpJsep2FC4j2un7gMmTIejZaE0lYirdACUefe0JxunYFbcmxArfnrRhEz/u3OzXHwgvVN9Y3pkxG1NE3ojHiipAJCpljv9/ViwFnCz3FvK857xgyk4Fp9AvwXZPw03byL/Y66Cqfr60S6W9WkmAB3EsnQjFiL2HUnxYV4SG82QFKBD4DEjjEX5U23r3r6gsVs1l0Sn6vvrIKksSWgRdlSAVS54IMmv5+HaGf3IdNrZ9H3dE/A3M+2Xm51iSZB3A0u0Nhhsq/xwFA1eV1ONQLF9s4+VtzYsEVWkEzxK3F6g1beVXGvDVtdYY6Z3uyCqyF9gH1MI3necqWEAhZOxvhDKbfvbWRCj2F738W7yndvl3iD10vSFKsQjK5WbPYcnZnhonSU0tDYXhhsa2IXNvB+tgsqIsYiB3b0mXq+atQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6506007)(6512007)(7416002)(107886003)(26005)(2616005)(36756003)(508600001)(52116002)(1076003)(6486002)(186003)(5660300002)(4326008)(66946007)(86362001)(66476007)(66556008)(8676002)(83380400001)(4744005)(38350700002)(8936002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCT6elZeR6xmQkoBhSoPI+w/aIbzg7A97YK/j99i5uosX4sTaZGPr+uQBSvK?=
 =?us-ascii?Q?QXZDrwocAnrrNinQcLuujePgxD6jR8ejtA8jMwrdp5s4cFtzEtMJQt/5Wfhh?=
 =?us-ascii?Q?V1Xxabg3QC1KD2OVleGhXC/oz3a2BgnIvXblzT6aXshRD15xRPQiihpHcm4S?=
 =?us-ascii?Q?0zg9U2+i21bqlZqRG+bnHB7Aw5dwlfG8xpP7m4YvfrzEZ0BA2thrboyO7IeS?=
 =?us-ascii?Q?mlcuD2ChW0mlbHho2+BIqY9kkJnVQFYVAJEfaHxPo6TcuBt0G90RZIqSZrBr?=
 =?us-ascii?Q?oqDTYyWU2B7u4kM7SLwucy0JaxDMKdlNA4JUwbHGlSiQb5UaK13tRxSy2UTK?=
 =?us-ascii?Q?zuJc3aWPmaWEDFnI63ZnX1pA48hL5zwcNlL1xQ4uhW/PFLBTIKGbjh16zcVz?=
 =?us-ascii?Q?JUTA5MW7vlxQURgQb3MYcBIRU4wNG+PNUC2Up0ZCNQvIVnZLnXhVN5Yp79SC?=
 =?us-ascii?Q?f182OtYbKuO1/ZFZn2zsbKft1vNJf3x+KUY75yfpdc8Ts5DL011/WvPZiQBW?=
 =?us-ascii?Q?Njjh48zAMsaEoVFcL5junuzeA9FXvQSmE3PVfV+ybr02lJyUFVQV3NqVuy2e?=
 =?us-ascii?Q?6iYErEDMmZ5QP7nqBmoUv0bZtsU//Jm3zuXz1jPx6CCLpoN6ZWpC9vTPIfPG?=
 =?us-ascii?Q?VvyenRB19LJH76gKdKhxVW9Da46KIZniCRujmfqHprmMWMyG19nopDQ9FUEE?=
 =?us-ascii?Q?4Wk+wv5uB18lpz6BFhEYHJuTvoNJ2sj/m8vihaLqTCKI3pZX8ww6stGr3zIm?=
 =?us-ascii?Q?xhhhXLmP3rT9gZ3glFue51Msi4/h/SWMcqQIF5ohT5SrzJ8dFIQlEOw67U7a?=
 =?us-ascii?Q?SArLW8Xc/g0sX76ckHaIxLcZOqNvGpYMVdRlXrzNkMs7ysyFBkKV6LxN5VD1?=
 =?us-ascii?Q?mh13rVgVDOWaDwFPKXT6izZPy79DTwHNvGX1o+vbFdJzLqz2hfOdgu5/YQOc?=
 =?us-ascii?Q?S74VkPpdMumDvwKEuwZ128baE7ba0TkpfY1Bh9duTsyKtlgqMr1w8WfAMPir?=
 =?us-ascii?Q?3hZcKUSP/6yea98QHqGJamLBEmviGIZIZWgiyqfWyeMbpyLe9dbvpP1j7QrB?=
 =?us-ascii?Q?lJgNPOUE1EdFNK7Ac78bBUxSHHv84nF8BQ/ewlvUhdl4V/qf26Olm54E1kba?=
 =?us-ascii?Q?cQBzokq6KVrlLqQLakhBXIWAfbJT3SmQLK0eQLrLp8OPtT18M8OJuiJMkcnv?=
 =?us-ascii?Q?YAks+7rkTuSoqsPikNsvBfHT93SXEHN5n3rnWYLGBJTSbJhHg/NhIGIBmSuK?=
 =?us-ascii?Q?N94MEiuYf/PjKEubGb8wXbr/88sxQHWXOO6AcTmEvV8dsqW0sSMz6JxJDdNz?=
 =?us-ascii?Q?8lonWrDNJnjU3VE2u30WAfThs0ndv/HmfR1argUKQEaNlzKYr5rxxKdKEMDH?=
 =?us-ascii?Q?ztgPfQsIB79ef550sM6gNd6TvoCfywzhKA5zjn02+L4rDpoqjBV46d8pN1be?=
 =?us-ascii?Q?S9X1Ouup55a6s+sv8jCsB7bDs5mvGlfmUakIVLRhqPdCpWfiSlQVAY4NKlB2?=
 =?us-ascii?Q?hSE0UVpO9zxW0eaKdR24n0VCDiADPBUr9AbBtPDNDDiPQn2YsthN/sUgLjd3?=
 =?us-ascii?Q?rWITakOWN7btNMR+YgS6KlRMSW/Ka6/BVUquVC3xlklMmVmSrVvdQe3g+cVD?=
 =?us-ascii?Q?WwMEl1PyXhkAyWa8nl3bkrZk0vevHN+LRz10ojLxNkCRZ/yy01L+kNOzz3ma?=
 =?us-ascii?Q?zEvCWyIBewCNIs9s/XzNFlmFt8GwpXbcRNEPJ5kxdYFDRTgvGO2dPni3DNOk?=
 =?us-ascii?Q?2vM/NBlpb6GCaC7+qLr9AAzEZc1hSBw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf80a395-0ad6-4d46-5810-08da140dc4b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:30:59.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAlS8w4/sjLBMwZPvtyApfFIonT2TPN5Y9YKZR3o7HqyXYKtqkeQl6a20ADN51zHtmIPaSQf5P7pm7kVl8J5jzVNGPosOk0r4bc0sSZBvhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010087
X-Proofpoint-ORIG-GUID: jJ9a374pMJ0Bij4zfcdBpdkBYrExBzbv
X-Proofpoint-GUID: jJ9a374pMJ0Bij4zfcdBpdkBYrExBzbv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..9730c88530fc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
-- 
2.27.0

