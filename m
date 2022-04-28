Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE989512B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbiD1F6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbiD1F6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90547C780
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:54:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S3Wv97018608;
        Thu, 28 Apr 2022 05:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dG7GcFp5EYK6YZJsbVee6Ls20dkAdgDheh3ibk5p4t0=;
 b=0V5LbXevmZJ8Tfmskwx93h2nXCrCU0aSMS7XRW6QDyQh/cWDACBkQjDiEuOTMdaOM4Vp
 MX0pdqSz39lAUB1cjI40EbhSATI8zetK6U+EqTwO8snI0yOmSuyAIHA/cazAJGVu0sQA
 8E6Dnl8pKlKtLlOlZrRFNMu3AHm3yFTgwIfVofBPX5vEhcWKFeckItzRfgHVtQ2PuoWe
 +pZJh+usD86yWvgUdozip0nvLTIm4bkzqUewNaevFeUTr8aUHngG3Cy1gG0qD41ZyeCH
 xDpB0aaj7atBn6pPDqSSZmabGIrkAiJW/CNa1bVBovhzHbPA4OMT/ye3MsYJFRZGxfRC CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k300g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S5kbh9033686;
        Thu, 28 Apr 2022 05:54:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yn5ad0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBVFBRpLcHmxm7RlGBxh3dDM6btzshcqVrfUiyFZi5nTNxYvvVUQrNsIyK+023skqO1E80ceiLaES1+5hFztC+AgUe7AGvZgIDLP96rv0nqsAXAv/FC4qaOX5N4JS3sCz+Ls1XOpiYCDU8GlBXeT8WssbfDAhQYjYKPSkhWSlCu3aqipOteyv+wBt5hUG7YPJ2wmac6TuFJ/swzx348FCKnkUk9eV8gixdona7IuphsQZJt4ySMpHPO50BlAu1YNG9lEFfDig698BeWjUOjwrrFBTc4D6jFJQtIGlLSbNLtQoD/B2n+tpoCRNMTNFwxYh4OkLmb/omIMUaqDivKHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG7GcFp5EYK6YZJsbVee6Ls20dkAdgDheh3ibk5p4t0=;
 b=VXQoycgNfa9XWIEV5GBIC1Z6FDqRyRPEfErNXY1BHtBhxQdvQSypEqBQcWFqMD68+sw/nLhOawswIGCcsgKP2eFX8fLQBS0ZChjjFZvWEyeLvB6PO+Smb+VrSMov5Jp/0yk3QERrW93gHACsUqxvuWysbA5lNs8JT1gy+bm24ROp4I12b/LfsSmaNlCiRl7oP0V50UP5O8UN2GU4iCa6d2C+4UA5S3G2oJU7KvP+24b3IpVpp+m/nw67jePmvXsMOs20zyONIe9guStcZeBAWkgJrmzKDMOQFhG9hfzak1udltrvhhtWM8P4q21BSOj2eRWfZJMaPSWwpWiYCY8laQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG7GcFp5EYK6YZJsbVee6Ls20dkAdgDheh3ibk5p4t0=;
 b=iIaTQ4gZDj06LnNeLapTqP2XTLpGv2dl7KK2Age7LUZoGf5xak6dgDKsg24IFtQDTFHeEMy/GQqz0xDXlpL75SrxrksmnKrnSDnC3I5uCO0l5B3KIsM5gt5QCi+ujDxqAHcXi5bqHTPwf2ODpszFrMARX0RRywpbiEMoWbArnUY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1789.namprd10.prod.outlook.com (2603:10b6:301:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 05:54:47 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:54:47 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Date:   Thu, 28 Apr 2022 15:54:28 +1000
Message-Id: <20220428055431.3826852-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428055431.3826852-1-imran.f.khan@oracle.com>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb502f4-98e1-4f68-d68b-08da28db9a0f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17898C56DF261C3D390D7D7BB0FD9@MWHPR10MB1789.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1t/DBHiSA+n3IpjEu2RSVX3Ziz/9bbMS2nxVzFnJVO2wc6DJisx7H/9Uh2KO6pBMZgSlhvjmjWqZWxekS2RaSGwqU0K7lXf81V5hWrdFTCf1wqQsRtKowXEIrEn/rs27regPOrgYSRsrMdZlavNbRhOFm/A7MecV1ZkfRbSY6I9XpHSYWtuJJxglz8JY1RN/x+hWcx/WSQIT47/W+HHcuawUHdA6swC/J4AuTUE6qLKbtLaWfSBFgB2IUdMAgEfNZRoMHwrno4NuaOkY/DB6RxIPKEzZjOSwATsg1Du6uowjjKTxS46qothK3kZC/HzwE+7m09LjTFxQQqAMwH3bGDbjEJvcMn3u4B8sf87Sh5x4hEA0hf17dsJuIVw5TZ36Bh2Rt1/sV8UQZQ+x4OQTGIgsusH7Ra0m8mabdh7cl+aXbSx/NLJodbqY2PNJJ3vJubQaSqEwgM8xbhNOY02x/f5emuIgb/ESARSqGYo4zxZydF14N3GkRbqqnL3ogt+O+yGp/dXuycoEqut0SZMKmN0uB19ZmH/o9zgUfW2MFxZKFMokMLBckyDkUt01j6C6pW5ThBvRh57qO7PDXDowkk5N3M7qki/bjvS/epaatXud1QrG3I5K1BJpaeTNaK52ympfafKh2Bjs244ZYMb+d89o/gBTJXCNrZaoTIcZUaPRgQKe1ND7FrZSJypUSTOzFYyIrfGejgPVvMwo3GX+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(2616005)(6666004)(66556008)(26005)(8936002)(66946007)(6512007)(508600001)(2906002)(38100700002)(38350700002)(86362001)(1076003)(52116002)(6486002)(4326008)(83380400001)(66476007)(8676002)(186003)(6506007)(36756003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H3SSBWVcghLF20EJVXQ0edqQn9c38GMu/POKzZKsjSiqZr25lTmN4HHCoR7+?=
 =?us-ascii?Q?Mq6BEiU0wkFd8xaPoIYVHXobErkgQW4IvrAS2RMcPxXsz8zPegHAQpwPqcH7?=
 =?us-ascii?Q?t9wmxTA1LKkGlHrNxHT3Mm+OfRcZK0wT/+Ho/p5ma+Mx4yZj4VBBXQEnaQxi?=
 =?us-ascii?Q?n810o89X5UwjodMcLWgpmmzX1I9c9SwTFm0S0vLDEa5AIxLRvON1JNpC7L0F?=
 =?us-ascii?Q?ZSIU/cx7YOVCRso0JQ9t8c1ixo+C+5gccP8FLorNoMyGmiTb6LNM3pssLNbR?=
 =?us-ascii?Q?G8i9Hreh8Nndzzw2JcYfQ1xOID9mG6CGy368yz6oc6VDPk7kbU5Mm8Vrgnnf?=
 =?us-ascii?Q?IKhzL3Kq/BokICZ33IZ1wo6cbBMs4RXZ9BKx3lPDo7ZfSL0K0ZEMYkP1zTiD?=
 =?us-ascii?Q?OlTZdaOpQHWSEX6yfnrokL8GJD9AcDKYni65wjKTid+fswjVtMgy5iYbsOA7?=
 =?us-ascii?Q?/ISKnYbkqiB118blntURY7gcMjCVugXS6UtTzXMLvfn9fDrBvzorhULc+TTf?=
 =?us-ascii?Q?wwTgKBjvvEe4xEK4PE+SvxvZ4SxhdNdQ2ysG5t1aX3L/omvLlH2NCwds+gPB?=
 =?us-ascii?Q?dMBIWcdMEfr3hFxzUK4xBTjE3l/vIubnpdnklksNlTUFYYj4O/azbilzlkPs?=
 =?us-ascii?Q?8DZDrgCBNZSmGhF5Hdu442YIYY8PYeTiEuYbPGAtnAplW9KxkQspSQamkUQg?=
 =?us-ascii?Q?Fpc8+gVFFrmD99aZkUDg75TruFvRfGWL27iukIxH3MdKkE31tC17vhTJrXLw?=
 =?us-ascii?Q?nxeZOcu5w35UPPKkwa9mIIv0e7lJrfz/8cdHfldVrhdYAEgt3q2YmDqg+X2R?=
 =?us-ascii?Q?IfAT86mN4PChKnnTVA/wwuv5D+zesAqWXWVZNzcKGWy8NTxhOkAw5xtfy2t6?=
 =?us-ascii?Q?f892Srj74uWPqRmaeWnHuNk394gviecKS7NkIPkz1SL+REHe0L2rVa0WRNnf?=
 =?us-ascii?Q?NO0HD1KB38bxQ6RrghOwFn+IEVbIwyWAzL1/j9dqMc3262YvUg9xX8ceCiUv?=
 =?us-ascii?Q?qiLx5OKJ8Nhyc65sZl7qi4F8y+CvptTFKDP2DwUBKBMtRW0QsWg3X2PTREeC?=
 =?us-ascii?Q?ViKaIuLTUzjwDDyJ0TnTeqITSj72xR3bCC9rAnC+G+AJLhqlFIkpEACcT4qq?=
 =?us-ascii?Q?3K3hIDQ4AgEMc1ST9VyqGuiuxylhABbjy3OGxkbegXfOFD91EhOr4uzkZC/x?=
 =?us-ascii?Q?xnxT3L0lZz3BYapHcogJSd71wdqIojDYK9ZkjaROGoo4bHw6s8PmnOa4JNpF?=
 =?us-ascii?Q?IhKgBrqW9zkZN5HAxySJ1IK0XlLo2X4Enxi8vfAtyZ4VW8SZ3Mw7honN70oV?=
 =?us-ascii?Q?Axk1Dx9Ho0DFXllz/RNpNllBnxrTRhtBQGNNHVTwP4uYkComw1JSIoloS1uI?=
 =?us-ascii?Q?c8CP/X/4fPguL4iBI5Srm+5n7q6XqP6L09uOV6MSvfdDAbwfMo6zdhqgp9zO?=
 =?us-ascii?Q?mIDRf1VdpuhmuEdx0s4zynXXdkrxALwUPDok3atfT4wUl+ZSh6oi1LTqFnFP?=
 =?us-ascii?Q?8X2kMXeItdJwSKCxw9/cDaZuPOVBYHgRm+nnC5d51q2qbI4AhKTYg90/haQR?=
 =?us-ascii?Q?kt6y2nELEHM09DX8efWCch3I6jUI+eUrG8D3QSWh57s+K41jY8F71gCKmiKN?=
 =?us-ascii?Q?shXY4BgDOz/NPyJaHcubvwVtTWl9T9Yhp0dEtiddJRhjzyAMmgHW1G9TkxWB?=
 =?us-ascii?Q?rG3Ma3xfW8u/m74hM24uND8a3D0cOJ7LUJs5FYJChhJdZ5QBtI4XBCAO2/2u?=
 =?us-ascii?Q?2i/yHdKDewb4A2NQIV9eYGYhu9XXnUM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb502f4-98e1-4f68-d68b-08da28db9a0f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:54:47.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXnMmYAtNzkGHcDQWqCeBwG1ovKVHSL+zLTVHnuILAnWfRINijKhU+T1Ir3fDnX7YjyDjRpyVodEbPKrk9Ss0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280035
X-Proofpoint-GUID: -4siOx-vEFCyAL9f4u_JmyKb613j5wmi
X-Proofpoint-ORIG-GUID: -4siOx-vEFCyAL9f4u_JmyKb613j5wmi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

