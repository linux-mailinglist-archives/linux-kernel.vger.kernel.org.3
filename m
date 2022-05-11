Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D272523003
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiEKJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiEKJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA55DA5B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:52:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8CCsE022886;
        Wed, 11 May 2022 09:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oA4SgaxN/5miA5GFKa2qBizaCF3qnbKUAnET4Z10Flc=;
 b=uOpAv/2RxCVvqlKXJRQBOrO8HaMQqreVqK/IEJxg69I5H1CfAw4OMw5arNMVNuD0eri3
 MmDUqTPM4f+9N0SBrxHIqYWGfbb3KQLdIzXeFo4T1RWEBVwxtUi/x0xnkGMvTi59Jq03
 Jkir8H3iDFQRWHFIAwXYC2ZoaqI4SLDyAE9o4kO9/0QVS4Z1/tyzBiP6W9C0eAB5nWQZ
 bVHAK8AJmzevQjCcVFawtI5H+eNGPfhiWjxNYMQb8cR1oxEYCNjnivNmPM9X3bxtDpJF
 3B6rS+tX+43iKaFZqKcf/HX/2HEjlGmO4T/Ub6LQuR9prVRvg5kzwZVCajOfuD0QiDsL rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhath827-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9peBk010660;
        Wed, 11 May 2022 09:52:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7ad9vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl9u8Pt6GnMfju1jg2tYTOcr4fte+DKt4k4hmKvgDr00/9XWQu+aKsBH7AfmP4GqE+EMo05rl6w0jKzto92BNODpbcEFP5jphXETyAQj3j1f3ktjL6+PgKN5Zzr3Bp/Sto6gqjLNiosBxeNkEAJyLhq+SH4ISr5aRPVN+HZE/p5F7IFLW+peN5YQeyTTaLLYRzMU/weyuX4/Ib2xDA83yIYhkmX3/6QX4RVjh4gPzsz7j65n7FLXn5oLILZjciWT8GiPBy+A2HkrwlztCwqbAQH2RlnHyrWcR57OD/H01RHA4qLPUQGRN9b8qZ0zqkUSAvH3s4dx6kbfyoKfK5WM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA4SgaxN/5miA5GFKa2qBizaCF3qnbKUAnET4Z10Flc=;
 b=I+O9jTDeeybyBzEHPCQDQinmx/9LSi66KGRYPAriDcj0gwghJOo4ZxITLqraDBe6AlCHAThyLTBRo2Icr8Pepm4BUuSv3Z6Wlji5HGydJjPXKF11onboCxmi8hLYBxyx+l6peqMnjhcdvd1oDmaacpAK0OLSc3AtcQczzo2Wm/RM3uoxYuxtv6t4S1ymTS95/RqibzvJeo9zZIVFoRc59ACi4z9/gYTOjv8SEoc/wG85T4MueK186pW6xXvCkIbyxhYpKoAC5NtKOSjY5M1JYCb98zU+AEK+okj/F1MKtIDQyDGDBARY7b+x9rDMtz423cuWv3hP5yZseHv9uAdTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA4SgaxN/5miA5GFKa2qBizaCF3qnbKUAnET4Z10Flc=;
 b=eCZGQKDaYzD81fiz1Q3OGocP5b2nhI3425wkTeaQ/vaOTlPz8rlHXsuVjii0Hxo7jF9/UMgf/CWJdX20mL9evDbS8RRslf3LpoX4Iwml5nkA+NdqEq5fWUraagGJNZ2Q9poNsr6mH0Da5zmtoJWcgEeBvn5hgmHrQ4h9kwdyfhc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 09:52:10 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:52:10 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] kernfs: make ->attr.open RCU protected.
Date:   Wed, 11 May 2022 19:51:53 +1000
Message-Id: <20220511095157.478522-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64c4d85-e944-4ca4-dbb1-08da3333eabe
X-MS-TrafficTypeDiagnostic: BYAPR10MB3718:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3718E6FC2F363CEFB5341C76B0C89@BYAPR10MB3718.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vigAeKVzq4H35ZIoH7sbO/v5HWs2AM8TL4bOOs++75bhSRNX/pWg8Sv5WYVfccxSSvKkpvtlR2AGMs+9ivRIEpYpKpbk2pAUDXFNW9qNzZyZCE+SYggANG270WStlOC8WhpVu0+pwfH7c7WTEUoBVsh5SXBLlnCfXLI60Qpyz9AjxzqehI6WXPz6gwamtBN4YID4piNKC5glGYY11aGXHPKm2RRvOhpNrf7Pg8DEDbqP/dwtiPuZnBcYiEVhXUdxKs0ZOUF3BLQcnq1XvA6LmhTl39X4h0LX/kE3jhZ66MBl13UqGyCn2+T01AdWFL/IUmbd7mtBh1eiS9u+gUNsVuLBpGzE06OPFv1GaBnuWmZmpRCz0JkLullYrVV11DuAChpRpEZSKLbPpZu/PfA0lc3h4Nag9DvGne5tKAOA9lNXdB5m4qsxXe4qgLK1bi/m7wEF4jQJdoZx8WcPxxpuDuGVvTLkS5J3Xa7++F8QjpXyOGG+hbf64jTkAYxTR2h9NGnzuEpTmFze9ZNpBdlTtoHTpebl5V0VNEjIKdknNFjAZgn7ImctA/PM/QZU8kX0LYvRHx+Z2mn/e17qs0wynuAnYhgtmz1vlNCw7ftMn1LraGljJZqRFtvVfZ1PjTuHC0HIUaJvDjyx29wIkq5VKoFh+FyIFHk3vZfch//Qwj1Gpc7eg2iVnJQnHDaca3LaDSXGtesJcQjvKzNNaYODKoPoZYJuMejMY3hQY3VGuv9S5QS7UTyPYTMo+n2ayCK8yXJOYxdVBn9TYuBroxdw2Lv7Lb+o5gy2T7rrh989kLaRO40PuPV96yV0L72EZhzvQuue5CAbINpUiBHcgfei8zg6qxMf3KK5kSYFWOdQOI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(2616005)(6512007)(6506007)(26005)(52116002)(6666004)(5660300002)(8936002)(2906002)(103116003)(36756003)(86362001)(66556008)(66476007)(66946007)(966005)(6486002)(508600001)(8676002)(4326008)(316002)(1076003)(83380400001)(186003)(38100700002)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2xINJzkrEsnPk/i3KjGZFxmSx1f6DGcW3H1xvPWPVLNCqK73sSYt4Malv1Uc?=
 =?us-ascii?Q?oSfOTbBHe4QHJRk/vSuBt2vK10uXlx4UQCPjlPm/iFW3km7QeYpHvvJsT1Ce?=
 =?us-ascii?Q?XnxYeswrG1yamYB0f+gPMFrUbyRB7ruz59mFrIj9tWtIiFRwCu86FobNpTfu?=
 =?us-ascii?Q?dWwwkttf0nYOxEOYLfuExI66agx4HvxXIle1F+Vh1+YgeFW2ZSKHN7hPKluV?=
 =?us-ascii?Q?D0wW75Qo9v8HfRuWgSxyTd3UuFa9kkmrmQ9C/jrKqu5ewXAn/Oc5pfI35Jz9?=
 =?us-ascii?Q?q/R3Ur0VUoe7r35hTzQ+WWSb1q8Z+5zw46tSY7MfymDy0PubbYSoEHhKEAHS?=
 =?us-ascii?Q?Y2b+rZAoUV6hC3llZkbjdNHZQRO2XAspCnMhGbtlC4fMzhnxBkxGcoP0+5IG?=
 =?us-ascii?Q?N+/A8qT0IDw/lDLXM2rok7ZI9sb/gv0L6a6rGQUvxzalRA19GE2wQYvHQEXZ?=
 =?us-ascii?Q?/TRNiqptlXhu4+a1uGyl/2/E2hbwwhL5pYEft/z81++pPw7i8YC7tYnT88uP?=
 =?us-ascii?Q?KtYX3tjAgstkEHXog4Pj6eOy3NF0CzU2Rht2twn+oD8b4kttopuRzGA5WqDO?=
 =?us-ascii?Q?JohQbYaChkk6ZI6+RJiQYL0GwzyaZUTpVW0ebtch3JFxZBYcnPvETq1JiJOl?=
 =?us-ascii?Q?EMdzVgUEDnxb9glEFMwy7aC7G6OPr0DcKlbEMzxneV5YfMEGSpv3QkANWwwM?=
 =?us-ascii?Q?6gwwEKKlFNEhGaBqKBTfbcAUlotstCnwTjbOV583cQBudH/pAeSyqsxp9FYJ?=
 =?us-ascii?Q?n03Il9znNwY1BTr4zNgRWv0IenVi4UvqEb4Laf/uNYhyW1/BbG+Yyw4CH76r?=
 =?us-ascii?Q?Qhk1yDpEbA45B2Lc0LOLux1hkJvqUZW/5H2QptuFcH3s1I5GTGq5446wd7qB?=
 =?us-ascii?Q?4993YTwnRfF0jyEpfaLfRDe8YzczgkvQBimWKf1gzAGghDQVZ0CvxZuxdQ8A?=
 =?us-ascii?Q?OaFZip4kTNRUbIH3HiG2wEwB8xPSMrTPZ75qhzCmj1NZoFLlNr4d1aUOYAGg?=
 =?us-ascii?Q?2BMrw6B32MbRhTuguQ9VqvaVKHR4p0MDhyw4GTEQbzflACcuLbL6SYTCyEK/?=
 =?us-ascii?Q?2ePECDynKRrYLdxNc3zZhNiRBqHqrSY1ziYBCNlG11YVQr5n0ASQeXI+UekM?=
 =?us-ascii?Q?QSVIy3Y1F1XMxhRzASqManOgj9/s5Y5iPLKw5JldYgp2gjKyipN3OHWZVtRo?=
 =?us-ascii?Q?V2jL2sU4p2n8457nNXXdpJs0fQBoni08qGqJ5X6bngAD1cM9FvhAbJ+TXeTE?=
 =?us-ascii?Q?+7e+nHOo7bHwlq/SFzy/jp3HVg2MCcPqBQzKMzj2qAWYVpssDJZvvcEN0dUS?=
 =?us-ascii?Q?ckO+Q6hh0PM8LT4yRcaJC1H/ojXYEE5EbDN2kySaMVU0i/xnp+v3JSxuExYq?=
 =?us-ascii?Q?kCUQWBwtS+fo8lDhhU8CD894wtgt2lJ0GeYIf28DpJU/dOes26WsoZlE3+88?=
 =?us-ascii?Q?6kRT+l4YJ7VJIXeU+1UGizwGYnI/GRj34CS71JdLn/0qO2NczVejxQKrRhW7?=
 =?us-ascii?Q?I/w6iA+R2/+LSMhIt4ORgRQu+xQ0L0kgpWHgI89owFRavgXOgYgB+fl+4tBZ?=
 =?us-ascii?Q?DUpJvhSLCZPhrx1hMfXUT13sgusdx0csVlQJW8oJpFUWUh1USm1wmfDuX27c?=
 =?us-ascii?Q?gwXHPlFmSkQHDsnPe5wxVqmZ33iMU6JHZM/YTH30UbxbwTuUtUsTwha6f00V?=
 =?us-ascii?Q?O9A1zISGVXIEMwgIUV03H/DeMIf5vbPLC0zOuHabLTi/YSA1Occ71OdIZghv?=
 =?us-ascii?Q?oS6ABYGC8hC3t/O15s6mxBb25JiSwEE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64c4d85-e944-4ca4-dbb1-08da3333eabe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:52:10.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwCx0F+v2NCfgS2s+ce9cEUSDQ9HQhlPtI/1toC7hHNBHhddXk/bKWQIcHRAaAp6oXEwJVX1s8D70E0UEOpbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110044
X-Proofpoint-GUID: JsJDSPSnuMXKERTG3xMwrU4KA4AOkH4o
X-Proofpoint-ORIG-GUID: JsJDSPSnuMXKERTG3xMwrU4KA4AOkH4o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this version of the patch set are as follows:

PATCH-1: Make kernfs_open_node->attr.open RCU protected.

PATCH-2: Change kernfs_notify_list to llist.

PATCH-3: Introduce interface to access kernfs_open_file_mutex.

PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.

Changes since v2:
 - Rebase on tag next-20220510
 - Remove PATCH-1 of v2 because it is present in tag next-20220510
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2 and PATCH-3)


Cover letter for v2:
--------------------------------------------------------------------------

I have not yet received any feedback about v1 of this patchset [2] but
in the meantime an old version of first patch from [3] has been integrated in
linux-next. Functionally first patch in both [2] and [3] are identical.
It's just that [2] has renamed one of the functions to better reflect the fact
that we are no longer using reference counting for kernfs_open_node.

In this version, I have just modified first patch of v1 so that we use the
modified function name as done in [2] and avoid those parts that are already
present in linux-next now. The remaining 4 patches (PATCH-2 to PATCH-5) are
identical in both v1 and v2 albeit v2 has been rebased on tag next-20220503.

Changes since v1:
 - Rebase on tag next-20220503

[2]: https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
[3]: https://lore.kernel.org/lkml/20220324103040.584491-1-imran.f.khan@oracle.com/

Original cover letter
-------------------------------------------------------

This patchset contains subset of patches (after addressing review comments)
discussed at [1]. Since [1] is replacing multiple global locks and since
each of these locks can be removed independently, it was decided that we
should make these changes in parts i.e first get one set of optimizations
integrated and then work on top of those further.

The patches in this change set introduce following changes:

PATCH-1: Remove reference counting for kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

[1] https://lore.kernel.org/lkml/YmLfxHcekrr89IFl@slm.duckdns.org/

----------------------------------------------------------------

Imran Khan (4):
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 237 ++++++++++++++++++++++--------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 +++++++++-
 4 files changed, 226 insertions(+), 95 deletions(-)


base-commit: 3bf222d317a20170ee17f082626c1e0f83537e13
-- 
2.30.2

