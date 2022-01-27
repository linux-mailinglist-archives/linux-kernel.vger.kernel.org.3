Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B849E822
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbiA0Qyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:54:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49644 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244142AbiA0Qyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:54:41 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFu4MS029555;
        Thu, 27 Jan 2022 16:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mosWXjvMhYWj2FuSfc53JndcC7pz53UJo1H0frUNpLo=;
 b=xZBeX1upCbBDOHjoiM7Fa3tzkhPsDRYubi2P3gQdswUEe8LYZwie6+WA2urS85rFTiG2
 tgbcrjX1CRsqR5NLSONF4yt1+TuWy1VqeCcM5RehwX+Lnvf3o8JlcWAirxaZkMVGFtAu
 JcFTIIdED5T8n0G207T8AvyFUt29fiA3jqYJ3fSCrjn2y6au4ey4tZ0/pTwfv1tRZbfw
 k5sTc+F8lc3+Yh8R2Qkzmxu8k3KiojLFC4lOs4lwhCke94iILQeavPAIFDmMD406zhQ/
 FB/TjtLtKoXEYxMj51WDcnJVNwxYWH6TCTEKZlGgEUUN1LwzpXbyXktEGnRh10e5YAY2 sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvqurnd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:54:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGV70g177621;
        Thu, 27 Jan 2022 16:54:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3dr723v4pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlNxedxSj99KwCm0hVktzfH0xY9pDkpC2ztnKMUbu4pAZyJA6sKYZm3mmGQ0aA87V4VF8pPJz/MDAX2NhY+4ue6icE8k09hAtu1ZZvOA9J1N+54jw+ucte5NrXVxowA4W4PsQpFsube1pff+vbeJn94D82e5NW6X7K8cyfsrWkz2JyHLWD4T5Nl26Mk7mXVsiU/6AXA0gbASfQ4fZ6APvDR+rgZCBKchMqiXToyfcIACySiv8WbQaPyVkxriZq1X1WTSVsUpGOGSapfm9Dmd9u2tg+341JXl1gOzZu/vlx/XAbXO3+0BQ3ZERs/IV6LpHpSwR7zeYI0QP6otrc3dZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mosWXjvMhYWj2FuSfc53JndcC7pz53UJo1H0frUNpLo=;
 b=Be9rdYRrAbHegjJ/hwRw2tk2ZeUrQVri7+gAr7JUwHxFYKP+k1EpIgI5SjP3sb8RxAeiumBMBoHRwfemUckqj5vciH6nilRU09hhQJNpVlaXe/uba5dvfr4FCOooljunA9yF3J0U8V7g79Wsr9K4dFp++S6Z6C7gZHUVCMJEHIrE+2CSEdzq8zIbhpXBeobD6nbHBTCoRGH8Y/rEF24cm9Gs5eZbceguykasM9dbgadLXSLi6AOcWwmvFL7M0dP+3KBZFfFtlzObUzqhoNIldCUeMYr9knE8yR2fRaUlqCedqLEGRykepJbus8XyfR1Wk8T++pPS4uerfX/1z4QRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mosWXjvMhYWj2FuSfc53JndcC7pz53UJo1H0frUNpLo=;
 b=Btoo7s7R2PkDBtGVR57PfgB7XXg9O4SydFAfh7TG6SbuvaMuKYP1t5Pf3ZWorxFqlFdC/w4COMVFm5hnRoMO5Ikv7F9Oowkh6rL4JT6FuVa3HdQ6/ui1uJn2UZPDSr3jhM7Jsm1wlrkq3/7dsPTMxw2o0lVUD4oT7CjmRJWnB9U=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 16:54:17 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 16:54:16 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, daniel.kiper@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
Date:   Thu, 27 Jan 2022 12:04:15 -0500
Message-Id: <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::30) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600a9b8d-071b-4840-9e35-08d9e1b5a7ad
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4370E600D98DAE2B3C3ACEF5E6219@BY5PR10MB4370.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZB2p53hiWS8ZmJQI9e7nCa1WUPHyN4dDRUPgeTQMGhTE30orygvJ/HAAHiAIxD2XfMtW15V9BzUlI2junCoC/4AYQ6ophW+Vhf8kdWa/peig2hCzaj/uSIamJx9Yx/n1157pWx1RsXa/NLx8UCvWKvAsXa1GnqppBvpOz810STr6Vcbhexw9CEliTaLn+uIy51+KO6lc8HXtqOOOPK94ViwHE/BZ+22FMwEIZYJkyRIRaDOGc5YX1g4ASXCzT8sQsYsQejcloZ4eKlp2EgwJMFmc8DuFZG7lwAwyPCvCqfKOalj+I4NEykZQQ8I9RUKa5WlOFpgB7jMQOylzkF5BqQgbGd0kuVkBNiGt1fW9UBlZtuuWbs8ZEi/nalQbdlbOkrBuNxo0zj+hkIz73ByzOzijk2scK92LR9VmuLCtmKaWMz4QCI36bCflWAX69MJQHtxYaBnfK283QzGXPzddhaHH7kdhTUHF1CIpkyTuYHT5Mk86TcJiZNZ+fMfV0bP/j4j02KbYMGt1sjS7dMi+mv6EsqjBc+wyH+Ovc673omBYjMfYPhpBVbRqUfUtnsoqVVOTUSLmI7hEDkOBUN6gvB7wdhveZJe3FKdhSAD8vt6TIJE6IjAs5DBgPSTBUqD7yB8vfmxlOr2iP/PtnBESahxF04PuiuH+xfUqo7b56UaJjz258JusbollxV85GfboqkLFSOcCYtdMCo4x22PLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(5660300002)(38350700002)(86362001)(8676002)(44832011)(4326008)(8936002)(66946007)(66556008)(66476007)(52116002)(36756003)(186003)(2616005)(26005)(83380400001)(6486002)(508600001)(2906002)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3+B7YTPj2o8or1sPlS7Cm9n3RFa8/8zGCClbtK//hdKbG6iSxpvpkPzSTn5?=
 =?us-ascii?Q?HRUsYaQWWpPuU/1RnFtzHcLcnMKYdo5+fMbMGAIyxodyy80uXTEq5KegNdHO?=
 =?us-ascii?Q?CXBJ8J9meEc8DlwAkJjUIwLALhB3m48EdNV2SHIZ0uEQZ//azARNetwoYvah?=
 =?us-ascii?Q?7puctai2R+TGmg0kFpr2OgbJkhcaxxVl3RpYN+k4L+RloeTnK5YZP7SLVrMP?=
 =?us-ascii?Q?Ljll8HTF+gxTFewc3zDT03cG1WYrSGGz76WABJKXOCRU8S9PhH+hyVJQKo5b?=
 =?us-ascii?Q?oGXRkHcA3XmLwPAIdIYKDXwdFeyCzLRZz542RVXQMJBb7hPxcGbHGiizBvzT?=
 =?us-ascii?Q?F1fpgtKX9T/dsxkb/U/oKCHwqjhLCVOA9C9xj3CQwnVjK3frDYGtodO0T8xA?=
 =?us-ascii?Q?ZgCcGy7Qrr1DO3gg4VcR9miOXPmDJ2HSSpeTQt45tCzNOLjuTu5p/rorICM/?=
 =?us-ascii?Q?1Ii1ZEszEJntRFlwtM7no4gkMPWxqWI+TXoErwOk7NtAKtOHv7YoC1TAv90R?=
 =?us-ascii?Q?USNMJaPUaLNBdfu4RgnI884X8tbQoJQqWiVrVzzgf/PWQUj0QBFuqU+r31yP?=
 =?us-ascii?Q?CKlL32lAxQ20+aE2Q3nznwi6SLYWWf0T7Iu/P29cm2KENaSKyGaIdP5aCEE1?=
 =?us-ascii?Q?Y+o2y2xeAgJ/ZHEKUuAsPRzrW3WdbFJ79o3yLVZ0JAE2dwOQ5w/JNWvoKu7W?=
 =?us-ascii?Q?qLw8UQaaPN+THY/tBSusS9IMHVmGMRs24e615wrkcJL5alxNqj5vSJtRCUyG?=
 =?us-ascii?Q?IfuOlXV9OR0OC3yuciNqUx9DbE9aNzwZLRNc+KZjQqlxJXXwbrOGkupZYUr/?=
 =?us-ascii?Q?7RPidZc7ZhObAxdbW0AkuIbd9h8xnd6pcaI1ES9XH5wRogjsBavHy5ogXoxn?=
 =?us-ascii?Q?xbfVrwRZV+ffi2VwrLkq8zVnRIt0N3ph3QRnrGn6tGpWTdxt9OuBF29fNvA7?=
 =?us-ascii?Q?1Jo5VTt00O+tCQku9eaD2HD9RN7FF0cOfNe20Ovy3ejGqIS5ISmei+qOONjr?=
 =?us-ascii?Q?+PJ3A2JifMzcKe7iooSElHt23nzl9U+Zd/emgkl0xqs7nSfENcGqXuQQeFSA?=
 =?us-ascii?Q?Vk4vQbJ36sdb35x2eFYVbqm+rgIDCHQopNKOrTQEKqlEL0CW/CWC7Ta0K6x9?=
 =?us-ascii?Q?8lS7WEcp2Yl+uzWwg/HA6h4M9y9QR2UmDC8pIIrOb4nq5CtSLA6jXj1xK1N9?=
 =?us-ascii?Q?TUShKLm2Cojdqs8Y4lpbxRr8TQeixMKl90LkH91kIn9EuS9410ObJimK8/2W?=
 =?us-ascii?Q?OjwKInzw1gU92WJhTiHRhkvv4eTy7gqngOM4rtpat4rhMxppmtH5AZsRj+BR?=
 =?us-ascii?Q?yo/Nn/VmNsE2dry7/8u3smAowQLASPSZMxTWK9ycGRdhgVtPrHg7bDX8Qscp?=
 =?us-ascii?Q?ZuRmOlI0YfVjSUwFBIKQHmxbR6Qf/jhi2W4uvDYVdCXLYckg8Q11G+EupCU5?=
 =?us-ascii?Q?4oH5/sBUMUPEYZmyC8EAiU51efLsyIptbrokwRjGGzJmkFtj/RWkpTDPKvkq?=
 =?us-ascii?Q?fgcuA1JnnRI1cg23pqhW+os3A16N66uo2GOTwKdAo7hokdlcocMkvUSIoRRK?=
 =?us-ascii?Q?sp8SkUtmz0EocR9EBljUU4oeY8v1E7wi5UEvOUcGsV1zsUfhNVTdBk9zRwvC?=
 =?us-ascii?Q?jGXA4Uq1AZrOcNp8IaFk+itabseCPbWfU4kiA3tQvBDVzRpT96Z1jq7Ov/eU?=
 =?us-ascii?Q?ezAS1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a9b8d-071b-4840-9e35-08d9e1b5a7ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:54:16.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxfbxDNbtEX3WBzUFKBaIRuQQSPBYfFwLnctsxAwO6UoZnE6IhMNNUtvanzdG9NXdUrc6WxG91FiaLrPp3lgQKPuoWiDPZJDZnJuGuzWxK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270100
X-Proofpoint-GUID: xqZt4bILAMcA77de8MzdyrhVVa5wANOC
X-Proofpoint-ORIG-GUID: xqZt4bILAMcA77de8MzdyrhVVa5wANOC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented, the setup_indirect structure is nested inside
the setup_data structures in the setup_data list. The code currently
accesses the fields inside the setup_indirect structure but only
the sizeof(struct setup_data) is being memremapped. No crash
occurred but this is just due to how the area is remapped under the
covers.

The fix is to properly memremap both the setup_data and setup_indirect
structures in these cases before accessing them.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/kernel/e820.c     | 31 ++++++++++++++++---------
 arch/x86/kernel/kdebugfs.c | 32 +++++++++++++++++++-------
 arch/x86/kernel/ksysfs.c   | 56 ++++++++++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c    | 23 +++++++++++++------
 arch/x86/mm/ioremap.c      | 13 +++++++----
 5 files changed, 113 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f..e023950 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -996,7 +996,8 @@ static int __init parse_memmap_opt(char *str)
 void __init e820__reserve_setup_data(void)
 {
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	if (!pa_data)
@@ -1004,6 +1005,9 @@ void __init e820__reserve_setup_data(void)
 
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
@@ -1015,18 +1019,23 @@ void __init e820__reserve_setup_data(void)
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			e820__range_update(((struct setup_indirect *)data->data)->addr,
-					   ((struct setup_indirect *)data->data)->len,
-					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
-						 ((struct setup_indirect *)data->data)->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				e820__range_update(((struct setup_indirect *)data->data)->addr,
+						   ((struct setup_indirect *)data->data)->len,
+						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+				e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
+							 ((struct setup_indirect *)data->data)->len,
+							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+			}
 		}
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 
 	e820__update_table(e820_table);
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index 64b6da9..e5c72d8 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -92,7 +92,8 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 	struct setup_data *data;
 	int error;
 	struct dentry *d;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 	int no = 0;
 
 	d = debugfs_create_dir("setup_data", parent);
@@ -112,12 +113,27 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 			error = -ENOMEM;
 			goto err_dir;
 		}
-
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			node->paddr = ((struct setup_indirect *)data->data)->addr;
-			node->type  = ((struct setup_indirect *)data->data)->type;
-			node->len   = ((struct setup_indirect *)data->data)->len;
+		pa_next = data->next;
+
+		if (data->type == SETUP_INDIRECT) {
+			len = sizeof(*data) + data->len;
+			memunmap(data);
+			data = memremap(pa_data, len, MEMREMAP_WB);
+			if (!data) {
+				kfree(node);
+				error = -ENOMEM;
+				goto err_dir;
+			}
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				node->paddr = ((struct setup_indirect *)data->data)->addr;
+				node->type  = ((struct setup_indirect *)data->data)->type;
+				node->len   = ((struct setup_indirect *)data->data)->len;
+			} else {
+				node->paddr = pa_data;
+				node->type  = data->type;
+				node->len   = data->len;
+			}
 		} else {
 			node->paddr = pa_data;
 			node->type  = data->type;
@@ -125,7 +141,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 		}
 
 		create_setup_data_node(d, no, node);
-		pa_data = data->next;
+		pa_data = pa_next;
 
 		memunmap(data);
 		no++;
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index d0a1912..4e8b794 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -93,24 +93,35 @@ static int __init get_setup_data_size(int nr, size_t *size)
 {
 	int i = 0;
 	struct setup_data *data;
-	u64 pa_data = boot_params.hdr.setup_data;
+	u64 pa_data = boot_params.hdr.setup_data, pa_next;
+	u32 len;
 
 	while (pa_data) {
 		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
 		if (!data)
 			return -ENOMEM;
+		pa_next = data->next;
+
 		if (nr == i) {
-			if (data->type == SETUP_INDIRECT &&
-			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-				*size = ((struct setup_indirect *)data->data)->len;
-			else
+			if (data->type == SETUP_INDIRECT) {
+				len = sizeof(*data) + data->len;
+				memunmap(data);
+				data = memremap(pa_data, len, MEMREMAP_WB);
+				if (!data)
+					return -ENOMEM;
+
+				if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+					*size = ((struct setup_indirect *)data->data)->len;
+				else
+					*size = data->len;
+			} else
 				*size = data->len;
 
 			memunmap(data);
 			return 0;
 		}
 
-		pa_data = data->next;
+		pa_data = pa_next;
 		memunmap(data);
 		i++;
 	}
@@ -122,6 +133,7 @@ static ssize_t type_show(struct kobject *kobj,
 {
 	int nr, ret;
 	u64 paddr;
+	u32 len;
 	struct setup_data *data;
 
 	ret = kobj_to_setup_data_nr(kobj, &nr);
@@ -135,9 +147,14 @@ static ssize_t type_show(struct kobject *kobj,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT)
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
 		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
-	else
+	} else
 		ret = sprintf(buf, "0x%x\n", data->type);
 	memunmap(data);
 	return ret;
@@ -165,10 +182,25 @@ static ssize_t setup_data_data_read(struct file *fp,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT &&
-	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-		paddr = ((struct setup_indirect *)data->data)->addr;
-		len = ((struct setup_indirect *)data->data)->len;
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
+
+		if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			paddr = ((struct setup_indirect *)data->data)->addr;
+			len = ((struct setup_indirect *)data->data)->len;
+		} else {
+			/*
+			 * Even though this is technically undefined, return
+			 * the data as though it is a normal setup_data struct.
+			 * This will at least allow it to be inspected.
+			 */
+			paddr += sizeof(*data);
+			len = data->len;
+		}
 	} else {
 		paddr += sizeof(*data);
 		len = data->len;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f7a132e..6e29c20 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -370,20 +370,29 @@ static void __init parse_setup_data(void)
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		memblock_reserve(pa_data, sizeof(*data) + data->len);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-			memblock_reserve(((struct setup_indirect *)data->data)->addr,
-					 ((struct setup_indirect *)data->data)->len);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+				memblock_reserve(((struct setup_indirect *)data->data)->addr,
+						 ((struct setup_indirect *)data->data)->len);
+		}
+
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 }
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b..b45e86e 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -636,10 +636,15 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			return true;
 		}
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			paddr = ((struct setup_indirect *)data->data)->addr;
-			len = ((struct setup_indirect *)data->data)->len;
+		if (data->type == SETUP_INDIRECT) {
+			memunmap(data);
+			data = memremap(paddr, sizeof(*data) + len,
+					MEMREMAP_WB | MEMREMAP_DEC);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				paddr = ((struct setup_indirect *)data->data)->addr;
+				len = ((struct setup_indirect *)data->data)->len;
+			}
 		}
 
 		memunmap(data);
-- 
1.8.3.1

