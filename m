Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8AF550E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbiFTBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiFTBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED75B7D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K1DwH6009331;
        Mon, 20 Jun 2022 01:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=O9OfoQqtyDULESzakeHcKvUmA7Xni/CUfnI3Mjwztr0=;
 b=iUIuCWGpri8Ck9v0OlH6qgAhZkKJXz1MRWFOXwBIBakYmWQC6FvzfEWOwXP3O5ZF17i4
 NWTrsZvGy1eMpnhZAk6Up6IDs+0m97Bqwcqzp0SzJkbIVU9ZAZ1ildE1XxPCcm9YVN5P
 naip/4apzB/sWK4e3bHnZchuH42VZ/as60ZQBtRc55odyyM38CfxEqHTI10Jl77KxJ+Y
 lmtLm7zdgwztpzECQ+zzKIsU6UCLTCMAJEE1yvOmIGomFnTNH/Kmr6Q6M9u1uO6re4FJ
 6tt7Be3cFmJGGI7S0qv/NxxWw99M/sUmKDvtyGVDuss0OZdufzZrgjmxOTFqNcdSU5+Q cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6ast047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K19qKq038388;
        Mon, 20 Jun 2022 01:14:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSfbnYJmN9HuZyU+ykwrzCFdS3oVz4a2LofWOXswjAcGFY94Ml04UQHg5IkM6guB2LGg/ZlWqEwei2OUG0AU+/c2wjpLVEp301+GJ85nK1d3pkWcv8LWIbwG5ALfuvqZ1ng0vLKbFSwhS4nDx81w2lGXglxW8KJbd6DvUamzTcn2TdErU8QFeeFauwSsIBWeQEus2N4SlZfFS26hS+dPm+oyoDFg2gi50wYipn9AsBSxqWjFeAwvSqhu0DwaDaFYtiNOxaz+Z9aE67jOlmYLUD+MKrslj+FAD7RLnHxZZthigTqHbHiDw2FP7kR7iHTb/esMvkB3ayxGyYdXSokduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9OfoQqtyDULESzakeHcKvUmA7Xni/CUfnI3Mjwztr0=;
 b=mJj3JwlA5v8bfDXkuMS5/0AvfoTW80mIj+Xz53iYQDpDsPWKxR7o8GCJ9Xapj3K+FwHM6OWQzqL2tSCBMsEYLbvgiffbFaI97pnbTzeXYqcGQjb+AkDn0v1yhfSErt3sW10+6berkPVZX7EQJM/yXzqq+btEhx5hdAdGhMBN3pSK+Bl2edXP1tgql5ZTC5LozQ1XO+31BVNWoFWM88wcZCgbrj6m+tc8YsxH4wJuZzFOKxxkeG6fL97zhUVenUXYwRr+cE90Ua3IrLcInCqLbBmbu2UUtHdj5h/ElbUtNHxPrvCTU/3X5ixq7kJRHOUr/NQ7LvixG+IhqySYpemUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9OfoQqtyDULESzakeHcKvUmA7Xni/CUfnI3Mjwztr0=;
 b=Erh34aPXd20+OsJ3Cy0XGN7ezf6XxGlrynxi/Y09EynEtvCzOVzPLGiNDzwYij13WRIe1ImtecXUrhs8U4TM2YFqpbi+y/ZhJpJN4ie1upgS+vYfe//zpKNpGD6vmOJbreNdRP8UR6LIXfSWxMmG/RRgpThjRW6V+GldpEvGlko=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN6PR10MB1905.namprd10.prod.outlook.com (2603:10b6:404:ff::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 01:14:10 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 01:14:08 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 4/8] fork: Add USER_WORKER flag to ignore signals
Date:   Sun, 19 Jun 2022 20:13:53 -0500
Message-Id: <20220620011357.10646-5-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9cf1b84f-03e1-4905-9ead-08da525a2d35
X-MS-TrafficTypeDiagnostic: BN6PR10MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1905B1DF3D3B4398CA9C2E27F1B09@BN6PR10MB1905.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiMOhwm32YZAQ1DOANZJsvnmQI3A+OH3Rse15+DIcFz1OVbIFTh4H7yo6pm/7XUkz+OkqnyORn+LtCWFmLsGcOo60PH/qtUA1FoLlmxJN4SQ14WNGUV5YHsMOJGTzl2JlqckCCixplzeBwCIRjJxSj6SSOQnf7FVMVwlONz1BNvk7/O4Bhq9lt2xWPdcMUX5rhEpuEkmQA3W3uu/VqJliwV+ykDFE9vWJsmJXJdkj1aZa0ungsI1CuBFXTfMyB4L05EV29AAkg3k3qwBwqD3cBTZ745NQVALV/pOViuAzeGyPqFWdxGFER/DNMrsaSIpod4ImKug543Sh2RyaY9Y55dhkbdoQitiAIltE0d6MJD2L0fPXYchXw6zQn80SFA9feKCMYpdFrtNBpWcU2m70G5p1n+fVdqtW/kejAEj+pE8BaBn1RqykhSFQOdOK7v3lTkS+0vF6AUunmSIw2GjViN9yAU/0Xd+CiW8rBdLaiBmEZOao0eQjHlwXCqoPRRczKjTF/zLaFrvJaeYSxZGyPyBMg+s6clmMMDfRZL3SF/Y06fSfVL+PjksNT6a+SCZWddVN7ivNiqlDuiw/LG1MuVdJ6Jn+SJpABBEbELF5u1YR3Mii1q6vk6fidk6dK5FRyVAitcb3pTIgyGe5+B6uaGUGfl4eDxZFf2lLiQu76rx2ZWJMTJ/mWNPgp9kY6gS9LFU2s38tKQPlJ3bUmteZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38100700002)(5660300002)(2616005)(7416002)(6512007)(2906002)(6506007)(6666004)(38350700002)(26005)(86362001)(52116002)(66946007)(83380400001)(66556008)(36756003)(66476007)(8676002)(4326008)(498600001)(1076003)(6486002)(8936002)(316002)(186003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJVzdXBM6q/i/fpULSFeaIL3Zn9tgqTu0aYGmre3Xs6ASjAKSE07ZdFldxPj?=
 =?us-ascii?Q?0LxocEZWaUZAYjfZyqYsqa/C97y6oJ214ACaKlJQ4ybjO8a8ju3jAghnV+1Q?=
 =?us-ascii?Q?WZM0RwF68x15B35KHVU9uxCtjklqHqEkFzj1fB0aEm+1eObSCF1nozytdd+3?=
 =?us-ascii?Q?uHELzXOSyO+xZCPVohJDt1ka0Eq6nQrwjMmLb0caVA2BDHXYT7MKLHnvU6UM?=
 =?us-ascii?Q?vzYswcrvwpSrjUkr7/b+dAVPOcahFl/sT3RjBGjBKhI/DMkCiy6XOTanst8N?=
 =?us-ascii?Q?Ebq2nYYMH5KQ/sMZPmK8GTzWbjsMzGThtOSjBK7E+R/Vkxw/qK+oXvKdiomq?=
 =?us-ascii?Q?iPDQESnWKQa/8opvudIL8lGK9JPGf7RwG4AnSEpj6KzvEAT2qpw2kW74OdRo?=
 =?us-ascii?Q?V13otiyafKh8pSgMdXxsySTxbldyq7oXTTT7TwHGMyay6E1T0bADBTmI23dc?=
 =?us-ascii?Q?vf9Mo7IAUP3P6htaDgZYPBgYnAsyqB1yCS0+h8Q6QhkARqdIlrhhHNwa0NCN?=
 =?us-ascii?Q?i3zz5UkraBAjE185fiiKk9IWz4tz3crlP0nw6rV0rW+CnXVH/6W5UTpg1owA?=
 =?us-ascii?Q?/uaDFvzgIcgG/6ES++qZqibWdcUJL6mR43OfB9nnmnkqmQJuMELtKo9oXsW3?=
 =?us-ascii?Q?TA3EKNh5iKWY7XNNhSTEPdQgN9npxcvWiJfcc9I63CXA8LHZ1g2oR/qDz53u?=
 =?us-ascii?Q?HOV9Bm4I/YnzLdQKdisSrQsTGWY2ZTom8Hj7fJY5HAxeBq485PMZwIQXuxsY?=
 =?us-ascii?Q?FOZ/Ph1FKLohhMrvK16/HdJW7hCAp7gOyadFQDyptF2Ps5SiQb0+JyzSggDa?=
 =?us-ascii?Q?rQy85w3MwWHL6PxACE+8IqDPVs2enNBshNnRPscGDD2WnkIKh1Fjmtyn0She?=
 =?us-ascii?Q?7Dwlr3vhYNVSk8RKf8LJk+X3Wrq3HfzSSBJ938+2lvWCumDt/tUmZgR7SkL4?=
 =?us-ascii?Q?M4JoV3tlGvgj2Iz2FMTUIiwjxb0JUu03I8VXvbOQee/G5P8pEsF3cX7rT1dL?=
 =?us-ascii?Q?6Om4E/M7Inay9WI0bkGqbDQ2OF06h5T51mE8J2fdGGqwN2yz4mvJWr4aP+/+?=
 =?us-ascii?Q?UQRJ0Ll/ZoWxbyP/WO37OoU7RMoApyU3HhzO9sqp52dVauw9ddkcKXX459yg?=
 =?us-ascii?Q?O1i3Ud1GVAs/LL19p9JrIErSCoOx6nFXW2qknueUHMjVQwNoNNinLZShxA8b?=
 =?us-ascii?Q?xFvV0P7svHDvDJnq01hGTLwK+HnMdWFApyHDGD6+3nT2WhuRe2lvbQ7M7PUF?=
 =?us-ascii?Q?QbpHMZ4LLcQeCY6xQmgqaXLeBYRtuO2QG7s+rSYTApw5eIFzljCdzC+PJwKp?=
 =?us-ascii?Q?Apfpd2UuQrjQZx5+QZuT0/88238sjSJazLp9KDfkb3lh4MTVnsXgpW5S0EwO?=
 =?us-ascii?Q?SPgEz+OMxb/6CWlOLpeHygkcSTuM6KCXaYK0EtRyNOc2TGIXNdMi1smEsG1O?=
 =?us-ascii?Q?9lwhUp++gTPLGFhrgHQUm9pzIU9fd86WENSp4tdHOn4Tu4fVZ4Dz2CHVe64g?=
 =?us-ascii?Q?NHDGX2cR7isGuI1C0BcZtOLuNdEIC9iOEKTtGqGP7isMuP0xh+BWrA1iUnJ1?=
 =?us-ascii?Q?p0nXCHeRLBF535NzMhgjbMH8RvPbKsJ1xTuLlLvXRGUWFsNySwBvT4zdW0Yq?=
 =?us-ascii?Q?AXYQTxjdQcXHNkkMOVxHrgj6X5WMfmlkQ3zDFTzJXl2U34J8qYfQMk4W1omc?=
 =?us-ascii?Q?AZNKkrGRZ11oiXe8Um9jzDUK/vsaQS6dtW/JOd+1MNHLNghvaKFncuL1YbtA?=
 =?us-ascii?Q?5RDk31Af5xqv5nI96gAzDhWmxmftO2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf1b84f-03e1-4905-9ead-08da525a2d35
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:08.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TroPPveraprr3XoYXcbrJd1IEiCkqGDXpIJaVi6rb8DbnyGWLTarvUrLlPkiZLp+KXX/ip9xW27Zvt6LWfjzFmAr9/9HsIJ2gK8tiJiM7G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-ORIG-GUID: Zl5mH4Kgd_rOZm-9kjIMOPWOxPjgBkpI
X-Proofpoint-GUID: Zl5mH4Kgd_rOZm-9kjIMOPWOxPjgBkpI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Since:

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

kthreads have been ignoring signals by default, and the vhost layer has
never had a need to change that. This patch adds an option flag,
USER_WORKER_SIG_IGN, handled in copy_process() after copy_sighand()
and copy_signals() so vhost_tasks added in the next patches can continue
to ignore singals.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 7f6364e5aa1a..9fbb489b2512 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
 #define USER_WORKER_NO_FILES	BIT(2)
+#define USER_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 0313aa9ead89..c479b8419a6e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2261,6 +2261,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & USER_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

