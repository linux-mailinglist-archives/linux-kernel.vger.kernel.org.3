Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA24FAB89
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbiDJCkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbiDJCj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:39:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31218361
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239F70Ls028689;
        Sun, 10 Apr 2022 02:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qD4t3w6alfJ01hnRfgjEsyYeuoRlfKzRDivwA7WzonQ=;
 b=jO5O7FhH390flX2IakQT06YDmb/trzp6rbmEA65STFy4405XXFllp/LfkWKMgjhZ731x
 w2p3iiDbJ+PHV20OdHTflwpBPEf3lKyFpOvodvAZlu3RF9dQnkBjIt41p81afGE54AR3
 mbSKReRhKqZhPlXh3rc6dU1Gh6iuG6bgJmbJjYE6r8r29czBILAQAWpbyBJm21C/vJza
 oYq7+jNZ5EovmCnedpwuOUzsMQEA7oMifDfK1e/6fyQZXwdUTRVPFC3KqVldFUgfSYNO
 Gnmw5a7+wyyRBFO99vgnKr9m++dtdwAPbDT0ZfDBbQmYdAtHvhxEO7euQW7AGY8QQcA8 cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs0yqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2VFA6034326;
        Sun, 10 Apr 2022 02:37:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0gmts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLOIS14vkyR8TwD9HqP/+v7dlqM4tRLf+WPUhVhUqvqKqotUB7KEPrffwBZZKUE0buDuVZ1Itz9jxt2lJp98ZTdi07McqjsLIZkjraIVaEVfPFSiNVlSUbpZp8OMz2Mz4tzDljKut87jkPurcitTpbc7wyn1oSniZQGPZp3Iy5FfREoFi02pjXiS3AJTPpjbFgmkn56s9oivWS2ufmt32694nloU2gteIfHJgUiHooQQlk8laU88gW2ERWjWL9xC43biV8m9FNXy2/5fzdC+2eWpwtsiJ6oOvWQlRcYCleFo40u8jEWNxgBjrA7QXOHJjvrJogtixAlESHGkzdxAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD4t3w6alfJ01hnRfgjEsyYeuoRlfKzRDivwA7WzonQ=;
 b=fqXGoJBI0HK3Vjm0aYY4Py9sjysn/VlnlmyN20ofR5Hh3+1nrKtyWvZylAtaJh8BglAuvmZukqO2gbwJxb4AGwjYIuQisiuQ4VNJ5bWfBW7ZLzFc5yXEHTCNrmLTE8shcwt7C7gdgUZh4NVIDE8VR4KoVKciibZ6W/ahMub83bV+xhidqzryz6u3iGNUG7lTF7wYERTDWG5scqUuB+qbR6trw5WJrJGhvzaCtB1QjA7ez4MRixntqA2QZw2XudqchAPe8nK0a1yzwbtDCB4RC6e/O78MfKhjrQe2wz2zwOKr984X/h2aSmaXFL1+CxC2tXnSFVZmnxCuC7eNFQvWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD4t3w6alfJ01hnRfgjEsyYeuoRlfKzRDivwA7WzonQ=;
 b=DAqRJtlIKA62aHa+eYWtD7en5caDxzrpapQAqhdx2s0HXecis9eENLBp2zcxQiypkgHj0tGioZhj/92jQbxfYd9ql8Rgj4G6ZCLe9Wv9VVKcSoRAYjotQE9mfYApqxjjJahxlN78MUOeE6QNzgiwv3dIi4K/Yb5rKpQcSe+GCyI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:41 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:41 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/10] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Sun, 10 Apr 2022 12:37:13 +1000
Message-Id: <20220410023719.1752460-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f60a2418-57ee-4fc4-e983-08da1a9b1577
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238D0FA545A567B1256BE84B0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rm3KNwJwgZ0uT4LSHrui8BAaqoOLrYPJmiPNdlY0d9ccP8hEkPx/2uhMeSo9/8ykHUFVg1ctXOV4P3s2/IheJncoxmmXeksHeGDWjhl6TmorS/IU9gX3zwVfyZERaeRfkA877ARLxmYC/TJedXLF610+ydwJeOGdHetxfV/efvVvFtBVoA7IIAFzRcZuitQl/3josRUeJKCWEx66ZV06QvnTBsH5AlfAt8iEgRWDqk529q2ufJuX3hFNRE4VZTkoaqkz3iHedB7SZOBOYhUSuumMRJQi4sVOBopD/FFHgrV6HkNSkEGXAsINWJi7LAzLU8xcHEPv4Hp7H6K2iBlEtwiIMXKLeXFxdiSmNwCMkdQJmqBCWoJVtOpMXlcvs1WOdoLKALgn+6/daupSXa4/FAjA6xLJ70l5UHa/AuEJ2RlsrQSjZO878KWwSNK2o15LhmWaFxGdhsHoh5GhKswcYjXpD9SHmiuZk5uE4chJ9yfbbDDi/6WyZS0yH+u3KC9M6X7KbD28nNzskJJZg0SQ3ZjwqoX0q/Z1n/Md5+FgtEPEB1pRP0FuxBjOuojiYz+A24n97oG3CemySanxecvKvGSg3W5K1MTpRLoMx+W6sc3zMCe3olQyQiFecj79PAvMUIeIhRi3CL9rHVW9kc+Qdxdex4ylZMUEDVek2nrx6BLiOW2RmTVEOP0Cgo3s2JDejbr2YdERC3QFIlZ3WJXJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAz6FeEJ3A2knnd0PPAerO58ubHx9yo7Q/K4FNWPJWQhddmRpZLUVN2nBVwp?=
 =?us-ascii?Q?2g+PTbNMTGJYfFsjCOJeSN8qhK37GGXCNmY6MoiXPFf7sTiePaOZffBf+8ti?=
 =?us-ascii?Q?GnZLcm9tAjqYYuOLYNGGxidCl/ZLX12khkroPWVKEC47qzqvcnCJxQboo0lk?=
 =?us-ascii?Q?FPew8w1KaaAtgFxIiRA4Ucjw0VtVRrgadn6jyDDVzm5J6v5M/CWS4RbNolVz?=
 =?us-ascii?Q?GPhOlg4r9LSSOXa0AoE7jjLLOGdwgf2f0huHZ+vC0+XxVVnx1d8dpAYDfsC6?=
 =?us-ascii?Q?Vp3By5jEoa1fbWs9bx2wkE6o8BXVZEo6kEWyljUmewo1C3QswokcYzcApm3Y?=
 =?us-ascii?Q?RiLusE9luHsQYskNka1scIWStrUddKowdcPH0EMzDJXdbX8UbMdfhH3IG/7o?=
 =?us-ascii?Q?8SBxRhqJMvqEaHLv0FOMLAkqXAPQ8oeujiZAE7DEPD2QTHIKb1lFJQhVbS+0?=
 =?us-ascii?Q?65dTfBIvGKB7KUFfS91wE23sGJSYp2u2GmdVrPgppD6qe0KBccl+rrPXniXp?=
 =?us-ascii?Q?7eJiGRRpF0qWEvUBN/x2/XtfXp3TowKliiRpF87MdaY044a2Cj8d1hbfuhFM?=
 =?us-ascii?Q?H+KiqCUpnfQ8P8Pre7ujsFZFBx6biFwW2SrbNH3GBn20HQ5vgZlFmEgr52jK?=
 =?us-ascii?Q?E8An8Mjx23Q+vG+lPiMokoKE5wbasINgOgyW2T9vPeFzgrjEMjf/XEFR3XEA?=
 =?us-ascii?Q?poyouRQwUudE2fh5WEI9cx8s2g1A2Wto+Y4ALZQBUcu5ij2LlZO7G61e3tJo?=
 =?us-ascii?Q?5dIXyVshbtT8A5s3G0UeyOt1yLuJfTFOUS+AleIPpY+urU891JCddBKHu5E3?=
 =?us-ascii?Q?6+fFQHKgMnlrLwCeTjZ7j2eo9TtvpPQ5ml/6CobRIk+cp3u50ktwPbRMsxPw?=
 =?us-ascii?Q?llHcsK1VSxhR7Vlrzg8Yyv3vmSSz+XSL/hTHmO48JXH/zu0g/f/qN8GW28v7?=
 =?us-ascii?Q?ZgM0XZ8l7foLqkqaz4rUjJrJ31K0t/ProCz+ukIxYcRtmqdDVXvt+b+NfiSw?=
 =?us-ascii?Q?Ev2zMe54XhOEC0s1//5TMn7NX1IVI5/urNzTVpqMKyv3PLJkyytYFBEZ6VbL?=
 =?us-ascii?Q?/XWQ7LoR0mYq+KauwR6zxRk8NDGZnVsg9ZeGPwa8UCwa/Frv8M2kOavMnyjd?=
 =?us-ascii?Q?x6+lYvSyUv32fwFxCoxnrhZfbKvsSA0lgUqanu4Il+uIakyMFWKcofhWKSlK?=
 =?us-ascii?Q?bWMwa2QXolrjSG+M4oWxJfH1XNty0UVaPR3w2GJdTuURXLcxkkdEM0tGHdro?=
 =?us-ascii?Q?KAYdjOvRhY0oguj6AC6lnpZXuB4VYEVXwyuTccPSQsw70c5UvT/16RVuu/2t?=
 =?us-ascii?Q?/sKgm/jDefwmHJB2DM5KB9tClyloVStYYlsaQB/duTOrUgZGOWwlccV8xeDC?=
 =?us-ascii?Q?qM8PR//1ou298taHYXklZGtKrvkFXMWRaXndRiqClXMEpt9G+mMbSQt2iTHQ?=
 =?us-ascii?Q?mwaXJiB7yfIeF1mfUdMdtc1Jameq+ksvRDTMqVB4DdjN9C+TN5x8VTaLCyeU?=
 =?us-ascii?Q?H4JrsbeUGwVq92BgtC7TL0My7MdzktyBVEuOZt23NJN7fP5xa1XdVRIqNwyg?=
 =?us-ascii?Q?5eGD6gBJn3GXuV9fnLDQelRN5rkozeNU9s7hyTpHe9mHvrfKCRr4m3PzEbcY?=
 =?us-ascii?Q?U+a61cJyWr9ZOaA09YZF6hdOaizbwlFsUru7LxO/9StcsMz29Mm3kYrWpWH8?=
 =?us-ascii?Q?HNwqotHKgbZw3zxEyUTWEThmtWNwcgKCiUb0RjyQVMgSqB/vEQGoOi479oNY?=
 =?us-ascii?Q?XwJHBNImpQyLY7/mEkB2dsmwjHKWJw0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60a2418-57ee-4fc4-e983-08da1a9b1577
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:41.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j17eGAn7PNOHmgu2N5aD5AtPa+Gmc0KrMhOtFAJ1FCB6fPV3PsrDJZ2cN9IlIH88yjMkCaDQZsFT+DXM8FV+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: hOogNOBmlsjW35n5_E6HH5I2Ski0F-8t
X-Proofpoint-GUID: hOogNOBmlsjW35n5_E6HH5I2Ski0F-8t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c89220dcfdc1..214b48d59148 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -47,6 +47,22 @@ struct kernfs_open_node {
 #define attribute_to_node(ptr, type, member)	\
 	container_of(ptr, type, member)
 
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_file_mutex;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 static DEFINE_SPINLOCK(kernfs_notify_lock);
 static LLIST_HEAD(kernfs_notify_list);
 
@@ -520,8 +536,9 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	/**
 	 * ->attr.open changes under kernfs_open_file_mutex so we don't
@@ -531,13 +548,13 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				   lockdep_is_held(&kernfs_open_file_mutex));
 	if (on) {
 		list_add_tail(&of->list, &on->files);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return 0;
 	} else {
 		/* not there, initialize a new one and retry */
 		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
 		if (!new_on) {
-			mutex_unlock(&kernfs_open_file_mutex);
+			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
 		atomic_set(&new_on->event, 1);
@@ -546,7 +563,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -567,12 +584,13 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
 	/* ->attr.open NULL means there are no more open files */
 	if (rcu_dereference_raw(kn->attr.open) == NULL)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = rcu_dereference_protected(kn->attr.open,
 				       lockdep_is_held(&kernfs_open_file_mutex));
@@ -589,7 +607,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 		rcu_assign_pointer(kn->attr.open, NULL);
 		kfree_rcu(on, rcu_head);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -731,7 +749,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -748,11 +766,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -767,6 +786,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -774,7 +794,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (rcu_dereference_raw(kn->attr.open) == NULL)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = rcu_dereference_check(kn->attr.open,
 				   lockdep_is_held(&kernfs_open_file_mutex));
 	if (!on) {
@@ -792,7 +812,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

