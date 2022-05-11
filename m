Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1903522FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiEKJyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiEKJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E395F25F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:52:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8os36003160;
        Wed, 11 May 2022 09:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vTf9fJxmP+bRMy17EqHu7rO0MwTklTjTk5ffFt5F7e8=;
 b=SF4p9H7YnF9edSU1gO6a8xW7ASmKJq6DZqKv0Zw2+9YCRuK9wj/snJuy2Vnupr+H6iNE
 ZHwfYLbRgJjZz73+aeg3grPo+ItTq7EicIee+3QK0kxcvh9wFwdBhlspZlGXwsavmX5Z
 1aqctR1aQkeuG06g3tqitAQiGDeJRnft8PArxutq5cYamx7s2+qoXymJPI9vLUSkP/NH
 CCENkPeF/SD7DtLtYai4gKvT1d0diKnKq4zEAmZOTUjjINZI+yqMk1ZXnfpnUs2HcLgE
 4kIopxy7QuWkgFSUNSbKamYUDs7FCTdH4BSXCSxBAPUm7SXqs0b91KVe94C2OHojMqNM VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04g5b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9pRSX030682;
        Wed, 11 May 2022 09:52:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73dvab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAi9xCZUWGa842OWBCTVYY5HE1FRglAdt9RxACAujlKDT2EpfxSZqHQiUY4YAHCAxxRtj3N2tv7wOMdzPz0j7hfLGuVAT4qt9obE8iHV+Xq+zOoRLic8hVzmtgu0BDyLH5hvHR3axJj++xcbrhLOHErf2+c7olOF6Fz9dIjJMF9UgvD/F+vT0eYO9jMsk58ABUQGtHJTm0/DutXIcTdiO1NTBIClMlRDZllZeafD6A8w7rF7MwqapsLuuLjpGa+iz0GNJ7ppt1BZ+j0ddxeHA4mzY/56+FKlOigKwJI7wWobVdt9AQnDHRuqECOMkkFg70cVwbXnEfOtmVJZmrkZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTf9fJxmP+bRMy17EqHu7rO0MwTklTjTk5ffFt5F7e8=;
 b=mpAie4CftIqKU5WZKNFeQt7mqtup/VVlcbeb8VPzegFohY5jWVTqcONKm2aKA2Zpf0nqnmm1jHx4MpQMQ2/8hiX8QVOMFGWgvlf1LFbGvxHgPhiv6AH36A7QaVoDh1s3kIItJd4qlJUNJNiGbSWjVbPS8gx34rLC0t8zi5X7G/EmJEe04SngrMNv77gg20fhYHj5K6HkjtlxClI41mPXCjjmFumW9nPYYpGAkfUAwrPqDrQEEg6yK2BCsaIxzimNaDKxUxgfdqshuOzoUo0OSKR4L6XEj2wnGDq5h8YFthKYo7QmOq+zuEt4B6IKvMguZ6PAn2Wpwgou6rUjbPFv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTf9fJxmP+bRMy17EqHu7rO0MwTklTjTk5ffFt5F7e8=;
 b=mzoSvYmPZ8WKHwoqGpZIoFvW4y8hGDdTsRhdXnHIcIYHq7prUWjNaU/+nhbHGBsxfox9y1xXxs+gNEQdAHlmONq/CDJqa78AgI7NWZlf4TJ3FmZ+ia7Y8zDQKSo+EYDTollDv9gDB+OsfxlQMux53wdJNsh6KtJXrWuq9TkD7Jc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 09:52:16 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:52:15 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Wed, 11 May 2022 19:51:56 +1000
Message-Id: <20220511095157.478522-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f65c4cf-ba66-4bc0-a147-08da3333eddb
X-MS-TrafficTypeDiagnostic: PH7PR10MB6178:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB6178B4236BDB11BE657CE5A4B0C89@PH7PR10MB6178.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyeimxmGbr9AATuO/LY05F8A7Pcf5HojpviSixf1kPKwSU9py4we1GsuJjn+yiI2eIkBNGA+pVdZL6gko0KX0xnhaTp/ME+r492uA1KyGodH+KXRIbyWf6n4GZGVt7KVZo/wLXAP67C4O7G4WA5YF9p72gwb6U45PN9qj4J6GamnIZQdf1FzwLb8qB0vZSwVYSAVt+TojrxtbZasW0SGZC+WbKJBFZ/jUtxJJ3/fk1nwTN5s9Q9byXFo2WKc/K/pYSgiv81zwczWKLzBuAXc8NoAqbOoCmbcAQMg+13taXzf+sBR8HElxRtGCbhrPF1YGlDPPsbFngwUaHljGPzozHuknbwIxlMDMmz9LFx9zxwYACBRKCvXQ7BssT0RSXYIgh0iJz1otMuFqNcAYsUIDy+zCZDoqFzXCF2VXz6lL8aZPIP8vMJnhy0/5M4fYlpQvBKjoWOXeyiYdCeiagIuYIP0uES8wTyunyQwufE3bKUTgkEFQwhQ4nzxIbl0DP7+Z/wKrh6BnQ0/ihro1sR8pDwbUlUlpnX+jiSi1Qrl429MBTj6hX22W0mZBGaNJ4wd6QOk06egkvOMyUYpW3j7jlLXIlO3XvE/Q0BMNWVxMxfnR/LAaAN1L75fl/Nj2bJUG6unOWWMb56r04J1wA+ODJLS0Yqyvy+fPnBgFJ8rK1gxHL+rT47cEh6ncCyFRLl8cC2L0ghm9pw9bphjfXkLiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6486002)(103116003)(86362001)(5660300002)(52116002)(508600001)(6506007)(2906002)(8936002)(38350700002)(83380400001)(6512007)(38100700002)(26005)(2616005)(1076003)(186003)(316002)(36756003)(66556008)(4326008)(8676002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SDNBSSXSYjDHkO/GGTgSJucS8PxB+c6hsA91MHwVdoGzkNl0+Xeax8m7Dq2?=
 =?us-ascii?Q?Z2WP2odQslLiXt75LrHU7XS5DNHkIsq1bBIFOhiBzMVI9eL8tPuYAUYpMmJb?=
 =?us-ascii?Q?hhwvMl2FY6Ri6d8crEWf5n9ERs5TYn8dtn/5BtSesN+K7nUALmZHn1GAwO6l?=
 =?us-ascii?Q?qh3epF5Dbz6oFDRBXM8Qf6Za2xaRV4Tygu+rjqqjiLc39dC+5RgtybXNS7jk?=
 =?us-ascii?Q?0cCF0ald3ZRwtFS6HCa5CW0mJBynWkRDCBtU/TrbADQjLksi6L/RuMEKOqff?=
 =?us-ascii?Q?O9cRpl1B2Pffp3KNpo3HzjrctltjrgTFkreZ5HLpRGsQ3JPs5ZER4wZTUtij?=
 =?us-ascii?Q?YmcGujSAiBLwk2R5QzrVSdzoCfyNU5iQMx2oI27C0v+i7CflQrozBG06aiDl?=
 =?us-ascii?Q?FuYLsBPOkzvpPXFdKT55OTxf8Sv+NNWCbGQIl5NTWbxk2bey9JgDpculluv2?=
 =?us-ascii?Q?Zqsz3k/JCFe/pClCLrr5ZOZ5wwu/HcbDOC0L9KS2AZj9UAA6WYgXkkyaylfY?=
 =?us-ascii?Q?o+fYgkzZpJHl518SKLbkpp6o+uKTJanA9niLa6nT8DfrekjQTxOJWldE+Jyr?=
 =?us-ascii?Q?LHp2/khuFrn3ZpA1Lf5N48AM66ovYNDuWJjl8TuJw+E0MSqqZNRpr+D4/9AS?=
 =?us-ascii?Q?VY1i5MFzSel76mSHUTGRgYdGJc7X+Dfpmj8uHTU+xIdor0m7yqdYEeAZYXA+?=
 =?us-ascii?Q?OwriOFtZgYvU8WpoYq47YfcwKgaZ7UPjzqrrVhm78cVazUQXwzKRAHJ3llik?=
 =?us-ascii?Q?AwWo35PCgXyhTFbNPS0OOYTHuEwVTdByfy4QXiN83TwrvNSnaIkO1zRlygRD?=
 =?us-ascii?Q?hSJJRl84DrHHMqZgfOrhTpkpVP7+7lyLvE/zy6jQ1rpypZTfjybRu816D61v?=
 =?us-ascii?Q?onx/hDWJsAEgv775F2ZNxsNpRE+LaQAaRe7bdrY6VdjdhZ0accsCxhX8KjQq?=
 =?us-ascii?Q?YNxUKuwD6KkxzdfR0sUdjAYxCItxLl+Arv99UI3VKFOo/3s6Gk6V9s6arUVx?=
 =?us-ascii?Q?R6yx81oo/vjxLYdb5rQQhKIRPjD4IAFjNUPLXmNo3czEfePSa+M5N8Lynuuj?=
 =?us-ascii?Q?k+mjN0dTJfYHWm8Y1+GH5MbV0LK/Tl2Tup1/Nm8WY6o8/tkUC0f5Hk0GjTJP?=
 =?us-ascii?Q?PimKbc58ULQhMGFzLsfltBz3zMwPbmzvYV/fPHNw0RwgVVviQi1dhCjnW4Wt?=
 =?us-ascii?Q?XSHmDef+btWWHYbaAHf3cbJMEcRoxgyCqSXIgV3BcP1PyPFpacMPxLG2mZbg?=
 =?us-ascii?Q?YCLeATp3WHcKtba6uQfIrLiD5MOTQ2b6ImquHGFDK+88uXABP1zUgcIaVN/4?=
 =?us-ascii?Q?7uOAAOvzHO0bUYhgge+82+qNp53QxgEhPbhMu9yqxh5FeSpDuLNT7RhTQUa2?=
 =?us-ascii?Q?IfiBEkuzlyKrX8/hy3c8rMkP/G1vMFb1gkOza9TjG2wwagOxErh9535J18GE?=
 =?us-ascii?Q?Ux+nzOpERgJVTM6sgA4Wu4+t3NPJSPd/1L8wDwagdLfdBQwfdO6NOsxZrLNb?=
 =?us-ascii?Q?ceknExD/UsVCKc84lOSrmEWF/5rh+BC7Lmt9CemXNMZZYmdDxajhNqpLbYRm?=
 =?us-ascii?Q?enJeKV77wHe1PaqUhhvp1GSvQFO20Fb2LiZmV5e1QoETDQsoFutoa6ipF/Fh?=
 =?us-ascii?Q?Jwxvi1zoda9oFx4Kl3hSI/LAhVcqotTZ46mGgban+PCQjVkIJ0bP6hi5dZ1r?=
 =?us-ascii?Q?Zlix5UpHZZBzJw2R9aIXRsGrS+Lr5Q6fcW8ooGObCxI7tmoGejMgYT8FQtgL?=
 =?us-ascii?Q?e2KV+AJLGj4o9r+62s2E3k6vVSjZ2gc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f65c4cf-ba66-4bc0-a147-08da3333eddb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:52:15.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlNX+f0ARvscWpaXNFNIGOmItcOZDEausDQuY6l3OHCHcWEfG60MGm/X8ImmFvijk4uiaifGat40BXW7LtPctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=963
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110044
X-Proofpoint-GUID: Zu7m2nVPGmw5G1uN9f4w222JerbGIyX0
X-Proofpoint-ORIG-GUID: Zu7m2nVPGmw5G1uN9f4w222JerbGIyX0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c | 50 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index a8d8a9114b51..9000c85ce1e1 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -49,6 +49,22 @@ struct kernfs_open_node {
 
 static LLIST_HEAD(kernfs_notify_list);
 
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
 /*
  * Raw deref RCU protected kn->attr.open.
  * If both @of->list and @kn->attr.open->files are non empty, we can safely
@@ -79,7 +95,7 @@ kernfs_deref_on_raw(struct kernfs_open_file *of, struct kernfs_node *kn)
 static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
-					 lockdep_is_held(&kernfs_open_file_mutex));
+				 lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 /*
@@ -90,7 +106,7 @@ static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn
 static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_check(kn->attr.open,
-				      lockdep_is_held(&kernfs_open_file_mutex));
+				 lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -569,19 +585,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_on_protected(kn);
 
 	if (on) {
 		list_add_tail(&of->list, &on->files);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return 0;
 	} else {
 		/* not there, initialize a new one */
 		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
 		if (!new_on) {
-			mutex_unlock(&kernfs_open_file_mutex);
+			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
 		atomic_set(&new_on->event, 1);
@@ -590,7 +607,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -612,12 +629,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_on_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -629,7 +647,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -771,7 +789,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -788,11 +806,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
 
 	kernfs_unlink_open_file(kn, of);
@@ -807,6 +826,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -822,10 +842,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_check_on_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -839,7 +859,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

