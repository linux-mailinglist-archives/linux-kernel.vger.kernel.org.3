Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE575137C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348806AbiD1PK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiD1PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:10:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255F47076
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:07:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SDZgIE025808;
        Thu, 28 Apr 2022 15:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=B/0LjjJFeOX25qHvCdZIVeL+eUxycM45omu6V0qfnA4=;
 b=ZT4SVzlH2bcrwXkda0U8Uj7zPo/uXgrqQLwUzgdcYshfwqUqQSXgbGyqJRRgaOOBp4hR
 I6ehHTKqucnNuwosOBx6P9idTwzs/no1rlW6ky2dMwh4a0tYX7pzIT2VmEZAz5B5hfSe
 h53KSH0hi/ZyTd0ycFcT+9+JWW8cYUGwQu7/p+LuBsjJqc4pwF3R8Q3Cq8p0Ejc/Jvh5
 Hpf1URl5UkKSdtay+gRh4zrLlhjyf0auN1veF0IrXzZBJX1fF9dkn3WyVXErdoB05svR
 VjUYlaqdSutb19/aQ9etzRyrMIc1Xyc1G+mPzDkh73fppQkjI3fFQS3kl/tlY+uG8Mly dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mvdan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:07:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SEodLc016542;
        Thu, 28 Apr 2022 15:07:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yny49t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6PnYBKwJqsWN2HcsgZnIx9tAT9ySiAQ0EsYXGpJcGDlvo2/gTTk3UTf2eV2YBRwHYG0N13djadLDI4Oc3F4DhOdod/BpWfM6RZoSMBZfrtcESSwXe4MQMWeIWzX86UZLJWYDlSwMcgHi8Uq84i4xfWG4csGwrYdw7x8FhxizPkpOoLG3IuoSCaR7WBV08KDjYb73TEieYTy8H18q9/uGb5WPwc5NmiN6OEOlQnz8T29A63O9KGXK6ZEBL7TS0SlLrLtEGgj4E/Jpe85xTw6/7vJh9mNsWJPqGdvNBuL7p+ANHGode7Kqqu6oDVgsqbuZVOjp3IpMpLEljR5Btlr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/0LjjJFeOX25qHvCdZIVeL+eUxycM45omu6V0qfnA4=;
 b=loOrxhyqf5MTiN3xXa5Nz9yFsfxsCRixKdP9Tqr8/sFEvLy9udCs0r9YMkLbj2LgQjqsCjSIoo5S8vlevckysjCZvE3tetqozNT9BRaFz4c+JZKJqrtTX4UlnpGbK1Oz5CAEVwojx/83VeUI6o2Izt6u1H0NmPUUdbwckkP7/S3tBSlJ44Zcr8G0r8QyX6j89Kejg23nYxJ0591QuI4xs9f4Ok00dU//2DViGeuAnsImjjCW6eqfKJQv/5Atvs72LRfAvOj8hHkDN34wdI8A5O2vkaMx+xILoQVOzu3j7qnn2/42hG2lISj0MkV+mmz9gqFLpjpu+SbDsmKcx8TLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0LjjJFeOX25qHvCdZIVeL+eUxycM45omu6V0qfnA4=;
 b=Yo4t933VXn4YWMIgOjS/p42MYiVWrIryjWO0XS5tu6KhWbwkA7E3jMQekRzyj6JCuJiOcztWbVEDPTsGFm4J/mgYbUB1p7qJNiymuSqxRfcr0emhpTbdM8SguoeDOpCImIg1A/iW5nCeMKkhLWOU+3R0pL+JoBUzjxJwFMFZRj0=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by DM6PR10MB3641.namprd10.prod.outlook.com (2603:10b6:5:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 28 Apr
 2022 15:07:27 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 15:07:27 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        peterz@infradead.org, dave@stgolabs.net, manfred@colorfullife.com,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: [PATCH v2] ipc: Update semtimedop() to use hrtimer
Date:   Thu, 28 Apr 2022 08:07:02 -0700
Message-Id: <1651158422-28014-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:8:56::14) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18433d51-3a8a-45e3-ee3a-08da2928ce8d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3641:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB36412535C898C4C8E3A17996E4FD9@DM6PR10MB3641.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7u32IQuTC5lSXJxNN6sock8+k1OhzTiPdwRQcSpLBeBKb3LjJRGkjaP+z+CH0Ln3QcaoWG4ei0qoLY+iSWUa0DIHBFnToWHAYukbINeVdbDkBswvMETi9TLMAzRrgB+8u5Ug+Wzsxnw1ZFvbZ6jrEW93VYjMLwA1jdG4bcarz5udMKTDdECCuUMIRRFB2bsT0CrZ0AK3gWHOMVdTHqqtcheDqoTuzBNsxYuoLSO2h01Xb1WxPqtwQ3UFsB6pCrFV4SNXx231wIWzlwGTEIIL8CZ4gVntKVrWYfq9wp+NFGLTbXIG1vL+u15w16DZe8JNLb2bACyixvGMIdxoikml8c5MdQXw1JyvtnNEsQM1/GB6dGQ746ndm99zWBsccmCkc9A86KhVCIxFwRqRt3uihkgVjGled5Ki3QCqjU7Rrt5D3tjGXi3K1OCyqLguCrN/xDOpOMSfPxe3giL42VzEypPW8KrJ/nITkvFQdjq7KA7N4b2TrVB/ahjMn0CvF+8Li84NK6zbgB30r9699L5hs5tpFtDOT6MCwXFxvlam1KHsTtcVspYM0hPhc8Vbf1W/dIcSZalzjwqHW0ZFrdh4GSbPfP2m9WdwVRWu1ed4FwnFUG9Uc/EorOdipEUyrHzZOxl9LZPl3vulg6VjMr3KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(107886003)(2906002)(15650500001)(83380400001)(44832011)(8936002)(36756003)(66476007)(66946007)(66556008)(4326008)(8676002)(5660300002)(6916009)(52116002)(6506007)(508600001)(6486002)(316002)(2616005)(186003)(86362001)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRAJ0qNj+DlDV8jpDTOxoJ7PX0yGJxk8aAVtBOSenPJLwwUfU9d2Ab2ftmD6?=
 =?us-ascii?Q?1o+m1u7JAkJ4j323Hr4BzwrR5sc1rr85BhKw2W1H1/91GQeDoDIxLK3xu+Fa?=
 =?us-ascii?Q?/9n9qTZi2KgefmPd1KfzWtJEDJF4fbqL9LYsQKceYNFOL0RFZY2h2G/UsnKl?=
 =?us-ascii?Q?S2On+EKchxBDZ6H/aj2lqcNqnrfIa7D9Y8R+pVYWgPE0RzZ+WySCu7kZvEX/?=
 =?us-ascii?Q?B0QvwZMM/z09DGatKTIf/tQSrjlKz6YPcqeX9gHtn4iyeamBBAr6uGRRRUoD?=
 =?us-ascii?Q?n/5zMORHtUdnFHVcA8ezr/CaNkVAgUczSRroaqAgEhCJzw0Hx+a0G/hzdrl2?=
 =?us-ascii?Q?jkLxecjaaLreV94W0oNLbWUMObVm2mslnX1amDKGt4NaPy1GrMWJrYikY8p+?=
 =?us-ascii?Q?OCYxNnssHSPEm807Py8p6TZ8RI2bUjkeiNbLQa6DaWgujZw6/nAKFfVh0IRZ?=
 =?us-ascii?Q?5O1u+3zULQWDD5zdGAF3BWEjyzHQI1p9ji2s8i0IhXRRZTRZz+GC6necs3on?=
 =?us-ascii?Q?M0aepLGP/+GZqeW4O1Wto+d3ZhRk7Ef1+Vw2DzwWgMbg7P/T1E0bbUNKbJYV?=
 =?us-ascii?Q?tudKwyENzxo6oBeFdYxkj4IOSIxrl8EHKpXHcKB/AGqSYsTqPKYq5+3UzZ+v?=
 =?us-ascii?Q?2y9qH1Xa0JpGNBFh2n1ux/lzYEO5Xdw0MJkoTmpYKrlzy3fux1dOEHD2Rs9y?=
 =?us-ascii?Q?0xUgP+Gs8PIHfF7g1ix5G31LyabSvF/QYMyH7W16I9IPbizMD0xrc5wY2IsU?=
 =?us-ascii?Q?LFOjMCYMRBp9FgVHNOIyCjXomwxw/uGisEt6sSXdZYcx0Tky1SyJWAFpHZ1h?=
 =?us-ascii?Q?pw1QFpMiYD9nLd45SCD+K0lRc2zjEqod/AEGFleu+2w2i8C0w2YE146N5Edb?=
 =?us-ascii?Q?ntt2n9XlLkFdXpyq+hy1fx037CoUgLqw3X7apuvWHa+R/hc9JkOlbx3eirGX?=
 =?us-ascii?Q?w4QAwk5OkPNyac0RLep1b3ySJmufvVPzr8MTQbtqB/hTJikn16Avs5Z/QrXH?=
 =?us-ascii?Q?+riTMSTpISZ/Q5rjacPmF5qFtwiHYsTJKXwd9cWLIGO1pmc1b72uBNaNcSUf?=
 =?us-ascii?Q?af6FZbbayxwkStLSKi4mDtUnHK12KmAbqsDlq9QYfRzQrK9wdMgWPIyy7z8R?=
 =?us-ascii?Q?7bBKbhPrzeIsPxMyF+EFf5z/jJWCnGrW3YQeHUMrnTRBbwGHQb2/G+DuXU5e?=
 =?us-ascii?Q?OWMBmtyoSp5p733UNPFqzN6FTfTTtwRizSxK907HFg1UNuxuKZdlQFtmmUgu?=
 =?us-ascii?Q?fS7sIqXSxphTenpmnwkl0xAiZlV6DFO4L6fFPXnX2jzgQC/7XbuRGVzZ9xdF?=
 =?us-ascii?Q?ggu3zJoo5rqBzJ87Alr4/z15Ptm5r3xwibLQbeX3GOs7n/6NaMZb+3S9nWaq?=
 =?us-ascii?Q?Yt4lGb8WYE6fdQAKVdSeU+fsdsokApQMqi5HGtTBKRqGkKdUnJaPXh1+Pk76?=
 =?us-ascii?Q?SvkBR75MyCLLgFhpbcuzGirGWBhiz7DZ4IbZu/XSDUHONMtHEw9ZJIwgsio0?=
 =?us-ascii?Q?/LvG4V3nRjPtHKU/8iQ8PkUTrfBtIoso8AaWZgljxQxCm3xhtc35kWIIjrjj?=
 =?us-ascii?Q?X1EUfnGxfmIxbwN1GLyS5iCXJbSNsgqq7+ZgCHrT6SiAq/Tu5j7uEImTjMEl?=
 =?us-ascii?Q?iUqz63CX5g4mtF14tmqd9KGjXL1H+iB9C36oATJVuNM24qr4sFZY1oA6l4D3?=
 =?us-ascii?Q?GtAJlVh8HeYg6p2RcxQlt+WaLupyg3UZx6G1M3XZ0wGBBOx6N4tH3o8OxsTs?=
 =?us-ascii?Q?rCtfHEDtB+rR4fnFSAZhR/49ZA2iTOsr4EnyweEJRzWxYHvS8PR3IIWqp7fm?=
X-MS-Exchange-AntiSpam-MessageData-1: Wa1+zt0wA+7i7w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18433d51-3a8a-45e3-ee3a-08da2928ce8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 15:07:27.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62CvNo5P2+PRDcjAZEVKx7ahhMNM7sN4Ddw8xn0JEZOz3kiDXfNdeRxMBuYxzM9+/BFfEFMLqj7t9kBw/45nsxu15SXe4K3M0wNuEyKxzPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3641
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_02:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280091
X-Proofpoint-GUID: 3AGwScWrbuEPqvNuFM6qeCmGTr8xXyje
X-Proofpoint-ORIG-GUID: 3AGwScWrbuEPqvNuFM6qeCmGTr8xXyje
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

semtimedop() should be converted to use hrtimer like it has been done
for most of the system calls with timeouts. This system call already
takes a struct timespec as an argument and can therefore provide finer
granularity timed wait.

v1->v2:
  - Use timespec64_valid() to validate timeout
     and other changes as suggested by Thomas Gleixner

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 ipc/sem.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 0dbdb98..44b65b6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1995,7 +1995,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 	int max, locknum;
 	bool undos = false, alter = false, dupsop = false;
 	struct sem_queue queue;
-	unsigned long dup = 0, jiffies_left = 0;
+	unsigned long dup = 0;
+	ktime_t expires, *exp = NULL;
+	bool timed_out = false;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
@@ -2003,12 +2005,11 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 		return -E2BIG;
 
 	if (timeout) {
-		if (timeout->tv_sec < 0 || timeout->tv_nsec < 0 ||
-			timeout->tv_nsec >= 1000000000L) {
-			error = -EINVAL;
-			goto out;
-		}
-		jiffies_left = timespec64_to_jiffies(timeout);
+		if (!timespec64_valid(timeout))
+			return -EINVAL;
+		expires = ktime_add_safe(ktime_get(),
+				timespec64_to_ktime(*timeout));
+		exp = &expires;
 	}
 
 
@@ -2166,10 +2167,8 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 		sem_unlock(sma, locknum);
 		rcu_read_unlock();
 
-		if (timeout)
-			jiffies_left = schedule_timeout(jiffies_left);
-		else
-			schedule();
+		timed_out = !schedule_hrtimeout_range(exp,
+				current->timer_slack_ns, HRTIMER_MODE_ABS);
 
 		/*
 		 * fastpath: the semop has completed, either successfully or
@@ -2210,7 +2209,7 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 		/*
 		 * If an interrupt occurred we have to clean up the queue.
 		 */
-		if (timeout && jiffies_left == 0)
+		if (timed_out)
 			error = -EAGAIN;
 	} while (error == -EINTR && !signal_pending(current)); /* spurious */
 
-- 
2.7.4

