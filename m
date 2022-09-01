Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06CD5A9CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiIAQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiIAQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:20:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AD2F391;
        Thu,  1 Sep 2022 09:20:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281FIgRo016658;
        Thu, 1 Sep 2022 16:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=NKZWcmWBaRMwxCQaCbiIgFvk7jj66DcMuJGPMRWC634=;
 b=uH85fwpb7L/2fZb58HBpS3z7VVHsBso9IU3WLQW0onpnSmjMEHksjWWDZ45DByzH8Qzu
 sE5iUV2sxaAOlp/QcGp7sDauKize4P7BXXXTLpWfVLhqrN/lu9AKjhAhIw8WIY+tA50m
 bOW5ilK7Ijj2YYyVx2z6YWHW0iLLMnXK76aFr2PBwmD5U9udBFVXNFIUcPaAeh0CC2iK
 4g6RMTuSL30+97Sx3pI9qtXxvm3TihbGmcIxoBv8FfyFK6LgiGwiqZCutjN3eRqEa1Wk
 GmBNj14fpAh6AlG9mDQnfHNehnPnwg9z+27KrL3HTchXa16IMWHbfo8fX5SX3mGXcLS9 iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22ctku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:19:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281GCQxT002102;
        Thu, 1 Sep 2022 16:19:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarqk00by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/Bi83GwI5nk5pGGl8/23LrJQrLO+54dfTr01EVlvvcFUK1hHNcWuCt0mWPx064wTvIlbW8th6HDAz28hF47bmy2stfVmZjxSanHLUZgnhpyNzV1FPV4jVkApPPB/bZFk5tLrnCZddSsVr2H6Nqv2A+KqQ+SIdrAzKMXnmOe/DCtu9Af6kdKU1/z/39/Gk7rrMsg3nf2+7iIv8Bq2Eum0A14iKisGgHVzxXOEBpCgQE0xtqNXgPst0hWzU5B+7fmhVa7orgGLURFqkLOflW70Rz+dV7OFHXC45FVg/OvoDVrnQD4ihYfcdQDhrqY95/aKuZAjkWz4Cnkw6m5UTLE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKZWcmWBaRMwxCQaCbiIgFvk7jj66DcMuJGPMRWC634=;
 b=Vue3Jk3dx4kJvQWBmlrebNlkLTGlUOG1VwfStWs/S27za9ekxTINPjO0oN1Po31zrGzeMd342cphx087TVXFdB3E3RTWEmqh1z8smmPXtzAADs2KN8eLKkf21KyXNHIVFEqLgBfR5phVwsilBwCpI4rHPSTkVXX+0IMcGnbp9nMin0ezqJqOmyUCZyW/OjuoSIk2BPHBKyM+9uQ6c8Ctm53JM0leL0BDD1aGU0KFYcU3tecHmA2iRI+REBSnPRCThw1UYlXq3eOyxqkvTmQvwTYEn9+9ex2mNnJEdQIZCEfeK2O57kZW+/0D2DCg3e3jTEnHjRvJEM4twcZ3FI3URw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKZWcmWBaRMwxCQaCbiIgFvk7jj66DcMuJGPMRWC634=;
 b=omXQW8MwRCoRrk2bSRmYYL5NMQCPkzKkl/Y6Hf7rgVwCz81s7YSxS7q4H3r9cHA7vAfAcm6GuOqzrrWDoGDVrImppvGSybKMOJq1+J6MRJVPEm3ygHQL1BHcWa7GCiqjlaVwX060MAjAkPUCPoWwpezgQ2ES0n2Fb37E4GN7dqU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 16:19:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 16:19:33 +0000
Date:   Thu, 1 Sep 2022 09:19:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <YxDbkvCy9+Opm0ns@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829234053.159158-1-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:303:dc::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc80bdb-816c-4972-5ce1-08da8c35c107
X-MS-TrafficTypeDiagnostic: CH2PR10MB4118:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ub1oxeWRAFU4U9flUkkVSw4RNLg8QxfZuCkcgW/yF/fiRFIf9ZxWKfR7xIEG4msJGfEBQN7ZSnIlYLpAY1QSnCXcCaTYGiJK+k41PWAML+/SYOgB9WkxhCvF4coWfOg07EZenmSEfnWv2smc+jPCkOv6EYdTwOOura504vA/mQtOo5+10L13vip4uo6n33qF4Pk37JbC/Wc/l7MmrkdXUKhNw5I6/EQTlBUObVakm58wx/eA9xR5SwfzAfWyNM/gLbARGmTKPsKn5F83vDUOwTc5X/77JnpZyPkXaGOiKok+LyyKX1XNaLYzTCC/pG2vfpa4Y0vgO8y4ETsl72hk3IXXlwbO7cC5ojGTT0cvVKeheFKAIi+4/sCV4NE/TJDcKxQUMJI2C7A3JQ1NnhF2vm1/AfXi23vgsD5Bjd/Q3MYU+xS4rj7hkp042zNwhCFlWeDghykLg+C88JbmvoW+wbq91WEMvDt8gyzA0a288l5MbhP5ps9vABV93q944rJ1J5ZFrJo/+ptujNcetaHT8J2RARJgwjA2PYwBG4JqSWfXGpjU9cLE4hcG612w3jvkJZtSM4tbwvejHlNJeEX56870A/sEnn2ZlNkKT7BIfFImm8gfi1swzgcZq6arbiS3bTY2WkiGBDZyO5hyed51TigyDC9cDsGEymzdpe7ZGpe1mt4N1epGMb6M/9jNOV0ofirbhVTx2SPRb1kmAPttN1oCYYw1+22bu7fvbso/88qDSUm40YvEDOkDPH8tSpBYsdm68ioPdXr077GK5Yi3fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(8936002)(44832011)(7416002)(66946007)(9686003)(6512007)(4326008)(26005)(41300700001)(66476007)(8676002)(6486002)(966005)(5660300002)(86362001)(53546011)(6506007)(478600001)(2906002)(66556008)(186003)(33716001)(316002)(54906003)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RUgnRhX3qDgquGBtp3wJeaw8ZZ6645BfJU2nhgkoucaIUiexFP8tkqsXzkE?=
 =?us-ascii?Q?c1xrkOjXFS0RYvwFIGVcU5wNr7TRMRT7AipcQ0f/ZJPlIGYcWFl60gaiMmgJ?=
 =?us-ascii?Q?odZ1Kkd0BWVEZG9its8Aoq1pWXtPHBmsvaPxr/iH7g2vjeq3e8+s0cJRPxqf?=
 =?us-ascii?Q?gRNdGVOXqgb5wR9Ro9Rk+a8qmt9RHxQ9RMK6bEZJNO2kbg2eLiMhNuTHFic8?=
 =?us-ascii?Q?+ta3y/IpF8hgBnAyPgHOtsr6Kaqw23SxwIXZrs/mcz2tcHAm4lDYXRduJs47?=
 =?us-ascii?Q?nsC0ZsfXUzDlF1fe9wv47hItxS1EwvVRdUWEryQN7c6VL0ckx0L1p9VLqYxx?=
 =?us-ascii?Q?JBy+0i2p2RSJ0Bt+I0L7ygViEHXmp07yj6vjySljWL6a0YOo2ld2HOFBJ1zW?=
 =?us-ascii?Q?4Vzsogw5op3n54Pjd/1yWdJEUmsgNK2481r6dCBKWp6PvdbsrTQ051NW/bV5?=
 =?us-ascii?Q?K8UWHjEOsl+BaA304mn9sNmMBWrgDwVfvXA0aCeq1KMPubVxJ9pqnM7yk4LE?=
 =?us-ascii?Q?rRmUdsM/Sna7Tuir3EplIy98j48mzF/IGDI4HXt1YAiaMvqkOPaH5X2f9Z78?=
 =?us-ascii?Q?WglLPD3XyVbaI2uc521QPN6GjX0YeM2a8+GZLPSQuGiWm31nJlCjw1UgTiwj?=
 =?us-ascii?Q?CRwsGWp3avxjnK7tScJM/bcjiH2ErhJbnN/FbAKRO0vipIvaVwhkICzQeRWQ?=
 =?us-ascii?Q?EW5rc3ncGahMu0oIg7B4w9qjOi5iQ/7LbIaO9Sy24JYYOBTaIAV434WgqszG?=
 =?us-ascii?Q?ug6SvS8hjKPwO/ModNw14Qs+F0DJEwqwZAFh47u8yILaTcBevpCocV55MU16?=
 =?us-ascii?Q?hB//PAGOPt0uECy78Duh+iRK8R0UPporvkYT/vI5E2+K2GGJvYvWCnQ91FuY?=
 =?us-ascii?Q?YCw4i1Rp1S809/qp6dSbZ/vouENsYEA19Zagtr1TJyv+N1r6H6Plq8iHyvgI?=
 =?us-ascii?Q?dbvHA3amXxB6aWViu5u3zgYB027P2MRoqcx/QAXYFpXHP2aXaa6M14esQ8f1?=
 =?us-ascii?Q?Og0U+sr6KfiX4Bdm3Cq6H/57DPu43XE8v7aSbFJTEhnotD9trU/5pLz+7LHr?=
 =?us-ascii?Q?pVA0vPyFM8dxCFtkFZG7yBycFPomNQwHsZkpuKjK5i339hamIWkKu5sIIHHY?=
 =?us-ascii?Q?jRQlLwURWBuNce/UYu5iAUwjKbR2q20kdkVF9srhSdO/NoEr0Uv8Hm7EYhQc?=
 =?us-ascii?Q?gIKVEbN2RkYqtf/pdr/IxMT4cs+efPFABAd2OGfXqHV9XDOE+NyzmxhsTmpX?=
 =?us-ascii?Q?3tXfrORCLlAgyLXVzsDdpN6ZAz/lFMENgF44mpy2PTjvn9G14Kl69ZyCjQnl?=
 =?us-ascii?Q?qnurxE08cS/mGUi8ALPtAZXo5s5J6xeWZJaXuYmhsKAg2c+QWa5B5PVR+l6i?=
 =?us-ascii?Q?JSwtFv69kD2MQlTGhAu5OYkEXYZ6gqoXDtSm1StjDZRlnVAY9ohB+M73zdbd?=
 =?us-ascii?Q?OUHceRph7D8mu2Euu/GfKhy6+bTC4tGH8iW7qrMd4GoH0DWJtHpkUeD0mluQ?=
 =?us-ascii?Q?IA5pd5r6vDjeFBBp3Y0xZL64b1wGcoTDaMzg3fpwLKv6qwdCiGsEviX8AjDS?=
 =?us-ascii?Q?mzQLgxFqrM6KX68v2mNseyeVuEAOJL0R5gwUdDNWcicWVdKd3rWcLLRsxFxp?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc80bdb-816c-4972-5ce1-08da8c35c107
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:19:33.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrDycSrsHh5MbMpi9z627NqLGmMqG3klIIqslI/iO+O47+H5CbGRB88vE7uXweoI1KkfoqipVyNPzv2OF8XQIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010072
X-Proofpoint-GUID: DXh78e3NEm2C8f-Al9tUHUx11mTPDWnp
X-Proofpoint-ORIG-GUID: DXh78e3NEm2C8f-Al9tUHUx11mTPDWnp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/22 16:40, Mike Kravetz wrote:
> A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> existing routine huge_pte_offset to walk page tables looking for hugetlb
> entries.  huge_pte_offset can be overwritten by architectures, and already
> handles special cases such as hugepd entries.
> 
<snip>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..b3da421ba5be 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6190,6 +6190,62 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
>  	return false;
>  }
>  
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long haddr = address & huge_page_mask(h);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte, entry;
> +
> +	/*
> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> +	 * follow_hugetlb_page().
> +	 */
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> +		return NULL;
> +
> +	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	if (!pte)
> +		return NULL;
> +
> +retry:
> +	ptl = huge_pte_lock(h, mm, pte);

I can't believe I forgot about huge pmd sharing as described here!!!
https://lore.kernel.org/linux-mm/20220824175757.20590-1-mike.kravetz@oracle.com/

The above series is in Andrew's tree, and we should add 'vma locking' calls
to this routine.

Do note that the existing page walking code can race with pmd unsharing.
I would NOT suggest trying to address this in stable releases.  To date,
I am unaware of any issues caused by races with pmd unsharing.  Trying
to take this into account in 'generic page walking code', could get ugly.
Since hugetlb_follow_page_mask will be a special callout for hugetlb page
table walking, we can easily add the required locking and address the
potential race issue.  This will be in v2.

Still hoping to get some feedback from Aneesh and Naoya about this approach.
-- 
Mike Kravetz

> +	entry = huge_ptep_get(pte);
> +	if (pte_present(entry)) {
> +		page = pte_page(entry) +
> +				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		/*
> +		 * Note that page may be a sub-page, and with vmemmap
> +		 * optimizations the page struct may be read only.
> +		 * try_grab_page() will increase the ref count on the
> +		 * head page, so this will be OK.
> +		 *
> +		 * try_grab_page() should always succeed here, because we hold
> +		 * the ptl lock and have verified pte_present().
> +		 */
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (is_hugetlb_entry_migration(entry)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait_huge(pte, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
> +}
> +
>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			 struct page **pages, struct vm_area_struct **vmas,
>  			 unsigned long *position, unsigned long *nr_pages,
> @@ -7140,123 +7196,6 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
>   */
> -struct page * __weak
> -follow_huge_addr(struct mm_struct *mm, unsigned long address,
> -			      int write)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -struct page * __weak
> -follow_huge_pd(struct vm_area_struct *vma,
> -	       unsigned long address, hugepd_t hpd, int flags, int pdshift)
> -{
> -	WARN(1, "hugepd follow called with no support for hugepage directory format\n");
> -	return NULL;
> -}
> -
> -struct page * __weak
> -follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> -		pmd_t *pmd, int flags)
> -{
> -	struct page *page = NULL;
> -	spinlock_t *ptl;
> -	pte_t pte;
> -
> -	/*
> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> -	 * follow_hugetlb_page().
> -	 */
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> -
> -retry:
> -	ptl = pmd_lockptr(mm, pmd);
> -	spin_lock(ptl);
> -	/*
> -	 * make sure that the address range covered by this pmd is not
> -	 * unmapped from other threads.
> -	 */
> -	if (!pmd_huge(*pmd))
> -		goto out;
> -	pte = huge_ptep_get((pte_t *)pmd);
> -	if (pte_present(pte)) {
> -		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
> -		/*
> -		 * try_grab_page() should always succeed here, because: a) we
> -		 * hold the pmd (ptl) lock, and b) we've just checked that the
> -		 * huge pmd (head) page is present in the page tables. The ptl
> -		 * prevents the head page and tail pages from being rearranged
> -		 * in any way. So this page must be available at this point,
> -		 * unless the page refcount overflowed:
> -		 */
> -		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> -			page = NULL;
> -			goto out;
> -		}
> -	} else {
> -		if (is_hugetlb_entry_migration(pte)) {
> -			spin_unlock(ptl);
> -			__migration_entry_wait_huge((pte_t *)pmd, ptl);
> -			goto retry;
> -		}
> -		/*
> -		 * hwpoisoned entry is treated as no_page_table in
> -		 * follow_page_mask().
> -		 */
> -	}
> -out:
> -	spin_unlock(ptl);
> -	return page;
> -}
> -
> -struct page * __weak
> -follow_huge_pud(struct mm_struct *mm, unsigned long address,
> -		pud_t *pud, int flags)
> -{
> -	struct page *page = NULL;
> -	spinlock_t *ptl;
> -	pte_t pte;
> -
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> -
> -retry:
> -	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
> -	if (!pud_huge(*pud))
> -		goto out;
> -	pte = huge_ptep_get((pte_t *)pud);
> -	if (pte_present(pte)) {
> -		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> -		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> -			page = NULL;
> -			goto out;
> -		}
> -	} else {
> -		if (is_hugetlb_entry_migration(pte)) {
> -			spin_unlock(ptl);
> -			__migration_entry_wait(mm, (pte_t *)pud, ptl);
> -			goto retry;
> -		}
> -		/*
> -		 * hwpoisoned entry is treated as no_page_table in
> -		 * follow_page_mask().
> -		 */
> -	}
> -out:
> -	spin_unlock(ptl);
> -	return page;
> -}
> -
> -struct page * __weak
> -follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
> -{
> -	if (flags & (FOLL_GET | FOLL_PIN))
> -		return NULL;
> -
> -	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> -}
> -
>  int isolate_hugetlb(struct page *page, struct list_head *list)
>  {
>  	int ret = 0;
> -- 
> 2.37.1
> 
