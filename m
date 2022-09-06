Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917FA5AF1B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiIFREN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiIFRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:02:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6BCB11;
        Tue,  6 Sep 2022 09:49:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GODFr004254;
        Tue, 6 Sep 2022 16:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SnDj421lK5Cgmq+CjDEkE27BzcWb59naBI31EwGMlTs=;
 b=mke4j2cYvOfWUqbdHfbu7O21XfaFdiiYC1SuLvzZo6Ju0Uynu8GqSCcFlLOVga1NMA46
 lP0loDaU4fVJNNxqYX8c1f4bEIfQci7MChFVxXcbBd6w831a1BreZnuSIk+xs5EGaCx3
 /+GYU1xT5MCclGm2rLiqu5QQY5/OBSPQTEqAhpvLH77P2ke2gOB5cC0k2vCULAyaFmP3
 8EvBj1ovweabJltdkeoSbfQHQhYXXCUdj/vmxUfxtcllS4XMb8KzkoHR/MG0zcC4uKj8
 +Yc9icYAhsjDZ10AEKwd/U8YUJJ01jr5oab1SMgdLf4l0XcCaFU29Jdy1bYzMjp9Y5cK ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1efjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:48:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286FtDw3039932;
        Tue, 6 Sep 2022 16:48:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9e5gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkbC/bS3w72dWOXCsILZZVIVEGgqinAeApIgnkCEiZCLj7xmnkwCE176erFAqNiq0UZeRmAMyT2+dK8H0OH6znMzdQ1zTjvc9LWG5iUZAhCt6lVPBTdTdeNbdEwjONRRbNk/TbWH96E2B/E93Mt5V4D1C7P7VzREHmL4XC/VPVuJdyw4NIwSmBW9WRh+2KNWT3f25L736EMrsOxyXEeXGiqdhCwSF8o36gSKTk19BXC8ffDpyFKbllIQp9PJUzo6mHvvm0JxaDnpmUkuBHkbs3hj94SNWB3F4p+vRp+3hMnHZOCqyCmCPpynoYNUTANvz5PFJ8UsCWrc/0c+CHNLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnDj421lK5Cgmq+CjDEkE27BzcWb59naBI31EwGMlTs=;
 b=E/HS7VALNcW4Uug/n41QJZu/3xNY8R+QyyFazendtyUSezYOx9TFasYmYfAwweEpgmXucQPtAOGxASJsQOB/4IMR/eCMQd1FVWYh15lcI8g7pwDEpN0v2BKO/QCNlQMygqZmco6dD7mi1Dl1LixuSSVW7uufiUHn1qBacO/Gf1WMLKnAHZ5oyS/kHuAQpJSYlNnsRMMqeQsgyR1awhAI50yvXOmW86o8Q/z4UQImX+Z8D8FvM7Z0yyBNtbjJ7o+kMrcAJ7KWn6bK0ygjjGSaj+YMFbkY2y7EBEkw5JLYopgNMDDVp+5kl454x205C6+p+jiY7pzv8cwJCUZZm8h46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnDj421lK5Cgmq+CjDEkE27BzcWb59naBI31EwGMlTs=;
 b=zvIPTG/Y8wHXAVsFHIJJnvfG/3xxYwsfasfP4NeuWJ0V1W1Yk7qjEEIa1uLPUZFvgGYihXjCLwvAA6ukuAU+A7rfq89OeDXduETUWwT+5mvAejV8JXbpYauurJuZtrikdWOaFljZ3pt+olNw806tBwf6zGttY88FbFFgOkpDBzU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5307.namprd10.prod.outlook.com (2603:10b6:610:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 16:48:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:48:19 +0000
Date:   Tue, 6 Sep 2022 09:48:15 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <Yxd5z0c8NlKVlVqk@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dr10ok3lm.fsf@linux.ibm.com>
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76d008ce-f5f2-4a55-60e2-08da902799f8
X-MS-TrafficTypeDiagnostic: CH0PR10MB5307:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6Fa3sD7zU8N/Q3wX8RCVtww72vvXugHjPpMISvGlKgNVX32FRiHGLfeCDWglyS8K5Hsr3/FeM9GKxyoBOfpw54ZsEWi0zF9SWdfMCM4EYcG0TOalZZp9rtXVzEYb9jhF0gy224tV5BckJd2o/kWf8mja8yOfDAujTUcZ0v2WR8uGznzlinLZQbuTVz5WW/aX3Wf21Wfzuhs1CcQLVhBx7EevomXAraspNn2fWqNnNC2IqbgZx9vpz66zVDIC6Il2KinZKesiddXHb3P4W8SU+e6BFLG6tnAjOVDtXJOPh5nYUKbJcUJZcrQl3ES1TDE1xCarzDlMgaLzFXDQIMtqCtXJJxEGodcvMwxib++o8Ia3IqcCyzmCw+wLrPvwseSV8ofKOE5ZQ8mtVj2roeHmc9tD7PedWnh56/GnDBIoqpZdAV+K9g99ZyzB2WlWzrtQlVWGpRck691qTon1MDyEuqBvWdy7KP1g0fXp00TuHwzXGNPky2cnReYEiIMGkAAMOYSDVn4enAR+8CDZoXo1kXeyKshXOBrwMOirZHvzrak9H3QcEKzANu8NKgBPN/9D6lpLmGRyFhhQAGKzG+EBo0Kwtbn/LGlIK6jZReCOZ3zjDuhdxN6pXwcCp0/Puu3HbwKI4VWAavdBLad84KoEKOhpdniatrjJujPrOJsvLNffO9Y2DtMSv57XO088/Uk043BMp8uNvAnqRlyYSI6N1x/RiY5Syz3SgIAY/aI7sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(26005)(9686003)(83380400001)(8936002)(7416002)(53546011)(5660300002)(2906002)(6506007)(41300700001)(86362001)(186003)(966005)(478600001)(6512007)(6666004)(6486002)(66946007)(44832011)(66556008)(54906003)(66476007)(6916009)(316002)(8676002)(38100700002)(4326008)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7X/J1b3g7QjXeXtajYbl64TmtzKPUzvFE6C5Rt0DZ73bpgufFPA7YhrDYDO?=
 =?us-ascii?Q?n7hgaN8ZArnN2txtHSs8q9PelaPR+afDLZ/NQSY99RI3/35A9/MTfXycbq8e?=
 =?us-ascii?Q?CfiuP9WoNzNn4hKzXfZq88hQiM8i80tXzzAxWjme4yePZZyyhSYn5qXX7Txn?=
 =?us-ascii?Q?ilYQ0IMOPmLEW+j7H+SkhROl3FRw30cr5pbQUE4LogZMI3UuN7aophgF6jlB?=
 =?us-ascii?Q?FZ7f06TOZy1tFix3lSUb70hmv5UKgzSbWcErbs+elggwO04iUUwDpAutaWp2?=
 =?us-ascii?Q?IGCu6DxHfeF7DgvzCzyIRaeQ9U3ajKd0XLurwhYdqv7V7AMXIKDEQm6RJPlr?=
 =?us-ascii?Q?AhJZTLgQFTMks02/hKqIiYJoYe9gxAAvL6T+1ys8ergq+/yhVh/lbBS+O1p1?=
 =?us-ascii?Q?vrSqjJ1I4gxTaEGXH1eRUGwkcENb2ZPtrshI8JUDibiWmKe8gCpiF6/sob5k?=
 =?us-ascii?Q?IcCDirhjpg0yGYCUg3UPkm4zIzZeb0tnmKIinC3Lk4ZaIpK9uqMGYjzHacik?=
 =?us-ascii?Q?V5bO5o7cZKksubA/J+lOfs8ohfbzBqUqQ9TE5QM5dLWkhZk7sd3OfMxf7lYb?=
 =?us-ascii?Q?qgJpdLWPTPgxEtFgNpz4D7/8WH72CreOhXpA/U+oQAziKV/Gu0H1F8FRfiFY?=
 =?us-ascii?Q?OS0BcfT5rmVd6jZH2/LPOx80YhWoxgilEWDnJsY7wSQ90Rk63mwEI6SuQL4c?=
 =?us-ascii?Q?cpmxvkN7NnvDE0Fs6mRnaGAphQyI2vR9GuI6G+lWi/n2xpeBJxVVEQVwsRvc?=
 =?us-ascii?Q?knuUt+p7/mBPSybVkPcjU9qZzX85049AywIsZYW6dIo8886JJUsBkWRYb/Lx?=
 =?us-ascii?Q?GnKqUdZ7c0y8RcOo8U7qLt+ten6/LM9ELJzB6RVyViOQ/sC6ENXxqWG4vfwm?=
 =?us-ascii?Q?oNPafO10wc56t1nMPEQWDlpHGCS1gadLOMOEuNC3UT0SuotN0BcnOy8EjXQ/?=
 =?us-ascii?Q?SVGag6YOOK+xhRRmTQc1pLLM6UQT4kesrRMOwo3h6y2Tt2mIKJ+RMHdRkHe8?=
 =?us-ascii?Q?h8SmzORrjipY5NanA3s9eI3WFbTruCXpog2eNPG9PsVi1ycDdOlO39IVqync?=
 =?us-ascii?Q?/D7ffr00XXA6KTkt5HW70DQ61MKs6KmSqvKM0rmvGK7v4bnih5eoMxlFYlGV?=
 =?us-ascii?Q?iyjY5Yz7ZakeV71fZhtb2OOQKZ74GiOVL5yv1okbKqQ55k0AvcNEa9UDDioK?=
 =?us-ascii?Q?ziCsask73LRnyzT0GMVHBXin3ztn/sKVV94Yj/pMp+E3vPKRyPHqL/RB/rkr?=
 =?us-ascii?Q?h5mDuuWZCAfP/1WXs/Voe2MfhTBNty3g4z2Rjm89PmfDAxjR+onHwE8YHsEh?=
 =?us-ascii?Q?zt2GVTPR4cDYPQzA0sHES9has8RE/+psIXph1q4hZz6Y65egWEwh6vj8r+kP?=
 =?us-ascii?Q?zMRT+7pUIQgAlQBBjcdPwLO5EWzxqkwHOQilgPvfqFvT1LrGLvAM34TU6sn7?=
 =?us-ascii?Q?8z9ZIgUYHe/NEk9BbkODWLSOeGhrjMl9pQUxCD9GtL30QRDu3JGjhZd4v4Iu?=
 =?us-ascii?Q?41DOojTE95oB2ALpb+ZZki258doqDcR1xr6x/xoojGUyKNqMEAEeVJE2V6w3?=
 =?us-ascii?Q?PLADsRQzwTWklql/e0LTjG1GpHaohyj8N4xZ6SC3l3U5KzEMytTMxr0kYUBf?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d008ce-f5f2-4a55-60e2-08da902799f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:48:19.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7NlZj7LEjN+BQzFRff7m1XX8Fvz8YVEt02wfZvs0JyJjxT9yQ8wSTVL8fD6qQ7/4xafBgNQqvjB2Hfk0eXEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060077
X-Proofpoint-GUID: 11WoU_FJpMwEbO59Ia_BuzjmwfK21HDh
X-Proofpoint-ORIG-GUID: 11WoU_FJpMwEbO59Ia_BuzjmwfK21HDh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/22 15:57, Sven Schnelle wrote:
> Hi Mike,
> 
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> > When page fault code needs to allocate and instantiate a new hugetlb
> > page (huegtlb_no_page), it checks early to determine if the fault is
> > beyond i_size.  When discovered early, it is easy to abort the fault and
> > return an error.  However, it becomes much more difficult to handle when
> > discovered later after allocating the page and consuming reservations
> > and adding to the page cache.  Backing out changes in such instances
> > becomes difficult and error prone.
> >
> > Instead of trying to catch and backout all such races, use the hugetlb
> > fault mutex to handle truncate racing with page faults.  The most
> > significant change is modification of the routine remove_inode_hugepages
> > such that it will take the fault mutex for EVERY index in the truncated
> > range (or hole in the case of hole punch).  Since remove_inode_hugepages
> > is called in the truncate path after updating i_size, we can experience
> > races as follows.
> > - truncate code updates i_size and takes fault mutex before a racing
> >   fault.  After fault code takes mutex, it will notice fault beyond
> >   i_size and abort early.
> > - fault code obtains mutex, and truncate updates i_size after early
> >   checks in fault code.  fault code will add page beyond i_size.
> >   When truncate code takes mutex for page/index, it will remove the
> >   page.
> > - truncate updates i_size, but fault code obtains mutex first.  If
> >   fault code sees updated i_size it will abort early.  If fault code
> >   does not see updated i_size, it will add page beyond i_size and
> >   truncate code will remove page when it obtains fault mutex.
> >
> > Note, for performance reasons remove_inode_hugepages will still use
> > filemap_get_folios for bulk folio lookups.  For indicies not returned in
> > the bulk lookup, it will need to lookup individual folios to check for
> > races with page fault.
> >
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
> >  mm/hugetlb.c         |  41 +++++-----
> >  2 files changed, 152 insertions(+), 73 deletions(-)
> 
> With linux next starting from next-20220831 i see hangs with this
> patch applied while running the glibc test suite. The patch doesn't
> revert cleanly on top, so i checked out one commit before that one and
> with that revision everything works.
> 
> It looks like the malloc test suite in glibc triggers this. I cannot
> identify a single test causing it, but instead the combination of
> multiple tests. Running the test suite on a single CPU works. Given the
> subject of the patch that's likely not a surprise.
> 
> This is on s390, and the warning i get from RCU is:
> 
> [ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
> [ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
> [ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
> [ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
> [ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
> [ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> [ 1951.907095] Call Trace:
> [ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
> [ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
> [ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
> [ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
> [ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
> [ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
> [ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
> [ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
> [ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
> [ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
> [ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
> [ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
> [ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
> [ 1951.907145] Last Breaking-Event-Address:
> [ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0
> 
> One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.
> 
> Any thoughts?

Thanks for the report, I will take a look.

My first thought is that this fix may not be applied,
https://lore.kernel.org/linux-mm/Ywepr7C2X20ZvLdn@monkey/
However, I see that that is in next-20220831.

Hopefully, this will recreate on x86.
-- 
Mike Kravetz
