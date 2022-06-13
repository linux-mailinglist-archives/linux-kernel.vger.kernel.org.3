Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F454A167
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbiFMVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352673AbiFMV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:28:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA2BAD;
        Mon, 13 Jun 2022 14:21:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdRPJ016594;
        Mon, 13 Jun 2022 21:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=UBf0bPbXwpUZnidM+EsPS8ze3lapPTHHHevFzawgO6I=;
 b=rz9IZT/Vllo4BymLwSPdZrXfMTXD/jxDvLko1A4OLhiwNKFyflZSCvZ5yZ+h+r4lGUq4
 Xt/CPs1p2v3JfhYZGocHXAtu1RRAxd5N2sUPVmFzVtb/OSDLCzA8kasPPnmkSrduFydm
 geVIT+vxcvbQcWBczBfzdV/ttTOT03ZoryCCdTqofyQaTkCL/D06+l+rdOyq3ORKPLNd
 06jTCLOksveEp+zYqfPJYM57QVqCjXY5DFYg+HXi6W/5ptsnpkh9qmfn6Uj1XW1Dq+ri
 1ityCE45bAmGupMzpk0sKP2QlylMxW0aJfooqYqxKYlsa7r3sjwe+IWTLj9SSStpMcH6 uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcm6h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 21:21:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DLA6Gi012694;
        Mon, 13 Jun 2022 21:21:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpcqhrg3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 21:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co3wMKl26ew1ODWkSJi5QQmUw4xIOFPYnCaxCtdLeXk+C8MtG1iHv4yYupM0zxM+zSga5BVqiW7LG8/n/zXQ1uqR8Gy3i8GlCjJlQCfxDSGsdtDu+WZ1yvqa14XDz1fYI8ueT1jfZaLw+NTEzNud/FXgM0sBHp/1TInjLnSEcVmnpTF09985+a1jt0h61lZTlRexE3ruDLsfIn0lwwRIDjhOoE3FsiLZdlN9xHJNf5uTgt+yYDgAFVy4nOHob8Au1OSKhgROdUK6z0kiB0aAVh6uXiLPtVIHteV1VtwLD19TVmtfHdcgwCuEID445sJl3zT+8SLH7wsC+/3qdLIZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBf0bPbXwpUZnidM+EsPS8ze3lapPTHHHevFzawgO6I=;
 b=SqgUgZGYtnxPlgrduADT+QHfhkhQlMJxbxrm7iH1HzFXXRQhzAIkbmZbnZHh5CCylUb9CB6s8syOGT09/YtQjweI92Xkrny/e7WCDc5hVEYsJVnZpZ6zxI3yStvTXcuKoNQvdj0Z/YhVoE+G5YNLY2BZwQUG8JmbmX0g/93rqlt/Y+iJN8km9GOcnRqMUuIVrvus+L5y20OBvISIFrDULjlhnrl8On9BGpA5GMtOSqgHleDW2ZF8tVcWyXlbj7MAldOZgvhz73jgrWLH9IPcY9MUPER86dTyH23ulbWxikrBgxMH+ibXXnjNFs3ofOX12dxzX77qXRfSINWcnh5TcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBf0bPbXwpUZnidM+EsPS8ze3lapPTHHHevFzawgO6I=;
 b=n1P2gOx9mvwJXywlTPpF9Nt0JE+MreVd1/SV5dp00uzfKIeaWKbfHpQF5rd67H6puyedxgcVbGyPtcqKJiITydlhWlVMHbkaecBaKmvwyjqDkECgJ4TVt7WC7/rbGr/e+t/27N2AZ6pDlgALS5KYYJqpbjoP/G2RMgHeR/lLNtk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 21:19:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 21:19:48 +0000
Date:   Mon, 13 Jun 2022 14:19:45 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
Message-ID: <Yqep8QwtfcRCCPsI@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613063512.17540-4-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0b0bf48-354c-452c-4c1c-08da4d8271de
X-MS-TrafficTypeDiagnostic: CH0PR10MB5081:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB50813D7C0E04798A43C91A17E2AB9@CH0PR10MB5081.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/5iVE5Uyg6ZGTk9j+lxUKAB2ugnxTAXcZTXtVchHB4HXszw+rmIYGjLaOBM7b2up3O0RCa9GsVnPyLTJGv+ZvnE3cDvTqQeXdpX9PcAHqjQnPK/UFHaXBUaTWERR6pUEBSsvDTtGuh2Som4x8l63h2trzwWzaJ0ffRJ2DsIqh+dbhr84BM0NbJJzQAXkgXxS26Bn6OT6zYZFFnDLunq2N+fzGhaHFpIL9kGhllZ0ogAT9fLv0pzMuGSShS0g0Gj/htqq9Pb7bYpWyZMxHVXLpBoBP8tbIiESnbGkI+vpatandsLZdTDGQvwz2mq1qrJ9/eBxOvFQyq1pUgvqg7KDirlYQIR5W8WmmO56Bi9UBkeYnNoKuq2xqKbyXxmWLuZVgnArI3D2zBTEeIwXtR4d7YeARGc+BfAI8lZNI0lFBRVK0/cIGUXXusaxwp/IKBEEWhuS8pjTAeQPceX/bJoPrFjmkSkrKvhrf42IJBUcw/zJ+M96bAMmGckU7h5BSSjClmQK1lW6BADBSmz0Vv2YaCAe8qoh1fUnLMZffB2UNDolepxDMZL3uwO8IiAhX+bxm+ClIYjOtS0Ziwwdz3HZXHX/azSaoQVQMybBD9VhrQfxC3cI0SuVzomSYGxnRYdtUEYgbEkl82Wdud4K3Dm4iv47vBBC7OHmwtz2jo9meyArKNxLDFBYZrjkqGGeOYUmF+jUmSxvycLyPtrmp1FygNC1RG8kxEnhzVCtqV4e58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6486002)(966005)(33716001)(4326008)(66556008)(8936002)(508600001)(86362001)(6916009)(8676002)(38100700002)(66946007)(66476007)(186003)(316002)(6506007)(26005)(6666004)(83380400001)(9686003)(6512007)(44832011)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5JWno1T0kraGI3THFuZXgyOXlRdjQrLzhGNlFZQkdDbVQwSW5pcFlueC9r?=
 =?utf-8?B?VmV3eEZ1azJYS3VMRzIyRGhFTWdEOEZUemM2bnJQNy9HOWVyN2prWWxIN01j?=
 =?utf-8?B?eksyRDR2d0tnNWZNZ0J1ZTExVnpLQ0NXeEJRMWhNdVE3QkJoU2VpSURJNm40?=
 =?utf-8?B?aVdQSTk0SWI2enlRb1BIUDFjcmRGU3gzaWxxa3MwOVVqbHJBNzNKNXA2dFEz?=
 =?utf-8?B?Tndwd3ZqUVRxL0VHZHhZeFJvOW50cm1LMFlYNFB0RW5CazhWczFVWmNzWnhT?=
 =?utf-8?B?cjlKV1MrSDBONDBlY3BRaElBR1F2aTZyN1ltQWZqOVVSMFV1Z1pqendBTnJP?=
 =?utf-8?B?SmI1bm1Xd1RUZUk4c25JSG83Mm04b01sZEJMc0FncEtvR1dVbENlYlZESzNC?=
 =?utf-8?B?WGZVR296cUowblB3T3hZMGg4WWhGRmFOSldJNkpxV2x0UlMwV2NuaFY5c3dK?=
 =?utf-8?B?TkhEY2pyUm5pVzBuWUg3QnVUbTBERlFMZkE1eitzNUdadGtxQUpnY1M4a0d1?=
 =?utf-8?B?TW01aVRHUTE0cWhwb0xCdEhLcjdKQ1NVLytqbUlPeklQZjMxRjUyNWV0Z0N2?=
 =?utf-8?B?ZXg3d1kydkg5d2dFSGZuNU1iWWo0RFR3MWdjdndEcTJBRzlPNFlGQkJ4SmRx?=
 =?utf-8?B?bmJpN1RBVGJXT3FQQzc2dkY4aEZCMWlIckJtWmNPaktoZmhYUHpFbFlZZHVr?=
 =?utf-8?B?d3dub1NDM0xnOUdmcjRtWmZvUVJ3ZFVqaHBwcEJ3OE1zNEdRNzdmcmJZZjdr?=
 =?utf-8?B?RExQVWFGc0Q0SGVweUVmZzRSdFU3L2ZFRk9kN25pNGR1WWt3VWxJN25zNVl0?=
 =?utf-8?B?TjhWQ24wZjJaTDVlajZQUnloaUwvYVRtUlV0SnA4Z1lkT0tqb0pBZVRBMHR1?=
 =?utf-8?B?eHk2VjZ5ZmRWcGNDR1ZJRHVkQjJicHBZSFlqRTFzNElkNXhsVGhMOFlxdGpi?=
 =?utf-8?B?VFBOMHdzVFlwOS9DdFp4RW90aW9PVzNSczRENWxiWi9FSW94Mi9wL2FMbDY4?=
 =?utf-8?B?VWFlUG5aYlk3dUViUUtlUmlvRWFnWW9mcWNQZkY3eXJoMmlCU0Y4NE13Zmxv?=
 =?utf-8?B?cTZQUXEycnF1Y25JTTh0ZHZPOVVtREVCR2UxK0NDcUozZWwyTjhrOVIzaEFx?=
 =?utf-8?B?QUZEcXJHenM1REFsa3dlRkJJM1RHZ0xYQzJONmovOGJqUTVpL3pRdVBRSVpB?=
 =?utf-8?B?WGxvSjQrK2Jzc1Rvcm1TZFk5N2h2cHVvQVJVR0NDdlllYkhrQi9wOHBncU5L?=
 =?utf-8?B?ckJkRnVXNm52UEhjcUdlRDhJSHZzdTFXWTJlTFFEVnlrUkN0YVBud2R4VlNM?=
 =?utf-8?B?NTJwRWxwV3NyQWJhMFBtVFNGdzE3dHNCWXVuMUI0RGVyNnZZcTlBcllGelpP?=
 =?utf-8?B?R3hKT04vNmpBUkVOUDAramtwbTl5REpjWU5tY2UvY0JMb0pvMUhVb3NrMUtr?=
 =?utf-8?B?TFQ3TFVLQzJSZDlBclVqYk9zRXJLZTEzbVFEdS9YWUMvdUFkK25aaS9JdFht?=
 =?utf-8?B?ZW5SdWVJWGU3R1UvQjVOVVY2a3FXQXBGb0o2bWdpdVVIQjBSZDdsZ2YyRXRC?=
 =?utf-8?B?S3prUDBOL3RUMEZaUmFhT09oaEZMQUQzL05HUGN3UW9IT29ZWEVSQlFvZG84?=
 =?utf-8?B?eHhVdzlIY3Y2bjhwVEVHcGdGUjByK0hkN21DM2dTYkVzL2JTQkF6amZPdGZT?=
 =?utf-8?B?bWhsdTVva3FNaG1PN2VKOUdpU2svRGFKK0xIWS9YYWg5WnJFbG5zY3QzRmRN?=
 =?utf-8?B?TzN2OHFaL3JaZUtKUVY4QnBVc2RhWllOdmVoTGY3eHBHMFpCZHh1MkpYSHB4?=
 =?utf-8?B?MVdWaFZpandLU0NoVDdtay9SRjBweE1qcStBY3hJRWhYSGttdGV2WjdOUmVp?=
 =?utf-8?B?RjFSaXhDY1c3L3RqNUp5ZEpNYUdwSTBJbFNuOTFDTDllMVkwOGtJaEgrSE5a?=
 =?utf-8?B?bmpqMDc1RDA2ZGtEakFGbXV1NHhtU1dzNEo5UmoxUENqVWQ5OFU2MmdOa2hC?=
 =?utf-8?B?UW5kckpPYmtuNmw3Vy9mWlIwTmt2WVBlRG56K2l3VUNLTzJGcXJWQWU1eHQz?=
 =?utf-8?B?dDR3QzdGUk16RHpTNHY0Z25nVDYxaTNRTnBrVGRKMGR3MzIrQjNETjczSVpN?=
 =?utf-8?B?WVBIMEVmRXNiN1pPQVI3ejBadk1iT0lRSjFGYlBrVWFZbG54My8rZFlpTUh3?=
 =?utf-8?B?blErTGRYYnkxV1hnaEhlbGxHWlV6bXJwUVJlQ2VObGcwWHhzYThhZnhxcWha?=
 =?utf-8?B?U0pteVpBYUh4ZkZOWGo1TkRtRXdCL1oxQ2cyQ1NTcEtGdVBvTUYrV0VtTEhj?=
 =?utf-8?B?ajVmaDdQRFE4MHBucHgyL2kvV01FQUtPYm9NUHVLNWVmSjkwbGhTaWYvNmNi?=
 =?utf-8?Q?7KugvSYIW2P9BLVs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b0bf48-354c-452c-4c1c-08da4d8271de
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 21:19:48.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdXfvGF0cPJj9MjiF1KWcZrQ9BiMKd1a90dJe35zYWQNFjGV8LaHkceGMWHpmvoU4h5XczpqJqKmVxAYDiy43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130084
X-Proofpoint-ORIG-GUID: xgKAGu3OuQfxZHwFSkUL7qT8mfw-5gzv
X-Proofpoint-GUID: xgKAGu3OuQfxZHwFSkUL7qT8mfw-5gzv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:09PM +0800”, Muchun Song wrote:
> It it inconvenient to mention the feature of optimizing vmemmap pages associated
> with HugeTLB pages when communicating with others since there is no specific or
> abbreviated name for it when it is first introduced.  Let us give it a name HVO
> (HugeTLB Vmemmap Optimization) from now.
> 
> This commit also updates the document about "hugetlb_free_vmemmap" by the way
> discussed in thread [1].
> 
> Link: https://lore.kernel.org/all/21aae898-d54d-cc4b-a11f-1bb7fddcfffa@redhat.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---

> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index a90330d0a837..64e0d5c512e7 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -164,8 +164,7 @@ default_hugepagesz
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
>  hugetlb_free_vmemmap
> -	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
> -	unused vmemmap pages associated with each HugeTLB page.
> +	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HVO.

I think we need to define HVO before using it here.  Readers may be able
to determine the meaning, but to be sure I would suggest:

When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set this enables
HugeTLB Vmemmap Optimization (HVO).

Everything else looks good to me.
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
