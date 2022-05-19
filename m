Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6852052CCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiESH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiESH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8391E8A33A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J5wx1t027449;
        Thu, 19 May 2022 07:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=/deI2k3jrtHe6bz5npsCsAFZC0VFGCAKb/rvsti9RCE=;
 b=dFYTHNsrqxi2A7TfkrYXdURVxIWG6VlKusflxBWPMlnAkxSlU6w5cQhxSGUJ7eG02/np
 +c09VBWcGruIqKc12wTNExYctImsbDAR/ofVcfYxj0JbhdmN4kRmvzZ1aL/IHwgniFJJ
 PDdKsL1/KyL7iL/73vpSVsGIgQk7WREvvyBhPyeDevVKTX7tY+WCtVu8jFlu03KzZGSu
 3nheD0+hFeZ/uO9GsBoq1CD94PrVkaOGBNd6zSgwMK5Jd7HjLZtx+R0eIXDs+s+8j/xm
 M9wDMTFsfmMB8KH9iAkM+8IlUSWKwFnOyH+7mEsDG4VuDkxN7IjXvWfRYHa1OZEPHgIK +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sbcs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J7FaUR020863;
        Thu, 19 May 2022 07:27:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v4rajd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV870Z5HV9hcTqKXhqb4mcT6epxlCxn2JsY3VUH92oQsIOujax94b/dTG+qfivGK0eSPSIW2g7P62lOL4nx4Q+AF/PrT6+DdyoMFkErM5lME28ajTon2S+SDnGk3yIj9IsvWnBpp9oWymNYbyuB5qHDUW0coFpRhDbNrXLJEt/LPutUS5ntRk5ZiuBFKtj17tEB2rcsAg+n8Y8ISiQ5aAyS6X1IQvdRANSulhlme4+6onJp2ZTGNPvJ0sDjeDi9wAs3vM/nG9Dj3aOAzeUHnVoPkOtPRpmmP5dvdx2A10TA9f7YuAfLcxWQXp2xFx439JQpkpd3LZDDJYjhvc928ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/deI2k3jrtHe6bz5npsCsAFZC0VFGCAKb/rvsti9RCE=;
 b=Bxn4F/on1N/heBPfJkmwcTdg0JL3H/dQJb1pmEULfgoQr1ERoFxjh3VEVTL5ylIsnzQNamxaPf1/jks20Vs1f5FuwcYD9YvAwYECvF2FPU7uWFCXINsOU3/JIU7V7a9AQcEArQAYcdI7+KZ9YSIBJ8OLU23Eigh+WIXWNKy8S5UCu2It7KgELe6SX4+ZFW7YJRTTXASt8jYRMPCIR2byZ2wsN38KELu4fv8TB4s/GJKeDqcIBvefGG77iLty/rR71IK3DSxKIIKxof3DYhOUOy3kejj+MCIJU1htBL/GWK++Gxr24dAoDtAuuubpV37xNFN66eH157RoO2tJo9DvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/deI2k3jrtHe6bz5npsCsAFZC0VFGCAKb/rvsti9RCE=;
 b=S/nlvk8ElV4ifN02t53ibdbSfydYdFSRwk4/1+SlFKFQdv2DIEDLdFpdSwvpQGK1K7CI+YBF/j0qe8sW77n5UicngoWTYkuEPnftoRHK9BlabNSoyFeFx80FUuinuY44FgjhtSwYlx1xYrF2uy+iP96v5cbDOP1CNrdxivy+QrA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2154.namprd10.prod.outlook.com (2603:10b6:4:2e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 07:27:16 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:27:16 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Thu, 19 May 2022 17:26:57 +1000
Message-Id: <20220519072658.736370-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519072658.736370-1-imran.f.khan@oracle.com>
References: <20220519072658.736370-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::12) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f9c0ca6-d16c-49f7-3050-08da39690012
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2154F209E5514B21F39757DFB0D09@DM5PR1001MB2154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Vt2cKwQVRBcqN5971cAMJaZ0OLuChsgUNRmUg2kll+2ODuWoqVPxGBW/g/59LwEpNC+CppVMTFJIpB/C+RIOhL2t1LfNHilKtcXuJTWQkcZs6d6qxs5Vw1HjU7xVt2haTH1vG431n/EHFfDL7ReKKY7EpiSgNOVwple/He6/TgVsWiucFmQxZDYAuzxZuBd0lRD+SQtLQ8IlSf5bQJfPxkNZgLaAVrHWMeB3rUFchDzAAazhmssidZYiWR4QwZ16IfRHI2/Of/gYpTfvFXk7Et7u5Mo9Dy7hkkvmBqxIw3IcihMZPQdenXnDeajEX5MWmAUS8yaOwCztU4YbasQRDv8Ze6dXP+co4pVaAga074to4DY9huNajG02/eURTnU8xihvuDd2rqXBqXors6GuI4DChjh1x0+hUfD7qU3hLuqFZy3ohZedxgHvcHGNy0fg/rRPGpT1FXh+xnfuJtOvSpzD/tczfOwT/v2W5OCvDVcsZS5eOPwMhKS6rLOgocrraMkCiZv0gC4qEGWBR2oZe6YQyW7BYj8sFwS8qE7tLZHS1JOU+JAKHZPuAvdHXduOPl7AixtO/HnHdACmbU57Y8QVGGFiJUOHpcBOE6WEt/PgwtGTOPjAzbR7sXA0yKtAdG3akAlYiqD/KMtbPaouCuZu0y8OZM340Om9vx9v9k47KRzW6SVtlhtieCNKjFB33NJ0rOOof437jRX0n93iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(103116003)(8676002)(83380400001)(86362001)(186003)(66556008)(6666004)(38350700002)(4326008)(66946007)(36756003)(66476007)(38100700002)(1076003)(6486002)(8936002)(2616005)(508600001)(52116002)(2906002)(26005)(6512007)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qAsLn5uftDdUhlrEI60f+ExfIKccIfEgATETmgym3GHc4/0miklP11u2rcKX?=
 =?us-ascii?Q?brc8zB3YuyqeasLjYNbRzuFub9t3ZsKTM5PHM4C9BRUa5K6DTyiaUj6KLY/4?=
 =?us-ascii?Q?kU7tcPyVB70MpcHOe2skd4gwJiHMfBkcSKNw4px0P84NPA+74v0wWvQFFIA/?=
 =?us-ascii?Q?Kd/Z30JqRGu6uBJoS59d0ztYKOR3kzHqFuOpSeLiU04rtsDr1xAHo2iv3oHR?=
 =?us-ascii?Q?b4r2SlpCDJH7uAEHNH1EZljJV6NgiXHwItQ2Oq3yAMa8FP1/A87YwuwRl2Aq?=
 =?us-ascii?Q?wCoirVCtTmqYE+zthXl8dl1aCKius/mNyI7Id/EVh8XYGVYh5mHycYA0610U?=
 =?us-ascii?Q?ztR9kzj5GVLfk9B7NubP3/Jcr+XwVY2/sPHNbi0ANvwKGSMkEPUKhzWQRZoz?=
 =?us-ascii?Q?SiyI9mwWJzI5LeCSIvOqLFP03PDVq3z+oC0ebLFfoFDR5Jc8WRMHOjYTrLhq?=
 =?us-ascii?Q?cvAzHvTU5in+NzOzmaP+yBmVzT/OPsBXClOpMtZnsi4cwmkGPXeMbiHJtCW1?=
 =?us-ascii?Q?MMixx4My2fToiMVoNRuSCSVq4oZJVdLY58faJxZkYTIqu/SaTwdoEMJA0RuU?=
 =?us-ascii?Q?GKG7AV/ekgNWZHi1yVwA+YuPwSt1YSvB4ymAFLVGdaZmN9yYs0FmduuHxvtY?=
 =?us-ascii?Q?ZNRzkXL8O8kmenmEaF1Wc4fN6WrPaLMMuXvrRmoWC/MpchyqCY36meTdBjsf?=
 =?us-ascii?Q?2XRP9/80aMAieIEi2eJUKGXJA4BeS1WjpN3Y/xbPppSuR48BUvQfFbqzxSEM?=
 =?us-ascii?Q?hVcp9FGFQho8zeBlLtWOnj9N/Z/yQsje4HL8TuglS7pJzOzmMKRfTNKVOsUN?=
 =?us-ascii?Q?enYwS7AOaiAXPMgIXVwSDlyaItf8Nir5EpYacMbNBDiICEvz7fu3BxqekXU9?=
 =?us-ascii?Q?3XXLTVFGObhwn+uwkzcjYTRZ7V3kdl1mdqUICCnftXIATgNIuh04JfvJS96v?=
 =?us-ascii?Q?jlK9XYLbTQ4haSxyaZe89CtKbhO6mAPbk6qQjsuLvoxifRUpINfrQzyaihuc?=
 =?us-ascii?Q?lAq1iu4NQSJi1BtE1xp0OJeqlPOFumf+FKEg/owmLKFq+pFyGyJaSQsHVGrA?=
 =?us-ascii?Q?IcQngnGGhT8wBYWWV79UEI5ozlW3NxEAu7mMPgd0P7J5qnyNMdyqHEOiKNZX?=
 =?us-ascii?Q?lQGoKlg/7gRP+Cjev91GQMYK/wWjmbOYglsP/3DJl1qm0EqUTIaGKt+8oiOQ?=
 =?us-ascii?Q?5b3mCPUm8nnAO9Hgu2U4U0+Oz0LOxstJD1aVNmXlF1k6BNptvR6nMC1LsXtW?=
 =?us-ascii?Q?9x7w//lV6emVLo4UOCoJpIj8QTiZnttWwz1vI90BsIxqOrPD2NJEGJS/r1Gv?=
 =?us-ascii?Q?0vfYJpsgEREw3SDxzn6WQUzzJlCEg+S5luwKlCicKlodK6epAVpGiViOkTDH?=
 =?us-ascii?Q?EjVyc7+enFTuWkDmrJzNUrlGAvnzhTw8jXcfa8PMmiGyxWu8me+D8CpXqaUg?=
 =?us-ascii?Q?mGCIC432K/1ngef0MMGh4EIoueD7qHI1Tn2uJSg9l3k81W1Z1XGWmHrkD+4Z?=
 =?us-ascii?Q?VpzCXwe8KCQ19Wk/lQ1uprq5IdyShN+RAJo7Ao+ZCr2Cvh4PXk18W4izmUsR?=
 =?us-ascii?Q?MGObaBMEOJTDD2nVdboXI0TrWYZi1mRLaQKv5oZFBaq88JbsdH8tbodbp7Qp?=
 =?us-ascii?Q?tzB7U843CB0vs3qx90tFSb1ZR1mclYXr+GzEYsKnIX0N9rs9vNoSmQ4arzCC?=
 =?us-ascii?Q?kheyeCJfa8TwD9DBFFy9BKOHnoTdLAF96DIWsNPyZKFoEVV0WrZPmwPBPGQS?=
 =?us-ascii?Q?x8o4wCGISq7IL0qYehXOF26VxBMBc1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9c0ca6-d16c-49f7-3050-08da39690012
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:27:16.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEOj36HBFjRMLWLbI/h0JuFQ8P8RJ3T1DDrxmqbh1MlqYiEBTcih/jPJdiThYZss90xptJamBv5l4C74hxeb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_01:2022-05-17,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190045
X-Proofpoint-GUID: V4Xh8p_4xqYfEW2z9YJvRNTf8EBbxT1-
X-Proofpoint-ORIG-GUID: V4Xh8p_4xqYfEW2z9YJvRNTf8EBbxT1-
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
 fs/kernfs/file.c | 72 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 3f883601c5ec..87ea8127c98c 100644
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
@@ -80,21 +96,21 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn when caller(writer) holds
- * kernfs_open_file_mutex.
+ * kernfs_open_file_mutex_ptr(kn).
  *
- * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
- * the current updater (caller) is holding this mutex, other updaters will not
- * be able to change ->attr.open and this means that we can safely deref
- * ->attr.open outside RCU read-side critical section.
+ * Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So as
+ * long as the current updater (caller) is holding this mutex, other updaters
+ * will not be able to change ->attr.open and this means that we can safely
+ * deref ->attr.open outside RCU read-side critical section.
  *
  * This should ONLY be used by updaters of ->attr.open and caller needs to make
- * sure that kernfs_open_file_mutex is held.
+ * sure that kernfs_open_file_mutex_ptr(kn) is held.
  */
 static struct kernfs_open_node *
 kernfs_deref_open_node_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
-				lockdep_is_held(&kernfs_open_file_mutex));
+			lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 /**
@@ -103,21 +119,21 @@ kernfs_deref_open_node_protected(struct kernfs_node *kn)
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn when caller(reader) holds
- * kernfs_open_file_mutex.
+ * kernfs_open_file_mutex_ptr(kn).
  *
- * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
- * the current reader (caller) is holding this mutex, updaters will not be
- * able to change ->attr.open and this means that we can safely deref
+ * Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So as
+ * long as the current reader (caller) is holding this mutex, updaters will
+ * not be able to change ->attr.open and this means that we can safely deref
  * ->attr.open outside RCU read-side critical section.
  *
  * This should ONLY be used by readers of ->attr.open and caller needs to make
- * sure that kernfs_open_file_mutex is held.
+ * sure that kernfs_open_file_mutex_ptr(kn) is held.
  */
 static struct kernfs_open_node *
 kernfs_check_open_node_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_check(kn->attr.open,
-				      lockdep_is_held(&kernfs_open_file_mutex));
+			lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -600,19 +616,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -621,7 +638,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -643,12 +660,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
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
 
@@ -660,7 +678,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -802,7 +820,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -819,11 +837,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
@@ -838,6 +857,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -853,10 +873,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_check_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -870,7 +890,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

