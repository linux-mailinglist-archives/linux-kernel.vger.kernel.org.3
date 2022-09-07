Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A135B0E99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIGUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIGUv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:51:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5863C2755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:51:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287KnAP9002175;
        Wed, 7 Sep 2022 20:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mYbwBdPYvYK0OAyjjbnbH/jMWa+Abj0KOx7arTY+XFI=;
 b=UgCJ5MXii791PFNfRuPnn/ejTTt0AExJGDXfr62XVo356rYucRb29KyAIJEwTI9KPl6M
 H5/LoL5h7o6MNF1bjuQ2GsYRR3MdNOjZRFJIRahl1aT9M7bfZ0sWhbAs74KTgqMLJMCV
 yd3qEiQgvw4bmleWG7SJHxnT7lU2YzKRd/ZB9r6nnjv5hm1AXuX/a36QYtaQij0K4Q4L
 0hXfSxV1ONCe9YRs8dYq+DB1EM7LFTYYuVThbGflH5IbnZXZc/7SuQYZmIlYhGroG7/n
 WSuQYqWBAMOdsmbG2K0JUhghWNd4AJAYhaDLl96qeoeC3oQg1jAiSMbZdDQIY0uKe3Bn dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtahwyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 20:50:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287IgA3b033593;
        Wed, 7 Sep 2022 20:50:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcawddy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 20:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYItwC0m6jq3J9H6Wlgn//7fxAH8UwYXwWkJJH8//pcggshQO/iRwfCD1C5x3xUsX+f/+QzuE1U+aiOkcO5wSnWSmXRCxf1y3QngTMOn9hTeCfhlTs1TX11DeERZsNIL7Mrj6zdFbkIXkIwQX8Vu92bMDw5jkj6gjjpkpe4OuSfZQXd7PYpxKXL88cuhNtcGITU8KuK3QZTwSpBFTBpkHGBs3vFV7Y139nu7WKCj4J8ALlVTNWdQ78NHJJHkdKduVYo6HuspjoXaTze/03CQW1TepJvO7JAB+B90GLuiJpX0e7pXwp0EGCqXUt60YO52NqlTpuUYtME39KYf6psinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYbwBdPYvYK0OAyjjbnbH/jMWa+Abj0KOx7arTY+XFI=;
 b=B/emiIrZzLzXwv79Px4tUYnvFqXmM+oU6Ns4nRg3m9Pf5Qgii1lLXjcLl3SsSE4xGAISyhX4wONQtX924hr6uSYBwUFzdmph6GzlDsgq3asGCPzRw51Xwv1k6+hQPkSqSX4svdPg9cGuJdUCoaD6Qle2h7fg3qNSlprmVBTGoEeWhuxLax2N8F9wSvPDwgpSBtrHErZVwb2DXFWYdGOSKceB+BRnNs07iRglNSep9qTj8GydxZL+oC9ef11XptCEcmvkPZ0QR3QTJT1euYXlxbfmF+1z6gjoc0j9/GmKsLtAQcKkXdMRaMOX0iUZmKsi/mq1QHrYKlT6fdvQp7uwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYbwBdPYvYK0OAyjjbnbH/jMWa+Abj0KOx7arTY+XFI=;
 b=klPC6RNViMSK4CAMjdLv1MZgYDxjp/CkRomr/SBJQxtESdgEQJFbznoqKsto6bV0rukWhheYIjdtvN951TXGfpLiYw5HGK18fQuvyPDgygtCAZesNdMJDPoZjnjxTjYxyDA2hadIeMLk8Pp3stkvqevE23oOt52FEYk71Z3YR6E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 20:50:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 20:50:50 +0000
Date:   Wed, 7 Sep 2022 13:50:46 -0700
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
Subject: Re: [PATCH 6/8] hugetlb: add vma based lock for pmd sharing
Message-ID: <YxkEJhTzglEfo+Tp@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-7-mike.kravetz@oracle.com>
 <47cc90bf-d616-5004-555d-b3d7e9b09bd1@huawei.com>
 <Yw08j5m62is7kqSg@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw08j5m62is7kqSg@monkey>
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 29361839-b512-4f6f-232a-08da9112a582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/HJIdKYy72n3uLaYmjJORH7/kezN/NJbjuhAJGz8vNzzvnBDjD+PtnP35Yb+2nJz1QgsaHpLYieWAKyFf10bw4CUBmsenY3kG/x7Ywq6uM1moJA+ADrIVbCBe9PczDKxQjWPcER+zlKmN+SGU+Te72epJeKa5ODZN360F+2aK64jYRFbqKezDLZh4w4SYUmFCPgT390vMGTwADrbTBcxpKO1NOvv8VPqMLugtA9cAN3ckhL6xyp12gimjQEaV3jrti/vm3tjSTqnGlXY7iG9wbIgkQjeIbsQuX50vuY73MtHPXpuk4G4Ym5Ii1wEOlH0DSoGWWjalazK+VYWFlG5Ck+lHysUhPiZ0M0EayBC2+6qeFiqkMGojPoj1YelQ15pCI6dqgFjPmsdwsrAkMW1IOscv/AMyjoG6X9nITKXBIQmifdRHOJqFjMynJubMu10OinoWr3rgvaslNZkD80k5tklPiZZRB7Koc07RipBp+6xsg8rhlmvcRoScpvSZTW5FY2U5uwyyZGGmbt5ETbs5dfqDGFv1O7n1UaYF/hVvOCPhJvpvz7rXwRiSCOWsbpCmmJRH4edKb8QdQt2Ov52lDrDu/8iYP6c7Z79SrDIE0R1kKfT1KrtC5s81ClyMIihDIt44w+Ra7OJi4nhAVd39jwSDV1eq/IKsdO4dx7Jett5lTufHtI17is9ovryM5SfkjNSFzIwjUt5JctKq/vvmQY3Eye2Tsuz8gaAJ0WQH99roenRq4RVqDtD/GjOxhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(396003)(39860400002)(136003)(54906003)(6916009)(478600001)(6486002)(2906002)(86362001)(83380400001)(5660300002)(44832011)(8676002)(26005)(186003)(66946007)(8936002)(66556008)(66476007)(4326008)(6666004)(6512007)(9686003)(53546011)(316002)(7416002)(41300700001)(33716001)(38100700002)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JKPGH84rXqd4tyRqg2JJH9eUE1kUke5DBWW3aBXqFSr3UoB9ycx/K6YTyfwh?=
 =?us-ascii?Q?fJu1bFEy9H5o2BcjuOnGsdxO9NwqSzd22g/GB7ejQ2sWo8PeaH5wcdF7njHW?=
 =?us-ascii?Q?rLDXq2hkW/adV19Me1Dl58Fn3ww41VSusphqvpB5v2+cVQ0Siip4A+XNzen/?=
 =?us-ascii?Q?3uKNSZMKXxlZYUVIfSaXewHw3w6xXOqhrRQrPjlqNBVMWPIkyQdgAkbZRxrA?=
 =?us-ascii?Q?RLP+WO318l3emkIoO4KM2n6NcwKVqvySAR1BYv/CqlJf1Y+NdkeEWg92hZqs?=
 =?us-ascii?Q?QKFjxaxiwh4+e5FdrJ7pCHfsEjVYH4mlObUoEr3Pk9xEKdyyKwm/Hqnevq7G?=
 =?us-ascii?Q?iEvD+uzqE4O0KX7DgCgk8V0wCftZ5yPHnZ9HbCMNM23zpLw29muQhVsd/j9Q?=
 =?us-ascii?Q?DdwOCbbs98P+wWiXlQxDTttmEstjJgxZWI2oC3x6Pxu9++kkUyjo9P6v5fe7?=
 =?us-ascii?Q?brjftYAUNhcTHlyik4eY7Dk7invlhc+pLem6ylRqqhGOM9QIePjFyXdQmZGp?=
 =?us-ascii?Q?7KOFFdO4Tv3exo9sfODKQR1srJdryQ0qKSdphTrSzSx4VqqOf+5Y1Y/vYp5B?=
 =?us-ascii?Q?oiesY6k4cm3GnVIGBXDTL+onR9s20xYn3BoPMUmxz7Qxk/Qmf25urqi28yo7?=
 =?us-ascii?Q?/TthYPz+JQ/Ue8MuUT6OYHsDr2+o6qzUI37Ic0BDsuw4mXmPnvyNZXSPIWlj?=
 =?us-ascii?Q?nquMERffMFYMyiQmP2iMCo384kH0mjSxqrpcPEKohiFYioJCFpFrerfxI/bp?=
 =?us-ascii?Q?dPHeaxhmvJpBVBq1OZg96xLsR/rnasoRKqAf8fh8as2lCcaCYJJ044jYQh3D?=
 =?us-ascii?Q?E+S1tfxbNTRQcIzm55BeZYWVAydeBsAy6sSViTRC16YmGBjg8inpJvtiq3b6?=
 =?us-ascii?Q?aANzTm4dDDfvvmLGqF3iK68ngN8bXpbw95IhW67QLKc/ZTpzc2oICBqDVbJ1?=
 =?us-ascii?Q?wc3C0afaZeNWiXFwfQLigHC8JOBqlebOhBgtd7TPi+249y6KcxicVYVWxFCN?=
 =?us-ascii?Q?Jd7TLYqaa/8rH2EQBKHUZIM/X+hahYVaQq+w3dpy/F6P9nJQEJ4SqJJBgmf0?=
 =?us-ascii?Q?mD1ne4XHrNEcCfVD5fx117OmxyaLNVAWCQg93cJZfqdq5gh42FdrzcjMHppZ?=
 =?us-ascii?Q?8fFNAXDstv/EQOuJcPzWbQ1Sjw1MY/8KNxuW19UYPlkLP4TtKMY+k9TYRqeA?=
 =?us-ascii?Q?7+pT4ucRQr2wHbdU8ruSSol+/JrCVM2UCRhVEWnICJwv1NKpl3K7fyrjX+pT?=
 =?us-ascii?Q?KrrOhSP5jidIwBkvcoESj2r7nE26KUMDPq4VxmsLd9Bgk/2LneUaKRXjc7Y6?=
 =?us-ascii?Q?tmYvAUXd24lrfH6X+VjFWGeQqzQKfSt7ih1Wq0RdXHORihC7L8BZn3Yk1wsf?=
 =?us-ascii?Q?BJ5mFUMffZv6/DFCBDZcFCGHNjMrj9lf9/IljU1pYuzf200OnHiPH9L2wHQO?=
 =?us-ascii?Q?HvbeCBMJutCoW52vaVyM5FPTuG4wA9+imQzbPgjYbmX3zHwXxhQKCr1YCGhu?=
 =?us-ascii?Q?y5n4c3eLJhmAZ0zvHJZOTWE9v9na0ZPu7mLmoYaFYGYsGa3qYIOBwVQYiqwa?=
 =?us-ascii?Q?RZovaIX+OUEUjYGNzsxpHOJPgnjmjb0PmwGORer57u11u9xGMV/FOL/65jUW?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29361839-b512-4f6f-232a-08da9112a582
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 20:50:50.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/Bqr5eUizfuB8TACfkCYpbJTjeMyH8iwfv3b6ppH8ouNjHNgpi05Jtk3CvZYj+WZFVJhmBTOOPtdOWPH2p3yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070078
X-Proofpoint-ORIG-GUID: 24g9DhB-te0W7MCYKfODKi92RoqtsyQf
X-Proofpoint-GUID: 24g9DhB-te0W7MCYKfODKi92RoqtsyQf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/22 15:24, Mike Kravetz wrote:
> On 08/27/22 17:30, Miaohe Lin wrote:
> > On 2022/8/25 1:57, Mike Kravetz wrote:
> > > Allocate a rw semaphore and hang off vm_private_data for
> > > synchronization use by vmas that could be involved in pmd sharing.  Only
> > > add infrastructure for the new lock here.  Actual use will be added in
> > > subsequent patch.
> > > 
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > <snip>
> > 
> > > +static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
> > > +{
> > > +	/*
> > > +	 * Only present in sharable vmas.  See comment in
> > > +	 * __unmap_hugepage_range_final about the neeed to check both
> > 
> > s/neeed/need/
> > 
> > > +	 * VM_SHARED and VM_MAYSHARE in free path
> > 
> > I think there might be some wrong checks around this patch. As above comment said, we
> > need to check both flags, so we should do something like below instead?
> > 
> > 	if (!(vma->vm_flags & (VM_MAYSHARE | VM_SHARED) == (VM_MAYSHARE | VM_SHARED)))
> > 
> > > +	 */
> 
> Thanks.  I will update.
> 
> > > +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
> > > +		return;

I think you misunderstood the comment which I admit was not very clear.  And,
I misunderstood your suggestion.  I believe the code is correct as it.  Here
is the proposed update comment/code:

	/*
	 * Only present in sharable vmas.  See comment in
	 * __unmap_hugepage_range_final about how VM_SHARED could
	 * be set without VM_MAYSHARE.  As a result, we need to
	 * check if either is set in the free path.
	 */
	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
		return;

Hopefully, that makes more sense.
-- 
Mike Kravetz
