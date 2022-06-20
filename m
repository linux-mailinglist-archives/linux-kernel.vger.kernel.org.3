Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB29550E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiFTBO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiFTBOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF9B488
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JGt81d018712;
        Mon, 20 Jun 2022 01:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=2j1xvGBUEglWQ5KNA7m6uAvAigJnl8nHYWH3eLconx0=;
 b=hG9xdHgubKBDWtwKMBEt1FW/TZkEVnqol9iNhbKCDyN1qtjkDLLa1Nh/UxKrKl1GtVKA
 vQ5ucl0oM8+NVbE+5KmSla90Ei55M0KOZ7XDBQ2djamwhcW9JoZcj1/T+BZJ66CxaeX3
 6vhl4HQYPy50T4UiNAYdRLXHvdhw0IXQtX97HzYlXS0FsK6r7qc7HhIiq5ozC8kmm7oa
 mFBMz6LkCSyfbR3HMvcGC5xZukOIFaBRkreEppyDBUjjZvdTrDW6K0QghASGLLduzzKa
 MQ2gGnhx3+yVzqTY6lejYklmeZ2ddoqIEW5hnVc4+xZXNcR6UbEkZ5KxWFKDSBCrG1oF iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1t12h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K19qKr038388;
        Mon, 20 Jun 2022 01:14:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbfn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6ue/RiFFENZaHL36VD2nTqGTKqfE88FNLuLNfA/M895rVY4yI9bx91i6NIyRjVU2Tczdqbl4sMZv7vkIsAuVmQjcC4mjZvcNjBuK00SWyASrJymJ4r078xG3t0t/l5kYkm5TK+y5GriK19L/16MW1KN1MEHvU99IS7LtBYKFsKsK+B7ZgUNVsNKBiKVANVeZzUTC9YnCschyxrCPDaDM3b1bVPzPS70sOdb9Ux0VR3M3q/NqvfFmJ/xKUSeZQKYzXjcwbR99QW9N9+eRGm2KMhOQzAN1Yed1R+Bvnu4BB/uG0cCNqugdxA7Kp0ksvb21I1/jcnbn340Q6NTe2MUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j1xvGBUEglWQ5KNA7m6uAvAigJnl8nHYWH3eLconx0=;
 b=DPJGuMkDDzUNmdPeMehCX+Rbl3SMFV5+XTX1GyP7qKfWxFcJJZ3g0vvG86anYgjsPJAPBiudB3iccP4PonYwo/tsHBIaFPQlvTZTesyyn+5zOG6dsDDFTHW6R+NtzXijeSK3E8ycJLK/PTo9oMwDMIa5y2WgTOOckyrcsczJhjR5eFcbYTv/uAddzsbxX6Ck1ngvKy2G3fbmC4N+8FKHv5P7twMXomj8utEHQFkiIubruzOJ3eEmAKiX+aqF7vSWLfhDPdJ6Bcc9WI2G8d34zYoB8soEweWtYLETeNmTn+Xu2yOO49AR+LbShZvRDOpDqixiIdkrSUeXk5DmRSFMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j1xvGBUEglWQ5KNA7m6uAvAigJnl8nHYWH3eLconx0=;
 b=bzfyjdzbn+3Fx6Xn+TA7erougD8Nhd5gTsYAJL/WL2bqf5mwYIcLsr1hvWG9XWEkLu/hZudycYEK78qJgR8R0PYp3MC+4wz+pxpOMOhYfDHAkX3jwABPgIXjIUhdQtXrY2QMxzgxUNruOpaWxq0bxaYfZYUc7l/ogGdgmRa4ukA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN6PR10MB1905.namprd10.prod.outlook.com (2603:10b6:404:ff::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 01:14:10 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 01:14:10 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v10 5/8] fork: allow kernel code to call copy_process
Date:   Sun, 19 Jun 2022 20:13:54 -0500
Message-Id: <20220620011357.10646-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620011357.10646-1-michael.christie@oracle.com>
References: <20220620011357.10646-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:5:bc::27) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d2dba2c-e2f9-4f36-e436-08da525a2dbf
X-MS-TrafficTypeDiagnostic: BN6PR10MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1905E8B61F12D55A16CA8EEDF1B09@BN6PR10MB1905.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t14b4BSBBk8wJ5dp+2NXZUhucvIrOgAkvTbxIktPG4IgrWNFQ1DzObbWc1aA+Ekh8RxXiahCpa1M3xp8MNc0Mk7nopOxSUlvfvqTxfZ/lp7VkYpMkZJZVnnPPRzMcdeXoMmR14YhqrnGRB5D3nsxhWj52FW8aSGg/wni4SGT+U+1mTcviIgr+7p0bT5Xvk4Q1XU+aDFpdJQu/u5Vvzse1uWtnVywNc7E0y0m3g0qI9TOuCR1yV36Q2mjFFQwZzAuSRKoYu4S6dbNvE6Bp5x9xAu84RyqN3a9jyn13WpCjphq+Q2KIaopWQjVL4XJPtDofAjaLY65jMzjN1X285KnRcITh53dc28UrhtrzR1ra3CdVpBM6Cb6UdUp6Zln3aw6HRBtMcdikK5KAOQQBs/pZHrs+pCUjM2svIWHFFmqiKiB8IeoQoWZx+FZJLAJ+bjxSvTenUyIpQpiemvZSEXMvuTs9ikhqv12SAL7Vr1ezdQnQIm1gbLS3+v1GfXb52kTwfR6o7vSGP9ELMyVX+TeQDU/xKS2JWXEht8xpmeun6tyCBtXXhH1ChNIkVvCg6ocAWQ5+qfheTyHNQ1JOrr/rmmD/PZRXWud3OWkWfqsPpwaA4sntsqS9zGm40wtdTEYilS+kWmLQYETaK3eclEjx63ITMgvAfZGnm/fMe/2n+diozbYhK2ofdrXWpa6ZYzn2V4RT3LJ4meghuSn2RRrJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(107886003)(38100700002)(5660300002)(2616005)(6512007)(2906002)(6506007)(6666004)(38350700002)(26005)(86362001)(52116002)(66946007)(83380400001)(66556008)(36756003)(66476007)(8676002)(4326008)(498600001)(1076003)(6486002)(8936002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5wIBlpOACQ7mhaw7hS1XB1OXR1G8oHHZcj4AsV3Q8wFCnrQdAAuc05hK1rf?=
 =?us-ascii?Q?IidA60mmLnPsGVWph98/0TP3QdwYpFgzTWSbQZ+cv7lSV3jQLJR6LF10jein?=
 =?us-ascii?Q?Y2Ky9sbmZ/LL5vHKgcDqBTde9K3qJh/0xLge1M83mBE2fvSzRvDlqAM9y4OL?=
 =?us-ascii?Q?NePcW6IyCFH8bJirFRKZUe2X2QSDNJqUzusA6w4ziRaRARoaHjS+3avKMASV?=
 =?us-ascii?Q?VaaAq99kfEfMgxYJ4ozA9APMRPjtoRa0O+nMMRpqkMvq5KO0NnW1SAe2wG6a?=
 =?us-ascii?Q?faDD//HEHVDnSI8FqxidZYyVHTJr1auuEWadjfG78NVt6TVobVC6aEqpBC/v?=
 =?us-ascii?Q?hPAJjBm6YeQn2AIAubqoueTW1bAWcFsdkq9yOFDo9G4+8sQrq+59ryJSmqZo?=
 =?us-ascii?Q?C8dwMgeD7vHzRdTXYV4PgpYT1HAdebk1lgmWuNmU2kWfx5rXgJwUp/f/k5Ct?=
 =?us-ascii?Q?A6xXZNueLSh4kMNqTt27z9Ux0rJiSMWkkQy7USw7x0kCgymp1VR9eeYrY7fN?=
 =?us-ascii?Q?PMIDh6f30oPyCafmLrk9zT/BwGN43rh92z/oVytpQa+Bc2FHc+xnkuqOnDmd?=
 =?us-ascii?Q?GO7UPYwJfZt6obRIS92xdyECFRJrccisd485eV4p1ZFqNVlwYsAEHT6+HUTM?=
 =?us-ascii?Q?gmT8dP+3rVqlzqkA3fUk8AI5uEkCqdbohROuwPNq99cQb5wW5Y54xfn+1GJO?=
 =?us-ascii?Q?Vua5nurWbcM7km13Ntg/veifTaiL/LaPWRLpItXBKFsaRYJNIxY85jB0z3TI?=
 =?us-ascii?Q?p+72wLD/GcYLnOI9hnalT0RE2DBI4+Xqdya/zpYShUztNFz01tCeTs0pwIp2?=
 =?us-ascii?Q?VV0dvi+xeZvZK9FfTYMprk8BRWat30alMGpMarPt7JhRvyWOaHvIoMrCTs2g?=
 =?us-ascii?Q?WxVnJjPm8N0lES1CTs0Rey9RPGMEIweKwSBUIkMb1tn8qMYIhfbCHNHmoFMH?=
 =?us-ascii?Q?9ewo0NtqTVXDRZC4K4TxEPVHuU8Mc932EvBx76qCTyDAdyKU35811OCK1nm2?=
 =?us-ascii?Q?HsPoatFFLFghHemAxLLIPwPWS180P+kIgFCSYRTrCLm0MgN67BXYHTzcqcUk?=
 =?us-ascii?Q?MWZHLNoBn8oVjAYQ8nxb1Um1lUsgXLkbUUvYoj5l8R/4ZrAPVQANV+MG6rog?=
 =?us-ascii?Q?9HgLexLbkYQI7jgbSk6CsfuJpRRcvokMGbTN7NNqGeYIGTTWwImU81rdDa1d?=
 =?us-ascii?Q?0wEQS+vAY3Wk/6uRLM3uJEfKBVRdrzo5nJT/oQA4M4ns81chMiaSoYrPV9ev?=
 =?us-ascii?Q?FgJNDHz4Rm/wBs9JjNzx5UMIGJJ64d0x6QdkHI4by4IFr6pzKHvMnbQu5gtO?=
 =?us-ascii?Q?KNtLzjaDlc+hpj8EVrdcFMAHH6raGW0f9xAlV9/zem2W6rNlI3m3ELwfTLhB?=
 =?us-ascii?Q?5L4AqP9PzOdaejIfVFv+tAV70q7Tg0z/v4GAj5z8CV0w0ANSOdDgKYeyrMxL?=
 =?us-ascii?Q?v3nRiEEfGd4bSXmgf+FzrIGvXLz392H3isDPFs3+OvsahBGpWTpJzc3oHwqt?=
 =?us-ascii?Q?esMK1HoG5c65OHup6akTacd/UMKaY4VgfIXirrsR+guQS2fgMvu0vNAC8sAl?=
 =?us-ascii?Q?1OLpxTC5JqnL6Z2Qtya5zQ42NJn2CqNX4ZEccDOTSbyd1bMFOZ8G/9piFhXI?=
 =?us-ascii?Q?yGFi/3h/4vW2MiYtwyduqJF5ubfruvFMZz6hMDF886TnpJzFNLv6Yu7kmNYT?=
 =?us-ascii?Q?JgdvHP9MDAduou78SV8UxtXjWt2J+NMU/p5+icYIhmKCEfAPe8+JQwPCeBnn?=
 =?us-ascii?Q?SIafp29Aj4ve6p7zr+Z27cy36KldHMI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2dba2c-e2f9-4f36-e436-08da525a2dbf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:09.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1G+xQ42y8hIPkWL6kZseLrvw+k2eGLmA5Ubu2hkY2+J4Qh2sWHPmZ0Kblu5M9YVYhLz/N8Vt/7a2ITSZadeAn5xLJ/QGylfVK/VUeNjbWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-GUID: 1bQb3lZ6BiV8poEFc90uL0Cy9deJMeOS
X-Proofpoint-ORIG-GUID: 1bQb3lZ6BiV8poEFc90uL0Cy9deJMeOS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds helpers like create_io_thread, but for use by the
vhost layer. There are several functions, so they are in their own file
instead of cluttering up fork.c. This patch allows that new file to
call copy_process.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 2 ++
 kernel/fork.c              | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 9fbb489b2512..ec4a0097fe4c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -93,6 +93,8 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
+struct task_struct *copy_process(struct pid *pid, int trace, int node,
+				 struct kernel_clone_args *args);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index c479b8419a6e..7b6caf46187e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1978,7 +1978,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-static __latent_entropy struct task_struct *copy_process(
+__latent_entropy struct task_struct *copy_process(
 					struct pid *pid,
 					int trace,
 					int node,
-- 
2.25.1

