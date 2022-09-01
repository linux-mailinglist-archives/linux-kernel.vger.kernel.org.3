Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DA25A89AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIAAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIAAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:00:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5347C72B7E;
        Wed, 31 Aug 2022 17:00:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNmjqW026908;
        Thu, 1 Sep 2022 00:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HtsM6WGD3EWAhgmoVKSr06yJsl6Tr8kz+mJIPtTg+g8=;
 b=GO6srhPwdyNYrpoEmK5vrrSdBWs4ppDMQW2FTGTr0MXHyC5qW4EGpCHL5qbK/CSd09Aw
 GihNotrmlrJ2yfW9FqGRwc9D4nTebwWKBAKzc370qIDW/TzEO+iJz/VmXJ/ttlxH68ux
 4dGv6vyyY9ZZZOUNueUDrgxcOWNiAICf6syo27WsWudnpP4MxpqqRlNYgwxL55aMQc1W
 VJe2m1tQ/cSFER8j2+uoYOpLWFAqRHJai01KcVahpH8XsE6RrVbjlgsNRhxE2ALC8BQp
 UQ6uXKhXuCJJ94DNXbxga8wvMTEYyJhZ54YsNS6ZJ7pAsMY2yOS0KNhLgclvOdXcHPEc rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsjm9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 00:00:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNN4cd014620;
        Thu, 1 Sep 2022 00:00:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79qbw5pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 00:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWsj0ToK5fFjCjk6MakNDbnv9U8BMo9gkYlr4hV5MV6mz64J8aQ3i0Bmm8JhpjU3umMuzM2z7gAbPMF3fS9Mie8Wb6mEn+ab2Qjnyfz688k+nu4E2g3p156Q+2bmiRwc33Up25cUyl64NARagvQemJYG0Ckw680Vl0v5KVnjgJLVFmatOORGHw/KTwW214X0z518IhkAkw5K09pUNrsospAJzQ8mPwjC50IKaqDqa4nplgv16eBoY7OWw2tcqnL/ITvl1nV3JUY0XcVtnAD1MS3aWeTEsMlWYQsIC9XGIpE5dhpEANEApfIjM6Dz2HtitxHCRnvibAYP4desuOQ/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtsM6WGD3EWAhgmoVKSr06yJsl6Tr8kz+mJIPtTg+g8=;
 b=hDGgyCmEAIfTHz7OY3cOaUIYyKAzqZza7gjLonIUDs81j8qAAX8CzKm933hDqc3NQdimiXM0qYTA3YFjxETNwr5ATqHVq/e0MHusb2Cgy3JDfBOUeXiyiInIRiPJL2ET1L908SqJubYkf2vDOEzxjO0ihx8ePLU1FBzT7N9hVVxoFeqoj6TpJ48fe6sdpAM0wX9RxpIEXf3LStO/7TNaB6WaMuZ9y7pQPGupLvRyjn+3+nXQZyePkUbEozuVSPgRKCfxlllACI3Gl85+anAp1JtSub31PXtjNMFzLSftqNUjSjgBaK+7CALsyP9TJItffchyggVez0pY3sy5RycX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtsM6WGD3EWAhgmoVKSr06yJsl6Tr8kz+mJIPtTg+g8=;
 b=BaUGc0zC+ds4asqWEGMc+4QB4rpUOZX49PEOQGcziwcLZdsP9yHfIsrELU5eUH7vhlKJ5bJRmARZ9VBhA+jtxk5xiFJm/r5xRXxLhlm3xPONgejaMlgvTZdsYzdQ0QGO8L00KYpO8uSlKMv4NhsIiThXYUD9dqeK2QWdiUhN11A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4900.namprd10.prod.outlook.com (2603:10b6:208:30c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 00:00:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 00:00:11 +0000
Date:   Wed, 31 Aug 2022 17:00:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Yw/2CDbFDX5cnB2o@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <57c8f032-e48a-bacb-7922-3e2cc10dc0d2@linux.alibaba.com>
 <Yw4+YvdS9kJUnx1s@monkey>
 <Yw5ZTEqxZCAgEbK9@monkey>
 <0a8025eb-cf15-453a-7d7d-7c72d008889a@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8025eb-cf15-453a-7d7d-7c72d008889a@linux.alibaba.com>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72c793b-7c24-441c-fb9f-08da8bacefea
X-MS-TrafficTypeDiagnostic: BLAPR10MB4900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2sQrS/NbBqciZe9Z8NE6EhKnB3FWbAv6jgOl4sYgmOVfO4rWAxBDUg2BZ9uM7AuZ+xbAQjkFj252Ll3uup3YdlbxvL+10A9XLpEkONly1kHu08YMVtSCpMmMMaFEPaYf+sptocgvJ8GVHvX2kkQR2dSKCD1w8mYruf25U/15/tzvdDnNAz8+CXM2mvCfreLsO7H9/pFzFiRQAeU8E8cjhM+wydhgsVQ0IZ4J1sdSgkE4kP+rJzL21E2N0QaUFL3Wgm4pzY/faqEvlJUlNSuzWawmiPTv6jLkeKAP60telMgq1LpkPUPSaROnCh5LmhnO33CCbyRddKtVm0KjOkomBSV7Ys+QA/orAirfXIG/erev1rZs0EcumbT85gNiCbsLf9bGcDGSYiRvLMUlprrlQJ9LOcVA8jkMHu+tUraLPn1k/RkFk8olRQkKgZnOnJAYmvgdrf2esfYeEZfsiJuY4HpXuhfpparo9+iMBa7/umsWkS5ev8eD6kKdAvhzVNI9qb+FX09IliJf1w2Kgw0i99ynlKd6TsYf09TfzRo6RAiokmxtsaP4v1BXbm8Z8TgFGPgZjFo4RZ0w/VwyfpNOEKwlNcfKfATb/w0en+c5rxlZo9ByvsRfj914pYOZpY1s5bwM0C6CkM0Br7DHhZ6aBaekwyf1F+3TxVpB8fWG+oWXBxyetRw4hDnp//uJDQ1NUwPl99/x8UCR2XOtCv5TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(186003)(44832011)(83380400001)(7416002)(5660300002)(478600001)(2906002)(8936002)(6512007)(9686003)(6506007)(6916009)(54906003)(26005)(41300700001)(38100700002)(86362001)(316002)(4326008)(6666004)(66476007)(6486002)(53546011)(66556008)(8676002)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rfpZaAHFZTd4p1UqX6KBLe5DBYc/PMeLtce8+BjuhY4ckE/90+NMnnoWY218?=
 =?us-ascii?Q?aBeNmJLlyP3SYZMtqRDct8PYNr2CAZAwJ5pWq0TtwJztNtgMttMO9DaY+yCo?=
 =?us-ascii?Q?3PFB9d+/GzY1D+TcAQIGbl4I1UFzHDhgh3Gwx47KaKfsXbmtt4jbCK6RT2Eb?=
 =?us-ascii?Q?iSTpo0nGcJidzFyNp94Ju/stPYpaLbR0HIhKgghta/F2TK6SNeAFPrBfnayU?=
 =?us-ascii?Q?805JNU5NwMBAdUJGB+EWYDpgyt8Vp4FlKnuAbHGotjHB9U9N/+qysXorp6qa?=
 =?us-ascii?Q?XffFYoANbjuCwvD/irwRoF6BOkEUHf1vRLCz1b4DLd5dFVzNSQxrh925pLVb?=
 =?us-ascii?Q?gUDjXeQIXfaO5XPKYvHqtk3pjhcSmbduW8V0DzRZA7JtdgchHH2kxSqyFDM5?=
 =?us-ascii?Q?fFRt9welJsyfJqTaClo4LpWlQ9evNSIFeJxHqMnHHDsifFOOytwF3+zZNrAY?=
 =?us-ascii?Q?AcfAvxmeEPMig9eX7xBawWJlERXDxvgJSwrr/r75iBako0GgQiXdJ+6gi0rs?=
 =?us-ascii?Q?nous37Q91y45ZCfvcK21h79tsQHDJTXmdzY75N7eeOReZj/3WVDTINbHpaFP?=
 =?us-ascii?Q?jFmlDuS52ERMPPQw3nuHF0T8w+VStv8QLX7LTGhQw0+LbkHupYXBN/5DDFyM?=
 =?us-ascii?Q?jXsjuJB0RgWZ9qD0FixmPbKgTpALC28P7XRZ7HGHaB81TmCFDdxeLbXTCzpE?=
 =?us-ascii?Q?9dF3jiKot0nSXecnxHdmue+kVqExi9EZAJjPd15e8Epk1NQUb9Bcuf/IA38Z?=
 =?us-ascii?Q?lQfr0dqaklL/927z3DsGycbL649trwRiHOzDARhd+OMxzk2LhgvnLc8rhGuD?=
 =?us-ascii?Q?Z5hQZB+MR/3d/u1AUgrj4+6hPmR8iTHTHqNeq1RFEdeA8u/ivmu4b+5gi2U2?=
 =?us-ascii?Q?c24knBJpFOSbsH9T/9YBrW4i/GAON/7ejpO0ekcrCVOh+yZEbxGUyBQa1LCJ?=
 =?us-ascii?Q?xnNkumRP6LFX0VsIEmnfWjXasnhNkkKQa6E0SjWH6G8PS6ieevjwoyPfU6dn?=
 =?us-ascii?Q?AoIOVHEBn0HJAVpOxV1P1bfAU9crQYlXRQuTj/Wti1aAEAnfgQbLrVMu4ahv?=
 =?us-ascii?Q?lTurLuYFu81lydLXigBckfxK50tAmLE7X6EK6GGKMsjb8+NxV1EnaCmNeU7j?=
 =?us-ascii?Q?qpRtTz3h8Qc9rKxsZWCxg20IpJore8QaaA2BAUK5en2BuKIKKIVDIOucDNGn?=
 =?us-ascii?Q?zedesBIQNmz4bnGAeb2ZjR5nU3PWCgqWXh8DuUo+F3bTjAdzJITQVLDhCALJ?=
 =?us-ascii?Q?FbKlcNNdI+aHFOUrKE6DgUxcl0OWQw/lfg6C0CIaRUO4WhQZAcWOpC9PV5ji?=
 =?us-ascii?Q?ilMYBrwJBKXw3mA5PsJytFvu0gVHjplh9ubPLC7jQ0yJpiTjve9vrd+34hkC?=
 =?us-ascii?Q?p8BGwFVp2HbDkae7sjDcJfMzHcKEeXyj5Awmk5txESkYHz8An7AvLJ/UGGh2?=
 =?us-ascii?Q?BgDAqEqPJTvOJdo7LMCn8vEFf+lHnXYwDQkDSzWibKjDhaNxXsxQqSAtozO+?=
 =?us-ascii?Q?gv1Zb2MnDd1EOFHoVYFHIY692wE5bt8FJcM7yWzMlzUfAnXNQRoQzydu12JL?=
 =?us-ascii?Q?5nYDh6L7vl2A05f8EEoZgkXtMbooQ55V3UBTu/1AU2elREzBaDtYo6g0XPe3?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72c793b-7c24-441c-fb9f-08da8bacefea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 00:00:11.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6zHFjtmtPewmmYnbkq0bMwWOxQ4pTanKcdxIauoalE0VU3wnvb1/qR13f0CEvb3qr3I+puOflT0lufdDhmwfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_14,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310115
X-Proofpoint-GUID: MVfj588MluW0fAHWEjUaIfEdXnfuWC0N
X-Proofpoint-ORIG-GUID: MVfj588MluW0fAHWEjUaIfEdXnfuWC0N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/22 09:07, Baolin Wang wrote:
> 
> 
> On 8/31/2022 2:39 AM, Mike Kravetz wrote:
> > On 08/30/22 09:44, Mike Kravetz wrote:
> > > On 08/30/22 09:06, Baolin Wang wrote:
> > > > Hi Mike,
> > > > 
> > > > On 8/30/2022 7:40 AM, Mike Kravetz wrote:
> > > > > During discussions of this series [1], it was suggested that hugetlb
> > > > > handling code in follow_page_mask could be simplified.  At the beginning
> > > > > of follow_page_mask, there currently is a call to follow_huge_addr which
> > > > > 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> > > > > a follow_huge_addr routine that does not return error.  Instead, at each
> > > > > level of the page table a check is made for a hugetlb entry.  If a hugetlb
> > > > > entry is found, a call to a routine associated with that entry is made.
> > > > > 
> > > > > Currently, there are two checks for hugetlb entries at each page table
> > > > > level.  The first check is of the form:
> > > > > 	if (p?d_huge())
> > > > > 		page = follow_huge_p?d();
> > > > > the second check is of the form:
> > > > > 	if (is_hugepd())
> > > > > 		page = follow_huge_pd().
> > > > > 
> > > > > We can replace these checks, as well as the special handling routines
> > > > > such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> > > > > handle hugetlb vmas.
> > > > > 
> > > > > A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> > > > > beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> > > > > existing routine huge_pte_offset to walk page tables looking for hugetlb
> > > > > entries.  huge_pte_offset can be overwritten by architectures, and already
> > > > > handles special cases such as hugepd entries.
> > > > 
> > > > Could you also mention that this patch will fix the lock issue for
> > > > CONT-PTE/PMD hugetlb by changing to use huge_pte_lock()? which will help
> > > > people to understand the issue.
> > > 
> > > Will update message in v2.  Thanks for taking a look!
> > > 
> > 
> > One additional thought, we 'may' need a separate patch to fix the locking
> > issues that can be easily backported.  Not sure this 'simplification' is
> > a good backport candidate.
> 
> Yes, that was my thought before, but David did not like adding more
> make-legacy-cruft-happy code.
> 
> So how about creating a series that contains 3 patches: picking up patch 1
> and patch 3 of my previous series [1], and your current patch? That means
> patch 1 and patch 2 in this series can fix the lock issue explicitly and be
> suitable to backport, meanwhile patch 3 (which is your current patch) will
> cleanup the legacy code.
> 

When I looked at patch 3, I was thinking the update follow_huge_pmd routine
would work for the PTE level with a few more modifications.  Perhaps, this is
too ugly but it is a smaller set of changes for backport.

Of course, this would be followed up with the simplification patch which
removes all this code.
-- 
Mike Kravetz


diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..b2050d22d855 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -207,8 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pd(struct vm_area_struct *vma,
 			    unsigned long address, hugepd_t hpd,
 			    int flags, int pdshift);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-				pmd_t *pmd, int flags);
+struct page *follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address,
+				int flags);
 struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 				pud_t *pud, int flags);
 struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
@@ -319,8 +319,8 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *follow_huge_pmd(struct mm_struct *mm,
-				unsigned long address, pmd_t *pmd, int flags)
+static inline struct page *follow_huge_pmd_pte(struct vm_area_struct *vma,
+				unsigned long address, int flags)
 {
 	return NULL;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 66d8619e02ad..fda980b436ed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -530,6 +530,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
+
+	if (is_vm_hugetlb_page(vma)) {
+		page = follow_huge_pmd_pte(vma, address, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
 retry:
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
@@ -662,7 +669,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
 	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pmd(mm, address, pmd, flags);
+		page = follow_huge_pmd_pte(vma, address, flags);
 		if (page)
 			return page;
 		return no_page_table(vma, flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..e2e54dc27b00 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7155,13 +7155,23 @@ follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
+/*
+ * Temporarily handles both PMDs and PTEs.
+ * How can there be hugetlb entries at the PTE level?  One such example is
+ * CONT_PTE on arm64.
+ *
+ * The hack of handling both PMDs and PTEs is made for a stable backports.
+ * A cleanup and removal of this code is made upstream.
+ */
 struct page * __weak
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int flags)
+follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address,
+								int flags)
 {
+	struct hstate *h = hstate_vma(vma);
+	struct mm_struct *mm = vma->vm_mm;
 	struct page *page = NULL;
 	spinlock_t *ptl;
-	pte_t pte;
+	pte_t *ptep, pte;
 
 	/*
 	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
@@ -7171,17 +7181,15 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		return NULL;
 
 retry:
-	ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
-	/*
-	 * make sure that the address range covered by this pmd is not
-	 * unmapped from other threads.
-	 */
-	if (!pmd_huge(*pmd))
+	ptep = huge_pte_offset(mm, address, huge_page_size(h));
+	if (!ptep)
 		goto out;
-	pte = huge_ptep_get((pte_t *)pmd);
+
+	ptl = huge_pte_lock(h, mm, ptep);
+	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
-		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
+		page = pte_page(pte) +
+			((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
 		/*
 		 * try_grab_page() should always succeed here, because: a) we
 		 * hold the pmd (ptl) lock, and b) we've just checked that the
@@ -7197,7 +7205,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait_huge((pte_t *)pmd, ptl);
+			__migration_entry_wait_huge(ptep, ptl);
 			goto retry;
 		}
 		/*
