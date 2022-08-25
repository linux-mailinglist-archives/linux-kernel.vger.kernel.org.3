Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B022B5A174C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiHYQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiHYQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:57:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E8AFAE4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:56:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhsbw006261;
        Thu, 25 Aug 2022 16:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GZqqGLvqnpBCl+2/732ZPNMjO5nlD9xb+VdpZ2NFsK8=;
 b=qhKRfImHy7bWdLkzy8NVLHgUxxsgKVn0kKMwFST7wUYoBx1fgRHy3XGS3ukdkt2TZJ1h
 kVoVDd9tS8laXRHOOOIjvSWhdhHrSEwopFsDDvIXdNXcxSAdT/9yGTfE+CjdaeXCUtA+
 2jsYQGcuXKX/hEash37OBYI0AO7uDKwNcsfbvvzLrbdSpM0EV4ok5Ck8UnEzvG0j6BE1
 pGWjFezBRwoBfTbjiRdL88HJ2jd7IjAKvBoPq8DbR6YZSWTYtURVYa0rKnOnJEUjAgpR
 v0/bIyGT2Kb2kjUO/LXyo1Dxtv63UvoktZxwmSrHiA+VR1a/jFK/nreXJ4GP0lsOM9g8 rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23y6hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:56:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJI4w009581;
        Thu, 25 Aug 2022 16:56:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6n4dbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAd5hIhd0sPEIP6B8mgWlPHC1Px67Gvuql/Ql79wSH4CSaU33ym2rfDzZK7awObdDmpjAfDGoub8T6dxFHdOaKBncxLgw3Wbw/uy0sCXEleWKh5VrKT/QXg99qsIEcvKnncKaQG3ifDhvlhbvmh3RNIyU7+uND5xFpprj2FQjChOqNHkKnER2tvkDQGroupg81h9sD3bLqK9XtRlyzvUU6oLJMWFAac2BaKZClQLwqbH3HYcN6jWWoCnY57mEsr7Xn0n7uUjU4VptDvsyjL01VyUBovbJFDHvwutBXJiSuujtjnVlWRs4+jdY7Wz73XdIjtTeThsUvdOHX0e94BdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZqqGLvqnpBCl+2/732ZPNMjO5nlD9xb+VdpZ2NFsK8=;
 b=FGQz+D3IBAbuoTasAshL0HkFxHWFavQaR3/TFzYwjBK6d54moz6jrzHbDOgyfj3PZxhudDT+wKTmqarPmMTT7QqIg+PAuRhjbYVibfIqiQsVArftvoqyiaxH3BCfmwBfOmgZocL5XaYYS7NTH3s/d5MvMi1K+JuQQ+bMRTbFd8fvbinlJP61VDPI0t1OnEsVmcryS2aQ+ro+256VyA7dveWVqReTUnI/7KrpHNEsTxGAQqCc77tRGl/zOY7Eg49v+lFownT5xMhet0BFR8zqalR62YHebFHBuSxv96hSrZRbqUObEq/dru1L1PXzZJSLOA3QzJEJ+u51BBz+hyFSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZqqGLvqnpBCl+2/732ZPNMjO5nlD9xb+VdpZ2NFsK8=;
 b=spTzB54qysi0Ez99JuPrzx4BeLQQCctKIAK/cl5Kt1w6uVHmOn22FlJgM5+3SKVUBAwGZiduI/jb+UMVXP56WiNXA/8/DDmfI5tgNxeZiqhJkjxcV10z/oLjDIv50J7L5mAlxNebgSkDtyoBgnN9zUM+YU9L+at2O/s11B53kYk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 16:56:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 16:56:19 +0000
Date:   Thu, 25 Aug 2022 09:56:15 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Houghton <jthoughton@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [next] x86: fs/hugetlbfs/inode.c:673:16: error: variable
 'm_index' is uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <Ywepr7C2X20ZvLdn@monkey>
References: <CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf89b94-e787-44cc-b929-08da86babaa5
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUU7ketSebIMwr2YmldNbnq+SWghN2BvcrOehIFkLCdiF6VHuICev29QM6wWtTYxj7heGlOGlNN1LEItfnP4Ds7vG9UIHejqAL8FvA0QqFvNGZMM/YtH2aax+ul1QNJvSCUEGcW1RfW3MIDFltWLTskIMSag9jhpjaFU3xFXW4wL9QoFEDlUoLBaZXZODf/MRqFpOityuNEw79LosAxHrqlWJ7Hp/FMNnUYJw8rhAR7tOWXZDUpgcIU2T8rPJdlT2skLCX8qHfa5vDBX+WuMIz8AraOvmUdZa/SGpgaifv0XvZgejT0zI3xQOm2Q7Jq5TZO2fl+slGyno5K710xgNbSAAzI2K1b1MWbaVFILm6rpBW1dcnQrfA1hLrIqcjyav+idb8lUEEIcw4G5Ynf0hZtReG1J8dxACjrZ5ZWUBGBPo1AQzHTooi1zfxGUUgGpQsofjJSk5U2njfeGl7HMQbeWJtEMmd8MddNt6qKW+7nqUrP0zo/xPOo8/mZ+X8wUsx9aUytusKXurnuTPlPCdoSMgObbARmBjN7qgmEjjwYEF/hh+0TDRr+Ikqh3n/3YznXTMsLRmLqCV4GGRRlOw1LD4RJZF/Bl/h/3XlMxDTZxu1URM6fNc5vG2ob35xF/cwMJkTBk4JGu6/aqw0+7fhA4mdCbfvQZJ9HTCUprHqM9UaXvneebUlgDoLgGubxKW587UECyrURwVOVG5IwPrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(26005)(33716001)(6512007)(53546011)(6506007)(2906002)(86362001)(9686003)(83380400001)(316002)(6666004)(5660300002)(8936002)(41300700001)(7416002)(186003)(107886003)(66946007)(38100700002)(66476007)(66556008)(4326008)(44832011)(8676002)(110136005)(478600001)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ndykdbC21JzfFQMnke8l6DVqTpO8GyxPX6eCX07Rjwik4+H6nVg39w4FJ3V?=
 =?us-ascii?Q?3XjSXrR/3DupZKebb1HpQ9WEyusqZjZWcMd2G5XxwD29suiFnT0CYsMpwKXb?=
 =?us-ascii?Q?6BnCPLp/TpIyzU58Ad9q6k40eitTv2759mGThjfT0SdUPJxt9yqUXpU38EI4?=
 =?us-ascii?Q?xsYMVIGc+0IIcHMwkVod/0jg5TtyWpHZU07QVFe/20+OUnIMalHXUjnPPcUN?=
 =?us-ascii?Q?PIEaMGQZU3TzJkPJ+AP0i8iFxyl1+MYeBD5OEDxH2vtwt57CHsZuBWI/u/KU?=
 =?us-ascii?Q?3sHLwmHRsx6Q4cPj+OgooafYTFj/IG5x54xqBWI7W5uZHu/GsncgRXrm4pCq?=
 =?us-ascii?Q?nscn7KnmnPv9hvdbUvCgCSIYAhDQG+6m2sIsYzZyYVe1Rd+3x2IIGFBFQTq0?=
 =?us-ascii?Q?BT9BCd5byC/pxnE1o6gL1YIo0Ge109bhqKnn3H9SUoKX/cKt6Df2jZQ/e0xX?=
 =?us-ascii?Q?tU0gU5KNMLd56hUYdPHqHNlp0nW1ygE0FbQc4aTHU2u+4NX4cvc61G2Nht/N?=
 =?us-ascii?Q?lXUb2IENWiIo+ucOmQZoIDujdZV7eEra6qVEYDAg2VFaBbtkZ/LHFcewBphM?=
 =?us-ascii?Q?Otgps/hGi6GBe37XdAkqX4o0Vpw2PYxC0leFTSC9nof5hQrObwz/N9esUZ50?=
 =?us-ascii?Q?+Ej4NJVt01e0EoCBv3ao1N2Dc3s+GMrG/5pOuHjtG6iiyF2bWg3w9MRSacVE?=
 =?us-ascii?Q?M7BKPTircjhuEwz0aYt179AuqYfJvr37aVvxEbXP03q/37EHID+cIXFIlz1u?=
 =?us-ascii?Q?t9b8DyB/kMQ1mYIpfi8fYsuuCTVFwAAOJdhF5GFetNGoPm3PTSpypLN8L0VY?=
 =?us-ascii?Q?g4iyUAcSlI910iam7QV6KlMXaRgE/TW2kUjYOSWHCglXQFZpsJOstyMLQAFV?=
 =?us-ascii?Q?i3qSaZqjwgzbk7N+vJxg8XQO2ODgRqULVUkPM4+o/K7MrN4kVvrkdv2FaxUR?=
 =?us-ascii?Q?2WK/4SgBcBT2jHoi/7RMNAUWZUVnqYCa26gYtuAWw7H0zye/GD2/MaTIx4oE?=
 =?us-ascii?Q?8fucZldxgtuToxHcVg/Cw552jznXcAzeJBKGwca0TRPvoPJ5wAmVHoLUIY/U?=
 =?us-ascii?Q?ksqCkqATZp2ap0l9slQT4quYhyRdTkLvZDcPhe2/2PpXoIY4q++EmfzoTdl3?=
 =?us-ascii?Q?MdTbn6Yhi5+DcNBb3GCavnxTcPmH+iLsobYSrB0ij6ghDejrqfCIpfolT/iD?=
 =?us-ascii?Q?33t8jpEdA+Al5CxwotLabuMK+JJ4Dpb7MmNzUECaDIoIeCWLS+/R2jDmxm7E?=
 =?us-ascii?Q?U+dp4fDywU+CxeScBUX7A0hHo0fKmAwC2gRqq2WPQfdAzjHddmVpiV1NVWqj?=
 =?us-ascii?Q?B9HtkE4ZfQ/X6qTHtrxeijWlxXgMcyrEjdAFV/K46zmZYYfnkSQaSHV/PXZW?=
 =?us-ascii?Q?JqYZFTJ6YrVLHpmyc+M1PtGZ/Y542y9peb4fy1+LiRVOHr+Xo09PY1a2Z69l?=
 =?us-ascii?Q?OZpDquHUk9zj32FFj9UM7feww7g5Flg7QTGFHVFJv03ls9UTO9886Lg1aalh?=
 =?us-ascii?Q?LBfWyZZloCHeOo7Pj0gmM43nPdYsEE4HMFsNzm74wHxyQ5SumswmA9iGZUCJ?=
 =?us-ascii?Q?HxC//5jVdPwm9QMglK8k1WGvlkiZj0mNnJaTiJwF+i/J4rWqjuusCIoj2Dcb?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf89b94-e787-44cc-b929-08da86babaa5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 16:56:19.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXjfKcnW7NXREHijLa5PpTvFsY0MGwFWZkoz+CzPio07yzA39DG1XA30oKXXotzn02/kRkHOpwabOoooYGSEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250064
X-Proofpoint-ORIG-GUID: AiePTlAF3zJx_NPoeI21V2YKI4pZnOQa
X-Proofpoint-GUID: AiePTlAF3zJx_NPoeI21V2YKI4pZnOQa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/22 16:13, Naresh Kamboju wrote:
> The x86_64 and i386 clang builds failed due to these warnings / errors
> on Linux next-20220825.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> fs/hugetlbfs/inode.c:673:16: error: variable 'm_index' is
> uninitialized when used here [-Werror,-Wuninitialized]
>                                                 m_start, m_index, truncate_op);
>                                                          ^~~~~~~
> fs/hugetlbfs/inode.c:651:26: note: initialize the variable 'm_index'

Thanks!  That really should be 'index' and not 'm_index'.  The variable
m_index was used in a previous version of the code and should have been
deleted.  Depending on the uninitialized value of m_index, this could
cause long delays as the called routine checks the range m_start to m_index.

Andrew, how would you like to address in your tree?  The following patch
can be applied on top of the original (next commit fcc0d3d00d74 "hugetlb:
handle truncate racing with page faults").  Or, I could squash and
resend the original, or resend the entire series.


From 99aae359c3a744e6718045d2f24b55c84bed4d56 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 25 Aug 2022 09:49:08 -0700
Subject: [PATCH] hugetlb: fix/remove uninitialized variable in
 remove_inode_hugepages

Code introduced for the routine remove_inode_hugepages by patch "hugetlb:
handle truncate racing with page faults", incorrectly uses a variable
m_index.  This is a remnant from a previous version of the code when
under development.  Use the correct variable 'index' and remove
'm_index' from the routine.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 52d9b390389b..2f1d6da1bafb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -648,7 +648,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
 	pgoff_t m_end = lm_end >> huge_page_shift(h);
-	pgoff_t m_start, m_index;
+	pgoff_t m_start;
 	struct folio_batch fbatch;
 	struct folio *folio;
 	pgoff_t next, index;
@@ -670,7 +670,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * due to a race with fault code.
 			 */
 			freed += fault_lock_inode_indicies(h, inode, mapping,
-						m_start, m_index, truncate_op);
+						m_start, index, truncate_op);
 
 			/*
 			 * Remove folio that was part of folio_batch.
-- 
2.37.1

