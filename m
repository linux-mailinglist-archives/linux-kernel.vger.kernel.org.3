Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080457D329
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiGUSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGUSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCE8C751
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIEuc3011725;
        Thu, 21 Jul 2022 18:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aYsmt359NudaR+a45T2x0bA8pCU7wVEevghnKueNqJg=;
 b=OiyOPUgqI8qygBAsuHP8i+3U8uNxc+bBjtGH+0s43HjnHFVZygfvq+TjN8dJQRIfmrnB
 Q2Yn4GtRo4VbYJYhc88fd9/8nAyx+hofvyRiNp/32NdwudV9LHS5nXxXsQCnVOZNbNGR
 QYCJ6TmNV2TzCd6e+vEXG4Ush5FfXpfeSBEUCTg5NSAUnNSZ2TJjrXVl0XerTOy8YCKT
 OEF3WMtkvOZBknizsUeoKhRmtOmM3B0MwPXwNHtaLBmDtpibC0L7lca2jaEEgnNw3MDv
 j/J01/4qxM8sPoyKusdsQSdiFYYW5fDie47HfPOrXHjtL7K6B3DXDLap9epmYyocMb5x DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7ad403-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHOcli009824;
        Thu, 21 Jul 2022 18:18:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gjs2xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx6oKqVHIYla9GPPX0NeTTfWL5wo5kvk17qM2Kyj4PdGeJg9T+SXPPf7Mb/cXOy6X+XHxZQYmMPX7R3tfGuN9dMqlmTUXSSWlpvDaQpeQbhKHsBwwlUDaGSDhYqzGkfWkvAl0FyWw+DbNiaKovOUdUNTZXKH2RHPUELY6svEeeNug/+H+AclBZYTZEvz+gsub6JcAq9SaXvd/iidJivjT+0h5v5I9b0XnNFyNinwBPPgoY5t8N5n84iPJXmY30Mkfr4m9Kf2HM39lzirXxG+7jAupk6yBvrJ4m61vJa6GJ5AdXy9khg453aS+Ief0DY6aq4aRi0Ci/2NQSfEvobZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYsmt359NudaR+a45T2x0bA8pCU7wVEevghnKueNqJg=;
 b=F87rIfXnvK41Mjy7Wayx7VINLFdPHLwEwQi8nCLo2Y8bIDy6d2CEj4vm7SATwYGN3P3SPUiXc1oJ7Kjw/koKKoHtYyIRmB6ChmFQtMPrZ7we1zBTEqrI9jz05uFkX2nPNoNSSx64kCYPdaowhF41vJodlLij2JE3xkmTumx6X8klBDGSRAIdddMNVs9i3EsBWSlQLvr1nrrtQ6ILTR1t4V5emalMqYAOtac2Sx8Jw199aBDcWFHYwiWMKvdilPzMk02qQFPzmnlVjNaV0jG8p1wAug7dVF5gcQnHclMvZPZIud16p7JGb/UsmnzOiz55Azs3NK2fkWXoocYelLGDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYsmt359NudaR+a45T2x0bA8pCU7wVEevghnKueNqJg=;
 b=qJ+BAb5KAEiIFkGxkPtbuBMN6EZmQ9nJEWAfKZv6Wa7O4yUpXNp4c5iIlgPrKyoiTN98n28RUgTXj3Aqt6+wMqiEhWvmGQuoZWYFzMOzZLYY/1I8LwXBmel4Ql1F/lZCPKSX0ImnWJEI9gp8W6rFbGX9ZPjgZH6WObHXnJx5QW0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:16 +0000
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
Subject: [PATCH v10 3/8] crash: prototype change for crash_prepare_elf64_headers
Date:   Thu, 21 Jul 2022 14:17:42 -0400
Message-Id: <20220721181747.1640-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220721181747.1640-1-eric.devolder@oracle.com>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf0ddd2-7e45-4537-9d51-08da6b45619e
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV/iHgjpzoo+olOaoMZfhzIamewA2t3OE1L5YO8/zdSlAsslRkMrA9uF4HZJUWE0MlfSqsYoNxAMkXYjUACX5YmaaEODJrDBtYV5CX5zKm+uHcaDMTSlD9/b80WYZ31Xinr/qdH3jFzNvkvxye4wN6FHg+K6JeOnhWR7l1rANnOImj2hqU2tLvcKBBUC83Gyv+UZHxT1O+tbxMJevGcMaFl9bwIYf7AGF/0qSLqEKviwqSv/0p+IRaevb2nxoG7xjm7ZoJjh3cPJ9Q205ydEWY55PfHEMF1y618tAZ+kkVSzxH0x8I8sg3jFQMmXrzB1m1pOeVz9BU6hqVkLdg1fdXhTlZrKxq/S3I+e+H/ed7il5pIb5f2fHInXXJcHPH8xk1iKQaRlwGasiFQZ62KHLcKWUM7TyqyAFWCEG+8KHVCT7OQEXAqrpD6jok+g4LENOui80RUgW5CpKh8bQjR1jaNZ+ggwDTRjP1sROWBJba7Brxg6I/W0mesb1EnYeVqzAvb1apeOC26+H09ebEXXw+ngFQhHU3T5rqg8EvXkDXJ3h3m2qKS14HSyndRcc3g7/lt5r0295RruYrasStCHkyEYKs9GKMc5cC853/HOmaK0MHgncTHVLOcPpWDG3N9anbSQLSSS32NFh2swCCnrj2oqb1jInMQOBlzFYkcXVpfcx5QbfRUYNrbLYDEtVl8DFGkvUaq+t1J1d2pnJC2c/wCboonPxtRiEJfmsb7kPvnaff+FKwUcElWvyZNyzTZaJxK4ohhg0l1qR2Z6KUNm904Httb/8KCUW8qj/LxTy/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(2906002)(6506007)(38100700002)(6666004)(38350700002)(66476007)(66946007)(52116002)(8676002)(86362001)(6512007)(66556008)(26005)(5660300002)(1076003)(107886003)(4326008)(8936002)(36756003)(83380400001)(316002)(186003)(478600001)(41300700001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkdVwXI4G+floxdUzRPcSnvgtk8A4uEfTcbXdk08E8nJwRfpabduileLLDSE?=
 =?us-ascii?Q?q3lPCAVj1avm41AKcW7zcsYLSO6ASiRX31z2pdyPh/s2l8nhjBlIDxOmk6ih?=
 =?us-ascii?Q?MSZbcxOY/YHeyrsFgtO6IYg5bzYoJXqZ2qXiIu5jYmfRUBMMAjjXD+fdH9cM?=
 =?us-ascii?Q?vEzBk9CmGxVZ9WLUm2r+SIz8PSKJaB9gR7WpCS58xnbFAxr1wLLPej2MX4ir?=
 =?us-ascii?Q?CkyGcVmts4qJdlSgpzTeW3Z+EF1HuoyY902UrcxsAgfcfm2dSJC+v09ye1zf?=
 =?us-ascii?Q?tLD8Ct9i5lgqXC2dEnOi1L9ktaEg3ifFpKBk4HFI4Ngu/0Zj0PUKykPSYEfi?=
 =?us-ascii?Q?qSmhIZH2hB/tF2l4sPCjai2VJhIeo7sDWk6ENKCIyMEvsEYOGN4h48WXUJ1B?=
 =?us-ascii?Q?/V/Ze1Y/gon8foOoVMEUI/u+2Ud4W5C9x+ygroGVcfEw0j9VdK3Z3dj+ScQv?=
 =?us-ascii?Q?7BvFLQuFEzhyBMgUMadLrRTw9v1pEQiMjOmOp46LxqLt8hXjQzUGE26sXFPA?=
 =?us-ascii?Q?rElL3NeQzuxUaD4V0fN8HiaD7iNQpiLz3XaS4z7wTAL3z0LCtTCBcFtPoqzb?=
 =?us-ascii?Q?NtBU7mHROjllNqYoVm+yoFnmcCMn0mmgs+a+Edndzwp7XVTR/6l3htcpAqsZ?=
 =?us-ascii?Q?uUyH1e4iFwkjfYlFBK/w6NUBRtOH+SbUZPaYappyVjcmoN17F68tMDXkFc0u?=
 =?us-ascii?Q?eilQNeTPnwF+w44saY9g9LfjrxN4/BEz338xyqftz54k0E2xhW3i94qB4lvY?=
 =?us-ascii?Q?gJ+bmOgGSDP9fX+AzOuQd8N1RDJnktAilA3k5OyZKawL8wJQy+kJUkG4+g0P?=
 =?us-ascii?Q?avm3az1g1pgOR14/RZKpjOgs5Q3Xo8RxxH1pIvZpMuUV+JqKlr/iPV9HgLZD?=
 =?us-ascii?Q?sq/uakEnYWmv0/q8YwCbWzGxcXIWooyuhfV5e7QY2AUf9l+fioeymC/rSGQs?=
 =?us-ascii?Q?88CRuocvqjUVUN35+aHD/6Wn9nrO8oZRTz22rmtJexcHGwBr6dDsjOTPC5Xv?=
 =?us-ascii?Q?C3gaRQadiyz7+32rc4Jm1Z5bM3aPiFmXBC0KojzonL5AR9ZVeLgiRNN4HzzR?=
 =?us-ascii?Q?EkglgAr8RilunV6wlWfv2owxXM0X008a9ZXEWLpkhds4ecpOLIVTDbe3AH8X?=
 =?us-ascii?Q?lxHAKVaRqaCRX77Uo/8RbJ8VQi0QNpBSN704L14NzA0gn6BCZSAVAKCC1x7Q?=
 =?us-ascii?Q?0EYNmvyWdjudLIaN588/L98brbkrQqN9fMcnb3j1a1tu6qqCKuuBc3vvO6Vw?=
 =?us-ascii?Q?nI53k+V6Fg8eeNJJ+19Qc15Tvg1xyPSTmweCewfWC1MbaNc0jf5jCSVs7lqe?=
 =?us-ascii?Q?KWq24gb6t46TXTedbn36vDDl//zaqLOoxkIKwrxkSyVGdpmKKs5Y9MNZ3Lg1?=
 =?us-ascii?Q?L25Ax5bG9wkKsy4K9EEBmbVnw9u+y2mx6HZ0gEQQ9bCm8lWM67dj7zamdizp?=
 =?us-ascii?Q?TR2a5SAmS88CxO96O3I4osABc797lu3Ul0MuBUVTpQg5MhkA0GgkB+8qbZLd?=
 =?us-ascii?Q?oCKogQkm7ntf5RM+AfuSFB+g1PPANQ6FuT/9W4ybNlLMYtGsO2yLx8132AqE?=
 =?us-ascii?Q?8coIDCcIdBzngXrAwNCW/3us86DSxFz7Zcv76l6oKANqHbUCbAKulIALahQq?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf0ddd2-7e45-4537-9d51-08da6b45619e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:16.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI+WTbwthaWMz6CdPEExUyuZwj5SwPfr8Badiw6JKHPvBHAsPVhWNVEUcCwiDP5b/cpm29BjXi/8fzV559VO7VazYWEj/zqIFooInkm0LFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210074
X-Proofpoint-ORIG-GUID: QWwm9eC5P793vwf_igM9kv-AdjB6eNOT
X-Proofpoint-GUID: QWwm9eC5P793vwf_igM9kv-AdjB6eNOT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers(). The hotplug members are added
in "crash: add generic infrastructure for crash hotplug support".

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 2 +-
 include/linux/kexec.h                  | 7 +++++--
 kernel/crash_core.c                    | 4 ++--
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..7f5f8243928e 100644
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
@@ -64,7 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	}
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_mem_range(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
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
index 9730c88530fc..9ceb93c176a6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 475683cd67f1..5f4969cf3f4e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -219,8 +219,11 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+				   struct crash_mem *mem,
+				   int need_kernel_map,
+				   void **addr,
+				   unsigned long *sz);
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index cf273fd7c18b..212d4dad0ec7 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -303,8 +303,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+			  int need_kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1

