Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54E352F633
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbiETXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347860AbiETXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:32:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900A19FF4E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:32:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KIb5wa022587;
        Fri, 20 May 2022 23:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ftbm2cTPH8riRfPhDmPLDHQroM9uKS9P2upzCLrqRbg=;
 b=uuySMR8vQKSSroib50LLD4kdap+OEdHQfecojvEMDzfpN4jSxHyPvl5L2Tk88Pf6eB4C
 5x2vFWcrawXn91tQNEzOx61zpOoKxObpAVUbpsyvGP+2YmLgNLguSxEcnWa+Jch3IDFA
 IkvFFhlf/c8iw/4RFNRtvEGOxc4zcfcv+uajm5WE0A4Rj8xsiXTXNwCfI5YVap7x3k33
 hbVZx5VCCb4/Q06SbOT2+gv9IkEUupwjkDrP2jRBn89i9TGNAWZIxRhFquN7PqACmDlD
 T43yOX7xiHHl6SkBUau/fdJGoJzTafdkKGhDPE7SaAmi3Ko81lOD1ljTkhBWYbYuGz5R Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24yu0bde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 23:31:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24KNUANh040050;
        Fri, 20 May 2022 23:31:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v6suvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 23:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzpZ78dRmeDpPll+acOVOlgel1O2OVTKhW4dzEXGob6AVF7HOVEFwH15wiW7d8n7n3pJVLgfzgvxVva/OsA0G+nUqEkpxw9zVb1qcAI3AVWMHZd4lVtTBOAirFa3S+TVi+afWFgVrAuRznQkpOVDvsTvJ3MQmFKRc7UyzPSugk+FvDir7U/cgGQ8mZixJUp7UxCpZa4qSbZhWjhGEP/mQZ7UHBk+6Ihfx1oZfvUPJPTmeFiaUQBdYLpRhYsoRF3Gz+0R11dfcqV+NwkvDe3+JX4mDTqz9KywBfF5vIzTt3huAUAJdaNBvssfGdfPBfSTjnh292fYZKX+tTf3qjRj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftbm2cTPH8riRfPhDmPLDHQroM9uKS9P2upzCLrqRbg=;
 b=OE+uhTl8coIwtV3obNoM4zO6/feBR6qbJwK7+f6su6SL94jFGKCd7TmOiCkfifrHnPASELwqYaKPX+UpHyrs3PQkWY/GXd7Xttb9VXqGptHs2jarb5yCBjIAth0sB5UDy6ivfmqslxpYRJa4nRNOeI3key0Qo84MGUBtZlL22O8gIPwft2ijo142q0N+CSW0gbJYfX5EhN9CDH25+hXQ1DkCv/Sl+uMW+eVBHJxgwJPLXTLGmirzDnw2oWrBea3MrkY2rGgqvC472htbWIr+Qx6waRk24Gt0OyNqkyKF5o03Pp7B+M71z9r72UZLHuavjbHewjOLjl4GrFswuRzM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftbm2cTPH8riRfPhDmPLDHQroM9uKS9P2upzCLrqRbg=;
 b=k/ZyPtyYfATj0b7LyzutwsEaE+3kiY1EC/RTiMPnMK9LCp9KZmLjCn6RaEXrjj13uieXzdndJkLZE1gNb9D92urRaYr1tEKYOUyx/7uCmC1p6xGITHsuO9bj6mA2LHXm0BGgHE9yDxIhL1J2koH5akBg7SkQnnAKJGheTKkE2Mc=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by SN6PR10MB2895.namprd10.prod.outlook.com (2603:10b6:805:d9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 23:31:34 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5%4]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 23:31:34 +0000
Message-ID: <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
Date:   Fri, 20 May 2022 16:31:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
References: <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (2603:10b6:100::40)
 To DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36250663-d691-41bb-2076-08da3ab8e099
X-MS-TrafficTypeDiagnostic: SN6PR10MB2895:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB289591C24CA4EC4F25C28B5BE2D39@SN6PR10MB2895.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hp6J8DUsR4ELaQehuPTIPH/DkPlribCfTdzSK0obBLkmD78U2LZWOrkkUh2fsFS0TUGo7hJDEJevKWJCsWGYc8nRZW/sJVoraG8nAK4y5MsSg46HQK0Wy9c4dyMKqsDZzDWlmlNMLfLbiTEsABa8RtbUZXojx1hqfmqG0+GmL5iE4aJbmv6s7YKlKTTd4gFWQiOL3a9i7+C7nnvbJ4MyelH++8k1S7tB2SxHjdhYQ0cUsZlAz7AnxImIkGsj0zn/fD0IqVA6KeM/XutMdUtWl/lEdQhB8x9gx8gWC7Zuv8PftuhCr2PnewdVwYDwk92HkRNPAk+Ae91Z0igFzTWG+1OZXRedkW5DAK6DHt4givkZjNKhoKv6X28PFDtv7zabaUcNW/wkGDe2IkUmaP0egek357vOuV3uEgFggE4aHZI4PnqbJ6nwYNgz7s1DUbGlzoWIMiJBO+6Yveumqn0g4Rov7Q4vn3w638EBIObyQrSFXPT2kV8s+dOLqEeMRNfs4egsPmq1QRTpqImOH0lC3vdLggQ7OMJbvrNGbLFFKw66BXr9Q+iRQjLUccZpPs4ulF0FoS/KlOqJHLdFHOmV9tGxmV2SlvxymA4pgBGwwzVMxptlRMTgYb/Lci9Dsi1x+KDAZk6IAMr5Vty/tgryhTNUhdK/fX8mwhFoZV+knb8q7OPt4sk5A53vniAeV74KmlanMgTmcfi0r3kj+KvIlJhDh5tI+F1JKC4ULcfT3g79qne7ipASVbXpw/tsXm20hLl29cRCvqy1QuD+09UwLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2906002)(6666004)(54906003)(508600001)(2616005)(8936002)(316002)(110136005)(6486002)(186003)(5660300002)(52116002)(7416002)(44832011)(31686004)(38350700002)(38100700002)(6512007)(31696002)(26005)(66556008)(6506007)(53546011)(66946007)(83380400001)(8676002)(4326008)(66476007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTN2d3ZZcmRERTc2QUhud0Jnb2kvdVVQVklBV1BZeUFNQklRVThLS2U5R2Zo?=
 =?utf-8?B?ZzNnV3BDVkhwWGNqbGI1U3N6Um8ra21MOS9Hd2xtOXA5aU4rUnNKd1YwT1pu?=
 =?utf-8?B?anVSelJIMUoyQk9xMWJva0U4VGgvRDl6Uy9MQmdsSE9BZ2FmRHI4b1dyc0ll?=
 =?utf-8?B?YTRzUTd0QVA2Z09PUFZXUWdXaloyV2ZYdG5hUXZDQXhrWTVFTWNUSVM2OGJS?=
 =?utf-8?B?ZFJpbU1NbnJRZEFkR3lTeGZxK2JKRUFCeVZ6bFpodVpDQjhudVlmZjZTbkhi?=
 =?utf-8?B?aXZNNmZGL0h2MFMzcTNtakNFanRDenF0eXdJckFJeTI1MHh5bFpObjJ4WkNm?=
 =?utf-8?B?ck5hdVZDQlVNV2txMWRzdFBzOEZ4VlhIVEcyV1d1RW11aU1LeDloRVl5dmxN?=
 =?utf-8?B?ck1DZ2xBWnJQa0RQbEJIQ01uN2NBMUs5RjVyeGVzRklOdGp3UEpxRjZoSmdH?=
 =?utf-8?B?RDdVV1hIMm5PeWROaHBCSWFnL0ozNGhzWllHZ1pSZHJETzMzZmFZK283V1Vy?=
 =?utf-8?B?blB2K08wY3NSV2pFek9VeWdnVmljSkozdGZYUXgzU1hJeWRLRkVDMGt4ODhu?=
 =?utf-8?B?ZFYySTdXREtYc2tLVStPTUErM1VTbG9hRUlWbzMyRFJSMHB4T1ljUUVTL0k5?=
 =?utf-8?B?dk9kSTFIQjM3dStpUkZRby85YlR5eGM3NWdsOFg3Z242bmJMMFV6UDRFQ29N?=
 =?utf-8?B?akpST2JtVzNPVHZNNjY3UkxWRW1PakxiZE1mWDFMbFdkeDNFamZRWFhvNjZL?=
 =?utf-8?B?ZXorWnMzWU9YYXpBWWJPQmIxb0puVXBxSXRKM2dubnBweTk1THQ0Q29obnpq?=
 =?utf-8?B?NEJzUXhveEhzOXpLTzQ2UUJiYmJ3MU9iZlFRWTFwclhxaWI3S0thdnlmSzZx?=
 =?utf-8?B?ckozcWZiRGF5MVhJTVpQa2M3bzgvZXFITHFBUkwwVUJwUC9DbDJxRU1Layt5?=
 =?utf-8?B?OXd3MkdJNzFXbDdaUmFCbHdKcUxxVE82cklZdXZwWHNjZ28rWmZKakxaR001?=
 =?utf-8?B?cVJ5eGpzcEw1RHk0Mkw4L2wrQ1VJYjNvczhMRzhmZmVkeFBxSHlLVC9ubjN6?=
 =?utf-8?B?bUhFS0tHSitSb1UwU0F6REhkOUpScytJWmRTcEI0Z1R2RTc1dXVzZkF1SHJ1?=
 =?utf-8?B?eUxiQlYydEQ2WEtsZnI1VUYwNGZ5OHIySDB5QVlobDlScm92Ym9PYzA4WnUx?=
 =?utf-8?B?TmxqemNCcmpKR1ZJd0dHRGNVQ0FjSFJnWFRsdWxBYlZERktFNm9tV1lxUkpJ?=
 =?utf-8?B?ZERSYmhDUlY4bnRVNlgrTVI5R1ZQV2l2aGN0NnphMTZ3RldmWWV2TWV3b09B?=
 =?utf-8?B?QUJ5S0tHa3BaWW52OTRrWjlkdms3cVZDWGY5ZnN0S0dacnJ6NW9GUDlETE1n?=
 =?utf-8?B?VnJLWE5Od3o0V0k0ZmJmSU4rejFsREsxZklHMm1hVWcrbU5LZUx5RUN0ekRH?=
 =?utf-8?B?dG5ZcUU2UWFQK25BMG9HMTZaU2RyTHJGbTZOM0lwQVNVSnJGWHNBZDNOOTg2?=
 =?utf-8?B?WWt3QjlVU1VnSFNmWHdTamx2QVQ2K1IyUXdxbGcrbEVDcTRjVkZjVkhEMlFl?=
 =?utf-8?B?bFNic1Z6MHR6d3F2SUlxMXUxVjd5VFMyWUxJSGx5UUFuOTJwMitSSjRZOFA1?=
 =?utf-8?B?MFRRaUd4ekMyNm0vcVAxb3krQ0xqK05UcjRMSVdDVW1DQStRK1h5ZFJodU1Z?=
 =?utf-8?B?Ykp6b21xUktVZ1grZ2VJWUtKb0NEMHgzYk9zNDFXT0QzbjU0RkNVdmhHaHQ0?=
 =?utf-8?B?bzk1cjZUK2xPV0ZITTg2Qm9EM01HcmprNXRpNWRPaGNHeDF4REtzbnR2eVlz?=
 =?utf-8?B?NUtiVzN4MTVzam4yZDA1d1VFYnlpK21uYUQvVzRENDdxTFdJYjluT1pjcVFk?=
 =?utf-8?B?SVY3eDMxZ3c2Y0ZMNTgyajNmL0lXbHQ0OE9xLzVQc3B5clo4ZG44cjBvaFVn?=
 =?utf-8?B?Rm8vR1VoUkNMaDFrN1Z5bHp2MjdxTEFJYnBUOURaZDZ5Z3RaN3dLZ1hEQzZD?=
 =?utf-8?B?Q29JenA4RlBYQk45cTZONUJIbXRBbE5EYi9Qc2Q3UlVjNWFCV1RJQ3FzYkg0?=
 =?utf-8?B?SjAvWFpBeVpQYlRVbkNnOWZtdXNzeFU3T3F6amsyTWhGaTRxYm5ZOG01S0Vj?=
 =?utf-8?B?Q2JBRWZPU1RrdTZvZkpaM2xtTXJoamIvVzhyRW1WMWl0dnphYW1yZzc2WWRD?=
 =?utf-8?B?dzRyQUJiTGVmUzRVWnN1Q2dhVTRmamxtV3NPR05FTHR2bFNsZVk4eUVSSkdY?=
 =?utf-8?B?RnFMcGwvWU1RYURQb09IRnMzQW5uRWVYY0kyYzhYdGpEb2Nrd0xnS1J5UFAz?=
 =?utf-8?B?MFlnMXM4K3owSEh0eGQxQmhnSDBCZzFSRHFyQ2tZOWwvWHNIUHN3M3doVW1j?=
 =?utf-8?Q?gZMeMZx4JPlhi9hQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36250663-d691-41bb-2076-08da3ab8e099
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 23:31:34.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE6xf/Ztjoj+3c3/Z1PF8tf1YdbzTbZvzzG6NYJVCPctRA0T5RnWlivjGfCpli3RATZhXuyfwfcIiyefVbKjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2895
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_08:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205200144
X-Proofpoint-GUID: JRKXwnVuCoKHZzsX8C-36vQJoajl0-Iw
X-Proofpoint-ORIG-GUID: JRKXwnVuCoKHZzsX8C-36vQJoajl0-Iw
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 15:56, John Hubbard wrote:
> On 5/20/22 15:19, Minchan Kim wrote:
>> The memory offline would be an issue so we shouldn't allow pinning of any
>> pages in *movable zone*.
>>
>> Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
>> problem to allow pinning on those area. The matter is what target range
>> on alloc_contig_range is backed by CMA or movable zone and usecases.
>>
>> IOW, movable zone should be never allowed. But CMA case, if pages
>> are used by normal process memory instead of hugeTLB, we shouldn't
>> allow longterm pinning since someone can claim those memory suddenly.
>> However, we are fine to allow longterm pinning if the CMA memory
>> already claimed and mapped at userspace(hugeTLB case IIUC).
>>
> 
> From Mike's comments and yours, plus a rather quick reading of some
> CMA-related code in mm/hugetlb.c (free_gigantic_page(), alloc_gigantic_pages()), the following seems true:
> 
> a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()
> 
> b) while hugetlbfs is using those CMA-allocated pages, it is debatable
> whether those pages should be allowed to be long term pinned. That's
> because there are two cases:
> 
>     Case 1: pages are longterm pinned, then released, all while
>             owned by hugetlbfs. No problem.
> 
>     Case 2: pages are longterm pinned, but then hugetlbfs releases the
>             pages entirely (via unmounting hugetlbfs, I presume). In
>             this case, we now have CMA page that are long-term pinned,
>             and that's the state we want to avoid.

I do not think case 2 can happen.  A hugetlb page can only be changed back
to 'normal' (buddy) pages when ref count goes to zero.

It should also be noted that hugetlb code sets up the CMA area from which
hugetlb pages can be allocated.  This area is never unreserved/freed.

I do not think there is a reason to disallow long term pinning of hugetlb
pages allocated from THE hugetlb CMA area.

But, I wonder if it is possible for hugetlb pages to be allocated from
another (non-hugetlb) area.  For example if someone sets up a huge CMA area
and hugetlb allocations spill over into that area.  If this is possible
(still need to research), then we would not want to long term pin such
hugetlb pages.  We can check this in the hugetlb code to determine if
long term pinning is allowed.  

> 
> The reason it is debatable is that hugetlbfs is intended to be used
> long term, itself. The expected use cases do not normally include a
> lot of short term mounting and unmounting.
> 
> And whichever way that debate goes, we need to allow it to be
> fixable, by not tying "is pinnable" to "using gup/pup". The caller
> has the context that is needed to make that policy decision, but
> gup/pup does not.
> 
> At this point, I think it's time to fix up the problems and restore
> previous behavior, by choosing Case 1 behavior for now. And also
> lifting the is_pinnable_page() checks up a level, as noted in my
> other thread.  I can do that, unless someone sees a flaw in the
> reasoning.

Go for it.

-- 
Mike Kravetz
