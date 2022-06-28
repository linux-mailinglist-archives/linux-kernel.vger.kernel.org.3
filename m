Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CBF55EFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiF1UpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiF1UpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:45:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE42A423
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:45:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SJBV4w006351;
        Tue, 28 Jun 2022 20:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rfjEuAGb++dTaje/RFedI8QnT7GR4HrZG0pOy4dpZQk=;
 b=n6ZL1NeiY4MEviHZq8B+Qd3pdkjRr5Nl+MsRDlDLHzLrwOsjRa+yexA0AwRQ/9lpgXtF
 BXz4cDsd2LYAYt2P0eu4jP2AFuuO1CmBdWlB/5Y49M/p2gd1PEEfEUUiDfM2qoHecubH
 4psyW4oZUK8W+veQE5DM8B98AJNs/6IwR8OL8pRuVs3PlaKUIr83lLjeESMnljc3NJP0
 uHPePyU3TuAR8F1uvRVd2v8yugZLf0SCWjYkhWUsjkmQOUPOBeFEY8dOe4QILRD+Tmpm
 CoqMgD2JKSvk7rvVWOH/g0bhZ9WICuCn5BFTlo4ccshwhbI6GZPlv4krH55RurvYSVTV Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52f9yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:45:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25SKf3wx033206;
        Tue, 28 Jun 2022 20:45:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt8hkkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoMzW1XUvTlkAZRdwG3E6UQGFEec/Nv+cV5XChP+zHwZO6QeP6LoUQniUwo90JFArnw2xRwqUbPEpUuQkPsc2ug+xDQwbOnr8+8Qe4Ye4KThJ+q39D1phFSd3rBI5SZOYnqexYdCNyP/5DmO4NrP5u2s0LLvMDHBGIhjgyjyskQwsUv/Mu2nd13PyAU8QH20dGZQaVaZy1iaYnJSOrlN1rMwN2IQn2eF/Q+yEcVnhwSulM9MWzqZjzKyFKRbaSMyYP9C5XkxvIB+DI4MiAsnacKJn2rrzd6jQAq1rhl2+zXEgrVELa6UQjqSTydCE4z6q/MkGNX/4mbs6pwTGsdK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfjEuAGb++dTaje/RFedI8QnT7GR4HrZG0pOy4dpZQk=;
 b=S1Vq/3hXQxXdgHG2oggcg47qiD+X2afwdtzese8RsRUMbysuigtHnbNKvEfFJ2S/Zi5yfqd8MMGs9n7nNGOxvzuRPQnWB7Rd9hbgxHyWRRJ3KOgCebOS+SJoJnMOjNjhw0qSUtIIIYqfLS2YZjW9AGYgNSrmvn/Oxt7M+f//5pUQUr0+wAgnK/H1cZAzGM6BXhUdT/7BndY9kX1eOERg8ee13TSwXG7Dlxp5TqNK+Uwme3OyrEYRejmnLZFVqrPg5Pi1fpIrWuiXd2+eLy6lwUk4BN+VOgCFLbRjwfzxhD4Ogq0Pr2PkRn9XHIWEmm78pNGUEP7iBu17pub7XEyyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfjEuAGb++dTaje/RFedI8QnT7GR4HrZG0pOy4dpZQk=;
 b=HtRE66jOrxYyAV/d0tc56Vp8L1W7QSpJcZk90nQJviDTfDB2uml9Il9lqALpiR740NTSHdhj6/gxaIFcmYS7GxqPW0MNvW6jvEP2qgxrhq+lG86DW91iojHAuJYklm+IYHLq4ulfWtzHLZgyKIJBbpVqoG/XHFqoqoVBORAwGSQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5460.namprd10.prod.outlook.com (2603:10b6:5:35e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 20:45:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.022; Tue, 28 Jun 2022
 20:45:02 +0000
Date:   Tue, 28 Jun 2022 13:44:59 -0700
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
Message-ID: <YrtoSyxPLGTauptZ@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-8-jthoughton@google.com>
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71cdc3c-d559-44a1-b79c-08da594712e3
X-MS-TrafficTypeDiagnostic: CO6PR10MB5460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JKmjuaZtmPR/VN49GgzXIl/PkhKVUHWIYYIH7DI41ydzkptTscO6qERD+ABxwg25dvttEYReVZMhnxrZufP1CI3fHIziUGha/4c9MZS7+NdoFnmkPGFV/aNTKCljaXl22crc1etaaRVWDeRYEF80p1pwvpskbpq9qONqCtfSDqA3yx3SMdhBaIylAOwQBHCBmVAIuNmkwIQ+N/eUStabTtF6JSc2U9i3unGaz18qCYPqTUY8dJ2/849BDL+8/Mbe2Pb2BNWMt4M109zRoQBnXqAqnl44URGCoqhhbN8ElSfaDB/B1IsXCUOCm8foK509rId8zDrYXJ5OxbNY++IFScZ25p7ilLRO5D9ZOJCpsIvgAwmiSd15hrqtv5AEhLYEhNbzGe4KBdGFuSOVzTWqy8wUWKD9SfH11UPipkLlJE3Sh9/sQwK7d4bO/DMb2U6PTHWB6sfSrTmW0aecV6qFWjz/Ov60ZFcuilJFGsUSPwUsMSyAe6ZlvSLoUhcn7Wj2wq0dsHr6F17egikG4p87cdDpZ0+CsZ1+JQW5Dy78fcsKSHJ/sVS2RLYYr3/t2J6qTYM3bvgIVIAQQPxt4Fkta+em8yXkzlUu3htK6cNeM0BpYtMtoPCfey9JEHm9QcbWxslExajI5Fs4WGOd6GHKwvZjyYeB+s43fwoEG/QV+bw1/wqla45cGhobDMF4cBUPGfsSWpco/X/Z/gOYX+dXZJgMTWIjf4AAGbZq/cD42Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(4326008)(54906003)(6916009)(316002)(8936002)(66556008)(41300700001)(8676002)(66946007)(66476007)(53546011)(6666004)(478600001)(186003)(26005)(5660300002)(38100700002)(33716001)(6486002)(83380400001)(6506007)(7416002)(2906002)(86362001)(6512007)(9686003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shDsfIPvo7Hk9WPdCcY2P0sLOw6nF4cTZAfnO1jSwwAxXvdRl8gEjpGI/Sew?=
 =?us-ascii?Q?HeE8nEdkFj008IRH+epnXJoziNUnt/6hSC6UzFqHPz2LG9nsXRj42wnGKqgZ?=
 =?us-ascii?Q?kNS90RG7BzR9pbIu3qpe14Exo00wtkiykl1YUOe+BIRXEWH763Ig/6u3eYlm?=
 =?us-ascii?Q?w1tDNDc3J7mluvaqjm5yDrIp6kNxPmY+SAlKoj/AVgJEuamp6umVAup0mAuH?=
 =?us-ascii?Q?sMZv9JQXpmEMQHTxbv5sCkCbn4KHeIALfd74afmW/4HUk8qMwr4m1ifrnBTO?=
 =?us-ascii?Q?0hDulTVXtm1pmRfak3UCmlDXteVqE203XMPQQo83IRxIRDHyQwl2kgq0f5P1?=
 =?us-ascii?Q?bY3j1gulN9zsKFdyrCJvcJRcSxscS+BoK6+guKSXMg7E6kA9kKoG0cX4TFbc?=
 =?us-ascii?Q?i3JSn/kwWx2HESx7D8OlQ1CkaS+kidki/hrDm+RZxXYu1mOsMbApRDdnTN4n?=
 =?us-ascii?Q?NFewQ3Dr5JrBb45ncH2o6GmMzGRr4MhjZsnvFbz9RpAzsQUNj7XZy7UQ0NqP?=
 =?us-ascii?Q?SIkvqpgu2sx2mVTfzuAZT+fVz+3/29IZY8D/jAe03yumapUCHkSwiOMDDwYg?=
 =?us-ascii?Q?fokdwXek1Y0DHG7m1JFzhgMcZpN7C+f2U78TGbfAN7oK8lrpV7i7WafAk8jE?=
 =?us-ascii?Q?2ClMcanOdiKxnY7KzMJ4B1uc/Zb3+bmWLbkzxsUe66sNjgKltsABbg7+itzN?=
 =?us-ascii?Q?HQGg/a2f4e1LRdSjtOf8porknflLIUZTgi4nrGA/nRMQtqwhGODW+HP8ZLM8?=
 =?us-ascii?Q?SaB/dEEi3DiDALzX9arvR5ulrpuaXgG3aM2NsW6SBae4uV7WGcO5+FHuhHGi?=
 =?us-ascii?Q?X7Yox5khZa2w5nlS942IBbrUkw7Wbk1MXhu4Y8Z8zHCc5Trvdq68LteCZhRa?=
 =?us-ascii?Q?07UBk0gf+kEgxHEVYGvatq4oz2tIw5veiktoByM8oJCtItCI4Cd4he9kxOTp?=
 =?us-ascii?Q?XZ1Q93xusYud/nu4/cELgxTkJJLYGKcHBGE+ZFQPLAPZGLukGRVcIGbeEJ32?=
 =?us-ascii?Q?EBX2tRfIOsr3TINu4nYiGHvBk3IYPjMSBx1Hq9BI0BOSOGmQans/dNghoeVD?=
 =?us-ascii?Q?0s/L81ZkjElPYu8CmYBMvcMVnqNUbLhZITnXh7NHcIg53B33GMMoHcheZI+7?=
 =?us-ascii?Q?E6xU9Wfqlo26fzS6KdahoFksdTJ9OxzX1Ze07GEuMoZ96Gg3Yj7h2jQGONHA?=
 =?us-ascii?Q?QTBmfPaLBhxS2FXfIwln1vaq/8lLzlnVAu5hRGKahqAUBey/zDmr8lKs3mX8?=
 =?us-ascii?Q?jXxV1a3YhujzDsN18zDhAUTDyhvgyaW6cF85r9+oYA2qg6VBt05Os90B4kTz?=
 =?us-ascii?Q?VGUHdx3jG0BZd3BWbgid27xOzPSeux2QeoyyUcuD6h5icWqMjlp1SyLzlZ6m?=
 =?us-ascii?Q?4CCgPlKpZ8x7TO8xf6wdsKAvORJM2arUv3aQZNQwrJi8Ro3gsZSUWbyQhqVN?=
 =?us-ascii?Q?q0EgRt9LE40JKFBKMdzlh/lrfNMUL2IiQs/WnKPNWaDxv1r20ntOjlN91M9E?=
 =?us-ascii?Q?TPOvLM1/S78FDpYttEFLqtw5BlabbtNmuCiv6xGOnzXcioY5MnIEh/MeaOtM?=
 =?us-ascii?Q?KIKgzcrd564OcmUQIwCqwD2PX+K2Kcq35bMkOEr0FxIqloz53xNkloC9i2Pk?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71cdc3c-d559-44a1-b79c-08da594712e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:45:02.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDRB1MfOD+yi5uYp6E17eAqfzO4t78/35neHeqkBldrrsX4ASiMeogBLnv8nzYZYJ+sZdqPp6mAyh6u+sMpJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5460
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206280082
X-Proofpoint-ORIG-GUID: LqNlRxenPDItY5v7bN8jPl7K_U_Ur0l_
X-Proofpoint-GUID: LqNlRxenPDItY5v7bN8jPl7K_U_Ur0l_
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
> 
> Without this, we'd have to pass around the "size" of the PTE everywhere.
> We effectively did this before; it could be fetched from the hstate,
> which we pass around pretty much everywhere.
> 
> This commit includes definitions for some basic helper functions that
> are used later. These helper functions wrap existing PTE
> inspection/modification functions, where the correct version is picked
> depending on if the HugeTLB PTE is actually "huge" or not. (Previously,
> all HugeTLB PTEs were "huge").
> 
> For example, hugetlb_ptep_get wraps huge_ptep_get and ptep_get, where
> ptep_get is used when the HugeTLB PTE is PAGE_SIZE, and huge_ptep_get is
> used in all other cases.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 84 +++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c            | 57 ++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)

There is nothing 'wrong' with this patch, but it does make me wonder.
After introducing hugetlb_pte, is all code dealing with hugetlb mappings
going to be using hugetlb_ptes?  It would be quite confusing if there is
a mix of hugetlb_ptes and non-hugetlb_ptes.  This will be revealed later
in the series, but a comment about suture direction would be helpful
here.
-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5fe1db46d8c9..1d4ec9dfdebf 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -46,6 +46,68 @@ enum {
>  	__NR_USED_SUBPAGE,
>  };
>  
> +struct hugetlb_pte {
> +	pte_t *ptep;
> +	unsigned int shift;
> +};
> +
> +static inline
> +void hugetlb_pte_init(struct hugetlb_pte *hpte)
> +{
> +	hpte->ptep = NULL;
> +}
> +
> +static inline
> +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> +			  unsigned int shift)
> +{
> +	BUG_ON(!ptep);
> +	hpte->ptep = ptep;
> +	hpte->shift = shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +	BUG_ON(!hpte->ptep);
> +	return 1UL << hpte->shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +	BUG_ON(!hpte->ptep);
> +	return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +static inline
> +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> +{
> +	BUG_ON(!hpte->ptep);
> +	return hpte->shift;
> +}
> +
> +static inline
> +bool hugetlb_pte_huge(const struct hugetlb_pte *hpte)
> +{
> +	return !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) ||
> +		hugetlb_pte_shift(hpte) > PAGE_SHIFT;
> +}
> +
> +static inline
> +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> +{
> +	dest->ptep = src->ptep;
> +	dest->shift = src->shift;
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte);
> +bool hugetlb_pte_none(const struct hugetlb_pte *hpte);
> +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
> +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
> +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> +		       unsigned long address);
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> @@ -1130,6 +1192,28 @@ static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
>  	return ptl;
>  }
>  
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +
> +	BUG_ON(!hpte->ptep);
> +	// Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
> +	// the regular page table lock.
> +	if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
> +		return huge_pte_lockptr(hugetlb_pte_shift(hpte),
> +				mm, hpte->ptep);
> +	return &mm->page_table_lock;
> +}
> +
> +static inline
> +spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> +
> +	spin_lock(ptl);
> +	return ptl;
> +}
> +
>  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
>  extern void __init hugetlb_cma_reserve(int order);
>  extern void __init hugetlb_cma_check(void);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d6d0d4c03def..1a1434e29740 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1120,6 +1120,63 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  	return false;
>  }
>  
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
> +{
> +	pgd_t pgd;
> +	p4d_t p4d;
> +	pud_t pud;
> +	pmd_t pmd;
> +
> +	BUG_ON(!hpte->ptep);
> +	if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
> +		pgd = *(pgd_t *)hpte->ptep;
> +		return pgd_present(pgd) && pgd_leaf(pgd);
> +	} else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
> +		p4d = *(p4d_t *)hpte->ptep;
> +		return p4d_present(p4d) && p4d_leaf(p4d);
> +	} else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
> +		pud = *(pud_t *)hpte->ptep;
> +		return pud_present(pud) && pud_leaf(pud);
> +	} else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
> +		pmd = *(pmd_t *)hpte->ptep;
> +		return pmd_present(pmd) && pmd_leaf(pmd);
> +	} else if (hugetlb_pte_size(hpte) >= PAGE_SIZE)
> +		return pte_present(*hpte->ptep);
> +	BUG();
> +}
> +
> +bool hugetlb_pte_none(const struct hugetlb_pte *hpte)
> +{
> +	if (hugetlb_pte_huge(hpte))
> +		return huge_pte_none(huge_ptep_get(hpte->ptep));
> +	return pte_none(ptep_get(hpte->ptep));
> +}
> +
> +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte)
> +{
> +	if (hugetlb_pte_huge(hpte))
> +		return huge_pte_none_mostly(huge_ptep_get(hpte->ptep));
> +	return pte_none_mostly(ptep_get(hpte->ptep));
> +}
> +
> +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte)
> +{
> +	if (hugetlb_pte_huge(hpte))
> +		return huge_ptep_get(hpte->ptep);
> +	return ptep_get(hpte->ptep);
> +}
> +
> +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> +		       unsigned long address)
> +{
> +	BUG_ON(!hpte->ptep);
> +	unsigned long sz = hugetlb_pte_size(hpte);
> +
> +	if (sz > PAGE_SIZE)
> +		return huge_pte_clear(mm, address, hpte->ptep, sz);
> +	return pte_clear(mm, address, hpte->ptep);
> +}
> +
>  static void enqueue_huge_page(struct hstate *h, struct page *page)
>  {
>  	int nid = page_to_nid(page);
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
