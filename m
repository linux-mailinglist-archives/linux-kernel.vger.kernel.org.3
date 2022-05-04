Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC587519C59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347798AbiEDJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiEDJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D4275F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24484mUr030007;
        Wed, 4 May 2022 09:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dG7GcFp5EYK6YZJsbVee6Ls20dkAdgDheh3ibk5p4t0=;
 b=LS8fARNbrmjreIRIAweN+dk/mjwJvZqZ5g67GaKkOiOtqAuTSJNdceqkTqmYBM20+cgo
 aXrEzWLMsUIU2WbxbOiO1x6EjtxB1d55wo1LXRuvwwG1C0KgTz37+/51YZiCZOTVG2AF
 q/TnyGdMpz25ClV858KRQ5H9iXGBNF12Vbfr9LmQK7MzZcVyUkABgnuo4B8cmdxrL+Z9
 bPFir9kFdlmLFAoAkhlXqT6MyH/xB9T9wP/rwd8wsbSHwOAD3xkIlMhxpe6gIIe/Eb1r
 oxqC9gcdr2UaplUUnoE4tMBpdaYebQZ5y/I9UDSyt5P64PizJIiXApVTkGR/7EW2uEOo Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0g0tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2449jTbM018513;
        Wed, 4 May 2022 09:51:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbn6r2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVyK9ocrmFqonnZq3HagoQYEwIGWgSUXKf1AduE8bgNd2LdGGZjqzPVleFIAV5Q2+U5nbDTGwrPo5qNB8y5si2a3ykJcuCcDXnWhzHgj9qknpKCVXDPj1ksMWIYOWXL6446jK2fEgZ1e/KFw0yV/O3c91z9bA1wGZEiuB3Fmiq3AIeUldxz32VRXTVx77czrSy9DKiOLdWwVmKMm8o6THUneFqfdxAfZIY86+NFr8ST+xMaSKgvk4MXUY7739FLPUaP3G04TKgh9G5aq3ci3U3gPs2I+Vqt/U60c4Dw2NjVvB1I3q9dqBzqPA8tB2jkPSSLePYl8uG8XXtcDITxW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG7GcFp5EYK6YZJsbVee6Ls20dkAdgDheh3ibk5p4t0=;
 b=axEZ6XTS0JvF2xYyh96VuvFSY8fMxot9fQ5e32oGkmJLYSO5oOwhbek+V4xGZ9GtfEV82GlV2DlpCUPI6//AZu52aZeZFff7qySHrIXe06Hd6Ck1p8Q0BbegoiIDrWSAm7rRYaeb0LBQ6JFFTAHHePKmc/xvJrYqDMmm/wyG9ibbQDmrAIyrJYjhPHvJF7dOsqseqJXUZPY0scI4MtmJy4nZAfzbHavOv8M5mMamcmd0za0ubS0UWMTagsap10nUP7zY+7X202/p8JtGWJRNT9SkHJWf+uWAMDunPe64kNDm4GBoriJ2yniG6j85+k5o6KS3Oh7Z9fZPg63aO3AUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG7GcFp5EYK6YZJsbVee6Ls20dkAdgDheh3ibk5p4t0=;
 b=fNeCVYsTP6Y0uJxxkqUzNN7RlmismCCN5NfxFAHqYgQbnNjxTpqAkBsi9PoFo+4A+elrSq1RCxUgOyhJdBSwv/cnuhdxXtXOUDOO6L+tH/JhnPKzUIOCBSdKUEarOsN2k1PW1VVceSLFdCFuhMsFaON1lQRNdmSVQzIhupPbc6I=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2316.namprd10.prod.outlook.com (2603:10b6:4:2d::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 09:51:42 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 09:51:42 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] kernfs: make ->attr.open RCU protected.
Date:   Wed,  4 May 2022 19:51:20 +1000
Message-Id: <20220504095123.295859-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504095123.295859-1-imran.f.khan@oracle.com>
References: <20220504095123.295859-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0203.ausprd01.prod.outlook.com
 (2603:10c6:10:16::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d0dd33b-a723-49e6-e5cf-08da2db3b122
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2316:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB231671C4D0BF58E36D7FC07CB0C39@DM5PR1001MB2316.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yHNGlNmF4MYG181h0xdXscLxs/IbCBPJyGIb4IEwqNBYwFJM4kIBWPHoEQ5cjCU3FixNJhxxL7XoMOZZIiwQZdPeCQM+16Fucp/ZnVBSPHlH5LWvXZEZLCTFF0FULaGCgON3Dd2DQfIIGeVDMfeu/Jq5Ib/NRkI0Dq9IVbEZZ/MMm80JdKQj8OjWVQh6o/oWhmW0bX0xVmWqoi0l4MTHiB/7LyAcX9Vzpb+gZamjCh/lfmrQbTJvlO7NBNr/5Vr8cTcbzB9v03ZfDta+HHBgxzj786lr3UBGL5oXlY13U4C1xxnbzGzegV4m38p7eLS/SBf/j8JqRH/VGQ4n+GlajKZU7myxDWMgjWZPb4yimVlcE1ZghoBlPrPgUr26KRJN44jS6WEJpa4J4/00+3542BubThGyDJCgBrNY1udfzF6FkAfa7iQTHiS7uxVOMr7dRAEmm7hIrV1aiPGgZ2/uRwVEpl/mgeUgFJh0CnDagacoxirNG8prHXgTp1aU6VJAVJex/kXELbIiJIlPy5CsTHGMcz3fpBDCohIC+1Nts8BTUOgiqSA53JBXIHXYrQ81vxRum+FsRth4XlSSk4OEEzAAUoZL54N7k3bkbDKXuL7dv/jLFUPtyMAAreEGSjFnYlqd8nAr+25jjfq65B1D5KRr+JUqu0giMOhhg11zLgwJDsDhv0F2tnHHpYRQHwGgZ76j+u5FaPneng33T5YEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(2906002)(38100700002)(38350700002)(8936002)(186003)(36756003)(83380400001)(8676002)(6666004)(66476007)(66556008)(5660300002)(26005)(66946007)(1076003)(6512007)(2616005)(508600001)(52116002)(86362001)(103116003)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRekcAJeJGMDQIkdEl9TK3xvj/I631a6nNWkaQSKz1h7bwm30WrkohThdsCJ?=
 =?us-ascii?Q?Ok0DCTnqMGevWVirkNPIC2pocvCNE1Snm/SdJMQXFiCwp5/teog4S9w5vwMi?=
 =?us-ascii?Q?dF+UWq8dd7EDOF6Dp3uoU71gWzRh8L7VSovQGq+tRE8GpPdvHj0oI4DScCqu?=
 =?us-ascii?Q?LJLbQTgJBtIk0ctReU/IEfhXanxapCMtUijph6FL44WzPCvkFDY82WdROHTW?=
 =?us-ascii?Q?KqrOgbIaOVLL/H5RRmcysBhyu+QXdfvWFZS6LxdQn2MeJVO5tJSsmHkdPm32?=
 =?us-ascii?Q?u5xOyCHFcDNW5v9Yo0Ff9+zGLkocyvB9nMAyYXmbfYntPQFa7aJ5BX/J67KK?=
 =?us-ascii?Q?IV6v1eqXfzzqf36Jsix6sJJMHwaUTG2wvElNw/x9P7j9ZIGXk9PWPzYdyXuZ?=
 =?us-ascii?Q?m5yYCCvDk9Ggfd1oYf5YfWhA15kCREEgRJBya2eGk04trXNp6vWfie7EJOLa?=
 =?us-ascii?Q?1gpLR7G2fEGPDwndNbAX2S/SBSvZq0og2lptwwMAjBO4su9nIu2aO3Ltn4WV?=
 =?us-ascii?Q?y5fW0+FzDkFSq/HdFyFq4jmXQnyjZcUtVKAXaBuLkRXEFcyPez4EzxKSWNRn?=
 =?us-ascii?Q?rAqZKbWadrtE7dKzqazkmQsBSKP/DMe42wlJlzueVMcuEL0n8Vc+56nJz7mq?=
 =?us-ascii?Q?9LcpGp5jzSM+dwjIghOXu/9KcFLlfbHIocPwTho/JNKFvDbjrMDmLtD5W2s2?=
 =?us-ascii?Q?BfBoej/LuA+3OF+CjH7sKdRNgtSAdNvyTDxMEHTlN2h7Vwt9iZAuML1qe7dD?=
 =?us-ascii?Q?+ttRQwAI4W7Icu37xlbodljC3pV7eXAkEyUkCDNyo7Lmpj+cgeRpJGdy1ImK?=
 =?us-ascii?Q?Z6R3seUmUjoCQ6F/QnV96mx1tQcyj27KwABQu7aDTCTu7ZixX5OuYakLjWEZ?=
 =?us-ascii?Q?NQ71ktLEofiLrFybUK+ocFnZIZu9a1YAv5aTgJOWl+UlDYUOlvWbpa5kAfTc?=
 =?us-ascii?Q?XZNKcCHZrQFkWlMVnEOZTe4rFr46KO7lthlZI8I2ZnMgMPvU1OeqzFLxO/NF?=
 =?us-ascii?Q?dYcjjX7Ze4QQhTd4QLn7TSZTlC8DnnaWs2oVkeVJ7VDLTOBFS5wuEHC5Dnyt?=
 =?us-ascii?Q?WLz9yVar7cV3WHqqSb1fbkIK6gBQoVEXVBTNNu9/hmw0wQaIt1+STvOi7fY6?=
 =?us-ascii?Q?ezI2e+sNUxoQXkpNQ/l0PaPSWWly5+TXkusDAd43KszUxOkXDO3remWnyAij?=
 =?us-ascii?Q?zlSiHmt7evx2tgfYsoetshIcK1yH2piuklHi+baCEywg30iezrFipS8Z6HFp?=
 =?us-ascii?Q?huQ3ACv32+fsZkXAHyHTrfSEh+llK/pOC4Ni0BmGrUSN3zKfjCA57rQiIXiq?=
 =?us-ascii?Q?gYqOaWBqYRe1teGb2lVqv3vdYHXS26Z4IKC1La2537D1OtMuKlXxrzxJHP44?=
 =?us-ascii?Q?Hj0Q3WqfN3J8i+cvStsqCgmrIAMXmPZweDyUwldz09K90U3b+SkuEx75+CPR?=
 =?us-ascii?Q?zghPfrS6t9NokDzqMyvWIdONYwnXilTymmbQLLJR9Khjv/NKuVQ6xV1EfowT?=
 =?us-ascii?Q?uJuTEtIlLKi0NaD2b4lvNECr4/T7uIJ2jr6YvPeOgBxPpD34TFBgAuIykE+I?=
 =?us-ascii?Q?Z/mWNnYaQmT9uekjE6A1xVtBkEtB50ERQeba/5TabOLsmHzDEq1ngmx2gb8F?=
 =?us-ascii?Q?fDYPjt7OuiXe+cpVFxDvHUfEQjy6wORA2WAdfdKLQ1dqtMpM7uhyIxWXgNJD?=
 =?us-ascii?Q?oplJ3OiPENk08dLIVF9nJug/ww8GJWpnf0efkb67sLPO8FH43FgHAMHdtN+3?=
 =?us-ascii?Q?Cy+ht/bso/Q0YBTi2s6sYz0X0p8IwQA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0dd33b-a723-49e6-e5cf-08da2db3b122
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:42.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WJkMvYfKsjVE0A6NK33tjl2swVfU/otVIO3Aq7LVeIlVsik+ywg3ZnZeixKGixwPq1vRv5yT5/Qx0H4+K5sqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040065
X-Proofpoint-ORIG-GUID: oU1O_JjiY0QM6WmtqVp-N2STes3Ke0E6
X-Proofpoint-GUID: oU1O_JjiY0QM6WmtqVp-N2STes3Ke0E6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/kernfs/file.c       | 120 +++++++++++++++++++++++++----------------
 include/linux/kernfs.h |   2 +-
 2 files changed, 75 insertions(+), 47 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879..36bff71ab263 100644
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
@@ -51,6 +51,38 @@ struct kernfs_open_node {
 static DEFINE_SPINLOCK(kernfs_notify_lock);
 static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
+/*
+ * Raw deref RCU protected kn->attr.open.
+ * The caller guarantees that @on will not vanish in the middle of this
+ * function and hence we can deref ->attr.open raw.
+ */
+static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
+{
+	return rcu_dereference_raw(kn->attr.open);
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
@@ -156,8 +188,9 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = kernfs_deref_on_raw(of->kn);
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	of->event = atomic_read(&unrcu_pointer(on)->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +213,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +235,8 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	on = kernfs_deref_on_raw(of->kn);
+	of->event = atomic_read(&unrcu_pointer(on)->event);
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
 		len = ops->read(of, buf, len, iocb->ki_pos);
@@ -519,36 +554,29 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -567,24 +595,25 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -774,17 +803,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
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
 
@@ -815,7 +843,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = kernfs_deref_on_raw(kn);
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -922,13 +950,13 @@ void kernfs_notify(struct kernfs_node *kn)
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

