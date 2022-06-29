Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF1560B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiF2VER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2VEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:04:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283C205F1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:04:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TJq65w008087;
        Wed, 29 Jun 2022 21:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8CcvGyJRlMnaXfCQLkHHYYhiqdFfvA4aGuy85FbR0M4=;
 b=Ftm2iq9gi/NOkCGvsSRWBhZnpsqRyy622XTmUc6Q2xI+f1qStTgUyKyCOg9NtHI+OIKJ
 b4kwlPlsGMW8QPjjAgjSYFXwPR2Mj77KyyFfc+oqdwlLhDy2kIQxChUaMNEXQMZV1G9r
 Bto5ppU0goXzHgKxxjcucGSvKWVHMZXypi6rMTCuSzkfrbMN80RKxpBkBb5zxeYgJ8EK
 7l7obtNPixkFPu1UIlCQWcHNULuu/Ecn5njr/FTDXKx4BlNn+ePOSMK0LfittXVMrQkh
 mnlj/LY6ThIqGfvXKCkKgTK/7VvpVTqSiBFAU2MyiwompH4DoRxZ2IrgWrhbB2yzpHcg Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0jfm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 21:04:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TKv7Y8002066;
        Wed, 29 Jun 2022 21:04:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt96yn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 21:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot6tslFuFlwnK4DdYovrNUvwuPoGWq6INknbbFdUMWdn5XoF5fnftkzzAxNDNA+/FrHbe4PDOUOqb33cz2Q3Z8ei/apJGWtBZxqOS7ArECuvOkFU2b3lJZWK9rBRgCONg9SUNF/Z3ipR6br5cn/arADkAR1PD0f8B75mREMY6YxXH9Xvb1+HWA6IK7W/Vsh97fD3lC/ZMIi32WD2qn/IuswSvn/839mWH7sEOeGL3HsaOuzGW8F2+yPYWcjYRcQF27A5t/1Dwric+9ASDcR8tShB5TAH7NZCvclmgpQt/mLCv+rOY+fmNpBA7BDGuD+tbHfjR3uRfSkK/AQdJMYSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CcvGyJRlMnaXfCQLkHHYYhiqdFfvA4aGuy85FbR0M4=;
 b=knhuaQnHadQPhAqflPtgjMkKETyyWvtFBxey5/b3bJEUZe6pgMztzT+fAD/sMizDlZEbKZn1hVFk+yGcgZ8eEEZfedBHvtxuIhmsAXQ9Yz5wpmRDMnP6P+ALefc01ET/suz3mYMhqtB+ItULuvvgHYElb47Qqdr1J3qi4sWz9WwN8M2zVDURv6zxnj0rDORtLaHDtpmaxNaY7Qnl0RbG593iTA+xXbjzlOBI5uBRR/tokIS2TrkBEyKZz8oZ706DX7h7lYgPWFASi+BCWeX8SkaL97sxRqAwh10ayhx069kDnyUUKUHL4XHGa7UsZu7iDfB+epHUg2pbSK6ZTFtPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CcvGyJRlMnaXfCQLkHHYYhiqdFfvA4aGuy85FbR0M4=;
 b=ZbIto355myoG7lUSZmfM54WgHJJFy3mf3Ldwzyk8RycRG3DmaF30J2vay4n0RVQIZUFRBMwhlEDUdekFlP2oJNmdNj9T/Z1symiQ15Ry+drPD8Aa1yEOzo3kLLgHn1a6BA/bbhahduo57pXCF2PdG3/+pd75lyjdADdpEXDNS/c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3236.namprd10.prod.outlook.com (2603:10b6:408:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 21:03:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 21:03:59 +0000
Date:   Wed, 29 Jun 2022 14:03:56 -0700
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
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <Yry+PPHSat2uN+aG@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
 <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: MWHPR21CA0048.namprd21.prod.outlook.com
 (2603:10b6:300:129::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6be1248-d6d8-45cb-5fa5-08da5a12e30d
X-MS-TrafficTypeDiagnostic: BN8PR10MB3236:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x+pxGbUGMj4SRuDfOu4epRaJKlGEFs2QgK8WPNX2vV4BR1E8izm+7V8bCRtyQZsCfwApsHJUHZ9oVM1/PyztBAmGQZyJILcZK1rPgE6iDpOFHLnPehG+02zZl2hSvAAQYEdBNLKKipg4u4CFlJTgPWAQD3BJOGFWoJ2oYaFxYPyEr+frwnBJsC+uqV0fqBc6KMypG227pvwWyfSD9k8aNaXQKs7q0MDx3g3KG9faFY5yD6QxG+E276D6UAmJw36Q4UvQO1wt/O008JG4xiBG5s2rkYM9JhUrzUqDS0CwgOljTn6yppxDQh9J/zmTvmnWVX8sGny49QNU5bBuoK1HwGr0HVRqOzFWMyzSiCc740x3rwnXbOFoUm6VuGguWQsjga/0xCB3qyCOcYIyQPw5LPff8ekLdnGgBvUu8BN0ts2AAxPfwswxFuotH1zw3bHEOcphy2YSzwl6FkRreuthH197RPLcQ6Tt6hut5+C4poN1HTP5AsY/41Nb85HRprc2MfMupUM6zcXNwk1HeYekY08qL0jsRVmHDu0HyxQt0CiF8EU3pWRxO9vD+cmqzEzoAHJ5Y+uj29hBwY0iyJlSj8iBxGv6SMVN1767uRBKYbQS3BU6nArtxs1jxaw5cWpFZbAncJ8EUFNf66YHFOA5e3939m0oyydRlCbInWsLKSZGZbd0mU3POy1vcjgT+oTj7AxXqLTtJJzBBg9gSqIw3ZQzMcS9RklF8vVgsC+xxb4eOsc1jw2BPuvSXBqs6/uqh37iC5OcNkX52u/QjThU71QguFrjgalUOeRZDsFIp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(26005)(8676002)(4326008)(66946007)(66556008)(6666004)(66476007)(38100700002)(186003)(83380400001)(316002)(86362001)(33716001)(7416002)(44832011)(8936002)(6506007)(6916009)(2906002)(6512007)(41300700001)(6486002)(5660300002)(53546011)(54906003)(9686003)(478600001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XG+nxsrRbawz+bEOzZwumModWwIQI4s+Cjz0wnpWTYH/kYJ+02dHyk6Ol4Ru?=
 =?us-ascii?Q?vxmqb7LvXUrQm+mspZNIY5khhmIaTY02mFtP3RrwEDXxCVD6w1RP4RUgd02o?=
 =?us-ascii?Q?No1k0FruXNb9u5LIweTa/EHk6NsvJ1zmgplQ88FnwkwbRVPAecKtoNGsEnl8?=
 =?us-ascii?Q?kSfupvh2VKOIXWKtaJgNg65MKxulVA27zB3ZzrbRNPZluN+vmrItA5Q3fI9D?=
 =?us-ascii?Q?JquV9j/o+w+eleM7bAM36zkDAFuIE3D93NYvG+PG8B+GV6eF/K0kBtZK1QXl?=
 =?us-ascii?Q?ZGmnbVADCS8+nSl+meWwsFJItARrxb7K/BLvqiTF4HDK+ivcveU8lTftWCYW?=
 =?us-ascii?Q?GooMcrvXq4dfYdI/KnvNudFFEY98W1kLFwSuz6flgzHtCU/a4L7FLnK9MaDA?=
 =?us-ascii?Q?QSkcyHPZDAuig67N+FnVtooa+sYBJ/rS2f8xm3+fMv9OAu/U3W0lQV+vv6r5?=
 =?us-ascii?Q?RB0ym5ZJOZBCXp+zB7SwC7SSeZWYYrPsrFactL04XVVP+KmbgT+9MrOqbe2S?=
 =?us-ascii?Q?pQOQqOU2hFKSvKWJmf8NzbumntDB5fdUlEPzLyWZVJjSYtNycjOOV/eemZHq?=
 =?us-ascii?Q?U08ihWaqd0NXSmk9sw4AMvigaqx+EjPOhCFpLaN8OUzWd9hRLBsitWLWBmjc?=
 =?us-ascii?Q?P9tl4980YJZsuT0efKKHrtm9isYXjFzULidAsSFMiTPuOz66dw+nshz+Qgfp?=
 =?us-ascii?Q?9kWeKiLWU6x/L60yGJsBr2EauAGXob4XaZr7E5nIhrDonfCe+EOLLd8DPwZE?=
 =?us-ascii?Q?Gu3trDXX4/rLOzIqdLSsEecbPSxT6/VqCqvfrUNsXewXrI8oxZXOihYKx++H?=
 =?us-ascii?Q?yd9MvKuQX84vgVgOKqGvRCZ/Cjl6WJwoYgTwfcquELAz+XmKBI/YyX04tayp?=
 =?us-ascii?Q?n6DoOBjLEq03HEfrc0QyM9g6Pme0VRtDtg47MSEObNiq47LRLW+B/epSkLvf?=
 =?us-ascii?Q?y0P/xNayE55h6Nwadc/fSiZu0g6WrMhFbixUnG80CU80iuqgIVxBnKw+g0uH?=
 =?us-ascii?Q?rNaf4tNZvcBx1SRPwOP31LBt/qKx8j2vwAKhm/BZav5ObsUuNCdwmeJuHxP4?=
 =?us-ascii?Q?ed2yxNthNE+4alMeqsixmmM7pSJxyMmO8g1A1syixXNGwmldEbO7FQ6PaWLd?=
 =?us-ascii?Q?nOWe95WvU/A72qgwT5dHxjsli2N+1TNxVdzGCYuvCXnRlENRRcsWPT2I8sqB?=
 =?us-ascii?Q?JUDjIr4XL3rl9dempsqtCoE2Q/q90vQBVTdT8FzxuPT8f0wEqsZaTGdrmSfI?=
 =?us-ascii?Q?2J233D8BRG3/iwWiEjZQuqjdiEAXCVxkeavYKJ9P3I/9mUe9LFL8tIbNxyIi?=
 =?us-ascii?Q?EdTSxHHxFl5RantlZ0WE0ceon+M5dxxy4id50dcBRE2FQpSCwB6hZchdhl7h?=
 =?us-ascii?Q?QiqibUYVR14jqFJtXeugxCQDTAW3ylZ5dZiYrhaeTPkZ7yZMlMCLwjEOOk9m?=
 =?us-ascii?Q?1++ZPN/+WKZ1yShT7fadYh2SBydeCDocnI09d8NqXfmF9Ti+MqT2l7eTDixE?=
 =?us-ascii?Q?yaCaAzplFEKEyfs9N3qWU/uvpok1/CR2dFpZdxiO4U92qjlAWugHf/1GAg1Q?=
 =?us-ascii?Q?O5cd1nb/AkWFcozgWuacLYaUMl/MHoRadM1bO/U9W69PIfWjUNDFCsNVnlHD?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6be1248-d6d8-45cb-5fa5-08da5a12e30d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 21:03:59.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TL3YYpJHkZ8Qy9XrKyr3hglPzpFdr7eRyyaA/GwBOsvRdx2EzaOJnhQvT0ZbqdJHvFG5rSsA9Gw0KPGOvx6/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=824 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290072
X-Proofpoint-GUID: uRFBuCnnTgJB672AYIzeN8PGWKlc8Q9C
X-Proofpoint-ORIG-GUID: uRFBuCnnTgJB672AYIzeN8PGWKlc8Q9C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/22 14:09, Muchun Song wrote:
> On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> > On 06/24/22 17:36, James Houghton wrote:
> > > This is needed to handle PTL locking with high-granularity mapping. We
> > > won't always be using the PMD-level PTL even if we're using the 2M
> > > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > > case, we need to lock the PTL for the 4K PTE.
> > 
> > I'm not really sure why this would be required.
> > Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> > with less contention than using the more coarse mm lock.  
> >
> 
> Your words make me thing of another question unrelated to this patch.
> We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
> did not consider this case, in this case, those HugeTLB pages are contended
> with mm lock. Seems we should optimize this case. Something like:
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0d790fa3f297..68a1e071bfc0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>                                            struct mm_struct *mm, pte_t *pte)
>  {
> -       if (huge_page_size(h) == PMD_SIZE)
> +       if (huge_page_size(h) <= PMD_SIZE)
>                 return pmd_lockptr(mm, (pmd_t *) pte);
>         VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
>         return &mm->page_table_lock;
> 
> I did not check if elsewhere needs to be changed as well. Just a primary
> thought.

That seems perfectly reasonable to me.

Also unrelated, but using the pmd lock is REQUIRED for pmd sharing.  The
mm lock is process specific and does not synchronize shared access.  I
found that out the hard way. :)

-- 
Mike Kravetz
