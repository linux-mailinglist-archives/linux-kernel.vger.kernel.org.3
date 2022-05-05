Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B8A51C85E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384406AbiEESvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384755AbiEESus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275CB6C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245GGqE9024988;
        Thu, 5 May 2022 18:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=8dqOAA1LIumH2rIT+3bQ7GbTmea1oEn0E4R4mxeFpsw=;
 b=yPRxh9sSyDL/+6XT9dsMeQ1UklvocYBK8OWLfzUQ1G/fnYsqx0E2dZZpc2RK/d7rYi6R
 83+1nf6qsrK/TqE2qdN70ktB6dE7GwUfKfpNRJGTvMto0u5VhCmHaH4C4v5Lr/hJuRdV
 ZS8EqEzlL0TdFO9/I3PrXtlVZg0HvancwtFgT1nH+0wtnVH0iFezkhyiFPHhr1zn5ugB
 s1LhT5sOCQUF1XAPJBz7OUi/oOyyWa1kEZ+xtysUI6GYvLVy36keoUQ88/j+mn9OTtNd
 8VSe4tQx/Y9+YRf30R3FQW6DXsNfnOC2GwLQdbQ12+IZooExvz9quZG1bH5Lo53OHhav qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2m7x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Ijb5k016775;
        Thu, 5 May 2022 18:46:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusah5rau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1MRvRukkQv/uGO25e3PqZRpJPxivBy2gIcExBHSC0lw2VNSMNtzNwXiXyy/QkGyRCbIQS2K5vQr8nVH8r0XtVj/QbQQ2e7WsMsBqQSCOdKIuW9Rk8qWYevdoVqO6FkWe7dEqwWlBMGR6X5ubXx6XxsKG7z6KygOR7LxxRC6umMMqLMESgAwY84EEf68tWxsJJrQFRZuwR8gL6f7AuJ027iMX9h9tJ6Ab5U1BEmfXnKugbEM9SI1HCSHHJQs44sNHIAO3mcrwJk15lB4iqfS5lMtOFo1npbLDYpxm0VG9S94bYyD+QvueE1HFo8jbXzl0/SJyE/Y6jNo/c9UtwYe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dqOAA1LIumH2rIT+3bQ7GbTmea1oEn0E4R4mxeFpsw=;
 b=Bfc1yfU/3b3ymiwcqtsoNxnxYEigFtjiGLK31sBoWFihHRsK+undiywH6xIS0THK7dDRYCQUUOjVeJvkSmS4H6pbp53GaG85WYviLAdNK5fxlhDFNBq5qkRH21yzryrVaIa/Lkv6pLeJpkpA53uj91Rc5udmmdILoApYvJeqfYFL0/25sPiZtwydNAQBMr9lz8RsYVnG1wXAPFkrz3aSaOSshxcGl/09tVWBsJAqEUZ2l0B2pftCN3VkbcjDEQFXAdUIWCFfX5KesqAmTcglfY8ek8ihW8pFAMRz8PB2yO7bmUvhF9SOoKCiy1sOpRWT7lOO443vElM3hjYNLnP4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dqOAA1LIumH2rIT+3bQ7GbTmea1oEn0E4R4mxeFpsw=;
 b=e+SAGefvcEEONm3QbAc3UasVdMQSjAfRIwkwx2ft4lHyIXCkKdTwVk0grDNSw1wusYMPmZfW0QiWy8h8nrZgNUP8ga+KbnFDSkQTCx1CVC5J1Xwt09pnPpAuSihaaQx24xNRz+/kjXL7D/1lsi4ae3jYdaPKDFG4I87TU3PHymA=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BYAPR10MB2469.namprd10.prod.outlook.com (2603:10b6:a02:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:41 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:41 +0000
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
Subject: [PATCH v8 7/7] x86/crash: Add x86 crash hotplug support for kexec_load
Date:   Thu,  5 May 2022 14:46:03 -0400
Message-Id: <20220505184603.1548-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f56530b-09d0-4093-addb-08da2ec7983e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2469:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24696109B42088A545FB30BA97C29@BYAPR10MB2469.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27CQsp0Nx6gtRazSQWTEh5DRHdzneuYbWNzfqVC2tEDipM+gEgXLJ6O10vZVvwg4Kon9zMvw1RldyFyOCttkhqBaAMyf6NAkj53bS3G7LwczhdVzw/iZd6CH0CwEECg5HWoDeM3akbxAfP44lb3JhO4cPvIuuipcibwlA21ir6LudCwRtTlesQX3vKoAek1CQSiRGIMFupNWJnSmmxOZuMQnbGPKGvCmaWgiU4hqHUW03OAerRe+dZHx/u0JCJVm/695kBOGewv0SgsExDoFoWAFUjET/hm6k+ISCEtHWuOmMeLg668dAUZ58N/2DlQLDlbESMNBr1Ku1hO2nFITQWj3YjYZG7SehWCkpN+j7FF0C6RqiRkFt+TY4NVfXrhbGJCNYw3Z/8ex3Bbd3HVH1DN2R2pLz9l6f68kzGwpYQGDPRvM9R6WZENUImmUXzcxLAV4N5a++tPOLAM40bH0ZFwiOiri/84AGfKeRlqjMkGKoX58ys38pwX+1TFnjgguRsHsfRFXLv86qgshrScaIhKFMiiG0AL4TsFc474duSITCD+9eWZ5/Ugycfkzulysj8NPImdpLymRioPrKsOPXfMDKLZmgpEu7FXJWi4kh2wTojtSYqit5zPk6js8lUl/Z8VhRel+yQLioSZNWzVs6selD0DukCHrsAx0mYSLSYWcV/cJQPJO0ynpw46ABmN7pbDHtVL0LmlZZaNwkMySIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(316002)(36756003)(8676002)(4326008)(66946007)(66476007)(66556008)(7416002)(26005)(6512007)(52116002)(2906002)(5660300002)(86362001)(2616005)(6486002)(186003)(8936002)(107886003)(508600001)(6506007)(1076003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MtyCZ399R38oXCtncqvOeZGE0Kp6Cvm/aF4/3AQT6BApnDwb3/NrDcBXWU2R?=
 =?us-ascii?Q?NaPf8jqZRFeTOZpuoTw49kixY9+xB4liK9fsaEmXReRYdTioPy0JkKHH6fLc?=
 =?us-ascii?Q?i7bfaANx2ti1Yrwh+bhBJ3dKAbNAd26CrvY9LLeTZRU7dIg8NIKIByjvZkMI?=
 =?us-ascii?Q?4ajv9PvMf2/fFJ1irwCmmMi3G/GVijDcFeIWb5gJ+k3vND/+j9MMLmpizfYE?=
 =?us-ascii?Q?qfb79Nst98zNnj8SEt3k/jOcOCgX8Y6FI4TxCWvaB/OTAlh8WzdiOUqcHtbY?=
 =?us-ascii?Q?jIej45aMD6qJhaP1XD7f06shE/AlwJLutvgMc3atCiOnTBOb3SIt1Vf4EZ9W?=
 =?us-ascii?Q?cioH19NX/h02JAtOxt1ylRHqYeS4khdDq6T56df9s/ohgduLjXLwUgTt5Fd1?=
 =?us-ascii?Q?5VrYs2ksgRnQQFumebhta1VUUdCQS4Mhq7wl40nkevemugr4OWAc2LGsV/DQ?=
 =?us-ascii?Q?1QwwlRpkDM8RHTJvQ0H3tBAk77JKNVf5kMHSJwEm7l579QRxbFY7te3L6wUz?=
 =?us-ascii?Q?RsQ/bisk/oua8oYbchqSKqEmt1k7Mnqz+S8PcSeu7etiBQnfVB02ElWDuF6m?=
 =?us-ascii?Q?OtOsthOKZMsNrUxTR7Ex0YEahgm49jAyi/SOx/OnGQIHnLh1fSESmdHOtoWC?=
 =?us-ascii?Q?Ormtbt+gkgVzJjKn6RaIGySYiPIeNo/aRqywsc0JDwTSHTo82Y42msiHrTSw?=
 =?us-ascii?Q?on6+TEtaXsAX16kzSJbFgm/FBnEdAomSeNxIp1gLEnWOOUZUk7vZYd11Vq0K?=
 =?us-ascii?Q?4qyt7XSXR9Oy73wPDYiR+S1QnXvnUpgFiq6esFHb6V5kCDIfGCTN8O/AkcYg?=
 =?us-ascii?Q?N+ePeWA62FrdbBEVZq+yRsnkt8/JV2g3OW6L8E41PnNmpgbEmbusJrzKYxIh?=
 =?us-ascii?Q?l0QNsLWyxJXUszqdwogdNPscas1sGJzCBhPC3NoQGLCCL6ZJu2euBSlQqnlL?=
 =?us-ascii?Q?NY2h3RIqnCI9mCKDBm012S4ESwEoumbLXQTWXXdP3mJwXlDy0nm5wYRdBu+W?=
 =?us-ascii?Q?04dYzMHGviu0ixhSDuq0rWryXMKqwSm6KlvSiKB2KtGZy2UBqljAtegSb0GT?=
 =?us-ascii?Q?UXQTJf4hdm427llUIv0JlKMH9tejecc+Yw9VOpJRJNTANOrbBwfZ7wzJtIKV?=
 =?us-ascii?Q?hRyGERuyC8IRRnub6k2BSh3tsXgt1bfdUNgpZEVmnXjJtoj1BbuRzuBVcl4g?=
 =?us-ascii?Q?Fj9Y3BWCm/k6t+zYgDAg9WZlXzspDA0Rb67u3VMgZgNUIglJAac+IYszsSBU?=
 =?us-ascii?Q?B1RnVjolSRoIER4RXAB6tuD5ODGlrXJDI/EoTNWduPEglbMXafBVw8Cl84g/?=
 =?us-ascii?Q?N0hJa6pj+c8KC8Yq8LKgnAnNZ/KpgCfy9P8IWmQL69p8N790D8UdHPEKejzi?=
 =?us-ascii?Q?C6bLKBPXljDwJu/ZrZEjcSRmy6+sNvsgfW9tZHdElzo93nBC2mZCVSdbskWF?=
 =?us-ascii?Q?hQAFFJYkrf2Vz1spd54kFsYG6THMjzgBgTCBeGapbsiBQwoLhKLvrcouoPpd?=
 =?us-ascii?Q?t3+R1uUll9oTo/RSU0aOY4XYXOtnVODnTJLaJ/+63Fck1UZh0j2E4kD1KozK?=
 =?us-ascii?Q?wnRVompcIobIIEp8YtviNReyfMQ36Qc2E1GPv60c5qPxPN6y5qQTEu+xDcsS?=
 =?us-ascii?Q?OHdZOyYQTWFABjNFmKYCAWleTCloBynSOQpNkZJmRgq2eloQ+ixClMUwaGJv?=
 =?us-ascii?Q?CLGR03inHtWnyDSUWt356lpz798fN3s619cGCFk2YAL4Bo18lKwO1aX0TQzN?=
 =?us-ascii?Q?836+2KMbMjfJJHQGSGfxnH/Wnompeo0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f56530b-09d0-4093-addb-08da2ec7983e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:41.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoUagmZVFls48fBDEjClLFLvR+KUY4E1Ac7FIisEcBKAGWUm+gFKRnV4KLvXG0SOrDnHeAeZTNIiPcF061yiTFgb/6cMZ87lO5iBxy4fNxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2469
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050126
X-Proofpoint-GUID: wkCYbTqxXKiuVJQKjbPNshI7XS59tJ7g
X-Proofpoint-ORIG-GUID: wkCYbTqxXKiuVJQKjbPNshI7XS59tJ7g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file_load support, the loading of the crash kernel occurs
entirely within the kernel, and as such the elfcorehdr is readily
identified (so that it can be modified upon hotplug events).

This change enables support for kexec_load by identifying the
elfcorehdr segment in the arch_crash_handle_hotplug_event(),
if it has not already been identified.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 951ef365f0a7..845d7c77854d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -485,6 +485,30 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elfcorehdr_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load, if not already
+	 * identified.
+	 */
+	if (!image->elfcorehdr_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+					image->elfcorehdr_index = (int)n;
+					image->elfcorehdr_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	if (!image->elfcorehdr_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
 		goto out;
-- 
2.27.0

