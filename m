Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52D95061D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbiDSBzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiDSBzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:55:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1471EC62
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:52:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23IM1bdp011984;
        Tue, 19 Apr 2022 01:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=BYgwo5DQfv9I7ZD5zUwoDNB/oGxQVKAiAQ3qP1HUxbk=;
 b=w7Ac/qWfmhXbHpJ11c4QoZdLUgWVeBGdrlv5gip9SSV2alH85bAt1KiwtyMn7VAvB+Yj
 hwLuhbkXoAJnBXnx1UWUz7X9CsCe1HIDac84xG4JJAHZpR/tzOmFZf542LZeEvZD5tKF
 LStqL2vvs1GCwXE51oXD/e8I/Pjfs2Vva3/C4lKm6sglmxQwudNw/V9xHlNae29dNPjK
 LMJdK7nigwBzc2gbITaBijSfx5Fen+H+waZGtBScyi8kGFPnn8YEHeyD02K5RNDvmlDJ
 7cj1jVf30oAl0nJqvZyKeRo2ZWlr+NJwBWf7/TBqM3aQrHA93wiW+TgTz+422Ocfdgkw 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbv4quq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 01:52:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23J1obwS016168;
        Tue, 19 Apr 2022 01:51:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm81y5xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 01:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgD5MlBQUxWw6jzJLVpYn9EEXPOTaTWOoL9pQQK3zwSDayhEGhKsLt1Wsxm+pwZivAYycPnsmNg8Z1uIZkElHWpdc/bTa0ONxV3KZvCtVKNxk5wM3DVzPMUs4KZUWb5MFXv/Lei0EZhuQUvXUnlYeP2NRLLiTpi4VlGCPZ3IojjnPFFyULyKO+M5V0qzq3Y/YjbiQgcFnnwyzOzzegIhF4Tq+SK6vV8qrt6FOOChG7Wz4JvSz9GpUbS9HyAxSWSDi1Ke1sxWokCkcmLqTMnFOYAybpFt45sO0k+QtQGJKFtBK6SNDSC0CN66lE6rUo0P3hZbdcggUFsWBZS64imaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYgwo5DQfv9I7ZD5zUwoDNB/oGxQVKAiAQ3qP1HUxbk=;
 b=DvX/9EGAeFoHVv88aRLJbBdHWcoCXc9PKgYUofa6hvZO1t69w4dmvOIr9GWClGLvEQved3MtmwhFKM7ix7hNCU/PSXTkpltlh8Qcj4uQuPWPWEGBmEBE0c3d06im7jlMlXBqMP4Fe+RT5NanE6eLDo8bEerhgzVU+oAELNenhItLPE0cukt2B3Nlu/hB4VXHQXjfkFPxjuSHLiEUb2haIrrSB8L39/UBgQbOPPIbhXMnk4UzcTNceC9YLyEa35zc0Rbm97KR6aLV4Zym80H8qASTPCVfhuRAXMlSXLql9bo81/GfK96TWryhhEFOMJdtQxWIPjSbJPlGjreJjC9qUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYgwo5DQfv9I7ZD5zUwoDNB/oGxQVKAiAQ3qP1HUxbk=;
 b=aZV7IF7Bpqx6Al2zP3OuIWT0PHgUTCx27v0Qsqa/t2QFipvogDboXDXmBvLb1ToZmgzVjbgDQ81mN/Eb6UW6TPbGY3+WgENfYS6zUKa69bybGhQiX1X5JjppgMt8RZE6taQZZSamMkI8hDcIq9mz5vZJyy0cJ7RAFlMJjbegymE=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by DS7PR10MB5391.namprd10.prod.outlook.com (2603:10b6:5:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 01:51:58 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 01:51:58 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, prakash.sangappa@oracle.com
Subject: [PATCH] ipc: Update semtimedop() to use hrtimer
Date:   Mon, 18 Apr 2022 18:51:39 -0700
Message-Id: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0276de6-4534-46e8-e6d6-08da21a73047
X-MS-TrafficTypeDiagnostic: DS7PR10MB5391:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5391F01A706B8FD65B3C7DB4E4F29@DS7PR10MB5391.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUVSsjkDJfsS+md9R8oiRc6alNreEtwB5qZAKKSyKmyIMpOBRU2QWTpWZgiD+9fEEje1maVsT0G0eXtBkIfCZoo5Nn1Ti2V2TKMFdsWr6HD3x9Uk58iRVHfqe6GEW0dpXT/jF3xXFwPau9DizdGLUBn28nfvgWDNwcWDIyCAckqyQ0oiJa6sluE/bRHfPb0pkCYaVH55EfjUv8m/BswuGAJrAUJWKar2sx+zJ/HR6lIpGPynPePE1bOoTaK8OGcQbWnRsISBGADJ8wxeijRXxTtOOnF8P9fq6pEzzzTF8rqiydgxl7hHqyHXB1vPSYThzVOD+SBB0vH8W3jETWyt7iqDm8htBTXowH9dUnK7L79j9x2v+BGsqDGONBnnsymwkypCc4ZyfLYzET+Iks/FihWePBVxaRPxBF/hCbiBeDofsEBbxCTd62aY9a+4LaXxhNBa/Fbl9tHiqk01VeDqOwRqNjndV9C7yzaUnUfpHO9im3yj0Xjsulwcx6NQKrSRGEkQkeXf+qB+YFNl06b9jSvMrVa83GMalYhJQU+Qc2pUPhzIJpP1r9ptH9G/hZD50F93WN6SjYKAF3OheHTUcl1++KW+moVx2dcHClJgR9d7pBsmDZmazuEfMPt2U/rrqxlJzasFlDgM7wGU81c0JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(83380400001)(2906002)(6506007)(6512007)(6666004)(86362001)(186003)(36756003)(52116002)(6486002)(66476007)(316002)(66556008)(66946007)(107886003)(38100700002)(2616005)(8676002)(4326008)(6916009)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V4eCiXoNGxndRtLWMvZm8VZz/CEydFyppjD9RiFWczqIz3NOsl4K3Y7rhSBm?=
 =?us-ascii?Q?U6OIL0XaW3dSTcX4cQ54QN4S1+gcFIvb1J6iPLEswGtiZOp0lcNG74X7oqvY?=
 =?us-ascii?Q?fnPiAtcQiBqtJz8cd4fjE7u5g5bIvRpf/6IGjHkOfKvFosiGReaoFux7jmX4?=
 =?us-ascii?Q?dizZs685SjwnPR9noygH31Xf048sCmZl333+FhQuZw6DG3CLsaDUYOMbX6bI?=
 =?us-ascii?Q?5/L0ZEd7nKwsSruqxnuWdZ5LZhdSRVS+jCBu57po+ZjhJDq4MyOX7M1PDUtt?=
 =?us-ascii?Q?MXmjrM/BE2rrccbNLV2T6cXp1p+m8SHXTLs5N9mMYgDOmyETCjIYsmsialir?=
 =?us-ascii?Q?TkJgmLID1wRdsg31DwxeBFg7uTN9qT6KbBG9BjO3gWZebRbYiBdwdU1Bn95+?=
 =?us-ascii?Q?kM6ZFQv6BqfhJC2xdjZm5UI0O6rE5L1Le85IoMjgeF4xz7hY+S5iIZ5qk4RL?=
 =?us-ascii?Q?CwGhGpiH1W6XEPV7pjTOsL9h+bZaYqlwVsS4Z7OLwaOc2L4nem01tFQfFVT5?=
 =?us-ascii?Q?zqD4yUelVTnD33tzeGLkEp8HqXnyxaB1Dr41x85YJLllaV7cHxSoQTQ0oA1s?=
 =?us-ascii?Q?XKQfJ4BWE40lPTdygkAjNvUy3HZ6vJShDW4s/E+c0uv/a8/C/4iMJVnvGWEd?=
 =?us-ascii?Q?bWQp5cSHfUMkNW+xWEGwbMDJxb7xC0iBxg0wi520OXNK2mqVx2s9pHkR/UZ8?=
 =?us-ascii?Q?YTck/HzGFo+4kafLd+0EIzetcUkYYTPM5ZtZ2B/yyBCx9EVI4sp0OGIzbu6u?=
 =?us-ascii?Q?PCEye9HTh26V7TjVzcBaXDw1aLaIBDeCJbj18lvsKpPCQCYpK60ZVVobVmHk?=
 =?us-ascii?Q?Lb+MqTrgMQ676Csm6BvygFZh6ibgfkMVG8rVsGAM3CqIb+//cfDVWxjgjd4/?=
 =?us-ascii?Q?OajUIArtqCyCqpDhla4BBys4vhBvmsnSfIUqCpxAr+3OEcUgZtRNhWt/sCTV?=
 =?us-ascii?Q?1mb68cJBI2qPvrk4sVkLn2ca1AmBfXDZnnJlcZUjkaECmcT4Lh0PH47llp77?=
 =?us-ascii?Q?SBNZXQKZQ0cQD6R20gZ0NvYejwn8lEoJzN6xDYVsMFZ+hVYXJMLqXhRST2l9?=
 =?us-ascii?Q?53w552133tEI6JunCgnl+FiVeObYnEP0F+PK+ty/GnfOFKZ8s/aEs0FhawMx?=
 =?us-ascii?Q?U8VTLToXET6TbPZXG3UzT4lwCnDNEhXgfTJnNwo+yOy1zYHa+y1yfcBbtiJL?=
 =?us-ascii?Q?5slmkHi2gPGce63LZEgHzraQxDnbMlzBpYXu6Lu3f0cJGp0ZaxbaP9ldYTCN?=
 =?us-ascii?Q?/rSIJyMO3urMcKgLqWbi+kjQCX8KoZPiYG+g3eKU5Mu/7o1vXfgJHyQSb2tQ?=
 =?us-ascii?Q?k+MeyQ3cCnlRlCmlsk8PwzPNUPw22YsUP9r0Bk8au3QUs9iK3w/CJACAa4Qh?=
 =?us-ascii?Q?EVFYXsLjCEGhQb55cfvRRxg2M6Bz4N41kohDdm7hvFLyMlVrH/OaM1YyhNQu?=
 =?us-ascii?Q?hzonoC45Wb7ghEhQ5TrJh2t0KwN7RoDYPWlKf25JHXbGLQjHjvgwLLG1WdwR?=
 =?us-ascii?Q?WbURut9WIPwVGgboRhYTS2pthY3mcZTXG5ANrdMX4OGDG838CQFse6Jb8AYv?=
 =?us-ascii?Q?rin+7Viqdamzp+cMH9OzHuag0TDJPq0fVhedUVAu4xW/YO5bSsjBo/Wo1Mto?=
 =?us-ascii?Q?YCI0pWv6MaC2BgkaJjz20zUd3lTGZ57uI6yCK4dUYE5Zpqd87VpueFzjs0L4?=
 =?us-ascii?Q?jGKVLTdwubKOPFL/uvZR2aVh52I7OpWMCTLyv2BKY86QRtWUp+kXMF097Sq+?=
 =?us-ascii?Q?YetwT5pRZQIwNkRwC7+FC7dDSei2VIeMcDb1b/qKKlfK5g5S1l4Fc2d6jFDo?=
X-MS-Exchange-AntiSpam-MessageData-1: H3htNrWViGTSjw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0276de6-4534-46e8-e6d6-08da21a73047
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 01:51:58.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gatkr/ld705ajPtnIMeLNPTwr7RuUpkexAyNejhZA09XV0EQMo/7dmEuwh7rF+aX2xql7UVspOW+1GcMME1wI8kWKmMCzMf8JhikxZ9PMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5391
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-18_10:2022-04-15,2022-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190008
X-Proofpoint-GUID: y0PdSaLa5B9dLoGWjxHpAv1uFy9cFngS
X-Proofpoint-ORIG-GUID: y0PdSaLa5B9dLoGWjxHpAv1uFy9cFngS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

semtimedop() should be converted to use hrtimer like it has been
done for most of the system calls with timeouts. This system call
already takes a struct timespec as an argument and can therefore
provide finer granularity timed wait.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 ipc/sem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 0dbdb98..6cd1a1b8 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1995,7 +1995,10 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 	int max, locknum;
 	bool undos = false, alter = false, dupsop = false;
 	struct sem_queue queue;
-	unsigned long dup = 0, jiffies_left = 0;
+	unsigned long dup = 0;
+	ktime_t expires;
+	int timed_out = 0;
+	struct timespec64 end_time;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
@@ -2008,7 +2011,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 			error = -EINVAL;
 			goto out;
 		}
-		jiffies_left = timespec64_to_jiffies(timeout);
+		ktime_get_ts64(&end_time);
+		end_time = timespec64_add_safe(end_time, *timeout);
+		expires = timespec64_to_ktime(end_time);
 	}
 
 
@@ -2167,7 +2172,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 		rcu_read_unlock();
 
 		if (timeout)
-			jiffies_left = schedule_timeout(jiffies_left);
+			timed_out = !schedule_hrtimeout_range(&expires,
+						current->timer_slack_ns,
+						HRTIMER_MODE_ABS);
 		else
 			schedule();
 
@@ -2210,7 +2217,7 @@ long __do_semtimedop(int semid, struct sembuf *sops,
 		/*
 		 * If an interrupt occurred we have to clean up the queue.
 		 */
-		if (timeout && jiffies_left == 0)
+		if (timeout && timed_out)
 			error = -EAGAIN;
 	} while (error == -EINTR && !signal_pending(current)); /* spurious */
 
-- 
2.7.4

