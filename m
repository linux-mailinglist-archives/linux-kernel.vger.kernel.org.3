Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D1519C55
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347771AbiEDJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344063AbiEDJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5627B2F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2448EBsF024988;
        Wed, 4 May 2022 09:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HbLECpceSpawoRHhTlPULsqAaBBP83rKCc8yqUqGBmY=;
 b=UzLg1vj7ZEKWhhRsHmnBpSsfWGMt6Kr0WngrI2c/HT4szqFEzgpS7zCdM8njzQnyUtjL
 bJNLLIg37AKWbBXkdamM3HsUzlUm4uZQGFrr64X3RG1P5mfKe+kggZO9/Sxx+89siAlq
 3bKJQZhs+PQPVr2ke+7tdVaZnhknHlL7aWXBiFNtu5d6FOytfrq1iIgMzDLHS/CqCm5P
 blOBzhZFU/kZYzG2VO7mIV9g/pd53MxpfF1puYkJJeyqTxGbb9FStGWvDXf1HXaBtyoZ
 EOCkwsYJz/jQCNqvqyvBt/YwXJGwKZLskpo3CW8NuZ441Ti3rMkoxhLZtesw6sU+0MQE cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2fyt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2449jTK6018506;
        Wed, 4 May 2022 09:51:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbn6r0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbvc+ICLvegALT943kqItGR0J28HKHrRdWTr0cghVpJjiX77jhPAfA6keRUf9S8sDnXswMsrE/nOdx2kjqe8ExXo1xcBP0BAN2RnzcElh2z1aSGjg4FCzRwDNN2rUEPNlUG7GaEc5C3gHqLVVg+T5zKifQz7AoRTQrY1c1d2lwvh0EboX04KwHZLP+mRdc5U7J8VUJSiJ4fzQ4QMoxoe4ncSiIRf0qSg8b5MlTSc8WfS/ZvonzEvCFQzdgmhS2iHrUViWa+4oVkRwRmej4JyQJVQjeSzorLz7BmmSvI1Uf50dBuOMsnIvDTn+t1UinWhc5E9et94ErNtRN11PDSxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbLECpceSpawoRHhTlPULsqAaBBP83rKCc8yqUqGBmY=;
 b=HqzuDauSSR0e8qQP1zznPZyeFbgzdHvTCaa0PkiFa7GO6j+QA9WHw8SNA5QtsyWiyu7ggGAqGXra2m26W5i1TQO3+E9LvHrYTFzNiYpeMTdIuCNe+AIH4UQ2wDMau3G4oNvZgz2X1VSLePFGT6Gu5pQTwdxAoeumoZl8WThkTVPYBZFnKN1PtK+k4HywWtOnaAWPqRqw17ggtSi0Zq1Qa1gvwvfAZnMXyxgQVkowJM6I674Iq9Ag6tnroJtf5jbcisFdcItC5BiuiHsbjYNphxeHWY/UIJrwT0HsLZiPYcxOP52pDkStD9o1GJ/+dCXVNOePx1PEgqCb/Aw8KYthZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbLECpceSpawoRHhTlPULsqAaBBP83rKCc8yqUqGBmY=;
 b=i0XfpwLDOdVP3sf6W3jUhAptR9UpfWYi7uEK4I9al8ELLT+yYUjWN8omPcjcUUzbfPp6HbOWbguThRLsaoJwod9okTyRVpck7OtZ0meO8oLDhv4/PhUwC3GU/tIGb62630oO1+bI810A+7nn33ALW+mhY7wSC1wNnTIlURF4m9M=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SN6PR10MB2702.namprd10.prod.outlook.com (2603:10b6:805:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 09:51:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 09:51:36 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] kernfs: Rename kernfs_put_open_node to kernfs_unlink_open_file.
Date:   Wed,  4 May 2022 19:51:18 +1000
Message-Id: <20220504095123.295859-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0203.ausprd01.prod.outlook.com
 (2603:10c6:10:16::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9761de-026e-4979-b016-08da2db3adb7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2702:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2702A5971E22B5D87968D4A3B0C39@SN6PR10MB2702.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /a5vhKmqdFqJ3RxLHrqbVRKnPCraOxRR3jSc/WFPh5ihfIDxR9dMtm6o5vAx7o8PPZs+MxhvOZJqS3ulfj9bzKDXeIyOl05qyn3JSJzHEceP4cZSsmNZOkf/wfpPALW7NZ99jR65o/o04f88bCd1PtrsyDHQIpDy7sRTmCGwLdNqGnZYhUhtZdoVHU3+THWAggHgjY2ToKOaRXTRGQdeCbgBxkEw0fXNJM84/bx5ADTDvGO6jxYHA6Yepf7dhmw9Ahxn90Kx7gba3BUXRQaGO/PQ5+4UmQzqGPK/5HIYbaQuDDq6ELweSg2d7XZQJjnTJDcN3/iiINYbUl8YNUrcGE7aV5okMrtk5j+HuFFodLptTMrgkNyoVSjMRhDlR2PhR+vQIZrJSpqRjEk+KvJ1q9MmcRH/rb9i9HLe1L+Sz4ho8P7yFOHD2cpcgYnuvbV7/soPorhStjN2BKRHsrNh8VuZeHUZpKV2nMzx2g36K2EkgDkhkNdkDuoRZIb9TW6jiyE9xrkKg552Jswhi6BoCBzDD+Fj6WzdYtUIGA4CWQd2r4yOtoAefR9uacjKcOjjHXqKgAaHSXVEaT/VGwWMehaiWv6YrvR1AbCvgBDGwgzcVDIwQ/yokB0fFeCsIwfN9kDKP0CXj79de02kUSeySBv55yEgXhFvhDc/x+pifxzfRY3N0b+a3RXsAfimqinV1bp9EOBUDWZ/HFj8x+v21XSHskfLLcvzI72gqt4FMN1pSPfzHA+n/zG3vQC51DApGDzPTzFIEq++t8foAAvQuHvfs8urnPlXvJ3ysJL5kaLr6Br5Guzf4LZJRF2ODUxzUFZitrxDwqMmphwlcSkkcmdWLpzljii84eMYLEYdzXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(66556008)(8676002)(6512007)(4326008)(66946007)(66476007)(8936002)(6666004)(5660300002)(316002)(508600001)(2906002)(966005)(6486002)(86362001)(83380400001)(2616005)(52116002)(103116003)(36756003)(186003)(26005)(1076003)(6506007)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wfKk3p8in/7OuJfQEraBwIk1V8mmgUkiJbNNpMIP2CFafy9rsQ+SUIY8awN?=
 =?us-ascii?Q?2EX2VUPaSbKH2eVO2Qe3u5C9jhMPr+vxAJ+nqWlz8KZyV6fFiOO+jI9DF3c8?=
 =?us-ascii?Q?MJ6teIYGYOsw7UoZBzg82Ly0NusBnydD+/gG+4W+vz64VkRFRfkrXmwUJU/E?=
 =?us-ascii?Q?2rJBq8woYQl77BTuUFnqHxQAXjpKu/VB+hWEpy42HKxKKFNA0/JTchTB2V2X?=
 =?us-ascii?Q?AKm+svrdo9+H6yBXhMI/cpJeJ0jt33lnBF4eUE0c4+xi6Kp1m2XGP82w6zhH?=
 =?us-ascii?Q?rTn3ira2loA0QuwEQY6GtEW3TUYsofe7q8XdRux2RtERA9qNTs9irpLkYLme?=
 =?us-ascii?Q?k8NGwIxqRtUNn5ZHMHZLi3nKC1GiXicvL5XcRE/drFgyoDqGchkaaJZBFqUy?=
 =?us-ascii?Q?iVp4uVcWOd2wMSbhAGtBDXBFm5LV6AVqXVkP/5ombkZO7gILiUHZWbBczxx6?=
 =?us-ascii?Q?zV4A0GeF6p+NVDcIJncw2WJhAkgThrzwfjgHV1eLFbVMMAamoSf0cT8smBM2?=
 =?us-ascii?Q?Bl/M+sAjtlqWE34YxHJzcu6ljVbjoF+C2lvCj5j/LKaz6F8Kk7QP6uRCs0A7?=
 =?us-ascii?Q?G0ox+jv9OjfTaWl6V7HIBrRBwRE4cFcW9/TQ+x+1sat8RMfqXYQmGHbZqUrR?=
 =?us-ascii?Q?qcthXm9UTbBOCbGQtfqko8rOxK/gbl2cagTK8xLOjfnENOYsl6qiPeefd3g0?=
 =?us-ascii?Q?jHbU2PtD9Twv96QIQ0oxBilSO/5zDBO5+W41jLWEogekZg0QZZD/g4MSurg+?=
 =?us-ascii?Q?+Z4ZKW1CqAvn7CI0zzXdBg+z2qICrUUNOCMDbxUqNpaP9EMiNMwy//Y/Jjuc?=
 =?us-ascii?Q?rIMUEWJO+yKbrWhAe5JeiKftzn++S9JiYG2ePneDRDWZklxi50k9nyghV10p?=
 =?us-ascii?Q?NIAzPdI7XR/c2Dn0kt3WsGvj4/R1hkT+JI+DNYDGSjQjHAlvmW3NeRcxUOnI?=
 =?us-ascii?Q?GOPFvuGOobTQ6b9QFX5CcsyIylFJHIbCQVDfGZprjv6otVeSMi5bOsp4GvO5?=
 =?us-ascii?Q?qAWjRf5PGQ7cKifscBQZZ+ggtE3R+ocvuQxvv2ie/ywWwyWTAxf9xjwKKoZv?=
 =?us-ascii?Q?q+sR222l/VlkRf6NwWKceWmNPtQBxLWOjUuFsJRhleoQVWGSCWHQvFMAu0gh?=
 =?us-ascii?Q?TwxPCasOBdt1TM9wXp2dipp3qWUSwym/OX6rWSzDmBuiyJGVyZA/jq+b9Ncx?=
 =?us-ascii?Q?SBHrxuzE8p/RaWkR3v8t2ZXOuoDhhDJCgGNIgf55uVvtIJEd82P01S2XOI+Z?=
 =?us-ascii?Q?aY7FRAVzUzeXVhR3a/6XYJB8NKHbdeE69dQtH10Vm4agKxP1+Eex2lyZ/iFj?=
 =?us-ascii?Q?OQiXlZHYSq26ErF4RxPkTOoIs34qfrL+a67KmktkmdN/c9X2mgjtntnAoRQc?=
 =?us-ascii?Q?UTecIveScMiJcd5+hRYFAoqutAczmWQc/ozzvb4+ODBQ8JuGAaT+o3V0fNs4?=
 =?us-ascii?Q?pivJ3tIedfT6xCy9hmtX63ZIK1xBG9qJQZbK5JhEa140YLX7ErDQu6q7Afkr?=
 =?us-ascii?Q?ZneD9uIl/Vokl0rAWoq2WH0vL52JO1kcWTAdByCJSb0JcAyjnsFJniA8Pm8u?=
 =?us-ascii?Q?6h9PKVIRQcw5+RzR7xilhahkb/0tXEr3cKMRY02i4tMu+/7Klo0DkYRNbnnd?=
 =?us-ascii?Q?dq+uHs441ejIuQiyrVDs/WqZ/I9CE+PFTQs7UOTAkkkZJMNaTGDRxEukWzNu?=
 =?us-ascii?Q?sK03wuPuiDhMYCcUUljkUQX8IUhqg43FMW+e52ozVvoEXyJHbpnYSlD4Uv+5?=
 =?us-ascii?Q?oUFH/+c5Vm1Ib0SCN4bMF4q/TrXz/eM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9761de-026e-4979-b016-08da2db3adb7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:36.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqBUjldxMiqItHuilj3eYN7VaRbGnTr4zj31isIlYDMuvWEuEMndGNQTpdTJQkvbB8aYfZp1vr6XbkdFee6F2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2702
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040065
X-Proofpoint-GUID: bJ_X_JgaJ0NLUHuPCugdx0CUAm56v2RS
X-Proofpoint-ORIG-GUID: bJ_X_JgaJ0NLUHuPCugdx0CUAm56v2RS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Imran Khan (5):
  kernfs: Rename kernfs_put_open_node to kernfs_unlink_open_file.
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 238 +++++++++++++++++++++---------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 ++++++++-
 4 files changed, 221 insertions(+), 101 deletions(-)


base-commit: 44a2f39e611ac0bc1f17c288a583d7f2e5684aa7
-- 
2.30.2

