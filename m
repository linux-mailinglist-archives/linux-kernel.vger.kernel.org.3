Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF8550E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiFTBPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiFTBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD1B4A9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JH8CIU000692;
        Mon, 20 Jun 2022 01:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WxzbB4BATD+CFL1NiVOP8Rv0r7TGLFMIADPmLhFJ9BU=;
 b=1C9SlW3b4o4FZDjzIoARwLFUI5m0WXWNViYtLbeORLnUcuhb+iqnJCuzThBOcKuhItAy
 uoiAMDWzHafEugrz2UcjqQonUnSmv7ON29puuLcoUX1AHoriA2CcYxYTRLanjWQunuXt
 LhFQFuVoluTaJikxiHeUGRFbLjb5O3MbZKNbOoTB+yLwCvJTeh87ioB8eyh0dEhDSs+I
 hb6yCq+5PTWvk+6TOwCwni+nW52ON5eustfMFKtmiAv88IW/TxhCaZbT6F3lnBjZWN08
 ItZFJ5bIYPR4C/OfFJTzP1wwyFo7uQvgkrEcmYi3wIhjhL46stf93gO5lNOXzPEL3MVA nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cj1bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K1A3RX038698;
        Mon, 20 Jun 2022 01:14:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbf4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h56HvbhhiEE5TzLNRKj+crIyvUm+FBwkqU9th0+RmuuUQbrkdOYuXY4ZC7b9PIHVrrWecb6sC6jbZhTSxHT4VcgHUi4aJl84RtnSkL620MLc5pzcBcTqg6pSJvVXjmu46KWC/xIzM1v/v/VocGxUMMNJd5UtMjFTotuK1W0zSHvNH2YoyPkAVomgjERvEyUiiSG1SiYD3TJTdATTw97ESIktwg5JAuk68lEYlrMJMMl83h1IGDeAPMUE5oSpH16QwwnA9yxmyT7mosy2K66hOu0aR8p1sVc/6jd0Ln1thnJRXcxxRwCuH7+YL0H3MEevwFRtvLpmpFDxSKOJIqebDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxzbB4BATD+CFL1NiVOP8Rv0r7TGLFMIADPmLhFJ9BU=;
 b=ednKIKvhJgjspe8TNI/ToAK86VUWU3eI7hBQh+ncaPCTJve3Jiw+hFPXyzRhDLjS0Yd02S6LMOnwPTdFC0RrQKxpMaH7oiz0Ml7u8jsm+n7bMa3zW7HU8YJ9l6s7JEGCb6+4qoBKtbtAXtZW+b3fsTWfIJaGAjrkAOec7VhbDE9iJTi8qzSnte3I8UCIe7d3hBdz+X34BbAiJlMuYxvWXx4mJB9Y7pXo8oXy1oxIcjc6RbwbNKXJ16PHIb1W00hIbW1ydsuxXygWlqQ02xxqnVSHKmhg+7Yjdf2XB2Ca2jVZgHgIEimnhLrVLMFFlhq21xBSsqecAMfWeJGs1EQ6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxzbB4BATD+CFL1NiVOP8Rv0r7TGLFMIADPmLhFJ9BU=;
 b=u4vsjtzcqfNJYC1+J6GWvnnEn9uUFETbZY8WUaG9X4khj34Il0tZmiQPIMBkFGYLgECTJGzbOW58+Br6wFWusEHH4GeILY+W9J6tIO5TOZvbpLSL/zUWONcbVGTWY4twi2yUrWaLujSbKsG1QQNMGcQwPtlOb+IiljaEC/7Qt0I=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Mon, 20 Jun 2022 01:14:06 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 01:14:06 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 1/8] fork: Make IO worker options flag based
Date:   Sun, 19 Jun 2022 20:13:50 -0500
Message-Id: <20220620011357.10646-2-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: da6805b1-067d-4962-e06a-08da525a2ba9
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1466BCA92A2A15E8F5A4DE8EF1B09@DM5PR10MB1466.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skfdrmkA07eWxeTa1ndSEqDTUt2UCbmazXw9PVe3bzjAfG4RuOFbWJO3KspVChOdcHdfDHVxz8e1nmkhFb45HBmpKtZLv1b1zHKCsR/nguOHaRWtbik9xOxOE8juQiErzhFT8F8X3Uh99jzQrLBiBC9cO9dy8vimOsl8Pk/VsP04pwqJE6wV/kVEkUQutSVu+BOXoRGh8toVDK09H4HW2SOVJBN9uOtV9yErE6KIXfLgci/ErA738k3n2IoEmMi1TaMgJRy/JLfPhrs3hWMGN98SaSLbZR9nqcQ+rKIlIy14WkYxH6veMUu2UFOizvIWdZffZH9Mccwd4Ve/61v1uivGaLuloVJ/OmRcFRmNPOyR8EWAdScmnkBYSdlunLpjflDlp4ttlnDLDFpFFwtWqiBP2vWI0kmuWPntWaY4sPbYSnsMV77eB8LHKhEmLhcPG5L1DHCJhtZZgZMlOEcTJgHST0NzTZBjjnfxQSZMubgv3YgUm+VodocWQHNxPgq3mXI6pGektpCjUP/RzlvpLM2Ap+qAnJEa4f1LJaXrciNMntUTI7rdnPLFDN5QBHD4Y//hlwPTDvxLl7kzuk9mkERzhAkWkGdLC2Jahjf6x0eFL02tnyAfkuqbPbO542Gdo9ChsHfwAkhht4NB4IRcy0A72R7JeR29WlG/WQMqjx93HVNg4H5LSPuvyA0KxLm1wZQipqZFFPsemli8XsLKPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(54906003)(316002)(6486002)(6512007)(26005)(38100700002)(8936002)(7416002)(38350700002)(5660300002)(83380400001)(6506007)(2616005)(8676002)(36756003)(4326008)(52116002)(66556008)(498600001)(66476007)(66946007)(86362001)(1076003)(2906002)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tj+xOquwxT/iDln7tlx43tIOn/CtEpfxVKJgLnuLze52403gq5Th1LGN8txi?=
 =?us-ascii?Q?zRMFUQZJ6s3yhMHnhND+kNsUxGuxyFQt0dyn8piiEmldAL2h63RY4YW0IZrM?=
 =?us-ascii?Q?n9ksYbnZKuo7Om4Y04+WiBLYaPHvB9MBJRtV99KkC7LmJm1yYBVgYOushO8n?=
 =?us-ascii?Q?u+pWK4DI8bYPgZ8gLyutPxpheYk1oswRGjL1wNlzWDN+Jaext6P34CNckRQM?=
 =?us-ascii?Q?TEV9kUjF8PCOXJK2v7fykI3Nauq7fs0EnXgG2Sjxkn5I9eqEGN5SlHdgJXEf?=
 =?us-ascii?Q?QZR3WOO/Gp70x10Y1LkE6h0ux+RBCa1o7DUKONVt5T38CBYJmhGp011I7iQx?=
 =?us-ascii?Q?1E6N6A879pj/6Zc0EjFuXQctG/ivN8H0RQYE/7tOFLP0VI1TZBNR87wah+F6?=
 =?us-ascii?Q?KRvqj0V/nXbuBh3iYAJSDxGYqLcvd8dyybZLEy3tpiGVAhenZADp269qqgYG?=
 =?us-ascii?Q?zqyYbwmtrDer5FEK5rXYRG7o4QhT6bSAYt5MATP5Vzo+K9JlsLSYZkht2p/T?=
 =?us-ascii?Q?YgiqjktSMFQP13ei87RQ/7Uj3jvNuN9wtqJ1LQSIn/S3VpLu6rEMcYPyQ5U9?=
 =?us-ascii?Q?xSqD+9Blw+cpl2ZQdN3z5qNs52MRztxjKTUnmyDbkVCDuPdiUqH4JsEYUeZQ?=
 =?us-ascii?Q?9qsX6C/tJl/jqGfUFwKQVIFyGNCVuUhzJwUmCCnhqB2ZFOgObzJjPcKaxgKB?=
 =?us-ascii?Q?BgXMkOHlT1M1MCXWkAdjhGARoYmMGL4mgjSrQH7TP7MbkNjbJiMHEDmAiRvg?=
 =?us-ascii?Q?CQbke1rdIn3Bywy8yfn7S/L+hrr5p7rMKuiU/uSTxhcDbG9LZo/RjXuSXkAv?=
 =?us-ascii?Q?GwLqwdxm7xEDGtvlPqHJR3jHW1qt99cxNn5SSELe6vuiStqzRE0ec2KEJBVY?=
 =?us-ascii?Q?VKoUjGOIFjtm1JlkoQjAEa21arAW6WlKl9xrlGk5JxLnHW6ujLf8ZRbHcDC3?=
 =?us-ascii?Q?3Eidl/7qdTOKj5OOVpgUETQvbfgS9U+p6BwS+fV6qe+0M2arRRbs2Ha6MeO4?=
 =?us-ascii?Q?w8kghLmo9UFY8v77zoBabYaoIGjmvy2WIFEUxKR5YeRRLRKFqFQY7QN35Vu5?=
 =?us-ascii?Q?OZa43J1y8yL5K8ERKj6yTtLZ+lGN5SabwI8+eGChOp8BZGtpnkqbUWIy7Vfr?=
 =?us-ascii?Q?BtirAr/YNNpO9Wy4ujmjiG+78+Y50iBdEEAh3A/be6jpG48NfcB7abmc8VS8?=
 =?us-ascii?Q?59ZBaoG57E7i3yt4dG3zEF0hEcM0O8cHRSBBnC3wcRP+HCaaUabX9BaS+/nL?=
 =?us-ascii?Q?fYRbuirCUIgDuw85q1PIxd8vXwYR4wS1Pl+9Nuu2dcBAvXc9AnFbYX1RDzST?=
 =?us-ascii?Q?3B6EJam6vgpNAxYxtCIK5/hd8WPkFvdFNQKH6GYonJi1SiF/ieNz9jWyS0iO?=
 =?us-ascii?Q?L51AEOvyee4O8lBqb5gDmNz3Rm7AyS+XXbtqq39B0zTVkyU5ryMmtefzby8n?=
 =?us-ascii?Q?q0wrQCcHG95RkStlZwzGG9px8a51SYVl87dSRs6UgHlDTaO302bCRwLHgV8e?=
 =?us-ascii?Q?G/zGbXkMs4c5CwMVYNFyuT1qqoy0OjFIBfpT/c4SVXk6zLcPYyN1pMmXlxnZ?=
 =?us-ascii?Q?np2/YcZsSkCfoUOThKHL5K3/lyDhbw9/6wR+aidAkUPgar1yZtz5zR5DlY6u?=
 =?us-ascii?Q?OUYbJIwrSvZn/lTiMDMylv4bp68fai7SJNmNtFN7Q0FrSFz4aZWhEb5vuIjS?=
 =?us-ascii?Q?Ms2cnYXyfv2X/ya90CIFwx2hFhkHYE24exUOoY9ytcwZksb1n3uh/bFV6C2J?=
 =?us-ascii?Q?M4tmAAAaILIrD4Wym0ECCBWGDU8S3BU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6805b1-067d-4962-e06a-08da525a2ba9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:06.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5xNfB6LqO0Z1zaAqAJH+j8L4KdGCCZBnl3Q9XSV/5/1bd5a3lv8TX1seygZ23uY/LhLjG58+tEazEBuec5bt+dL8RY8TtK1FLGSaRnv7io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1466
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=731
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-GUID: ahBIelTtR8JYkIXkJY2vc85qWVv16kjj
X-Proofpoint-ORIG-GUID: ahBIelTtR8JYkIXkJY2vc85qWVv16kjj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a couple new options to kernel_clone_args for the vhost
layer which is going to work like PF_IO_WORKER but will differ enough that
we will need to add several fields to kernel_clone_args. This patch moves
us to a flags based approach for these types of users.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 505aaf9fe477..b0a9d6c75bcc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,8 +18,11 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+#define USER_WORKER_IO		BIT(0)
+
 struct kernel_clone_args {
 	u64 flags;
+	u32 worker_flags;
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
@@ -31,7 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
 	int kthread;
 	int idle;
 	int (*fn)(void *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..49fedb79925b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2074,7 +2074,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->io_thread) {
+	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2597,7 +2597,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
-		.io_thread	= 1,
+		.worker_flags	= USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

