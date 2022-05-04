Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFF519C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347817AbiEDJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347773AbiEDJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C962275F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2448TH9x013484;
        Wed, 4 May 2022 09:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bZPGkS06yWX1KnFgQdPwzAo8WOEYAz5SGlexyy2l2dU=;
 b=oX7z5+BVTT7aGR4whAWaH5KilbkgC7hxNZdl3yv6wUrWC+NoklLVfim9AL4rjVVNdb3o
 eL0vYluymqUHg82wI+Ie7bDZheOUmSnDbb8IA9JnYqB3zRkn20yApm2sOj/JWs903/TC
 7sf1zGDGHmYj9ah8YQAyhZPZRkMYjwHQcnkXU8x0+nHhpC3jeel+flA5Tlnd3eeK9JHT
 YoXxiqOxvv7F6b/T80eNQNFG0GIVuEkWbZyts/uKL/gN1eXyhNLeK/NacmvTxJKmpb2O
 EX+Gi1ccRHBowybabknbhKZiaadBvhCPkbTwwjPPBT9Pm2I7sNXG1VjEoQev9f1R8DA4 OA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsg05r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2449jM1w035760;
        Wed, 4 May 2022 09:51:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a5jfn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWbSn+QYxDycd2i+1elKXOWRwSYOMa7oyQF1m3XYkltAXA/Nk5ONAo7+O24epVexNpTSYXuSPPajU96esPiW7R6s3tyWEmLAk+ilE7C8IAv8XWaDlWWERU9ZlABYW1+2qiUguf14Xcqr8Rf+nwsKUrbSZnoYvttNLWLEvNI6Lp/QbG+5TVkiv7CCDtfaGhDOr68wBDkb47q05EZm1VYfoHiAGjs146bTPsKiwglC6UfKTfT/dqow+4DMwZb+bGNIHGPgBDkuZc69azgmVN+qJgw0hP66sof4xl2E5jCpQItBcYoTR1i6X24I1a7VZ076jmAufkRgZdMLQKZDX4PZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZPGkS06yWX1KnFgQdPwzAo8WOEYAz5SGlexyy2l2dU=;
 b=JVtTqJbC1ICp6V5M45/9MPjPiKTyOvvBj/johcO3RXZheSRdrkRpZN2siAq0CpoatI8lwHfYMEus54ccWuFwpHAakj9OtDzvJNVJ4RPGy8ArmDLPtuRTG2L88lK7+rnkVf8lW0Kw1a+G14wZ0WtFTHKq+HsJHR5vxdoRDlYf+bSlCeoU+BUio+ULLDDB3NdxDn3mV0oZqKd9oNqA12JkEN/oQVWR+04KzpU6GM8hAJHVBET/jSvzgiMZ299nbrkMn2anHhfdynSMA1XmIfQ6dZbd5q0qrHWOuJJOtdm/w0ewt5I6Z0pFx5I9NYYJUJGup0vI77qozkz6H+4n8FVqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZPGkS06yWX1KnFgQdPwzAo8WOEYAz5SGlexyy2l2dU=;
 b=w/mMv7WsmNSHZj2YVf/k3bp9qqF8J+uF26+H7qMOIrcSerVpCJTPTA5QDiQFBKQ2HaEZG68gHWLuhP7OjGYoTRICMLy3MO4goWYmoXmXUGQYOhv7iXhPCCBexbSM6LxgFfr8j61MdyylqrM74YrccO1BBSOGmd4hfbft8Qhq9Yw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SN6PR10MB2702.namprd10.prod.outlook.com (2603:10b6:805:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 09:51:39 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 09:51:39 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] kernfs: Rename kernfs_put_open_node to kernfs_unlink_open_file.
Date:   Wed,  4 May 2022 19:51:19 +1000
Message-Id: <20220504095123.295859-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504095123.295859-1-imran.f.khan@oracle.com>
References: <20220504095123.295859-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0203.ausprd01.prod.outlook.com
 (2603:10c6:10:16::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ef05bd-9e40-495a-6901-08da2db3af62
X-MS-TrafficTypeDiagnostic: SN6PR10MB2702:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2702914D60DA1E369D1FCC36B0C39@SN6PR10MB2702.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9x8e7Niz50Ks3givBWn5s4XJepRuErS83mqM7Tww63uMZw7Nr20MrsLJRNnAU1DZ2LwOkQZ5oTnCMM/YGq21B9lats3/qH9cj3nTKUtUWW4KUYjCSZDDKb3lj4h19YHcH7gEPUMzpH5eheZ22Lhj8g1svmGx5SUficCskkeZgy5juBgpkVndsCsX6tY0g4mweIcmOfb//pSeu93Infy0ot9SohT49d3IAKgVu71RyLEM03NcVgnLNUBQmIgLq05ZyOQ3II2589f7XrJJfbo7pMvVm+RPlBucdq3Qn53q7W1qxbWFQOCUho6Xlbj0oevSwXS1BhJk6QzLtSHVJdzzDbPfnRRipAVdFAwvOF7j/DfxB80ruoiMxqIgvdsjONBGwQdtkXTnarDvOlIWEszXFSOPnUg8RjnyEhTJUXZMn14xQl1qZrhkiJgpleq+OG4gv6p/yvTbxTOqpEMD3fi8/MnA6Fy+pQ83Tic1jEUW4KJFdq+TqB/PzS5gOZWR58SRbZt/j/V3DjL7f0dllBqbNkMW8vWzChR5mGMwxxJIudvRpDtGCYFUJu+27ivZOFce+hnPt8/eRORCbk1wiKBK4bE4mIaI0q6QvkVdc5AlGeBnXGjIohI+biwPUj+6zostX8roCk22PFZe07lj+aPYhDJfrh/0iDg5pwGLSQFYdg/s8XUBoidbwGXP0CDrEWi+Ryqp3Kp4DJoxuFREI/h4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(66556008)(8676002)(6512007)(4326008)(66946007)(66476007)(8936002)(6666004)(5660300002)(316002)(508600001)(2906002)(6486002)(86362001)(83380400001)(2616005)(52116002)(103116003)(36756003)(186003)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/+w2/7P4LojH50QBZqKkifP7mkNGEsxlVm1EIrE7fhIzGQRfciUrRjn192u?=
 =?us-ascii?Q?R2KgX4c4MLTjX2D0B8ZfmFGdaJ9CIyiqXGoEbkETMZhn0UPIiJrUU71O0LH1?=
 =?us-ascii?Q?BGPI4w+Vs9ucUaMrSs9ipvigS6h3L7INov/qHdP6y7ichYZw4PCJt+mauOoS?=
 =?us-ascii?Q?lYc/HXdlDI38RetNq0Lx7fgcia6VGmkIcfZcApsSicXokYiWN1KhnVXlvu8D?=
 =?us-ascii?Q?sdpkTpdlWbhWQ3iCcNLGtx8K7CzRRHxIIpCG0/ieKygAaY0TZmNH2jv/tcX5?=
 =?us-ascii?Q?9RIvHswuuxBh83Vg/iK+BABMDCKDDhypix37459R2gKdvF0lzj8sceD+fk8H?=
 =?us-ascii?Q?WB2expebvgSN0MFRolSRxhmeo4yKW3wnClVTUZ+cjpo8P4hDEWtPG+gxoNop?=
 =?us-ascii?Q?8vyewKVDAQI47NGfd3Pc1+pXm9DNysAso8frwXhgUjKCCzQx5cZCUvqTRmNh?=
 =?us-ascii?Q?H/4ayVPZ+Kh3LXViiOGpysSdc7qh/f/nCFS6hM1Pmc7r9VNZ1a4jo1PzIAwo?=
 =?us-ascii?Q?BDHqRSkpdiO3p76IZFB+zVoDeVKVeU21YAf2glUbK+jIhCo4ORM/UjqE08hy?=
 =?us-ascii?Q?PlruplgRH+PkEhCC8khv4HnVak16FI5U46m9Ubj17PwvpNG9Zodk0TpgBqA0?=
 =?us-ascii?Q?ZyW98go1cUqmoNzIK6gKqLetDA1SRMh8Hb7cY9X0bzqKCTZ6mLvzoIUjaaXM?=
 =?us-ascii?Q?WKzgP9ngiiImsPRNcjqVF4GggwwGcV8ucJ+N2FEnOjwczyHwUuQuI+ORrKOV?=
 =?us-ascii?Q?bENIkoCMhNXQJVxl5OLObRtWoZ8noCdc3rPqb4ifDxKoPSn+TplkoXS+l4S1?=
 =?us-ascii?Q?gYL4RgPgaDJGIkEahl5QRA7kbvHMcXYyMrHy8bHIC+M5vNGLS18VLM2gBtyZ?=
 =?us-ascii?Q?tvDLNYJQUnRcmcWGbw+3qBySbZ+3vTZqoxIN9Y4tLwCSFNTl6+raiCligDvC?=
 =?us-ascii?Q?KTixX1gY2VAjXLwSv2O0X3ZGh9MeVNZoqsX2isoPMXkxajKmdI+Ka3wUmVFr?=
 =?us-ascii?Q?WRmDa5EJAVJenwHORjT6MyHKXZAS7LmU55HzdNq4lN4UlZj4bhYibsg+OKey?=
 =?us-ascii?Q?h+QlRih2W9lKYbfl2CWOgz1xo4Sp4EjB1ovZ4sXmZ9eWlHG5g78q6XFTopxw?=
 =?us-ascii?Q?Totzw42JO7tKNz35AVeiZBzVIHwYU1UbD0Nq1x3AdMQfc5RAmM8/d+kwpBtM?=
 =?us-ascii?Q?aeHOCL+UoRcn1XjgqmgDCZXWshw1vLpZpvS+GEjT0Znv66gCFeP5aIdEnY+l?=
 =?us-ascii?Q?rX1B+SQHB/EkGKYWDGWtPfz4XmWwyQMZSCbP9BI16dMTlfYRQuF2QnnULTW7?=
 =?us-ascii?Q?02iJMfslPkkDGVOcEosMH6jmMLXuTYITdKeYSDILIDhAaAd6JmLZIYBQrSxg?=
 =?us-ascii?Q?8So3vUBjE74+1mV9DTiVmqYsyyjTKOlkYGVlAx/EVT1bmrrbEadZM+VHi74v?=
 =?us-ascii?Q?NthKVBa++BAakNn8gVyCiGfFpk6g6r+gB6qJiOzl5CygjKcV/oXvLsD94p4k?=
 =?us-ascii?Q?1qw0UPRSz7NHL3up+nqJBX+XW64CRHFGiDj1cEFa7qKHlIfsXGNZe4WpxnLe?=
 =?us-ascii?Q?4JjVeCRhBe1kXPNCq7m8x2bKyAFHqnMGljVC5F6HfCY7QiOWsSUzxNUbhuWw?=
 =?us-ascii?Q?3MxRtW32DjAVLVjunSmv0XaqBJ2YrlI5Npjw6g/IXWIgVOEFSLbV1quPEZaI?=
 =?us-ascii?Q?HadXVNwxWXDjuuaVBAYS0GlQvSlJZNSjLSx4+lNksM9i3Z5JF1r1GWpQqJNu?=
 =?us-ascii?Q?hOLfh0Le6qY5BTeYl9KxV4tzI4xMC6E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ef05bd-9e40-495a-6901-08da2db3af62
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:39.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeEL7udoP8EjKy9yuyA+XK/N0tI3CiAKBHyohnH2wPsQ0ekc1YVz+foHq4ClksOrSQpJtZyc9aIO7GYRV7NL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2702
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040065
X-Proofpoint-GUID: tksyVwjIRgZYppqzmHOSh85KegIdLYgi
X-Proofpoint-ORIG-GUID: tksyVwjIRgZYppqzmHOSh85KegIdLYgi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are no longer using refcnt for kernfs_open_node instances, rename
kernfs_put_open_node to kernfs_unlink_open_file to reflect this change.
Also update function description and inline comments accordingly.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index aea6968c979e..e3abfa843879 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -552,18 +552,19 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 }
 
 /**
- *	kernfs_put_open_node - put kernfs_open_node
+ *	kernfs_unlink_open_file - Unlink @of from @kn.
+ *
  *	@kn: target kernfs_node
  *	@of: associated kernfs_open_file
  *
- *	Put @kn->attr.open and unlink @of from the files list.  If
- *	list of associated open files becomes empty, disassociate and
- *	free kernfs_open_node.
+ *	Unlink @of from list of @kn's associated open files. If list of
+ *	associated open files becomes empty, disassociate and free
+ *	kernfs_open_node.
  *
  *	LOCKING:
  *	None.
  */
-static void kernfs_put_open_node(struct kernfs_node *kn,
+static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
@@ -703,7 +704,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	return 0;
 
 err_put_node:
-	kernfs_put_open_node(kn, of);
+	kernfs_unlink_open_file(kn, of);
 err_seq_release:
 	seq_release(inode, file);
 err_free:
@@ -749,7 +750,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 		mutex_unlock(&kernfs_open_file_mutex);
 	}
 
-	kernfs_put_open_node(kn, of);
+	kernfs_unlink_open_file(kn, of);
 	seq_release(inode, filp);
 	kfree(of->prealloc_buf);
 	kfree(of);
@@ -765,8 +766,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	on = kn->attr.open;
-	if (!on)
+	/*
+	 * lockless opportunistic check is safe below because no one is adding to
+	 * ->attr.open at this point of time. This check allows early bail out
+	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
+	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
+	 * check under kernfs_open_file_mutex will ensure bailing out if
+	 * ->attr.open became NULL while waiting for the mutex.
+	 */
+	if (!kn->attr.open)
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
@@ -775,6 +783,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 		return;
 	}
 
+	on = kn->attr.open;
+
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
-- 
2.30.2

