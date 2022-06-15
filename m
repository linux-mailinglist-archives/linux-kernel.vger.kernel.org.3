Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD454CFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349525AbiFOR2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbiFOR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:28:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79EF63F3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:27:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHDPi0000848;
        Wed, 15 Jun 2022 17:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=okBeIUKl9xyZOVxELcEf4YcM/rcsIvFOc6fuxb2yYv8=;
 b=OT5BPYBNcvFeJLUBalh75TaAh+SkqVnNti9cTfE6h5k0mBrddesHLxY5gXnaWS5eAnN1
 4UBuXahxCQI4egnNM8HESwMzznuz0gKFmVEcoaCoIIwB1qZcGxAp3wEnx5Upx5V6XjD+
 iHxVDnfxZn4pe9ENlLaxI5zkuGuUyE/7HhYLirxH5n1qEjKw/ND4KIO+ev01O5URG6a+
 wCU66eKdfqz9EnFrJnlEgcbzWjvZb/GrOyESQdF14DchzlUwvP5JvNqhVoPeHS35IpDZ
 FrCgb/ZMRiCCEVGxcYiNLYwFmJkJ3X1V+M1bjSExv+s0nTJ5zen2ITeJu+X8grjvpcF/ Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9h124-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:27:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FHGFLA016505;
        Wed, 15 Jun 2022 17:27:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2af4ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkkTzdPWHS7t7m8LgwI2QTFDvnhWDH2o47XNdc+HUlsklFCWrvjX+Vnt8scZTdoN0FSKnsekxLHBn/oIGlYgYoc+11F51wRQ9Re1UFswX3I1WMKqBbEzjFycS7RZSORlkPpRZ1N251ky5dAD64+RnlU/KHDGc7NQre+9U+GVXcA/bRWoCCD+t8qvL34h6p7A2YATwPcFsY8vUAlTNakoztne7WEG0ERWY7JPmM6IXdvV86RajShnV4eKqurNOE25nmarZKcHj/z3fjY611LW2BMN4SN0lPRtvkebTYAU+cRcbVi8ZSvWM9ir5rWJlZFhrbb79aqaaZn+KH9/byLIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okBeIUKl9xyZOVxELcEf4YcM/rcsIvFOc6fuxb2yYv8=;
 b=H5659JJHTYbThycoDksQdTwqCj5dywswZBCNS7Z8mivPDYNoLuAkgcI7MXx1zsMWapUVcHoCYLt7QnWSdeXiKPi8WJxHvue+tXTtmRbdI+AeNyJ3U/bKycJpjhtWLXmOY1TcYog/rNTKk4mlPZEk/AS4jYdeIoJWxfAkppwa3nsCTaEb6XUyk3AtVZsr07AEO+JSC1TSTJPx68aSdBR3Wh7Ebf/ZDdrkH6GOuiIk/ZtmPZoijMqgY+k6MNej3rTHd6FEmbNeozrDrrAgewLrGOr0fAdir0nZEbA0VviZYif6RoHnHerc52lSLyYpTWiaZNiT/ryYYwUnrT0iBVMPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okBeIUKl9xyZOVxELcEf4YcM/rcsIvFOc6fuxb2yYv8=;
 b=w736S0wq9R1vBLH4UHff8r+vMNsa2tuJA3wYY77uHv8qoexX8MG8DB++XxMdkvq2Hv4sry+WyDDlLVIXbASyPV+yec+iL2piRr5Eoa/H8El3X33oOPnBOBCtbwulcUHK5UPDBcTQFyr9Y3cbdDt5Ev/2/QwNDzwSrqoFCCMbv9E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3136.namprd10.prod.outlook.com (2603:10b6:208:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 17:27:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 17:27:29 +0000
Date:   Wed, 15 Jun 2022 10:27:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Message-ID: <YqoWfcZXJ7NfJaYJ@monkey>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <YpUhe6BSfflOVz7b@xz-m1.local>
 <e9456223-c26a-4d49-2920-9a597a817190@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9456223-c26a-4d49-2920-9a597a817190@oracle.com>
X-ClientProxiedBy: MWHPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:300:117::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c79dd4-8f70-47fd-78e2-08da4ef452b4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3136:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB31364A12E1661F3D0339AFBEE2AD9@MN2PR10MB3136.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +R1Ozxqsga8gSbt78SQrtm5Y6mmX7MiqZ6EIPBTNzerxDqcbQEewRHq3A1we83SAD/BjJwelHkb8YhvYYLvvxggQk+5kjVcam+5+oGxUh0ZeB1b9gMGaasUuPpCqqjvVAhjTO9TRHoHXmBsoiZH7pHx464kYTdGwvtCD2RI2oa8vCrEM1roWIEY3TFnH3yt8d+iUHlVDl+DhmfSl/TvflHrU8+XKG5FvPxDIrI3RN2684X/ZWrVeek7v9ufCICPrK003DqJCyWQuITPZ8xFGJd97NdpfXfZhLmOnSPBMAQMyHBdYPqJsEBEJRk/AowdKlUSUKsifzAbm9FGcPvmfK+drvP0lRDSNBGhTwwY9rbBQDnby93CnN1nUESnp616E3C3KCfmrFXsWmnAie9wB8zzOUp3MThhWkzT0CUAeHLa+U76inVmTxrkmcd+TOcuHMky+1HDJU6SaoBks/ZDFfmw0Myrt0epggowvFCLEiD3UNVgw7Sg1JThtjKAtW+PJqUkx/4THKWUXhL7hLaGTiHsCv3u7sK/na0cGL+c/L3CEfOcnBnETk/vo04fID695r4LoGCSPH6ePRZU8MLnixEOS2tC4Lf91NVVmaFm6VZU1n+tTR13NALYeT+wKKTTPUyxKt03e8oFm9F5Df6YwQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(26005)(53546011)(66556008)(66476007)(4326008)(6506007)(66946007)(2906002)(6512007)(9686003)(6666004)(86362001)(316002)(6916009)(38100700002)(8676002)(54906003)(8936002)(6486002)(44832011)(186003)(33716001)(7416002)(5660300002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1UsL6DzOB1zlKZZSUoTk87MTIl5WxC1QoL74KhO5hz0Gf++Tf8pTYV/NMoaS?=
 =?us-ascii?Q?Wya7kahxzuFxcBs6nm0kMk8rILjkUbzbMyCeYEtQuarLIkY/TokUzFp8cFj5?=
 =?us-ascii?Q?twijoS6315CwmYA8Tp2faN9aiV/M5d1yA0NynvDdM/DiPmlYoqfEZbzRGWjS?=
 =?us-ascii?Q?Lu9WrjmNgvANDSiWbX2kSKt/cTvERXRsuB4ymkgm0Zrxz90t3XwJPa60Dqt9?=
 =?us-ascii?Q?+7h1O0zyWm40q5qRc1/EbS9At3vdC8CO6SMuQC83yi2YiD5lJlz3zwZWWMXB?=
 =?us-ascii?Q?p3YlnHR35dy5JNaw138S4n78p/oUB1C+S05Sa9oKlG5CQb5UtwCfUfKMUYYf?=
 =?us-ascii?Q?yponUW0JoJCtJyq5SByrYglsp1SRuC5Wn7IIKxl109cJwtZ9jTMmA/L0UDn7?=
 =?us-ascii?Q?pwe2GZ7UnKD4Uw0UoqYPLqwcYDlWOM58bKtgbxGrLNakKLC7qP+wxIjhPayb?=
 =?us-ascii?Q?goSAuSGwG68y8EMPcFrCXVJDoinxkfXGobavQ2CK27tLyRoMPH2GId2Ofy83?=
 =?us-ascii?Q?EI33cOVXEbRwi4IkuT+ONq+O0+y0Hkb4dP1F/H55BX64FmtOHzroPwaYrXSk?=
 =?us-ascii?Q?I7UUwA55MAZo7A5xfqIrRDHeGA0DPwlLwZaOYEDnr3HDy312M2Yhmxmq/Qpi?=
 =?us-ascii?Q?72LCTthn2RKvLBrpQLylASW6G52iiTKOkGIT30LZxRBnt6RlO6xQR9xLF3JL?=
 =?us-ascii?Q?CEAncfYydoLrjeyKKcpP3f5ogaB81Eij5gfCjQMGtQNQiGMr3ltyj/YY5/6o?=
 =?us-ascii?Q?qlgQE3M6OUqNwi+uSaUZW0Zb+EFpNqe7q1aqlZfkXuSRKeOK5nZZgqSu6eGB?=
 =?us-ascii?Q?7iQyWX4l7Ae5BNa//AKapE0s5hdm5tcDnCLCZ+4TEA/en5S3LMSQHK3M0WwV?=
 =?us-ascii?Q?Wu9OrSOVV9oek94CaBCueyeNCmoPOw90fENEYKgJ1QtHubm/wl1yMW4itYj4?=
 =?us-ascii?Q?QaSjCJdZjc1RhYteZd9nIOz57k3DwffmTmhqqV+YSzoIysQF/auLUbiqaASk?=
 =?us-ascii?Q?UCU7Zpk9nGbecJ5zNbjlps44Rqb3R2WQD5S5F6ij6Q55ULtOv6mEa28gel9R?=
 =?us-ascii?Q?4xtbFDDnEtJBxJsa3BDzqZNSpNGgCXyYERjFLiusNA/NcI2hn4krwHQFPMoE?=
 =?us-ascii?Q?VvsU3jgXLCWkeVtg+zo6GojLmT0HUFaCxRU3m8AfxCAw3WqargCJcYol+k5J?=
 =?us-ascii?Q?4+detQ/MrS+xmr2JzdvzjuAucnGCSBgnJlWm8Qjm4Kwa13Fxr6KXF3Z/tVhi?=
 =?us-ascii?Q?v3KhuypLNNqcXiu+ylOEleUcHqVgaNbcihyGxrZ+mTDN5EQLK9lLyGZyPeq6?=
 =?us-ascii?Q?bq77UilaIjvZvPArLlY85b8rhxtjZ3S3y28tFO8umhpGcj2BLx0Cz9Hjr5pP?=
 =?us-ascii?Q?rX4M8L7RMXHbcKJ/ApljKk/0EU3HyN3ARtkJRui3356Fwz4I+yDANW6+6JOL?=
 =?us-ascii?Q?BU0DB3ApY0mTomOnycIth0tiJo9XWZUgzVDKlfztWVwTaCuJMBOeMRomof0+?=
 =?us-ascii?Q?ZjspG6rK2ROSq3QOFs9LeM1ZZPGc46IQwrKqoNHPGi3J+e43iPq3cYCPyKES?=
 =?us-ascii?Q?1RodpWShPgwNeBHSD0GXPB3nrsTO1idA+jADG0Ed3D6pmg3Yr+2ge9mpodxG?=
 =?us-ascii?Q?c3fkAl1UmwZbFjVJgvPiFYmPGqRH6mJeEDT8/3D8oo0JPRWNofDKsRzPO5xt?=
 =?us-ascii?Q?9TXFw8R1EyoOSNX4fOUpaBBdAQlCVDTAmO8s9cVNdbi81V6xuIdDKk7r5JvY?=
 =?us-ascii?Q?NebjJ65rOvxy18lurwQa3IwIt0JZP6U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c79dd4-8f70-47fd-78e2-08da4ef452b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 17:27:29.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bo+djK/44jHDEDTRELL3XR5bVvKyPdNbRpflUgBsjxTepm16EBfv1B0hXThdASLdbHaPYCAum0RBwak2IdXMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=687 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150064
X-Proofpoint-ORIG-GUID: oO3p406MJsDf6rQsaIRKxLMSBrkt3Qj6
X-Proofpoint-GUID: oO3p406MJsDf6rQsaIRKxLMSBrkt3Qj6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/22 10:00, Mike Kravetz wrote:
> On 5/30/22 12:56, Peter Xu wrote:
> > Hi, Mike,
> > 
> > On Fri, May 27, 2022 at 03:58:47PM -0700, Mike Kravetz wrote:
> >> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> >> +{
> >> +	unsigned long hp_size = huge_page_size(h);
> >> +
> >> +	if (hp_size == P4D_SIZE)
> >> +		return PGDIR_SIZE - P4D_SIZE;
> >> +	else if (hp_size == PUD_SIZE)
> >> +		return P4D_SIZE - PUD_SIZE;
> >> +	else if (hp_size == PMD_SIZE)
> >> +		return PUD_SIZE - PMD_SIZE;
> >> +
> >> +	return ~(0);
> >> +}
> > 
> > How about:
> > 
> > unsigned long hugetlb_mask_last_hp(struct hstate *h)
> > {
> > 	unsigned long hp_size = huge_page_size(h);
> > 
> > 	return hp_size * (PTRS_PER_PTE - 1);
> > }
> > 
> > ?

As mentioned in a followup e-mail, I am a little worried about this
calculation not being accurate for all configurations.  Today,
PTRS_PER_PTE == PTRS_PER_PMD == PTRS_PER_PUD == PTRS_PER_P4D in all
architectures that CONFIG_ARCH_WANT_GENERAL_HUGETLB.  However, if we
code things as above and that changes the bug might be hard to find.

In the next version, I will leave this as above but move to a switch
statement for better readability.

> > 
> > This is definitely a good idea, though I'm wondering the possibility to go
> > one step further to make hugetlb pgtable walk just like the normal pages.
> > 
> > Say, would it be non-trivial to bring some of huge_pte_offset() into the
> > walker functions, so that we can jump over even larger than PTRS_PER_PTE
> > entries (e.g. when p4d==NULL for 2m huge pages)?  It's very possible I
> > overlooked something, though.

I briefly looked at this.  To make it work, the walker zapping functions
such as zap_*_range would need to have a 'is_vm_hugetlb_page(vma)', and
if true use hugetlb specific page table routines instead of the generic
routines.

In many cases, the hugetlb specific page table routines are the same as
the generic routines.  But, there are a few exceptions.  IMO, it would
be better to first try to cleanup and unify those routines.  That would
make changes to the walker routines less invasive and easier to
maintain.  I believe is other code that would benefit from such a
cleanup.  Unless there are strong objections, I suggest we move forward
with the optimization here and move the cleanup and possible walker
changes to a later series.
-- 
Mike Kravetz
