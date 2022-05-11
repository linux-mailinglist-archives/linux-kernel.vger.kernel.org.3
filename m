Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14CF523006
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiEKJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiEKJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3F5EBDC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:52:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8OGUK022574;
        Wed, 11 May 2022 09:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MEryTXJE8CmdHi2K4qrJQ1EZMSc1ytvc1cHp7TCXjII=;
 b=fZuEzRhhXo4+C77KYPKGkqAtnDLUnSZzFIJN71aM7JHue4lB6RcZNcvo2D2uVNbjK/yU
 cKxKIWd4CaRm1h5cSVANjB8sk6GujSygdicoz54+HI6poDN97dIKc0pIPoqJTcw4YiSY
 LDAT0ymoGGD8I12l/ORMDLI53RtByX3f/NxC4NacAvY+jDheMtuxWzc4c5WEJ7IFcptI
 h3zCDeJ7IUYG36fq4hAOnFKM+xJAyh7h1XBVhSawn8+GiMVOur8jh5hiWcRu2gS7luu7
 okmTErHT3GPfyuS/FYmyn7WtLPB3QCgPxUWc+QD+Ex75Mwhe10mZuYxktTHLZzLryTXV HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhath828-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9peBm010660;
        Wed, 11 May 2022 09:52:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7ad9vn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5BHQevo3huyU/nwTqXUuBHmUEI5EhJiFw93++0lpfOvkkdOdm478LWKM33CSeZe38INCDpO3f4O34FiHFkEL4W899G8h9RyrDl38q3iQcbP8ZqLd166okgWYiCDk1BEltXoXV7VihSlwXwb5xzUxCT4lsLl1gj7rLbgKdn4mLHftBt9CZLCA77Gp1qCAX0r9/se1bC5qAtazu//z42JMfth2Heu1GpO1TGFPDjS9grKZzBjwtzpyMFFy3KYnhL5xCANpwtuS7VkrsBkL2W4792pBQkDUi2AarwykC5IeFTywbthGk8vuchPgqAtjlz6wdg4+Dsmgab0S0VUs86V4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEryTXJE8CmdHi2K4qrJQ1EZMSc1ytvc1cHp7TCXjII=;
 b=fethLSs/sMCko+5ZUZwOr2Y11XMlwzCcH9TxOmtcODJxKGX3TDyIiukRcpEfOX0TMeOwDs4v2T7RQR044XkBN7kyPewx/m0mHmtReuUjFDMNtPZfhtkpEbAssnPp3qHFxPTRijPiHK6FPBRKh/gkHaC/OsL201K+OtdgT0IOZNkpVYkGCm+uJHNLg/qCMxcmqj1dppsjOCzaU0V+9+GS1TU+fGjGwJeXhdSM0CcIsolV62AR3QQVmCQSQP37p4bqA357+MNMATJ1o1YxLQSm44bZ4MSJXscvBaXicQ6vvivavLpAmno3hF+QG4q2wMWJj615A1J/rpiqG0VfBAT9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEryTXJE8CmdHi2K4qrJQ1EZMSc1ytvc1cHp7TCXjII=;
 b=cDsjQk28JyUt5/c6AegI7eaV4IVPledndUmYSustTcQXDWh9Ube9mx1iKOa3AW3kTiSAQBlG2BQgYhG0une3U6ptu5DprH/JCQkd3vHZiz7Ps8Pg4K6pT6qsrJLiaxyS+xUyowWGtp/troMUY8tR5Vp3hSb6JK2SbtYU0425X2g=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 09:52:12 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:52:12 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] kernfs: make ->attr.open RCU protected.
Date:   Wed, 11 May 2022 19:51:54 +1000
Message-Id: <20220511095157.478522-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511095157.478522-1-imran.f.khan@oracle.com>
References: <20220511095157.478522-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 473eaaef-1c3a-438a-d69a-08da3333ebc7
X-MS-TrafficTypeDiagnostic: BYAPR10MB3718:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB371815EAE92056CA172F1E0CB0C89@BYAPR10MB3718.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRiqou7mQg6oAZcDnDB+R9pbGjY0mVkXcUPYIDWIL1agINwOSYDyGCbotoK5z9c7wEE1oIeJtPh9v492wk4woilQ439p678tZMDD7zJmChkFH0jXtKBdARRg78hMI4EPygOFNsXRv2hauaw4uXZf7MeQKEQ3sb3yAI9iFkbxGjDZupR8mMkMpW34xSVS4JRe6k17hsPVEIIa8lFVsobAOTb/7QGCNcARd/zuA/Vsk+2lgcSl5r/0/ZkHgnPMOkEujS/YhPeuZ5TkshjGjKWKcEUv/BxRJk0p1YeEORYfEpGxxT0vS7Sed5GuueXxprcH+bpf6KiVqRf9upAFWC4NG0Kt4d/qeT7Zkk+fAo0CO6+gR7e6kicITdRg77blCb7rCtnleG40farxjNoQVhElZir+2IQt/68RJMDt1/psocUxhGBazKx5Zse3SlctevGrjQIFiA21ulio+WSKzZ6FTQJfxZI5RONwiwt11YEDUewSoq1HBGEWU0txULForLAiA93/dR69e2+rFTexxi8uWLBMN+epMRwnwhkVdVPJyaYLi0yPfqHOFckggjHC14HEbD1MViGA8c5+1a4nB2Rvag6x2wxBUXcapLnm/boMWtnx16pmN7x8jWV1KkphTwBYiHt3qPeCa83/1NYrhAIhtbX84MPFg48uPUThthSgmrisWS48pjchetwnGLR2gI1tiWq/F9FYqhqMgOhpOIMvCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(2616005)(6512007)(6506007)(26005)(52116002)(6666004)(5660300002)(8936002)(2906002)(103116003)(36756003)(86362001)(66556008)(66476007)(66946007)(6486002)(508600001)(8676002)(4326008)(316002)(1076003)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOEMvVIYZTJLWCvsaNPH4kaYxJTJwnBTeT0+qh1I3uvkapokE+ALbVRYcBF4?=
 =?us-ascii?Q?5xSu61aaVVwkO3B9avDr1KdWYdW/Azz5AmzLRh+KH/M4+8kUzG8M/ubcv23y?=
 =?us-ascii?Q?FvMf7HQweg6OOEVzgngqa2Y8eErDdb8iM9mDEt42ArrZBk5w6zGswUd9AyCZ?=
 =?us-ascii?Q?2B6o9YQxAG/B6KTp9Vn81jTT9vguHQXzxAK2+bssw7RtP0Rw0LsUm26bkIsu?=
 =?us-ascii?Q?GBTZE9ycfQFSLRF6PLD7LSgGK7A4B4KSB4WlBLuQpX6eJ1pfjWPH2IPDU9Yn?=
 =?us-ascii?Q?MvumJAeT6Ch8otdSSdKp9TC1RtTas4ANQY8/efYOxsFVE/jrAVMQhTiJD3IO?=
 =?us-ascii?Q?CJokTOaKvuj5dzxCyAHP952euZyCl4qlTQeOzZj0gc0AXglPGvkfRPhGsDjh?=
 =?us-ascii?Q?+Ze1B6TW7JAkJ6ExSlurvIOvyoMuFj1jrIjlyfWykcy5ceek9IE5/vie12eQ?=
 =?us-ascii?Q?8KabiVCRbgJPChk8EoIge8gCG6jKZ6miBLxfo//b9BTjCCMGscIk3wYxYNK0?=
 =?us-ascii?Q?jQHk7T8PnEM1vVJs2q+PVZUAa94/a1vRpLyipV6l3wxEXuq0V9aC9Ihl4G8s?=
 =?us-ascii?Q?Qtste8aOxEVz/P2jv5IMaMBR1zVoMbQxv0zmnBfHJyDcEkXzyPGP6FP04jCL?=
 =?us-ascii?Q?G9tw8Hx/NWvLMqop3EqGAeWfDtJ+BWLk8E3k5HqX4HY3O+7EbQnVhwDWefEW?=
 =?us-ascii?Q?dKTz0RYOJDW23glps2uZSA/iF7BD2bv+mS0wGODA1ioPJYMYI6rEHwgqmdYD?=
 =?us-ascii?Q?kHLkEbLc47SyX30xQz4MDIQqhSsV39EmrdVQflNb/TSO2mK9LbhNBGaAch7S?=
 =?us-ascii?Q?LeicTdIDkBJJboHbDOep06x9UIISbfJE+5DqTFGLdfrlqz5suYa+smhs6uAF?=
 =?us-ascii?Q?bxQCTtrC+M8p/WtXnEW6fulnTKIlq4rOpnzF0XraRo9WHkBHBvc5lbrDvYKE?=
 =?us-ascii?Q?WOsn0BEmLtvdk4QAD9ij359l2MmcSe/yYnVvrtseUCMWxuWMhKaJwTfptWTb?=
 =?us-ascii?Q?7tLagaBr3sYHIeu2ckTkmV9CWlnMQeHC0r5u/NYRMKZ6uwdLh5Yrj/yijVZk?=
 =?us-ascii?Q?Yf8hwmrCKBGWUsKrD/ER84MyD1d1Ul53vJFVN1Pguwm3xfMePMYYA0S/lvwF?=
 =?us-ascii?Q?VHSiCmxRLQKwjthC+olhfAmu7Ql9ZQYKnoxRAb9j2tn/SGswCE578HxE88IZ?=
 =?us-ascii?Q?w18izglcUay/Y8LfitS94JZ0Njv5e9vPlQ73wfcAL403/SXROIZRnCRw3QVt?=
 =?us-ascii?Q?QZUyI/Ezw1sZ2LAy+Hh2N1FuT5/czw+/l0X83Dvly3Gb0kZdtbj/AtpXgAPo?=
 =?us-ascii?Q?IlsM7O88ElXwX7YxF/2tGQV9hd8jb21mz4Ev7ySabRxTaOqclAHFHDASQD9v?=
 =?us-ascii?Q?h8p+dvTJ4sVbS8216nKCu13c7qcvaceb9pAvo8mPO3Prd9IirmbhcTyPkJ9+?=
 =?us-ascii?Q?OKfEBGVj/LQZI79naWmWtsVTPsIpAP5FmShUTQN1LOyPuZRS6PMvez/4zmgt?=
 =?us-ascii?Q?D9RC43FNDMB7827dSPvP2FKwUg1jKtvjDlCj8Ry1Nkzl8IVqllPo5GENVYcn?=
 =?us-ascii?Q?jhSrv59TTRV6dK0Q+Z7dEDHi82akNIXSf6trI649JhsmH89Q/bLw89QH8yJn?=
 =?us-ascii?Q?gMDyCmc7RDSVWs8Wcp4UjojKbqrUcnKjYVVThnVNcUHYSiXL8ZwwibVpFbeq?=
 =?us-ascii?Q?WGc2VuCAtkCY3sZDPQ9j5mYzBWke56HElJSahJ0cKah6YzCRLXH0iiM7Czpx?=
 =?us-ascii?Q?kjwp2ddNV7tzMMYpxkhbte9/MqfEl+w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473eaaef-1c3a-438a-d69a-08da3333ebc7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:52:11.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+qLZE3YBadgrnOZexdjJTU2jfaHeend+2EZxq3lqQ63+etLZMyI4G/Al7j41G/+koIdNT9WR1Q4D4cqZMelHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110044
X-Proofpoint-GUID: Ik3ukUpnngKJ5dt7OXEbEtXqm_pAANUh
X-Proofpoint-ORIG-GUID: Ik3ukUpnngKJ5dt7OXEbEtXqm_pAANUh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of kernfs_open_node->refcnt in the previous patch,
kernfs_open_node_lock can be removed as well by making ->attr.open
RCU protected. kernfs_put_open_node can delegate freeing to ->attr.open
to RCU and other readers of ->attr.open can do so under rcu_read_(un)lock.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 141 +++++++++++++++++++++++++++--------------
 include/linux/kernfs.h |   2 +-
 2 files changed, 96 insertions(+), 47 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879..796f27333846 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -23,16 +23,16 @@
  * for each kernfs_node with one or more open files.
  *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
+ * RCU protected.
  *
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.  kernfs_open_files are chained at
  * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
 static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
+	struct rcu_head		rcu_head;
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
@@ -51,6 +51,50 @@ struct kernfs_open_node {
 static DEFINE_SPINLOCK(kernfs_notify_lock);
 static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
+/*
+ * Raw deref RCU protected kn->attr.open.
+ * If both @of->list and @kn->attr.open->files are non empty, we can safely
+ * assume that @of is on @kn->attr.open and hence @kn->attr.open will not vanish
+ * and raw derefeencing is safe here.
+ */
+static struct kernfs_open_node *
+kernfs_deref_on_raw(struct kernfs_open_file *of, struct kernfs_node *kn)
+{
+	struct kernfs_open_node *on;
+
+	if (list_empty(&of->list))
+		return NULL;
+
+	on = rcu_dereference_raw(kn->attr.open);
+
+	if (list_empty(&on->files))
+		return NULL;
+	else
+		return on;
+}
+
+/*
+ * Deref ->attr.open corresponding to @kn while holding kernfs_open_file_mutex.
+ * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
+ * accessed outside RCU read-side critical section, while holding the mutex.
+ */
+static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn)
+{
+	return rcu_dereference_protected(kn->attr.open,
+					 lockdep_is_held(&kernfs_open_file_mutex));
+}
+
+/*
+ * Check ->attr.open corresponding to @kn while holding kernfs_open_file_mutex.
+ * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
+ * accessed outside RCU read-side critical section, while holding the mutex.
+ */
+static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->attr.open,
+				      lockdep_is_held(&kernfs_open_file_mutex));
+}
+
 static struct kernfs_open_file *kernfs_of(struct file *file)
 {
 	return ((struct seq_file *)file->private_data)->private;
@@ -156,8 +200,12 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = kernfs_deref_on_raw(of, of->kn);
+
+	if (!on)
+		return -EINVAL;
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	of->event = atomic_read(&unrcu_pointer(on)->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +228,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +250,11 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	on = kernfs_deref_on_raw(of, of->kn);
+	if (!on)
+		return -EINVAL;
+
+	of->event = atomic_read(&unrcu_pointer(on)->event);
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
 		len = ops->read(of, buf, len, iocb->ki_pos);
@@ -519,36 +572,29 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 
- retry:
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
-
-	if (!kn->attr.open && new_on) {
-		kn->attr.open = new_on;
-		new_on = NULL;
-	}
-
-	on = kn->attr.open;
-	if (on)
-		list_add_tail(&of->list, &on->files);
-
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	on = kernfs_deref_on_protected(kn);
 
 	if (on) {
-		kfree(new_on);
+		list_add_tail(&of->list, &on->files);
+		mutex_unlock(&kernfs_open_file_mutex);
 		return 0;
+	} else {
+		/* not there, initialize a new one */
+		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
+		if (!new_on) {
+			mutex_unlock(&kernfs_open_file_mutex);
+			return -ENOMEM;
+		}
+		atomic_set(&new_on->event, 1);
+		init_waitqueue_head(&new_on->poll);
+		INIT_LIST_HEAD(&new_on->files);
+		list_add_tail(&of->list, &new_on->files);
+		rcu_assign_pointer(kn->attr.open, new_on);
 	}
+	mutex_unlock(&kernfs_open_file_mutex);
 
-	/* not there, initialize a new one and retry */
-	new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-	if (!new_on)
-		return -ENOMEM;
-
-	atomic_set(&new_on->event, 1);
-	init_waitqueue_head(&new_on->poll);
-	INIT_LIST_HEAD(&new_on->files);
-	goto retry;
+	return 0;
 }
 
 /**
@@ -567,24 +613,25 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on = kn->attr.open;
-	unsigned long flags;
+	struct kernfs_open_node *on;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+
+	on = kernfs_deref_on_protected(kn);
+	if (!on) {
+		mutex_unlock(&kernfs_open_file_mutex);
+		return;
+	}
 
 	if (of)
 		list_del(&of->list);
 
-	if (list_empty(&on->files))
-		kn->attr.open = NULL;
-	else
-		on = NULL;
+	if (list_empty(&on->files)) {
+		rcu_assign_pointer(kn->attr.open, NULL);
+		kfree_rcu(on, rcu_head);
+	}
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kfree(on);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -774,17 +821,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * check under kernfs_open_file_mutex will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
-	if (!kn->attr.open)
+	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	on = kernfs_check_on_protected(kn);
+	if (!on) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
 
-	on = kn->attr.open;
-
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
@@ -815,7 +861,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = kernfs_deref_on_raw(of, kn);
+
+	if (!on)
+		return EPOLLERR;
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -922,13 +971,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
-	on = kn->attr.open;
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e2ae15a6225e..13f54f078a52 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -114,7 +114,7 @@ struct kernfs_elem_symlink {
 
 struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
-	struct kernfs_open_node	*open;
+	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
-- 
2.30.2

