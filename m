Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF5513EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353249AbiD1XVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiD1XVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:21:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A44D44A13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:18:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SMPsSf025802;
        Thu, 28 Apr 2022 23:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=wM27rxhcyQ6QuJB/QdrWMVVmJ+6GjAEX+fg1q8rbcHE=;
 b=wZdDvlRgXgrjWCnCmwodFpl8zVB5zVSiqk+FAlKurWm0QTvgtdxZJ4pLQqdhdfWtkRzP
 Z9NG0+FR8hJ8LduP8cEub5/IR/Q+IF/j6PB4rUq0veH1FWwESLBX6A7loEXKx6yEfd6f
 0MjcP0Z0/tALTDa5tk+WiZdgKrKa79eBbL4eUxlD89jcADgx38HhIWGiK1qR+s3dGw+A
 koB1qNqlnYJWghalsMhtaA8LQvpBb+FMYhn3aoy+2mUSsaIiDS+tbeibTKtnxygh3iYI
 aWCkwzEW8PtmRQ/lBHnhuKk9Rh8wm3V5ZQhc6PA+DqvtoXgtsDMltt/GxjZjZK9Yjodh 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mwhac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 23:18:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SNAdQu031031;
        Thu, 28 Apr 2022 23:18:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yphxru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 23:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDmLIBuG2raneGR6pfSdXmYQH4QYlOpMkQRYGvJf0GRDDwyXTRAUhHrWJWlji0YakRvcaM9qSzk1TcNsfiaDhBEKL+FUd83Ws1zWMOHI92bN/dS8HJBPpSYdz7xwY0xlJKMg8tfqeLqYFMfR1/TkUERGX2nNblaQrykayZVda2+eX2+7QV88gzZY0Skj4vxJCBqH22sJl8MOl8LUaAEBbyikrPNeVyBr3PmjMfH/u7imYzI991hrZfQV3WT4xNrMWRGWTctrVttS0VQK+2Ghzt2bV4ZyFVFP3Dbalu4MfCP9LvMV4jxdNxXgouYwzKiJcn/ljKVlh7b/xg2zwVkXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM27rxhcyQ6QuJB/QdrWMVVmJ+6GjAEX+fg1q8rbcHE=;
 b=UrYiM5cs7Rjh3SB8dk8w6zk1x0swAvyiuoUu4GxuaYKRvIgk8pCT5U2AJKy+1gY21vyFfaHDj7Zhdfs+rvJJzwpXtRTasae/J2R9b4F258FWDtuu8g+C7Ebhs7Ro9HF5BQRAg4ST/2MWz4cMHOpQucv8TInfzNy8jtKf36SQ32ydGiJlUtmM26TipNZXPs/Ix7qqNNg3fk2wILuNduiwxjzYZiOoeP5umTffh7clpKAf30zMBMPqCUXNGsPVjyqi+3HvP1QU37cIcUAZWqlrtNv4T+CN3kVP67nE1Y0ELDH3yqsxLx9jgxExIDP+nbgVmIBi67zH3hOv2hot4/Lr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM27rxhcyQ6QuJB/QdrWMVVmJ+6GjAEX+fg1q8rbcHE=;
 b=iTY21WyFBMCqy6UWQRx3nj2QELqqKIK6UTcik2YSeD8niUp4hMGYXdQhz8F5ywJytYCujLBn1fQkZ0ELOEjEsO3Vs31uT8SBXbxu7kgYiftjoFwKhNyCX/w8gO68vtGhCrZdUXz7nju34ND2xVnCvamcXvLlLjEYo/HVpVOdmko=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BN6PR10MB1442.namprd10.prod.outlook.com (2603:10b6:404:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Thu, 28 Apr
 2022 23:18:13 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 23:18:12 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        peterz@infradead.org, dave@stgolabs.net, manfred@colorfullife.com,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: [PATCH v4] ipc: Update semtimedop() to use hrtimer
Date:   Thu, 28 Apr 2022 16:18:01 -0700
Message-Id: <1651187881-2858-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0152.namprd02.prod.outlook.com
 (2603:10b6:5:332::19) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab5a49b-4beb-4dd2-86b8-08da296d5dac
X-MS-TrafficTypeDiagnostic: BN6PR10MB1442:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1442FD5D0DBC2EEA5970C337E4FD9@BN6PR10MB1442.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHYdatRCPdWU6lAApjoKauwZeQ0wXrdRnT9X5RS1TC+sip6lbQquT1vU4xO/dMiNhTmcZp8+rXyVOiK9z81HyQgbGGYt2I7+xi3rk1MPj9zND0vTgitJf1mJ70jHdJ3V4RfKcjEVEXtJpjtK3wKw7jSxHtu1P2w7708EvBjuo7zqBO9Rx4uq+h/99zkv53r1ErzF4IC2hJIGBS/K/7APie3Gm+WINJjlbW5Uf5O8g/5YP1ypaVGHfLD5OUvM4q67dPH5ESxNO0mEezj7Fv8JPiENhnNuL7Lgz3NPmQ7GyCJ6hpZjH/NlZ8jdybL2uusuM3S50FyMI71VEB2bBKztBfcUg9AtUSlXZgdjjz+YRUovbwQqWnVoS/xf4DFUoK7yTQ39aVqP6Sg7ItfJmAKXMbpZFLvNmgubPTcqNZPNY1QEGUeeSwS/rmUKPzh/U5NTjq0WH9olMXM7NctlyUwg1TbtsNs0pCuKYNjSqE21JJVglEslZzyKQY5xI+0/7gsKQiKz3B5ozPdLXdO3VDDuaV/DWQrLfKKHNVHgnWWvE3HVhZNQVcgX5tyWc7BleqcbowMuASgh67BmRNua7XD2GP0yg2O5GMS8Qf3A1zQhSO7kVb9llzASH61Z8oZSkRm3SO6vopGB/I4Y2oPJ9S6DEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(36756003)(6506007)(52116002)(8676002)(66476007)(83380400001)(2906002)(66946007)(66556008)(5660300002)(186003)(15650500001)(2616005)(86362001)(44832011)(316002)(6512007)(8936002)(38100700002)(6486002)(6916009)(107886003)(4326008)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zn1UGCWMDlIt7WLPJFKJa6g6XBulfbMWcdf7/vo2AXfk1MSt7X3cE0ZqqZaR?=
 =?us-ascii?Q?5il1SxiB0Va+3e6PK1o80rgfkYXxi5FBXYS7B1vWmytups4Ibgbywmm/aejL?=
 =?us-ascii?Q?2BJNNJwUZB69CDuwvMgiEkH2Op+xTxWkdU6cw9LxbHcXy6/JOc54645PNqLr?=
 =?us-ascii?Q?o/mXbOv1OdZqxJgsjh0WDst2zSQ/XnjyDKwUjaS3lyYl3Ybksfv6lkedN7Us?=
 =?us-ascii?Q?kjLP6sJ+8SqcNwC+BFKR3DcQKT5bIzt3S1STDHgO451kggrjIdUWIvGREYPn?=
 =?us-ascii?Q?hp/L/S5PoXulxlCiqLw9c/L5q8FvHXtVWKFxYjZPVO7uP3IehROhmYst6AQf?=
 =?us-ascii?Q?XV7755dFw3ypyetno7pBSJB7EnZ5XqUlSmM9C5eU5GdZTmfSC5bHg+FZ0SGs?=
 =?us-ascii?Q?4Q1wz8k5mRq3Gbmnm4uop5MVZHELj42z6dyPxfaa+11fFdK9d3QvmFacQVNG?=
 =?us-ascii?Q?erDVcVXI9PpeMsbvWgiY/sG12DQNE1NwiB+oADfzGR6l9pHbIho1yjpvIew/?=
 =?us-ascii?Q?7AzPV1Z5ThbzK6PsOuuOTVPfbyTarc2biwZpFxd6WbeIorDpC5I25g+JOMJ2?=
 =?us-ascii?Q?M74CWqoa4OPzD3vDWg/eKCz3C30UQjJ3j/7Dcrycoew9tS+l50zaY24n0cOC?=
 =?us-ascii?Q?dN3Z1B4/yULtzxDuIk7VHk70bQk+Q1oDptiGcxSXAClGoqcO8MCAMBfHTEkK?=
 =?us-ascii?Q?E1KRch0oE8rPKA7oClzlwRVrCyjRAf4nVqxagyP7Na7HrM/VLFTbx12brgwN?=
 =?us-ascii?Q?EvJUMNnX/YRCjl2Ko3byh2UFUrOkGvheBUC4qnMM6XiAEr9rxDqHfB5CaMdy?=
 =?us-ascii?Q?/Y/FtGLpM2XkjpW7mXnb4qdOPVjj5JvqpiwWEpSc7G5jFJqDd+0KFCn/d6JO?=
 =?us-ascii?Q?oCJ+GNDruXLnrEFeG+Jf3UCO582A1PviIs5Jj/C1xDVTTmO8JRLSlSzm0O5C?=
 =?us-ascii?Q?YICZh7ZaZsfcj8v1nR0wl4WweC/gJ6fEdk57Zr9omYDlsDXrHH4TjhibggyD?=
 =?us-ascii?Q?qZVvheR1JWmVELw4VOBfbpMHjCjP9v3WYe7PqvxgvAUh5wHVjfAVxY8bxez4?=
 =?us-ascii?Q?wdLhe9RIbQRk9WLzTEd4slaaEHUebWyUepHHEjnwVof3bIGA/aKi2BHXJnTo?=
 =?us-ascii?Q?DCSOczr0SSI/zrfw0bHs7nuM8uPiyDmZvX/k1yyooGoy9k4nkotQvwxoXgqH?=
 =?us-ascii?Q?sF3F5L3L6IuU/DzlzZjwopbuKN7tNm/D6EyjjKFRhMM80iBnGS+ZAOGq/4f1?=
 =?us-ascii?Q?IZNpbsPLkRDpi/rkuL8F7n7pG+dMPAYKZq3/00Ig8sT4u4sWe/30skYzsqtm?=
 =?us-ascii?Q?cm80mZ23haHOTpA2aVj90mttbppGparMIdGjbH+a0DGFjvIzhKrLKSFrHZVI?=
 =?us-ascii?Q?gHlY9zGWqW2dmMoZNE1EIr/70KbBdkxUjAT45amDq/w6WfpmJD4dK9Yj+cbF?=
 =?us-ascii?Q?G2X3VauQC6ngo+sAjeNAduRPUGk66KLWbEbzqEsHXukQahIJ7HM5NpXgrleX?=
 =?us-ascii?Q?p/tIfGsVUzYMfMtFU0s2g7yJ5mx/jDQgvCUx1dWLovsrq834unr3BuDf8vcP?=
 =?us-ascii?Q?/2Jt7+HptwhAZQXhJ3eTNO+BfpWU0RVrgvCwxaOFtZwG5aeNRN7i2Tei0v8K?=
 =?us-ascii?Q?dF7+mp9H3JCcICHcWBKva8ZBe7zMXxSQEBR5qhpl5mUjqLbLH6rGKfEGl2gO?=
 =?us-ascii?Q?UTUeMmhiCHEZd984rnxruZVIHXfZmYHYg5DQWw2Fdm4lh7/rXBS7gVSRrO51?=
 =?us-ascii?Q?/90fxoUpz+ZOddLIoLpc8rkJDZA+zExudpl5a4wAJrGG9r+g6MOs3iTX3FKU?=
X-MS-Exchange-AntiSpam-MessageData-1: HdWO9AAfg2STMg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab5a49b-4beb-4dd2-86b8-08da296d5dac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 23:18:12.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9s671sbh3FyRoHhsL2rYDJmHpJQFnuq1XIBP0BNbH+ef7MiKzcgCjojo8ZS8qAal/+eQMvgg+/a9vOe6ZffvCSg/4cCGYCCIqP/1gV9nE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1442
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_05:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280133
X-Proofpoint-GUID: 6wZ539Vyl5-00tqyco6RwRwjgPAXpYZ5
X-Proofpoint-ORIG-GUID: 6wZ539Vyl5-00tqyco6RwRwjgPAXpYZ5
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

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
v1->v2:
  - Use timespec64_valid() to validate timeout
     and other changes as suggested by Thomas Gleixner
v2->v3: Added Reviewed by tag (Thomas)
v3->v4: Added Reviewed by (Davidlohr)

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

