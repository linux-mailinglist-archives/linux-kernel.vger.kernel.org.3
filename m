Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C96560B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiF2VGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF2VGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:06:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F25205F1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:06:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TJovEN028231;
        Wed, 29 Jun 2022 21:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Qh5n0hdoY6qySscLpoZdcqY5izlWTrYEwJ2X7+6iUxE=;
 b=JMFyT2UJ4TlRcjftMvKXjhOfxFlwgNTUg5E+7ikV97i/BQq8ZKYdIl+gAybPzx0U77mi
 z97F306XFbGx5peDveX40051MhY7FF4qOzds2deEHgI3kwLSzwM0AbYtPrKdg8vpdA65
 HPGmQd0Zr7IncD/VQcERu6Wc8lvBedssNBwGd1Iy0PvrYaX80mMAZVv5nBxxov9PZfAM
 0x5O/T+4WXvYVst1TJ9SpJDPZN9mC4QZ0C5w5netDNiPrpGrBb8RhAY/ydZ6z1p6fjo2
 BXyqQfB3fHn8Tpa5KcnXUasOHqZa5Q6QgXF3ohH+eIMrQrMKYemkuwaDfbx0BlQuxR+G mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52jerf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 21:06:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TKv1pB003828;
        Wed, 29 Jun 2022 21:06:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3v8n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 21:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5JDsXQXeO/Yensv2sOXtqyRO+UN97IaPFanaFzL4waCKh4YB7jIY/PT9rB++gjNVJElh9wx3o2G0w6BEOvcD7m4AIoaflDQiQUayVFmW4enzXe6Isd/bgDLfdP0sBYsOfasquLwr5J68iwe4zWF+8KjpHucG5al5hMZ0fBGcy6h6X2dzThsBtLW8NhWHlT7FB+1LrQxTDKIwAASDiUr0lzGixYtAxhH5QiEkShrRLTlsOF9pMSCVEmfNNtPJ9w3K2VzXUH6//3S8mquwFDAQBwIeilCi6ipi9VEhZQ9WXnkFdrlepdFiphFwYB/01LKb51/U3e91lAwoPRtyf1zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh5n0hdoY6qySscLpoZdcqY5izlWTrYEwJ2X7+6iUxE=;
 b=XibofEnTtJckruEMQLQsst2AXIhGbRTy0qLOXdRcPlf0Hruae6WfEmjmP110TYRvm282yVA4kIXcUepogaSoEYjC42J03uFoKdH2b31kFubYDSCRlAeDLOa72j43my6ZWPTzL/smNmKb/Kmo5qm6J2JQb2L/Mmk4zpgggSF55hIS9ZGYaaseC45tVoq0i7+s1AwMPtR6s2VSBpuz8umPucSDYvioB/t8C6VYGprss+Az0mW0CNCHUe6gKT8fEnwu37LNdNUi4qRYghLw2SMGe3nWHC2b3BYmUi0khp5x1WUd+QvZhq0Qopf0r87MIgxWjqejX+UjfXHKJOf8/36QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh5n0hdoY6qySscLpoZdcqY5izlWTrYEwJ2X7+6iUxE=;
 b=wQWpu7F2Gkpy71DUiARZFZn7bhugwS0wTh4jRbFKCMO/E0fC423KcQMLN04ElKEVLoF6lHl5JMYPomiCPQlgGtvzdBAIsQTwdz2wqWzRw4khBjSZ7rhSf2Hqu6ddNErtF8JWFh7mNLbimI8LIqNu+HnnkHl8nuN6HHJLYqAU06c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3014.namprd10.prod.outlook.com (2603:10b6:a03:87::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 21:06:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 21:06:06 +0000
Date:   Wed, 29 Jun 2022 14:06:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
Message-ID: <Yry+uxxA2/wsK8G9@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-3-jthoughton@google.com>
 <Yrn6DfTINknKNS04@monkey>
 <CADrL8HUD14o6XybhYDdozAUkJ4Zt6nE8=dm-_osKg2CmvOFzHg@mail.gmail.com>
 <YrvzlTU2z8/IrEuK@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrvzlTU2z8/IrEuK@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: MWHPR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:300:6c::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d54f32-6261-4dcd-741f-08da5a132eb8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gB/pTqjplywMUw/kHvDQpR5+wQ9csgl4YD1vhj7/X61nkTC/+NrMKSxH2t+zmIXFRpLnQmF2tNxXFqmrvE5JWL3Yln7R4Tt5SFsMNi7EIs4uz0haxLfjh1utjL8gDgrpYeD63UUYZefN7kwi2gexHNa/O0nvPmjy1damwpJPIanv7hgdHCdZOyem+uFTHP32xsiNV0UbkjrjsMBWltXnl9oi/0pb5dTxOCQH2zqMAkWznLauU8RoTfTruASOS2LCvA+ltZ1aeDARu3FedadCdxOR7pBEU7da5RWVlUbZ5d0tfFKlfUHV5qdXBdgRzFOFadTUqkuLXOFF0XjipIZTiREbMa74vEi2CsvTZ7X9vpDdJzxHhdYK29UDlnH2+SCP6gRPABrywGwLWx5KOWeMTAVRzqLI5ovTdxCEQnH5+ZZMdlb7iem8OBkF/ppZmiZy+svXT6tNtxBma6YPqd7f/mhe0nZo3gFoffTsAAstFAxFtKNeise6l8901eY0ueQQWk3VKW4k9fqXbynXAxrSpdLyCaYC2yIHBfqa5f2WsmZmmF454Rg5OVxjwKOdwTMUI56M+wcPOIV4OOAJsPxYy5KRAAG9hxY+Dw2bnHH0dXfI5Jhol44GndGczQAcBalan2aj4dRLPsoDkuDX5LytoMOA/aUvGVLzdsCP5hcABc1lTzhBp2aQDbWSxcVvgDniqI2fNzUPvSgObTBOWufzQpRoqhetO4cuwFOuZMdUUR8gMjYJKHqSLp11SjTvaUbQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(86362001)(186003)(66556008)(66946007)(5660300002)(66476007)(33716001)(38100700002)(4326008)(478600001)(8936002)(6916009)(7416002)(8676002)(6486002)(9686003)(41300700001)(83380400001)(6512007)(6666004)(53546011)(26005)(6506007)(44832011)(54906003)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuo9+AJiv5yM76d84gQBAuoax/wtoI01gzBpvdVInfRoxiTybHxbgdVbqsRx?=
 =?us-ascii?Q?ah4IuzMSnT+47OqDOtAmVSzVUo1M9T0UcEZe4Ffy8qe/eMboSCBF25goOmPb?=
 =?us-ascii?Q?64biDU/TyY3DBYniS8kgd5dYumGbgMH7DPW2AepDLw7ZxvIp6NM/j4vErw7f?=
 =?us-ascii?Q?P6TMtFASJqHsZ/Y1eA8Y5I56xWPUdAtH/jr5+GvFJ+em4aYfUBCcfLQ9fqa9?=
 =?us-ascii?Q?H8clcKA/k/D5AyyQQw4oeDyZP11TdLjsQ7zXEkqkWSy7rV6lq6mYa+pXS5ED?=
 =?us-ascii?Q?wug3yJLsc52nKeR/kj/JpExCbrZDbusrCjbye+qK+leExzh7/qQYNqkPBRov?=
 =?us-ascii?Q?uAmYjWu2xtrQwQ6Tzy4sgx/GIVV2FpbyYa6a0gJIU3bj8hqeTcUKx5SpmMya?=
 =?us-ascii?Q?Op/XzU4kcU5knktu7zD8yLVScokr7qfZInSYe59m5/0fKUL4I3nC0RGKGxYl?=
 =?us-ascii?Q?mPjs6A6NWRsRq49JXqW0GwFj85uf0DqBESqhA+S+BAsJRUfYR0KaSXcHDNn7?=
 =?us-ascii?Q?GRDcJoFY+WPga17Nd7btwi1TE3Wnnpp1Vv1emMQrwgWsUlOiYtgAn9RYzzb+?=
 =?us-ascii?Q?TIPyId6Y18B3RCGHJU3vMKaZLu5h8RBILt7Y/yU9gw9QBTwZTCJGu0OEkKmF?=
 =?us-ascii?Q?lK8RGXzaQOhzRn94P3qJCTS4niJ+sOz59nPErvz2uaSzN4Rjl8gljqMb7IXW?=
 =?us-ascii?Q?RMPpH0cvrlNNYCS+KFMZZgQ97FBFguR2MXMxtuia+YaToIzUJncd9RTFZe0Z?=
 =?us-ascii?Q?hCFWn6isb03NmGJxwYrrGedQJEQQ7tK55i98jlTEzVGZwYRwc2LxOQd8hCUP?=
 =?us-ascii?Q?COsMju8lm3WcCzUGFqKiS+aR6Urvc3verlhay5a7zME6AT/Zk0a0XVWNEMtI?=
 =?us-ascii?Q?krxEWspMefYwrmqBU9sdHGxvuk/9MUsd/2AZuK086WyCyhIgAdLDKvghM6r6?=
 =?us-ascii?Q?hPtBj9Vgxx9kCrPGn+fr3dWynRqGCW0GTOPXsvP8rN0fy0Sq8mKz+oQmYt+F?=
 =?us-ascii?Q?cpjDe9Ba5p8AZdIPpxXPs+kYoZKIMH0S2oFwFxjnbIIWBmujmlyVTddXZB5R?=
 =?us-ascii?Q?2/ziZROj4FrS58NDN0HCGV2cgaWubfJLNd+FAo1LJbj4utTeLM+ubTGU1JHX?=
 =?us-ascii?Q?tpeb+hiDBjrLgzjPJ2kQYLaz3tZQRYwnDnGoL1O17o/mbtKC4gfdho4+Sjqz?=
 =?us-ascii?Q?cjUjs4fdpj0G7B8GHl9ei7CGYPca0uSuNs2IX7BN/b97HYFwcKoUsGja5ozi?=
 =?us-ascii?Q?u8hJXEffzhRLHOUfx6+MGxuWGIh54uVzGhlze6kczeCV/udYftCc+KUuUpp/?=
 =?us-ascii?Q?9hvkU5dJdLxdz0WV+kVybD0IrCE/TQMnCdMdKzdkHhCkKgOlshTP6cIEyN1o?=
 =?us-ascii?Q?CMvme5jjLcW/aIV2BXPaFbE78SrkOLcI8tWhjII7aTtnaqNA7eIvK59vN6FU?=
 =?us-ascii?Q?X2hpIxs0YHrDmJlChp95AN+kuboPyX6ly1ozJa62Cky1YBrNKjQa8UyyCTVM?=
 =?us-ascii?Q?Pyr3cixoSJAkn1PpM8HV0vo0o5thmoCRUSmSSjwjeEgxQDAz6m8MxKpg3f2d?=
 =?us-ascii?Q?kUo4D1XJOXxA4fkRGhfwmroL/WmOyHHDmbn3wWbSTBQeqCOASbZkQaQoXc85?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d54f32-6261-4dcd-741f-08da5a132eb8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 21:06:06.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtXe/Howt+RiKFc00touBeujhr6gK20OxDIoGjv8VxG7HQKPnRp1xgDXgoY4qnyQNGOkr36+0/S3RaAR/nel8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3014
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290072
X-Proofpoint-ORIG-GUID: 9bWhM3SS3TVu9qLUwFb24NJTATsi5icl
X-Proofpoint-GUID: 9bWhM3SS3TVu9qLUwFb24NJTATsi5icl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/22 14:39, Muchun Song wrote:
> On Tue, Jun 28, 2022 at 08:40:27AM -0700, James Houghton wrote:
> > On Mon, Jun 27, 2022 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > On 06/24/22 17:36, James Houghton wrote:
> > > > When using HugeTLB high-granularity mapping, we need to go through the
> > > > supported hugepage sizes in decreasing order so that we pick the largest
> > > > size that works. Consider the case where we're faulting in a 1G hugepage
> > > > for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> > > > a PUD. By going through the sizes in decreasing order, we will find that
> > > > PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
> > > >
> > >
> > > This may/will cause problems for gigantic hugetlb pages allocated at boot
> > > time.  See alloc_bootmem_huge_page() where a pointer to the associated hstate
> > > is encoded within the allocated hugetlb page.  These pages are added to
> > > hugetlb pools by the routine gather_bootmem_prealloc() which uses the saved
> > > hstate to add prep the gigantic page and add to the correct pool.  Currently,
> > > gather_bootmem_prealloc is called after hugetlb_init_hstates.  So, changing
> > > hstate order will cause errors.
> > >
> > > I do not see any reason why we could not call gather_bootmem_prealloc before
> > > hugetlb_init_hstates to avoid this issue.
> > 
> > Thanks for catching this, Mike. Your suggestion certainly seems to
> > work, but it also seems kind of error prone. I'll have to look at the
> > code more closely, but maybe it would be better if I just maintained a
> > separate `struct hstate *sorted_hstate_ptrs[]`, where the original
> 
> I don't think this is a good idea.  If you really rely on the order of
> the initialization in this patch.  The easier solution is changing
> huge_bootmem_page->hstate to huge_bootmem_page->hugepagesz. Then we
> can use size_to_hstate(huge_bootmem_page->hugepagesz) in
> gather_bootmem_prealloc().
> 

That is a much better solution.  Thanks Muchun!

-- 
Mike Kravetz
