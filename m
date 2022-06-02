Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA353B3BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiFBGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFBGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:39:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2A82A1427
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:39:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2526RFwp021216;
        Thu, 2 Jun 2022 06:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=m1iSjamDqyqxMu9SXCCs8oNabaTWPDZfM9wumRhiAB0=;
 b=DygSoAi6QkgeVkbnY3+Eh+W37C+v/8pRPLrvztILvOcnalh0q+Nq7TnnMo4w8BCjuXzQ
 +a0COknP5kAP+cqnwDbN08/VO2jZ/vvrEITvkWXfd8qSy9eJB4h+XtGbPOTVX3KxxH4I
 +t3zqbYZ4UPJ5MP5OSRDU8+jAho8mVlR0WYH5jGjGLneXyG8Ik3BiyM7JFI9RI7TupF1
 OH+8gqGJSKS2Dj2yPW1+FMB/NCV+n16yjoDuj+sQDuK0CfwjPkkNAWeeO0MsFb6or/uG
 Ci7Yc8lAvwl88y4AUyUjgdLV9U3i9Ffqu5e0SCWFNoRuPj8VASbJ30gVLbAGmVp1vqR8 qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm96f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2526M0MQ039391;
        Thu, 2 Jun 2022 06:39:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hutb83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAwhbzZTVtZeRA4YzzO1soErUwEgwSI+q7s5ndHJKaXa+793T3sN/yNMFakeEYJoXeOQ4ZlYq9WJqE7Dyo7IIF8sKFxyr2PCKvYpnjUQA1XyKBYN+kUZ1/5T1+tnV6FlG9yMiePil9LxfiHfj6SnlhKVqH6wnJYGlYyG09PVR3DF2aQu8JYEQpM4qkbaPRfr3ACYR/+6v3Oi6fcxzOduofSnp53ZxCVq6PNKArddXYWhlsVwwf7xDt9UgTxTeMbp+7Xb0lMS55fC7zwTq3bNZCePA6wbmj+o+uLlZ8YfpGCxoH4MaTTR+pxteJGt2aHvxMlgp1F9ZxzE4ArC5MNSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1iSjamDqyqxMu9SXCCs8oNabaTWPDZfM9wumRhiAB0=;
 b=eBTH1yk9JWhAXHfU3ZjDed+lnpRHS3CWhjIh0WCBjEvFFVMAgcAr4CR3TXy19Z54bBZ97yxTGavs0kW6pjJ/sRiZQOYs0Nqyhvon4rx0P8De+M3+ITNVIrs/yHWZLvu8tbmELYdHHKMjOf1ZFryFdFN4lSeEfvbE1dllaxsxtSk6530GnG0pLG4mId59tbW9tzDCIwEXrLVqDLwg+QbsBmB2QkRZhlbhIDe04zjPCntBGXMVPqbxdNtwcQ7CGzBAnCxo2rL1cz7AlnEDHe7YdHYjHnL3DacyD10QHljnzM8iEzPNiE5CHIv/TxwIM/p07mL32aWKU+0Pc6UMT2pvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1iSjamDqyqxMu9SXCCs8oNabaTWPDZfM9wumRhiAB0=;
 b=h13zBAcmJexGLLOqgT5TjPyo3e4nME2iUxsaeh15yt4Hw0KstfHr+11O2wmfJ46S5EWn+5yzzh/1yOhyYtGxoJFQu28cMv6dNWFzLhFfDVysgux37/TYF6BOSCfayEZrQpvqkCG4LugLydzaaRxrUXkRLGWt14U71oal8B6ZO6I=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:39:28 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%8]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:39:28 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     matthew.wilcox@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 3/4] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Thu,  2 Jun 2022 16:39:06 +1000
Message-Id: <20220602063907.136569-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602063907.136569-1-imran.f.khan@oracle.com>
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972b2b8f-ff2b-4307-e39d-08da4462a417
X-MS-TrafficTypeDiagnostic: PH0PR10MB5845:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5845A8D61189E62197D23E85B0DE9@PH0PR10MB5845.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMT7edIbYen4FecYs4XjbRwOdr//85hPQ9G3xKbYPZymT6dm6QHApTxpFkMFjCvjKZjSgBwu/w2WHIUPR19JOSTTLti96Vy9x7tw9NMc+8SH1UJJHFK6OmwtsvHTvVNwjBwz0/+vrCOjxaDkeF3POY5FpSaBcMQx/tmuMsi+godp+oh40S8XXefb+GM5lPdjnBtVkNW7f1nDh+XEBCa6/YgOREua/sYyT6MHji19fv62eO2i1GtflhYoeJRTEsOtdyFWeDyPEbtveOQm/YkAMQfCUOSmT0z5XZmp0RXyzelBaO2mVsFehmd3aoDa9fm5R8t/ueFg94Nc0NZPeTbDq0Wpn3DhgJhAyLR2rCew8ygVoJRCQHti4FyauFwTyNUXOTInn6CboBmN5a9s+m/PBJNALOu3Bp3nDEVBGAU9LQzCZ8lkI1X3n4hDZeDbpavdQKsP4a6YQU9XIIaTMlFP2MjbDqxRGIJXvzpNFzi6uIB6ggaNT2Jbo79FiOcYU+INd6X1zek5XrdBRog+V62duREfgNUyN+mSV9tzQiX5OvMhVjFqJpkUL65gmzQYhOvMiPZTdh7Op5iEdICdWHSyzrgzuEQt/aLgYCc1lIQ/N6UHhWHsBZQkmFpb7LHB/156pECMh/d4sB5ZWPeDAfqsa1ai5D/Hw1rgBpjkqrvfLLh/yve6liGaSTSC68/RI06jafYlU+ZRIr/iSsPOYKRSOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(38100700002)(1076003)(2616005)(5660300002)(103116003)(36756003)(8936002)(2906002)(4326008)(66946007)(86362001)(6486002)(66476007)(8676002)(6506007)(6666004)(6512007)(66556008)(52116002)(26005)(38350700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4m8WFYF/WqrZKmxsUDkToLqV4x2snpiy9RPn7nCuIJIysIp8Q1bLkeBZyJOW?=
 =?us-ascii?Q?zcLGKBD2cWXX55jMUA+YMCUehVS4wHvfmokQ7lI5wcOCHFxMypKtF5t5Xpef?=
 =?us-ascii?Q?HOJqi+SEQw4Oiy/H92zeWykqaTT5x7Mt1gRtd9VZd5bA30nQ02+XSWyoNH8N?=
 =?us-ascii?Q?sB+ckwKD5ylbh9hW0AA3hniVu8wISlLHdxLoFSo+XjZqPKiV0+bnFBhsMdnS?=
 =?us-ascii?Q?2RnGFAGgNrr11WzOmjCvpWQp05Vh9+UeRCqDmbWo3vB338Vf6qumAyrmq6ui?=
 =?us-ascii?Q?KDMPIaH9OCPUM+HTIqsxTjX1Rnatk+iQV1HAeh/bb0Ia9e2kOM46iNcMpOk8?=
 =?us-ascii?Q?eZATCmojjul4jMKna2fkCr3xcBfty0XVCMZfqLUR9GXVLvozb4lODVRDB3f5?=
 =?us-ascii?Q?IJu7GIC9aQiAWxQjcVuxI36m53AmNBizNzze0A3Z/ChVvYCwTBwNvCxXaH/H?=
 =?us-ascii?Q?TMvKCG6NamLHSKHgzEN0MHxlfqG/tWLFboBjtDQhywlNqvmsHGGlKJwLduII?=
 =?us-ascii?Q?fpyEs8qfGDHwRxIUmeYt7PcfBUPp0BQ4mHVmL0O5uzPP11o1MFSV/hFwvR9W?=
 =?us-ascii?Q?FlkE6lA4Y7BpSc0+2p7e/sXDJCO2sPCt38aUHjB2KRcoe8j0mUWISnfK59ED?=
 =?us-ascii?Q?cu/U0/eesFGhbLynSW+OaSOF0OP+IdpZLjgllnAhwH9/TVnFdubamkZtcMo7?=
 =?us-ascii?Q?1i/jfsjcg67UYMvJNe2DStCp9WDL4J1MnxwTDH2R6z89UYoasvT99kpCTPjT?=
 =?us-ascii?Q?zTnFhqhB2u90Gw7Z4Jhu9D1p50lrtpAqBDHFmvJawN+SOn9ZOr2E46fxLFf7?=
 =?us-ascii?Q?krpjhqlbpO98DH5jPeEOS2QLSahag/gGb/lmm0Lcd6O8f3im8013cjkjMez+?=
 =?us-ascii?Q?fAkHRWwu/kGEGkXaklWUqpGpTMS0m3Y68mi60StepF/DAdk6AHohkBYhsTve?=
 =?us-ascii?Q?VuK2yxXQCCjLr9nqSvwPcdfxgmNndo/CSMZdk0CII710AMQk6PlT0BisxhLF?=
 =?us-ascii?Q?As78aa7kmFtF4NOT2ukoUtaov30P0Whp0DSoZbT6s6gMm/FUKKcU/nGHnCNT?=
 =?us-ascii?Q?hETJnFN6IICdSwPh6k+TWPZF5xIDYQGc2qOz/iQseLzA0QQEmL3bF6xLfRDJ?=
 =?us-ascii?Q?0Ur4MtxMmEMN7c0rsaV/7algjCxVgXibFwfXgXw/hs+JUU6XhIdsRe13Kvrr?=
 =?us-ascii?Q?PF/yx4aL3jki4VXH359FSEiU311MbdyzAEoQquMEQgMtOHWBpx5tDgMzhEfM?=
 =?us-ascii?Q?I167NYbpFtPpIq1Atx+A69VU+U2vprWx14Y9HLme8S/vzTLlGnNPFEtuUTaG?=
 =?us-ascii?Q?b1igjqScuyhXK1RaaN96hagPBJpT+tx3kjfYxnil5UotUPKhwXtb/FuWaF/R?=
 =?us-ascii?Q?82riBvqrH4DjMiJAuGeqXHdaDOjufJbzKwld2rxbsJQwli3lLgQVM48Oli48?=
 =?us-ascii?Q?k+exP0G1pvu0bdYOdwZ5sjp8zZBYgGgs2h3A8R1UJ/D1N6FRO4aT5gSFqcNv?=
 =?us-ascii?Q?GtfYI8/18nFCrj0TTZHYpolCUXYeoahSCrwNzFLS8JQHV1/FaLMfSIVRz3D7?=
 =?us-ascii?Q?X4GQfF/iQaREkfwSEddiwQyqpBX/K/3rRETB0HupwFjtcrP1+3yTRKEMXUMz?=
 =?us-ascii?Q?5teuQpDRQsx4uYp3w9DAytpNRK7N2CwA+TkDT6VEkZqODmYZQE8EJvUPCdHo?=
 =?us-ascii?Q?XebVswRN31jHUn6vI4ZGkI1HY6/WQL6re9uzikfPGot45rEx29TO77DbhM/9?=
 =?us-ascii?Q?MK1FAgAnwvQqI74GQF23IrwkZSm21q4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972b2b8f-ff2b-4307-e39d-08da4462a417
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:39:28.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvHAqTW+VTUvGCfCbNdYXhxRptb3+DVfaBBLDvezBwUf4w2tfr0vVLNB9w3MA9eZ5nn82mpsXRB+0yUKBfiH0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_01:2022-06-01,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=992 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020024
X-Proofpoint-GUID: 7LZKAyl96yGcGiI2LfoaPU1crghaBqAR
X-Proofpoint-ORIG-GUID: 7LZKAyl96yGcGiI2LfoaPU1crghaBqAR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c | 72 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index b21c8e3b6a8d..d35d01d30fa0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -49,6 +49,22 @@ struct kernfs_open_node {
 
 static LLIST_HEAD(kernfs_notify_list);
 
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_file_mutex;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 /**
  * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
  *
@@ -80,21 +96,21 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn when caller(writer) holds
- * kernfs_open_file_mutex.
+ * kernfs_open_file_mutex_ptr(kn).
  *
- * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
- * the current updater (caller) is holding this mutex, other updaters will not
- * be able to change ->attr.open and this means that we can safely deref
- * ->attr.open outside RCU read-side critical section.
+ * Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So as
+ * long as the current updater (caller) is holding this mutex, other updaters
+ * will not be able to change ->attr.open and this means that we can safely
+ * deref ->attr.open outside RCU read-side critical section.
  *
  * This should ONLY be used by updaters of ->attr.open and caller needs to make
- * sure that kernfs_open_file_mutex is held.
+ * sure that kernfs_open_file_mutex_ptr(kn) is held.
  */
 static struct kernfs_open_node *
 kernfs_deref_open_node_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
-				lockdep_is_held(&kernfs_open_file_mutex));
+			lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 /**
@@ -103,21 +119,21 @@ kernfs_deref_open_node_protected(struct kernfs_node *kn)
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn when caller(reader) holds
- * kernfs_open_file_mutex.
+ * kernfs_open_file_mutex_ptr(kn).
  *
- * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
- * the current reader (caller) is holding this mutex, updaters will not be
- * able to change ->attr.open and this means that we can safely deref
+ * Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So as
+ * long as the current reader (caller) is holding this mutex, updaters will
+ * not be able to change ->attr.open and this means that we can safely deref
  * ->attr.open outside RCU read-side critical section.
  *
  * This should ONLY be used by readers of ->attr.open and caller needs to make
- * sure that kernfs_open_file_mutex is held.
+ * sure that kernfs_open_file_mutex_ptr(kn) is held.
  */
 static struct kernfs_open_node *
 kernfs_check_open_node_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_check(kn->attr.open,
-				      lockdep_is_held(&kernfs_open_file_mutex));
+			lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -600,19 +616,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_protected(kn);
 
 	if (on) {
 		list_add_tail(&of->list, &on->files);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return 0;
 	} else {
 		/* not there, initialize a new one */
 		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
 		if (!new_on) {
-			mutex_unlock(&kernfs_open_file_mutex);
+			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
 		atomic_set(&new_on->event, 1);
@@ -621,7 +638,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -643,12 +660,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -660,7 +678,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -802,7 +820,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -819,11 +837,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 	}
 
 	kernfs_unlink_open_file(kn, of);
@@ -838,6 +857,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -853,10 +873,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_check_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -870,7 +890,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

