Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6299513CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351893AbiD1Uty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1Utx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:49:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F916929A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:46:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SIMtON003699;
        Thu, 28 Apr 2022 20:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=o3UEBtV3WZuLv+t70AOQpeb+0SD6FBlY/7zW0HDbelk=;
 b=B3Ip3QxCpvrm2ZHAA9GVWTOpt4AId0c4vupIjfVYvowNVwdKGvq9rVFfeLgVmdzBbyEe
 xHcmJshZZ3MXmQFrHLyo/EQ6N0/Xq41oEENK+SPlkrI87a8pEpV9C/agUJ4wPxkUXDOI
 wMm92z+ilQ3zqj+F/+jndE5hbEY/Ksdp/+U7xRHxryUE8wZTC2fkfu+F5vk7BP3uXkoN
 Yt6gExX/SrdWkJPl+KeTKje9BiswoBpqdRl78+MpgsY7WdRdP4dCFhL9P46IVHm6AhJ0
 LA3C9Jby9T2ntBYQF6FwIRm+k0gh6F9mmucGrndvT7ob2opHkrYn1QROiQuWaL6uaOhK Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4vr46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 20:46:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SKVCcO018823;
        Thu, 28 Apr 2022 20:46:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w792b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 20:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUMOsKvXM/+guNWr71JvIgrqIpFF28gGtpy1Ia58byJj4qczvpE4jvwm6zma3zW8aESINFcjwRc53X/TEeWT9nUQkIo6o7mTPjRyX2s1Hcgqp3gH1V9s7EQ1+7CeQEIG/WJ3302Y7i385HzktM4N84+47LguuH60cbPVD7btbEE4iX8bx6i2Shu/N40qqWjtovvbd6cIn0WEubWzo6vyLHx97PBtY9hKIxYCUhiFKYdSsYYsZJwnhzMKQeNXrlUhM2h8JHwkl/o/tZ0kq5sPN/lbutAPJJzcdhrJajQc5JtLGv8Wey0piXktHa56D0/9Fip4Qkzw8aOEo8f4XR96tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3UEBtV3WZuLv+t70AOQpeb+0SD6FBlY/7zW0HDbelk=;
 b=H8wFL7m0Mti098G1+XeMA6bAmpwqYxjpIP1Rvm/rFXC+9Y2NE38O/eJYWRLJWEGG6/3uJ40vmbQXS3I4O2A/mlCnaebhmIY4xQ8dNnao5HGkhXCK3lLYitUpsXaJcMbTa6jyHbd+3XSGPDohxflyf2NM8zhtuFYNhS4ZQroJQExDlkjc0RKWgVbcOvaVYDnwyNKfSEOrqYA8ex5rvNqihZ0hnAa9gTzA1AL08bSDJ83S+DHilVTMAK4Yi6JZXRbIKTvFBowTs5hS4DvIbSV0+Y7BiWASMnTjjhUN2rLYokhJ8YqbhaKinrfnniRLXyFrfiHEdVJewWG8lx24n+5PQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3UEBtV3WZuLv+t70AOQpeb+0SD6FBlY/7zW0HDbelk=;
 b=rQvX1bsSsyUlWARaqPEI8nDmzFJSW1uM5bUWP0QZmYybTzN1RAgbkntwBo6qIiEUeRy+on6HqdrRSpzKo0oTujuAZ50lyFpfpZvvGX/PQ5ADDU0n5wPinpyYizzu+kPU61AO8uwo/MzZCkuwJU+QQOfN/lRrqexERZS1pNCEi0I=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 20:46:17 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 20:46:17 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        peterz@infradead.org, dave@stgolabs.net, manfred@colorfullife.com,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: [PATCH v3] ipc: Update semtimedop() to use hrtimer
Date:   Thu, 28 Apr 2022 13:46:07 -0700
Message-Id: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4f0bab-eab6-4a10-6a12-08da295824b2
X-MS-TrafficTypeDiagnostic: SA2PR10MB4458:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4458DED30AE95F1CF185F152E4FD9@SA2PR10MB4458.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NXB95n62pBGsKigUIdEwKwca9YFNStsC9n1/xOivcLr77R3tzQRs7jC98zVq1ZI8BXpxJpAjauf1C0NduBBtKqNKstugtjs+X3l/VVc2TowgMWqHRMNH/Mo98JYwSmnYjAiSUDm4vHwaRMwg2Hk/CLZdRlHFadOfMlufO+Wp7qdZiR1K1o/IMSD2BajS5m4KnHzPSdifV3gMikzKo0N6M2Q0601bLR0v3Sa9ndRKcMVTUPkO8P38gpJQr5R3PD65VxyX1EM+fslAg15o3Kr+LnHl7GDqBROmafEXcmRtQu1wmseBP4msybLkRVVmP4lD8n72migYWg7iQO95pmDKxX2CTOn4aMivJZ5Sc7PwfOhTPu+8WgFBI1Qqi3FQ6o7MduPphEgDlDWh92m85IgMqSzDyzdfKbLi5XyTVE6+PeTf89sxZL0zTbh3SlRA72PtM0pwyVyA1MNrR/DURK9AblltxVoDMPAD9fdboFL+Y4TwIm+2tI3Gi7fIKvXsOLZDNmv7b4r4saiGQXLVMFnG9Tf3Sz3afSNOjfHzz1J3DidXIXADbH5V/l+FetbHE/42DlVqs9aRM2KjCDvPnweyiikMCUCfj1kmt4Rjgwei3AReFVcGJT2nPLEwTJmvZWyF5uWG/V6hPWsrQ05NX36fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(186003)(6916009)(107886003)(2616005)(6506007)(508600001)(36756003)(6486002)(86362001)(66946007)(8676002)(44832011)(15650500001)(66476007)(8936002)(66556008)(5660300002)(316002)(6666004)(83380400001)(2906002)(38100700002)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILk3dmgVOgUNZ6Yq3dpNj8ZJbhSLVGH9U2W39ubr1xq3Y8qbHifbQzfGWW/k?=
 =?us-ascii?Q?4bhbJEUIvEmzU5dYdnTUCXypXhGfTuH19gq4ISr+Jmcs70S+t7Q9b5c6Opwc?=
 =?us-ascii?Q?+OO+YCMztawfsz7OtYW/gtvZmRgcG7B9SscYOOOhNwZbvmPNm2Er8isOf0Pg?=
 =?us-ascii?Q?fbwr1mjwHMaQJmg4d41nug6rzWF+PI7LSh2XeMbDNrGTxgChrVqh/SvFQ7qr?=
 =?us-ascii?Q?U4fSoazAPVVEAQUfY2ZmP+XUVn3KdYHt1Unczj+GuNjznuZ9+cvxeybXH9ym?=
 =?us-ascii?Q?X7VBUDdYKdkWiC8sJE4AeTRsQoYxtHTRAJLjRthJOW1G5hsUd8guRkm3yatF?=
 =?us-ascii?Q?z1n3ZVOgu5MUQx874fxsrKj3zDm/oOaOc3oJHKh5IQNAnRSltiSC3TWON2+6?=
 =?us-ascii?Q?Xcgmi4dsFrD/VGmexsExYlaWAIWz+wzN3IHLnEAGwLNWdQK4MPKlNivx1Cjd?=
 =?us-ascii?Q?JfsqYlrPcCrbHq1gd1MH25Fz0coOH7d2u2LKGD61jtMYeVb43sQ3AQ8+w1+B?=
 =?us-ascii?Q?PlEOpDA45EnwuyhROdBuSzoFROqWQ5uwhCkGtM/FraiSUlWO7cPqBYKslNvw?=
 =?us-ascii?Q?a3VIYye+pZjCK/f41hYaq4bFzMt2E+nh6DRDeDbBdDxRBUIcQHbNdSRmIaT5?=
 =?us-ascii?Q?ZReBC60zOEWMouqf70ikcooN+NCd1LNZBNXXnt7DMdi2CPzlrY8f79DOzZq9?=
 =?us-ascii?Q?fmn0PbAZFFUtAdHNxoS0UJ6uUxvAl+D7w1L4qo9TPUg7+SvP3BXcGkbcZzUl?=
 =?us-ascii?Q?4NI/77qeG2xOWiaEaHMIpjsUoKsQeZe6JlT+MhwB1+k3L89dpYAIuGufaKmY?=
 =?us-ascii?Q?7gtHPLZCoeQxefo1uUGlAYLl1+7UsfM5awBaBm87PvNViXWkPGgZgEpq/7mh?=
 =?us-ascii?Q?yB7/zyvnHo4kvh0tyBmh2lyTd3/pEOLmucLlVgu56kwPUdn7l3UI/zK5ipt4?=
 =?us-ascii?Q?nXm74sn2qKOCUd90IaQ/t4vdgkHA38uB6yRvkXI3kwS6vOZjWvNOKLjOUlUX?=
 =?us-ascii?Q?ukVDK99qWpDRmj8Mpd5zmypu5IzIFxrAFbGL+f7HOoWDE6E94iX9Q4QYu1Vm?=
 =?us-ascii?Q?sDt1d7RsU1/hg6JeLMaobSCrgHaaj5XeehgZnl+i2OG8DHTJs3lWhOpOVlrq?=
 =?us-ascii?Q?9TU/yS6yKI69qWwFDIYIQ3lGXe0m58MNFRCm1LlLa7j1dRThc0z1hgzBCF1Q?=
 =?us-ascii?Q?zlsnk6jMGa6PRD83zgr5bhbR6uxxtyWE7LAXClAOvleLMMr/tgcJLQXJA6fj?=
 =?us-ascii?Q?EWTyCKz03gxyArnfYEpb16u0zIrycvj5+s/LArc6QwklL2fFf0xVUCqnwrkr?=
 =?us-ascii?Q?oPstz0xw0i97baUEyfqYaxaR52XS5ZtpYbfqX+CeNHidlxquMtmgdHNQk4Qv?=
 =?us-ascii?Q?/33kxPOAnEZwQEz05DGufDaYSaWzQjGXennfETeJ9TQIOljB7J92bk94/BwK?=
 =?us-ascii?Q?Yab9kNc/eQCRB5v3AfSL6ExVm/GTo7T6nLlxZLdPWignXmkXDHOKKUS/OF/R?=
 =?us-ascii?Q?S99lTQIehkX7IjE9YZQjABlCMEYCs2FNO3XwgpGxeY07ujmH/R4IHSURIEde?=
 =?us-ascii?Q?ytBAf56joyucA1flp2ZOqwuLj5xyNkHdE2yXTg5+48ulOGjwwhoKDZEAKCLy?=
 =?us-ascii?Q?1MswXL4V+Dd/NndkVubpCkKPHiIaznukIXe9vtdGtPDUK2nXYdRCnx/SysoT?=
 =?us-ascii?Q?xjgAz78NQKFOewHWWe021eD13hj8Py01IXk9Zc0r3TpRtom77ShrS37ANilH?=
 =?us-ascii?Q?to8dVVIWeG6xQGAE6bNYCc/66w53oxQK01FqsmAIEEyAX1zjjxBeMfvVgeoQ?=
X-MS-Exchange-AntiSpam-MessageData-1: lWkrdjtpMNrqpQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4f0bab-eab6-4a10-6a12-08da295824b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 20:46:17.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iq8Z7Z90uGe66q+LsyLj17U7omw3W1iXkpFJkQnb+esCJKvvBcW2abs3yJ9Z+I3ki1xam0Ikc/GaJTGY391QC6zvxJixBUuBZQpR/Risic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_04:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280123
X-Proofpoint-ORIG-GUID: H7OCTEGMICGxxTAFjxvgpSpk2yIKZ88G
X-Proofpoint-GUID: H7OCTEGMICGxxTAFjxvgpSpk2yIKZ88G
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
---
v1->v2:
  - Use timespec64_valid() to validate timeout
     and other changes as suggested by Thomas Gleixner
v2-v3 Added Reviewed by tag
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

