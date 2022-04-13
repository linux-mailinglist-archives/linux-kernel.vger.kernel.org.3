Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517934FFBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiDMQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiDMQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:46:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6512AB1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:44:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DFSURf006846;
        Wed, 13 Apr 2022 16:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=A//cTzkeF1PdDgO5td4qSSPJn7Hfe0Dew9RHnD1Bk8BdYxiKtlip4LNz/A71HUuplY8P
 XJhlNUNasUS+OZ3XM9s1nAtUFPc2F+y2Tl48UQ1G90KrvXNOsVopKh4voL4ZXZVPniP3
 QrtW9/88UTx6BLOLAYdXA9PEDYGv8z2XrELm3LDAqRsgirlb++tnhdPBuKagLPchn1Gg
 P+g1yWS1XOT3QMbWEOzPPcrmErzouMukxPWP5LYLvi086p2czO4nBbVTWQoF2IAfWUU8
 x3b/zG+mOjKUxlseWab/rRy5TiQLVK/FBocL8SH0r3KYv+4sIkE3ke5W2QwTlftTuoKu hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsam1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGQSx1031039;
        Wed, 13 Apr 2022 16:43:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck143gm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8dL2WlcNhDb4I/86AChF53zB+NIM7phM2u6ShVaQFqfXsQXMhTavGRfZL736oBOnMtYRE4j9JP+eU6u/sDJuTDcXqCpmEDtquUm7+3NHr3BDH2M1q5ui9lZSC1oA0v8q63WlNhFkUXGymmuJ2O/J6s9SkV40QQu4IYbQF1XeCznIGQ27yQ9zPufdJNhBYkC4q6RG3KaGMcpvtSp7w9COUrwzISeRKa3JQv5Oy56sa+doeNWzj5ENBvVqTR83FGBAHHfQwlDg+NI0Y/8f1sqMCGNtnIppTPupAx1CkbPVLIFqXTf5ZuHZAcUxSTLGCNvWpTbF/xWGkkYBhfh6gj7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=EKfnumbp6hOMGqZAC04TkApj7bxEF7FRe0NsuAGf/RDX2SBw/kc4rgv/7LGb2XChKX6LQAot5cpiUM1gnpuaydvn+T5MbaCbj8kFodcIP0cgyhiapNRJKdM9TJg6VG7aXE5NjfaCvQPb7QkFlxe27K3XZ284XARjUI7UtpPSl9fGiNzr4LUZYvNCBx2CMnm77vrfSnFqZ/aZyN1NIbX7etPktmiItJtk8j2yBf9Mlzsb/SJiYe7mSpyWCA7SHiEFLB9V4Z5QCSpETCvRagLi/vEdYagiDbWYrN16jawUPtsiZFKdAE2aJItkMFQvXcEHWyyohtWTbbBivElQeIrqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=dxZK1XOvMpLhoPEyhd8kL9nmEQnvRYZ68YiEeGckl/4xPtsvWTWr48RJ4W1KWD5pNXdyT84x4kvTctAtbBaNqG2Myhg97h8XzvJownOs523NMojMU3t0yKxg9B9B0OFwkJHSSGURM/WJpv9yf5rrOk9AtwU075jDkr0kwuh80mQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB3560.namprd10.prod.outlook.com (2603:10b6:a03:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:43:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:43:00 +0000
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
Subject: [PATCH v7 3/8] crash: prototype change for crash_prepare_elf64_headers
Date:   Wed, 13 Apr 2022 12:42:32 -0400
Message-Id: <20220413164237.20845-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220413164237.20845-1-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615bc69f-5047-4646-e485-08da1d6caba8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB35600881BF42CA9EDB66734597EC9@BYAPR10MB3560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuOc+2J2WDeqam7RxUAEhI8YHW79rIE42oP+VtwAIiSJE+UBQwJ1noIRcuVYsNfQjYLzuPgBC9ltmw/PTrGJklGHpJHx/s0fzdvSt8uideFq+CyRsJPxcWJXAUFEBmsLbbCY5iS8yWFgEzZ00xLC9Ykn1X8l51ZghjmPJriXh/C9aV4siXgR8kuO4u6sC7kun8BkdnjcWt33kekJAHgpJUAeiUUEHW4Ah5DJzJVZmCzIT80SVG2CyDRLmyS6w/zcoEA1LSqsQ6n9Qw0xcsoddLulNzUt6W4xvpUyTLZssWunB0Znpl2cqVvA+onHYXm8nJmAODxnFKMScB4u3gMZr675QiXNDfSLoRlj8usRj3bb6KpsKYpEIWaBKnMau5gn5wFFsMyujLfK7gqjl4z0ylaihgHiwRYHrtY8a+gnK7LCOB2ER+2S0Yb0CtuRKEo8KuKB0jC/ISJdvq9up1WqpbYU+Up3MWygSTj9cYUJikRiw3jtDYhgD/yfwgbFnfroFVwUEuOLU+a/ZNtSJj1AzSqWloFa+BeB2ohUZQGePeiYG0FtV8HJiO8ldkuwwhacyPF9OQgxliUHtRml2ApWQhS26+BjQ3RPd9z8MEDCJexi3Oyy5xJK2eZlAq+OQixvRMrrKNl57NKfKe/28R+HZqDjkZGJtAjfjxF/eXT4Z0WJ3/HqpuRGcxcqn1miOr6tm5qKStjYTSAiQwEsLmNm1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(83380400001)(38350700002)(66556008)(36756003)(2906002)(2616005)(6512007)(86362001)(52116002)(6506007)(38100700002)(6486002)(508600001)(66476007)(186003)(26005)(107886003)(1076003)(66946007)(316002)(7416002)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19dBkwTkvalPJsQALyAkqo95FncDxXeBkJIxY1MvK2QrUcUYbioIE/975ihR?=
 =?us-ascii?Q?3OVWxjCfJNqnDkykoD82ZLw8p18aFCfv8749AtkJGeiBwpo+DHrRchKp43iI?=
 =?us-ascii?Q?wmq6yZz28AzupTfC7JNwEoQdVIdOcDCi+fSvhxqZbvX1BMXavOxc6u4DFC5D?=
 =?us-ascii?Q?ns4rMxmGmXXN+7h2O7eJROEladGhpUIlnhzhBkuk1Wd/9J2FCQTUKdatEQlh?=
 =?us-ascii?Q?dPZUvL2qWI0pqswMl6WBD7JUFVKqU8g44vU1hOlIHgu1e5Rku9XYrn6/jsaA?=
 =?us-ascii?Q?qkNB6qDqpggPt9ooVdRTaNo0U7VT7Rcvf5qomKot7saTnj53nIEPzHG3SdBZ?=
 =?us-ascii?Q?MCSIPe+nXhnsA78TNzNKQLSDbQzVtxksR28BQxLRlCklFSE8Nxk3Lb4+VJEb?=
 =?us-ascii?Q?oK0NY3nBqj9XaEGawqPHlbzC6+CFwLIB8hWTQWfKI2gaeTJ2lcR3OKi+1cm3?=
 =?us-ascii?Q?JmKqjP9SW39uYHdSaLlhYIcTYjJiab/u6IhAYqWa6ZfwSDzqH2UGd8gCDCaW?=
 =?us-ascii?Q?rZai09KHgzESwiYHKIF9zqwOzIzjEG6y7PCRwiUfCqFbX6NYyPMwnZIORlef?=
 =?us-ascii?Q?UrfpAoBRL5Fq6j5ifUDPcE5mUX1OeIPX8lOWo4JV2U0RyefgpptpbpJpTGsx?=
 =?us-ascii?Q?V0fH/nZQFr3/9imVG558EuKdoDS2VHTeRS3YuQvFY4y1O0826RflSTd434qY?=
 =?us-ascii?Q?iWoyHiolOxQMRjyHDL8muH4FDU4Cx91GgXW7CNFcJx1s8J83j7N/+OP1e6b+?=
 =?us-ascii?Q?+zPr2N8png680KZrsGJl5V3TIJozZDSXLX/61lZJHhquPIaTw56XrdJGJ01X?=
 =?us-ascii?Q?6EaauhW1Mmgaz0H/4efcMLMKxuH39tVLldZy1BqKysrmlVJUkgmO6jSWMmZ1?=
 =?us-ascii?Q?GddT19TGQ7mJQKs3o4aAFwoxlol8UPXEw+yxnUUWX0Esfvs2U39jxArQnzeL?=
 =?us-ascii?Q?EXU3RghPu1dGF/5Lm9vBxojOzI5b96krohfMrCWDFgt8qtOqHge23izf90yY?=
 =?us-ascii?Q?rAyX9wn2SmHvJNqAdtYCjBSNGdgmCKh0iNoz6T799bOiizZBmnf1yC6+3JX+?=
 =?us-ascii?Q?R03xS0/gVp1PCrb4eGushhDo21F+hgoXvoCnu1CakPRp2XUOzjG76yPkn7Ft?=
 =?us-ascii?Q?u6UQTNrDkmgPmmz5JP9O59sCfN6S2p4GdOK3eZd+e3V/Q6lIB6c5CZjKzlWL?=
 =?us-ascii?Q?gjOpMIRA3acFfqPND6j5OfOm4snj2iPi1CszDpdMYWZ7EmPlaxHbq2Z5Mjl3?=
 =?us-ascii?Q?h0DXydO7xaHJIEwgG9vEIpLI0MLVocBnA1fc4Q4Tmj9GlDIkSXE3m1Ddvqz5?=
 =?us-ascii?Q?2KvLvSM8kQUkYWM90SZdl67sp/G/B/2uinTBdi7K3jpzkNkVCS+f4mnXaDEf?=
 =?us-ascii?Q?/IVig3Xvxq5Vaaa6xVtgGtNGLWueBIKiy2LsL2xJpxSr5dsGU07yPmIMIiqQ?=
 =?us-ascii?Q?m6ij3PlyrrDTLb+7HQ5momEMR1+m7GDJtpUsrJ+v6tNgh0YQvxflifdcuDlX?=
 =?us-ascii?Q?17qhMjxXEHC1WjQWI89iRY6+rbur1Gfi9seUDHhQvcwFRe1JwAr25MrHAbJV?=
 =?us-ascii?Q?ET4o3kgZXIIpkZsLK4gZCn0pYbNc+7yMU88chIGYsGpK167Xi9z+uR9PvZTm?=
 =?us-ascii?Q?hne2Hl3oJnPISiTztMHHMghd3ppCCGmB9osiBu8Wq9UJIy8QZ+bu3l4FyQXt?=
 =?us-ascii?Q?hmQm5RAsvYClx79e4C/wpa2lfQ9qVlfVxyXaImSbpTOcqoh6WRK6736gdEOy?=
 =?us-ascii?Q?UAWo0kzi92H9zKzAvhcriDGV+lt+zQQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615bc69f-5047-4646-e485-08da1d6caba8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:43:00.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5+N0BpiIDT0qEQNGkdMkn/BkGJRHc7HS9W8VFfld3bjdiGuaG/58UEVwh5XyDpyKetYQnXphT52ZEi00d9+Ak6Gcza9wUPohUPY7nxK82k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130085
X-Proofpoint-ORIG-GUID: Rmjzp0uMTWQV8wKoTXupa56wqbeGW8mx
X-Proofpoint-GUID: Rmjzp0uMTWQV8wKoTXupa56wqbeGW8mx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers().

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 3 ++-
 include/linux/kexec.h                  | 5 +++--
 kernel/kexec_file.c                    | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848..7dbafb42ecf2 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 
 	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 	kfree(cmem);
 	return ret;
@@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
 
 	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..07da6bf1cf24 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9db41cce8d97 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..f93f2591fc1e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -227,8 +227,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+	struct crash_mem *mem, int kernel_map,
+	void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..801d0d0a5012 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.27.0

