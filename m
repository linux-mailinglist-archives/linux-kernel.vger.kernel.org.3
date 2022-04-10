Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F914FAB94
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbiDJCkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243394AbiDJCj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:39:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4415833
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239FZSw2029058;
        Sun, 10 Apr 2022 02:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=32Ru7ruiQ+QqISbRWomga8Ujk0sTnxMOyWp7P6ooY/c=;
 b=gnpbXPORdTSJui2xYdRVG5jMh3TXyfxqgWjJRQpclhfP/DgRKhqgLRp8aC2HzbstVsEw
 jZT2iNcNM6+o03jYhVtT3/INJPJomVgM2BfVtbTB3IIrHBhJMyA+ZYsVnWufO+MQ3HKG
 intyr23aAJmxPMX8XPqrFKvpV4330r5lCVu1lo39dH/0t6nlJZm+WqO0q/k8MYX85mNm
 MtCEbPOtoTZN53XQVn/9VQ3jum6Z9jN5wNIv6JbdB8TDy67a9u+X6TG8hmGufCmGj6vl
 cHbUnzLAkFfEHdtXmMpuhx0C9SWrepE2yWist5YvcmXcwB59m62WBaP1rRh7UE+9AgAn WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs0yr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2Udhf024144;
        Sun, 10 Apr 2022 02:37:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0h5gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2KPr2/U3ezKYdVuHwZRd00XCZTkNZTlY1Y0/9SfBjt1NXjDe81z/AFbfVeANIGgSO3GO+i2siamoMBYpW0Qp+E5dJ9x29b4y0zxuyks4Coz1Nd2QVUAO7UlqTvPpon7WaNgkf52FuIs9SuOM2t5O2t7Zrd7/GDRu5kukZyBM6+DawBWdBUvhmezaQIp9y7TlcBKbhZQ8HrDZ07N9JOREpo2tSLbRiHT5Vbv6D7Oe3w+PLn4NDlo4NbnO4eVLltL2/QUYTHY/VIpQOCbXZBVwEHB2PXWmrgxVttunAaUbXnMRk4vzD5NFDUw0/fpwtffwHB9NV/mmwZAa3B6LYke2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32Ru7ruiQ+QqISbRWomga8Ujk0sTnxMOyWp7P6ooY/c=;
 b=mafO/o+E9kgs4uW0ACjTvr3Q6GzPfaqyTD+amtNi40dvpaPZUMJLXHtNgMo4jnc0GAGTA1pzqpCCJ79PLPYEGbRyPeBX46k5OQQyJtybklhHq0kjyZpCIzzSYLoC+gYdjc0beGIqr30IVKETfvUn1cYLLKSiKaddO27+QaQafOXe6O1YDpvjULBcHRLPxH8lH6SeL95COyZTk0PRtzUAhJHtiOyt422BO3XAQw8S7e1nU68lm9v80cRt3dJACGsEXRdHm5e3ohAZwOmf2IHw2Kaf3qWzHH6gbBdt6nMBI+7oxZ+pAjiJO6GVsa3aDUYyvvhKv1Ogt16wp+OQWb4DRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32Ru7ruiQ+QqISbRWomga8Ujk0sTnxMOyWp7P6ooY/c=;
 b=hP3JkCILkoi1PQU/35z6IkuHDtZmN5RChXa/202CIsd7OhMZxkSAGzuZ3aqCETzVQwGdfydMnJviFB1sIN63y/0/JDW+mglNcQCLvWgtKxwDfbU/c50IW1G983FPlh2mY7Utm49nf2U95pDKmPTWL7wosuiW8ambDwIuOU8kSWo=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:42 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:42 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/10] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Sun, 10 Apr 2022 12:37:14 +1000
Message-Id: <20220410023719.1752460-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590656ec-06aa-460e-337c-08da1a9b1691
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238CD7A4F7A4890223AC0CCB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSlp57PNYacubQCwMWuN1EhSwvHoTkrdjHIVDkyH7znkC5MixbSivD23XHvM7egCCphlmFZDtkgGWhxVLHMze5N2X/YGlMy9OLeIK/JPQz6+rzsCpNbN8iYfpqq567HtiOZKUw1JAio2jrJ4lVBjQWRM4RRbjTaw6ehDMGlGim+Iih1zFG7CfXLE5d0sZpeLoFhGhF/DNuhRCcdqZy1VKhr7rdFHmjKtmpALjEMriK4XrltqcXxhkloI+6Uq/n7BrSyuaB04LMNpyIUcrbOBn00BoopD+jCLOZg5ZsPZE/i149ZDQg8KDDA29FWCwefil+2jSX1sSPnIN+M+QErTaueKNMUH62Xott9gLdjxDY++j/7ouRSGQXIC4CdRVm/dKKlqYC7b4SEI31mYqHL+CIz2sQXcDptOAMUWyotuWxOjQE1Of+B4MBB0PTtl+TaXokuapvfxFV6cfueskPC9OgtNaiekM3sZwoCXC6LSWsiuN1GNCkXBccy2AK2vLDtC6zDUnWng1Ri76M6cAaGdfKiwHa+smgWDpHoQJ2kQPE1KOr0CqHOpHsIHpkg9tNubDQSeWgX5w6EG23ZRMnlgZDURI7zCmwv5VQRtmdUYUZ2PSjWN26B2Ip8l5w/rOxo9wOiGt1j2VRtINo9V31r7TXrV/+U9UN1HDMf+iAYz6ElvfuT34lWAPQ0OMqHLMQNNJuqblw5V+VPM2r0IBPLQQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7tQccRH/uC6g0Pl7yaN/4dRPb1wIkpz/fOdVdZ3ubZqdbBECgwLY01dekJfE?=
 =?us-ascii?Q?pAotsBggmF3pzeVeso8BxdMkmEAD12kGKFxLbDSA5OLRENLzqwk2ZOL3bqGn?=
 =?us-ascii?Q?Pl8eXWij7YRRZeSCXayuKIIsqwrzJZMwwxTeBPNtyuEOPHASkS5jcp+Jt+2h?=
 =?us-ascii?Q?ZlVXNAX7Raj40GjAvANg8mswmlw/mo5tfdBOYmKG2O9nHlK09jxiaDZE0pRK?=
 =?us-ascii?Q?XdBpWHe8JU3f1/sSEaXLmNGRWwQP4hJCFm2jrBVEWNvryWAPFXPfvSPXScYk?=
 =?us-ascii?Q?RkSJ+ScvCAWknqu4PhKmYunkUvldht96AtKmTS99An3gOpX0WW7p/a2Z3brt?=
 =?us-ascii?Q?wkkr+fVX3br9BcwK0qacEgCsJ3+upepCq8gZyN3n8IDvRbEx7/rSJSyRQ/vI?=
 =?us-ascii?Q?3YO34bXj1BRKlFB7iuZkDEsrEOphDfH3CK+yFjqXZUpRktLJDNO5WwrGt2T7?=
 =?us-ascii?Q?jHJEZfxdnzgxe51SKTRrITodAojsBKpJ/F/my0DLd1Dfqj3hOFuZu+f6CkvY?=
 =?us-ascii?Q?LHlX8rcmtgW5MvRdXA0tSKaRg+lf4dTUPbivF7WXJnpNlBZxfB2KNEvQiYlW?=
 =?us-ascii?Q?iylpZ5LuPZaElD9jp4DRx5HZCP7UrINcnh0WryVaieExZPcA8M2ueKHJw75n?=
 =?us-ascii?Q?DyGmRU4ZgQPL+N3oCLixHFauGsPAabPnxQMhEt2465HuE9lnqIEK4HGg56sy?=
 =?us-ascii?Q?+LRAhs4fG5AlY9GOjxDODR9emGceGAclxrn4n/ixRrgQ/+UJsu677EPbyd2Q?=
 =?us-ascii?Q?MoJJU14+qKsFRM51nQE4QC5qrqacOYCPnYcTGhsgNOA1gGWCBM3jwhTJF7ez?=
 =?us-ascii?Q?XtH3R9yBOxYfpR3cqoIHC87jRGka8YPsebhLX86CLC9eCFfDKGXLJcEfU/p0?=
 =?us-ascii?Q?0c7ro8wxkyWg04EM0rNrEp/UME7uhQ28Gj5VVhf8X1VYcMVVJtSQm+qGRku9?=
 =?us-ascii?Q?JF4toqQNlyMRYmULji7S3B3fhhs6DB3+ge0TrPb1I49yTEurR8Ls9OEG0naW?=
 =?us-ascii?Q?25uSApFcutW6m75PJ3gEeJSxD0dV56FIvtPMJTW4m7rFmEA/fMREvL9lonL3?=
 =?us-ascii?Q?zd1exc1OFihpawBD0jnKSFho2bzMdhrFv5huRq1wpOH/fCcJ/uj+XA2fBnyi?=
 =?us-ascii?Q?fpZhA3ULzXB6waVVRvPgX9AQQ4MX0vj+sVs0dECxInKsSAcyZgHzXUFyISqH?=
 =?us-ascii?Q?wDBoAxZQ6vSKH5zbQAzpzi49pABVO8oUIcSFO6VeoSbm83bNQK5iqdfx2z5P?=
 =?us-ascii?Q?yK37FHGmqEzcasL7KwYQJHugEEc51QmyvlEcwf57OlAim7FaB2LftCXUZZct?=
 =?us-ascii?Q?CX+c2d2Wxi4CRPwuzYPadQ//CO/pbNhhXki93pe73Vq0kZ27faJoQK9DA2n1?=
 =?us-ascii?Q?qOA6ECfG936QQwirMluknxOxI9QP3/1fFHAZpNTNK1RkbbAElGsRurhqF6Xw?=
 =?us-ascii?Q?AgPq12Pzk0jbJJWlSLwh+8DH3UsjhvsVaPikd2pF9nzB4biFaDohusB3Si2Q?=
 =?us-ascii?Q?LNhcgnfQCCHOoXVyK5nvXNenWi57cSjwbVGtuhgopxUEFxRSwiGJfpc0IssH?=
 =?us-ascii?Q?y4DiaiYg3BU8iv0tLhtL3wMjtaVypUJQFAxplonc8avWZNuu2MYUjeUyfrCR?=
 =?us-ascii?Q?ATL54Gv0Wcm0tRwE/e/8RdIEAybb3fU8Y+QLz3U+5xSq/Gtd0L0PSs0cBS+w?=
 =?us-ascii?Q?qO1QAzyZpJtbLd/h/E91LLkH9msMJBl8R6Bh7iNeCcRAWz9JxSy3a7g1R4oN?=
 =?us-ascii?Q?DEACqnOmT22Z5HcH1po5fckiFnpBRV4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590656ec-06aa-460e-337c-08da1a9b1691
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:42.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFZo32xvsLaALya2p/pbwK0Cwt1EG3Bi62AxfjVzPpaDzrW5h2XHSzoKj+dX0EXqZEx96g1pq5rHDxQA82yNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: ZpCKjBjQSEjA90lMYjM6zKrk1C-dpxFD
X-Proofpoint-GUID: ZpCKjBjQSEjA90lMYjM6zKrk1C-dpxFD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/kernfs/file.c       | 32 +++++++++++++-----------
 fs/kernfs/mount.c      | 14 +++++++++++
 include/linux/kernfs.h | 57 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 214b48d59148..0946ab341ce4 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -19,18 +19,14 @@
 #include "kernfs-internal.h"
 
 /*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
+
+/*
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
  * RCU protected.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
-static DEFINE_MUTEX(kernfs_open_file_mutex);
-
 struct kernfs_open_node {
 	struct rcu_head         rcu_head;
 	atomic_t		event;
@@ -49,7 +45,9 @@ struct kernfs_open_node {
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
-	return &kernfs_open_file_mutex;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_file_mutex[idx].lock;
 }
 
 static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
@@ -545,7 +543,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	 * need rcu_read_lock to ensure its existence.
 	 */
 	on = rcu_dereference_protected(kn->attr.open,
-				   lockdep_is_held(&kernfs_open_file_mutex));
+				   lockdep_is_held(mutex));
 	if (on) {
 		list_add_tail(&of->list, &on->files);
 		mutex_unlock(mutex);
@@ -593,10 +591,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = rcu_dereference_protected(kn->attr.open,
-				       lockdep_is_held(&kernfs_open_file_mutex));
+				       lockdep_is_held(mutex));
 
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -769,6 +767,10 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
+		/**
+		 * Callers of kernfs_fop_release, don't need global
+		 * exclusion so using hashed mutex here is safe.
+		 */
 		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
 		mutex_unlock(mutex);
@@ -796,9 +798,9 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = rcu_dereference_check(kn->attr.open,
-				   lockdep_is_held(&kernfs_open_file_mutex));
+				   lockdep_is_held(mutex));
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..a64a04efc9be 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,6 +20,7 @@
 #include "kernfs-internal.h"
 
 struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+struct kernfs_global_locks *kernfs_locks;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -387,6 +388,17 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+void __init kernfs_lock_init(void)
+{
+	int count;
+
+	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
+	WARN_ON(!kernfs_locks);
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +409,6 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+
+	kernfs_lock_init();
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 2dd9c8df0f4f..cc514bda0ae7 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,7 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +35,60 @@ struct kernfs_fs_context;
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
+ * kernfs_open_files are chained at kernfs_open_node->files, which is
+ * protected by kernfs_open_file_mutex.lock.
+ */
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks and use kernfs_node object address as
+ * hash keys to get the index of these locks.
+ */
+struct kernfs_global_locks {
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
@@ -397,6 +452,8 @@ void kernfs_kill_sb(struct super_block *sb);
 
 void kernfs_init(void);
 
+void kernfs_lock_init(void);
+
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id);
 #else	/* CONFIG_KERNFS */
-- 
2.30.2

