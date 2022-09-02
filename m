Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B705ABB0A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiIBXId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiIBXI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:08:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3239F1B4C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:08:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282K6QU6001624;
        Fri, 2 Sep 2022 23:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=beNqB7bsZRQkO1JQ+4hdciQy0oDD1zYmgF6nsuli294=;
 b=VYrn/Gx6LiefQul28secrrJzM8eqaZUJWmvN8dXRhhsmdxMS1dUCrw4ndC/gRASWCGB6
 JhK4AUlyEREGyN7hfML2Z1kAScC/4xjCrV8pNMhe0ZtsO0RF4+4oDPStMqaOPFJBXsQH
 nrMJJI8luDUhG3UZOUaV4PSEIaCX6yyNkxW6KnzUHYO/0LvQXTZnfYUqM4RN/4lX8Fmz
 LRC9CsFPNFKgDRh59KgWLqbOAWZJ87DmP9UIFynvjkGg7aVXNa1P9YMZ4nngRYehiX0R
 eIA5BXTFtnp7/mnndyLSEpag6tPuW87dTSvTy5d97kT5x5SQR3CBq5E9d5I63jzPX9HI ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7bttgb54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 23:08:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282Mnl5r019724;
        Fri, 2 Sep 2022 23:08:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q7xs2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 23:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+/kCPga+zSJAxqHMg5kHJiZyMxSpHbmTdavhbHYqnKFOchUojQe+Mf6aw/2UF6fArmRpt/MIucc6yUHY1bPJnHV/iZDHGWe0MB3yQnxQDVDo4/pm16tL1rAjuCQoesF8h1mCx1/DQQ5rnsWAoclkeL63pI6xdEUZOEzW6NeIlisWY4Lu6Ardx2cXTtA8STnlbrfd+LloAGcliKRrdoiBNGq8F28rgisC2NxDxWd3QKxSgX/lSr7gRL6HRnSH1TrN2TQ44tJS9QnsVSCN5yNsm+Huxhhi+w3c5hewM6yEmpe8dBotMnMv4HlcYT65mRWr0AtKbG14SKCEta4ELVRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beNqB7bsZRQkO1JQ+4hdciQy0oDD1zYmgF6nsuli294=;
 b=dJTRwzZKQB7qUP6XexkZJK82dzgNOog8KILmjHKQUeqeunOLKC91LxAPi8Wo77u4DIXpwNyzrM1b3VxjlAQt478vLu2MC8PAHQsv9FjARrfxsXSYHJ3cBzs14TXqJyECfVkFw1A4DKYPwRlCJ0wsE/ej482XRf8HOJ+6kbuUMSBXgPTYXYe23F+2KjSr0z3qPDg/i3dqJS0hnINxvNr0J8xjIOdD6tUQf1mlU/D55ve7TgORb2v4pDvpexfP0z422MD8V80FgEsq5L+VruGiZTV5ug46p+7jP3xU+P6vg1MAdmh3eVPJ3w55DssHzoqrh+PwJYgbHGGPdizWG3E4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beNqB7bsZRQkO1JQ+4hdciQy0oDD1zYmgF6nsuli294=;
 b=zy7DZemg+bBQgRAGUM67jlnc1zWZjD5uuYKm4JqVtr1bckIM/cXB6pgok4TYYZyP7HuvommjHaCWXguC7sOugW3AKvK9vfQWOBb8Yglk6tqxwSsqlT0+wBMYQw5SZx3qmMnAEqSUpyVu+bOJAdWeR2oXbmBzV8tZsoQcT+/1uEk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Fri, 2 Sep
 2022 23:07:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 23:07:58 +0000
Date:   Fri, 2 Sep 2022 16:07:55 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
Message-ID: <YxKMy3sDsWPEOMMJ@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-9-mike.kravetz@oracle.com>
 <08edc08e-08ab-0706-3c8d-804080f37bd7@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08edc08e-08ab-0706-3c8d-804080f37bd7@huawei.com>
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 949d7ada-241b-4524-15e8-08da8d37fa20
X-MS-TrafficTypeDiagnostic: DS0PR10MB6173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfKMkFiCebFa3iVQHe7+hQvCs1t4UKu/XvUEEixifJQHaGsB1iNklluU/dyJd2+v0Kh3H2lj4RtwGI26czF6sU/o2wmm02dFri4pULjHiXuWSjGsDKnnOMoG08XrSj/Pq8/61vGdkIrQbDxUy/zZe0c++uDsVZweGKF0RaW5Qu/T5kTS6/v3k+ShjiEHvg/pkpXm3cZJEJWWdsf7l2mhU1RtuWs1nZILzqSSZBY3NzNQvYOrphs3we3ZyK+WIuLUDZMqfx3vS36/paRrC4r3xIMGcyKbr0Mhon0ifQ+Lr4iXUhNY3Ok7cWerrU+37lRByKBwgPamRu6EQ2fp2LdWPcxUr/souwaXoZ2vYR3jCfVkUcL8+M5SKH/1E3g+hgMW40BVvJcmCphXbRHmxpltS4SlPEXZLnst1BlIjX54LJ9BSVTc/yp4zyF1C/k5xdnNxr7tdWYQqEutmfJAt3CG2QRHcNnzNm7KPJz0nio4tnAFhtXyHUkR1JYWWh/eIYRIboShY6zxsaFDZQHo+FPF5i0EaPAUm2j294nnc0Aze7GtkZnY40J1fXP92X5sm8VcdnPK3eVtC4+tNmJHumkGPudMMpoZ+gQd6XsR7KOB+J5/uCtDYvLu+iH3vIpljomw5pQD3nRAqh5HNg1mRhlhwuWzkHDaoFNUH/8HLPmnjB9zVuPf/ii9k4BR6e/escid8eIjNV3GZkFC/BmTa5kCw7bKeMrbLeuchccabxy6EcLaO2UPvf/Y/vy4PNuZsV40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(6512007)(38100700002)(2906002)(9686003)(186003)(6916009)(316002)(26005)(478600001)(6486002)(53546011)(8676002)(5660300002)(8936002)(66556008)(54906003)(7416002)(6506007)(66476007)(4326008)(44832011)(33716001)(6666004)(66946007)(41300700001)(83380400001)(86362001)(134034003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tM+HiRIv8wn7CKO1FWzqUbiyiaNvKID/I+X1VsxNr/VFrbHXWTQOji3RecCb?=
 =?us-ascii?Q?7u27xe2qSaDf7jSLRLkwMEGfNF1AJH7YpXfrPHK2xpMaK0nPMJyG8UL0GTKN?=
 =?us-ascii?Q?VfXduGLQx7UJ91ciPnYWnMbtFkFPTVHcbj2eRwEFmpIl0k/uwGi15lDA67CM?=
 =?us-ascii?Q?lgs1VsW59dLsPHbpmApw6QHh3HOq7DKo2kmKkq43TaiNxfEiLB44eFNput/I?=
 =?us-ascii?Q?5wuupTpZJu/CWGpcwNoL4NGMKRktpVyuS8MGVXj5PeYDRBtTwOnjFBZ38+Ks?=
 =?us-ascii?Q?2HZpKxVBZzSZ6ho+/LxZHgQSbmDhPPU47PNIilKFzrN8QmePxyyKMw6KR0PV?=
 =?us-ascii?Q?D/d2iJU7VagNSkUqvndrk8i9oykywhoQ9t35bkbTPKgaq4ctYFKPi9nXQVwP?=
 =?us-ascii?Q?7JBlknGxqAwHJydogMUlB8u0G6F0EgJjNb/64jMz0/j18hIX0m0qCq3YsPKR?=
 =?us-ascii?Q?zZ+jW20AOTgwD51IPfhcYBhvJAuN+8ZFFnWRbEJmxNy09oIENK8oIKTeDIYC?=
 =?us-ascii?Q?s/S7MLVIbBH8g11T1JplXQ3t0YAJMdBL2rxpkOWUPzevZy0WtehDXL01p0iU?=
 =?us-ascii?Q?VGnWus32wXsMm3We5Dhbv8cwV9dVoxNyIAFXYligydHsYsT63PuvxZYgQl0r?=
 =?us-ascii?Q?JZnToYxOQDWzIPdreS9PJ2tK0U8fUKD0Z3+zIPZ4hkUFYb9a5M0QvFc2X2MR?=
 =?us-ascii?Q?09d8RlWNIkoJnAX7tN0WgHiGflQqLkqjGKQeqIzSIoBSXMUM130UPCP3SF2+?=
 =?us-ascii?Q?dHnC1lhkWNqzXT7Ptc6FBpwEdOZvl9I//+WW6HdXB9o1w4yaPjwLUBTzi1sX?=
 =?us-ascii?Q?n+mci7vs2fv+GmA54/VedOexFcgM1qqotAmH/+q/p5UNmWAS9bw8DE/TeUZU?=
 =?us-ascii?Q?AIBUsaRrfKIRXvhZOjvZI3LTKcKF1yzhZHocQHVrUQl4K0mk+09TI0DcWS4j?=
 =?us-ascii?Q?xkk7Bb7Q3+9RhpPHVjRSLtD1cQquolHS6QDxcP88aLFmYmhuO6CO2bVh2swB?=
 =?us-ascii?Q?MWR2hLrA7ivQz2wz981a60yQI+pX3hwlOoJP3S/pqVTZldJu1YDW8WcW3B3n?=
 =?us-ascii?Q?In1jt1AAAhAFSYzluK8nd7j532shncSQqYxCgJvFPooepoNR47nhPAwNiXuU?=
 =?us-ascii?Q?tsQBAxefjpSZqmc+nesoIPpSnFNBPaXmN7MzX1dugOoVloVrvCFHPJD5Le39?=
 =?us-ascii?Q?5ZmII/PY7XPF1xEvSGOUqP+bm7fxeQav991mkcrWABzNOpm2YN3pMb4egVmv?=
 =?us-ascii?Q?/ZvZCMlW2gt5hbG/eksSom0LkHiv8dviinMANPoucA0FzJbNd5xVz0Tb1HBX?=
 =?us-ascii?Q?VJY9CUP/lOS0s2YDKI7Zuc+XPPKnFrIM2z9PbMeNI+ffPvWxVsr/8q2Dz+yH?=
 =?us-ascii?Q?m6Gg9qT7TvJSUsl8eZvisiOxcWGwjq7ao04+AKHnfs+sgNt5mBC/hg6Pv7b9?=
 =?us-ascii?Q?MaLoE3Qr/kBaf70gr39vTsjSLsew+S0rproO9MaD+UePBuR0qg84e1IOz0bk?=
 =?us-ascii?Q?OMaK0nYdMC3sSAt9kPy6ZXd8etj2NAsBIUoUIxfcE9JQOS9ZhaFun7GLG4JB?=
 =?us-ascii?Q?my0ky36CmmVEEHAQdDUBqKm76TNCQeMh69l069MNd5N0iJ5kQZ0xadff4p3z?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949d7ada-241b-4524-15e8-08da8d37fa20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 23:07:58.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2vna1zyM2V7Puf5I/O0RlHxAIpR1ipg2D3N5gjWp7XAx5YleszhKpQ2zAbWvX9sC1+7Biw/42UNK5Fyo3oMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020103
X-Proofpoint-ORIG-GUID: OcoXJHtujBBj5dsVIjBvrURQKoWCBIlV
X-Proofpoint-GUID: OcoXJHtujBBj5dsVIjBvrURQKoWCBIlV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 10:02, Miaohe Lin wrote:
> On 2022/8/25 1:57, Mike Kravetz wrote:
> > The new hugetlb vma lock (rw semaphore) is used to address this race:
> > 
> > Faulting thread                                 Unsharing thread
> > ...                                                  ...
> > ptep = huge_pte_offset()
> >       or
> > ptep = huge_pte_alloc()
> > ...
> >                                                 i_mmap_lock_write
> >                                                 lock page table
> > ptep invalid   <------------------------        huge_pmd_unshare()
> > Could be in a previously                        unlock_page_table
> > sharing process or worse                        i_mmap_unlock_write
> > ...
> > 
> > The vma_lock is used as follows:
> > - During fault processing. the lock is acquired in read mode before
> >   doing a page table lock and allocation (huge_pte_alloc).  The lock is
> >   held until code is finished with the page table entry (ptep).
> > - The lock must be held in write mode whenever huge_pmd_unshare is
> >   called.
> > 
> > Lock ordering issues come into play when unmapping a page from all
> > vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> > vmas, and the vma lock must be held before calling unmap which will
> > call huge_pmd_unshare.  This is done today in:
> > - try_to_migrate_one and try_to_unmap_ for page migration and memory
> >   error handling.  In these routines we 'try' to obtain the vma lock and
> >   fail to unmap if unsuccessful.  Calling routines already deal with the
> >   failure of unmapping.
> > - hugetlb_vmdelete_list for truncation and hole punch.  This routine
> >   also tries to acquire the vma lock.  If it fails, it skips the
> >   unmapping.  However, we can not have file truncation or hole punch
> >   fail because of contention.  After hugetlb_vmdelete_list, truncation
> >   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
> >   check for mapped pages and call hugetlb_unmap_file_page to unmap them.
> >   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
> >   correct order to guarantee unmap success.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  fs/hugetlbfs/inode.c |  46 +++++++++++++++++++
> >  mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
> >  mm/memory.c          |   2 +
> >  mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
> >  mm/userfaultfd.c     |   9 +++-
> >  5 files changed, 214 insertions(+), 45 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index b93d131b0cb5..52d9b390389b 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -434,6 +434,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  					struct folio *folio, pgoff_t index)
> >  {
> >  	struct rb_root_cached *root = &mapping->i_mmap;
> > +	unsigned long skipped_vm_start;
> > +	struct mm_struct *skipped_mm;
> >  	struct page *page = &folio->page;
> >  	struct vm_area_struct *vma;
> >  	unsigned long v_start;
> > @@ -444,6 +446,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  	end = ((index + 1) * pages_per_huge_page(h));
> >  
> >  	i_mmap_lock_write(mapping);
> > +retry:
> > +	skipped_mm = NULL;
> >  
> >  	vma_interval_tree_foreach(vma, root, start, end - 1) {
> >  		v_start = vma_offset_start(vma, start);
> > @@ -452,11 +456,49 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
> >  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> >  			continue;
> >  
> > +		if (!hugetlb_vma_trylock_write(vma)) {
> > +			/*
> > +			 * If we can not get vma lock, we need to drop
> > +			 * immap_sema and take locks in order.
> > +			 */
> > +			skipped_vm_start = vma->vm_start;
> > +			skipped_mm = vma->vm_mm;
> > +			/* grab mm-struct as we will be dropping i_mmap_sema */
> > +			mmgrab(skipped_mm);
> > +			break;
> > +		}
> > +
> >  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >  				NULL, ZAP_FLAG_DROP_MARKER);
> > +		hugetlb_vma_unlock_write(vma);
> >  	}
> >  
> >  	i_mmap_unlock_write(mapping);
> > +
> > +	if (skipped_mm) {
> > +		mmap_read_lock(skipped_mm);
> > +		vma = find_vma(skipped_mm, skipped_vm_start);
> > +		if (!vma || !is_vm_hugetlb_page(vma) ||
> > +					vma->vm_file->f_mapping != mapping ||
> > +					vma->vm_start != skipped_vm_start) {
> 
> i_mmap_lock_write(mapping) is missing here? Retry logic will do i_mmap_unlock_write(mapping) anyway.
> 

Yes, that is missing.  I will add here.

> > +			mmap_read_unlock(skipped_mm);
> > +			mmdrop(skipped_mm);
> > +			goto retry;
> > +		}
> > +
> 
> IMHO, above check is not enough. Think about the below scene:
> 
> CPU 1					CPU 2
> hugetlb_unmap_file_folio		exit_mmap
>   mmap_read_lock(skipped_mm);		  mmap_read_lock(mm);
>   check vma is wanted.
>   					  unmap_vmas
>   mmap_read_unlock(skipped_mm);		  mmap_read_unlock
>   					  mmap_write_lock(mm);
>   					  free_pgtables
>   					  remove_vma
> 					    hugetlb_vma_lock_free
>   vma, hugetlb_vma_lock is still *used after free*
>   					  mmap_write_unlock(mm);
> So we should check mm->mm_users == 0 to fix the above issue. Or am I miss something?

In the retry case, we are OK because go back and look up the vma again.  Right?

After taking mmap_read_lock, vma can not go away until we mmap_read_unlock.
Before that, we do the following:

> > +		hugetlb_vma_lock_write(vma);
> > +		i_mmap_lock_write(mapping);

IIUC, vma can not go away while we hold i_mmap_lock_write.  So, after this we
can.

> > +		mmap_read_unlock(skipped_mm);
> > +		mmdrop(skipped_mm);

We continue to hold i_mmap_lock_write as we goto retry.

I could be missing something as well.  This was how I intended to keep
vma valid while dropping and acquiring locks.

> > +
> > +		v_start = vma_offset_start(vma, start);
> > +		v_end = vma_offset_end(vma, end);
> > +		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> > +				NULL, ZAP_FLAG_DROP_MARKER);
> > +		hugetlb_vma_unlock_write(vma);
> > +
> > +		goto retry;
> 
> Should here be one cond_resched() here in case this function will take a really long time?
> 

I think we will at most retry once.

> > +	}
> >  }
> >  
> >  static void
> > @@ -474,11 +516,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
> >  		unsigned long v_start;
> >  		unsigned long v_end;
> >  
> > +		if (!hugetlb_vma_trylock_write(vma))
> > +			continue;
> > +
> >  		v_start = vma_offset_start(vma, start);
> >  		v_end = vma_offset_end(vma, end);
> >  
> >  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> >  				     NULL, zap_flags);
> > +		hugetlb_vma_unlock_write(vma);
> >  	}
> 
> unmap_hugepage_range is not called under hugetlb_vma_lock in unmap_ref_private since it's private vma?
> Add a comment to avoid future confusion?
> 
> >  }

Sure, will add a comment before hugetlb_vma_lock.

> >  
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6fb0bff2c7ee..5912c2b97ddf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4801,6 +4801,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  		mmu_notifier_invalidate_range_start(&range);
> >  		mmap_assert_write_locked(src);
> >  		raw_write_seqcount_begin(&src->write_protect_seq);
> > +	} else {
> > +		/*
> > +		 * For shared mappings the vma lock must be held before
> > +		 * calling huge_pte_offset in the src vma. Otherwise, the
> 
> s/huge_pte_offset/huge_pte_alloc/, i.e. huge_pte_alloc could return shared pmd, not huge_pte_offset which
> might lead to confusion. But this is really trivial...

Actually, it is huge_pte_offset.  While looking up ptes in the source vma, we
do not want to race with other threads in the source process which could
be doing a huge_pmd_unshare.  Otherwise, the returned pte could be invalid.

FYI - Most of this code is now 'dead' because of bcd51a3c679d "Lazy page table
copies in fork()".  We will not copy shared mappigns at fork time.

> 
> Except from above comments, this patch looks good to me.
> 

Thank you! Thank you! Thank you!  For looking at this series and all
your comments.  I hope to send out v2 next week.
-- 
Mike Kravetz
