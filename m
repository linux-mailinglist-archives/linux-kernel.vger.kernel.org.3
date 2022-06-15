Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18B54BF96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345693AbiFOCLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345669AbiFOCLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:11:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E340909
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:11:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0SpYs002108;
        Wed, 15 Jun 2022 02:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZUOcE7tzIMGoYsaIMuYmLq7cWaWMhxugw+Ja3iy52Ds=;
 b=s2Yc72BzPZXlCB/6Dp5yH9G7fitE1G21NT+kTZvb0IyPpYFd5mtlTIFTdmb/+LPqSN+P
 R/9kwq/RfNysYAPo2q6ZKnF9KJswNLRsWY/rLc4I45weWEL01owlJdRqSAMCrmdbX9zz
 wu1IQhS6IfZA39D1UaWSwFshg1jZhHKZ/Jc3t6zDIspIStQk69G81WdTwWgM6g6vKGqy
 HiJfCoYTvuscAyCgT4qFj5dRSDajcgoEgoohNsBwvcwuQ+iKre241vDdeqSEjNfGsOWw
 xj/pk2oDGzDsFR8L8mQjDoq+jRtxhJM1pRWURYvJpgvqL+JVzjKzKoKDv8fblFWaKwJU 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcqahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F29wWq003813;
        Wed, 15 Jun 2022 02:11:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25a1g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSeNcYfD118y6U8ar/MF+KvevZtk5zdet5+hhruCWPbPhzWtPyCciYSM0dw4vZs7pM5BbBuTF5eM6VfFkKtWMZrYAeNdr2N8hN0ojP3fZhMxuBEUjWLPwj6Ufv5s7XzsEaCi+WtGllvbl81QVFhhDaEgnuB3drOTmXwcEt+fr7ZLzXYD+3OdkhuO75qx9x5KiUjLQo/zlJPQicHZPQFo1FJjoNICPtEf3ZjuFaNYS+3SBxWZWiQMjmCsG81K2REEmNzr1EeaXfW9m4szv4RLkqIUi7R6AgKCX3dgM/JgLU9HWK/3i5QDfL/Mr8YTahi3iwjbGEuL8MdiVZ84VvScng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUOcE7tzIMGoYsaIMuYmLq7cWaWMhxugw+Ja3iy52Ds=;
 b=h2O6HyiS+vfHxBxLvmWVIh4XhZQTP0Pu4jMYhcMGqPPy+W1vBqATyqdTX+qGI7RDlBpnJMJAgLHoC5rSCo/Zb3e7cggQdAM8r8CZVRY050ME4mHTPJ2HscCcDb7nzyQfsmC1WHDL6Io2WLwogXWYrfq8e/Iu6y8qAGWQM2/iv+7CZcx2UHKIR5VRN8BVVy3By4XZ9DE7a8eI52tvSLcvSf63RIiKURPKN9K9mubPeQkQE555NhWrHQcPKYH6gSJJGRAUCpjB4XZ3IAHoyYTYfHgSpI8YoJTelONnrGKBN6+VLiQqxtoLiSgqvm9vhbARMKz0HPp1JCdOGyRLtI1n1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUOcE7tzIMGoYsaIMuYmLq7cWaWMhxugw+Ja3iy52Ds=;
 b=Z0eZ6KSY7CEQ1qa3zhhNpSCjIHUK32lgchpNeJmatD2TEwyL/6XEG26BB0dpFyQHr+ydbex6H0/e9tkC8iWZR47m2Lq3Ww5qW1s26rttHyhW30brgW4YMWcbdeACOTQEcYWVw/24nRXadk0Zk0+81zx7bC6uZfuTB/LX3L4wNso=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH2PR10MB3800.namprd10.prod.outlook.com (2603:10b6:610:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 02:11:18 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 02:11:18 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Wed, 15 Jun 2022 12:10:58 +1000
Message-Id: <20220615021059.862643-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe8445cf-ed40-449f-49b3-08da4e745532
X-MS-TrafficTypeDiagnostic: CH2PR10MB3800:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3800187990554C3D7BDC2721B0AD9@CH2PR10MB3800.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUe0QUa4G4yeIf3qNAxr98LBYw3yPeUOUYg5Zn7eb1URRRcZ832B30R6ITNSwv6Y654JxQPQXIaBvOITqHoLkXfOgAyPFS+93HPrU3uG7vsfYT3S94mYQTIZKObCUbopmnYlBr1ctBQORhtxnkpRctH+FhzvFIcv3iLaLigIO6WEReksSrlgFBvK+ft7wUjVAZuyAuvh+Qnwy/92sCX+4JNCjqwdbzh5jna+7KBx1lGLRulZeRftKoH05GTQ3vIdd/unIGDnpCIlylEgc/CiJK+f6WmDl4N3Lqm3aiv17a5SLrtCH0lIGxMFEoXL2gslOWnMrrjPbeDKEqsihBtnBzxFqkuu21Zx71QaaLGf9GmluKvGAE4QP4pAq+b1Ww6WDt2Ihla17kh1eFz9QmOjSMMEOmz01bK/iC/fhCNXjkIqFtuAzu/6u7HWQTx6JvL/qHefQ6M7/eU51g1cm4BewuH99YoBAznKny1drJTDKwMLdPGq2fsNy1Rz3wAr+MNB002rtrPPhEQPpD1h0BNsA6BwJ+0aVkDFWJw75nDN5If/Ids/Evm9W1PXiNXc20Wp32cNOvtP5I8AGgFvOL+NG2SJp29Zz2VALbaah/mJMDY36PZgoTKnTYoJXU7BZ7SB52xTpBS2ToEzO36vELypC77D3hSdLH0sVkW8Q0ZINUh8aK/wsuri3RhEKbF8v44PIVUY2WU1jYM1e2gRqRTvog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6666004)(86362001)(38100700002)(5660300002)(1076003)(508600001)(2616005)(38350700002)(8936002)(6486002)(4326008)(8676002)(66946007)(66476007)(316002)(66556008)(83380400001)(26005)(36756003)(2906002)(52116002)(103116003)(186003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQGCB7cXFPYv1FdLaD/017nMkOyfWcX4PbWcVQF22xmOwDfmb/0gjCAQw7pv?=
 =?us-ascii?Q?GzWUZi+0FIr4XQ753Bi0WANtkq3bP6C7fVFrk7TEcySLEI2E26mp9c7xZI6A?=
 =?us-ascii?Q?ArfiitM9QjhtjXSwJRPOQws03tpkQaqTMH2S1oI+bjUG3YqRdwuttebDqHo0?=
 =?us-ascii?Q?i3W1OQfZQP3oY9geOLC87j5zf07UEOrrwXUXUR7OKBV11drgt0Iz/A8HpOyU?=
 =?us-ascii?Q?6/H+9t/y5RhGf4eSZEnOR1eIQjGsJN2upnZl1UfnYpuVjVeSDbNLDba2dSRO?=
 =?us-ascii?Q?uOZ824OIkGb7mVJ+EeSddpHH3CZAobrYIHLddhW6YslR9+yTtwBFTwrs+mPX?=
 =?us-ascii?Q?aTMaLQesAOi7A3Nu90xDjuJVA7JYYK+Ls9JGqvr/x1hEny+KNkvVM5mNUHya?=
 =?us-ascii?Q?5XbnIxcQPnCg4S/Xa3QdDkyJFJx4448opZBXPkzQTLljTdgyAFXwp9upwqKG?=
 =?us-ascii?Q?2CBYfN8HmQFEaAMCtqw9qV1S0tHREUCE8EK+0PEE655nBHnMptSt3olxmVT0?=
 =?us-ascii?Q?SY7l/3quPFcY3bkZMIik00Ac4ByhB96VC9hC4Obx6gvClo3wadso7VSDbE83?=
 =?us-ascii?Q?Ml+cW6/Jm04/Z/zAVTR2RLiYVjYusXLfRYftGhBjPCXczW5v4cheaKQpZNlF?=
 =?us-ascii?Q?H+TqN6uf8zveY5z9QQu8jr5MAK2CwGTbYX2rU1vEaM3GOy25YqVV61gorATX?=
 =?us-ascii?Q?zvhQgxLt4XMqYjHJqh623LXRCiNjMzeP8xtv+0wJBFScJuEwoZkdbnNPrlB4?=
 =?us-ascii?Q?OYfhHesWEIN4C8myzGMvqRCjZ01I9JlNHGdcHifNHWQDpjjMpUuXg9Q94QVC?=
 =?us-ascii?Q?lFfPi/1sD5JNVJFpq2EGfBRuNvD7fUtbOQfLduMbnomZ3wKf6dcGpkxW9VZW?=
 =?us-ascii?Q?sMSFpvbGYyHXlccvVMGL8u4ZNaE3AZ4qnxsBlbBmHCOAy8Q9gZ2nLRe2KrGN?=
 =?us-ascii?Q?o+xYuqnXdbK3I2MQ4Di55BcuD28pIzNwbjyj9NrFh5oFjfQthkaf8PAE5d+P?=
 =?us-ascii?Q?VI2NcmKB+Yq1IjAy963IzVxIGwMLNl6fPH4C150xlNsb3jaxsET98CDPpdlC?=
 =?us-ascii?Q?n00zldRNxgkZ3BoEtmHEDDuZhPxYTjBMMi5mA1aTnLLK80zA9eI6P7Sw9PoV?=
 =?us-ascii?Q?srVlBAAY2wmnSBKZLr7+v5Wr6NucTIhwZs2lCJOiWyOUmMTSzQIOvd1cVrnF?=
 =?us-ascii?Q?vlokLV2KjlZOzMI5QcR9cEDgSlYkgrI8Vu0/wvKpkyreP4D49WWZYczthAUi?=
 =?us-ascii?Q?85xkJ/FbKA5vnTUq7GGL6oeYjL6RnrtLw9zHaNFALDIneWLTCoPIZKouOLJ0?=
 =?us-ascii?Q?/nb5tUTfZpOW2bRS6TC4UCjcTNKoRJFarknbSzzRZqKTDyirzZQvenRa+/cx?=
 =?us-ascii?Q?IO4uhcH7UWis4sFGX8xhWjL7Wh97+nF/rrm0eMBK+0gu/++1sIit5WE9JBIH?=
 =?us-ascii?Q?eTprl9CPvwspVUQQg2Sf9clXEIZaqf8JH3g/J8JKcBSus/X2l3mUVcA36WmF?=
 =?us-ascii?Q?h9J6ymRA5DDENzY8RgbioRRZISt4aEJca9fNco2b9EQo6K8qAPczZWtvJJcs?=
 =?us-ascii?Q?1Sm/aNHBd1MOB1V7N3rf4Lag07zXRilrYYlcSyLgRk95swjG1a/rhW76TVlg?=
 =?us-ascii?Q?Yk0zECBHx8bsAQ7Bj8+BetpygY3LYThS6PAV9nreQSSPptGWR3szGEZpQ3xs?=
 =?us-ascii?Q?huhdTSaXczysChbl7jpDiHAYzdBQAn8tmyA2xpo7g0dTAKGlnHkMyRYgbeg3?=
 =?us-ascii?Q?i+Woy49nM47p+5SRZkhIoJF0w68yIy0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8445cf-ed40-449f-49b3-08da4e745532
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:11:17.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+R5r+DfVKQV4KfosC5c1Xlmh3B46ZxRLtFHHJiH6UUtgAw6Qk07fPEQoSqRUJazjKGSVKPQ7IXgMSbXPEKYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_01:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150004
X-Proofpoint-ORIG-GUID: bpy3uf-a5qdRiNfPIpj_YHRMHsgZmvIO
X-Proofpoint-GUID: bpy3uf-a5qdRiNfPIpj_YHRMHsgZmvIO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/kernfs/file.c | 56 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index dce654ad2cea9..fa0154211076d 100644
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
 /**
  * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
  *
@@ -79,9 +95,9 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn when caller holds the
- * kernfs_open_file_mutex.
+ * kernfs_open_file_mutex_ptr(kn).
  *
- * Update of ->attr.open happens under kernfs_open_file_mutex. So when
+ * Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So when
  * the caller guarantees that this mutex is being held, other updaters can't
  * change ->attr.open and this means that we can safely deref ->attr.open
  * outside RCU read-side critical section.
@@ -92,7 +108,7 @@ static struct kernfs_open_node *
 kernfs_deref_open_node_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
-				lockdep_is_held(&kernfs_open_file_mutex));
+				lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -575,19 +591,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_protected(kn);
 
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
@@ -596,7 +613,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -618,12 +635,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -635,7 +653,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -773,11 +791,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @kernfs_open_file_mutex_ptr(kn) is enough. @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -794,11 +812,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
@@ -813,6 +832,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -822,16 +842,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * ->attr.open at this point of time. This check allows early bail out
 	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
 	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
-	 * check under kernfs_open_file_mutex will ensure bailing out if
+	 * check under kernfs_open_file_mutex_ptr(kn) will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -845,7 +865,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

