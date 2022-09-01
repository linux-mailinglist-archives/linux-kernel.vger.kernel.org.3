Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC565A9E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiIARdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiIARdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:33:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2492F54
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:33:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281HJjAf012764;
        Thu, 1 Sep 2022 17:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oRicenFrMXofd+IOwRz7EuttE3LV7K3QUrDHhvpcGRc=;
 b=KVYCDIZWyxTdwN9jORI4GocBcQC2Y4i3CrCfmj1CKb4eULQiTxkYEhbzxRBVFu38h6oG
 JNdoIyKBW6DYOWdQT/rxAapTe2aj0baCK4BlOoG9YAaasihE9XXtyv4TJpjfQ8ruvB0x
 rw9ApfnhyfXkxdZW37BZYXhygQBDO9Pyiusg7yZFTLL632LAcYT48ECUvLu6ufmSt3Ro
 8xImYQ9uPCVywOJDHZfS2qbA3VEE8vKzGGVJXXMQL1yKcoIhUbV4wfh6H7X5VVoIZ5f+
 OGnEwb26vc9FtYzJKwlFy1g/8H8yUXwpGdkfMb4BjX0opUTO5LIJenh7ivMP26HEJRxQ 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a4sdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 17:32:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281G74Ba036765;
        Thu, 1 Sep 2022 17:32:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarpbae01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 17:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8X2OywA+oOVgt2gzke8n9kph5qI731s07eT88QxYxQCT0IG6nloKCaH6AUOlHdNs2xxhBe9cBRPIYVA8n/wGp3Qjnp2LANHWWJTw37oI62PWJY3ZYgesxOPYlbUWLOpDfqo3NjeWpvk98+gxfYpbYGFYEMhyKJrHfFHW47bZwSCXHNVqkRG7DDuc262MTk3uaASP0SNqpyHxnY3y9YTxTNEE++IGtrQRg0SEdQkA3qKDny76BEXzothUaJ95eb24BIYL+lBhj5V051huT38XSVDbKKrGznJXn7fzS7ReqDOzOn5mdlxOJKu+ED4MYe+xxqo3GP3lMYemQRFaTmFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRicenFrMXofd+IOwRz7EuttE3LV7K3QUrDHhvpcGRc=;
 b=kEtcL+jleNlCCUzc+s3xbM7q8O3A97nGlZ84jzexRRyaHs5Buc0gwxo4N0zL07f0iLRURDjysxEWkWeSlbiQrHw0lUSa1gYGjghwc/FHXn1n0H9jJUUMvHJ98Q6CisUiQrmiPYrZG82j7vXe90g0We6bLAhcMvybVDJ6qZ6wH9xgGr4FwVB+9JipAM5pw7fs4exC6k5gtTT4TnrD6Ni2eU4w6Un8u5MXsabXJU6vd6ORi+qbitgEoPx/hcCOdWnq8Pq14igMK7pF6iPnDUIl8rS0gQtywzs1K2z5Xp+YGUacVM5JVHNWPzumFbTJcmwZYemVNcp5HIg26KqATe/DNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRicenFrMXofd+IOwRz7EuttE3LV7K3QUrDHhvpcGRc=;
 b=SrnMgLlZCxvKqKU8+oz0bXRvhYNKch82qTm9qQrOn11t9tsYIQ+3JwjyBSJ80+WjtTYJBvnnA/I5m5uj46962fiRf3ULzm9MwJnxKEJr4M3p0t/UrxtLeQR7LwNz981neKheIQLorDJGc9KUIVEadg+iHFg0lNM1wuJc3FO5FZI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5146.namprd10.prod.outlook.com (2603:10b6:610:c3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 17:32:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 17:32:46 +0000
Date:   Thu, 1 Sep 2022 10:32:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        vbabka@suse.cz, william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 2/7] mm: add private field of first tail to struct page
 and struct folio
Message-ID: <YxDsu8Ol/yOg7sMV@monkey>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829230014.384722-3-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e477e43-278d-4f71-1c4c-08da8c3ffbcd
X-MS-TrafficTypeDiagnostic: CH0PR10MB5146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQoDgN8KzAFRjI7WK9rFN9VXReBiGX1zmRONYhjAdNTDTl8b8zVn2laZ80HR/p0mXC8Fu8qgN2Q+6MDvaIkD9pZaS0mQfBZblBYoWHlbnkGd9PF4raPGKGi/TG1JNyGoTxo6wmCBVSEqh5gDcCN7D1Zk+2qTYoMBQL0OfcR/C8EmmaPG2u7Yk+U4xq0no7ADDfwvEZiF9gnuMtF6wHJux8QkFd2X3MRIX5uaOqXDSvY/vPh2pTd8zoM6GWJZ45+VUb9K8mSXeQt65Ou/kNUkdPVWjARed7cbP47nkyFHpYEZOATNT/ePLbj+rR+yjKj2LtUUbiQLgLNZ1VpiIpLH2QoYBTvWcq2dmhKB0Xf/+8hlYpnZmOHdoXqn1hAp2aFsGXXv/DAKTTH3L3U/ZSnQy9NKpIlv9OMh9Kgdg/KS9pvnqsVmmAVMDiG32DOJaurCQO2UMZZqnkaWIWlWk9nORCfTsnskdfOFJETURohQNaC/scee9NvCykKUFSgKD1gUjZrAQuQqAlK+fM+Qrl1Tc5pmVmW913HIRK1xG+rIlUzbGjJK23qjEdVXrCCsLVa+G9MAfKDno+xf8BdffnvC6fsfEC1MyjM90k+jAJNUKC5JHzRSHy+khcoIIQ8A1PZIkamfPKyxhNswg4k8Zqc73Di5BpKdQo7PkFhX+JklSfBQLMCzMGJE8+bD+IORyEoMUGwep1pre/8nFwMGAo9Vuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(7416002)(41300700001)(5660300002)(8936002)(9686003)(86362001)(316002)(66476007)(6486002)(8676002)(478600001)(83380400001)(66556008)(26005)(6512007)(4326008)(2906002)(66946007)(38100700002)(6666004)(44832011)(186003)(53546011)(33716001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HvW6hjgUMjOTrTt7l4p1IigO8B6119Sqe/5SnHIsaldYpRi4Ddg0BGuXMqxI?=
 =?us-ascii?Q?0rOmIvJi/c77lfkuz30rpTQ88ya6x2Kyt82XGAf50HIBkGdRI+0bzOJ+4kPv?=
 =?us-ascii?Q?gIkUZupu2HsyTLnx9jZGBkiBYGF4UAvlLl4JBSlwiQ2rgliCzMrQe8ExOlZ8?=
 =?us-ascii?Q?4LlPREIHJGDq8WX2bkoewIIE4k0SVW4V1efm2TwcJ0tDDVrogQuVt7aqcDhO?=
 =?us-ascii?Q?pfUUY8TaPg/wyhVjZVrTl5WC3isEAZChKs5Uxzn3qWQcujGlyzwpL2a8Hj4W?=
 =?us-ascii?Q?1NdL7kPxupS/1deHHXLLzU5SSgDtIAfwz/RNke4V/Ggyf7md/wDkkbxQlYfM?=
 =?us-ascii?Q?JWAPcSp9OkNejf6foklg77IF8aM0Rzr/M6Ua4qia/aV3X8bp5JOWdFa5Y4PI?=
 =?us-ascii?Q?q0eF+LaxhKHIzwKkCQKyX4KTo3bcv4l/AvIbdPpSv+KfaaDovevN/5mYOh4z?=
 =?us-ascii?Q?772QlU9srYG+9WJmNBZcoNJBKqA5jNtJM93l8E5GYBKC2Mt+gMU4A7HMozoA?=
 =?us-ascii?Q?mtZWZBvNm/Aq2orJq5mEwmaZniyJPljG6J9HHw6ofnfzT4EjF1KUXtHscF4V?=
 =?us-ascii?Q?8dvtYUipu0yxrLBEgqXpclcgxtwNIcJknHZgnhFbtyaXoDk9FFVL8Ze+a+RH?=
 =?us-ascii?Q?yRnrlHk6gYM6D2DaziNmtGsCUizQOB1rUg1vNq/WS39uVmJJWcc2OW5pK4kg?=
 =?us-ascii?Q?XlwdIFwaOHSfigTPFzdgwHi/KpJ7JBJq1TiWne8QLF8TNSdSL1Pqs/ZVmqAT?=
 =?us-ascii?Q?pbykb1TQPvb6OGLN5WN25V8VPETc/Emv+0CN/G6gpxcR+j7REsZjO9LJAOPZ?=
 =?us-ascii?Q?iyhn7mDLVT7tcqCyQKlESEcbOaheP7QnzlpRYzvowxaoXtiPZFidwzFAyt5U?=
 =?us-ascii?Q?Gohgdy8WdKzTwiklDGpKPiGIHi+ggZ3CNRuCEGuiNS7CTBQ9H5dBynSgEdt9?=
 =?us-ascii?Q?gsvz7pFnWgyBZ/mnDPWRVD5G0e/sBX440stFe5EyqMIgvXS3nSxE7Ij0ucba?=
 =?us-ascii?Q?u0kjEjCP/xHCAuMmCd2mmA9xi2d0dJqiYQV5ZD//BIBkiIZFlfdw4FvQxnSU?=
 =?us-ascii?Q?AJmp/2P6r4hFuq734UmBquzeEAriRrMPSoN2Vn9rTUnuFN3ixG+AGXoi1dTb?=
 =?us-ascii?Q?qRwgLNLBS5u02X4S0aTYDsGYCuEfvjHRHb43nqwH6APlYb41gPJ3copB50qc?=
 =?us-ascii?Q?2cyq94SW7/hvouuCKPUP2HAbaHAuipS9D3IHECmbw/Piwg5+hSuOEA8J/I7w?=
 =?us-ascii?Q?0s3oYdAjhMVURycpT9GFb0bspm6rrkGIq+PMnRoxa1rGox0YXd6AKezIJVmh?=
 =?us-ascii?Q?ftXUW77gOr22Y8HexIwOyWGReJ/rWoRaFUC6VQbbe1px1D0PVXTjK39NqeVz?=
 =?us-ascii?Q?DnejfhG8nYmXKyUy3EcVXi1Rt8rzuMq9x6xcBFrA2nMxU5JwQc+IgT470/uk?=
 =?us-ascii?Q?8vqepqxIq4CKrH/tCeyqNwDx+8cv3LSx7PoM+Xjz2o1UGpv/F1EpVjwGwr2w?=
 =?us-ascii?Q?nRhI4htnPKVS9q8kb3/pzBJsCm3f9NJNFXJvb9KbCWpNNq0fjcn03PgoV7vL?=
 =?us-ascii?Q?ZqJU5uiABycZM7jDu5SmNVNnf0xJjlVojcLlafOaewOcGcEZuk7IgrrICoG/?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e477e43-278d-4f71-1c4c-08da8c3ffbcd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 17:32:46.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gSTrq+pgAzzQkLxEfmWGwCH/KgfuxTRV1jVzxgwQjZ++TlDGL6eZxK1JcaPSrxf5Soy8yTF5v59vi4SkrT7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010075
X-Proofpoint-ORIG-GUID: qv6e1Y8K-qXXZzpwk9NFv5sY883UiPF6
X-Proofpoint-GUID: qv6e1Y8K-qXXZzpwk9NFv5sY883UiPF6
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
> Allows struct folio to store hugetlb metadata that is contained in the
> private field of the first tail page.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8a9ee9d24973..726c5304172c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -144,6 +144,7 @@ struct page {
>  #ifdef CONFIG_64BIT
>  			unsigned int compound_nr; /* 1 << compound_order */
>  #endif
> +			unsigned long _private_1;
>  		};
>  		struct {	/* Second tail page of compound page */
>  			unsigned long _compound_pad_1;	/* compound_head */
> @@ -251,6 +252,7 @@ struct page {
>   * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
>   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> + * @_private_1: Do not use directly, call folio_get_private_1().
>   *
>   * A folio is a physically, virtually and logically contiguous set
>   * of bytes.  It is a power-of-two in size, and it is aligned to that

Not really an issue with this patch, but it made me read more of this
comment about folios.  It goes on to say ...

 * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
 * in the page cache, it is at a file offset which is a multiple of that
 * power-of-two.  It may be mapped into userspace at an address which is
 * at an arbitrary page offset, but its kernel virtual address is aligned
 * to its size.
 */

This series is to begin converting hugetlb code to folios.  Just want to
note that 'hugetlb folios' have specific user space alignment restrictions.
So, I do not think the comment about arbitrary page offset would apply to
hugetlb.

Matthew, should we note that hugetlb is special in the comment?  Or, is it
not worth updating?

Also, folio_get_private_1 will be used for the hugetlb subpool pointer
which resides in page[1].private.  This is used in the next patch of
this series.  I'm sure you are aware that hugetlb also uses page private
in sub pages 2 and 3.  Can/will/should this method of accessing private
in sub pages be expanded to cover these as well?  Expansion can happen
later, but if this can not be expanded perhaps we should come up with
another scheme.
-- 
Mike Kravetz



> @@ -298,6 +300,8 @@ struct folio {
>  #ifdef CONFIG_64BIT
>  	unsigned int _folio_nr_pages;
>  #endif
> +	unsigned long _private_1;
> +
>  };
>  
>  #define FOLIO_MATCH(pg, fl)						\
> @@ -325,6 +329,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
>  FOLIO_MATCH(compound_pincount, _pincount);
>  #ifdef CONFIG_64BIT
>  FOLIO_MATCH(compound_nr, _folio_nr_pages);
> +FOLIO_MATCH(_private_1, _private_1);
>  #endif
>  #undef FOLIO_MATCH
>  
> @@ -370,6 +375,16 @@ static inline void *folio_get_private(struct folio *folio)
>  	return folio->private;
>  }
>  
> +static inline void folio_set_private_1(struct folio *folio, unsigned long private)
> +{
> +	folio->_private_1 = private;
> +}
> +
> +static inline unsigned long folio_get_private_1(struct folio *folio)
> +{
> +	return folio->_private_1;
> +}
> +
>  struct page_frag_cache {
>  	void * va;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -- 
> 2.31.1
> 
