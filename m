Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95135854DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiG2SAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiG2SAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:00:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8337E33401
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:00:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THxHm8009942;
        Fri, 29 Jul 2022 18:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=g3If11pmNYL8vM4KRbfvTyWRoHcGkxqIdhNNPMm7b8s=;
 b=mwWFDq3pYn6y9FAOfWgyHKZKiQipaTSoYw50Tk2ufW3AvU/UQ7c0kjMYzrVy3PfbkiA/
 YJbXmeLleESzBV+GAvH5uoTG6bE5f/ylDHVJ6gwnIae3XSHBN2wFawCeHLiWCRPMHUd3
 lPHK+NQWE7rr3mmztHuBaqSeerrLlzdCedIoRp2Xs5dMFC0hPLeckA1K7bup4OljOyRr
 cmiacjiR3iDwSbxJJfZzaOmHibEWve1eZfxBV2E6JstLDCzvxLZ1diCtB9KBcrFIPVFZ
 ghsWVrj/2hhvydYo43ZNJhm5M89w8EAoFptsWCalaEbPcw67a50I3/Z6L4Ra59neXc/N eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ht0j2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 18:00:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TH1vXb029652;
        Fri, 29 Jul 2022 18:00:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hkt7d2scn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 18:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbhYXJP3hu9wRqhL9UlUrwDhVDzk++t/eTAa9+BEpAYj9aCzpwBfdAiF40gAdakO99iKYErKt4pz3xfFiQcxxRn+7MasST0RoX3gK90dFzn1A6KjQtWtB0itQq8uuNaXM+1skdN1aKVoR9jmJEjc4T4gS3wxp/MN7SSDiUcGebh/xilAML6s2VBDctqpLDIxUgz0MZ7KWT3gSNwBU9fUlAxJQeUR3JrwjSsy49gLVgDwA+6xzPPnF8WUYeo4qsVQIO9OjUHo0OggzZ5Sm024mVSV9ggLZnOXd7JlBKtP8kb1b+12TsW+xisUXbbP9mo1O7wgvAjRx6+qqPAtTjpY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3If11pmNYL8vM4KRbfvTyWRoHcGkxqIdhNNPMm7b8s=;
 b=Afz7zQjSZWSLr0HDbySZ+jmRKUAvGxljPlrBR01I4vzHwwFzkARaPhV8SQOb7Y7Wusdw2qGeOPXOMvSBJGkTRmCHFSE74KZCI1bjoQ31lPiaqaxwJpHrcfKWNiJelKqInjlvzdPobq0B1cwduKJdnTHgsuZB+qbgICFUwNU9kOCc2tMxuKzqe8Sm3hzgly9Hz7MSCa7iJE75ax97wVP/ENnkyd2hfQDZuFhw1iK+t70rSauhIYdiSkL0qCGGzbPXhZzNQuZ0q+WTdkIS5sb1En/iEBsz5+g4RjiBAn/576iBZa7iLuhqrgnoeWBAIsBBbcYSFjpV0QERvm2bb+sfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3If11pmNYL8vM4KRbfvTyWRoHcGkxqIdhNNPMm7b8s=;
 b=HBE+BJ9VAfud6dZL3gRdUuaaSxv7t6yRn18p8SFXakLyOBLxwjO2hFyObf+r19wFrwrRJUSnXVrazpQqZbbAa3jtTLe9ChOBcEUNRscp/LC5GhU0n+Z1QZI501XgqZKwuw+bClwtPv8hfK9qb0vjL2+zSlv71MCajXkBjseDcdw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 18:00:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 18:00:06 +0000
Date:   Fri, 29 Jul 2022 11:00:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v4 6/8] hugetlb: add vma based lock for pmd sharing
 synchronization
Message-ID: <YuQgIwT+bjqX7Kcx@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-7-mike.kravetz@oracle.com>
 <5b8c6b49-e17a-2c0b-4440-ccf3c5493cb2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8c6b49-e17a-2c0b-4440-ccf3c5493cb2@huawei.com>
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02eec73-7934-4a59-ff97-08da718c2b59
X-MS-TrafficTypeDiagnostic: MN2PR10MB4288:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5SVvoYNJRu2kxIhSCFu9pyBXkBwUkCLnZtDt7IIxTF4OWqYUYv6pTyr9JVFrOFiRlk6zkTT6QUaiHxVO3Tw6rftGHOclA2Lxc0KNgIPo4LiF5jjMbr+Tv7k08CwWfKVkMGxl1NauRd/jlYqccWZHQmBKVlsScbNZnIi26A86cCEgHf4Vu33TYPHnxakBv2WFEWoRV33g/5c9IZAXWOY9HN3l/egYBE3hBetd2Y1sCzvs0SvOV+hnUCRI/KFVraV+xaMejrFlJSKoOKaH6xNpLf9uG4yCRZLf7Q0pl0bdr/e10Uopb7453LH9w48vmpnTyjOQivdLIP6YQhl43FmMdlxRysrc8yTMBk+nwiK5NO1U3yn0d0d7AXotJZ+Eg/j7ZH1L17TV11HwW/I+S7HF/BLcD/X0KRL+914ShCR7UQgrScoI2WBte9Bqm5inaz5OaWcPcVG0i8Iq7gF6jMsTOAfh3sgwNmDEld8zGrrPnKLpbwZaoXuR3PsJIUzhiY0U7P0BO01jQiQf6NcxzPTi0uZKJcQ7ZAFzLq45q/bl+vrhAIgjSWT5XC/DfMYvyni1cWHT29XlvPYOtLvEDNOWr6qaUr6PAH8OCDRJiXPNInqlZRHkyR5VfrNygvRt5W/SZ0mPmaYZ18xR034KcWfeJ5RK4ZXpyETOc8rhJn1XXP/4abw1pb4/VT7bjUGtaz7oBxYmZ3e0m4t6qry08ytB/pbZZ+fSo3wYf/3qgVD8h9S34NN4jsY7XNa3FU9Gkduqp03c25rxzB1B2JP4FXzNjYbJ+LUxDiVlSGsE1ll1Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(66946007)(44832011)(8676002)(4326008)(5660300002)(66476007)(8936002)(316002)(33716001)(7416002)(478600001)(6916009)(54906003)(66556008)(6486002)(6506007)(9686003)(2906002)(53546011)(26005)(41300700001)(6666004)(6512007)(186003)(83380400001)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPxh3Sg4w7JVl2Q40ta4Sq045clmsL1UzbmwzLdMNGkQ3Ypy3IwrnjeSKbP2?=
 =?us-ascii?Q?tKj0JK0c3J6MiweLWh6foSmU+pboFx9AFCRVUeCuVup4dxfm40bLqY5MQsHl?=
 =?us-ascii?Q?f7O7y98eyMh9do3MsN5xDSkmfRO4312B1QOh4RBvswlCRf/OAV+7tjH0eWXK?=
 =?us-ascii?Q?Lvrr/bharHu/9Vggw4J7bzFSCJnWuTwLdW7sxRcAqhW2Kfw7iT9Q5TaVaMAf?=
 =?us-ascii?Q?5XEtwXeg1qdDZ3llm78MasHaAKccpVXu24c5QlLhgHGrhNvDI0gKCfgpgcGN?=
 =?us-ascii?Q?8TIMRSgjlCuP1B/6dcQ/D0c8oa9trmKbLsoP/XtZaNmcPBkLg+e/GFc1fIvB?=
 =?us-ascii?Q?1eH/dO/Uo4K7RnBf9Rm9otWlvUN2Z4zYXWne2PVUo2fDoImu8sE/um6gk1Bj?=
 =?us-ascii?Q?sy0W6BYRxdLXleG+25OWTiR/BiBGLK/akCmEB5pUBwy98FLQvba3fuRWGjcq?=
 =?us-ascii?Q?VxguLtlqCzqSxvCuBlC1fDmxuS6ZXTNCE9Al8iDr/G+itZdgFLoMsv41rYP9?=
 =?us-ascii?Q?X5NmMZhhMazYEJccz5RkS9NVm8z8r28aAalRU4lbURxPymtI2HeZo5yrSrTO?=
 =?us-ascii?Q?iGgHur7hIWSBVkUDJE1JeymnjWkDaXcnciO+dmK+h+qHQ1HsbFpg/38lWq8N?=
 =?us-ascii?Q?Z8eB7VV3MXqIx8ET4jdoKjv3gueNEW+JMqoUURCT/QMaik4ElInh+kuQQxp0?=
 =?us-ascii?Q?EeE5KcHRnyo8dIn50NvEGQc8JZJDRg/w+82L1dGLAhR1KTScFMIAShaTeokP?=
 =?us-ascii?Q?X6xRYqM25L3jwgepF3PV9PtI6K0sUsitm1Sii9x9p4i4mPGgF5wcKi9Be/G3?=
 =?us-ascii?Q?WqVMr95LMinpNwr4moDZVk2ZEzPyvGWANIZQ4lGf7XvxEpz1y520wJPihE20?=
 =?us-ascii?Q?PUcIHmYkB28YGGGKaTAr0EWbDDHqqXef6zuwd0wGVpPp3tQh7oruV+mcxm7U?=
 =?us-ascii?Q?0pJuLH2IOg0D1f8IgZnpnuWN71Jj+SoIATBovxZfDr1AP/GyoTcD1tAMHZpK?=
 =?us-ascii?Q?IcqM2ix4td8PT6uFRYaBupcBiYO3Bz9rLgi4Fuzl8a1yu54xfG8feGkXCD/6?=
 =?us-ascii?Q?9IZMYnQCrpf5LGWEX8ilZYtsWSFUCyxisjFEYcT4nW++qnQl7j7kXcLepvVt?=
 =?us-ascii?Q?3dG8k5pmWfyGoI1yKfzM9nU3HR0YKESUjay05Mv1Koz4TZtkICeefNxsdD/u?=
 =?us-ascii?Q?fMhNgGbjvmYHRxZ82aulq5QZNVHrYQ5D6E8Cga1d/8EQ6IUmuR6j5/394ZPv?=
 =?us-ascii?Q?udgLjMrj+bcddBy2b2tUeh1//0x6EqUGsSu0GEAgx9spjxmU9TZ40Aj035Nv?=
 =?us-ascii?Q?RHuF2W2YNUMw0O0oVXusDJjgdZH/fWhJasp7STS2aJ1ExznW70awf01cPAOF?=
 =?us-ascii?Q?f2POL8Y6VyPr8tLgiX8oCwpLWLU46KS43XNZDzFFs8oONMqcWjKbokvIgsu0?=
 =?us-ascii?Q?j8ryU1QFwzRn+lJa1Lv/SVeTi+cLAO0attEhxM1sfNcYPuej5mSP+MTUmceY?=
 =?us-ascii?Q?ZRmZj/E8rhCwH8J8puEh2+sEoZOxRkXwQT37jgyAjGvqR9qUzMvLfNxhhuDD?=
 =?us-ascii?Q?XCUE07vXoC39meXBQMPLrhMTu7+YqW54YhpOOa5ps684Vatep+jPioHtKeu+?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02eec73-7934-4a59-ff97-08da718c2b59
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 18:00:06.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcjCfv1qSW8KiX+pXEDu5ZGnE6ULSyBfiWGjH5xyPceDZhyOWRKVx5epPfECR0ecGfm5EcS48RXflyDCjoeh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290076
X-Proofpoint-ORIG-GUID: ujV37ccNojmKbSkaS1ylkzSKSPnzIhC2
X-Proofpoint-GUID: ujV37ccNojmKbSkaS1ylkzSKSPnzIhC2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/22 10:55, Miaohe Lin wrote:
> On 2022/7/7 4:23, Mike Kravetz wrote:
> > Allocate a rw semaphore and hang off vm_private_data for
> > synchronization use by vmas that could be involved in pmd sharing.  Only
> > add infrastructure for the new lock here.  Actual use will be added in
> > subsequent patch.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  include/linux/hugetlb.h |  36 +++++++++-
> >  kernel/fork.c           |   6 +-
> >  mm/hugetlb.c            | 150 ++++++++++++++++++++++++++++++++++++----
> >  mm/rmap.c               |   8 ++-
> >  4 files changed, 178 insertions(+), 22 deletions(-)
> > 
> 
> <snip>
> 
> >  
> >  /* Forward declaration */
> >  static int hugetlb_acct_memory(struct hstate *h, long delta);
> > +static bool vma_pmd_shareable(struct vm_area_struct *vma);
> >  
> >  static inline bool subpool_is_free(struct hugepage_subpool *spool)
> >  {
> > @@ -904,6 +905,89 @@ resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
> >  #endif
> >  }
> >  
> > +static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
> > +{
> > +	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
> 
> Should me make __vma_aligned_range_pmd_shareable check (VM_MAYSHARE | VM_SHARED) like above
> instead of VM_MAYSHARE to make code more consistent?
> 

I 'think' we want them to be different.  Note this subtle code and
explanation in __unmap_hugepage_range_final().

	/*
	 * Clear this flag so that x86's huge_pmd_share page_table_shareable
	 * test will fail on a vma being torn down, and not grab a page table
	 * on its way out.  We're lucky that the flag has such an appropriate
	 * name, and can in fact be safely cleared here. We could clear it
	 * before the __unmap_hugepage_range above, but all that's necessary
	 * is to clear it before releasing the i_mmap_rwsem. This works
	 * because in the context this is called, the VMA is about to be
	 * destroyed and the i_mmap_rwsem is held.
	 */
	vma->vm_flags &= ~VM_MAYSHARE;

So, when making a decision to share or not we need to only check VM_MAYSHARE.
When making decisions about about the vma_lock, we need to check both.  In most
cases, just VM_MAYSHARE would be sufficient but we need to handle this case
where VM_SHARED and !VM_MAYSHARE.  Mostly in the unmap/cleanup cases.

> > +		vma->vm_private_data;
> > +}
> > +
> > +void hugetlb_vma_lock_read(struct vm_area_struct *vma)
> > +{
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		down_read((struct rw_semaphore *)vma->vm_private_data);
> > +}
> > +
> > +void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
> > +{
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		up_read((struct rw_semaphore *)vma->vm_private_data);
> > +}
> > +
> > +void hugetlb_vma_lock_write(struct vm_area_struct *vma)
> > +{
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		down_write((struct rw_semaphore *)vma->vm_private_data);
> > +}
> > +
> > +void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
> > +{
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		up_write((struct rw_semaphore *)vma->vm_private_data);
> > +}
> > +
> > +int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
> > +{
> > +	if (!__vma_shareable_flags_pmd(vma))
> > +		return 1;
> > +
> > +	return down_write_trylock((struct rw_semaphore *)vma->vm_private_data);
> > +}
> > +
> > +void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
> > +{
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		lockdep_assert_held((struct rw_semaphore *)
> > +				vma->vm_private_data);
> > +}
> > +
> > +static void hugetlb_free_vma_lock(struct vm_area_struct *vma)
> > +{
> > +	/* Only present in sharable vmas */
> > +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
> > +		return;
> > +
> > +	if (vma->vm_private_data) {
> > +		kfree(vma->vm_private_data);
> > +		vma->vm_private_data = NULL;
> > +	}
> > +}
> > +
> > +static void hugetlb_alloc_vma_lock(struct vm_area_struct *vma)
> > +{
> > +	struct rw_semaphore *vma_sema;
> > +
> > +	/* Only establish in (flags) sharable vmas */
> > +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))

Based on my explanation above, I think this should only check VM_MAYSHARE.

> > +		return;
> > +> +	if (!vma_pmd_shareable(vma)) {
> > +		vma->vm_private_data = NULL;
> > +		return;
> > +	}
> > +
> > +	vma_sema = kmalloc(sizeof(*vma_sema), GFP_KERNEL);
> > +	if (!vma_sema) {
> > +		/*
> > +		 * If we can not allocate semaphore, then vma can not
> > +		 * participate in pmd sharing.
> > +		 */
> > +		vma->vm_private_data = NULL;
> > +	} else {
> > +		init_rwsem(vma_sema);
> > +		vma->vm_private_data = vma_sema;
> > +	}
> 
> This code is really subtle. If it's called from hugetlb_vm_op_open during fork after
> hugetlb_dup_vma_private is done, there should already be a kmalloc-ed vma_sema for this
> vma (because hugetlb_alloc_vma_lock is also called by hugetlb_dup_vma_private). So we
> can't simply change the value of vm_private_data here or vma_sema will be leaked ?

Yes, I believe your analysis is correct.

>                                                                                    But
> when hugetlb_alloc_vma_lock is called from hugetlb_reserve_pages, it should work fine.
> Or am I miss something?

You are right.  This is an issue in the current code.  I will address in
the next version.

Thanks for all your comments on this series!
-- 
Mike Kravetz
