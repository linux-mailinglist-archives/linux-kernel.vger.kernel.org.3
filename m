Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CF525743
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358897AbiELVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358804AbiELVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB82DA84
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIa0Vb013766;
        Thu, 12 May 2022 21:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cgQYMnVyBrP6eyHdzTgLOco+ndaIzq1ErtcqwtQ9L7E=;
 b=Jj6/od2Y9d0WLTsbQccJ1F0lwJyAXomZ/5DInG6gLwbTwEQ3lofmbDnhidrE62KxknRL
 IhPD1pzeJv8h68CWZ/PAxeUHOf5XJJg2G1pwPK0NZfIwgItI/4LWnlLC4mPZDRR0lged
 9ixCRwpeNUHxaUH2mS8+GpVXcmWkl+S79nxwg7sAhYYocLOYyLBR53/A7E62ZntHkPpv
 ZApwEXwxvbzMZFOjv2yEQ8PJsC0/K5fCK/WxAUT4MiFf3q99gqNz7soazzLMMH/nCb4K
 A09H13H554D56D5dLr+HE/HKkwzR07oNBUa5AaS4wPp0+IDD967QkvkY1r4+EGBJGC+J 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9wg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLgIkO004728;
        Thu, 12 May 2022 21:47:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c98s9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY4/UdLPHAbztDnbDaMryP/WamyrJeKcDe1jV2XRs5TmUqcSEsD3xBezRpHaTFcY1CYSNctTV7N2QUuukmJNN2NrQYWdwn53pVasK1GCY/Q4afRD0cmKDAD2UII5TFNiDaZnVmpsgv16c+1ijEh+5Q0i/KnuEY3wQc/YyKm/Up9oRERLyMCRFCWi+oaALp69D8iODYrPzZ9d3v+cZ7R6BtRiJ8lESmVULbmgsrrRKMgZhjTTXdXVovL3VsacKoulYsjt5Oh5NJ8W/bJQPGt2hh1schpqR4jPQrjz3J0w0rgltjxO8edbzO2vA5BX66kU6Hp7LDQiVSV9jrC0XO7+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgQYMnVyBrP6eyHdzTgLOco+ndaIzq1ErtcqwtQ9L7E=;
 b=Cu8sMdMVpGZYmjYYkIhf5eqVeIne3Rjv6+qp+1Zzl0bdhEU+l95TFlCZnPmA7Gbe3LUotnnK0l8P1MjsORPGInHybOpJjHik7cqCYag3k1MtZT+h1Q7HrSrm35a8upHl/iqAzl4JnaOdWA0+wPIBTyU2tKOtWtfWQDALCV2AzEddFtakV9/OBDxHsqJK4KMvpLzLScPXj+cjynIDFSfaKwpYeaHpOHKess1I1iK+6I6oNHkRWUWqQglLZTNjH9mMOsyJIrnizXdpJq5amZMaa2IkX2qjbh3+kjtQ8+wql9J/vpcwJmd/CQ3qayOzzkMCHtXEnSYcKKUKgzHZvAuXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgQYMnVyBrP6eyHdzTgLOco+ndaIzq1ErtcqwtQ9L7E=;
 b=woev75G669rTP4tQAeOhPx0BO3kvIw8v7KRv98w+aZ5pQq6++ymNJQbk6gCIPkqkJHSpRKjT6CL/lNYcZJNbi9/B015m4vc3JhtulWvxtFmNXK39Vikr9F1XNS1YK/UKCMZx4IIZcnvj46wLKqLEM/qx5rHUjZVYlD7L7pi3yxA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:14 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:14 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V9 5/8] fork: allow kernel code to call copy_process
Date:   Thu, 12 May 2022 16:47:01 -0500
Message-Id: <20220512214704.104472-6-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: edabc01e-a35b-46d1-90fc-08da3460fa08
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB331175FDAF7D341A091F5385F1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q53W5kzqWpQFS8+/zt5GlsZGo92yx5kuLCQ+RiadcHetaPimQAWxMOKgK+Vs69UHkU23TEBfyvnh7uUxwgGzdLcGVkAhmYw1kUQf/nXc7hsrXAQrE7PRGjQqG1SGClYZABHJhH8d6S6nRTGb61jiZ/QodEt6YWyD3p/Qwqy+v+1ylWVwmq5Iv84wtco3f6Bmttyr4w8CJ3w/L+yNloFQPOqYRMk0vrgyT3c9lt8vM+KJ7zbNQsHAZ7jPyxixd7F6zw65WpuXR7yBKOO8StdreEv4WOQbJovBlGyef0SPe79ogoGQlEOk8VqICUTXZCnfGfUUbcJCW1hBiqE9hK1qI/8rIzSHDegcdSxTi5jnJ8UL6LdIVGVUiwTd25/d/Yh1kAgKPpwkKWo25XEpp0CKR9ECTshTC9t/j0JjXq4xPRBmfXj0XlTO4iDL316ZkmSAaSnmeM3Ja2gaUmhLAfTWdMna19zzrWy0hUkbtUT9JO/fRETZ4Lb2IjEPuX3WmurfhcZVigEj6ld9s8pNrDDVTX3GVuGaQa9+pFY+4xyx3N9h3PYVgoRbMC+a3iFtXabYjF9FPH+GSNMnuXJ3Pw6D4SGQfIhRcrez0fUcAJOxr0Z4H1+3frNjzEiW7uLX/zHEdVUROD9D5fdSpRJZF2dxw9imFPCmEV4GOe6WLESTB8nt81HomfnPiaYi6EtV5gbpp3ZT3mxffT0HZ2e8Ha/3Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(38100700002)(83380400001)(8936002)(2616005)(107886003)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIzpMWP0XnsNCT5+r739fQOJy0PtfQYHR5DWN1TrUe3BxDVe0hpwqYT2uXKM?=
 =?us-ascii?Q?f5Y0x7Dy/3a9XEW6I9lApRB4CoAYEvvaBbxFsHoKkyVypjd5ZFwBuNg8W2FR?=
 =?us-ascii?Q?Hh5QKpB4xVRv1JxB1N+RtgjR75yvv66FCJ18nX5WccKjRpt3+mZl4OIf/DIi?=
 =?us-ascii?Q?ymw9NdzqGOOFXlaonNLhylya6mKdRoCvdxpGbQ8B9o3Ch+WNfjs1foLm9T3D?=
 =?us-ascii?Q?AjCndYwVQLkHeZB2xZADDebg4pIwRETZ03CKtskrn8q1kik0N38wUpqZDPRl?=
 =?us-ascii?Q?iFMhp0AzkNXs1Fo3mGlu1d6Ye1oiwCIT40yh8layWQDUS7WYm5lR+2y0K3EK?=
 =?us-ascii?Q?jyz9JyTmxSwSOj7YP+/YTvq1lWE/gjaPHXwjbX0T0ig/wExFRtpItlbFfiuc?=
 =?us-ascii?Q?pSi8+gyrqLAkEBbS2yUggPoOJtWHkm3QNRyQNM8mcs0eNjJkKnPWx4iavX8E?=
 =?us-ascii?Q?3Qwbf18IqZoIHLNE93dNCs5WjLDLqAiD6MrYxwgnjwRqUZyagORZfQSeCYmN?=
 =?us-ascii?Q?bEqM4I+tzPfTQT/IzkRHbJrfl/4f0wWSeXXa1yx/MU63X8jD8t03n7dHS7nc?=
 =?us-ascii?Q?kLUsE5mTkay8DZNalDQ5XvEcHN73JDid0k75s2CpENQAKNPnSPODXhjHcryt?=
 =?us-ascii?Q?2ovfEAk9XjKGkQQXVtscV+ubczkpdX5wmG6isQ5Y2XsSabpEBWZJjLU5+tza?=
 =?us-ascii?Q?XQBztRW9VzpAw91Mtpc2P4R8dzXh2LAx8iStUk3x8hV4/CO5+632qA/CwhjQ?=
 =?us-ascii?Q?f3YyGGrdvjGCrpdTE1I+RjDU/27X+C3RHW3PHt6HGcB+YqtJWjodEbUsVO2n?=
 =?us-ascii?Q?FIWiNKkf7bRzV2m9/yIXDZA0Ko7OBd0fhKDNTSCX6CZYN6KnDG7zX521vnnh?=
 =?us-ascii?Q?ZKDfCdkXkpR/xZ48LdL6FwTftQkEW/twHLUFIqr5ztgl7ZeWJXh8Fv29Hrgs?=
 =?us-ascii?Q?cQXR6mvlEgM7/GNz6GxSzUHeWgR+yjnrCX0x2jiunb7Q9/8qgNXEtXtJlCXr?=
 =?us-ascii?Q?ZdUSdJyBuoOeuyUs2B1t/TvNaboAWZ6/3H9dAxy2Mq1rnCKseQWynV8B6juv?=
 =?us-ascii?Q?6rdLv6XpQ3FRGGBcG4Jd9BdtsEXDgoAWJjDDfn7UkLYUeFhS5lzghIrmGepK?=
 =?us-ascii?Q?4alflX32N9EV32Xpw/Uz79YEV6uHFi7RxRazZArleh9swBAIyXtRjqi4viFn?=
 =?us-ascii?Q?x+4y+08aNKpRGLraqq0K7ZexN9ssIOpalFjpGNoFsPHpQTCDw6CdytRcwIdZ?=
 =?us-ascii?Q?j7sj93v0yvdodGg6hajrM3j7kFwMGokrEM70zIVG97LLKVc9GHPxWYCKdvpZ?=
 =?us-ascii?Q?QpELTCejraIjfJfg2rocHFLiWb2YBusfJX5YePU6Jbc/84rQTGI47LhsPJTW?=
 =?us-ascii?Q?8QRs/K99ejCYMc4pYOs0TGibyq4LS5jDBj7+DtukMy9phb36vJ10EcqMrj87?=
 =?us-ascii?Q?83tkGqmOA0agX6RcYalLP+Kf/hr5n/PrSNnHtDc44NhVISMPbZdzOBABowUh?=
 =?us-ascii?Q?BQTL1EJbx7rOu+v4j9ZwcB2Lw9IPzAcZPUThZ6K3yfbE32va+8kMrG4gZW1t?=
 =?us-ascii?Q?ABCTImcnQT+70pFX6vtStsZimJ8qDL+yjRsBBuAO31PbiyjBV7Oj9WOhHKiA?=
 =?us-ascii?Q?/m8eVO4LqCLQ/M9lqu+eoMI+SF3ZvPv7brwlmS0CsC7fDOytvc3AZznyEjUl?=
 =?us-ascii?Q?mNNrW8GDGDpMf6iYCfiJIq8w4JUrC/6l0F+dAw/aTVXZUGuJJHzx6HaDFfYa?=
 =?us-ascii?Q?NpTNpt8ygPop3+F/JUPQYiHRHIduOzo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edabc01e-a35b-46d1-90fc-08da3460fa08
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:14.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 572wjbn3KVcBvL6YgZw5FLyD8OrE8XsNsgwfpeqDHsxg4gc1Ft2pDuWkzvi8VT9eZ1wyCWdFakUQzrxHHJuAPwkdk6CzcHFZEyhkon7aKss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: PzrZZ_d3ks3dmMOtg93aWBdAuCdAnl1v
X-Proofpoint-ORIG-GUID: PzrZZ_d3ks3dmMOtg93aWBdAuCdAnl1v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 84346fa6232e..cdb385dd6c1e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1975,7 +1975,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
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

