Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718FD5A9F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiIAShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiIASgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:36:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4E82770
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:35:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281HJJaP008998;
        Thu, 1 Sep 2022 18:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Cr9DvArYY5WVK55sFaojt+LTm8F+MtJ+jIu7lH031PU=;
 b=y9HI2jmk3rBrUSlexGZCGHQfvb6Cu554RsClgpMZklBHu9bfU/h3c+MBdfbcrTCWcga1
 o+v8M/1yIwfkIonfFS+4Hnjw3/fDNXZx463EmC996JS1r9JQmissHDDUPqpg9qnfNCDZ
 bAbnoLqY3IatUh6mjkyIb5mcdnJrqe321XC8MArfrrgd3b2DGJyXn8IzzqLsxqJe9xzK
 e62jqJ9yG1FxHYPxm7Ra87L2/Wb0RN+1XLeukjg8wKpAW7afR9ur5uj2cJUIej1r7mOh
 37B3x/btC4Dlq/fd8VfMkTr3WznLDwixJx7f7AU79bCNPwMEzh7agroHDjbo4W3MQR8D 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22d76h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 18:34:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281GATI6002188;
        Thu, 1 Sep 2022 18:34:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6uk65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 18:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO+rHtF0vi8SRyQReC0u0LJo/pTgGqHWqvER8RAQV9BhKpv9ibRjqYX4TTDjC5rL4SN/hbIoDJQuQTHh+7SoGdHrg7QknYK9tOE/adVxRrdJCgpCMJkZga94fu6o6bKpUjLFwtcq6VXl9zzgc6LH4qZMxazdnmyNarU/TDfiPYvTJbMWNqh5Mv9Ui/RschzK7qvN7N+3MAkvx0msNkg3JLrfg9Ir6GFWuhYUe4548BXK50ghZKqFQdyAWRdKcBDFaGAruCOXM/vqp6Dt7q9VmRg9Lv/+/Pfsq8jCLddLmCK9Qf8eOHlxb/j8nrAlsJ4F6aiTDUBiB+JqKQcgOtHnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr9DvArYY5WVK55sFaojt+LTm8F+MtJ+jIu7lH031PU=;
 b=gtTLvV0apo6YBCYqztxIT+/k1/vvs3N36GPHOvxs5qQtIY/pQL0WD4W9cJ45WvI81r13ghJ4lpRiVZvzDmEC3NEboKwZE2k7yBT2G16Sh0K3sFQ7cji+4mLWMnSsmgjUEmp+kUe7bP4SLts/ddZOsqrh2dTeM6yiRoHyhXy6q7cX26l9RLdy3U+ev6PMNdCfAgCtYtU67zbWSoDroTkOAJO0c8iSV23iAro5WVu2SQ8YPryhLQ/QDxdKriD76Agk15vTQyZnWYp/YyH7UYgB7iUJ95Z6FE1Q+v7IFT3luaOQiC/UIx70Cha0Jmqsl7C5VAm0fxSwY9dWTjTAlG9SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr9DvArYY5WVK55sFaojt+LTm8F+MtJ+jIu7lH031PU=;
 b=swvdVaQmzCTwMRwChge4KyCuPmhKx7lZHOSCdWGb/Dmd7hM6yGN3T5HM2x8KSWRoIgGgMQnBPwHzuH4ux9QBIpMW1TebuR5QEDmJyeoMNDrpJV0Nu681A3fp6ivEA0D12k/3eZh8QuHgOAEthPq/Gdaad/SYjgAyxOyAJHnU8RE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 18:34:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 18:34:52 +0000
Date:   Thu, 1 Sep 2022 11:34:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 6/7] mm/hugetlb add folio_hstate()
Message-ID: <YxD7SIcXX+JwPm+k@monkey>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829230014.384722-7-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7011ce91-66f5-4a81-b6bc-08da8c48a894
X-MS-TrafficTypeDiagnostic: SA2PR10MB4457:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqRZ7qMcdI88TN1xPl0b1ccLzwRWX6ufHpkrgSJZzg/FWBm/k2cRDhN/vGakIC3Kvva1nZKtPD3cTjocMZgCtS4N6tSM/bMZ/QEY7/4ZCo4Jva5uyapkpx2e6zs4GwR9ueOSgrNSKFNstZ8K+tcDeb7A0LuISjT+sVhcr0OXc6OCgQBSndVmABoeymFWbT75h+Zyun8ldN4n0EAZNlGRHA5yWBwzBYDJLQsxsVJweaFBrgJ9NWsK+FFUPdOPIEEAgcDXomUY3Yo8YW/wxuHE/FdREZX+5XWZ8XFYLtEuTkGK0S4OBF8/9bmPGg9sFzNVoJtNfS4ra0APzFORMzN5mBol27AZsTft+8N6QfEfvcwC1Qjoa8gWbrrGcezp7HOt8E1YFeM7u7DpAalw5JId1rUZlnd3kusH3YUvh9Y9+P5F4eVV1OvGJIW60ri3SMZPrJQZXd2VmJsk93wS5VbPPAzC7YxXaX7v/d0ATdkBupcf1vk5iLfoXHlWy9toV7vexH8v1A+8+SZb6X5MIWtcsbX8DZaP6ujDxJ7EBGaP0wfAlzQTEUCm8cwCxAAamqun8gRw5brB3ZKPFQhSt0FWG9zERH9mZRHozfUlxawXcWxNBq00419HfjqAZaNob/IceSDuqvNfbUAbyt1Ni39VGj2o7tVJx6JTRTlncvyohqjN4k5sXwlWN8b1znR86tOO/d34mDAa136VErQR+8qMDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(53546011)(6506007)(86362001)(6666004)(6636002)(316002)(478600001)(83380400001)(6486002)(41300700001)(38100700002)(26005)(6512007)(9686003)(186003)(44832011)(7416002)(8676002)(2906002)(4326008)(8936002)(66946007)(5660300002)(33716001)(6862004)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l9qHa2FsAX2viQwSXyX+H0O0QPD4yX8oPJzji14s2G77HH1xy9bSkzZe1lPT?=
 =?us-ascii?Q?DwWdbOssKkR2HJVafDVn/zwQI4XS8JR2Wrd1ihA84XMfJdYPiAG+JBmnEMZW?=
 =?us-ascii?Q?LMW764i+M5/EbbyjXhD2Y3GmUxPII3KbplccJAUbVIZGxUeACDjjwCo5M2ft?=
 =?us-ascii?Q?gNP7EiSRly8Kej2rthNfICoza8JsjDk1ghiWxbGLGOZe0qfs4eo7vEIRTgpc?=
 =?us-ascii?Q?z5D2rpLib3267dbbSOt/EvlbhwwQKndH5h9MFTwpLEyd3In+RmDKDFPvH6Ho?=
 =?us-ascii?Q?mdyLCRDNRFn2LqbnKtqoxnrjfifFYezqGQz+NiVIn0OTFrcrPdROaLIairuN?=
 =?us-ascii?Q?WoRueutdjEVm0M8IXDBy9hgEfODVwQeCVkA84xqtdv84Jh0RMIuSIMmS6Jc2?=
 =?us-ascii?Q?uvniexjmpvJ2Um12u+wbVXaTzB8lM1NwD1BXeZf0uMkofJFnoeHpVPoz99a9?=
 =?us-ascii?Q?y7fuP9cTf9Pa0QtuQ/1VnQsjWusOEJL9CJq4lVsT5ikjOu3bYlxEZYAIzZAr?=
 =?us-ascii?Q?8ZYsrZgXnb1fsnstjYIV04Sh+qhPKWfIhnnMw3PL/DQgLV1Wc9vYlHhTJuSo?=
 =?us-ascii?Q?7L2P5PVzzJ50NnM2VcXZ9gneMPhzZ78bUp9tiSiJEMY4/ddxTVpBg264QCBL?=
 =?us-ascii?Q?9eMfMmTCm0Vl6TWBYPFnddTwSgNmLtU+1akagrkXYr9iKoioB4iILX1IMF2S?=
 =?us-ascii?Q?RHKZvUpk76mcIKQjFBE2j7px3db4VL5s4NchgMNaWM91BaHVqZ3tUFKF1URK?=
 =?us-ascii?Q?rQq1UihlE1kgARGK9MITMiFwzAWsMdsom36dZYrJDGDvgHajlJaeyWHi6XsU?=
 =?us-ascii?Q?iAFFhracjyWYAnkL4wdr4B/6vSb5gOfJy56bsP13wiglAwurUjKJm+sDe69l?=
 =?us-ascii?Q?BVw+kc/NRnGE2FwAAWfWzsTthwiLu3qef3DRgIkWCwXRTgVItM55+azV+z1b?=
 =?us-ascii?Q?ba03xP9aiGj7pzU/VweOVCoR3xGmdz6luEdblpXYQQD+SMy1OZIqAVfTZoEe?=
 =?us-ascii?Q?7wkxAwllO3HPVAYOChHdFfCRjN2b05SBDM/sYjOpdEdJkcQ8+Jd0nPkhaRNU?=
 =?us-ascii?Q?ovV+VklihESAh7E3THIRebJBWV36AwL5k51v1fuqjuTpaL0b89L0aNj5RvTy?=
 =?us-ascii?Q?hVtdcvHPn2ERVIrHAQ0NYMSUhYYIwY3HM6y2kiOGZM2CxZv+edrMhnK4gn3V?=
 =?us-ascii?Q?HaKOexSf2Wcedwgc2wcnF7m3bV+/t7oh+bXgSroAGZVTpghhrxkB6mVxrBGq?=
 =?us-ascii?Q?2T/azhvBPefEce7LCJpkqpDWewC6Qi5sgBaYDSKuRjPPWWMS8GT4zBBLa4Fm?=
 =?us-ascii?Q?VudbnbP4ALTcVRUFuNRYXVPrPUqv1eloHYBR7iIBdBGHA5/dDWZTixQGEiM/?=
 =?us-ascii?Q?4ZfCOMp+O4DDH/Wkwa3RoUTuodNb4IgGGd2xT52JWVo09k8O8qFR0CqL8ZEU?=
 =?us-ascii?Q?txeUmnRk8plRTTInFdn8s3rqHhUTY64TozMGWR53TnafIxtF0QYhpLmRKdN3?=
 =?us-ascii?Q?PrumzyDMXYKGeTYTM+l6vnKNG+iQCcsK1m6JBVNQw3qsqeTXJX3TLxuft+12?=
 =?us-ascii?Q?cAJxJvMsFK6Wh7Z7e/pAlMXMRJ4Y79lrPdu3J2e0uKx/EX+1jGOh0coEHVgl?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7011ce91-66f5-4a81-b6bc-08da8c48a894
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 18:34:52.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bqs01uWWsKebCZDbiTjnA2CB/DMZXWg3WR/6ktsg1tooYk42OFENVtbqxBYA+PxglyWikH5Mck5EmOOlsU5qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010080
X-Proofpoint-GUID: VNYNRgk1mZW8jJYVa6qSekFaeNWjgURg
X-Proofpoint-ORIG-GUID: VNYNRgk1mZW8jJYVa6qSekFaeNWjgURg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/22 16:00, Sidhartha Kumar wrote:
> Helper function to retrieve hstate information from a hugetlb folio.
> 
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d8742c5bf454..093b5d32d6b5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -815,10 +815,15 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
>  }
>  #endif
>  
> +static inline struct hstate *folio_hstate(struct folio *folio)
> +{
> +	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +	return size_to_hstate(folio_size(folio));
> +}
> +
>  static inline struct hstate *page_hstate(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHuge(page), page);
> -	return size_to_hstate(page_size(page));
> +	return folio_hstate(page_folio(page));
>  }
>  
>  static inline unsigned hstate_index_to_shift(unsigned index)
> -- 
> 2.31.1
> 

I would suggest including patch 7 which makes use of folio_hstate.

-- 
Mike Kravetz
