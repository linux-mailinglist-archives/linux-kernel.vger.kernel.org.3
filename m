Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D554A70A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354625AbiFNCsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352311AbiFNCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:48:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C5B59960
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:26:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0fH1S027238;
        Tue, 14 Jun 2022 02:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ADI9sXjaxTkOLxp23rB/WTc7Om4E0dUsEwTsb+uxY20=;
 b=OUkJVDsxDMM1f+9GVFiz5uLzwYZlHZFaCBVkAFKnAJ02faVo3Vwth33rr4bKnNM52XoI
 qZ8rQmHiWq1S/hAZYlXPix3el6GRuAJax/+N2cGXEAVSKkrUY+np9B21/q7haJ16Fx8G
 zKnRwMQt32mxc2xheW+PiiNO9Ry8XaoS+j2cIGGLkqWV0m4zovtCphhg2r6MM9zuNWu6
 0uwJxTKvjgM/Jx/4Q7+RJBShqVzqQfTvQBISZX8DVDkwjyHbLorU2/Bq2JpftwyNZM3i
 eM2ztGxR6S/IostjT1IBw7fTh4Rl1XS28IKko8qVrv+QwwUi0lHwBErNw1Rb5u4+YjnZ CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns4j5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E20iEL034822;
        Tue, 14 Jun 2022 02:08:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gph5xr466-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMHgo7qLsF1M+6vdwWRytEsNKLoZkLqb7zIgG+pJiJBb1dYTeT8LusEyq8XOfM0Xq+dWThf8rOavwlLCGZbXa0VWsyKIOJIQ9oUHKkPyH5F1f2tgcbKrxkXuOmPhFohyj/GsNJnfFxdpNdPCuoTOjkF2+VxwWCqfzZeMS7cerB96InRQq+PgfKE+kiFDpmw3g+PsfbfTsPQW1rcU3apvo8yAvlytZ0/kMPODBo9JF4ysh8dY/53QN2BJ8GcmF/Piqu/NI6wOb29oQTuKPItH2T2Hwf3Wa5I5d/GdJXdChQU8bQ9ARIzYMYmFmzYlR7XySLX9hCrId+5x+PngykJL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADI9sXjaxTkOLxp23rB/WTc7Om4E0dUsEwTsb+uxY20=;
 b=TF/OTSEUYW48fbyW+lchbmheTGfJjR7OwYrCslF5dfyMIaG7rYl6QqNgQJNKPWlStSPq2igr3R650mMMuoRd0ITguHZcADIJox/ip3whUOO+34LD2aHOkeijupwZoDB1sSmi+0cz5dzk1gyXEfWpL6ZSfR1vT9i8rVgvlQGUaa7KkLsgZT+6xJKa5jY7bEG7nTXRToVBdYQytE0ntX9oSTI4rI5RIf1Nv6BbNwMWo7Z5GfCw9YepwkXDAa1UuU+lFm5JyjaXgzlrsSac+mFC/lfSpG/ePSBBCXN9bkzsI5HEF3NuJOOJbpPWWYTdEYzmwWjGRyqI8tscf3IaPCTihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADI9sXjaxTkOLxp23rB/WTc7Om4E0dUsEwTsb+uxY20=;
 b=K6RfACK4KmxEINrRwCnVnffS0sglenubtc8GRkFqXJ6OsqF9pZBIaobjEVW5Luk4JH4u0vQdOiX1r6ElK1DLEO4brROJ60vY4ntu3AVjRrIsaibXnMDOVBSnzJ/VwOgXa6ARQMm/u2cR847dyB8g7IMC40eedwLcVnpLb0P9xKw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:08:57 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 02:08:57 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Tue, 14 Jun 2022 12:08:39 +1000
Message-Id: <20220614020840.546013-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614020840.546013-1-imran.f.khan@oracle.com>
References: <20220614020840.546013-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ff8109-13af-4d22-049a-08da4daad6ec
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23987E816FBE7454A4878C06B0AA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C85d8qRNU4BkqjNgJ+wlyBz7hsNo0w64Wv8n/7aNdwSxg1PUj4IuWOlp9InjsWe1NsgS0kON5PIuOPkqBK4AFTyqSklrErCYAQN5N2WW8XqpptENX/34MoI7s4j9sgS8QdF3Xa+m0oYCPdWfF2YCdqPcqAWuZxRHP8pZD5CFZ1t/2uS4A2k2ychq3H0oSAhlMTu3X8aQBq5WgA4jXd3bNh6p8b4BfotC789rI1Weoll0j/x+vSfMOKTqrguHz7RA/bcgmDfzB6oUcYyr7VuXu+aRIGh+deoyWww2Q9vgvVp3OC6EJWIynFMa464ddsHUa5nakoNRrOQ8awDaAHGPwHZJXjsGNa41UGhLXaGzPgI9qvCFs9ONuc7IOQHNlRV2P3r9ZtgW/eUo9pvtmtJE3twya6Ytq5edv0Y0RWXxJtxFIklo1rEk1iSvHLZj+AQxJElMD5MGwZIndn0VPYIxHNKRgIRL/1eXyzJGkHNtvj3J4NQxIyKqAD1ZCS/C6e8aZkfRbDXYBL2u3SEyYl1gkXpy4DZH6xtDVlHJO1uEQ1G55V1FIvJKWohJy2jehe9OIROlemiUiVYDuisU0LzUcOONz9R9NF27f8GCoE/LmRvyHbtbIZ1Zh/lOhKnI/gMIlq6FqpFqpvzW6uohMoo8/w2H47sCMRnUq1LhlAV389yLeTO5C0pGDoCWkaraNiUATBVIvMbk3CTaAGMmKzbXJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(66946007)(1076003)(66476007)(8676002)(4326008)(186003)(5660300002)(2616005)(36756003)(52116002)(6506007)(6666004)(83380400001)(8936002)(26005)(6512007)(86362001)(103116003)(2906002)(38350700002)(6486002)(38100700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wnsL2q1+hakzd/ovhYkey5wf4DY1+ubm+/2iktqQqkZYYYLgYjrGaownkS9?=
 =?us-ascii?Q?PBtbOSsuVXeRTEuvOEX++aSX4oHk4I1H5yZI2rnG8KcUg1KqLMHLw6lTM/6j?=
 =?us-ascii?Q?ezjfAoJGVlnPgM5E/z5pO2jnGlT6vFxgCfdmjDeAe6GkjyJSx9kHrb8/kN5o?=
 =?us-ascii?Q?YQaoYlzmCsta0LfantqB3GDAVQLoNEBnGiQdP7D1AcU/OXGCQlT10E6Gs8tI?=
 =?us-ascii?Q?4MuxFUAutoSh0Ktjm1GDaJLxiVUoLX8D2kJtZj95TOxHO4uyJQ+StdLWByVc?=
 =?us-ascii?Q?30D7mlM7oZVOcoQsJ14PzkKuvWIRhWUXr2dgzWTfXBV/Wn+65NYyd6DWypv6?=
 =?us-ascii?Q?5NGE3UTBAJFgGr6u7k6ybjl4fBTNhwR80HAU8iFuuNekimASMYvygwYsd6DD?=
 =?us-ascii?Q?B+NesoonSQVm45V+rsbHGuaTkYOfNZQOn8Ye5H2A9FVezEpx0nP1/XaAQcb/?=
 =?us-ascii?Q?EVG8MGVtOj3rkqQj5bndRRG7M7PU02FL0FpWCny/VYnygqzFYpBt8O+KbbZR?=
 =?us-ascii?Q?7b7dg6uFyG9LxdxpqpOn+70DVjPK5KPLnz0KL71BwADrAfhE7D81EwHFncGo?=
 =?us-ascii?Q?AT4au4vpfywk8zeGVhEZD13wnPxtntyVM40m50ixqh2Ou/cATXqXA/SdLe0S?=
 =?us-ascii?Q?FxlasubOliQ4aGcZjAaNo2BM8NVw0GJ5EN8wbl0fYJwvwpfMKcAmJSlSpriD?=
 =?us-ascii?Q?m81NNI6AxMjtBhx1hONNDG8AqnyBmjXdA7K0hTGmF4j98SrCMSz12CcP4VEb?=
 =?us-ascii?Q?eJKUICly9Hp8xel4G+ul+sUYTk708QFdae8M2rVty1ygNZVlLAbur+zEDLGr?=
 =?us-ascii?Q?CBEa8yvJp2Bs0MmgOwkQriHefs6C4yMpAOVCQXZgPiAH5Lx0EyOOXLUMts8n?=
 =?us-ascii?Q?JWA7R0+W0vhA3FeclwJwh3KcdTESgtay9Km0mQGPkFTRHvE7jNEO7qytlEIS?=
 =?us-ascii?Q?jRXDqsHLvaVyLMoAYP94z76ZSOh+AM9ydnNAMdmmWvKb1MUkZSBYZLR/TZSV?=
 =?us-ascii?Q?NL1AUDc6slBCP7pRYpKAp8jd0MD4j6vcPNMWN+6iQkTuXOP0Za63wcX2xdCD?=
 =?us-ascii?Q?Jz9J0+mKPhcTa8AiKGetKHQyCb/w0VxOrkGYei8ksxJYXdKarjVbF0kD98sQ?=
 =?us-ascii?Q?doISmrLTzpJyQMjACf5us3FjusPVtyyQTaALYCVXLf2VNdOeUnWZtLmC9kUS?=
 =?us-ascii?Q?6OdS9BZgG4/Di3PQCF4v1PXWPKN8alunmKMIXVV8/3VOc6yauSDz+PFadVPn?=
 =?us-ascii?Q?iCo/O1/yX1DzB7i7RTQvtA6s6kUOUBSwIlHlQct5mzqeUvXMT172+0bVlqX7?=
 =?us-ascii?Q?5q6r3CfNugDbfVn5xjzPjprUAbSJCUCjhCF46iisegr2LUAmPbS/ChwHRydf?=
 =?us-ascii?Q?TKC8brgEF5Wgp5nG9deFcboqtRFpSvQNgojEtwjNw2hStfqUsL/eS+vNWq/b?=
 =?us-ascii?Q?Fd6GP3aMWYg50qBOoMFXisCW2IaWhLh7u/mXMP+OChZGrrTPMrOG1q6JYPuc?=
 =?us-ascii?Q?Bx7Nk/tYvQS29w/VnaKSpu/Z4XA/a5woIdSA7M8/BPqqOrovOLeEYxGfC9P7?=
 =?us-ascii?Q?GaWL5YzcSn0oI+0AShR3eBEUhvMVTt3ep4jdJIFBwr0ACwA1vYqIXyWAK5pN?=
 =?us-ascii?Q?8p+9I1MLntdj21L7enHSzFPdB4QI497kBrQRsmGFaJYo2DlQImUlWZGzi5/0?=
 =?us-ascii?Q?1W8nbBy4d3mhlfX1EFUFnLKbxYX7gRmCCtnWLKstXYQVDGJcPe8w/pQNKLI7?=
 =?us-ascii?Q?+lfbLdq0qqdmchiMzNbLmYRTifXfU48=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff8109-13af-4d22-049a-08da4daad6ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:08:57.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysus6idDPLvHqRBZE5aucdjqwqh9Awq/pyTEyPimz2pDZs3bisw40cSWc2RQdb6Qx1DtwDCFTqDMWWzUuDVJrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140007
X-Proofpoint-GUID: FJEgKmShpcVzUsbY8tXCDYwYm0orTAY9
X-Proofpoint-ORIG-GUID: FJEgKmShpcVzUsbY8tXCDYwYm0orTAY9
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
 fs/kernfs/file.c | 60 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 0cc288dcf51d9..205b5c71f30cb 100644
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
@@ -56,7 +72,7 @@ static LLIST_HEAD(kernfs_notify_list);
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn if @of->list is not empty or if
- * kernfs_open_file_mutex is held.
+ * kernfs_open_file_mutex_ptr(kn) is held.
  *
  * We can rely on either of the following 2 conditions to ensure that
  * dereferencing ->attr.open outside RCU read-side critical section is safe.
@@ -68,13 +84,13 @@ static LLIST_HEAD(kernfs_notify_list);
  *
  * or
  *
- * 2. Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
- * the current updater (caller) is holding this mutex, other updaters will not
- * be able to change ->attr.open and this means that we can safely deref
- * ->attr.open outside RCU read-side critical section.
+ * 2. Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So as
+ * long as the current updater (caller) holds this mutex, other updaters can't
+ * change ->attr.open and this means that we can safely deref ->attr.open
+ * outside RCU read-side critical section.
  *
  * The caller needs to make sure that either @of->list is not empty or
- * kernfs_open_file_mutex is held.
+ * kernfs_open_file_mutex_ptr(kn) is held.
  */
 static struct kernfs_open_node *
 kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
@@ -83,7 +99,7 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
 	bool deref_ok;
 
 	deref_ok = (of ? !list_empty(&of->list) : false) ||
-		   lockdep_is_held(&kernfs_open_file_mutex);
+		   lockdep_is_held(kernfs_open_file_mutex_ptr(kn));
 
 	on = rcu_dereference_check(kn->attr.open, deref_ok);
 
@@ -570,19 +586,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node(NULL, kn);
 
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
@@ -591,7 +608,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -613,12 +630,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_open_node(NULL, kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -630,7 +648,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -772,7 +790,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -789,11 +807,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
@@ -808,6 +827,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -823,10 +843,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node(NULL, kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -840,7 +860,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

