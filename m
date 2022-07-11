Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5D570E51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGKXc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:32:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27ED211
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:32:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYG5R007080;
        Mon, 11 Jul 2022 23:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=KoSPohyxxZgDa1GHW7mZQznXnNWqksRAsgyJO2/AaPM=;
 b=q/EFkopk+GtngMS43in7G7n8ywdOjyFzYnGqLeaj8F0+Qw5P9V6CQOqk4sJHYsJpeNhp
 3NNVdUOPkuSnjjSzbwkQX3y2EvxEe7sMMoM9Cnp7VnAiCYQbq+NH+hiUKOgutMuip5bB
 tHrc7WNoleSTrBneVRTeQpXlzGpxZwc4FukfsaGnB+Di6cj3Y/oELDGPsSVb3Br22ySn
 jeXcCucFlUJxggnyw1xppQWNaTrEPsaR9wKrOuDLVL9H0y9HYzJ4qPK0Ow4/H7/k99Bo
 a43BOn8bgouBvDu+OWT6D89GBqh92vEMjmN/2TRmG9ao216Xy8y522yoMRFdrZ5n/7+u vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc514t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 23:32:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BNLZWG018691;
        Mon, 11 Jul 2022 23:32:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7042ssj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 23:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8nyI8xS+vIUTWTejl4WMSmexLRadF9A8M1FHqBnq/HF0ldZEhmlCTzLV2C/W1QzJKa0JENC/2Zqw89/aXE96gZpxZHoxynx5EJ3sPR5T3+bxmxMqrNh3/x5/Xb+cusbvLBv0hAJYgg5Z7u2tFKjNBEEOltw1/utYDJ+w2c4/RT/+b19r02ZpqaLNgqNR+oRjmHyFd8lyL3CPzN5MTP73GzUAReuWaLPsiIO66E0yx5aMyzeabN8xzjswtf6OhnTvGExdQG7gCYEoyRjuPappTUFwR8gAus1bQz57Ytis+v0htTxl2JKfLkDQMdyMyMTtIduuc/0g1cFDXg1fbtodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoSPohyxxZgDa1GHW7mZQznXnNWqksRAsgyJO2/AaPM=;
 b=KVru7bjctgIa6/3QCaw/IQk5plMbvpeCU4Hqxs7LjJa40RZWcF6nD9zfqQQt+FtLfMQd1qk6etDBYmesHNn96Dd1XZ+DvbOASSiZs/jODSorcpTQngyh8Vqs30ok5SvjHIJErJEqKXKTwUy8p3sIhM9P62nAdzAAS8/Zd7YGVlYmQrVBSPZqie5p/WoxAX8Np0popRc0s2wyDJ4fX+Tz0Pto/gN/ZwmcNICWYxmUUmspyU3tmhHxgfkyOBOaeAxajSL0W3WpOZG0zB2IJBSahpm6T9NSPOIaezydlGx3DJsUWaCuuhAgntiGxKQYmv1RrFDej7YWebe23WCn3QW5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoSPohyxxZgDa1GHW7mZQznXnNWqksRAsgyJO2/AaPM=;
 b=KIo7TOIsuj9dEL0REHHP2FbdpXOOTmf6thyILnFD67Bfh9uPuAoq9g8P+05S2017YfNarRprNPQpzqBTuGBYj32k3sBqR53vAGrWYqjcH4xFmtkKTPral4t8lP2U+j2oekliClJVNH0FXdAcUI+WAvoaBmPu5Q5fVeHAG9relPE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1838.namprd10.prod.outlook.com (2603:10b6:300:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 23:32:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:32:43 +0000
Date:   Mon, 11 Jul 2022 16:32:40 -0700
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
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <YsyzGMS+MS0kZoP8@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-8-jthoughton@google.com>
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41477d43-230b-4dee-6a09-08da6395a741
X-MS-TrafficTypeDiagnostic: MWHPR10MB1838:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ok2QK5NuPRXymNEo9b9G9brSc65Q/f3YopkcWHs6csnBcvGNzCGgz7gMRyGeNsgb6O6N2kcNwS0HoB2+bYbpx6bqZo5m+k1kroZrne7x+wXxK/EiGmahVJtV4n3E78a4hsQxZYk5ZyA2gL1b6SBoPvwrBd/Qgd01gQCUiqT+tF1fZWtOiHGjnW1enu/nWFwYoPfKdQicYid4wOpOX71Qwa7T3rKFFIUWQa28qEeG6YeKM2nCaIgVCPzT9MFVne10bXi65H8AOaqlrTcelwxCRxI7ITjPksI5rKIcK4JjD9HXS1sMmTeiw62PwWTj+QIjWPuYAm7UQmykYNGgR89fsvZ61rLsKxrKkTkhGTfi4iT88kcQZyWtM49+2YTnUq7knI4mDboUB3pc3+4LwkzAbvz+tZmrXEZEj41XtuTy4VIxPFgqmYneEtOY2JlPYk/3XQwA+P+IHxsOWVbkqy62+vyf/2Uaoy4ksr8Tz53hXd8KGWd/Tk90+Nr/aevTxPWkuUF3j7cGDl3mKVroa5fIw+0Y69NsBF3jpN2+PUwCdWGlWuDUqgYq7Mu86WYaw73xPOBWt24DLd7Y6xO7DVbgUNHvB4Bcwdc9t5rDpfqyH+2nLJODZgBOeuZ4rVsaAvDZqqHmAE4/rVPXDHcKF9f8iRX7hLvxYBY0N4HK0ECXwEW3S6PKZ7L+KPoIx0EmDUz+Htvt4wyH7hOojXeKMRUabSW8wktYCj41+D00aAS4glVDJROvamFH72IQiYZP06SaxjQy2h2TOj8LqLq1p60fdy90ylsw+7rZ1Qpv4GMaDpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(8936002)(7416002)(44832011)(316002)(33716001)(6486002)(38100700002)(54906003)(478600001)(5660300002)(6916009)(4326008)(2906002)(6512007)(53546011)(66476007)(6506007)(66946007)(66556008)(186003)(86362001)(9686003)(41300700001)(8676002)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sa9iTAjWopxYQUUFrfs15yfFR3rXkGPfgvtXuQ8lvvSfZPrRXKDociDygGVk?=
 =?us-ascii?Q?6IqxX52Jsfk1jlgqxRtRUALc5WwOqEcPwnwb8HZ7Gjc9zfqqhfQqhubbqSYr?=
 =?us-ascii?Q?c+f+1tE/QtQyJI460teOY5WDyanAjLyc3UKjv6hJjxL27RB7DZjJU1VNOjCH?=
 =?us-ascii?Q?ClerVJr0qRHk5tRIMaXDFUZxxc0IrnO0aTCbBIhHnVT6kuMLOamQgCi503uQ?=
 =?us-ascii?Q?Zl/GPL86FBWGB0HLJQRSelhA7ysUhvzc/AeNKBa3dLxAD4c1WKCHl3S277tp?=
 =?us-ascii?Q?DlmwYj5EJgpY5yOk2lNT98023NbUK/srAXFIpIpmXIjQUnrn9+IbVcUq4DNf?=
 =?us-ascii?Q?QR6n6/IYaQxs9t7bie+6lKkH553+qrag80yzUEhcKaCtoIpC9+PyWhn8XFnt?=
 =?us-ascii?Q?plrwPTnufGPvyj+L7fuoMysGXdO9Gf+2ytQ39Vc5RhWbPFY6XF6ZtwPLJUZc?=
 =?us-ascii?Q?iMNTLuIOk2F9BwZdydFLT1A3NK0+O1vI+Sj2+Bbqb/kODGBwjvbLE7VRPjmP?=
 =?us-ascii?Q?FUqjPgmzS4B4hioJ15cAXEvsLdofF3sB7RtSwqQW2JnRFIcj2cLwJrhXkiGB?=
 =?us-ascii?Q?upXLURnzu3S4Ww7eK7N118Ov6iByhMylRQA200Cd0tQcjhb+UWcidgScmuxh?=
 =?us-ascii?Q?uWv1HRMkfL2u5IY91td4hBxnhVfaTXXmL3EufsQgX40xtmje0jIiAcaf6pC0?=
 =?us-ascii?Q?g1UCad0MJQdQt+vcGZv7MxkBZuhnlky4YGWSrJa6SIu+gdOJV1yw1LbAOZXw?=
 =?us-ascii?Q?ELqPIxzxo/QGLrQlaWYhCWF4Jv3He0VNHoTfAyXqD7CDtfGhN6XtBODlMSg/?=
 =?us-ascii?Q?d/H8XzOfsfFwj+7Z+CsMH2YS7x1uZ5Dl1HLJqTq3avpRKcd17MHK5fjg7Eb1?=
 =?us-ascii?Q?CttzyHvq2rGKQYOIPtlplmeLHd7EAfcO6DECG0oJcxzlAluCd43MIfW4HiHJ?=
 =?us-ascii?Q?1FIqhX8n0UvJwCNWOA+fu7018RWAHCn/5tepf1NVlihWIj/qedhVyf1Pod0e?=
 =?us-ascii?Q?h5LU1+0xN0iF1ozD7eWG4divY4kijDDabOjHtdvDo6+qsnnbpDuRh6qBwt9v?=
 =?us-ascii?Q?lVxzNcxpjI3ryDDXS+MVRNnnpTyo5l6CtlcBPau3gSDnLZSviokZtMY2KDRn?=
 =?us-ascii?Q?8IhqhTbjPPUfHc9pXs9wpCnjZPE9HwFoypblASip0ZUp87bMnWO5yVsOWmek?=
 =?us-ascii?Q?WSYSRZ4rmaGvZIh5COceBiYpToe4xF/2FccFp+F8DU8EnqHZL538i2SA/DkB?=
 =?us-ascii?Q?fD06KuAqf59sghcKo54Jnd04NfUkY99fbtja89eByydchlULlVM0mx/k8XJJ?=
 =?us-ascii?Q?QI44iKtY2XFqjhuEXbw8EdBTim187cfklXwkmwVKMhQ5H/klZQy+qtD1BAe2?=
 =?us-ascii?Q?wbzCGPMXsxfr4WyACznxRnU6Y6lPng4oMkPS7ATXrs4a0DnFk/19W+BUILN3?=
 =?us-ascii?Q?MJrK2O47/jb9H7XFyYVGwG0ZdvOeoXcQcHGqPcOYKWsq8U8s52gh0gO/4MRy?=
 =?us-ascii?Q?nFrf2QWS4vFWR2LDqA2+MIK7JeG9SR+Z0GinXrBeeiFR4zXIKeg/9If4cXUr?=
 =?us-ascii?Q?KxVKMy9LvgywpoWDMCkdHv3srKdbpNM2l6urB/OKt21yeB2tHKegBwJ0gWmC?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41477d43-230b-4dee-6a09-08da6395a741
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:32:43.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcUhMUfFPRu1rdM9LAVHey0fU36wFn+0kwRk4wjD8Tq5AayCLojSy1EFmnr1v4fN0gcq+hu5FXtM4X1FvxnfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1838
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_25:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=802 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110095
X-Proofpoint-GUID: 4S8zlA8R_Ii-n4t9_tJzcJY4-GGDiyUo
X-Proofpoint-ORIG-GUID: 4S8zlA8R_Ii-n4t9_tJzcJY4-GGDiyUo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/22 17:36, James Houghton wrote:
> After high-granularity mapping, page table entries for HugeTLB pages can
> be of any size/type. (For example, we can have a 1G page mapped with a
> mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> PTE after we have done a page table walk.

This has been rolling around in my head.

Will this first use case (live migration) actually make use of this
'mixed mapping' model where hugetlb pages could be mapped at the PUD,
PMD and PTE level all within the same vma?  I only understand the use
case from a high level.  But, it seems that we would want to only want
to migrate PTE (or PMD) sized pages and not necessarily a mix.

The only reason I ask is because the code might be much simpler if all
mappings within a vma were of the same size.  Of course, the
performance/latency of converting a large mapping may be prohibitively
expensive.

Looking to the future when supporting memory error handling/page poisoning
it seems like we would certainly want multiple size mappings.

Just a thought.
-- 
Mike Kravetz
