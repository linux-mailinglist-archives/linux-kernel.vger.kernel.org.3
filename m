Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740F522FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiEKJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiEKJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F085F8C1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:52:19 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B7W0UE013766;
        Wed, 11 May 2022 09:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Dv6MdJQVF/iPf30dqjqKA26fuiNU9n9T7VLokmbH7wM=;
 b=LJMn6xW7Ejh4xnd2je37BUICqrsuINZX+t09v3pgEu2uTLQ9XxecYa0bIP0MgzAQtJ57
 OoDIXxiZ7ZKz7w7s+sj0Kw1W2CE9VRAHfJgkCKrtYlOdzUpwM4vNuO2I1Yz9dAsd6k/T
 D/Pys+fGzh+RfDq+0231L5Lag7TtSCELvyvQsKCvk7765Pv3A49mEWjkgyWv85yebMzK
 m2U8tKNTwgwK615JSASfTyqAG/r94PfCPpMRwTMrTz83l2TLv21LeLGIod9LZEUXklrw
 waZWgWHH2Ujelt4vFxErK9ObaMAA1xT9Ax8WUbWHjTO+wNuvju9amQ5ditIBB+wENHlS Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9rw1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9pSlg030701;
        Wed, 11 May 2022 09:52:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73dv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E76+pkIYCZXWvTLVtYk4JyGRukaHeFOwqlEV9vPbFWaaEHwz/1vQEXoFmJmye+xt+WQ2tT7XrM/koSajaCGiOVkukDALWo1y6weplD5iHrNpsgYywg6PUhdjzWkuQtr0WpPwn3FkMIhRQq+354o6r5vT1A2nd/Ag2ZshFdCGcZG09mbVS5CPzASOh7eHo/a7vDjKxXtImUpcJMu9QHYEr54cwlrPusa+Rkg39Mgh66mFLj4fPPqUXkuuyxqLwWmHZ4exrwECrQj1xlZVw3V/79NKZxlXDdkZmG1X70kHRErrHPP5OVldxk+iQx2UjWIddR/mspgu2kyOEOWilceO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv6MdJQVF/iPf30dqjqKA26fuiNU9n9T7VLokmbH7wM=;
 b=ceYc0AlHIqauhr9ONGY8tEj023FXKY050ImCWzwY0d97Q5+EVdpKfyylvqumZn07NReGwlP3fikVpM0ihfVw8BiV1SnmGBMQertbBPTZohTHDF6T2yYpCTNHl2SrLEVneFmEJ3RALgS3SK87ALrCgEBjGmhxBoew8PtIGo63DE7r7GGZLb0SczVq8mSZmcIQl+1yi/drRsCp04rv37vLlA6bSlGh9R8X7u0CLG5VhOEaygCE/w13B/Mwc7zppH7aNP/8nGJT3IGYa1JKkhSVfUroqHLuyP2EcSz4HPN+Y9ph+13KjVYp5Vr1e4NpMNl6sMFKpM288sKCsVB1b5lQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv6MdJQVF/iPf30dqjqKA26fuiNU9n9T7VLokmbH7wM=;
 b=yXJ6F4eVpF/NkWXxnniPALLqUTad//1SYyL4Aly5lV+6BBrRyYdHkTriVIOxN66ctwjTyo2hOJoOx7gMXtZ31lMKonlxiMAAtWyGJHGmWfhl5h/zAXVjhc2g1E26jN/uA706vMqIy7LPY/C7PFVCPg9TZRRRbgKobszp0f7eOGA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 09:52:13 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:52:13 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] kernfs: Change kernfs_notify_list to llist.
Date:   Wed, 11 May 2022 19:51:55 +1000
Message-Id: <20220511095157.478522-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511095157.478522-1-imran.f.khan@oracle.com>
References: <20220511095157.478522-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e9a72c-417d-4c4f-2b45-08da3333ecc2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3718:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3718DA82463B6636EBB21522B0C89@BYAPR10MB3718.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAXx0wUB57qTj8r9vfiJl0jbSH1Gfkivg0vTammOo12Er/MzXbr27U58C/aXs1lp3GFrs9RMggI2rBGSQ5qanQ/BgS6BCeZarziAgqm21P/aMNaH4xVctA/m637y0rXqwYV/kSFYw8eHdUSmGrRhWROsYlwoqh59wPS1XLxTGmz9itEIpapwgPwkWZiYzDBmxAypnAazjstoI73R+0sCmmNxDrXeCyIARY0O/kPfHJ//pxIMlFwzOXhKN9yVVh5PkYwFylyyNO+qdsn1N1kQyzVg14da3YHGlk4l9bVcIj9AM0RXENYC6QCGawH/FnF8tLruxC9eM/WuGWU/byM9oOkFJ7Q89NamZlliEGoQnKwxqWdFG+w5JMVQ9xP9KZPN1qf0Qkup2OCRjjGJRKr2k2KiwOYCor+QX/AlG1zWcAQCkgPnyJHOKww66u5t+9iqDA9XJyCHjyW2Qdd0CjE1TOWASCJT3JhmIUCIut26Eo/q6hjy587LxYBqIfUW3NuUb6dEaoHqnvTSHwokmIu4rj2wnT4+MV+yxtKuzXwClUxJrfBeQQ6gLula/BSMm5WO3CHSid4gub09xyrWiDGhKYEHf1dK9OfFviNyS7C/gcqvzwiKMhx4vrK8gapWYjZlpQh3hOE71MRAKTIVcsh853IZU/MNVuAwO2+s/oG8EtlH8S530Mb9jZkMcd/VRfbffq7b0OrMC6NcOtfnMb+yhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(2616005)(6512007)(6506007)(26005)(52116002)(6666004)(5660300002)(8936002)(2906002)(103116003)(36756003)(86362001)(66556008)(66476007)(66946007)(6486002)(508600001)(8676002)(4326008)(316002)(1076003)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJWr2rCp/6nbhxokw1fi3xTj3mKxFhkd1/I1mAHTHLQgobhhv5BCMtvecqlA?=
 =?us-ascii?Q?KOWRFfGnz6zpO6pr+G4QQLnjB6dT1T0azcSZEKs/exLwEexIidGi/LkRCEOP?=
 =?us-ascii?Q?QObfC0Lr121LMFT8iFtvGuihWWCImUitRBoi/IAt41rERC+55xM0ywqbuvJR?=
 =?us-ascii?Q?ctPecAKA3ZiNmlD5EIpHUW3KRsgZ2/tDt9dsWahgwgbQp0ddR/kqO4ILSasg?=
 =?us-ascii?Q?xcInmOrCRMWzkPZGQdgQXwkfC4v1Oqm4yaAE5OGwI5tYFTQOhmBz8cLfG7LE?=
 =?us-ascii?Q?2gRGofOyso/zZzK+IapaylCEK/1iDGVoz5le+htzWrE7wCa7nPkTj9yPD2XG?=
 =?us-ascii?Q?YaxohCa9vw5i7Nxn8InddddOLKNRAPoPZczFO9iHUzaukCfQZ4CDiiY9TO4P?=
 =?us-ascii?Q?9flRNgOMeT+30LsuerqipQOp/e6dOP5Oqrv+XcExNdhn8liZGP0wdLbvfYf7?=
 =?us-ascii?Q?nf9gSuC1YcfXToUpNZcgMfMI2RQyzyRZPbsh/3v+PdSLshm13glSe/1n4MSg?=
 =?us-ascii?Q?Z4y0I4pEuegEzrH51bSyHJKaoduHxnCCk2em2QzQ/HuJrFNDRxh1Ij0qRdsO?=
 =?us-ascii?Q?Px1mYm+P+84MroWYtIpMxNRh1GyKc1DkXGW79xmQA2cVUCqhIrgTbTKQW79E?=
 =?us-ascii?Q?ilj5BO3kG1u+Eqxqd/9RKNRi3FklKLyLF2E4kxrF07LtJGjaOyLijysO+etc?=
 =?us-ascii?Q?xxOvpLKnXJlR8dWPPGA7Y2mJqCMZ5au94TRKGC2rpu9PU0DEmZsBv/PnvzMN?=
 =?us-ascii?Q?hccRoEAE4j2yKbcVQuJ35+2EQ4ySFvAJWw4LqtDE1nfiSmdrw74Gr3puYB/z?=
 =?us-ascii?Q?kDUMi8/FyUBpHKaGpwKzdDR1DybO14X4nJUNH40OjlZrk6Qcikwg9Uzsfhs5?=
 =?us-ascii?Q?UNY/7tdnJ//jOM2+AVssLtBUW+0+p18//1p4CDCxHV7d9adwkUKMbpRDfYmT?=
 =?us-ascii?Q?wqpe8fWYct8zTNcWxHby2cjjTwuZlbXtdufBnNZGm6WjkD8Aa188aD4xu6WD?=
 =?us-ascii?Q?gYuwv4IsHYrmMwyUiMVj09fBJoRWiPskpmQX7XO9qlLY/xqZCL6B9tZAvRvT?=
 =?us-ascii?Q?jw8Q3BiFb9lcJyKg/dsRWCmLLE1foO3Hwv7gpB1Cw8QxTqNe1bH1+WoDjbI9?=
 =?us-ascii?Q?83qqynqWDPjTi4ypZp1mzRCyzD4J4Gi0LphhZ8ntoDE40Z3Oxdq0gf+otZRA?=
 =?us-ascii?Q?jQoDkE2dSepeI+JynUrPMovCHnUMiwdgyJSMEBAL/jax9ntLWLtAGx7HC/rV?=
 =?us-ascii?Q?qKR1PZafgxPnJVh1eONTDAh3e5YhqQcnH0Zifq2domLsKLw0euhaL2J3YiKa?=
 =?us-ascii?Q?UyF4ibeauBUYApfMrYbDY2A0mHo1FQ6jOHAuIsqKvgdzLXhK9cbS0CeGFNcD?=
 =?us-ascii?Q?3xn9vyHf7fiucUTOyWQYOp9b3dOSJaojJ7+scIHoQr3W+KR3GBxed2sMo4Pq?=
 =?us-ascii?Q?s127iSibLpZ3UEJ6O/D9x8shIaHwy7aqxIycnI+6KqTwTGrHqwRJ0o6rELhC?=
 =?us-ascii?Q?lFs3Q9STlFuEK5+DM6BePowT1AibhRYybX5agXWm+f/gMA+Lv0YRsbuME+Sh?=
 =?us-ascii?Q?Lp8zlnpin/PoXpORbX4jsCNMyemn92a3+BMNJy7pbvHgJZ5h2pZX4uJ9l5HY?=
 =?us-ascii?Q?htkn7aLEEgdKiMFb48qtrEFWJlqqc+iaZhnFtoCkzv/wbD9Ma8D075BvkBJW?=
 =?us-ascii?Q?ai+IK73DNgqIIRJHOwIos+nAMGmoAxGVpBJ3ktFH3ABrTRl2j0mQ9xoRqhDx?=
 =?us-ascii?Q?FPgfZI4E1YAFCIUVohRQSCC8hwL+EIk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e9a72c-417d-4c4f-2b45-08da3333ecc2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:52:13.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQffhU8X6PhHJjtnY+MxlqA85xiLi5LSQh4kMKQZEb7lOWvG0LK6CBiAVfVgG38dTbkGQX2EOTQEfGLNxZ2TZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110044
X-Proofpoint-GUID: VqOlTnQm8YrdRti7f9Vl4rkwz-awXyJg
X-Proofpoint-ORIG-GUID: VqOlTnQm8YrdRti7f9Vl4rkwz-awXyJg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
locklessly. We still need kernfs_notify_lock for consumers (kernfs_notify\
_workfn) because there can be multiple concurrent work items.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c       | 47 ++++++++++++++++++------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 796f27333846..a8d8a9114b51 100644
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
 
 /*
  * Raw deref RCU protected kn->attr.open.
@@ -897,18 +895,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -964,12 +960,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -980,14 +978,9 @@ void kernfs_notify(struct kernfs_node *kn)
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
index 13f54f078a52..2dd9c8df0f4f 100644
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

