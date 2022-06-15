Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1454BF93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbiFOCL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbiFOCLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:11:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C14248D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:11:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0Sxlh000892;
        Wed, 15 Jun 2022 02:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=VB5KC9zdxhxBEeHDl81mzpiGxVscSardrsEkgHsrhz0=;
 b=r++PG2cvKn5kaUjm5Z1AWQ5DZXEmpXvn3eczi/zjcKzLM+sqnVSYeiBq9++5co6We126
 rAqgY+XcsE8oSCgDLZ/NsfhhRXbh+Bk1ZkU8lFRtApsQrK2zs2hxYo03ewYEuCQxgYIF
 YfSllGGtZtsvXk5bqom1tq/jimjbIFrcvVbFTcKhd8aH+Cr+MZNx2+V2Me+j0kJv1fVF
 wgxh4clC3mq4vD6MWOLMDYwX+S135GgnCK4xr6axFVsDBs57x2DzifbNrtnih3gnoVWm
 mN05FA6zArbQL6YQ5sHkFn+ilKnRR57U3L923I+gBaYNJ0blj6S/IrHlFRwo7kCxs3uP Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9f5y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F2ACLF005230;
        Wed, 15 Jun 2022 02:11:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr29rgmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6P40c7XbvSjoCj+c6/mZEc45FjDO60LtfEo4Vs5tv6AjOQyEOG7iRuNYZnw1/4zeaiYGofWEOuV6/rmvykDlYSkFaZUNKmZh0/6+W+3vWrsdSxxXWhh9GxDOb4v2Py2f6ejJ7WGfwObVz40gI/3QYYalBr4g87iUx2Na0hAv5N9ErFVonMLH6dZRFmHQlUab1brgJwThFz6JqpcY9ukgygYGU6V2r9UhbWu6R5PxtaE5SDwNy6Yn8F571PVGhisQhTaaoAqLLIBEX3AERA2Ifgoq3ydAxrUinnZiipR+lneHHdzal47oRaflluscl/uRoPYvM/CkNQubX7dDjarRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB5KC9zdxhxBEeHDl81mzpiGxVscSardrsEkgHsrhz0=;
 b=X72SYUnv5qFvJImR3vb4qs8d4lgyUEmcP2XOpqHNjE9YLq44G6Z5/fyc661USAcUUB5AO8KLbMn229NTJpwL/VO5BnMPRY6No10AjDcL4aGOARlnxMF5OBDd6JICQLlwjqgVnNevlTlljicwgsZ6cNMwN3n32FAdd9zJ7l09clZfIqB0hIO9Qd35w4ZJZ22MBqhYHphlWFwYP3kuzTmugjWKiPBV55Fru+gZn6IGdGBzxsxbPpzuL9m4pNylBjwYRDXYGYqT59EVoX4dWQ1FDK1ValtrX2cuewrnVUlLHyaJ4qPKd52IvM/Beeo+LGMJ4zVTmtQGLFPMc06C375uzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB5KC9zdxhxBEeHDl81mzpiGxVscSardrsEkgHsrhz0=;
 b=olq8EL7BnURDso+yp8xj+4on+bj0mOP3OS5E+mHmA5Nnyk4SVC1UV7/EjZ1fSuOcmWUNoVR+UYFQvT7gU9hJNHPSqqD6lGMkq3J/ZQGDpmBDsDnBBn+x6qGiDfQJIc7wdoybMFwF5NCsy1Dwc4oYMj3R9zLGTpkBBpaTsuDm/fI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN7PR10MB2513.namprd10.prod.outlook.com (2603:10b6:406:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 02:11:16 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 02:11:16 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] kernfs: Change kernfs_notify_list to llist.
Date:   Wed, 15 Jun 2022 12:10:57 +1000
Message-Id: <20220615021059.862643-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615021059.862643-1-imran.f.khan@oracle.com>
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::13) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f42a077-8f87-481d-febb-08da4e745437
X-MS-TrafficTypeDiagnostic: BN7PR10MB2513:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB251338FF95945E66A34865D5B0AD9@BN7PR10MB2513.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3I2QkabaJOyvgKA6Jyag7PEhjJp5+FCQPJXfPje4r8n3wCfrX2sXeQUZncYoX82w9tBleDqrHPDsG4K0LpOVgABjv0V1jpCgJS79d627eCgkv6OoA9deDNYcRHqEpuD6xPGp4ZPU19ncrmHOyH4bTV2u0R8I+iMHWnD6kLMxcNILosHBUqua5WdWQ2PvVN1PiR2Koae+SkfQvzji96/h3/plei/6Psdv8RGpwiv4CyCKSjWXZwxmrUWnkopHHrHUfBkwlONGMkNNBiRvDU/55Kdf6giTSs7Rm417pN2kRiS73DAAlvQdK1kQ8JPOFBqvslaEGyHQQV+V7+IVzf3fVI03O1BidsI7bj/bCqVN7y5eBsI4ZL0sIv8JrpR9cEGBwrWUSi2PwMNhjEC0s0DoHt22Np3jAy/vSel2Pai0URLObiv6PxaF8NvACrGSq2HgYsidgSpeKkUw03R3tlccZsLsLhiTrNrpeNPvr9YePMmwSrnunqmMvqi/ed37neO8E3gSCgTaT4JIrjcW+Mj3QwKrIElz+CirNM9oj2T6/XKf9Odk2batza3WMjwSwRpHbAVqIL0s0wMd09+C/rHCQvcGgQuMlOlkADyLdFXXpGh2c7vFgOQfi/z8xMAWJ3iDq0EzW0vU4ZzdFD1IKOKIhtRptqf4H6rXP5nt6UuJXprcbn6fZmrJwr+Rt538a8e+oAsc5LTmDzYQTxdAaYa8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38350700002)(4326008)(66946007)(6512007)(8676002)(2616005)(66556008)(26005)(66476007)(186003)(86362001)(38100700002)(103116003)(8936002)(6506007)(508600001)(6486002)(83380400001)(5660300002)(36756003)(6666004)(1076003)(316002)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVrjjPCRCb/HE+0TWhsYunMU57WRO1JiqlxrWqMQBMqmbSsin4mDFF9UwEac?=
 =?us-ascii?Q?HOqAFEBw+uTo7WQ8rXFXJh3YTtCmgFLjIJWQIpY4HqjcAi6xJ9EmJbMEvde+?=
 =?us-ascii?Q?YM52K6FWBD6hsZZB8q53LIOpHbwDKsTYevO0ejM7pC96nwvFr5rlLcFfPfeC?=
 =?us-ascii?Q?6vE8BUoA07MwT1pZrRYsMA5TOmfLb/EV/aXATh0Kqtwx3Ht3L7rH/eo3UhXM?=
 =?us-ascii?Q?9sAz/ME+KpTKkkvhh/FfmLZ5WeUPJ6v3ThyTVj+DJPNRANEapVSgc5++vstI?=
 =?us-ascii?Q?1yDt/ctNXfZK1G8PKEgtX/zg+AyJIntAHvPJY++UlGmyXN/Htle+oPocecp+?=
 =?us-ascii?Q?6lMejoda7FtlxZs/t9sAsNE9RcZ58i2fS7F4Spg9HnzeZ7jstm+EBcg/m/ql?=
 =?us-ascii?Q?B6lSyrP27Y+9F5d5doIdoKmXTGjzQxUVjqLarpwfWtyRWN9lRzdhErccfCzK?=
 =?us-ascii?Q?dfk/WXOMCRhP+hNTbPJ4nejbGLguNaYJdup3qgA3QWK1IoNN5Q3KTUEjmq8n?=
 =?us-ascii?Q?orxBF1or8qgzY3d5o3wgyRNB5ZeAyvo1e78cloBDBJ3RFwY8wUtfMqjHAEMt?=
 =?us-ascii?Q?9/BdAuGt4h+TgBLR35H7aB2/UmLDfbN4ghidEtXxbqyyYxFTqP4n0QFz6Ior?=
 =?us-ascii?Q?D8UhTPrE4YcswAVVPUhW4JiNE4YgcbudedHnKhGnyvYic9lCtw1TfIZQ9yF7?=
 =?us-ascii?Q?va0t0uLIi6EXTRy38vvDEGUPmmsJ0b5PzZe+RWDw8dpf8KsmHbw1lk9on5A1?=
 =?us-ascii?Q?2bvKUD7xBXJdQzJRZNe2xz6SIuf2EupiHqx7J2p8FnSI6uPft5hfpGiMNoJd?=
 =?us-ascii?Q?/IUPI/VZAYTPVNBQiqKKQCpgLiTOoZO+iczY0GnmvB6T2v/qzgTcS16IjUX+?=
 =?us-ascii?Q?iO/ZSVhPYlhusS6FS6uD6T+QF/xVZoEcnep4pb33Eba3NVQZJwmMusfyy/zT?=
 =?us-ascii?Q?mLSpA+98LpnbodIZ36srefH35U9DI+9LkePJbzhwrR3FguYdao6Gzd2xDkwl?=
 =?us-ascii?Q?mY7mAu31VsHzwEhy4ujLYfE8Q2Ul6qyhy8Ix1QasRutWoT+1ma+CVrZB+Ctw?=
 =?us-ascii?Q?Qr61511sHnUU2mygeWCpwOx+d5woEl0jkSHQe2bsn/pGXsS95fX383FbMZzR?=
 =?us-ascii?Q?iOuBqOTqID99GvHK4kPELr2luHbsGG7zBGKA/dLuhO/U4KR6l2+Beo3Fjkt9?=
 =?us-ascii?Q?HaNzls5AXaz6JonwXYOURE3ZCcGDhZPPfT3DVGWGW4Bh+BH5bgMxSM0KJtOD?=
 =?us-ascii?Q?golj+Gkun2IaF/8iDXyEFd5M1epRxbvOw2V+0xXAmS5UrDHButwAyZ/glwPc?=
 =?us-ascii?Q?tAqS+0wymJp+jEOf7Rn/A7usM4cNMD3BxYSMcPL+32Jfy1yH8xiVjAovI9hF?=
 =?us-ascii?Q?qKQLMVsjOY0bInSVTMvFLZkdxXHEuu2rR9/tt79PeiT39SY99jbLSQBOvs0C?=
 =?us-ascii?Q?RByMCzCzcCu5MZBPvLu/kKrqBot21i3bFaGUOM6UaRsr7aAbEWj0nQt8APAW?=
 =?us-ascii?Q?GQXTqSi4HegckJGx409VeyFAU3oTgr6jN71lFb6b//ld++momuYnMoEs3aIv?=
 =?us-ascii?Q?vMOCFEEbRG0XajgCtwiHFdtNy0cnaAOvt/teHCEQpfAoSTCU/qQVi2YnTsMs?=
 =?us-ascii?Q?DrdS8NGrVXgpH8U+Y1zXQYzZ/WYFvsVzEN6FWa2rlIy1gSGTLpg+BrtJsJge?=
 =?us-ascii?Q?NCM7Mbv/cOpZAZOXt1hY/9jpUdxfiR7JBEdjcpDDKM5X0fW07CNMB3wsM6CQ?=
 =?us-ascii?Q?09qqj8Z/7aDMY7TJah5+1MeDAZ0X/ug=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f42a077-8f87-481d-febb-08da4e745437
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:11:16.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTDJXoceoCoS+UAKKIpehbX3xgISeWnvAHUR9ujIEoHrQ/CwICMPW5sZYI9UJzmUa0DdWoioGIr+ibMUXSzVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2513
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_01:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150004
X-Proofpoint-ORIG-GUID: o49r0AZZRjirLWGt_8yW7vP3WzMid6XO
X-Proofpoint-GUID: o49r0AZZRjirLWGt_8yW7vP3WzMid6XO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present kernfs_notify_list is implemented as a singly linked
list of kernfs_node(s), where last element points to itself and
value of ->attr.next tells if node is present on the list or not.
Both addition and deletion to list happen under kernfs_notify_lock.

Change kernfs_notify_list to llist so that addition to list can heppen
locklessly.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c       | 47 ++++++++++++++++++------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 706aebcfb8f69..dce654ad2cea9 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -38,18 +38,16 @@ struct kernfs_open_node {
 	struct list_head	files; /* goes through kernfs_open_file.list */
 };
 
-/*
- * kernfs_notify() may be called from any context and bounces notifications
- * through a work item.  To minimize space overhead in kernfs_node, the
- * pending queue is implemented as a singly linked list of kernfs_nodes.
- * The list is terminated with the self pointer so that whether a
- * kernfs_node is on the list or not can be determined by testing the next
- * pointer for NULL.
+/**
+ * attribute_to_node - get kernfs_node object corresponding to a kernfs attribute
+ * @ptr:	&struct kernfs_elem_attr
+ * @type:	struct kernfs_node
+ * @member:	name of member (i.e attr)
  */
-#define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
+#define attribute_to_node(ptr, type, member)	\
+	container_of(ptr, type, member)
 
-static DEFINE_SPINLOCK(kernfs_notify_lock);
-static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
+static LLIST_HEAD(kernfs_notify_list);
 
 /**
  * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
@@ -903,18 +901,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct llist_node *free;
+	struct kernfs_elem_attr *attr;
 repeat:
 	/* pop one off the notify_list */
-	spin_lock_irq(&kernfs_notify_lock);
-	kn = kernfs_notify_list;
-	if (kn == KERNFS_NOTIFY_EOL) {
-		spin_unlock_irq(&kernfs_notify_lock);
+	free = llist_del_first(&kernfs_notify_list);
+	if (free == NULL)
 		return;
-	}
-	kernfs_notify_list = kn->attr.notify_next;
-	kn->attr.notify_next = NULL;
-	spin_unlock_irq(&kernfs_notify_lock);
 
+	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
+	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
@@ -970,12 +966,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
 void kernfs_notify(struct kernfs_node *kn)
 {
 	static DECLARE_WORK(kernfs_notify_work, kernfs_notify_workfn);
-	unsigned long flags;
 	struct kernfs_open_node *on;
 
 	if (WARN_ON(kernfs_type(kn) != KERNFS_FILE))
 		return;
 
+	/* Because we are using llist for kernfs_notify_list */
+	WARN_ON_ONCE(in_nmi());
+
 	/* kick poll immediately */
 	rcu_read_lock();
 	on = rcu_dereference(kn->attr.open);
@@ -986,14 +984,9 @@ void kernfs_notify(struct kernfs_node *kn)
 	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
-	spin_lock_irqsave(&kernfs_notify_lock, flags);
-	if (!kn->attr.notify_next) {
-		kernfs_get(kn);
-		kn->attr.notify_next = kernfs_notify_list;
-		kernfs_notify_list = kn;
-		schedule_work(&kernfs_notify_work);
-	}
-	spin_unlock_irqrestore(&kernfs_notify_lock, flags);
+	kernfs_get(kn);
+	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
+	schedule_work(&kernfs_notify_work);
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 13f54f078a52a..2dd9c8df0f4f6 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -116,7 +116,7 @@ struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
 	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
-	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
+	struct llist_node	notify_next;	/* for kernfs_notify() */
 };
 
 /*
-- 
2.30.2

