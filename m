Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404234FC648
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349996AbiDKVGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiDKVGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:06:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54122B1C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:04:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BK1i3c018418;
        Mon, 11 Apr 2022 21:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+LpETvYRLbAOAJhHOuijHpE9LWLZOTbSCnWuIyKEPek=;
 b=dHU6r2zQ5DKjYXnv+Vffb7hIWJH6ROfd6Ii2pvcnOF4PrsULvlsRnoKhJS2AFbaHnVyL
 W+VI22zEAbevob2kHvkJMDQ0scv7760ZYQm1U9NCrzh3WJ6mrt8aufYU6NbPO91kzMM5
 ecIzOgyRUA9UErdbF64JsRSAfxv4FuIwXlGcfAkiuKOGlta1zoLEUxhzdK8T7RKPKLK4
 uMkA7kwPu8Pa2QdQHdbmnQx1uv72Nw4gzjpj2ySoGPpdqg5IGklTbcizCibVC21FC8+k
 Pu2JC/TgpX7LHOUkwQz/15R3u4kVPNoVsUaYx74D8bj0gahCoMCm8Bo3a8tPFPSe6s4X UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1d16n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 21:03:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BL1GdR004816;
        Mon, 11 Apr 2022 21:03:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2fer5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 21:03:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS3gKAuIH8iRQv3HU8IK895XGMCpATRBIjl6iEmOR/oID9B6gENaTG+cCi61vuIa+E35UIl2MVzaeAeEYUK0UetOMP5TS1wdez8DSWoVhrGYEEANowj+bSYY6xEa3QJkS6wHVjctixBlZBZ86KkvHWwwq+eXJrhyG8/OnaybWuzLE8dSVzPSn0Kw483PgBtfw+h320yLpujGqigDZ0Owg9d6ZMuXtAFRWxkuseKjbPKZNUTdVTqtpE50kDX549dNgtgIP7oMbSn6pqJ4gQjrv3IIw30O3FyHum2KQ+35d4i7V+swkrnhy8nfeyZWR5WsOXU1ChQJz55jyR3syBKw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LpETvYRLbAOAJhHOuijHpE9LWLZOTbSCnWuIyKEPek=;
 b=UfHT9azN9TvcWQUZFVf5FKWszQOUP0yyv9AzWe7vxuMmjoq/CimbgMiPhiLQKOfcA52tb7ibicGOvRTRg6bW29UMb7EoqAyDl6ZKwwOo+mxBwII9uVnG7T2B5FGSFvKS8OZMMY3ycNBkqVIA2hxgnEFNphmqELgvRiPU2P3xWHE5ckFkbCPRQc8vHaK1VlM4LCebgfAWTqKy5Lr8pGfcvvMShVTPrxwWrmBzjlt2cygXQY/aVM5yIm1Ee/8qTYJ6uGYuzLctIGurk0aK6yotJY1EsyvOSxJtli/xD0Aol44ro71c8GPJbAjeqJJdHWHA1n343pOSjkVoaTw8EAROeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LpETvYRLbAOAJhHOuijHpE9LWLZOTbSCnWuIyKEPek=;
 b=igHDZCUXm6D9he0JNQi+OydoMolYY4W8mAbhIZsAir4HG7dN+8e+DcfK3I1ovbcYRpXHB8qALB44RmZXr6kYFwbaZFYDSGVS9EurhhZWjP1g7IF8XSl04WijKsNN904bLUD6MG47j8dmCX5XiveGHXufEb7yhvVD/JwMV6UwtI8=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by SN6PR10MB2976.namprd10.prod.outlook.com (2603:10b6:805:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 21:03:50 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 21:03:50 +0000
Message-ID: <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
Date:   Mon, 11 Apr 2022 16:03:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        chenguanyou <chenguanyou9338@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16)
 To CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f24d91a9-2ff3-4b28-83b6-08da1bfec72f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2976:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB297632604A3110C09D662477C7EA9@SN6PR10MB2976.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krAbjnTd36OykCYJWzCRk/J7TLfZFdIujw3JHOqN5l9LIsL2IiA+lCc2TusNYqRflPee9O4OI8M26l0IcJfQvRtpIzChK67kGAiLoyytIy1yAg8qC+yu0qvq+/tKvSaSvr1zTIOs3Lmu58OkAhJNffFr8/9yQ5Mvw+JqAiX4halx6FtvwctNHNFI+xoA+TqQaocij2Mnoa4E1ZN+miqGnKahZ1muYbu/+TxRLJBw4FVGcqglh7/t2r6c1m8Ur6LXvU1JeKwGSuzaVHTADUwudZn+04TRveAg3AOic0QOefA4WmVDX9j3IaOK7gsmqf6btBfDNUtPA3Uj+LABDxRiNqq53rY5slZBN/akBSIPFcNCdGnW+Lhjoc1HHMI4AvAbjhqpMh6N+LpQ46FjtOXe+6gqSlPSjZ67p5tuLGgUHUpIEO1JHalg+RFjD/3yM9GFNRVRltXQYIiQHcbDMRNstCOmyVuwV2PzuzK/r8fb1I7WmPmvH0brxjkRFM0PRhjxKcsn/ocvDkuEiMZRxf/dZ6Zkk70g3mcpLAVGUPsaygjPC+RGkSlQ8zIbPsawqFvU68HynxeRyQuAOlJ6QbfiooEZDa/2Vd+rq/xvHlCTKer5iaTRQ9MD1RO+zrEPZ95UoN1JlUEVKcUM7zSB2kOE8H3clm31p/HjqZY4AKjn0swmcSwZ4F4ZjOF9FaZIaeyuKLWT3QECJ0poYzE4R1vNIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(83380400001)(86362001)(31686004)(26005)(31696002)(107886003)(2906002)(8936002)(36756003)(6512007)(6506007)(9686003)(6666004)(53546011)(316002)(7416002)(5660300002)(6486002)(4326008)(66946007)(38100700002)(66476007)(66556008)(110136005)(508600001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2g5bnlYWU4xWDN2N0pHRWNqUVhySm96N1BRWlNrRFk1VVBBZGE2TW9QUG13?=
 =?utf-8?B?clZzRkJkVTY0UWNlOXNkZlFDVENGbFpmOE9GeDl4T0V3TlVJV2dZRHdvQ21o?=
 =?utf-8?B?NVk3QjBKb1VpV09lUXIvNVNJUFlOQzM0eEIwOTJ4U25OYmgwOUtxR2hBeVVH?=
 =?utf-8?B?K0lueGVuMjhOSWd2emlXOUR4cTNIdG13bmRIMWRnRW5KSEE1eEwrSFdhL2NW?=
 =?utf-8?B?MDVOQ1lXZlh6NTJvV0hrT21NNTB6QThoTENhYXpJTi9zVmJUNm1UdkY3NDNz?=
 =?utf-8?B?OVpCbHV5aFVoS1BaM0RZTDFWR2NXTFlzQUZnS2lpOWREOE5ENUJUNlBYcXhB?=
 =?utf-8?B?bVkxbTlNTVE4SkM4NmNBbVlQMTdhUXdlSFJ0TUw2ZmdFS3Q4NnBjaEpVNmMv?=
 =?utf-8?B?eHlUK1pFclAwekN0RmVPeFZLZVVrd3dQOUxwdEJwRnh6MXprcERsVVgwTWVO?=
 =?utf-8?B?NUFIbFFPM2xVeklIOUxDVmJkRnI4UCtiVnRMS1JtZXRoZ3FqaTNBVU15RGhK?=
 =?utf-8?B?VHBtZ1JWWWFxY0hHWG54T2NSU0gzcHFyOFh0MFQ5TmV5ajY5Vkxnc1c5NnNM?=
 =?utf-8?B?QmFxQXp2dWVnTktydWxlbjk3TGlqbVZvVE1DTUNzZ2RiYk5Kb1Y5cGYra2w2?=
 =?utf-8?B?SnBzU0wrL1FlS0hvWlJCMngwR0t5RURHY3pXNk9adGxsZ2g1aDhENWRLUmpV?=
 =?utf-8?B?OElSVVpGQy9kMnNKS2Qvdm0xdERCT2ZPclNFR2FIQmw0aThyekl3bnQrWExZ?=
 =?utf-8?B?aFMvbDdjM3FuRm5VaFhYYnFjQm9jTE1hbDFBVmV4RGNZMHVMakJnY1Z6eDRK?=
 =?utf-8?B?dTNUcTkxaExLMStYZjh4VERBU0d1S0ptaUxUcDBJeXRKRVJjYU5Wemphdi9q?=
 =?utf-8?B?TmVJTTBndjdxMm5OVkZKZXk3aDNDUU5BVThOR1BxRkl5LytHT1gwemh5WGxQ?=
 =?utf-8?B?anJ4YWtFWXBTWVJuWkt4Y1loNStEK0p6U3hCMG4yOVFqMjNCUGN4dm41aDI0?=
 =?utf-8?B?Rkk0WEh2bDlhMWpEcnd1YWs0RVhTSTJsRmxxL093TTZZVkdnK0x2c1ZiSU9n?=
 =?utf-8?B?bE5CRWRiQUhvNWw5ZWhpQjc1WFdHRmszQUgwOHFRb0VDYnNGcmliRnQyUjVs?=
 =?utf-8?B?UWY3b1dRc2IvRVBYUDhvM2NyTi9FY3NTbnZ3aVlKSW5RaUJUQldIc0xXaXZ1?=
 =?utf-8?B?SmcrZlNaZ0hPeHlxaTJSdGFETCtEZHZWQzdkSjl5QzBSQ2VkOW12OHkwYVdh?=
 =?utf-8?B?M0wxVmhJWEdHb2NKc0plenBrcS9vZmJhS2FrZVpkYUFmUEFRUGJ5QXdGRUZR?=
 =?utf-8?B?MGpPdDRtaXJnV0pUMkZOalprclp0ZXFYVFNDNzc4ajF6c1htcyttRzkzZTlJ?=
 =?utf-8?B?NHY2bzBaYkFwa3lzeFRmNHNiZ0xvNVJ5SC9kTmVHcWtJY3pxRXcxektCRENt?=
 =?utf-8?B?eDRJOWRyRFpPaEFJUVhZS0M4aEZFR2hSOVhiNks0bENHamJkRFNXUHlHT3hj?=
 =?utf-8?B?bGtGZjdFQkJZMWxUNlhWWSt2NXZydEVkcXV6eFhudzlEVnhtOUtCcjlwRk5t?=
 =?utf-8?B?RmxMbXNiZGR6b3FwQjZzZDJtaENhTHNjUTNjUG5wOXFFdUlwT3Q4K0YxVWpY?=
 =?utf-8?B?Q2hxNGRxSEpvbGxiSTlOYW5rdW1yU0Z3VVEwM2NKa0haQkw2eFdlK0kzTW5V?=
 =?utf-8?B?UVdxam9VQVdjRE5Tc09uZDRYQ0ZtL2FNZytKTHEzZUwzY1JCcWlURXhRbXB0?=
 =?utf-8?B?ZGk0YWx2aHA5ZWZYSGltVTdvREtrYWYvV0oxZkN5SGxXS3Y1bzRNVy9SWXRv?=
 =?utf-8?B?OTNaRjdwajlHUWFUbmxka01tWXRib2ZQS2xPY2NJeVdUcXBCazlQSWtFeDQy?=
 =?utf-8?B?dGp0cU16SUxpZjhPak1rMmN1akNRMFNuZ1UvMEk0THdwMmhNSVFQenBaSEM3?=
 =?utf-8?B?dVdPc3UwU3h6bUZuQktjeDhqZ0crMzlQOVl0czM0bDkxcWFlNkxVb2I2SHpl?=
 =?utf-8?B?WGJtbzlrN2ZGOE5mbU1lc0dDWlRpTlVnR01WOGhCTFM1ZWR6OUZRd1htQW5R?=
 =?utf-8?B?cGdxTEZNMlF3N2x3K0M4VGdObTZvOTg3aG9FZXdNZitIbkF6ZmJ0ZzJvWmEv?=
 =?utf-8?B?UjBaK3dKQ0VJMTE5ejNlUWc0TFhCN3ZhUWhYSFhvM0FmaDEwVmt6UVN6OXBR?=
 =?utf-8?B?cWltR0Z5Mk1zRGRkdU85c25KbWNuT1lPZzhnT2NJK25jdXNYQmlzS3E1dE9M?=
 =?utf-8?B?NlJob1V4djhrTGpVbEpudGtONW5mUUFWcWt2cTlZQlRBdmZ1d1FtQlNvdU8x?=
 =?utf-8?B?M0U1OEtaQWt0YW9aTElHUzZsRHRWekNCNnpPQUg2bFZ2TkhxSlg5Z0FMMk9E?=
 =?utf-8?Q?Gn1BsocpGIaCIzPI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24d91a9-2ff3-4b28-83b6-08da1bfec72f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 21:03:50.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcelX3jxfFDN045gruLrZ2dACptl396b4YXHtueSzxP2ZSdRB1JVqdtcjlyp24kTEwcFJInw++LhoR5T3dZTikO7hj3I2IQmIvfJUCVfIuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2976
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_08:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110115
X-Proofpoint-GUID: Bjm88792_mTdaFPZ5f8WPS2DgREGhbJL
X-Proofpoint-ORIG-GUID: Bjm88792_mTdaFPZ5f8WPS2DgREGhbJL
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 1:40 PM, Waiman Long wrote:
> On 4/11/22 14:26, john.p.donnelly@oracle.com wrote:
>> On 2/14/22 9:47 AM, chenguanyou wrote:
>>> Hi Waiman, Greg,
>>> This patch has been merged in branch linux-5.16.y.
>>> Can we take it to the linux-5.10.y LTS version?
>>>
>>> thanks,
>>
>> Hi,
>>
>> As a FYI:
>>
>> We have observed that following lockup with this commit added to 
>> 5.15.LTS:
>>
>> d257cc8cb8d5 - locking/rwsem: Make handoff bit handling more 
>> consistent (4 months ago) <Waiman Long>
>>
>> The "fio" test suit fails with LVM devices composed of four NVME 
>> devices with these observed lockup, panic.
>>
>>
>>
>> ext4:
>>
>> PID: 3682   TASK: ffff8f489ae34bc0  CPU: 2   COMMAND: "dio/dm-0"
>>  #0 [fffffe0000083e50] crash_nmi_callback at ffffffff828772b3
>>  #1 [fffffe0000083e58] nmi_handle at ffffffff82840778
>>  #2 [fffffe0000083ea0] default_do_nmi at ffffffff8337a1e2
>>  #3 [fffffe0000083ec8] exc_nmi at ffffffff8337a48d
>>  #4 [fffffe0000083ef0] end_repeat_nmi at ffffffff8340153b
>>     [exception RIP: _raw_spin_lock_irq+23]
>>     RIP: ffffffff8338b2e7  RSP: ffff9c4409b47c78  RFLAGS: 00000046
>>     RAX: 0000000000000000  RBX: ffff8f489ae34bc0  RCX: 0000000000000000
>>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff8f47f7b90104
>>     RBP: ffff9c4409b47d20   R8: 0000000000000000   R9: 0000000000000000
>>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff8f47f7b90104
>>     R13: ffff9c4409b47cb0  R14: ffff8f47f7b900f0  R15: 0000000000000000
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>     <NMI exception stack> ---
>>  #5 [ffff9c4409b47c78] _raw_spin_lock_irq at ffffffff8338b2e7
>>  #6 [ffff9c4409b47c78] rwsem_down_write_slowpath at ffffffff82925be9
>>  #7 [ffff9c4409b47d28] ext4_map_blocks at ffffffffc11c26dc [ext4]
>>  #8 [ffff9c4409b47d98] ext4_convert_unwritten_extents at
>> ffffffffc11ad9e0 [ext4]
>>  #9 [ffff9c4409b47df0] ext4_dio_write_end_io at ffffffffc11b22aa [ext4]
>>
>> xfs:
>>
>> PID: 3719   TASK: ffff9f81d2d74bc0  CPU: 37  COMMAND: "dio/dm-0"
>>  #0 [fffffe0000894e50] crash_nmi_callback at ffffffffad6772b3
>>  #1 [fffffe0000894e58] nmi_handle at ffffffffad640778
>>  #2 [fffffe0000894ea0] default_do_nmi at ffffffffae17a1e2
>>  #3 [fffffe0000894ec8] exc_nmi at ffffffffae17a48d
>>  #4 [fffffe0000894ef0] end_repeat_nmi at ffffffffae20153b
>>     [exception RIP: _raw_spin_lock_irq+23]
>>     RIP: ffffffffae18b2e7  RSP: ffffbb7ec9637c48  RFLAGS: 00000046
>>     RAX: 0000000000000000  RBX: ffff9f81d2d74bc0  RCX: 0000000000000000
>>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff9f81c04a918c
>>     RBP: ffffbb7ec9637ce8   R8: 0000000000000000   R9: 0000000000000000
>>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff9f81c04a918c
>>     R13: ffffbb7ec9637c80  R14: ffff9f81c04a9178  R15: 0000000000000000
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>     <NMI exception stack> ---
>>  #5 [ffffbb7ec9637c48] _raw_spin_lock_irq at ffffffffae18b2e7
>>  #6 [ffffbb7ec9637c48] rwsem_down_write_slowpath at ffffffffad725be9
>>  #7 [ffffbb7ec9637cf0] xfs_trans_alloc_inode at ffffffffc074f2bd [xfs]
>>  #8 [ffffbb7ec9637d50] xfs_iomap_write_unwritten at ffffffffc073ad15
>> [xfs]
>>  #9 [ffffbb7ec9637dd0] xfs_dio_write_end_io at ffffffffc072db62 [xfs]
>>
>>
>> I have reached out to Waiman and he suggested this for our next test 
>> pass:
>>
>>
>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock 
>> path
> 
> Does this commit help to avoid the lockup problem?
> 
> Commit 1ee326196c6658 fixes a potential missed wakeup problem when a 
> reader first in the wait queue is interrupted out without acquiring the 
> lock. It is actually not a fix for commit d257cc8cb8d5. However, this 
> commit changes the out_nolock path behavior of writers by leaving the 
> handoff bit set when the wait queue isn't empty. That likely makes the 
> missed wakeup problem easier to reproduce.
> 
> Cheers,
> Longman
> 

Hi,


We are testing now

ETA for fio soak test completion is  ~15hr from now.

I wanted to share the stack traces for future reference + occurrences.


Cheers.

JD



...

