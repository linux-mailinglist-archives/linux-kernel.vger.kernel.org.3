Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC754BF95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiFOCLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbiFOCL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:11:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095CB27FF0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:11:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0Sq37002206;
        Wed, 15 Jun 2022 02:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=uqvZvLh0G989ufZqmc/N/K4i51RKlYfNv8J8TR6Gjps=;
 b=ngpuLnjHBMU48pEJ6lmq3wv0qQ+5uwMuQb8P46fi5yQIJ6WP54auHZo8Flp7bAC2sNrW
 VrgpxG39TuP/5RLzHv3yeJ0oY5u58MxQGe/I3SZ0s/uZ4WGrlJqzs0VXaChajSYrkhx1
 QGXCrd6nGHvHgEoK77F4zhfBzOB8q36oPQWf6WyRMJfZHyDwWNVnVCKqIvuwsN/tH8lW
 Q6Vn8iImdHtIO6xvMqhnjUPFdbqerCNX44L8IYkstRhoYPhDyhKrALY29lMP9LENJNqs
 LiY8bKj8I+gcLTTO9JJqchHfqgEo2skP7/IHRABLxDkVoMiUKxaOpok6aomSsO5xUGra eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcqahs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F25lLE028721;
        Wed, 15 Jun 2022 02:11:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7nh9wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWasY6j8yK6pL9IabC6I9H/9TFVM60lBcipTAsSISZHztxsk7EVL403ca2K+lt7bp1MCVPfPI52O5yJGqZAlHrOElEOjgMInWf0sdg9ZWB3WX+1DatrWFc++juf47CQOphk/24JVbciIO1+GM9Sz/LZS/mA13ESMY+qi/IRM2pqrSMzYuNcM77rGHEfI6hekTxxMqtEnwYBJTAh0qVjofiJlGQbCR63c6RuxZdgHEtlXbLUfzYV+JwHh/a1z90YTWOCGBjlSqh0HOgejOki4Al9PyGDTxDiP9e0GLI2hJF4iDL3sQoXc81bterRLB7ERgmls/qhPQunrytpZD22+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqvZvLh0G989ufZqmc/N/K4i51RKlYfNv8J8TR6Gjps=;
 b=OaojZQ5FDDMz2HRgqQUvlFCx4XSifNEvc44062rrjflaDo8nC5OPiKiPwGuoI/SflFE6GwwrEf3kbU9e62fNMuWzyOuV+/t819txPZCP5DuF5xXJP1jl58Vmov2625uB1XZ7RZgm1dT3/lRuu+8rCIIiVpLIBttNqIuNyOiod5p28zaLYvBv0yZL1i/qm9an4dZQHNQM6JfaB9bts5g2XjvTSkqTABcvKL3x6zLdNyO9O/vLAenpxYrl61yZAxhw8HQ/8r/BAOrgLXVJwyfx8Ak4mhXNy1gPt+7AE6imWns7xBG5mFKJM3TXYL6zUbxEpExpwMKYUVkrNqRSA9CgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqvZvLh0G989ufZqmc/N/K4i51RKlYfNv8J8TR6Gjps=;
 b=HxwpL2wm1WaN2rZ1s230gRuF3ZOqkjaEc2f/J+FqnIB71TQAYFYrFdoKLiaObCNFmTHa6dtzdCYReh6KX0dDjq9Xeh27++ROdg8m/bDfFsqYi6amrLuh4Gihhd2r5XdyhWiJkAZF4QMc5RTvx9trMy+k88wVEyNg5iiT4H7BcAE=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH2PR10MB3800.namprd10.prod.outlook.com (2603:10b6:610:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 02:11:20 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 02:11:19 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Wed, 15 Jun 2022 12:10:59 +1000
Message-Id: <20220615021059.862643-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615021059.862643-1-imran.f.khan@oracle.com>
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::13) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 342caa52-f8aa-4889-7841-08da4e74562c
X-MS-TrafficTypeDiagnostic: CH2PR10MB3800:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB380053B79F2BBDCC7866CD9EB0AD9@CH2PR10MB3800.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYUzNX06DLfJKbgVYHVThjY1tnU18ny+tgfYb4RiLWIMI/ME6Y1OzXt8A+TVfhseVTzKqAICTEnX8upLBSevPNbMgHjEF2HfO+dWnGBZcafi55IDlz3QaRS6M9Pmb47w9+yGbHqy21CtF2OObAkPGfZH2pCuE4u6mUOfzOIIaiONYDFvrhJ3JGf7zRxGZbq3rnbzju9kLOBZxQy0ntgWxcK2bX9Sn8ksNigAHaaU2gGFxTK/PHw2DPG2vLHzFrnUR32bnG3qWDmqIIFgQLGcGyTWz6hocZwUT2/9HzMtAEP/HiHEh3dtBnVBSyR8i5TFWoAbsKCu9iuGcKyfc36wSuWrnK9qzFlsC1K/yajPRpK1cAxauY2rO+R0aG61n3pl8hRI0fui+zIGNMuIyttuuqtKOupUZPGvDKBN7qx+kacmet2mLfz1cfhB1YW4te/C1PK1YA9+25AEkPMAAtOSuncwtQMobGogmDcvJGlpm2wjqGRfSlWRokzY3b/Qpx13J4v6kqzF6Y5wjex7PwDo7YBBsHW+pFsJ0qdLIDCx/DlEuhUVJ+VrDO5IWoXxC1yO4qPb7hcTx798TLYxcBvOR0y2Z2nmdxF+wAw++XeeGjt5dxB41eRfQkn/6ovafm+5P1qNx2OkoxstVNFnpdUnycPEZchnzS61v37bacwA9bfqFbv13yod6BV+IVgCgHxGnJvb6uMrwLCTIYNU67qd9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6666004)(86362001)(38100700002)(5660300002)(1076003)(508600001)(2616005)(38350700002)(8936002)(6486002)(4326008)(8676002)(66946007)(66476007)(316002)(66556008)(83380400001)(26005)(36756003)(2906002)(52116002)(103116003)(186003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?adNCBOt+75BDU0vjGmVL16zw2BvkSssldav73j6Cn5zXtg8P/G1kco2lFe8L?=
 =?us-ascii?Q?lBvmQS2uoP4j0Gp5fbyAY6vzDy71alBNsqL0NxKdDzAF9DikqWfQBKgW6Ucf?=
 =?us-ascii?Q?Rd9llZZ1a3yfu/Ma4WuJmBUWVWc7+cjmsZy9Tf505vl4n/1/atXXRhEIYn6s?=
 =?us-ascii?Q?DYI1TbgewHB++1s53yoYxS1cbKLWS33cNv+HZo7ngiJe+JtYOq2VNW5U/O37?=
 =?us-ascii?Q?G9nYyrVX/c7wjYc7Asv15YhhRa9U5sEqH6jHuKGaO9kdTpLC6AHdQmBNIfvV?=
 =?us-ascii?Q?r0VxuUmrOmh2PIX46JKtdpmEf86gU/iKOSNCgz/ya2sSmys6t7NJWvHHS5x5?=
 =?us-ascii?Q?QCz1VEaourFVD844TVjwUwKq8a/Ewn9CnpaN6XBKiuHjPVjteBxD3PwNe+YH?=
 =?us-ascii?Q?FbsHcn5J2NZp9qnN8H2GJrAa/SyqxxFByfh1BcuB9/2XYQH0TFC38P3Gr+xP?=
 =?us-ascii?Q?cvkcg8fj01CzJtYywZxqZKn6/yW4lFCV/A6zebnvEaP19TjHlPoJ7/e3A3UW?=
 =?us-ascii?Q?+JgEy2h8tkEYWoakwCWMCpNyPF5VTzcSg4HuZva1NRsgmiq5p5HbWWlxZpUf?=
 =?us-ascii?Q?IA5qy11GFla2df7JhLG44agwHxSUK0lhoX13jJq1O19tY4AiPXdwUwrTOhLO?=
 =?us-ascii?Q?vAD51/8VX/fFWTYiP98XUdT/QZv6tnsf9C8+aVngFsWvcNBFpZTE2NMsWlRJ?=
 =?us-ascii?Q?oO47Unx84kmEPszNfm32b/8Dtm3XY1GGODfsYOEixgI/NjVg6jbHT09Vm7yW?=
 =?us-ascii?Q?Mqe7ZkYb+QVVJYtFm0nqli8snLQXBeXM9VXHArAzQMHhliM3Wtzm+qWWo38W?=
 =?us-ascii?Q?Vk7870w7wB+RNAEnhTjsBT3Ajnw+COJURvczn0ZuC9YCilE4161z88J6WUwj?=
 =?us-ascii?Q?OvuNRMyiuEtjbn0gByHGjI20LKjELksrHRTNl1lzne65MqIqcjxXgg5KZA01?=
 =?us-ascii?Q?wfsZ5x9XG4kxVX6FX/MEYvBitlES4bTtwA2m8aMG3u+bgRUGalGNixFPQKTe?=
 =?us-ascii?Q?dkrSH+NJXjLyYc3PTxU0FchtjEI5gDzYurSKS4c/p+ksofXCX/5vTMLnLFfY?=
 =?us-ascii?Q?uxdUbCy7sVj8XHa5ixFPU/XAAvUdatgXEtANTlbf8ZdkRZRmIvJJn8z5dBha?=
 =?us-ascii?Q?gI+P3le57jjDmf2v8Yxsqj80PzvenZHaD4t8L8bbY/WdnOSiFoBYUJndUalm?=
 =?us-ascii?Q?vOUlSiwrhmbHkszC6UlzsRZr1dqbAR/7LIl6wlsb4Jt0btu3bQj0JkVW5XHl?=
 =?us-ascii?Q?P7Glt4Eg0B9szTfrePwlvYLTnWyQYvlKKTXN9vBsEHigVZgDl2u1eUWHq4L1?=
 =?us-ascii?Q?IEwgrzWNHyBuP9Sgd49Y61kO0eS/woMlQoT+6V3jSFp/C2OXU2gv8t/OKan4?=
 =?us-ascii?Q?xktWCWhzg/qfLMRYcZKXWiBpOXFiShtE1r8oA+azXmDFMm7eX4dyMWUYPmdU?=
 =?us-ascii?Q?grVt9Zby9X6OH0gAyM9vnLwrt734KhUZdSMOxHN5/4Z6fzFVNb17bkB3HfCo?=
 =?us-ascii?Q?5EeL3zhHEUvUUYlR3XcpUDvhXFGlmFi6DhIKLuv1JNjwagYNJ3m5vzC2cVwN?=
 =?us-ascii?Q?ghI4HCC1XI7SXIk3n1dd4VOyCUyo8OPlmRxDMxTNSgBJM8asiAmuavkrnGW/?=
 =?us-ascii?Q?9gEOiKqk5kKDSsRNvOVGlvlilgvfeZNy7/BOh6DHMCrvXuuIknrJyIiRcgf9?=
 =?us-ascii?Q?8AOYqqM3jJLJ4iv6dxkwHc6605FGk73u3puPH4KtPs/ZwYGxMTeruUP8Tpde?=
 =?us-ascii?Q?rDgnMLTkPqJifXTWJ5dZ1b7+EsqRpz4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342caa52-f8aa-4889-7841-08da4e74562c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:11:19.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45sN6afeX0lsPViUrDiWp4gONbz/OwllCsoCvm3/tDO5lm/KhTrLBS0d+du3Xg0kM+bw5+FEKLI9bX1C88j7vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_10:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150003
X-Proofpoint-ORIG-GUID: M68MBpczfxOXJfByzWIFVPDX1wxG-dp7
X-Proofpoint-GUID: M68MBpczfxOXJfByzWIFVPDX1wxG-dp7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single mutex, kernfs_open_file_mutex, protects
the list of kernfs_open_file instances corresponding to a sysfs attribute.
So even if different tasks are opening or closing different sysfs files
they can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time.

Using hashed mutexes in place of a single global mutex, can significantly
reduce contention around global mutex and hence can provide better
scalability. Moreover as these hashed mutexes are not part of kernfs_node
objects we will not see any singnificant change in memory utilization of
kernfs based file systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed
mutexes. Use kernfs_node address as hashing key.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c            | 17 ++---------
 fs/kernfs/kernfs-internal.h |  4 +++
 fs/kernfs/mount.c           | 19 +++++++++++++
 include/linux/kernfs.h      | 57 +++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index fa0154211076d..06fc4be4032b2 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,19 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * RCU protected.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
- */
-static DEFINE_MUTEX(kernfs_open_file_mutex);
-
 struct kernfs_open_node {
 	struct rcu_head		rcu_head;
 	atomic_t		event;
@@ -51,7 +38,9 @@ static LLIST_HEAD(kernfs_notify_list);
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
-	return &kernfs_open_file_mutex;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_file_mutex[idx];
 }
 
 static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index eeaa779b929c7..3ae214d02d441 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -164,4 +164,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+/*
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a7..d0859f72d2d64 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,6 +20,7 @@
 #include "kernfs-internal.h"
 
 struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+struct kernfs_global_locks *kernfs_locks;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -387,6 +388,22 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+static void __init kernfs_mutex_init(void)
+{
+	int count;
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		mutex_init(&kernfs_locks->open_file_mutex[count]);
+}
+
+static void __init kernfs_lock_init(void)
+{
+	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
+	WARN_ON(!kernfs_locks);
+
+	kernfs_mutex_init();
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +414,6 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+
+	kernfs_lock_init();
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 2dd9c8df0f4f6..13e703f615f79 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,7 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +35,62 @@ struct kernfs_fs_context;
 struct kernfs_open_node;
 struct kernfs_iattrs;
 
+/*
+ * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
+ * table of locks.
+ * Having a small hash table would impact scalability, since
+ * more and more kernfs_node objects will end up using same lock
+ * and having a very large hash table would waste memory.
+ *
+ * At the moment size of hash table of locks is being set based on
+ * the number of CPUs as follows:
+ *
+ * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
+ *   1                  1                       2
+ *  2-3                 2                       4
+ *  4-7                 4                       16
+ *  8-15                6                       64
+ *  16-31               8                       256
+ *  32 and more         10                      1024
+ *
+ * The above relation between NR_CPU and number of locks is based
+ * on some internal experimentation which involved booting qemu
+ * with different values of smp, performing some sysfs operations
+ * on all CPUs and observing how increase in number of locks impacts
+ * completion time of these sysfs operations on each CPU.
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+/*
+ * There's one kernfs_open_file for each open file and one kernfs_open_node
+ * for each kernfs_node with one or more open files.
+ *
+ * filp->private_data points to seq_file whose ->private points to
+ * kernfs_open_file.
+ *
+ * kernfs_open_files are chained at kernfs_open_node->files, which is
+ * protected by kernfs_global_locks.open_file_mutex[i].
+ *
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks (e.g. open_file_mutex) and use kernfs_node
+ * object address as hash keys to get the index of these locks.
+ *
+ * Hashed mutexes are safe to use here because operations using these don't
+ * rely on global exclusion.
+ *
+ * In future we intend to replace other global locks with hashed ones as well.
+ * kernfs_global_locks acts as a holder for all such hash tables.
+ */
+struct kernfs_global_locks {
+	struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
-- 
2.30.2

