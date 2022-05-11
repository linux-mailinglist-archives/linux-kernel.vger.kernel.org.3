Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482E7523BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbiEKRxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbiEKRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:53:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609AB6D957;
        Wed, 11 May 2022 10:53:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BFmHgc022574;
        Wed, 11 May 2022 17:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Mn4rmTv7i5cbigW+2lxG+RNEqXBhBxpBg2utfQO6p04=;
 b=tZ4Y19exXf19306SV64Y/k5NsqPePeaJktySJ4lQbhcXcCjiNUFyxUp+USfuoPptOVQg
 oFjl8ahXkosREcUWOAKasgATAbog7REWqnwIpUEF+ONUsTvCnS9/GxsJ1hD/ZI2r51K4
 UwlsE7KWOtbDKv6KdKxdq5H30Q6jybDcvkIyTzrI8D8XoViFWdq+ZbCzSzmJjNUr1UD3
 DCuRwRFrAZRcj8UJWYunJvH4qZylyCibHOK0CkE2+xD5HR08GAHZzxVHLCyaG1Sr0+i4
 HhnyKRhm262C+kXm/Ni7/vGh6rZZCy1hTHgQ+HyDYtAw0FFdrOq78djkg18XoAHzKn1p hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatjmw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:53:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BHVhpp001574;
        Wed, 11 May 2022 17:53:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf74nera-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxLPh8Jvyb0N2IdmrZwZN7IAvqtdDGBR/UvLdnx9XaOHcGU5sCKp7pqF0UtcYLE2TQF3JwnfMMEHS0MGXuK+CMaCLaCylaRHWywN3/ORSkVaeQClffeIzp9exnrCXpPshE9wrPfWxIyZIvrQId/0XD+vpInA7RpNMOc1d+OTdT6iEMYUoJRwPF55Co/DQF/ZmbS8zs4XQqmMSxCvEJWMyRj+cuMtLbLhdE0mvLTyv/F4B5EJpLfz/ozEovCyT9GVtBH2tlKgcqKBGhj+MS3gWiA58mfRF2TnJ1T0k2XlUN+ew2ANZTyipqpLmpr3nDYK0tREmJpq3lduQKMGOvc3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn4rmTv7i5cbigW+2lxG+RNEqXBhBxpBg2utfQO6p04=;
 b=Ba1wJp3f5bCwHvMYXgby6Rk6wY8nAOBfjvx2LtGtp4yZZD8LNKFI5ljK2O39D5BSTwYI1qLCgPZs6Zfke53EFCxJJOSpsPC9hVp1JMt7RgZ6H2aX95dnXmK9xCHRWKUjm5qX53mIXV+D9miVmDppMy0HIdKr2bNrU+ARnEEj04RbBExrc5pj7XO8ElPNlgJtJ8GljIILMpfKJievhuy+p45bZJEf8d9zCbTDHAFzihp2kHJNxOKPwvCesgxpEYxPlvgC9HfePH6MZsbPqMlF31542P7GMIYMUt8YUxKs0U/q8ZF9WgO3tl7/IHK/C1lQAjhy25DzE8PXwo2qtR253A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn4rmTv7i5cbigW+2lxG+RNEqXBhBxpBg2utfQO6p04=;
 b=Ye9/0SyhlIZ8uI0UMXDRMJUlXS/1Vgj7VXDzxt1sGuNIHtlefsBhn3PZbWROysX4+Q0pLOrgU3X5aAd5AVZyzlJxKlTXy9giDxRVyhYMpFcTjjqSW2xiV8Kt43gp+lZQ0+OlDBDguHZoUjZ+z31pyWoFm8CR43dbXm8B+GpiyiU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 17:53:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%7]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 17:53:10 +0000
Message-ID: <c77c61c8-8a5a-87e8-db89-d04d8aaab4cc@oracle.com>
Date:   Wed, 11 May 2022 10:53:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-5-songmuchun@bytedance.com>
 <970166e0-f70e-dd2a-c764-af23a8425f87@oracle.com>
 <9d64809f-db8c-0a3e-1ae9-d4a8ab79041e@oracle.com>
 <YnuF1c5fMOzJnNfD@FVFYT0MHHV2J.usts.net>
 <YnuWnFbb8xExKfdk@FVFYT0MHHV2J.usts.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YnuWnFbb8xExKfdk@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa92311a-5fbb-4582-6c45-08da33771c6e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5804:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB58046C36AC3712583A8A9CC3E2C89@SJ0PR10MB5804.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPyL2JBqpL/qGRhrTD/x/g75jIMsbqxPE3HEdwzRD/hPWUpluM3x84Uckt8VOGNx4ObwjlczEiiRWGZ8SyCXPZTCDO8tJN6kOAgc0cUw8VkkiKklOnyZAqBfquTrEO4DN3p5J+fPN0y6cnv8KoNVwQfKIsReND9+KCUq8pQU3+dGTjldHEx5p9pflkfXeTAdKJZshCF0lRqm3VxI8rjanuwE21dukOxSPZplgX191zM3caBiaFkYjUtR76K9SFVtHZ9QfJXgQStHS+hx05tkbLtr3pKHDOys9ifDhdy4VV11R7euK9kHyclfJEjpMpO11xUpvnY89MOgedz2tvBtlENXweUggJr9qdgPhSwgLdTIJhxOgyoa4jHyhR56ba0xupM7gGGnqNlY3sX/qbbDalvuGrPrNimMnN6ZAYeKi2bZG3sqSyabXH/D4/S7QLzSwH6v8BBtQ+OMBF37IMggfq37ZgRa2q3AWYw1WNdbwf22BZ0D6WvbiQuIics8XSUrXmDR3SI3HV4Q28a9xlGgwqdQE094OrnZKhMYOlIf2DUhII/lgMLY35bXxgZskflAViyRcUEynipe4Ckq85PleeRJ2yhimjdRKYtjLn+N6SNPRFgNML6aMcUySuajyMICpmg3IOYW/wXl1eP68I982VOZR1uqLnU7WMnrbcqWO6CNNzit18ePcTdbhmKqEd3RD7IWMpzFYX8YrNSzb2rG4i+3PoNfx9ZDhZH/Ki8po35vZgmytSycUAzCS4pT9GFzIIc/nb7iI/oCZNqHDITKLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66556008)(38350700002)(316002)(83380400001)(66476007)(8676002)(4326008)(8936002)(26005)(66946007)(6512007)(53546011)(2616005)(508600001)(6506007)(6486002)(52116002)(186003)(6666004)(31686004)(86362001)(38100700002)(36756003)(2906002)(7416002)(44832011)(31696002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBEalVuVnpwYVN3UlVOOXpJcS8wVkZaL25zTDdhOFdsR3RoNEFiOTlENDIz?=
 =?utf-8?B?WGJYZzdsMWhuTkFTcXRkckYySm5oSks1K1h0dk16aEF6Yk9DUmNucjBLQkhI?=
 =?utf-8?B?Z0UxZUgwQzdFTlJpL0FWL28rVlgwZlZ3ei9oRVdQcm85cmVVUGdYYmVLeGxO?=
 =?utf-8?B?cngrM05aTG5qMExkdXNkKzUvUWhVaVRadFdaZEpMdFpaUUwvTzIvR3RKYUlO?=
 =?utf-8?B?ZEw5UnpZU1o2dXdkRUNTLzJuWXJyZUljeldiWmxsNWVBNnJraTZFTjVJdWxT?=
 =?utf-8?B?QmVWVXNFMGVXNGRZUDBySHRmZmswZ0lsZktLN0NndVBWek5TV3BPU21IWXlJ?=
 =?utf-8?B?Mk0vN3NlOXIzTWhoWGtIdU04aUUwOVNDQ1QxOXc2TmlCcVRtaStlUVV1dEJC?=
 =?utf-8?B?dVF2a0ZLN0U1SXdUN3lYVi9xWnlvUVBCdGtSUXRHUk81OFJnbWYxbUdJcG0y?=
 =?utf-8?B?aUo2TEU0MnhjbUIvWEV3bm12VnlwQ1RCZWF6WFJ4TnJLRkJQYzhRYkRhcDBY?=
 =?utf-8?B?QlFsQWp1NFdiNEJTNlp0RFBXaGp3K1NNWWF5MlF1OWFwQ01xRm91Tzg0Q001?=
 =?utf-8?B?dDRkNDd6UGpyZm5IVDdmNHJBcCtFQjlvL01QenAzY2J1YXU2WkhPYzIyV3E3?=
 =?utf-8?B?MUV3d2JFRlRaMXJUVURrV05SLy81cUIyQklsc2cyK1lHMW55VTBWOE5jbGRP?=
 =?utf-8?B?VDZaRGJpK3Jwand1Y2JMUEZMb2d0QVRETy9tOUNaR2xUdkFBczcyQXZsL01p?=
 =?utf-8?B?SXJGTWVRTStiRVJGamRZTUU1UFU4S0FnTHpuWFdjN1lyaW1iTE5MS1UvcFcw?=
 =?utf-8?B?R0hsZCtRYUpBY2tiM1dycGI1VmZrNzdoTmlWUnpHYmJUNkh1Zm5vY05lelV0?=
 =?utf-8?B?VEN3cmxMNjRtUlMyU010RW5uTTVQUUx2MGNhWTVJVTBlVXFrQ25BSWUxYU52?=
 =?utf-8?B?Z29vRHBWak5nZ3JBUUVDUE9sUi9CbkhDWVFOZWN6b2xseVBiWkxoV1gwTVVw?=
 =?utf-8?B?QTd2QUsrS3kwbitJS0ZIN3RuR2lHRmdzVDNzeFVPZWZWendyNHhYNm9qRi9a?=
 =?utf-8?B?NTBLMUdhRHdIQTV6dTNaR0FuR00xdWk1ZWk5TVdsSnlaWnIzSE16YmM0VWl1?=
 =?utf-8?B?WUhmdm9aQm5pTVZYLzFUV2dqU3BvYThtcFlUU3NnNk44MXFkNzZ5SVZWeWdM?=
 =?utf-8?B?cFd4Q29WcnFkcCtObEptdDVlZEZIVGNRNkc1aWFPOHdKZWdjTlc5U01UYVhK?=
 =?utf-8?B?RVIwcnZENkRjNE9rd1RUSUMyOW1vMlBRNXdLR3FUYlNPejlpR1FIQWg3d2c1?=
 =?utf-8?B?S1Y0bVRCQUVCSHZNUWlGMjhWS2lvNlFadElGTGZNbXd2d0VHY3Y3ZEZQU0Nw?=
 =?utf-8?B?OWxoRFJ5MTl6MmpjR0h4Ym1pVXBtekh6RHNzL2piTFFreEVSR1Q3TC9pRkRy?=
 =?utf-8?B?ZWtBTVhLVFhPYmFSSFFJYXRlT2V6WDdwNlB0UTZ5b2NJU0dCWjRCcElFVklv?=
 =?utf-8?B?SjhWQWFxNlNrK013aEtEL1VQT3FHclZaRUsrWWc3cVFELzVlTkJMb2lzQUpK?=
 =?utf-8?B?WWJZQXhYT0E5Zmx5Vk5mZmo4ZmNEem41US9MUkhiSjVWcXZIeHUvcjFGUzBj?=
 =?utf-8?B?SHRDQ0xTbFRDRnJQQXc2TFpESEtTSzFRamdVQnlHNlQ3MUhkUWJxYXVIQnJl?=
 =?utf-8?B?MFdNR0Q0aGsrM0F5OHFZemU3bHRwSWZOVXY2clJNTy9jMDZBYzVyWTY0K2E1?=
 =?utf-8?B?dlJYMGozVXJkWWk1TktxdXdXVjlLTVlncXFwRDBqT1g4M2hnWjgxa1dyOHFQ?=
 =?utf-8?B?OVJmVWs4VnkxWENIdk9FdEhsTWJiVzhER0RuNisxbEowTGZDQlBPdmhoMVV6?=
 =?utf-8?B?NTI4N1M1R1JicUxFRHJObnU3OEFJTmFFSm1wWDBkRFh6aEtzM293VzNTQ3pw?=
 =?utf-8?B?WWczYy9TVnRsRFA4MkplTnBLMXIyYmdraHVKenpkTXNsNC8yK0hSd0lMWFNi?=
 =?utf-8?B?YTJPNTRIaTZTK2xaRkpSY2J6S3o0KzZITkdHWEdGcjBGWmNZU2ZHcGZjTWcv?=
 =?utf-8?B?NGppL2htNFVlN2EwMGpxLzhEMXJ4elpjTy82a1BhbWhVK3dxNFU1d2NtU2ND?=
 =?utf-8?B?L213TWF2elk2TkFCYkJFSWd2RVNDdFUxTjNZeGRlUHpLK0dnQ0QxYWRabE9W?=
 =?utf-8?B?Zkk1Rk9UdklpOHEwSHhhbFEwYzdZbnh4UFliOTkybnpaY0N2c1cxUWV2aGU3?=
 =?utf-8?B?dXIyMFpqWDgxcGhuM3Boc3prTXh4UEVzeWtNODEwdERlNkpqaGljRXJZalFk?=
 =?utf-8?B?amxOTGNjUk42VmFKNldzVnlHL212RzA1M3FKcGJlWkEyMmZ4dHZYQlRwMjlZ?=
 =?utf-8?Q?zX56pQAYtODN0HXE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa92311a-5fbb-4582-6c45-08da33771c6e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 17:53:09.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c3VvQdbgLp4U/NCdy++LuSW8CBJg2SVPIzi2V8Dp6/stknKi2menaOcRvGIEi3/cKlRR7y7jN2V8xYjIEaMDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110079
X-Proofpoint-GUID: t1qaYPlqOHRx9CLncb1pYI0Mj1cjIEKW
X-Proofpoint-ORIG-GUID: t1qaYPlqOHRx9CLncb1pYI0Mj1cjIEKW
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 03:57, Muchun Song wrote:
> On Wed, May 11, 2022 at 05:45:57PM +0800, Muchun Song wrote:
>> On Tue, May 10, 2022 at 05:39:40PM -0700, Mike Kravetz wrote:
>>> On 5/10/22 14:30, Mike Kravetz wrote:
>>>> On 5/8/22 23:27, Muchun Song wrote:
>>>>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>>>>> index 029fb7e26504..917112661b5c 100644
>>>>> --- a/include/linux/memory_hotplug.h
>>>>> +++ b/include/linux/memory_hotplug.h
>>>>> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>>>>>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>>>>>  #endif /* CONFIG_MEMORY_HOTPLUG */
>>>>>  
>>>>> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
>>>>> +bool mhp_memmap_on_memory(void);
>>>>> +#else
>>>>> +static inline bool mhp_memmap_on_memory(void)
>>>>> +{
>>>>> +	return false;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 8605d7eb7f5c..86158eb9da70 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -1617,6 +1617,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>>>>>  
>>>>>  static inline void flush_free_hpage_work(struct hstate *h)
>>>>>  {
>>>>> +	if (!hugetlb_optimize_vmemmap_enabled())
>>>>> +		return;
>>>>> +
>>>>
>>>> Hi Muchun,
>>>>
>>>> In v9 I was suggesting that we may be able to eliminate the static_branch_inc/dec from the vmemmap free/alloc paths.  With this patch
>>>> I believe hugetlb_optimize_vmemmap_enabled() is really checking
>>>> 'has hugetlb vmemmap optimization been enabled' OR 'are there still vmemmap
>>>> optimized hugetlb pages in the system'.  That may be confusing.
>>>>
>>>
>>> Sorry, I forgot about the use of hugetlb_optimize_vmemmap_enabled in
>>> page_fixed_fake_head.  We need to know if there are any vmemmap optimized
>>> hugetlb pages in the system in this performance sensitive path.  So,
>>> static_branch_inc/dec is indeed a good idea.
>>>
>>
>> Agree.
>>
>>> Please disregard my attempt below at removing static_branch_inc/dec.
>>>
>>> I still find the name hugetlb_optimize_vmemmap_enabled a bit confusing as
>>> it tests two conditions (enabled and pages in use).
>>>
>>
>> Right. It tests two conditions.
>>
>>> You have already 'open coded' just the check for enabled in the routine
>>> hugetlb_vmemmap_free with:
>>>
>>> 	READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF
>>>
>>> How about having hugetlb_optimize_vmemmap_enabled() just check
>>> vmemmap_optimize_mode in a manner like above?  Then rename
>>
>> I'm wondering is it necessary to do this? vmemmap_optimize_mode
>> is a internal state in hugetlb_vmemmap.c, at leaset now there is
>> no outside users who care about this.  Open-coding may be not
>> an issue (I guess)?  If one day someone cares it, maybe it it
>> the time to do this and rename hugetlb_optimize_vmemmap_enabled()?
>> I'm not against doing this, just expressing some of my thoughts.
>> What do you think, Mike?
>>
>>> hugetlb_optimize_vmemmap_enabled to something like:
>>> hugetlb_optimized_vmemmap_possible().  Sorry, I can think if a great name.
>>>
>>
>> At least I cannot come up with an appropriate name.
>> hugetlb_optimize_vmemmap_may_enabled()? It's not easy to come
>> up with a good name.
>>
> 
> Instead of renaming, how about remove hugetlb_optimize_vmemmap_enabled()
> directly?  I found there are only two places (mm/memory_hotplug.c and
> arch/arm64/mm/flush.c) except include/linux/page-flags.h where use this
> helper.
> 
> In arch/arm64/mm/flush.c, we could replace it with
> 
>   if (PageHuge(page) && HPageVmemmapOptimized(compound_head(page)))
> 
> In mm/memory_hotplug.c, I have a plan to remove it as well (I'll
> post them out after this patch merged).
> 
> Finally, there is no outside users of it, we could remove it and squash
> it into page_fixed_fake_head(). What do you think this, Mike?

That sounds good.

Sorry for all the questions/suggestions around
hugetlb_optimize_vmemmap_enabled.  It just caused me a little confusion
as it is providing information on two conditions.  I wanted to prevent it
from causing confusion for others reading the code in the future.

This patch as written is fine with plans for a follow up to remove
hugetlb_optimize_vmemmap_enabled.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
