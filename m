Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E864C4FFB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiDMQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiDMQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:46:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADE67D05
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DF6wqS022836;
        Wed, 13 Apr 2022 16:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zdn60HCWUbckAEvBqcTxt/oylx4crYgQGJY9dQMY98g=;
 b=wBRB1BryW0bvUFy/rnQMno3CFD88liBacUjj/+oaDJ23YwAY2iGTGGwSrhZNKCF5xXyB
 lhEPwHPgo1XOiI0kf92vsqAN0MP8T/Kvaq0giZvBlvbhZ5b9E/vW6m8xCYiVrgpkoTL4
 INe/LVXy6Xy0HfWg6hzHBVb6rzTXh3kqz+AGkinmXX/kz/E5hCXzvD6W182TU4c/E/PF
 lHzLWftjdeDRxQGFBSOg++XA+/L4dQpjKR62+ndGsZ3MQXygC2/91rM4YsmktU9QGlHs
 cIDr1fHZUuTRb7/fRwsvR5o0v3Dg9GCluJFZhEq6LJfqHnbXTBrtymJsXRX7HAjtpTou HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jda8du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGPPno015228;
        Wed, 13 Apr 2022 16:43:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k3wt0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILBhECrnNWC9HTWmyyyOJwoPJ9Me8rqpvEq3p3vBGq6jRpy/oLjvLpjxCsjfvWcEkMPE1gq9kAfjNS0XiApLon5co1DNADX1XDk4jx/6jWf7/i+V07UtyU1fmiokN10zLXIY9Kba9YzG+VrKM3fY1QhtDm2P03eFdqnQqPDgDM7SILitNUOTfXeZK+eaMwMcZT9O1tR6+C1V/4fMuHe3zrNsejXGljxmgtET56iTplucnoWPThJfaVfgIvS73HB55Uc8srmv2C/szqO/OwGMz0yvBkA4gAv/XJyt75inLA8fObdZdcwhtDJnvBrr99PpSvjoFv+KitMr0NMcM4iQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdn60HCWUbckAEvBqcTxt/oylx4crYgQGJY9dQMY98g=;
 b=PEzXihq2e5FbIS1Xw8nNtpxuV0hb0rK1a8NEeuvBC/re0W00IisBWeI5ZkILr9m0sISwHIK7smqTxcEB7+TDjmnAO4Uitcez1ytEMzVBp+A/B3O0L1bCrFezz44hTcWgUo/KYJ9SJGX0aPsmpa4YpoYdh3UX4DxMshawyQSs+TkRT2HCI4JxybF28kOaK8AP0Xf2yUgUksD1y2M8gFtQmpMaO7OxlEXyhnuGZSww7FByKIfC1UPR5k2MIIBQUa9+RFRK5Q9T+N5LJ6h8qIBVTRZBP9fiBM7wHrQ22bDe3HajCtDdeWG9goXnC20PH8Gd1S53rC9XRNTpwiho0S7bEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdn60HCWUbckAEvBqcTxt/oylx4crYgQGJY9dQMY98g=;
 b=P0QpSWRYDnFCpmtnp+lkuffA8n9zwoc6oPXFnp0LRSiHciISbMzrv2b2dCxoXejkoXXTJ+TIcRGB0jKyTkeXk45XpID6iFnoZR8+Jxdo2LLQsBG2Kd+NxSYFFdhlrFlxdkeer70EkzGkw7M25lNmnf/OK4gfYG5Ky03lpzBnTRY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3562.namprd10.prod.outlook.com (2603:10b6:5:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:43:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:43:08 +0000
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
Subject: [PATCH v7 6/8] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Wed, 13 Apr 2022 12:42:35 -0400
Message-Id: <20220413164237.20845-7-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 330f1a34-2d9c-42df-e983-08da1d6cb0b7
X-MS-TrafficTypeDiagnostic: DM6PR10MB3562:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB356221931F9533A9C5DC205497EC9@DM6PR10MB3562.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25KnZXxg9xLoW8onHnxELE4KQ6hx8EjQvExesXQhpIVr6fljnc2IMWNCJqKf0b4Xjbarn7kFvlKHuNJ/4OTX3gidC4ARSJAvUTmoMWHxguXjxeNuVlmKDTHWQcmrd7cSzxje+2J9IjInaPir712nExf0/EebLJPYonDuXlEv4ljhXPoRRhmvwXookVrznd0gDTxbXnvSwhm3m9E/qjsFJ5qFHSDmTk4k0yftIQ/YrLdKdvh7JxhIxrXj7+nhAuSOkyShO1WBDqcElEGAJZghu2SvssVmkDVVuUFFi562/DHzO/6dOzFM9OuYN/Tu4aL8C+yuQnmHGkh2XnAG2wdl6bt26rvHKNd+mhZiCzqB2dB2soOAwhZWfubOTGMq1qWTvuGij6C0U5ebq06quppoYWpj+zsDbyK2rOKSWD1gVHNHX9Q6OfN1nMf53v6y2Pkx3Fg/cHrhgmgzk6KP7ekkE63w4MMqnNpgHO295VvJoTcW+sLc0KWy+RO3e+Tz2J3yxEdag9IzNuhmuQMGDvEc346fBlNLtNH9g4+LWNhXM/7Jfn6n7jABi1VZVFafHarwq3xd7InlFMhHk/6ucviqPEGbAMsN01L+LCkmoLpcCllQNJQe3k6weVoy76L4Y2oEpz1bIp8pJXQzbvUz2Q1qlL9M5rmsBLjFoVreocVWZSrLjliAm5pt50mB7gUTUyMu0Kdw+gE9c1y91kpH4yfVbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(86362001)(66476007)(66946007)(1076003)(66556008)(8676002)(8936002)(7416002)(52116002)(2906002)(6512007)(38100700002)(38350700002)(6666004)(6506007)(508600001)(316002)(5660300002)(2616005)(83380400001)(107886003)(36756003)(186003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGrxUIqcaOJhbUQOv84Vc/CrqmDnejDISEH5vypjIRHj4GziPK4rdR1sqqsI?=
 =?us-ascii?Q?+wZIF3ZH/kETRSIZGrkFWIbYS2ZBTXKhOTg3Gvbi/73LTFAIgDuS4pXYt+9q?=
 =?us-ascii?Q?uOdnNg1eayjPfa50xNDV+zPw2QAjqvfLugQc5W8SRULz89P1NIfC+M6KYM28?=
 =?us-ascii?Q?+mvjiC+LG4+6miMD/oXGPUg+8kJdJZhtMKUQpoXaUNSpcFew1VGr3oJdc6Lq?=
 =?us-ascii?Q?Ln5Me0UI+UDl8QszeFzjmpkl8hNVaGsw5hqonoPa9kBz+Mwl3G7rnpKMuz8k?=
 =?us-ascii?Q?NfFzxwKWL/aS0OrV8/dyx6dqU9aEdsf4yGM66WTAAEvm/7iA8Z0mwkUTNppM?=
 =?us-ascii?Q?67csdtyAQxm9ebRV8F5xHulgVNaM0Hcp3FawxwvWya6Em6X2j0PeWds6VR79?=
 =?us-ascii?Q?bFryAQusfaNOftYSEf4tp1XRKrQPSaUT/EVyQBihDDDQky7V593lLaBr/cVb?=
 =?us-ascii?Q?l5eY8a9bOAVVBiI4MiLZRcF1RBYgylD5oyfPyBBI/QojmbqrlkVlDh+Z4lhd?=
 =?us-ascii?Q?5UUqO9ajml8BVBz1vd0+0rnJ+aH4iV91m/uuUwkiPamEBdZewUY3QIBr6PMv?=
 =?us-ascii?Q?GJ5bMr73qORx73c6nh94Xmuxdzh7lTt5qVwOGWnG5TAUIpMlb5xiQ4HcGeIm?=
 =?us-ascii?Q?WAChGFbseNaLOPcKqmg14XJQbzSw3DU1uPZeIVvabTxyCT6+Pi4GeB+1dIF9?=
 =?us-ascii?Q?XQO8us4wA0TvqKBhx7yJmHkm1MyEO4EjOK24Jk1Bq1CUYRcsHSDjN/YLwBKh?=
 =?us-ascii?Q?OCReiGFVXEr5N+G0342jV9+jeSqzCNIl7lHBLhYsEOsmqH31v2+HlWULzyF4?=
 =?us-ascii?Q?ySebc55i85M+B+cgp6ltpPyZOr0fMXuPSGDh9VCGM+YexuAot6PDFdC4isYr?=
 =?us-ascii?Q?hVFTniP/bjqtpUJZcNW3Ty3bXJagnhUmTjX91zAZkcMJL63Fsd9lOxMihkB4?=
 =?us-ascii?Q?oJ/caL/W7Jm5jxDMX2IOvog/t+FeOeONZBjMHhFJmCXl1jLWoGZOm7BnV4jR?=
 =?us-ascii?Q?2SLpRxaVYUVSp22a7x2ZH9FikllhXrJtmXReOv6kzUt8Yef69UHjUoOYpxWM?=
 =?us-ascii?Q?F6WE9f3n9FJyHpQKQTBYcbKK0sE+NwXuu8/QrqIgUkb9wTT6qnvNdOqe/irP?=
 =?us-ascii?Q?NNMxdCLGjHf/xAi+OhZXTjmnl+khf3PAcNhjljdJY10JOyz3qC7Omg/EPpq2?=
 =?us-ascii?Q?g1kY1s4wb9athI6R78H2b4wBce0/yVFkEOD6TZscSzxgZuDQsOkUTAtw9coA?=
 =?us-ascii?Q?Iv7qtM/Xrr4aE1/PfKG633sMx65uFH0/8dxVVdlIncmhueEac0sJ5VrP9N30?=
 =?us-ascii?Q?DRKKDqwP3cI1ELW7bV+pxFfn8jDJB7k9/NfDy4I+EpuC26IZHDIgoRpiJYqW?=
 =?us-ascii?Q?SmFx7QczB3AQix7maP/4SKLpffA7HJcg/PsJkm7JXSSL+x4ZTv64Uxr2eJxt?=
 =?us-ascii?Q?asim011kcszziFlPDbaEmuMES6eSpPiFm6sbuWTPQLpqlx/4BIpLDTH6BHeK?=
 =?us-ascii?Q?q2jFHO2NAdsxsyQPzar1xJAH1HV15P+FHz8FgDi8tLq1zYvQBZV3hCyp+hND?=
 =?us-ascii?Q?MU/jaD8/eN8h4u6Bp5NyNioot7uNzgU2m8zBNOJO8SQKmuUo/4cCNpzACy1i?=
 =?us-ascii?Q?SFFqgRZUQeLb+QUyeURKdCPq+ifQEbVXS6PnNCid4Fftq9tLQGQklK17L7oQ?=
 =?us-ascii?Q?xFhy2LSkEyvKdwymbT/u+3Yb5+QaF0tusrjSkQkSOSlVIXBvMT43wzPA6Z4T?=
 =?us-ascii?Q?+2H0oQd8tnvLU1tgVo/WwEpzFXEEGzQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330f1a34-2d9c-42df-e983-08da1d6cb0b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:43:08.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyReFIk1qOafXwHefamp9kGH80/gXTaUQnTmyYRWD4J+DwaYKkSAlSeqrYVXgTGRBise7xLrs0F7pVQOA4JuMzx/2NYq6F9KbmlOPwt101I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3562
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130085
X-Proofpoint-ORIG-GUID: YHzokLuWxaRzDY_gjJehJ-X7lS8hIrFY
X-Proofpoint-GUID: YHzokLuWxaRzDY_gjJehJ-X7lS8hIrFY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
crash_hotplug_handler(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in crash_hotplug_handler() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 9 +++++++++
 kernel/kexec_file.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ecf746243ab2..036243b1f252 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -521,6 +521,15 @@ static void crash_hotplug_handler(unsigned int hp_action,
 		/* Flag to differentiate between normal load and hotplug */
 		kexec_crash_image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ? cpu : ~0U;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 94a459209111..9d5c4eea0179 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0

