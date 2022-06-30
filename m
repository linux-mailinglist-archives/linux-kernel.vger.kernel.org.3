Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96156216A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiF3RlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiF3RlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:41:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D01107
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:41:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UHUpKA020594;
        Thu, 30 Jun 2022 17:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IoFgQ7Trr1VXPj7MmSw3pd+LavZsXaSAOMC6w59ublY=;
 b=ntdYD+e+KmAasiymSrrrz9wK+4A4376TvhTNZ8Przf8fJQwbxC0oofdOVaQTJQ0p2GeK
 qBpLEbLrpkNmmGTZYHtF56prHKv13cH9DAux2yDVKn5fCak5GJn12sFrh44i1KRX/If/
 Pv+z6p5/UFO0CpF3m4Ymlv7Grq5vEEcFHir5S+Mbyfc3adssUzBj3tmYCaRIoC+iev4N
 dhw5bSG9LOoIE8LS5xkxoP69//lATC9FnK6QKow1Vr/hgPYZKU5xBTL75k2L9DcfctiT
 EcM9gxRu+zgwYcNgDb8g0YLMutDQbtdZpvvbxN4kcJhLgky4uNAOkwjETUsbHavQY9J7 rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysmx27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 17:40:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UHFBog010783;
        Thu, 30 Jun 2022 17:40:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrta05dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 17:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxpTF3C4cUyi3NQ0/sX0fONggLI7PvFNgprIRgf+4GKElp8tUjZMFEhoaufHPmnyZeCc4TUBdSNaRYB42dPD+zNYEHXATGBIUjnaSGVXtjrZdTE08Fysy5IQaA9agfkUV6dpnjRqtnlAgbVnFTovF6izTND15PNaVOM5TDZBs2AIaFfEu9u0HHRdSqUKQZuBZMC0QhuEcLoq7v+Pvu3apLC43hjlj2kUo9K+aCPF3tf24+xXq3X0dtEoM2zSRf3T4yiGv87S8fjhYyROAhBthlZuV+lwv1ZX+13b2s/cHoSzCTQOedRDN8X1khFHHNM277mgvki7htfv80K+0SHRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoFgQ7Trr1VXPj7MmSw3pd+LavZsXaSAOMC6w59ublY=;
 b=b/ryGH1lUdBl79ve0QWzoilasOqa6rvlwaiFrzABqwFo6t21o0PNrFD5blLJmAG5dgX3xo6tKxLL+7EXvIztsm2cq3N7PFjSzqVqMmq4BYZBbJgQPbc8BzHBOx9w1iiSCFfymkQgUgS7+9HSV2R70hXX/cMUjUlwEEAWAMOouwMCqD/LkSMFVr71tvaArYuaI3qFdTfNSsh89Tbi2AAosPb64XRqVq7FpE466cGPWHop7UrDyNP9RirQoanqq36xdZUqXZYs3YsJud2TeClU+MpoY7BbwxFTEQueDlblDNimzEdzHHqB4xyXKnPHnV/wqEcJd7q7KGdACw+cMQH8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoFgQ7Trr1VXPj7MmSw3pd+LavZsXaSAOMC6w59ublY=;
 b=sB4HV4lMAWabs2Sm30+HmPbLjoHD1sHHtrDmQ+Uv77aNISKr3bVFkXOgdQNgj40f9wWfM6Ib+jneUK/yqY1bJ+zRw0Q37FG0Po+XnOegFlUwtV9h2i8vky1lGIZUU6S73SrOc8ZKAx6AiQ5WxqSlwt5GP/IFLvCmEcuiJFTy95o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 17:40:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 17:40:51 +0000
Date:   Thu, 30 Jun 2022 10:40:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <Yr3gH6F3R5lSwcWf@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
 <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net>
 <Yry+PPHSat2uN+aG@monkey>
 <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
 <YrzRLVQaYtYAYsEa@monkey>
 <Yr1uUmfA/iWO740v@FVFYT0MHHV2J.usts.net>
 <CADrL8HWuF-yXvgdJW7wWQSMU0GsRg3gttHykhV7=1VYSxfzkag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HWuF-yXvgdJW7wWQSMU0GsRg3gttHykhV7=1VYSxfzkag@mail.gmail.com>
X-ClientProxiedBy: MWHPR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:300:6c::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20785a39-c3b9-48b5-8180-08da5abfacbb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKbqYcMc7KR4qAqH+0lIPN0txUQrjVw2iLIOvHNJpbp8kGqzLo6675GWbhx6IIrS9nJMKiqT3UIgamdtWct6C8ovgrFGbuYaqDKZyoN7YMGM62SNdZeLCJCW+LxqojyC+P5tYBul7ZWZC07gs3N9wrsx/1y99XdSh5muKIN8w0LJC0te+Cmgt6mdLmrSrW2YLItKbmQ0tw9PEKicsAklKiVDq4dvA94JPeB+KHoVCmVymhFyzEpWBPvdOjHTy6GDK9wDQsZk3wIA/gH5a1DXmYH89D0XJIJG3VU+e+WN5Pjx6hiL5eE8vWoJpZ7FDx2iTbUNS40WX20jEMbUf75GIM8CLrNlNpy2pqA0xgLKZNch42L6QHMeKYnH2xADKcSgL3DNyeE2hCZem8VBaMUB9ycKAQeT2xZgASkMvNempON2GppyfexLo4wPNOCiZUYSArHJPpO0b8obVRBydw6ht39Ix+vvO/jxeO0WERBk8Xva+oxrEpz21kThpG8cGld/q4/pMIP7s4L5czqUM7FyU0a6sDimU4uZt5qeEZqPXyp6djuxJATC++MvdN/Te98St8zl4i2rIGa/vSNYS7soc37zbppExxBrxNw/jM0OzXvGnzJUGraQtUgR7tZls0wEhOVpXDn+5lXgeWxnH8sOMbxnm4bo4AjzY9NSuJEBPD+z+VM3UymAVnwP3Bd0QJvKuBdjbyoalmzZKrQQmfVXhSiQfqBwd8ev2aIX56p+Ryy2A+04RnX1kJP4LkXhcRarDQMEiqtP2DIMKoY83FjfdNNzSBm9Gq1Q5ehW+dtFAh8hERJkXDMt5JkhbkuB9bFj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(39860400002)(376002)(136003)(396003)(6666004)(6512007)(6506007)(9686003)(41300700001)(86362001)(53546011)(26005)(186003)(83380400001)(38100700002)(6486002)(66476007)(66946007)(66556008)(4326008)(8676002)(2906002)(7416002)(5660300002)(54906003)(44832011)(6916009)(8936002)(33716001)(478600001)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xqYMrev1HEoxXe4QhXGtUV7Cz1/kzuUPux0EHBi6V3+wvRUI6DPVjVJRp+i?=
 =?us-ascii?Q?iGKY8iT8PnHX39hiwCrMCUbbTHSVe9m0E7Hb2wZbsIz5BIc0QSzuqAky+wxm?=
 =?us-ascii?Q?B0O+Jg2IC42031fGPd9OH8plj9yXxEZYY2zApge4zh3zFkYyZnYw8mrPqE12?=
 =?us-ascii?Q?TDneDu8xIQo5QtqkylpGLIu5APVt9PAnS4Wwp6LKHzO0cXIspVQ+CzuZk1D+?=
 =?us-ascii?Q?FpYnR82XGMNfxTbg2qT1cMfoR4x4NV+jKxglDfkS4pCHlpUTUd1KdJiZhJnf?=
 =?us-ascii?Q?ijr8CfZWNOI2UY8x3lSc/8a5G71JLm2vKwrJXqX75euXntATCbgimlguvYhc?=
 =?us-ascii?Q?DqMl0JlJ2zfv4G/fVIQT8eZLCkwpNUBpHCpRSq8g81+TQPOlZZOvBtcd8910?=
 =?us-ascii?Q?ByyHG/pDYr/bi9kkoYPfugNU6WdBj4VLISbxBJrU2Wr9qT+fj4i9Of3OR85m?=
 =?us-ascii?Q?KGsvfrNqeed8tFvLuGEgRe9sdF8vhIuSxgK9FJahbfH7l+5s8lxnqnnw1v+B?=
 =?us-ascii?Q?oCOEpp3Kdz7Sj3ERXSjvUwKRlJjzvSp4rTywfq8MvPjYNkBBhMuBHGeFcycg?=
 =?us-ascii?Q?WoT9nSsdH89JiuboUDcXWPxGQO4RUXC2zNFBBsAaDN72kJwxOMUAkOhUhcjk?=
 =?us-ascii?Q?ttKRrkpermB861yw3TSKKJr8J4+rjiPMinto1wah+FLJAy/C+OTWS/WGCl5f?=
 =?us-ascii?Q?IUqVPf2qQtz4X5ZkKe8Sw3AnGvrtDwokP21BNitfLcC6m+xjHnO79ro4kWC/?=
 =?us-ascii?Q?mz9mBP+O/cWVEaEuHp+EhYp0q1B8dmiDpGcpxcYfvFbnV+mtgDZwoQhMpB5R?=
 =?us-ascii?Q?9zWBabBCmYsExBu7NnGkQKKs2dE7PHPIjQiLWIB7yvfFMwl4d9PvRcjSzvZj?=
 =?us-ascii?Q?k9wdhxAxwh1wQJyKX47eHZtRUJsFhdsdyfz0j2XPB/7+xaZIDg4l2wuu/FHl?=
 =?us-ascii?Q?MaLKfjIlF0RACBssXLoIfvEy34TZjnOvOO7ielTkCL9thWrmnV3IeQp1MA7x?=
 =?us-ascii?Q?OYF/ith7bg9wORKvrQoM11x4fKL0/ATDnJLtd8s7+X5ccf4YTmeXxANfJ/Vx?=
 =?us-ascii?Q?OpuaviIwHOd8yV6hdkXMKKVY70Tf/v2Tu5c4TVM3V2FY+Hez0r7DW9ORthdB?=
 =?us-ascii?Q?ZHQa5fEiw3t71fqQmFrvKybR+YCYEIwaz6wY+nQrAOTN8ub/Q+q4FYWy2BA0?=
 =?us-ascii?Q?Xcohym5rMvObhP7r0aFwQs5t/mzm9K1aO+GhM9oGH6xbGOWG4FyGLH5FK5+R?=
 =?us-ascii?Q?lymoLVgAr5xUY9QXS/PkmooHoYseuQ86lo33bVrvMuwwV0GdAy5r9WKjbn3h?=
 =?us-ascii?Q?hGY3om7SM3ViL30CSHSB6T81Lk2aeb7GDGIISMXwyjswBHenYNtV1mWTeAhq?=
 =?us-ascii?Q?warfvUgRfp6VL3fPxyH1oaXIHUPCQ40RhaLwgDZzo0pWWSs5bsQVv+LBZF4r?=
 =?us-ascii?Q?rjy8/B+3f4GWrPJv54W1CmG2Lf3CudcvwfWlqrLv1r/cigcXT2H+eEYvZRgC?=
 =?us-ascii?Q?uxpVgUM/KXFbP3yY9HMuR0W/Sk0SUvXjHabEdn6+IVWmUZE8I83HwaMQ6uIL?=
 =?us-ascii?Q?8TQDsjcMka0ESmESTyX9tbq09YLomXK41V00EEJW4/GdWCyv4XyXfj86sqXc?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20785a39-c3b9-48b5-8180-08da5abfacbb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 17:40:51.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc907ex9MK2B8h1wTVJU7l2w8uNY0xG+DHqN/NM6TjMvT/i7HHqyArksbbuZjPwBfc5XB7YlJYsds+AMdVbHVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300069
X-Proofpoint-ORIG-GUID: L_oTeLOT-4TcYRPSnyMPwraOtQ_wsFD2
X-Proofpoint-GUID: L_oTeLOT-4TcYRPSnyMPwraOtQ_wsFD2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/22 09:23, James Houghton wrote:
> On Thu, Jun 30, 2022 at 2:35 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 03:24:45PM -0700, Mike Kravetz wrote:
> > > On 06/29/22 14:39, James Houghton wrote:
> > > > On Wed, Jun 29, 2022 at 2:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > >
> > > > > On 06/29/22 14:09, Muchun Song wrote:
> > > > > > On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> > > > > > > On 06/24/22 17:36, James Houghton wrote:
> > > > > > > > This is needed to handle PTL locking with high-granularity mapping. We
> > > > > > > > won't always be using the PMD-level PTL even if we're using the 2M
> > > > > > > > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > > > > > > > case, we need to lock the PTL for the 4K PTE.
> > > > > > >
> > > > > > > I'm not really sure why this would be required.
> > > > > > > Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> > > > > > > with less contention than using the more coarse mm lock.
> > > > > > >
> > > > > >
> > > > > > Your words make me thing of another question unrelated to this patch.
> > > > > > We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
> > > > > > did not consider this case, in this case, those HugeTLB pages are contended
> > > > > > with mm lock. Seems we should optimize this case. Something like:
> > > > > >
> > > > > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > > > > index 0d790fa3f297..68a1e071bfc0 100644
> > > > > > --- a/include/linux/hugetlb.h
> > > > > > +++ b/include/linux/hugetlb.h
> > > > > > @@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> > > > > >  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> > > > > >                                            struct mm_struct *mm, pte_t *pte)
> > > > > >  {
> > > > > > -       if (huge_page_size(h) == PMD_SIZE)
> > > > > > +       if (huge_page_size(h) <= PMD_SIZE)
> > > > > >                 return pmd_lockptr(mm, (pmd_t *) pte);
> > > > > >         VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> > > > > >         return &mm->page_table_lock;
> > > > > >
> > > > > > I did not check if elsewhere needs to be changed as well. Just a primary
> > > > > > thought.
> > > >
> > > > I'm not sure if this works. If hugetlb_pte_size(hpte) is PAGE_SIZE,
> > > > then `hpte.ptep` will be a pte_t, not a pmd_t -- I assume that breaks
> > > > things. So I think, when doing a HugeTLB PT walk down to PAGE_SIZE, we
> > > > need to separately keep track of the location of the PMD so that we
> > > > can use it to get the PMD lock.
> > >
> > > I assume Muchun was talking about changing this in current code (before
> > > your changes) where huge_page_size(h) can not be PAGE_SIZE.
> > >
> >
> > Yes, that's what I meant.
> 
> Right -- but I think my point still stands. If `huge_page_size(h)` is
> CONT_PTE_SIZE, then the `pte_t *` passed to `huge_pte_lockptr` will
> *actually* point to a `pte_t` and not a `pmd_t` (I'm pretty sure the
> distinction is important). So it seems like we need to separately keep
> track of the real pmd_t that is being used in the CONT_PTE_SIZE case
> (and therefore, when considering HGM, the PAGE_SIZE case).

Ah yes, that is correct.  We would be passing in a pte not pmd in this
case.

> 
> However, we *can* make this optimization for CONT_PMD_SIZE (maybe this
> is what you originally meant, Muchun?), so instead of
> `huge_page_size(h) == PMD_SIZE`, we could do `huge_page_size(h) >=
> PMD_SIZE && huge_page_size(h) < PUD_SIZE`.
> 

Another 'optimization' may exist in hugetlb address range scanning code.
We currently have something like:

for addr=start, addr< end, addr += huge_page_size
	pte = huge_pte_offset(addr)
	ptl = huge_pte_lock(pte)
	...
	...
	spin_unlock(ptl)

Seems like ptl will be the same for all entries on the same pmd page.
We 'may' be able to go from 512 lock/unlock cycles to 1.
-- 
Mike Kravetz
