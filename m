Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABE563694
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiGAPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiGAPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:06:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180923891
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:06:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261DOV0U012699;
        Fri, 1 Jul 2022 15:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y4XY+oEl4DCXsoG13N/n3i3GaJcwKTYpHmQo4+/LRqY=;
 b=QUddflgm/M+fyKzLqJAEyE2pcjfWEfbIw7P7P655RApjMoo6JH+mVtZubQkAwtBu7TlT
 5B6dexBL+Bj9DeK5EVlRFgnZZbvfbJODToFd+vFmW5iBrSSwi0jBfvsA192IKK5NPgYV
 IZ/RLEghgl6dBsyEQii1o/fHd9gFZ4mhVmkB2H4OHL9hTmjrm/4Y3Zs0D0Uso0o/SH3e
 nhjY4hpYUPwnc8vJJNmSLUNoUPh2ln3pLHdLeiPfiI7gOBFY4KnGhjXn/THUGkfKU2x/
 S6gVJIIksijovqEmyGiK76zy1aHchZpFhVku6eIsby9RcEg8VC1PjTW7yu7/Yf52c8WE 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwufjma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:06:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261F0Ugl017857;
        Fri, 1 Jul 2022 15:06:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt51bhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi/fdnlqhu0xyWJx/Vv2EbJJl+mK+fp6JMH5TAeidjCuPLznnnnLkZmdcA1BmFrpe5JZKzGM/yUHb5IMqe2ivEuPBUMqfDj3h+EIFBFzkgoV6wn8vaxZ1y2nYggk4hprCQd13PlpUK9QrO1+P1seHrrVbcdWNjyLfxHyV8TAX/DGb5xjKT9/TEJHCYPs4OeQB7dAo6AT/Gxf+m4GFwl+ZkOqdbWJ/DKALT8ALPmx1LUvF5ZIdYXLNbZe/SHcotSctt1FRlon1UAlRx1fnjlNTUSVuaaMkpN7rHlpUS+LzApMqhqxke4bSS/4z6Fkc4KLrQljAhZ3/YU0LuKk3qRuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4XY+oEl4DCXsoG13N/n3i3GaJcwKTYpHmQo4+/LRqY=;
 b=CYNlF37zPaZuUN1NVGTBF2R+ITu1K0SA6RR7uCc2lPcNf9Ebr2tyA4TepqaMteFg9S/E7M97OeVXmumWAm0d0Zs+KRsuREatx5bKv0GrctVprmUQ8Jqz4YyzMRdz06Izk/NJnGeu97tc1Bmj5jITPzdQ+FxSDOTREsBIzWGHIrSywvcg3QTWMvLld7kHo81Zz9zSayds5mXNsHBDa8HHZ5/s821wSHsOraMFI8UDSqe8amCxg/QmUgTKxLAcm+37OCkFY/GSuqzR4SJjd0fEIPXIaY9mspSaf5NcBiCuyWG3Jzn2LixG3zaeqb00AecPth98/ivQ7pBkxww+u04k7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4XY+oEl4DCXsoG13N/n3i3GaJcwKTYpHmQo4+/LRqY=;
 b=thX0YHkJItObaC9XCcdpL3P85YOGTR+wqf23lx1CjfXrsRqF1rf18q9jsMHfy4vE2DiFVQkf6eaB73cfN94JVC+MGDNoUGmcLhj5/viAGYlabdyd4apOqYSY3qEAD6EQQsEAK5006IpBI141rTetEPhOnTqgx6/HpiRRERKx2SM=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DS0PR10MB6223.namprd10.prod.outlook.com (2603:10b6:8:d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 15:06:12 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 15:06:12 +0000
Message-ID: <ab856471-99f5-b70a-cf4e-5293a7d52957@oracle.com>
Date:   Sat, 2 Jul 2022 01:06:03 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/4] kernfs: Change kernfs_notify_list to llist.
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, tj@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
 <20220615021059.862643-3-imran.f.khan@oracle.com>
 <CGME20220701112210eucas1p2d2db45881086f41b73527f7536537aa5@eucas1p2.samsung.com>
 <270b640d-d5e8-b775-9a16-5d5d07f959ff@samsung.com>
 <9e95f138-9ec5-90fc-7ea9-cf8cff8bf180@oracle.com>
 <ad06d3c3-7878-9106-e118-f89e2de91a1f@samsung.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <ad06d3c3-7878-9106-e118-f89e2de91a1f@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0194.ausprd01.prod.outlook.com
 (2603:10c6:10:16::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb95b08f-4cc9-40e3-ec06-08da5b733cb8
X-MS-TrafficTypeDiagnostic: DS0PR10MB6223:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RP5uZnfqaLnFEjd2AS08vZOIrMPFTnDGYiJjs3uP2QtK2biNydOsnuTx/8ZDsGi1FxScm/K0nBkNKnnfwKnhiiBG5X0OXM53esI/w26AzEtOr5Nra5MUDKtjE28zvXCIJKt39mIGjP7wmM+b2VCn8/vEWPcpr3xHBljLJgVMN0bsRS5WQ94SmSmhiROMNWomu1HnUFwn63lozK21Mn5U0P8SjBV0/urFnXeAxYPMAxYgmDNE6yCUH9CoXU6PCiaVjPOMsG3Dsa5hT+okAVEwGU11m9Ba2TvmJqDL/pmjOz9qo/Ntjua3Ltely3xSUQGH8xhS30cY6OxrD3DNqq/aOBQsXhDr3XBqPiY9lCb687x9MkVYsuf3+SnTlT2Iy2ddyqKDhxXV3/712IeZrYVrlbwIUZx/4IxYFoRF/E/iLOZHOil0Imjai1TvrTxpF8dZTlc5UZO1/52wW38EblOwXeWU+gFeEbdFdQldroGPKiTAuhRKYb08mnaIJqAmMf/Tq6v8d/xU/eOpuS1zDJV3eqfyPiSN2AdPuUprN7hVdyl393gQfi0i6JzziwfgIX1Tr97JAqrfwCInZY99H9Vuai9bccmTGTgaeFqQuSX6YMV5f9viD43QnvsREi7oneGh4s9m5GkcFaYciSdzVbkhiIl/ViJIWIYOMCfVYiriyxT5EFqRIY2vEyI4JrrEATASYYEH4e9mPTeqLzxavzDPVI5F/IQnJyM1xcLqVUE70g6ALX68tTVYtgQTITHLPIRPzAAXqaAajWHlR/RIzGJ4UciMFTqL88+VGnpql3fdr6Z6ejufg81s5oMZkODiwa9n3rlb2iVXRy/duAX99SR7Jebca/9+Ub279q425u9Lm2KqO1t+uNu+sfnbdN/S9I3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(346002)(136003)(66946007)(66476007)(8676002)(4326008)(66556008)(8936002)(5660300002)(83380400001)(31696002)(53546011)(2906002)(6512007)(26005)(966005)(86362001)(6486002)(6506007)(6666004)(478600001)(38100700002)(36756003)(186003)(2616005)(316002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRzaEdXS2xuTi9xMmpCdy9pWHdBckNLSXZJNEVvMXpSclh0cllZTloxSWcx?=
 =?utf-8?B?UCtQN2xoUmZmSU9nbkt2eTZsM29QQkJSMWJERWtzL3BJWndhNUwxdEc1WUd3?=
 =?utf-8?B?WFdlZTgxbXN4VlVGblZNOTBVQTBRSy81dHZTbUFDaUxFK3ByZTZrQnlGVGt0?=
 =?utf-8?B?NmdKQStGM0NCdmZpTHlpbkdXN0VMUkFWcDQ0aE9ueWtCdzl2YjJmSjc1b08v?=
 =?utf-8?B?WlgwdUdwVWplMEdmSXFtVXZsVXpwdnJqQW1RN2UrbW1IUzRMeXVQOGhWZTQy?=
 =?utf-8?B?aU45aEdHU2MxaE8xTHpMa1YvZWRvaUhCKzdJVUJ3Zm1wRkV6QkhTNjhieWZy?=
 =?utf-8?B?dEFrUStsb1pTUm1FSmRBdHJlRmdxUnJSNnhyL2t5RGFpenhZVUxBZHpGN1hB?=
 =?utf-8?B?azRuNkp5cGYvaHcxZkVwUzhnL3h2Y1dLbG9iT1UzWmh5MHdndUtBcmI1NUlh?=
 =?utf-8?B?THljYW8wcytTQ2J0ci9KRjg2RzNYNlhtdzhON3VON3lCYW1zNlpaQ21vblhw?=
 =?utf-8?B?M3dIbVBSUVdXdEd3SmgrTDBTcHdsQWV5c3l2ZVRVTmpLNStQQ1VYNVVoblBT?=
 =?utf-8?B?UEwwbmhhbGwxY3ZGTXRuQnBRYUdSZnpiSnVtT3g5VkpMMC9zZGc3bVpjaDJF?=
 =?utf-8?B?aW5URnhvREZtbEtMaE5GZC9hZ3pQdDNvOFpIMDdmSkQ5ZTJzZEdPS3ltRTZM?=
 =?utf-8?B?K0RVS3EybDFPVDJzR2dsdU15ZS9sd04zdXE1UXlxbU43cjF6T2hkQ3pnZFEv?=
 =?utf-8?B?R085NkxpYjQvRlhRR2RkQ0FYRS9vZm00VTBZa1VmY3J6azYxNVk0NEordEhq?=
 =?utf-8?B?aTJVQkp2OUZXc0NUWmdmb0pOUEY3YmZlVE93aWVvanRLR2lQWGhISWpFRGJ1?=
 =?utf-8?B?bEFCT3c2WGNzTndxUHZ6RzZ4eDR3cmhnN0ZSMVNTaC9qSnBOU1RhVXZYZXBG?=
 =?utf-8?B?VjlJL0FPQ2tSWkR3ZUFtNTlUamVJMjBLYStZZ0t1WmM0N2luWHZka21mOC9x?=
 =?utf-8?B?Y0ZkUGhuc0dxZGx4b0ZNdmNkbGN5QmIwUUNBQnAvT2xhZXhtemxUcGphNFlX?=
 =?utf-8?B?RStBZHVZZFZGQ01VdkFVcmN3and5NWRtN1R6RjdmcmkrVzJRZGJCWG5EaFFt?=
 =?utf-8?B?eEVMMk5DS2lzUzlLSkJwN0dkazBUbzc2R0JwTHZLWFcwQXlUblZienQrRnpx?=
 =?utf-8?B?Y2RYUVRiMWdwazZodHJ5K29vaXZJREdIUlhxRkc1b0NFN3d2UTZiZDJVMVpr?=
 =?utf-8?B?TnNYQ0hJS0lBTjVoQXl6ZFpTZG03ejZuNVI3dWdJcUo1bEJZMlpSVkkzUm9C?=
 =?utf-8?B?bmFmMExjWk02RFdZZ1p2UitkK2diOVRMTmZSU29OYzV0Q0FiNC9Kd0ZDQzNa?=
 =?utf-8?B?Y0Vnelp5aFFoeU9hN3BQQUg3NUZWQ05zT0ZmNldwWVlRVnN5UEZCeVJ4dGFR?=
 =?utf-8?B?U2N5WnRGRG1tVUVZY1p4RE1tRTgyRmMzZ1JHWFlOenRkRDd3a2dtNnlIUUZP?=
 =?utf-8?B?cG9YWk55R3BzRUhwRVprL2U5S3liZ1AvSDEyVXdsbEo2ZElxb0FJWUtla05Q?=
 =?utf-8?B?N1VQcWlESExnUjRPcjlmTUdoYTBYZDFaZWRnN1lZaFBUZ0hIMHg0elpReFA4?=
 =?utf-8?B?QjQrSWhCKzM3QTRHQTg3S2h4aGx6MjYwQTdkSVRPRTg3SGJ4bmVLWk5qT0Rk?=
 =?utf-8?B?MER6MnE3Znh0SEJwb3BJdjF1UjBrUm5JV2VVYnFvbDFseVFkMXRUL3BIVHNV?=
 =?utf-8?B?OFVSSlRIa25SeXBSL3BZd3lDOXY4M0tYU0tWZTl4RzF4em90elpvSjUxVUNx?=
 =?utf-8?B?aVhBRXVZNVZQN3FDbXd2anBPMld2SzJ4MDVDZkI3QWx6YkcvSzhMbEVERnFW?=
 =?utf-8?B?NVFrK0lWWUU4dFNyZmpXR1A3NUtRMU40dzdsVTZLMkZ5Rm1qM2JkRmJSdkxZ?=
 =?utf-8?B?QlVCRE5rWVl4eDZWbUp2VGRZcmlCVjNtQkJocXkyeWVCZTM0REE0Q2xPUEsw?=
 =?utf-8?B?a0tReVpITDBRNDZFUVB1dTZBb1UvcWxqa1lxZEdSb091QUtyM2tZdmRxU1Ny?=
 =?utf-8?B?Rnluck8wL1EvSTlvcW1hK2dmY1hZOUpyUjU1UHgzMUJiNC9wbENpZUFOczJv?=
 =?utf-8?B?UTVmZjhpRzAveWliODZJcWdXUGJNVDZtbUVxa1VUUmNaaGs5eThDWGU5dDBy?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95b08f-4cc9-40e3-ec06-08da5b733cb8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 15:06:12.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKdku1q19/dsno01gc9fea0ogHG9Q3sMQtY23JvXpz4t9e+doLYS6V/LiDbQeYhOK7OJKRsu05E4J/7j8J7KkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_07:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010059
X-Proofpoint-ORIG-GUID: VpNmPPHwjWs_hPWZW1GRdUVBxz9QgfXW
X-Proofpoint-GUID: VpNmPPHwjWs_hPWZW1GRdUVBxz9QgfXW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 1/7/22 10:49 pm, Marek Szyprowski wrote:
> Hi,
> 
> On 01.07.2022 14:20, Imran Khan wrote:
>> On 1/7/22 9:22 pm, Marek Szyprowski wrote:
>>> On 15.06.2022 04:10, Imran Khan wrote:
>>>> At present kernfs_notify_list is implemented as a singly linked
>>>> list of kernfs_node(s), where last element points to itself and
>>>> value of ->attr.next tells if node is present on the list or not.
>>>> Both addition and deletion to list happen under kernfs_notify_lock.
>>>>
>>>> Change kernfs_notify_list to llist so that addition to list can heppen
>>>> locklessly.
>>>>
>>>> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
>>>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>> This patch landed in linux next-20220630 as commit b8f35fa1188b
>>> ("kernfs: Change kernfs_notify_list to llist."). Unfortunately, it
>>> causes serious regression on my test systems. It can be easily noticed
>>> in the logs by the following warning:
>>>
[...]
> 
> Yes, this fixes the issue. Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 

Thanks a lot for testing. Sure I have added these tags. I have
send the patch for review at [1].

> Maybe it is related to the fact, that I have earlycon enabled on those 
> machines?
> 
For sure it is occuring with some tweaking in console settings. So far both the
reported occurences have this thing in common. I will be able to confirm further
if I could reproduce this locally and I am trying that at the moment.
I will share when I have some more findings.


Thanks
-- Imran

[1]: https://lore.kernel.org/lkml/20220701145047.2206900-1-imran.f.khan@oracle.com/

