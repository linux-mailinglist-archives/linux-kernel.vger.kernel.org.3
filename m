Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40CC52CD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiESH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiESH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAE87A2F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J62Y1Z027463;
        Thu, 19 May 2022 07:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7dHR2zvKmrKYyFDljtZZJB03REXmU/C0GxUdKURGTHs=;
 b=h3+YirsokaNzHrqqYDlYE1WQ1M0ZwpntI8kM86Aoi9jtkqCy+WTKazAqW+3j26bZoH06
 ixFwhOpNmcGRAhOG1NcltHEkOazqZ+WaSOtxr/M2mpBTj38Klv+KOa/1pFVN8GBxnKyO
 8DcIQTL0qZIL+qg1cnzzIO1q/5rAyD05N87HBXeOvGBo55mE5S8vX/SHpT4s8DAGafep
 M6l8m2a6SIS/h9RlL86ae9xfnmHqe53b9N5uWWOOIqskhIFlKlnx5ua1gS6IwdHHxREh
 SJQnIK9JnYjbdNu3pZdLMlmTiOjm356KpiHR9B+OvPrwWH1zQVIw4LmOIkbPOjFzikjL 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sbcsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J7G5VD005600;
        Thu, 19 May 2022 07:27:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v51aae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEORVCaDrnf3nCVd2YgZlj7nZjgGYjmATqWb9ANWaFMWkUBZA/9dRjZxA80SjvuteD/ELCorNq8ZLFJ5RuSi9XR6oi1BFtE7Hxz9FGPOtru0Sw9NrVd9gqjij8XMD1WFNs/MaB5TK83N03CAu88VuNleg7VY7FiKfd8CsL/EHgsI4SE/Ca/eHRSDVNQV7kg39w5aS2acriPQD8g2FovoNU1vMh8BpRWV8unRZbiiFW/1tOEf3RhloH93UF8woQ9LKW2ZY1SWbtQMI+99iS71P7hIvHpYxxusTeapF8AGX0oGeVCzpAk0rOBDa/qTekgcOzAF53zIVKemwslOyB9HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dHR2zvKmrKYyFDljtZZJB03REXmU/C0GxUdKURGTHs=;
 b=LAv/Ih6tvoOpGzbZLB8qlNGvdti3/iJirGmDuDhJO6BVA1j/sfJXiso+SxQuTxXmyNFD/GOS7dOsN69kx1odc0mLOCaL+u8sY/9ZZTbcsWXdaSkTbt8LyIDIVAAmHBQNEvtcu3SM2qQ93R+5eEsVN7928LN9lnTX5W8DzMqqovWiKWGfag19Z741CppR7Qu6ODkb9e3XR7VpR0LnHNT4VBZzqBwJhaLmX5lQRE59G/JUlMV3vkdZwml+Lej0JhnLJfT5gYaInO82QcGdp3w15ARevMXzr9SOjLC74uaHOSF+/tF5pULHkU9Lrj9+mx6HU2oG4g/2pkdW7g8DdfiN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dHR2zvKmrKYyFDljtZZJB03REXmU/C0GxUdKURGTHs=;
 b=a9hlYIjI27lZfn4w/7bra5aBTyRrnhmqKgWxlemjx+2DeEJEnfAytmKTS29GiCo7CirQtGHwgY4beypRE4R2dU0VTc09XM9zoeKUjbJDId93s4NdMuPgiGXSW1UDbdZLCbnSbb5qc3BScpAjJwB6ex0Ypu1MegumhDhZswstBu4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2154.namprd10.prod.outlook.com (2603:10b6:4:2e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 07:27:18 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:27:17 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Thu, 19 May 2022 17:26:58 +1000
Message-Id: <20220519072658.736370-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519072658.736370-1-imran.f.khan@oracle.com>
References: <20220519072658.736370-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::12) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: babf5724-6ff3-4473-ae30-08da3969010c
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21545E2CB7C5DD821603B311B0D09@DM5PR1001MB2154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Imt7c/v8OK1vdHJSZa4Ik0HR1WqFcataWtfO7gd88sxg/NYb5MDYap621QES6t7CGIZlIxm93T3CvI9Vhw3fi4h1+QY9AJrJrC9PNChO8eDYdveo/W2VNRCHY9NyITASw2d+VfPbcRHhfkZoS9MfcPE3xRUwSOqUTvo/EkIVjJXzZGDdfDiCLyeJCK1FWn8MLNoDqG3v8wRovNHgkQgrgriBq40fmbrFAn3Cj1vao8xLg51GYUyj4q4c6ZUOe9HvonPJ76/ePIBeFu45RUe8RxRHKA84nyu0MfLYgh7C4PBydEVz1IpzT/yFwxB6Rfq0+md+92SpaAu/5MgaS/7VB1dOfdfPWeIjARmgkH18FudrU++UdmJt1I4pw5Wy8DDzt9nYJN5Ln4PppoLgk/8m4M+LxrrwvsjzYhyn/s3lgzThH+sD7pMpZjEFDK4Ra3p0C/bWfJ5y3AMp2xFK5y+N2LW4Ux46pql3YN2cm42Pr/09aDSEs5PR04P4e1+Vfqn7prnGtsR40fB14aGv+XI3cBJBQ2Fp/8smrgEDo3MgZGS/y+Yy+o5JWNPJo42XOppxFIhuYZMsDr04Toq62wgnLh3IXMXu5sLvRgzG7aMj6kTHbruaIJCQe+ajXxBioWyPeUA9XfqeL0zt6vXnGWjySGAZ/UMKVjBNI/hdL+gPqqB4PgtQ631/X181Kg8QIIGzjeuL+j9101uHljy2TYMYzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(103116003)(8676002)(83380400001)(86362001)(186003)(66556008)(6666004)(38350700002)(4326008)(66946007)(36756003)(66476007)(38100700002)(1076003)(6486002)(8936002)(2616005)(508600001)(52116002)(2906002)(26005)(6512007)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPWKdW3QoILG14jxMK1Cer2HNTwOq7hkfIm4ERTEiHnrRicJX7LFAOS6n3PQ?=
 =?us-ascii?Q?D2Hki5S41sgDWsCjbgI1tljwRK41rRF69zFV04KloB3GF5JA00v1ebYz14UM?=
 =?us-ascii?Q?Sy0QTkBsWW0fY94yGypjgZaA60i3TXprwEq8Ta+ArjAyTHu6UFKC3ZZ4h4EI?=
 =?us-ascii?Q?1lTvbdpNkz8tqKIUszvIFpsUOJuOKeEJx4XnFLHjyQwztTI70nx3iIXANbdA?=
 =?us-ascii?Q?9NgUtA1MD5gaa3mE5gIoI3rM8qE6O0AXEVuTPg8MbGXrbNZUrcmhep9XDFyb?=
 =?us-ascii?Q?+pw+AFho3fs+C/PRR/7LsG+JcZn/HB3Fc9GC8pbhxyNFQ5DWFI11223eVlj6?=
 =?us-ascii?Q?FEw3Q4SA4+UnKVNGu7SwJrdWbCPz7Rw9aHDydY00Op/IGFpBgmg5AHqkvJA2?=
 =?us-ascii?Q?vIqkqZt2M/OUbsZ/kXvcbHfiu6EMO4X0TSjEnpUNUHyZHupyTnMXiWfNVba5?=
 =?us-ascii?Q?q2UPhin90VFiaBSp+6Ko2n3oXZ00c/QFMFN3QvNGgXBQQ1sPyxqTIeQLfxS/?=
 =?us-ascii?Q?J8Jn3tVVTDGqdJVSkrCE8u03AzsQsT6vQNnSZCjEmkMi8f9mXwngrMS/3c2K?=
 =?us-ascii?Q?g/3Yg+f9VEETcXfgSAiNI6yR7vx8B8NMP/SloZ1ExNrPxzX7s2Gb1CsK3SRa?=
 =?us-ascii?Q?fn0gWQerohCC1X0RgA2wSIErk50xaDIUNdvB3lq71/JOPSP5POtpek7oL8p4?=
 =?us-ascii?Q?cg8hjywgA1Mr5mG855BFPDQejnJK+3c548zwhd+YxYRHZixln19jDea2I6XP?=
 =?us-ascii?Q?qcsFrn4818Xnjh1tOwsdz9uIRNyAt2EzZKJfcU2d7SZ+bsF9Z6GAttRSNhlQ?=
 =?us-ascii?Q?nwTLtqPSf4OplTIB68fYFYbyMCDkTkt0RFufiYlPFXuWy1rIM2/oHZghd+lq?=
 =?us-ascii?Q?I5bNKzpL7Fy4dj0wWK/0VaFAUdU/BT8u8bFaoG9LROENmsjl2g2JLgbSKDer?=
 =?us-ascii?Q?j8vtwnX8t0WlymXhXTJeVxoksjJqse95VnXP3oM6FLUj5Ogrn75UBmkp94om?=
 =?us-ascii?Q?7onQSpxf1lu4GlEnMyFkrsWV8h5QLCX+kHdV66HpeNuZSkq7050pqaLhUisA?=
 =?us-ascii?Q?25k/B6Ajq/LLrtUPX1LYSCORav2oUR327HSr3mlHzetqET99g/blCpOWemik?=
 =?us-ascii?Q?Zsv6je1FGAhwsPhtLdtwtlSGw79t02cfz5sYSlwO336KjQL0gKponNRsV0T4?=
 =?us-ascii?Q?NTNh71aI0fRsJmimP6Ph33aQ4RVnv0EgYbwxPsJP7cGmD+mpc4hRizCs/hF0?=
 =?us-ascii?Q?6Y5R0cMIPYoIxwohsUxzXxjJefsNrLWjd8STIKErY9VhskClr+wHoTED9p72?=
 =?us-ascii?Q?W+IglXmXlTOiQIOWleLjYWJG7V1t+hZpUOHvdXT8x8edNXHy4f8I707VOAbM?=
 =?us-ascii?Q?NakgOapmYexTS6RYy+d2ugsgidahbCArqkVG+l/B5qqlDiFZW89CqZ1VlaGH?=
 =?us-ascii?Q?wsIiRijNHyzEDKgHM4lH8ZFKA9M2BXhWDNxRrHDH9TMxj3xlNkjCAfi23UyM?=
 =?us-ascii?Q?4x1R97H6Jbn7ribv661rCKJaK7Iuz2GaJx2qmDIvmZPLDHoqnrKRcLLyC8Ny?=
 =?us-ascii?Q?daa5hSI2jD0fgNZ7C58O7qtuDETECI2+iwurBi3q4JLnGg4Z4FmxENGk0SWU?=
 =?us-ascii?Q?eBrZNTdODKdShIDCNTaj2cYn7Mbx2zOGatOyU/xFaElb7AUjQrTBkzrPvN3B?=
 =?us-ascii?Q?animmQq0WnVQXQWp3FiRQ/yZluv5Ul0pAioKFJPQ2zvglHQyRwFn1sxeCrod?=
 =?us-ascii?Q?WeIXil7ugaqO2sBcm6/tltZPCEMDtEM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babf5724-6ff3-4473-ae30-08da3969010c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:27:17.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrhShRR5Z/TO75TJgV5ImeIB9s5Sg9IMDl+zlIlqQ5CzDxGhO3OKNA9fT7asQ+jTLbWq/bjytvOVlFDkAo7A3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_01:2022-05-17,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190045
X-Proofpoint-GUID: cIGDHlSoPM0qMJoftmoudxH9qwK1-o1Q
X-Proofpoint-ORIG-GUID: cIGDHlSoPM0qMJoftmoudxH9qwK1-o1Q
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
index 87ea8127c98c..2f7325352e43 100644
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
index eeaa779b929c..3ae214d02d44 100644
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
index cfa79715fc1a..d0859f72d2d6 100644
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
index 2dd9c8df0f4f..13e703f615f7 100644
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

