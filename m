Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89D570E63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiGKXl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKXl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:41:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F327FEC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:41:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYhu4001795;
        Mon, 11 Jul 2022 23:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=E36ULX6a0Yk+BvtTH8uQTPImiv+Xx0HcGbgR/AKjMCs=;
 b=vRAhbCLpE6dgo3dYkdIvUfSaWXEGJFo2cDN01ZDsfTJXHzY425z3YXFyi4haBUTTvEqM
 4t8TJ7/yvHJtQJvpLq1T4IGvZry7mAaz1l5TGA9NNK3kiWxsv8KLtdaFon5XxiB9oC59
 J8w/WGcz70rLYLCTj1+NQawIX8iSWPM9S2EK/kLZMybdy3Qt8cOhGSfpCs4nwhe0y4F9
 3IvVtvX7lYOQ7UcHj6JXwIl87Xd9LoNfYSRG+KgjuwZRj58S98yz6hhrpyFpb79QnLzA
 kMvOANO1eHYSWufVTrwa+cADtnQ4Cu9iBMYUFTbx5mGOVLOtFz+GWcEt2plqY0B/FyL3 MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrcyyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 23:41:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BNfHsk026802;
        Mon, 11 Jul 2022 23:41:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70434ug9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 23:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfTR9ZDwb5XSHJEZOLuB9z1pKw6hDQ4OpAVn9Xp3wUi+GDSGf+o25UeI5tHaJcX31UlKlP8aR0L0MW27vP0EygrEcdg/350x7fo5XebtMTgnmD86PIXdFvqorB21n6Sd2zfridZ6sh1MJqXRsk/uGU492XCVD9ovKsS5Jq07PbaU4tSKYGjC+Y2G0P4IUJjEQBxwOpfHTNLEXBZOrlhaIrRkYVRsoa79neGkwslKkR73G/tP1uI4JJbvRPruRITkWpZJHzQImuGTcVOvP/1nprKDC+JJhrcDMKN2TkZq7fFPTp/YhdYioXMyLjPG02lW/fVZv/JZuQvtGl1GDcv26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E36ULX6a0Yk+BvtTH8uQTPImiv+Xx0HcGbgR/AKjMCs=;
 b=HcoTsQnwZpUVE8zV+m9j0Ow301b2Um3aoUhnm1YITjYBb1kbX9zhq/raW2UQby4eW5N3kXVu683C+W9a9gJo0eVdvybagn9f7YFAOaWZkpqfdJj+OZBCwaJ3mdSTaqjs90eLCsDFXnimbm9s5mHBstXSBGVfLQ4PpHNBzGU3JP/3HgZYIMczOg116TEZEru1SJY9JxT+Kqk/aL+J8iylwYGMLgR3a5KGxYApdlS0cioQDrKUzEOTg2uAseqjQqCFs/ZtwB5d0NvW8LUzebW9m/Q3xKQLAW8UjSuFf+DmILgNWqDY734khhzowGCqoHyGwEmE3l8GNE+TQ6x6CneCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E36ULX6a0Yk+BvtTH8uQTPImiv+Xx0HcGbgR/AKjMCs=;
 b=WKFQ5TV1oIhZg8RdJLPIidygsD03ZG3JWMJsFKAo+yZkaKOGFanlWdLW2n8sE6HSalakK7Cxtdw2SfzqGfWLlwg6p2x+udu8XaKrWkrhEwzZrAYD9fDgcjOVB0/sgTFD1BpGU4U3GEho9pCORRnphbY0j4to1FaGM7VO4khoX3A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3725.namprd10.prod.outlook.com (2603:10b6:208:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 23:41:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:41:10 +0000
Date:   Mon, 11 Jul 2022 16:41:07 -0700
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
Subject: Re: [RFC PATCH 19/26] hugetlb: add HGM support for
 copy_hugetlb_page_range
Message-ID: <Ysy1EySRmjxl2TmQ@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-20-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-20-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0351.namprd04.prod.outlook.com
 (2603:10b6:303:8a::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e39974-82bc-410e-6d52-08da6396d54c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3725:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JY967lOMeMM4acTq3d+5H/Qd7c5+YhugQK0xxL03/oIDIbbgTW0tpcIyiKjeaFNbRVbXNFmJJFVswT32xUT3pLcbQ/ryJ+iK8nQZXAqZtFsY3UxkenX2Z3Nhdd7XvISTeU8v0bxhMkTMLubgKHvZmomlC8e7g0PW2iQ8JKH+xc3TkAeMREMEOSMi8B7133L4LdMerGZtt2sv2IG+zq+IIVQkFaX0WPhcNzANtvxqKJ7inHurw0BP9gn7uXrJA9Rxo3/q+WKvSEO0yZBT3zi9xexKAORqAcQ+meUlts1MIF/tMoZh33LPctTA2cGzsaql6bASuNfRaJXwv8y1rs23DIcO1k+rcR2A7fJUan0Xcgrqwv3CL21GbJfxXJgZ5L7N1itXrfhnYEYZW12U4uTG5swf34cuWlz7yG8sys8t/t8NEINEpYIAJOvsUgeb/rq5GMY/s4BzUlb67nYu+KY0Z1l2PJ8SsGcdXdSNuPP1KPTKf8/x5PirVMO+udfG+WESiOj3Ia+P3LWsP1G01vkJgG32A4yhH2JVyvuNNy9wSci0VUcRlEtNYWeS/eEnz71SRS5e19TA56TL2cmAPNqzamydPxU4ry+y+vi4Yu4rWFVCJHt/HLs/QSqj3SFuoPxF5nErtTrrzhcWSA7xemAci092SjC0Ta4jGinpKknGec4e4Drh0S3+hFDsGCnLA5u830KNvob9Cwwz+Ev0eNG06r4iDnE9iil9Xnc5SbwbKglbr4DbYyeXqtUlHcU2pSMdioHlnvD/fpaJPoMr+1ekGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(396003)(39860400002)(366004)(2906002)(478600001)(53546011)(41300700001)(83380400001)(33716001)(6486002)(4744005)(966005)(186003)(44832011)(316002)(8936002)(8676002)(86362001)(4326008)(6512007)(66946007)(66476007)(66556008)(6916009)(5660300002)(54906003)(7416002)(38100700002)(26005)(6506007)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmFDCcNlF8lgf4myshZYpD9CybvUMj8vIekqnOy3KThFi+dDLKVgtHGwxx8U?=
 =?us-ascii?Q?HbsA/J3PNZof83c/E19M8ngMxpvvAwtJZAMv1TijRx1Qe7IuS5GJ62joF0cE?=
 =?us-ascii?Q?cPSpmFgiTs9+f268yrPja2hqBVVh1HZdfn7CiTHI42ETHbpXVmj4MyUCu0Hm?=
 =?us-ascii?Q?SfT31BVEHpNsN2LaFKsSEyJriwWcPNPMa1ARC0FKhkcs+Lf/MnlEQs6L+/7f?=
 =?us-ascii?Q?yzTz6MWiujtbM2f96YpYXo3WQsF7xlRSFcNSnPKAbc0nwJuYn5nLynWVCIkF?=
 =?us-ascii?Q?ZpuBkwx9mkosOTcPiiTAL9NEyw9oRMw88WXatXjeVVP8qMpmv//cvhlRzYRG?=
 =?us-ascii?Q?W+9ge52ZU33a59oT65iDhm/dBqpATF3efGMi5Q82W7cuYY1RnimZRhWD0Wyi?=
 =?us-ascii?Q?CHkvPMwtZPT2Q7lJxXCur0C21GLoE2mrbOwohUXmrGVfS/gREfdBmSaI0R1Y?=
 =?us-ascii?Q?4TMLJ69GJ+MabMnx5iNBT74AQw2Wh9MEIuqSoQOkrXpvYkILAjlPP9Q4+bqc?=
 =?us-ascii?Q?y9IrChpqt8KXluhuu9O8zFCjJhkrFWUg/YyPOWLm7g83uJPiW3JFxK0n4dDh?=
 =?us-ascii?Q?vPHVoZDAO93eFK4NhV0zx5kCjAOMU4Kcij3QdJUw/ltMwntlgwFfrNqm9Jbw?=
 =?us-ascii?Q?rPeDDp2sDISS0NOD2GHeh71qPA0sifNcqyi2E6eIcQqCrX7B5ch61vDp4ZrL?=
 =?us-ascii?Q?qdcCkwEHDNCMSv9lj6xspTAmkeah82ru3M0vRIxHBuRrtWch2tpxiIxIndzw?=
 =?us-ascii?Q?Qbjxs7fRZ34eJjkcq0MWbtVXc+18ZgfQ2w3AxAARQbg5JEr5eWPXFsqdv2rG?=
 =?us-ascii?Q?VErSEl0dUymM81tucFoocdAUSzMN1CoNP0CsdG4qg5KU816jFGH3h6npCriW?=
 =?us-ascii?Q?H8rkg4PX19nd2oMVcHhHayDA8S9pe5HDPMkn0HtlFKZk3GXhcZf8EJPEmSAe?=
 =?us-ascii?Q?AvGa9+8vr++ack2XZPHhuxBMnT8Yo1P5upsjb//ECrEkXJnatsf+h0TpjD1S?=
 =?us-ascii?Q?809heonGkx9SszBaRae3Z3sZAzk+hvE2GZSvcYdhdQqMVMCMXruUbBwQ9KOb?=
 =?us-ascii?Q?rgOJG9HsMysL7AkIe17/IfcOGAb+eEW15nS/mKE0zwZnGthUerUKr0RxvCdU?=
 =?us-ascii?Q?pOoSPjUjFZ/GEMZ8V3DdgA/pTWiLzCxE9MrKUgT5QdBNFkjICyWKNeE35t92?=
 =?us-ascii?Q?1IBOzNgV4jM8yMmT9pGCUFP144Xp7DHNYz1yfhgN6Jvv0ZJB5aG1Ob/1Uhny?=
 =?us-ascii?Q?F/VfFGxdnyODyH4GTVrBiHjG8pPY20VAeKFJs5BliQ9AIV1isWLp5icklsLo?=
 =?us-ascii?Q?THfV4RrftUiDBKMEzODpR4lmChA69+3b/w34oFpTV7PiLateuMJMiLgqhNwt?=
 =?us-ascii?Q?L66/ClTzfeTIv5RRiOtncGNhIOs7RfFW2IGjlf3PrecjkOqAMN5P8rybm0+r?=
 =?us-ascii?Q?XKsvM90s098cAnqVcviadXlQZ/MGEz85rqpYjkgZt1UmzokjV+bvRuWH4wiy?=
 =?us-ascii?Q?GG71dsInUNzpOetNf0iM7Bd+X3o1bcP3UmIdm5CTZHPZnt0KTl3Nkce83AGx?=
 =?us-ascii?Q?DvRSODfMq80I4gbP9IzFq64oryGeYn1sU5u5i9VhyiCZvd5FhTUug+VEm6Pj?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e39974-82bc-410e-6d52-08da6396d54c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:41:10.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW4reE4B1goP1cqvQNsgsQkbPu6NO474Q1QcWnLaMh+Rxei9ygENRDHXPAmQj9cTg5OeLMtM6P0L+vucOy+XzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3725
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_25:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110096
X-Proofpoint-GUID: 3rIlU-EAeEyhCnBFBxRbMxrOm87UMv8f
X-Proofpoint-ORIG-GUID: 3rIlU-EAeEyhCnBFBxRbMxrOm87UMv8f
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
> This allows fork() to work with high-granularity mappings. The page
> table structure is copied such that partially mapped regions will remain
> partially mapped in the same way for the new process.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 74 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 15 deletions(-)

FYI -
With https://lore.kernel.org/linux-mm/20220621235620.291305-5-mike.kravetz@oracle.com/
copy_hugetlb_page_range() should never be called for shared mappings.
Since HGM only works on shared mappings, code in this patch will never
be executed.

I have a TODO to remove shared mapping support from copy_hugetlb_page_range.
-- 
Mike Kravetz
