Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3854A7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiFNDoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNDoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:44:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E938BCA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:44:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0xTtX027234;
        Tue, 14 Jun 2022 02:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=OfSN8q+CnVo23NDqHh0S/Z9/fDUvVHplbpLyWz8PKi8=;
 b=p4Al/4pvgGmIuhONO/0LbTihf9lwgs4xRoA3lHwWn4cLIlaHaY8wtZVT9zhDi7bmAAMx
 rDtd+5jVwozGsMuzWOMukc/V/hfx+yJvg5WKu8/vGdNoXOMJ2LKFjYDMmgf3RbtwxbO0
 OyGUCnhuBKzynsIKt5M5uj73T9D7Fl31FN8AfWjxgBryIJ6SVwhGzi8HlI1EAWd6/Ry6
 Xt5BZltfAzJioW3q28mLhUuxGlHcLQF3FOuSOIVIsGt+v3V9wPLIgAccCepioBeFLHbP
 ooGC5AjN965hpbjMZqvAIFe9u0qvoXzPcByqxFyDuwkBbJ1+AhT8c8bZZofCwpfGfBc6 /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns4j5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E20I5m025507;
        Tue, 14 Jun 2022 02:08:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpgyerbhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irDVzOQl2q3tZlQnbC/piQliljout/W9gyMu3SoXAK18oK6DG65yBggOkgdU3U79v4cRDa54odnBfEK9udeEcH34XAlfsS+w12d205GpPTBv3lkhesY4L+jC6lbTz3AhHzic7hcz0vw7u6N2sPJ1/4b4OyF+gXQVKu2mn53FgXj4iDgxqBM9zxdA90IzyMP/+f7ANxxFYZ8Gv7x6O9N7TMWRbDFcYTtrZeuh1sLtVLbdjUH5flWSWtq2X2MJSkzoLjOfrSMd0TwjEzwF5os/TbMovj77WEqwFhHF/F5Mzr0v3sK5Uh3Fbgvj9+nlFCk9Ff20clnaTYC6hKuiGISYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfSN8q+CnVo23NDqHh0S/Z9/fDUvVHplbpLyWz8PKi8=;
 b=iu877/C6NvA8VbMFbgR4rTsFcC/G8dsq5CEdyfSjpZkVG95ALgjMYAxKImVGdmFxmVmFLq3SPAGrqp1P1J5EBPyakd4RYR22n2YtbLbp1jCYdFu9Qcl/6DHlMX/3OjtJ3Tdxu1LxmO3Kq4QDx3FVwiK8/U7u44SWxMGWJaNfFMhKWgLJGGoahAp4kbQWwU69/j1qkyTri2U1egt4DJPWizMxhrWXY0M7ctRcGM0epLLwZOa6SKAU8asmOtXFhkgqpEjEJYDKgJx1MsHtI76OvevVsi9wrFp2a1wTB8L433MjCxzjXr3IEh64C6qEbTbY9Vw7SmwJKtqpZUhGLUwmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfSN8q+CnVo23NDqHh0S/Z9/fDUvVHplbpLyWz8PKi8=;
 b=Sa9t++hBSwBa7NK8ZdxaqxyEYXQJBf1xkxxRSjtN3Hw5VILJ5AvkDvEfAhTlJYALrEYkiWcu3kjy9dfdp6YQXaBlJfkiRBmyjSh7t2gJ0ZSImV05woTYuCtUV3qep6u4r+H17h+3P5GcSK6MLW0MxPHf/0o7rs13D57FVKlGRq8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:08:54 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 02:08:54 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] kernfs: make ->attr.open RCU protected.
Date:   Tue, 14 Jun 2022 12:08:37 +1000
Message-Id: <20220614020840.546013-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614020840.546013-1-imran.f.khan@oracle.com>
References: <20220614020840.546013-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e72f9f3-ed75-4400-4725-08da4daad4f7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23983C6AC36F0AB92689F425B0AA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Zgia1u/tcfTt41mFXO4JSkpgpGjWW4kfZdINBxhOBnSMEm52yUIMi+E3OfT3b3Icl5Ycq9Wz7BouGUEc5SLNLUYPFFTcAQf60lL6GGOAKSL3/X75U06eq4tVm+zW5kLnmHOcS32BeKtyng9MAHjV4E3iCjXVpMjeuYO9VHllnXt3xqdsopDUd6vgSycck5rbPWu8SHRB+KYbxcxAHSimlPrNmwVcNmqMewgKra/WAoJRJIbyeJzPxMNZnL5+odHXEvE2B4VUvS7vYOeFa18Guz85U30BsSkZOyl6CEAzJcuvaAkMCOeuWxnCUzQlfUEtdlMaLHBlsvCvi53xfSowaWWG9BAUBF9rIyEbwQpqcwQCzAcLCkMxS0ctlANMAj0ZapnyD0/lC0Vurtu6pWgYyAd087Rzlj9YdIX6Cr/TsVjbJfdESc+fCwM0yv/6J4i6LbX6HtrKBFqpLisql2IFHPbjYqF3cYRYdl0x7LCOGjIidVbANZcW6OX1kfCMu9dUk3kn3d+BqIfSX3I/wTLIKGZyS/f09rvcS2I66QM/o1vM4piFEOl2U20SgsrI5MScoH2ev7UJm4cOG6sxNTB8JcfoRLtch5+TbaELu1s940Vj4lcxJOckaoLtXfuuSX6Clqi9VgT0JowpqVb5j1xGNCrk5qO03/F+8lv1peqKajhVnJ2Y14mlsMRUaAjMugKhSuT6tik3YekH6/DU+0ssg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(66946007)(1076003)(66476007)(8676002)(4326008)(186003)(5660300002)(2616005)(36756003)(52116002)(6506007)(6666004)(83380400001)(8936002)(26005)(6512007)(86362001)(103116003)(2906002)(38350700002)(6486002)(38100700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fYtLC5lsYzlOeRquz6uRZvRt1jccWXuRUNBqb+yLO9pJa9q1UUwDa9MzXBc+?=
 =?us-ascii?Q?eVH+ly5dT54NfIzLJDHwCvVYXHQMtgFwj0DMFkKGjDtfyaaP6FFTeA0dUcEC?=
 =?us-ascii?Q?1baFVuZz4esU/ZDYU0tPw3z5S5aZYXdKKprjoeHzzMhvYlnPugDN4xJGPalB?=
 =?us-ascii?Q?bLWV80BblQnqgJ7XM00NnU0K3vPqFEs3itvHJjrJsPTu+C19gdAzueLYicm9?=
 =?us-ascii?Q?g371bbFEYHSh4O9zYugFS1ZOv7FVqtSnXVSw4JaRXN7kpfzBX5qZuMovX672?=
 =?us-ascii?Q?Bd+U7SBwLXZ0nE4BoOeFcBjF0w/yjvFQC8VIQJZ6v8TbRQgH8pMZ7p6Eez2B?=
 =?us-ascii?Q?rb7Fn2yasY1ml7cLbEMmjdND4I5CHZlHePAfKqZeMliIIbtXohM8veeR/eMB?=
 =?us-ascii?Q?mCMMwkMgt4w0Bh0gMYWvi8Ybsn9/KZGe0sI363AtzxY0r8Vih6lCA5Sjzlat?=
 =?us-ascii?Q?KCkt+plITXJhiKQnaSIuXRIzwAlRqr7oUd1N8bNzHWCGcHUyV/U3yHEYHj64?=
 =?us-ascii?Q?4quX3Urxx3lDspZvL98KNJgNarQfp15/sGhGxbGBEAbwYf5cHQRCsjD5DafV?=
 =?us-ascii?Q?F5cnuV5YhLQre58DCUXpnUwb8a4+HW5SkafXNmWWIYu9k4kgYvKDlz1keXQ1?=
 =?us-ascii?Q?eegt2cV/evw8HYlkdC8spy6B1BJCTKWhjkYiibAHK1SEZRWKtBHdiGJBxRGP?=
 =?us-ascii?Q?gZltQ3POmz8HB+geAx0BriuzsUjgXUROPVnxoQBZUwjd7OLJg4tv4cibymaL?=
 =?us-ascii?Q?ZLkDNPwfr9DNVuVpxYk6zAGd4gmw6cvu/oYvQ2FiRhkRe4AUSfRF8dr1BTXg?=
 =?us-ascii?Q?943NPO2l3kCIhKbP0z6Bc419HxuZ6s8vwCumVFOTxdArDcb5ZuPHZjGuoX3o?=
 =?us-ascii?Q?S1ZUlWaKbmuO+c6f5LDktUS4bs+NCvjFsVkMOeYNqJOZlZgvZ4WVIo2hkajx?=
 =?us-ascii?Q?79afSvUj/Rjsk1CMO6YarXrxzdzMWD9sVwMGRT1kh3K8KuWP1oPuuY4/BY3L?=
 =?us-ascii?Q?FVHAtTHEZtSETw3mJj7kGHRjA1qtEpYX7U02ak3nGFVAQxo8HyUONJxMfovH?=
 =?us-ascii?Q?2zbSa/CSuNGxN0d8LK6X1tCmCXh4MgHem0eVGxKERYut11EP1Y83eIXnni0P?=
 =?us-ascii?Q?0GJtzJMKUBufzPQ+PYnE8c3KPxl0c0YsY86j8p0nlx9eOXDnFI0tAJNIocUO?=
 =?us-ascii?Q?DCKZgH9Br0OafXbU9il8OxnjjchMxExiyvrThsHq+fbKPLaU6f9AQl8TCaeH?=
 =?us-ascii?Q?Fla8Pi3nCm2DP4VT5byzr0vqUbbUZoVWZqDcWLVueP57hyRGB/z4wkhe8Fda?=
 =?us-ascii?Q?X4FhkwNET3pPxh2cw3fy2mRQ3BYyg4Vn15mnYaWGFuby+yfyowkDbaqoboKf?=
 =?us-ascii?Q?bD2mW3aO6G/UegQXIL7VNeBpxS+4aZ1jDOWOAw0xVf2mjvoBg/TTfwRmFWkB?=
 =?us-ascii?Q?jgWi0oJNmiKzLXm5veqhkEmFTMB5JbViD0Cg79Iy1RqCS6mISmJoP5D1cDEB?=
 =?us-ascii?Q?zF2z8S0+GxczYxYOgBdbXT6m3q12GBmhHpAcFMqa1FpomIwAyf8W3FpHKodm?=
 =?us-ascii?Q?sHGV40OIwrdHZthf2MjLmNhXEdrQ+vIhmdQLFWHUph8TwRRs+ScfnRDQtFEq?=
 =?us-ascii?Q?L3JKWsVaXZllHqBUs9jU/7c4ZztAuM0doA3OeawrBoV1eRi8dh6yLbaARjqT?=
 =?us-ascii?Q?8blKSwcjg8YASbPxVm/BI1lh5pn+5rAB3FwcdMUWiLbQvE2ZdgYTGtBJ4NpS?=
 =?us-ascii?Q?cT8ra3/H54IRMXSQEmgou6xGf3itJv4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e72f9f3-ed75-4400-4725-08da4daad4f7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:08:54.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gME25gI8/y27nM3rWHfwYjhLsJS1hB1ucFwo7jZ4tWsJrEaN9LF0pqR1IUDpltcrsF0jqV1rWsde3nLcRZAhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140007
X-Proofpoint-GUID: 7ehe1OOc1R6gL_qI2oHkzCsEVmFXwHSB
X-Proofpoint-ORIG-GUID: 7ehe1OOc1R6gL_qI2oHkzCsEVmFXwHSB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/kernfs/file.c       | 142 ++++++++++++++++++++++++++++-------------
 include/linux/kernfs.h |   2 +-
 2 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879c..42ee5dbe351d3 100644
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
@@ -51,6 +51,47 @@ struct kernfs_open_node {
 static DEFINE_SPINLOCK(kernfs_notify_lock);
 static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
+/**
+ * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
+ *
+ * @of: associated kernfs_open_file instance or NULL if unknown.
+ * @kn: target kernfs_node.
+ *
+ * Fetch and return ->attr.open of @kn if @of->list is not empty or if
+ * kernfs_open_file_mutex is held.
+ *
+ * We can rely on either of the following 2 conditions to ensure that
+ * dereferencing ->attr.open outside RCU read-side critical section is safe.
+ *
+ * 1. If @of->list is not empty we can safely assume that @of is on
+ * @kn->attr.open->files list and this guarantees that @kn->attr.open
+ * will not vanish i.e. dereferencing outside RCU read-side critical
+ * section is safe here.
+ *
+ * or
+ *
+ * 2. Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
+ * the current updater (caller) is holding this mutex, other updaters will not
+ * be able to change ->attr.open and this means that we can safely deref
+ * ->attr.open outside RCU read-side critical section.
+ *
+ * The caller needs to make sure that either @of->list is not empty or
+ * kernfs_open_file_mutex is held.
+ */
+static struct kernfs_open_node *
+kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
+{
+	struct kernfs_open_node *on;
+	bool deref_ok;
+
+	deref_ok = (of ? !list_empty(&of->list) : false) ||
+		   lockdep_is_held(&kernfs_open_file_mutex);
+
+	on = rcu_dereference_check(kn->attr.open, deref_ok);
+
+	return on;
+}
+
 static struct kernfs_open_file *kernfs_of(struct file *file)
 {
 	return ((struct seq_file *)file->private_data)->private;
@@ -156,8 +197,12 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	if (!on)
+		return -EINVAL;
+
+	of->event = atomic_read(&on->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +225,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +247,15 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	on = kernfs_deref_open_node(of, of->kn);
+	if (!on) {
+		len = -EINVAL;
+		mutex_unlock(&of->mutex);
+		goto out_free;
+	}
+
+	of->event = atomic_read(&on->event);
+
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
 		len = ops->read(of, buf, len, iocb->ki_pos);
@@ -519,36 +573,29 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
+	on = kernfs_deref_open_node(NULL, kn);
 
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
@@ -567,24 +614,25 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on = kn->attr.open;
-	unsigned long flags;
+	struct kernfs_open_node *on;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+
+	on = kernfs_deref_open_node(NULL, kn);
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
@@ -774,17 +822,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * check under kernfs_open_file_mutex will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
-	if (!kn->attr.open)
+	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	on = kernfs_deref_open_node(NULL, kn);
+	if (!on) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
 
-	on = kn->attr.open;
-
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
@@ -815,7 +862,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
+
+	if (!on)
+		return EPOLLERR;
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -922,13 +972,13 @@ void kernfs_notify(struct kernfs_node *kn)
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
index e2ae15a6225e8..13f54f078a52a 100644
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

