Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFC5A53FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiH2SgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2Sf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:35:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD637A764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:35:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TIT8ot026589;
        Mon, 29 Aug 2022 18:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=m1rRHE6QiJDzX4ylZe3+X3jknrWTdiK4ksTpg/GJDB4=;
 b=3TQGrSCeOljQsY7+Mf8xRSLmNDshGaGLked/0H8N5QYNsgvehEZJkSmWfxwgJIdCWjs9
 6bfgXwSL5Iuox/A5yXOdlNgDo0JifFtTnYRvU9YNKiRwMhG51nYDJnxFc6fOET6EBrFf
 7UezMaapChqSJPZreB4q8Sfh2K29Cf2OXwnvMDmZnzM5AgAwsSQ6BOORURmxSbUVCqVw
 K0o+kwbzfyHsBejOFGYcqlc0eeuK8vMkuEk80C3iejWfsGwyc6hdZdXzEGryt2F3JhIS
 gg86VY+QGHhbHX8wj51FfFXkcVJPdZXyDvYySDUidwdjxmpYn0QOTvU+8dLb61UCCHXX Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a2248cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:30:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGq0DW017971;
        Mon, 29 Aug 2022 18:30:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q30unu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2HDrhDymyDcebyWiFBO0Ily0BoVu0Lre1Xj9a5v5l4SHZZXzFZbga1baWZgXD5R9WVvEDFoduTpRSpgix6dczy6dj+LoQb++I32j78IgY+wA3TlABUsHm4BmSWGo3xLTFUkgLqQ6CS9TFJMchEzFlakoy2Qb4u4MQC9teCA16IFR1SSTmGNDOQFMDeYbil2RiJkrdIDSqidaqznlYAJPezKBimAdHR2sX+bw996wPR9IZI7zYQzwixmtrAYsfcnepNrxoJsiR/i8HcJYmWPq6d6jnK6sDI7jvjDX3upioPmaOz4ELxhLY6AoPzo6z9tUfpQKiYtMrpg5YgMCdGG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1rRHE6QiJDzX4ylZe3+X3jknrWTdiK4ksTpg/GJDB4=;
 b=a1hsrXysWcXjqzZmRC9JgNnoPqrp3eU89QyZpnMJioUzTPtNkZzx3cFFIkIoeee0FeuwqTWNtLJdBaLIL6g/O0M85LxbNmXM56S/N0Tw7xdpLDETcFCRtmDUsy0JUBYS4FVzWx5PhtQzSZwXcCuSxbtNHxCQfSsvRCXm3u/z+ZYi0Dz8HatGqIxATq3aqhFokR1tCWUxwdI4dRm1eF3A3ZQcBzus7OprdA6SorV2QffQQQcNcbLrQWKdmdNxXKy08lk9xe+/gw/BJIXmTwy0tTEKFAeyLjQmEwkfD2ScrGxLu4W04ZTM0hnwhruvgdQRrZ6Hu4JJOa5QNbEHC8cV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1rRHE6QiJDzX4ylZe3+X3jknrWTdiK4ksTpg/GJDB4=;
 b=Y14hSPJqpfTnwr29F91NyaXgvbFr90I9Uv4bKTY0pPxzXnIvUb0ybcJVU7BXGJcog+4crkjEH8zQ6NniUCv8bI/N6b5KkTP+WWuWrYBpvIWk6VLI15BuuSJGLiEM4SuUaVO6fGjgifvrW5LZS1NBWBUTiSVxwElfGYXq16ubof8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 18:30:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 18:30:45 +0000
Date:   Mon, 29 Aug 2022 11:30:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Message-ID: <Yw0F0/Fnpf6l9fgO@monkey>
References: <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
 <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
 <Ywfl/HIeO/ZbwYCg@monkey>
 <87wnatrdmx.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnatrdmx.fsf@linux.ibm.com>
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0499d9fb-3bcb-454c-45e9-08da89ec968d
X-MS-TrafficTypeDiagnostic: PH0PR10MB4584:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYkfA9HMf9xyrv3aKTiKHn3W1NacdLnYkkgf+JpouAaJNKKphseNfbvKlzdiYDbSFf4yGXs1Z0XflMYLcxjkP6/LzhR+Nc7niDDHO1lZhllye+aNSZBxJ6yiWRqgU7pG+Ax2mouOPFwTVRdZJsEYdf3Zssd8NXWamlCXJ250sgLN7FAx3gBFmfkEEeUB8z/SynEC6QbagrBSe56MLwdpL0dbteEDTxIDdBby9yYC0Ri8e2YUMMZb0uteKUc/p8VspTQih4oXYWca3JXc7MdVPxB/OnWxqtd1uWbA1Ehr0HhB9J7SDni9f/N05+3TBJiDlVX85xWVD3BBGB85YW4+u91+By7EIeGk2g3Yjs949q8tcDDVKjh5H7RP3n6eHrKAhUUx81kJ7xwLR31NHbciUPDLNmY7uGmA3Aasl0ALoiXUMDJQ8hGcwzyV7UgUoNt38RsA8+bmKNKf3o5axF9sPntHfJCszgRCZNnRHQYIjAB49xd/k9b+7YTfpj64ZGcX3XlKA08vKYBx1sJ3SLTFDb2YbnnvTuRjdc+oZEq1dWbR3sLIhRJVBT7RfhjVXoMf1jztr0uBUfzGCh5l64cuxIUNtQLOnWuJlPnt6RztP+Bbms5jPY8ITcKz6qzuYPybyPWSxUnMqTOaWtW1lH1rSJHxmtzIEHxhfkYMJz4UM7e7Nohk37BJrIGWPgyzAa+OF+FsfzvFNLPOkurl0roYY/XV481XOAlg8++xTsgUr4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(44832011)(8676002)(4326008)(966005)(6486002)(38100700002)(8936002)(316002)(54906003)(6916009)(33716001)(86362001)(66476007)(66946007)(66556008)(5660300002)(83380400001)(186003)(9686003)(41300700001)(478600001)(6506007)(53546011)(2906002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUhULo+bVbPaSU4Q5hsoU7tbQTxfQBo2v7tQyGn6SkZJq96zOt5HSSHo5y7+?=
 =?us-ascii?Q?nODaP/55HtZ2EIS0maf6i0HleMctO8b7lsVQsGMfYI0UvIOnpJeAvf+MlB9F?=
 =?us-ascii?Q?iUBdop/EQQIS5fqwggoQ1bZ96GFpOTtD77L5Sx0AZ8FrFsT1sSa7TffQrFnK?=
 =?us-ascii?Q?tk56xCQLqWuYl3L8gsWo9vouxA6cXF2/1sPlNjYFEJlg7p1dOKd15hLOObS5?=
 =?us-ascii?Q?HVBbxC6EK/JGBA6C4E05I94v94oUZtpj7Xe9QzhUWIr5vpB8XpNBornwzlu6?=
 =?us-ascii?Q?fX9esd2TlWlgqeHBYag7Ac9nh6EvUqfY5G/3iZn7eQk+TR5QeS5pQ1Ua1fcK?=
 =?us-ascii?Q?Jyuiizq/DIVa+PUaGQkqwqaUZ/Eal9j1MBAMeCDvoCASgC2tAhJry4wNL9IM?=
 =?us-ascii?Q?mT3iIa+AkGxhCIqJlZwIyLXb+jOqi23TVRTKM8kqzvTDosaDjypy52LQ9h3L?=
 =?us-ascii?Q?+1tBdVjU4K3FngLPX/fS+QDu4mKRQs+UW7R05cIG6hxXGZFUuzJB/4QeP6GR?=
 =?us-ascii?Q?tQAjcUkN6TQMq6opBbU7bpuDnNAtwr3IwRinAakDXjO9pph5KoDMl7u3NyfF?=
 =?us-ascii?Q?j5JFvN8GqLDPtCLrUjlfbjPP8XrFFYk2kmxnHfXpLBsQzjXcU0e9G5vqazXS?=
 =?us-ascii?Q?5IJmRXX6/BjlgEI0Ff0/ZJBm6uUkr1x9YaJ00Iy+guP8ZPssAvNI9qcwf46K?=
 =?us-ascii?Q?JiWKHV9aXePghp2/BD4wR7vSpqhnWacr6CNGm5H1FQUNlLjixkaiwv0n2YgD?=
 =?us-ascii?Q?rjX3wrmJbzC4DJHQbFbY4EDbEXdsP7gG2sml5ZLxtgxpI/ijUTRdnqTUEApn?=
 =?us-ascii?Q?YIxfLeS0LMPbm+uBEE+qTazq9gRJBo5kGMKG10Tb9oj/g0Vq+FSDC5M+4mwd?=
 =?us-ascii?Q?Ca7bfnbPVl7Zb9P98FkfbmPwokutCZ+3HR+hJt9bmppsHNh5GgZYGw2DURwA?=
 =?us-ascii?Q?y9KvmtEFLFmqpjxO2fG3CaR06I4eq/Q3FwKGIaYMyaLl4eqR9EOsNoB6u30A?=
 =?us-ascii?Q?4Wfd+QSVf9eSQKAPWmYfp0+CnIypvfr8JIFoiM4THKXu2+NSIfKpUVVAAtb0?=
 =?us-ascii?Q?OEGJMyhPJ2+a+3Bkyl9KIZtcQcMfJUf50zenfPuzePMZv4wzDqAyQvYpYZW2?=
 =?us-ascii?Q?hG+KmpKKUBRWSGz3Hf+n46UEAX1oiPlAe6VE93M6/o/CBAvcLoNtfrn1hIF1?=
 =?us-ascii?Q?iGr/rGkDdEd/2+Z4FoLy4FNYAdTNmGNwuTZfbFdI283KDMuWXh8mCw/qZzOC?=
 =?us-ascii?Q?PGhdkloOmJoHPKEZOYXLNpG9ps7/2g/ucwWZm5+gbdkfTtLVltFDZ0dEo2q0?=
 =?us-ascii?Q?riGFC4cvN0BCTrH/4874UOdmw4jdjq8t7EEOrVo8wnBZzjQoNC3SkKZEM4AF?=
 =?us-ascii?Q?rGLOp3lAhJO79s/y7nxh/j8a70feNbBL59GM+dILmffi2wXZVDhTLZQNnqP6?=
 =?us-ascii?Q?SNYrG6fPg3y2Cl/M3iKQcUJxSLKgzrE5NzCOqrnj/Zsm36RPx09JrDCZjduW?=
 =?us-ascii?Q?ual1VJ/duKZQ8jPtiRJWfDwpt8bh1rwdRXCKe4bf5/Sy/3WiIDzB7igxNC0g?=
 =?us-ascii?Q?/nBxzCSfFyzJFvDTj+7Mr2iH4QyWBwqge5Us08VQ4xUbULGIARTPG7/aK38B?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0499d9fb-3bcb-454c-45e9-08da89ec968d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:30:45.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5Bz2I59d1bPjzQOxjfDeUo/7e/RAoDnpFV3ee8x3+x/4cVSvqEotIKD5BmiD6G8prT09/JPv6VJ/QS8Af8SRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290086
X-Proofpoint-GUID: K_cP13PDoM9oh0eNtCtsWvGT2rpEvEdp
X-Proofpoint-ORIG-GUID: K_cP13PDoM9oh0eNtCtsWvGT2rpEvEdp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/22 19:29, Aneesh Kumar K.V wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> >
> > On 08/25/22 09:25, David Hildenbrand wrote:
> >> > Is the primary concern the locking?  If so, I am not sure we have an issue.
> >> > As mentioned in your commit message, current code will use
> >> > pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
> >> > will either be the mm wide lock or pmd_page lock.  To me, it seems that
> >> > either would provide correct synchronization for CONT-PTE entries.  Am I
> >> > missing something or misreading the code?
> >> > 
> >> > I started looking at code cleanup suggested by David.  Here is a quick
> >> > patch (not tested and likely containing errors) to see if this is a step
> >> > in the right direction.
> >> > 
> >> > I like it because we get rid of/combine all those follow_huge_p*d
> >> > routines.
> >> > 
> >> 
> >> Yes, see comments below.
> >> 
> >> > From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
> >> > From: Mike Kravetz <mike.kravetz@oracle.com>
> >> > Date: Wed, 24 Aug 2022 15:59:15 -0700
> >> > Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
> >> >  follow_page_mask
> >> > 
> >> > At the beginning of follow_page_mask, there currently is a call to
> >> > follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
> >> > architecture which (incorrectly) provides a follow_huge_addr routine
> >> > that does not return error.  Instead, at each level of the page table a
> >> > check is made for a hugetlb entry.  If a hugetlb entry is found, a call
> >> > to a routine associated with that page table level such as
> >> > follow_huge_pmd is made.
> >> > 
> >> > All the follow_huge_p*d routines are basically the same.  In addition
> >> > huge page size can be derived from the vma, so we know where in the page
> >> > table a huge page would reside.  So, replace follow_huge_addr with a
> >> > new architecture independent routine which will provide the same
> >> > functionality as the follow_huge_p*d routines.  We can then eliminate
> >> > the p*d_huge checks in follow_page_mask page table walking as well as
> >> > the follow_huge_p*d routines themselves.>
> >> > follow_page_mask still has is_hugepd hugetlb checks during page table
> >> > walking.  This is due to these checks and follow_huge_pd being
> >> > architecture specific.  These can be eliminated if
> >> > hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
> >> > that need to do follow_huge_pd processing.
> >> 
> >> But won't the
> >> 
> >> > +	/* hugetlb is special */
> >> > +	if (is_vm_hugetlb_page(vma))
> >> > +		return hugetlb_follow_page_mask(vma, address, flags);
> >> 
> >> code route everything via hugetlb_follow_page_mask() and all these
> >> (beloved) hugepd checks would essentially be unreachable?
> >> 
> >> At least my understanding is that hugepd only applies to hugetlb.
> >> 
> >> Can't we move the hugepd handling code into hugetlb_follow_page_mask()
> >> as well?
> >> 
> >> I mean, doesn't follow_hugetlb_page() also have to handle that hugepd
> >> stuff already ... ?
> >> 
> >> [...]
> >
> > I think so, but I got a little confused looking at the hugepd handling code.
> > Adding Aneesh who added support to follow_page_mask in the series at:
> > https://lore.kernel.org/linux-mm/1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com/
> >
> > I believe you are correct in that follow_hugetlb_page must handle as well.
> >
> > One source of my confusion is the following in follow_huge_pd:
> >
> > 	/*
> > 	 * hugepage directory entries are protected by mm->page_table_lock
> > 	 * Use this instead of huge_pte_lockptr
> > 	 */
> > 	ptl = &mm->page_table_lock;
> > 	spin_lock(ptl);
> >
> > Yet, if follow_hugetlb_page handles hugepd then it is using huge_pte_lockptr
> > to get the lock pointer and is wrong?
> >
> > Hoping Aneesh can help clear up the confusion.
> 
> 
> I agree it is all confusing. At some point, the goal was to teach
> generic kernel page table walking code about hugepd entries. But looking
> at this again and considering we only have hugepd entries for hugetlb,
> may be the effort is not worth the complexity it adds.
> 
> ie,  instead of teaching generic page table walk about different hugetlb
> page table layouts we special case using is_vm_hugetlb_page(vma)
> wherever we can.

Thanks for your comments Aneesh.

I give David credit for suggesting that is would be simpler to just special
case hugetlb mappings here.  Based on your comments, I believe an arch
independent 'hugetlb_follow_page_mask' routine would handle all cases and
we can remove the 'if (p*d_huge)' blocks and 'if (is_hugepd)' blocks of
code from follow_page_mask.

Such a routine would call huge_pte_offset() which can be/is overwritten by
arch specific code.  In fact, the powerpc version of this already handles
hugepd entries.

> With respect to huge_pte_lockptr, it is tricky (hugepd entries are not
> PMD_SIZE) 
> 
> static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> 					   struct mm_struct *mm, pte_t *pte)
> {
> 	if (huge_page_size(h) == PMD_SIZE)
> 		return pmd_lockptr(mm, (pmd_t *) pte);
> 	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> 	return &mm->page_table_lock;
> }

Ok, so I think you confirmed that huge_pte_lockptr would work for hugepd
entries as they are never PMD_SIZE.

I will be sure to cc you on the proposed changes.  Thanks,
-- 
Mike Kravetz
