Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F692525739
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbiELVrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiELVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C11C136
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLVQPf003190;
        Thu, 12 May 2022 21:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=v1XyjQOsZUXbXlg2Cs3rOKGBHG1FQKGTZzOGb8GakCs=;
 b=GcZIRTA8YVoBmDADjI8FfpzedtoYLb5HeR0WWFZmijdvGbbepCaZAZHWHDNBSYKSNnn1
 tUvu6bI40uYqMIeUx7LwTkWrDaTkDhqAOAGtvc5GitNqlqMNMKcwwF5X3EmDCSVgcuHe
 SKReftx9/phnJLomZxMlXBi1OsBbq1XercGrgFMewUhFf0yFGBkoZxjfughHE0pOXHCi
 6BTyRXInMtX3Jgu9Ea009MNdrNZMH/yRXERmCnhE1hgRdCIkdEf9zTCpyPBb7oPDNT4b
 7e1U3Ybq1kXuyApFeFKZDHgSc4J7Qdo9TSO7bd8Uc8bwKoyvzWRKHhMPHG7e02BiLdoO Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04n2hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLgIkL004728;
        Thu, 12 May 2022 21:47:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c98s9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3JX0lrSzha7nY19yUgpZYXMHLp3NzNh6QAm8aqvrbFilmc0B7FyWCudkrR93UYcqDXLyd2xXRsNKz1YKGUeizWaiZZknyjquovaYmasKnIYc+bKo0Okh5zATf5/Q8QbWh27q/vkvlwP+lrhEjlziVTLZv3KIY/d4dyt/t46A0QhyNr0v6aOSgeIwyNybAPnD8KWvFzqnMg6RRHB8q+qM9NpkEUeJ/58s9yY5UpLyGm3/GdIy/9iGk3zWIymwBS5EQI5possRI3rAWVrShzYUZUVd8kxV46jyCHBVtgVWrvmjUMkvBHQVBlWDN3ElQVfH/6BUN/sYFWORu/5cSAuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1XyjQOsZUXbXlg2Cs3rOKGBHG1FQKGTZzOGb8GakCs=;
 b=DYtvaXwOb7SJApNmjd1YFWmkAu9gey2VtP/XAxYqs6MaShIBKyaKiM31MrAnZ3sD8hxJRBIrmly50J61+tMHmZ+LWMSiB9RXuM/7w75O0ugWaLCrFIy3du0JGc/QvbFY8Jok+QaavYqds8SQ57wiG9ZWKlolNGjKD7/JvCTJ3M9UqZXJzUNpvRf3IKLzhYzmLe9+1Rd8RoEfQSzzsE9f7UJRSvgoaOF+aJr0+arySvtTDD56cUbrNd/9fov67gTW7EQF0PjpQOAZDA4JBsP6n1Qu1brAVUmVatj6ROV/Wp0IGjfVD/B3K/K3+9EuQmsoaZtYyzuEKG90q88WuYrAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1XyjQOsZUXbXlg2Cs3rOKGBHG1FQKGTZzOGb8GakCs=;
 b=P1h//5oirVoM9cyzABxjkWZ+hn+8zX7uvpXgReSng4Z7YcBkFz51qzJ9rXygXxqDkXL3Gh42/VK3LRFfDb/ZK6G1oiVczfbxAzSIShvExwjFH3Hya8OxEfp4PT1YWE/Rq/9GR9yyXmCsP/rSp92ABwxUd1QyfcLFhgrzpJo7qy4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:13 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:13 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V9 2/8] fork/vm: Move common PF_IO_WORKER behavior to new flag
Date:   Thu, 12 May 2022 16:46:58 -0500
Message-Id: <20220512214704.104472-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
References: <20220512214704.104472-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:4:ae::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b716eb5a-2b77-4ae6-ea60-08da3460f91e
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB33112E3902B118922C5E5EBEF1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVyXVV9qWojAzYQa9CzLr5o1KttBmGkIj5K3R37Tq2d+EtCmtOE41IkM1Ax4P/0yi97z9WM6oMp+SajR6t3DWNDo+pWjxwDT2d6g0i5qvlHxxHSxy2GwP00nMU71yYrV0hR6uQcXcDATImBxKHL/tXI6aN8D9mXDS1Mbguma9uUiqgBUTerHRXu8aYoUVjhPO79D+fpXN73igVi+t2tLQYDaxeQrdait+87sZ4tWt0AjHi50cBKxx45tFFLetSF1oMkZON+fAViylFDONQbt1jniyMwX+nvwlHWicO8/g+6vdPdaEDKKgCyN+ia+Y/BurecEBy9KAM+Pzo3+jqc+1mN/rc25lpMK7Bb7OB57fNfeRcUS4H/Ez0gevzU3L5Qf/35G8h47EWoukzPm0EOYinZlykgde9qeEznDltC/vnwWCfSZTctUX6eNagoHxzbPKp3o7apTfHUUml447EIktp6wB7OEFrmSL1WT1RxzJgaQUBhPQq1Ua6gnK9CKKedUKmXWzODiF5J29hbOFPwuVc6PCCjz8rbCnPohcPP6ElA7ik9uCA7L7REMyGKnfveJJLpOozc+x60lL7bSHEL2HYUYnZEQMwrk8Ix0iFsWGEsRo4mikPcEF10uhbjAOsSXsakh88TPPaJKnMihvQco6M+YzQ8bwr/J0w9nK0FYOwC4B6fyQP+5AXLakGVd11Vjm7gPtkJ+QEBorL9prMoqyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(38100700002)(83380400001)(8936002)(2616005)(107886003)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YVQtemFZVzFK5qIzKigYR1XfrtT8rujuWm7hpn0TkKzI81JCUYVKGa0aPs8I?=
 =?us-ascii?Q?YODz5Kg0SoUMCjwsqQ1dxMeXCcod7/E2nvbsN1IjHC2ifap390GC07dsIJa5?=
 =?us-ascii?Q?x8MMWhl8LZ1NG7Szo4cYx3g8UJNEgG+Plb2CJqSlu1DMuYS/o+Nj8FqvmIQB?=
 =?us-ascii?Q?hddSlHkT1/jIuprG+BHGtCmNmeDEBD0jx1QRhEVuM16Zre5oc1tQN/9vBJka?=
 =?us-ascii?Q?0P+JLjApNmVQ1OwVOq1y7CJcYbVtOnKtNNHTBRmyCSVHBXBGRd6MGx9h4Kgy?=
 =?us-ascii?Q?+KrKZ0c5WDBfqB3Eig/avQJbV1ecjoFoLg5d23DeBko/pFPDkXq3lj3B6LOV?=
 =?us-ascii?Q?5INSeK1vYZfnV9WDC6OSfk4Ng2mtlXuoafROoECiSpDWSjbkijZRBejk2Io/?=
 =?us-ascii?Q?9wGd59FOeYzX47kbm+GNmobN2U9I5s6A0I807Dc4zA84B436VVNEk4vFvRF3?=
 =?us-ascii?Q?wkud6GZqOVX3gMwFtxNYQhicEUz31xyI+9owxw784ladVdPYpt44JOY7mFMX?=
 =?us-ascii?Q?ZAKqqVct9e9GxsSqLJLDkl2oCrw5T+4VhxtUffhrPIwR2sUBo+U1GuBKb3Ua?=
 =?us-ascii?Q?HI5c36wzII2t9IMDYhl3DlQVd+27O7UzdxH68ICNZ7klqlVgPO8M7lEo3bar?=
 =?us-ascii?Q?xtLM1AUrcmNvkOZ1YlYCKZXRoQHdPDc0NNeSp0f6PCNkC5tAuA+VV+WJq06e?=
 =?us-ascii?Q?3/Uw8pOYKj4AhV0Fjar+86l8t+Hdan0O7s0RsPqRr+iBwRmBU2hWbP5UOPQU?=
 =?us-ascii?Q?L+ODdd+rcfY3mUIhzG9xheegynm3JC4+E1jL7gOdaM+jzGMI3qUTRwPLnpu5?=
 =?us-ascii?Q?dPNiWbE2ZB/aSVvfk4wdOY5GhicfpfD3ItHXfr1PECPze9uHPruKJSt5wcyu?=
 =?us-ascii?Q?93WUwx3nVe0WcVYmYfM0mQ6hUoZQZfSWC+O/w7DRbpYEonoTiz89aGo4lNJU?=
 =?us-ascii?Q?WG6+IeNOaF5ZklIhIq/dtTyEAJcKzixmBPS3luvw9LKtjz7RZgmdLNEXRaDu?=
 =?us-ascii?Q?XYaMRzwd9h3fr9cMd9DVmyOFINjJVGHzycSsAljLhHTx022FF8Rarsy34n1C?=
 =?us-ascii?Q?+WUX7TBAUXpHD5jNRXnEmYbKvZLwOtzh7VClLGzNxzPawOVb6yQPsH+bsBjh?=
 =?us-ascii?Q?nAWp8dbc9igFXSqslDui2hwH3y8P2rpw6R0w8YRyE8XQg/Z0E2Y+H7oUh5CM?=
 =?us-ascii?Q?bMQ1YQe2jQiVDG4AhdT/RzwF38JkvcYGNIP4+EJFe75P4k4oUDWsD1JEVDv+?=
 =?us-ascii?Q?eMJl/Th1z+tNUF+drGCmv6oIjiKwFhUnkc1PVlQsvmMzR5Cjw1zscA5UNlbU?=
 =?us-ascii?Q?U0IMWFOCFTUJ0c1ZkFSwIthpXTNimW3TqVrKVNQK0xyoT7YtzFLd/BubqLvO?=
 =?us-ascii?Q?AVSvhPNIYt0uDn0qZliRlQ5W/HJCnYk+BNowD4zYMyNoaQRmESsHAJIMyddf?=
 =?us-ascii?Q?nBSDMPGwLSOOpqoKIoWaFbGiFMigo/X8lpN59N+eeGd4VWiQJQuWSrrjCPNq?=
 =?us-ascii?Q?zBGVNRSrvdk++oXEJavlMyPrvwW32DrB2PyLq1Pl9IFluNI4sp7EG0cA6tFE?=
 =?us-ascii?Q?JjcJRbdkkrsW8q2nXY/IwhUjycMKTNEvOrHCxLpSQ/Umgh5FUUKCg2ogKQfJ?=
 =?us-ascii?Q?B3k7itLeBYp+JoAfKL6aC9rKkmULUWlRCL9PW9H6mXE/Q+tTPczcOsLhKRbL?=
 =?us-ascii?Q?iKidtyhLWBeI1D9iaOS4VC9hjAW0N8lgTQzjcIvDf4EaiCFIl7B3rd4YZtOZ?=
 =?us-ascii?Q?DN8ceKM8DYpYsO0/w9Cy88Hydr5BsvA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b716eb5a-2b77-4ae6-ea60-08da3460f91e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:12.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t/hGr99WsIXEWdZmVZuJeZ88iU5aWBnQPDGX7HGkFWtrIS1AtmT7k6+cU2UHZvpf+UCcfBkK0Zu4KE/0n9QMThEFFASEKhHP3TC927cd+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: 5YFTjurr7syQmLBVMbnbXjXQUy64EBRM
X-Proofpoint-ORIG-GUID: 5YFTjurr7syQmLBVMbnbXjXQUy64EBRM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use a new helper
instead of create_io_thread because they require different behavior for
operations like signal handling.

The common behavior PF_USER_WORKER covers is the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched.h      | 1 +
 include/linux/sched/task.h | 3 ++-
 kernel/fork.c              | 4 ++++
 mm/vmscan.c                | 4 ++--
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a8911b1f35aa..0fa66a098183 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1700,6 +1700,7 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC		0x00000800	/* Allocating memory */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
+#define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 #define PF_FROZEN		0x00010000	/* Frozen for system suspend */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index b0a9d6c75bcc..9e20fa18c41f 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,7 +18,8 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
-#define USER_WORKER_IO		BIT(0)
+#define USER_WORKER		BIT(0)
+#define USER_WORKER_IO		BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index f4f2c88d9a2a..19293bcca001 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2071,6 +2071,10 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
+
+	if (args->worker_flags & USER_WORKER)
+		p->flags |= PF_USER_WORKER;
+
 	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..0f58587862ef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1051,12 +1051,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD)) {
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
 		cond_resched();
 		return;
 	}
-- 
2.25.1

