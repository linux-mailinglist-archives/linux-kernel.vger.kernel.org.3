Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07141563727
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiGAPqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:46:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4752E688;
        Fri,  1 Jul 2022 08:46:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261DNY0m028513;
        Fri, 1 Jul 2022 15:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/iu2jWZH/Fv/4GgJ1rEeFsQ6KJWVqVu83JccJpZf3QI=;
 b=bNlFC+Kj/WXDk1DbpNwM6S5aMnkVDE2UPs5o0cCDCO21cN5Dm36wPHGuSnu5ffrw1iNC
 xU02lDRJcHt5Zx1Q4TTVK8cT4LBIG5ahUbon3WrsymZ0vYLv53NrzZTBPJOkubzzREqD
 PXA3cVFFxc/C/gIb41/GkfNYmzuodOoQJthfPjint8AEPihsmMg44jSV9kXnebOK9jkN
 FgDrkNxwhkkK6emd+WHcd97IEpg3Uf/FhlzLKkSNSE+0KgynNxX7hIfJykf0wDiSwMLv
 bIvFZ35cYqcfLIgfkG1ED6A09LTJIqVAlSEX5/OY7bu2NHBYdB1vU6gwhHp9spvr1otb vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0qn55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:46:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261FjCNx015919;
        Fri, 1 Jul 2022 15:46:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtasren-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXP3rNBsublZacqEg392OydRxI0na9ID7Js6ByJgAoaYhxkNLIG25bysvQs3NzWky868cO9SYrihlyocbLRoKRZJp1vKLQX0t4tcoC9p07OUtqbWyb2Dzxh1iOTQuboYR9+QJrywMJGeNVUK5z+3FR7nQ9gfLWJy76g0J7vTzrgze9lGWn8hHJLXOIC0E4FczrGu/ZjewB7tBDvZfo+zA87pBsjr7yL5h9aQVvjVCoYM0OYQLw6YnzA7FmynZrISeUKRHqrjHNe/cJ1Ev/hOsyN973BY7EUyD3C6lBrYMI3VGFO4E97HfVDaw0SukUmjzZoy2S5Vyl/AijtdWw9wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iu2jWZH/Fv/4GgJ1rEeFsQ6KJWVqVu83JccJpZf3QI=;
 b=kpeFuhxCf9KWyie+qszdenNKDTl+ULIzx3UcI41LmxV81uDHFzNelIyyLkeojw/8J/4fFNeQMra3WoYDDaW56WH0i1izSfh0rqM2pyM6J4NfGXSqRsEC6Y+IsNyUEcZSvdSQhswarHatW9u4mLHvxqDbxo6rK2vvgu+cNG/lyGMLmlk8W76jhHVUlQj7I7Isitr0p3KsuPt7j4zN1ovzfluYl5EWsh0gTkeSO2dJU15qL/pjRngzAB7hswZzoD40BLU7jfl1WMgTId5iwVRUFGumlHHLXq9+7nFYFejykKDaZ4WxXyjVGj+o9sXzpVXwLCCkT7g9We8FniLBvLXYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iu2jWZH/Fv/4GgJ1rEeFsQ6KJWVqVu83JccJpZf3QI=;
 b=oP5ITOp5ic7DGKGT37ekEt5WsL8qf3DRMORBKjm9O0CwGI0bHycKMr6HYEc7wKXQZzaXGd8JLlaODRbirEsyO5Ltt+yRROXEgpGHo2gwqEAq0aksvHVlxRkWTjKk6rNyyN35Igd0MzKOgQmpliAK7SPHZQb4uEGZZ0005rVFAFE=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3603.namprd10.prod.outlook.com (2603:10b6:408:b9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 15:46:18 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 15:46:18 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into kernfs_notify_list.
Date:   Sat,  2 Jul 2022 01:46:04 +1000
Message-Id: <20220701154604.2211008-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0185.ausprd01.prod.outlook.com
 (2603:10c6:10:52::29) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4814e7d-74c7-45db-e179-08da5b78d6ab
X-MS-TrafficTypeDiagnostic: BN8PR10MB3603:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8m0Mw5uZdVHV50SJfDOtpz182wnRgc6LOD63jyHCkXF5zkXIHSOeslMR7lh4H1ZoRkBOXwauVQjhtSkhxR4oevGPHudg3ub8TnEcmdOi5CdlJ8Ps731F8IUxc4RLM0ZS/q7GroelPBE+/v/U0ijSG+yfPioi04bD7E1iyjBnpXtTSIZkvrG2UKtZ4IBiG4ad+KGg1YLNVTCK49bgieoWACzBjigmiieL88IkszcUUtrFB3PPE8AafuY/E+BNcG9KOnFdKpQ+5JmxmxKvInxk3rhzBXxwmawgubx+R4ih4ApHG+bE0HuxinppFybH3BBVtwfnquiYDxEoTzs0zZinqLphbOdL0Vy69Yx8Q2Ds026LDtPUab0xwEVXpiLIbZJrv3I0TBy9MqBQFmggGjodAVtxL/sHxpch33av7TtW8/9cpayj1wFzr2lUYmwtwr2AfkPnaVLnUF6R4zTTwkiTI6B6673YLRQHqtmnwNEUzP71KlVrwxj3T2SkAOhIcOgvu/8g2awZ7b5/CU94oNBedAJbx1W6czzssfl53Skd4wV4WAxThbiv6CwOH6NDHFyy7QTTMocD+qCbNKMnxTU0oACNFj0nZJGzYKouh3gPtcPaEu6sFzVZ4e4uUa1HV8Hm8CO2iExWvwtNXSLcvIEQTWgYEcPlDXghtO24SfkiuXw9u4wPPqd+GL+ZTjTv5wnSt4/E59OJyHSku4UqaS7rBT41iAn97ygCFsSMJgsW89OywQjdYNzeb1oTZkNo0y8dLVk1u8Yg4t7eyhtJkjihJNokGC62ame+VvsOb7zM7xNZB1B1cCnZg/+ZJlKjTLH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(376002)(366004)(2906002)(41300700001)(6506007)(6666004)(8936002)(4326008)(8676002)(5660300002)(7416002)(36756003)(478600001)(6486002)(66476007)(103116003)(66946007)(66556008)(6512007)(316002)(26005)(52116002)(86362001)(38350700002)(38100700002)(2616005)(83380400001)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7W6igPfxDwrbem49vMCxJ26Vqi+kY81DbA62vVjN9VNnqY2BlBQlwT4LTL12?=
 =?us-ascii?Q?Vp9XA/gd+UBNvRaOEZtCvf/lF9ocN37pDhzg/z08gOuHoHUfrl1FnJCzSVQU?=
 =?us-ascii?Q?5d4Bl6Pk35HNfFwTzTyqGLQx220a7FTrxf8pczHQ9HwMSFwaVdgteizfeH7S?=
 =?us-ascii?Q?a/HJx5EWCN0WOHLDhIdcvpgqCQmVqVytPXFlxZrAGSix3XguJsovOiNgBypN?=
 =?us-ascii?Q?SpLe7XzpCmrm2Nrm9yv4dFYity+U1a3TipQD2CAK3hA8trVb/UfY3/uRK0Ql?=
 =?us-ascii?Q?q+6sgXdql6xg8dFBL8VvXGUjhCgEYYC8aiyzPyjtiq0/k3yGxY2iNON3I/0z?=
 =?us-ascii?Q?SJ4D0izq0IAyafKYf0pswOmB/WGci9y2ROrSH0tzeh74NNhT6zl7wJyu9rjm?=
 =?us-ascii?Q?IlVKTo7bZ9yxPHVuK7zBdAMjR1PvRMPmnVwW1m8NDNwctp+QJdxiUeXADgm0?=
 =?us-ascii?Q?IMAyl0gMHkmcNMwgcclddtElqjcGjfxnirzisX3kj8m8u5AYF1OcPl/f5LSx?=
 =?us-ascii?Q?BTONnfXzJhrVY+KenaBjcJKjabeEsEeL1zoI14O9BWoUy5GWDZ/v79c6iHE6?=
 =?us-ascii?Q?UlyXzepfNIqN5r+xBaUqT/wF8CZUyqivfY4HvGToB5x3urdW2cepJlvbz+Ep?=
 =?us-ascii?Q?MqS3pZuEGtQA2mgFfBsE4Qpx7y5aNx6fqcRAGdBBQqbyrlElFFfxCG9ioO41?=
 =?us-ascii?Q?62UMA2vUj+3cebl/+goNJYXJtP4R0O5aO2ojLNz3IaqLMbt/v3J6Q9AlJCDd?=
 =?us-ascii?Q?DdGwLB3ggg5Xq7XmzUbBgoF56FwPBoNhJz0I2GcHzj8JnxAWBgH9PZ2fXzTb?=
 =?us-ascii?Q?L0gfF4ZnUxxmNYEtI50PskHU7YjCcWDuifVK9QoE9M4EDjpknhNjhge+XLOY?=
 =?us-ascii?Q?hgjZHwWZy904JCQW/5EXfHEpuj4UbMnSv2f/GT7Gj3n5mM9OxQBnWKpYBAz4?=
 =?us-ascii?Q?Tk8St5uds6Xy0UPOASoHxsVATub+Ck2ph6Mkv8PHJp8Yiu19PmJLt24eSWyT?=
 =?us-ascii?Q?NXyz98yvhdlILEt9RCuieFeDthsFRl04REfZIFeo+9wLKm6nQR4kIq9a8JL1?=
 =?us-ascii?Q?O/pqhS7bUHME7kZWotIsKHJL7WwjRe2XVY1mOs8fUK5BikuxLgy0Dba3fMnh?=
 =?us-ascii?Q?MxxTNPtD11+mok0DElDOBxdiOOaj/0IaDaaxlEZxqHcn1PxLsAAf8aVDAeEq?=
 =?us-ascii?Q?qJs1FSGGiMCDbTcUE3EsEsT7LOPtOWjnyJvKlt+2zWxWbBXBbJ7c6TdHqVR2?=
 =?us-ascii?Q?+pxn/sXPV4FT19lgz7wSkcWfy9YbtYJF8MPSl9HiK/8nOSrBQgk59edRhy4j?=
 =?us-ascii?Q?SYDxCSLxky7tjpZY1hquPNLPnN3qObWNWQTs75SzRbO6v95YxI70Ucl2Se5V?=
 =?us-ascii?Q?SSI/3mSx/vvpl3Vsqx+mOEVfHv3CY8mvJjxYA1xErmKgEnWH8bYRYS6Nj0Zw?=
 =?us-ascii?Q?yfJs+mRzSLc76eBBOpJYXCj6CQmZHeK8ZMmbsY5TYUd8ZdMg6QJLRI+hHmYT?=
 =?us-ascii?Q?ZCDZFZj6GisyRbgj/yx93zrG82GXVrmANoAcqK4EspSl1gtIa5KKf6wuvG9f?=
 =?us-ascii?Q?0lf/xGpJMy4xE2V9D6vXwVIAo+yUeBLVitbq3+CgwUDGvgNrjfzBfOmThxWz?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4814e7d-74c7-45db-e179-08da5b78d6ab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 15:46:18.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgLYvDdysZwN09nsrFPQp3N0lgDM5xO3J13QHuq/ZrSTcW/ViXoZOCF+MdKSjiJ2F2J80kGI7VhR2k4XAlOX1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3603
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_08:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010062
X-Proofpoint-GUID: ZkSY6QeAvlpLZu6liEeAwSVnBtoft2Oc
X-Proofpoint-ORIG-GUID: ZkSY6QeAvlpLZu6liEeAwSVnBtoft2Oc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kick fsnotify only if an event is not already scheduled for target
kernfs node. commit b8f35fa1188b ("kernfs: Change kernfs_notify_list to
llist.") changed kernfs_notify_list to a llist.
Prior to this list was a singly linked list, protected by
kernfs_notify_lock. Whenever a kernfs_node was added to the list
its ->attr.notify_next was set to head of the list and upon removal
->attr.notify_next was reset to NULL. Addition to kernfs_notify_list
would only happen if kernfs_node was not already in the list i.e.
if ->attr.notify_next was NULL. commit b8f35fa1188b ("kernfs: Change
kernfs_notify_list to llist.") removed this checking and this was wrong
as it resulted in multiple additions for same kernfs_node.

So far this bug only got reflected with some console related setting.
Nathan found this issue when console was specified both in DT and in
kernel command line and Marek found this issue when earlycon was enabled.

This patch avoids adding an already added kernfs_node into notify list.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Michael Walle <michael@walle.cc>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: b8f35fa1188b ("kernfs: Change kernfs_notify_list to llist.")
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

Resending after adding Reported-by and Tested-by tags missed earlier.

 fs/kernfs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index bb933221b4bae..e8ec054e11c63 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -917,6 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	if (free == NULL)
 		return;
 
+	free->next = NULL;
 	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
 	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
@@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
 	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
-	kernfs_get(kn);
-	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
-	schedule_work(&kernfs_notify_work);
+	if (kn->attr.notify_next.next != NULL) {
+		kernfs_get(kn);
+		llist_add(&kn->attr.notify_next, &kernfs_notify_list);
+		schedule_work(&kernfs_notify_work);
+	}
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);
 

base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
-- 
2.30.2

