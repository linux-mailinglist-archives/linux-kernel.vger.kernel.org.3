Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764CE462104
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379976AbhK2TxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53658 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351377AbhK2TvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:01 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVDIA009070;
        Mon, 29 Nov 2021 19:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YIWujBelXi3kXDA45ujdK+AXkT78q1qx66pDwiOoPmc=;
 b=xFMpbYGuIPzFJ93GgQo2ykObZVKmlFiQbuJS7xIDnrzrEkv6T3LctBmPNFt3jNVPpOca
 6GVZNoFjskxmZ4WZn88M0o1gl05OBdDyZYr5sBk2SZ5qfJOKcDDywatDAl5umFqVuJzQ
 oE9DTOn/lnDBAmDyIuOtx4Un72/M9mn1FTSIfpsYPH9eqQ3cTma5ermcu5eHI2wgVq8h
 kbceYMS3RYZzGwh1irfyzmry53S5l5w1tEXeDRdRwtvCtoAIsnvrmwD66RDkBkjMlnDU
 qjJ10SWp4cK2uWZZySWyyfYIPm+tb8/873l05TJ3wqeZFfJjhP39UObwg8qF4Bi5Mi6R HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9ksyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8a181733;
        Mon, 29 Nov 2021 19:47:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA895wiQybl8b3+hRFDTPVl0U6/FaODZywRl0L+uzjiQgHGGKFxMuuqRGnV5tg9meJwqEAqOqSt2dYNICI2RQvSe4l2kN06brcO8itdxL77GUwrgPgLNjXJTp4fbGc3Wir33EK3uhZpxZ9vEWrEktvhgNlXwJOpCMiPuP0Z76SjiltR5nEwzilVYyqq3ZY8kRxJSf3E72CaLhLPjXM4LOVtSebyA56jjfeePM8v283CFGV2cKZ6kkXdexJpvVnWsnM0CCVRWZuiY7MYOQd72ppP0QzODC0URKvTck/JulOez16bsmw/r+jWYnObZCRer8YXqVoWlOgpfS812zV46pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIWujBelXi3kXDA45ujdK+AXkT78q1qx66pDwiOoPmc=;
 b=ia+Bw7tIwCJizuK3TCVBijsrkTdQM5CEosjO36rKZNcSwSJML2Ypob1MWIT4O3NxxazfNWUKkPa1qYUQtp6Y1zCrnL0lGxuA2SU3bYYFpt0C8VrayqyIxWxz4suNl9f4gMrxwIHcJELVwd1azuL2dW7lvZuvhYStAt7eyrwZI5cgva3BiEe7mYqhAHICcfGNrMenUQsO5lfYIu38sNXTflvcU8zqOWMPjfASuDF4sgERi5MxE3WVJolH6pFiVUiGfmc6PyJ556BLKOYYrq5e4d71GGEExChCa311s9/FzkjaBCHmsydcmgParMCYJKcVdVesRDB4AzlibHST5Vat0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIWujBelXi3kXDA45ujdK+AXkT78q1qx66pDwiOoPmc=;
 b=FmDi39R0I2p4gYMwzztoBT8BOlozfbjfkWh02sGQPwG/143MkcN3LgxTo3FJ8oA9HOYPcXbe7RRMxWYDBdTAc4Rya3XYf8SfclOaOMPqRwDmWoTowCQhD03iF7mC2OHZ1QOfUSnnBx0tce7wA8DHjjD8yiJkkWOHX0OwIvN9V0Q=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:17 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:17 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V6 02/10] fork/vm: Move common PF_IO_WORKER behavior to new flag
Date:   Mon, 29 Nov 2021 13:46:59 -0600
Message-Id: <20211129194707.5863-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db9267f9-09d6-43ab-8658-08d9b3710c9d
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB130703F7899A93DAC85C565AF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7KhKeK5enUlnJLvmlj2R7F8J27+2XJhQkQeYt9P1wR0d4R+y81PTTGczUaVCgVsqB5FmPKSkrCFu+/yso09f1aWkSPy1t9TFwfwtc6OxaRmdnbuG19gOnwz9WWHz6x5b1IPLQ1pyNVrILP57LOuclPRvyp3/2+UTXCwLcyj06zgY59bbkuo2Lkr6K4yhV7HZ2JUw/k6kiiYcJGNnO+s+sv3DLNd2tfI74GMBNNqJ3Fbnr2Xpa4t1nz6wcICsOSEQVS3xvjLZpvMUkUcdiOSHehr+2vkdLk4EcIEv7xUTQ0nwO5edmS92kLX5oNWfkEJ9f8fVBdmksNLq0f/EWomw6tqnwDzSLhRluqtTI8N+Tjz7pg516eTwemVyo/+l9T2mmcOFQ8m2UujwmxeZhoGuRNGxSsaQLz0uM7er84fxumVcu+M59UJAPsfMd6EcnSEhScaVdUzB1R7gl6hKX3xM/8xfwSmRdjNZrqT9NScgyifizmZPDy+DG+mHRkZ6z+FOPpE5//YgjwksgY0xod1UMTzya0mnFcNDlREYZXpUG5yrvFDb5rOAUWAsqHPP2PMsp+2MmlEc7ZboEsHJmpvRlxgq4oTdGkKl+ArhE3SrBrDV0PSen3Wn1L4tqO2ruaKif2NiYbq8JXjvxRfyK3Fr34owbAAxIizyhjS3bRKGakGkLVMPZX6HvoY7R1Pb3xcNO9WK4JBKl/H5TCUKJO7Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(30864003)(6666004)(2616005)(6486002)(66946007)(107886003)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUqdj3WB0B/B/NGRo0EWgXVX8kUZWfln2u42hkOb9aTqb+KI053Gja0Uit2F?=
 =?us-ascii?Q?1w3A1g91M7aKAkMX4EBlA2EhZNTg9xOfI0MiUdv8xOu2CfcHTslG2UCGcWsy?=
 =?us-ascii?Q?TUHl2iiRzCRRYiz2SQ8ZJ0OAbnEAl3LM/j7Vy5qd/PaWyJgjsT8zd9X5KrRD?=
 =?us-ascii?Q?BK2lh6RkUSMHqn7XZCoDRNe6dJfo9s8D64qn4isXJIE8oauNGDJ7KGy9gWhu?=
 =?us-ascii?Q?BXGTgfVrmsLjbVRgtDweEEPFBmj88OtBhUf8wuotlf6y0pofE0+FUqnZyNQl?=
 =?us-ascii?Q?cd3/x6hz63lBFCa2DvkWS0kbtR3DiXgTQ7/gT0Wt+wp+FcaWAguUPnSkuxQm?=
 =?us-ascii?Q?wssneiusb39PbGeIW2721BNAmBdEwcbS/peqYtZytN9dHJ31Slw1TX5KZryz?=
 =?us-ascii?Q?diLtleYxlTEtq2FRdyFiZhsjJqYr9OJfZDjt4HaIB4Mv3gfzX+/USukRFTYn?=
 =?us-ascii?Q?yi30vWa9u0tJItkaSZhCP72AjmHa5F1BXttCW4yMq6a/RyzCQx0roT6PNvnH?=
 =?us-ascii?Q?mJ2mlvvlKYEWQmjmCLze1lSs5TllaWgelPM4tK2Z9CjgLR9qx7Y1asyg6K4e?=
 =?us-ascii?Q?LXJM9woADX6N4Wci9s971RoNxgjcLIlrqklIXE1u3Mo/dFlYw+DAR2p2SIGd?=
 =?us-ascii?Q?Rtx43ldlhMevgP496HgpFsUa3NqJ+CkjkHFgV3R6iB2XtjSf6e8rQpAk+Qs/?=
 =?us-ascii?Q?AQRsg3X3EoQJhVmCDyZrDdBfnZcQMhCZGxwvbkw7E9vU8CBCt7HRbVCvnbno?=
 =?us-ascii?Q?STLNH/bYSVe68WXi1vzK+CxIjhn1f1/jlmY0izHKRpu/IjDflbrOhVPfXjXp?=
 =?us-ascii?Q?z2DHa1BfiezeDlboqaDQtMl97LZ+eOvuaQVDY+02i7uLZ0TTZYNbzWgM5ZxY?=
 =?us-ascii?Q?1XcF76GHOPg5QbNAbHuGZR9Dls0lyBV1rEDtoo0GX5Og0QYrHUnTP3PPrpZm?=
 =?us-ascii?Q?i0FuBdem0VU3V3OR1pCEOPtP7CtAwjtV4iitXdKGXc7t6Ndne7El6CcNd566?=
 =?us-ascii?Q?KRncoIzI4ezbqSMhGNJt3PT0UuERN+cLHfsd27OZ1KNQh7O4y+ZxWwgQDCbj?=
 =?us-ascii?Q?lCqESDe+V/JIo/9PNmlEIQYbtit6PbXmLRHbXfBiB6m/D4f3CTW0/OZudB6D?=
 =?us-ascii?Q?jK6A8lI/cXNKd2ypoY0nI2H59p2WSlXOLHcEHuZJm+wuizfQTyYqMrTfly4v?=
 =?us-ascii?Q?7Bs7qIp5sWCScf28kXgD3E/5jUZa77o7+A0aQTVd3PQPmraU29/7IJt6iT7M?=
 =?us-ascii?Q?TU6zN5fJ9mYb19a3rljzQ7vtvnsgDz5FxUOW0i1oUPQpOUZsxA5oaQdR9NlR?=
 =?us-ascii?Q?d0QJzvrSI8/a5JYs9V1HRTVDQXqXnX5bBF8qgeYepbomfUKQfujGtHeBcDey?=
 =?us-ascii?Q?BpXS5N8eDWE2RI0eyHTMdv5WmFagGqNfBY7K8gCzN78tj3OtUcqvCVBoAjP4?=
 =?us-ascii?Q?G6L/q5W8UgRTWGiNGaMTOSlRe3YHT2ON2T6TVWx7WVjzksHC7+JmXUdRRY8X?=
 =?us-ascii?Q?mK+nTFMoE2RICZpm81EuTjkFW9u/pO1siaZOeM59w1XDn77nhk0X/aSWuFEN?=
 =?us-ascii?Q?4QoaCHAuq/ShoR3hQoW/p3ko8Rmi+VF1xgDmhDmNDZkW/YrrfvH76bSOQJbz?=
 =?us-ascii?Q?5s6fpCB30kR2UP90nZ+XaIv7bXYd3uVieHwB+AmDT+ethqV7twuYdra7bVKc?=
 =?us-ascii?Q?NiuPMg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9267f9-09d6-43ab-8658-08d9b3710c9d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:17.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJpEJQJ24YhRttJWRcsH/1YO1sj9OIldW26QI4Nd0JgnCMF7GkIsoRmQI5s0qbkUvcsJ8RbPucLEZpHDGX2HHwVI23D+RxVkDG42sqy0JMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: RlsK6sHeIixIORg2gf-avh6WQQjxK5Pw
X-Proofpoint-ORIG-GUID: RlsK6sHeIixIORg2gf-avh6WQQjxK5Pw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use the new
user_worker helpers that will use the flag and are added later in this
patchset.

The common behavior PF_USER_WORKER covers is the initial frame and fpu
setup and the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
[For m68k changes]
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 2 +-
 arch/arm64/kernel/process.c      | 2 +-
 arch/csky/kernel/process.c       | 2 +-
 arch/h8300/kernel/process.c      | 2 +-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 2 +-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 2 +-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 2 +-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 2 +-
 arch/x86/kernel/fpu/core.c       | 4 ++--
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched.h            | 1 +
 include/linux/sched/task.h       | 3 ++-
 kernel/fork.c                    | 5 ++++-
 mm/vmscan.c                      | 4 ++--
 29 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..f4759e4ee4a9 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 8e90052f6f05..b409ecb1407f 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d47159f3791c..44603062d661 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -251,7 +251,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index aacf2f5559a8..b4c6c41847be 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -333,7 +333,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..509f2bfe4ace 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -49,7 +49,7 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 8833fa4f5d51..050aca44ba6d 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 232dfd8956aa..40f8294c6c7c 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 834df24a88f1..29015ebdcf1d 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -338,7 +338,7 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index a6030dbaa089..cbb693012b5e 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 5e2b91c1e8ce..de1da9900f7e 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cbff1b974f88..6f1ed337cd41 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..dba91dd1e289 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index f8ea522a1588..eabf3452e5e2 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..aa110383cfa1 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -172,7 +172,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ea3d83b6fb62..a76120e30eb4 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -197,7 +197,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 406d7ee9e322..0b06b7809816 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1700,7 +1700,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..8deeb94eb51e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index e8858b2de24b..5ce90a23b1eb 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -130,7 +130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 1c28e3cddb60..0506a739b0a8 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 2dc0bf9fe62e..5386e56b5e6c 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index f5b2cac8669f..6058b3966f71 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 82107373ac7e..2cb57aefacbe 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = current->flags & (PF_KTHREAD | PF_USER_WORKER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8ea306b1bf8e..f3fc1b1db999 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -485,10 +485,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	/*
-	 * No FPU state inheritance for kernel threads and IO
+	 * No FPU state inheritance for kernel threads and user
 	 * worker threads.
 	 */
-	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+	if (dst->flags & (PF_KTHREAD | PF_USER_WORKER)) {
 		/* Clear out the minimal state */
 		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 04143a653a8a..7c451f234c26 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -195,7 +195,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
 		 * An IO thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index bd80df890b1e..00d81668ead4 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -224,7 +224,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 #error Unsupported Xtensa ABI
 #endif
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..5ca45456a77a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1683,6 +1683,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_USER_WORKER		0x01000000	/* Kernel thread cloned from userspace thread */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 65d5ec3a8a04..b7861cb6a74b 100644
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
index 6effd839d566..0d278ac26f2f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2032,6 +2032,9 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+	if (args->worker_flags & USER_WORKER)
+		p->flags |= PF_USER_WORKER;
+
 	/*
 	 * This _must_ happen before we call free_task(), i.e. before we jump
 	 * to any of the bad_fork_* labels. This is to avoid freeing
@@ -2524,7 +2527,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.worker_flags	= USER_WORKER_IO,
+		.worker_flags	= USER_WORKER | USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..f504ff88a09d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1028,12 +1028,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD))
 		return;
 
 	/*
-- 
2.25.1

