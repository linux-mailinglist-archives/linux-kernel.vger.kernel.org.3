Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24453B3B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiFBGjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiFBGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:39:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5929C128
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:39:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2526KfUs031601;
        Thu, 2 Jun 2022 06:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tpSuJ9mTu5PZWLxWmPAZQxN82fxwaXM4SRruPtAwDHE=;
 b=htjbGonIjneDxWgeo2lkveczWJQZYZOoXDBhQ14Ae4gXbz8eerfLxdcxw4AJSTsIeOys
 JFxBxy5gozZNjtujOJdZPYHELVjRuKjbzs0feTuPux44Q+Z4Pjru85cwCg5ofGDlI8QF
 WwIkJxdWPHajDlcmw5l5Vj4FrCEcIzN54mvHSpMPd09WF9ZTAdyLoX4jcq5/9irFT3rn
 CQTZRXmxezjzIcoguKh9b/l6SZKgJ0nDz+V8PiW2LNqVc570E9WgKt+StF37xej/LxVr
 jAAN2AuX66K8blUbrMyZE5CHTL1L2MLdGQvGlx64zKft1dpoUAYhC3zS3ieYMDjGemsT Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xsnd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2526LWQR037779;
        Thu, 2 Jun 2022 06:39:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k15btw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxM5+7nS6phxz6bETVsMfYMR+j6PUmJrVN/Qy9moHFuvNiN61Ad/U70q5nRHgSZw80bINAA1I5zXE8Hyijju8NsSEAJG0h+5vR8MialixcnzC969J5O375Hs/qUfMuX9L3YOPDGoFae3TGQaU2sVpr8h/KDZpmEP80Rrn9WIaTF66M+7orJG1Kd5Sc7rINlvUVDYaXw2NKozfFwuExotJMKOBKsD1peLjrCOKH80zFj525SbaDqBD5eXfXa+4wQsV3nD1KcgpCK45k6Vl5VKObmtZjQxMYL2eiG0rbKCzF+xvOXiKsESuKmO+NFPxWUQbTPJPjTqpbTrCwUpvtmWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpSuJ9mTu5PZWLxWmPAZQxN82fxwaXM4SRruPtAwDHE=;
 b=C04iwAA9hgGt7DBjfQXxpTzqqFemehaGM9J6gta45IUzHYkZ6vF/QA+GZvFq4ME6SkbwuXwK8W4f6nz4zgMbecbrUHs4fzuK6WdhTyXUwhwrfbT1+kxVndd/vrpRDNMxXZDNh3tUbqvFX7EwB7FKR17PQsNaXRVnNIM9XcdoQHHK7W4oQkAt2E6NfLCw6HOsa5rDiE/FU3hJlJ90ewRLAluIv28nCjw8szFxV0i3X5pCvGO6Pv2Y/0d1epFtpAZHJnDtnFpqIpGC5XnlMd8wz1PBd8k0+xr+3y515UOOg0C5xC2BzJ6bCd93sA8PPrvDN+m6NGg0LppmTHZ7xvZx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpSuJ9mTu5PZWLxWmPAZQxN82fxwaXM4SRruPtAwDHE=;
 b=nLpPW+SBpDRAvmM0N7F9QlcX1xkwUBsZ6j8x9BL16fsHJBen3RLefA4ilGfCy09vzQzXDsepoRT0M0g/+WbYomjbNbuBcZUISNi1GcLo8AAmPF97Mwu1fcIyFHINjgoJ6fpJKGATrn0iCO0/KiOO66hpBzMkRSeM6Ghr8SVAjug=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:39:21 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%8]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:39:21 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     matthew.wilcox@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/4] kernfs: make ->attr.open RCU protected.
Date:   Thu,  2 Jun 2022 16:39:03 +1000
Message-Id: <20220602063907.136569-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad33e4c8-30e5-43c6-16b3-08da44629ff0
X-MS-TrafficTypeDiagnostic: PH0PR10MB5845:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5845C5BAD403319FF64CDA43B0DE9@PH0PR10MB5845.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdx3MQj6zea8q/WcfX9H5lHxKqiJvuorc0z9JCo8ib8rNiBEz6PD1YJdu9b3VI98qYmB6k5tagqFegc+qTrT6ld2+K5CRnVOEdOmIsCgAGQYzdjjzxnGFweT+cquF1k3rbOh09Ja3z5jgPQUoBX9+5T9MDTiFT+y/RKNnRM5TyrWORiEEv/JUgUgUWirqLK+oCyCwq02k0GwOC5KAFbZGAxTRqeaIZPFoDtlzg4yfXNTOs804VpJc1S6M0+ThneOZ+u7qaYLd7qHM/LievyWonIgdQy1GS7EajBEKeyCp26dwNjeyRrageidW7rgGWuls5XqGnmUAWMu8LncWQx+QLJ9FMWzb3lkt+hqISIAT2COyD64+ImExXauZHxXmj/YfaqvMnPlyDeY2yhfqQGv1p6q8ynriWxBug4L1I2nhI19xSJsw4tDrAIzXSfT46EbHCKzZNxYX8GtUnlLNywTEOASg7JIdl7WdA1b6jaPcPFoobvdtnutYJ8BxctduAep4y+vwRrdtAoN4g2BlxEFQs7QgbytRMCx/GJn0X0BQssUaliC7VtFGsp0AnGfkP5iYEyL8ae2/RxtvHaLLsR+MMnYmKh3bqFTTq+nXCgJhBezuxgXlc6YUBB9HwlvQqSfWmeocQdAxzwS23uqZmnQf3qyy5FcNdEa77Q9WUgFByNOwGyuQ9GNq0oGffPZ0tDIuGBu3RYVXStfR4rjwK2VEnj4LFh8mDCsajWDmsmsrdKbZWxSUzXY3i+pKW32ElIsuCjx95lndx0X76VzSOGFNafrZEWhQkpH+yzTW3M4kKoccAv0RuCAq/sfAPk8yjVOVurehVxTKCQ/wqVo68rnV+kF0tHTEzueYzaTNsptSY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(38100700002)(1076003)(2616005)(5660300002)(103116003)(36756003)(8936002)(2906002)(4326008)(66946007)(86362001)(6486002)(66476007)(966005)(8676002)(6506007)(6666004)(6512007)(66556008)(52116002)(26005)(38350700002)(316002)(508600001)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koxD0ETT0MGf2bQLAemERgddMuKqT6ObotB/qnSSdYNBy6j/v+NaB1ZNyJpa?=
 =?us-ascii?Q?dML4Yxuq23Lk1CCwOoEhSUxYK6l9e3bKg0MkmZbbXmhxvZ17G5ScBHSebCjA?=
 =?us-ascii?Q?MyAaNjzi2b0YdREUkMFJjNchetVcba5RsTqBb2ZgSqQcvLgrIjPjHOWrQSQa?=
 =?us-ascii?Q?EYwmpoA89oyKpylSWh3bm+uI/a8CYDrw2PMy90lCohSR1NlIs8rBJRvOsb01?=
 =?us-ascii?Q?RIs9H4PIun18HXY6cC5Y+Uygoefp+LYuZlIU+US5SP1teuuE7E/+hoL4lQNJ?=
 =?us-ascii?Q?+cXKDZBG8dX4qaansjSeTmd6qFGFebwOo8aLQQkh2IhtLa/AXcmErfe/taZE?=
 =?us-ascii?Q?AH0ECJHiPu/0bH+oMkCgye8hQ39DR9xlil5B7X0dYuLxgz9J5MdYakGIqboQ?=
 =?us-ascii?Q?amge9wWqawBv/kSY4AN/Oi27Qgv1QQ9thTWHIN+2nK2wOPwP/pzj3DM2nYlX?=
 =?us-ascii?Q?MMjZG3hyBT2FCcWZBxr4BxWIDssHqzq2HkTUZNM1Z9uX6nDJw4pntvtUZoQp?=
 =?us-ascii?Q?2hjD1u5V5B5ULAWl7nObJc8yjrrT2d90UH8U0B1apZVMr3yPDTx7ll8n3q8e?=
 =?us-ascii?Q?DHpQe/VkB4ZhoznkYVsTQYUlu5To5+A+UOdClnGytYAem4VZx+1y8ZoKt8fh?=
 =?us-ascii?Q?hM+snroHGzJIMmmUH+Ca10AqfuKiW+rgXd/Z4VEYjcv9pLflLy2aAuiK7PvK?=
 =?us-ascii?Q?2r9NlXtxsQHV88TDVFv2yLDHsh2p2F9v6aThEm0XwZVBCr6y6sEbWkhR6Vl4?=
 =?us-ascii?Q?HDiPfEoG/SbwwAOrUW4swGDqCXC7+3Q8MgAH568gztPxo7rbsth35a9czOOc?=
 =?us-ascii?Q?7/oBwsaVFl6u0EkL2lS5j8ClKj9Yvovq+ennEe6k20NxOhlCJE+zTb1UmNcp?=
 =?us-ascii?Q?qd2UPJ9Yo6DiKP5eUH/jLCmNwDZHs2c2lyAblu+XuyeCoViSVd4eYDJoE/yv?=
 =?us-ascii?Q?TN1T9zdpQ512BJQohEDMnsH1ES/vO/OGeQuGenCqFrFpPqNe9FTefKrTv41i?=
 =?us-ascii?Q?Vu9bJTT9NKplQFWhzuuyo9m1U/RrlDpZ/b1VG4qi+yEVf0jZq5bdgMMu2hW2?=
 =?us-ascii?Q?sj4yeQuocdSuXm8M15h2CDmVlRj4ZQ6NYwTtatafe1QRTZcj2AD1Sn3DqC1m?=
 =?us-ascii?Q?1yBe0UyQbEdawE66XlT8tUx44nSV/apzSl/SqOgMr4QWh311FkXhOOzI0XfE?=
 =?us-ascii?Q?Pdts0j8IFsPIV2+5lRdUtV322grqk1bEoC1thrgOd1GfBX8phNEnptFmhaAf?=
 =?us-ascii?Q?L6I1NTe7VAb9he2ytnU865C3IdNFBHEHOaAyX4QPajWjk1IPlmMUPmzl2AJG?=
 =?us-ascii?Q?cEvA+TxHRG5Hwzjy60zst0qH6oTnsqHgOOg30/CmgjfSS+lBVTXfQeCO8T2L?=
 =?us-ascii?Q?u/YG5Uu6xkyjPtF4leZqApayVxQMHiwsRizj7gdtSoDNWUmLcnnmYjMd1nf4?=
 =?us-ascii?Q?MN6qOPtykCTpnPlJ7lgOmXBrNj8MbPC4nL2f7UHzhustRgODI1v2wz3LPSZJ?=
 =?us-ascii?Q?Fsfi+uHYvK+7SQVrDutt5KJUpOvV96y9Drg8/YinVBMII7M1SvvwFZuLanRm?=
 =?us-ascii?Q?AzCjGKZT47k8E9YWJKnejNgydV1ImwvPt3vWCT9rsUi+wNp5u2dahMG1C2jG?=
 =?us-ascii?Q?QxypoOwUljZ/6jXKF4EvZU1MHxe4mVdqNUHlCNT0G8a1DoPqYOsnN8BBLTeW?=
 =?us-ascii?Q?vaHFF/xcaDStIJaPbCNtML/HbCRORams8sri2QwLfj2duVoUU8PtlTfojlUQ?=
 =?us-ascii?Q?9bJNj8saXGCiHF+q6fHgClUxRAn7OzU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad33e4c8-30e5-43c6-16b3-08da44629ff0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:39:20.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFsW87wDHbJFku9BUmeWxCu3+Q817z6cyU1rijPGfLHIIgyL11O25JKnTjpTwSquLtlh413FHk/OrIuKUrPn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_01:2022-06-01,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020024
X-Proofpoint-GUID: PJxXX9wHvrhd0Q5p2IEJvyBJHsyxPtDU
X-Proofpoint-ORIG-GUID: PJxXX9wHvrhd0Q5p2IEJvyBJHsyxPtDU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have not received any feedback about v4 of this patchset. So RESENDing
after rebase on tag next-20220601.

The patches in this version of the patch set are as follows:

PATCH-1: Make kernfs_open_node->attr.open RCU protected.

PATCH-2: Change kernfs_notify_list to llist.

PATCH-3: Introduce interface to access kernfs_open_file_mutex.

PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.

Changes since v3:
 - Rebase on tag next-20220601
 - Rename RCU access related helpers and update their description
 - Address errors reported by kernel test robot
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2,3,4)

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

 fs/kernfs/file.c            | 270 +++++++++++++++++++++++-------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 +++++++-
 4 files changed, 258 insertions(+), 96 deletions(-)


base-commit: 5d8e7e3bbaaf115a935accd269873469928848c0
-- 
2.30.2

