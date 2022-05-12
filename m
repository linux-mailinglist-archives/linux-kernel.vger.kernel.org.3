Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08147524303
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiELDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbiELDHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:07:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067DA37A9F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:07:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C0T7hM007656;
        Thu, 12 May 2022 03:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sEf5tAeF4DlR3VKpmxAeLujuSV4yPUtEvoJu9XaPm/w=;
 b=1CFRE++tTY1iiuFC+jjHs+1g32ImHnkHKF1D6A+TNvGgnb/tcec37f75j9AZDkulL9Ca
 L+ptpRw0Nl+Ped6uyHymqcZzNNKRFQQuDyWaLMhe4dJm9/mKVARBFLy8DThUBZKjjIhk
 CxHwHqRHWdGjwGDBGjTFNYYAfg5acaSifF8Ve9FW8MqrjhWy/b7rcmFvyaArwuSoG3As
 xbRld7We/kQ4SyWWDGE2dJo1g5wGK/3aewADynwymPkfEcOauX/VSDRIuBa0CcO8MjwS
 LopSTiamRSEXpiBEhzI/zHWemTkjnpq7gbXwTAXMJNuhhJjjecfVy95Wwl3D/5zoLni4 WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9u3a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 03:06:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24C35tX9030455;
        Thu, 12 May 2022 03:06:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf752qgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 03:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6pTfKOacYLZRxqkJSCKP2h1J9X8w6FGCTBxq8vGzBuHmDtiGpKC1JoWNYUu+nK6offJERcHLznyV0JM6hjUevu56pvw+5eOYTWGiGwbsZO/8DOYLzBIlJE3bObWo9hxbytPqFFChcya+cBZGuu3KwSj8SV6AygZQVm6uZJFPdQxEyGWZlypsKesiXGkqSA29TrOjpjV/BnQsAMXTuZiNChKDJWzzBurb7QVoJi2xm8e6pdqJDbQYFCXxDfboxDzsXqiKxqIQVoznDb/oQgaGzG+b3/FsPEKTVpUtPpWwGjnFFExgnSu2eVUhGSxuBaolVjbUTSRIlH2FKMfjVTuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEf5tAeF4DlR3VKpmxAeLujuSV4yPUtEvoJu9XaPm/w=;
 b=UwIvUUMO5HamefQyHHopo9TqMTq/M1vJoRaDnKM9AD5mJlxY15Q9TwcZt+UAO87ISEWj0qANWoOtCF2ow4u1L13JKfyz8akoBnP9fC4KKOP+6kMDS8oR/5K2qZLSgbzcPqwMQJ4yaYN8NdjgQwaG1mw17LplcWYbWIp+bA0bViWNf9BdjvfSTD6a+2zy58zOMjXED4NlJXp0pkOC5iLNlQQEEZYXyqbrktEfapvvWfZqJQ9nPcDLeW+72pZHvNkqTNxPhiPduQinmOIFDSmoR7j5QNaINhRQyPN99NHQejBS8M5AAo8hviEEN6LbrF2wl0buRW1WMa8c/PeheMzLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEf5tAeF4DlR3VKpmxAeLujuSV4yPUtEvoJu9XaPm/w=;
 b=dcZH9rvSGY+glz/uBf3ZsIe5UoGjH7NyU+5n/rTaC25dSO/qIMJwetY+LEdRfmde9Dd1tFmiw4pyTNjOqL74PW8ZcxM+x4tp8f1g1t04vcvmTqf1yyE4NCz7Cn8D78x015J0pGX3r/I2Ry/CWy5mSTK7LqEQ1/1zRceb0q9uf/s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3150.namprd10.prod.outlook.com (2603:10b6:208:123::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 03:06:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 03:06:49 +0000
Message-ID: <f9236f0d-f70e-e078-84d2-9ea480060f27@oracle.com>
Date:   Wed, 11 May 2022 20:06:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
 <d7f24648-2af5-3998-d265-c441538ce5fc@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <d7f24648-2af5-3998-d265-c441538ce5fc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab6a1a66-4dad-4b63-9654-08da33c474fd
X-MS-TrafficTypeDiagnostic: MN2PR10MB3150:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3150D0F0567FC2D81616BF97E2CB9@MN2PR10MB3150.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXpWdaW2qAT0+sZG7gUkNY362oaKusMqKZ/kBYnZyqToKJdSohjwCHqM3bPaE1269PiFRB5KodLITQN8LgjzuR7wUdCHBJ2h7aCvsAwboDPAa1zW9WKvCfwygJWaJP/WS9EAu9Jg4KlyeYwGe2I572SBZTpXtBRjueqf1+GoRzA8O4bXJpAgWPBOZwuXPjYAGCXXJsFbr/ttXOGvBSrC8nh0xXWCpDlAXmWRlMInHjlX2e8vr1wrybQRo7wOSca5X1gBuvJnacmt9o1NuQ5NE9fjYbPM5CkQlM1sJVOypJNDL972UrrihytQ8je80DexUcIQ8X1P9/z/HK40/UqvvX7yPY0VPQbOHIr8O+EJQUFvwzG4yQGxWoAXB6g5pXW9yCKlmgvVCtYN80PHRV6fgD0ziC17coO9wndMD+4bI5chAlIkTxR2qk4UQFsDJdEozVa+CuAM8Rrw+O2dj6tPdq0q0L/deH03uz0+rSfXCAjO501PjV93i3LXef6e1h68FfkMNDuM73yPIswD1KqHrtrIOUrozSzb2Sa+6P3rDmHv/Z61Him4ok1a13RHqWTCpYNVcES4azeDJNRkUS9ULvhUZD8jlueVw26LDHBS3/9kpQfrflQcJ6dI3OqpaSstN8DDzHMiv2OOU8wKh0vWz0MTX2/0/N9fr4tMFKjhN5Ycm28Wlbvpk1h15JW/lqhDH1XMAH6dRO5W+8PCXAQ/XjcCF4wCz1+q8DPaTi5zHRCGQS5FDuoVMOSZYk0qXoIXZrliL0eSW427lkqKbpw2ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(86362001)(31686004)(31696002)(83380400001)(52116002)(6506007)(66556008)(66946007)(186003)(66476007)(2616005)(4326008)(8676002)(5660300002)(44832011)(6512007)(54906003)(8936002)(110136005)(26005)(53546011)(508600001)(6486002)(316002)(38350700002)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRqbGQxMFZZam1kc3hVTGU2QmIxanRKQWNjaWpoY29VQ1oxYXRlZG1ERHdj?=
 =?utf-8?B?QXA2Z0tKREd1b3dGWS8rdncwQlU3TkdyQ3lNeml2UjVjVzFhQnA2UkdBby9t?=
 =?utf-8?B?dDRhd2NnQ2xUQzJjamx1YUtiTGpVaFpXVTVSTkhTWDZzYmdmd2w5aUczUnhR?=
 =?utf-8?B?SlZmVWpJSjlzcEZrdkZaS3NSekF6WkRZcEpaMjdYOTlQbVBsb0hsOStDaDcy?=
 =?utf-8?B?a0NJTHMrZmdvUTM3eks5UlVrSUtkOHFzQ3hoVGtHRGFBeWdNdFZZVEJxWWl1?=
 =?utf-8?B?K3MzTlB0Q0l2Qi9tMEI1MkRXL24rRi9sb0ZUMUtXSWs1QnNtNHdUT2o3MjBB?=
 =?utf-8?B?emNUVnZYWUhNcTQvV2Fmc0wxVWJDNzI4QzYwZW5VemNSSEZDOTlQTUpicE8w?=
 =?utf-8?B?U2Jqb1A1bTJyUVd0OGxhQnp6QXdBekVRWG9qcDkva3JyVk8xamJSZThHVHpx?=
 =?utf-8?B?ekJLY0tGNUxTTkN4T3RxcnFtNEhXU20waGI0UmFtYlFvZklXb3BxM1Irb2Ux?=
 =?utf-8?B?WUNzb3lHK1RPOFQzMWRmNC95T0Y2eEkvSHZCaUJxT0xQODRCWkcxQ1JLbjdG?=
 =?utf-8?B?VjczWHhFNWhwd0RxYUtGaWpJcjZ5QXBvS2NNSVZTSkVnS3p0Y0lWbTB0bXJQ?=
 =?utf-8?B?YWY3K2tId1dPRWp5cHU4MUF3ODBDb1RlaDRXR01tWG1EU1ovVWtRRGE2VE5m?=
 =?utf-8?B?ZW0zRmxqSUZVeEc0NkVYQndHVjJBZWxlVURGOGtDR0RSMkhob2t1anUrVTBt?=
 =?utf-8?B?Z2ZnL0Q0TjdSOWVjb1djWHhQaDlvbmdKU0VaMnd5NklHa3B3NldRS2YrbXVh?=
 =?utf-8?B?clp6SHdWYXVNd1hQQ1VhQ3R3MDE2UTR4RG1pODBuZ24zT0J4TWpPV0ZMbFpC?=
 =?utf-8?B?WG5YMGhmVGc0ZEFhUUp4Z1YvRFRQOWpUbDRYQ2k0TTRvKzdDKzdkdEp4OERq?=
 =?utf-8?B?Q2llNEl4K2tXcEhoTDUvdUtmTnlkTU5IL1NPMnpKSzAyU1BVRjF1RGN2MndO?=
 =?utf-8?B?VDlrUk9XeFY5cWJYY0x2Sjd5MG1QZnJnSmQwTEo5QVk0MHBzdGZkVkJzcUov?=
 =?utf-8?B?THdvSkhjYnM2TUIxZ3Iwdi9UdVFZZy9yMHluVVRZQk9xRzZML3JYYy8yNW9J?=
 =?utf-8?B?UGJna2dkQlpiMjRCTXF2aVQ5Wm9vS2xhM1JzNTRoUVpkYWg0NVNXU1FwdDJk?=
 =?utf-8?B?MmRtY295Q0lNTkVqYnB2cy9DR29iUjBXdVZRbzcxK0Vha2xnSG9zZzU1SlNl?=
 =?utf-8?B?NDMrdzBPTitCQ1ZaRER2WERvRVhneERLSTBabDFIL0pVejRXQVRUWGpRYUgv?=
 =?utf-8?B?VVJRSStFUXY3cjhBRE5TSnBwZy9kc0RRR0tScnRuK0NMbXdsNmdUWmM0aVRs?=
 =?utf-8?B?MnNUMTB1dDFrcUFnWlBtWFUrUnUzU0c5QTFzQUpTSTd2bkRHSWRISTcvbTE2?=
 =?utf-8?B?WXJHTFo2K1dCaHpFT3lERTFhUDRZbFU3TmlQMTJlMTJrNDRMcHFaRGJpRHdJ?=
 =?utf-8?B?THJ5U2dGc1FXWFR3SUVqWXhSTG53cXM4aHVnQmhCaU5XNG9uV1Z6ZWRkT1oz?=
 =?utf-8?B?NWZzZFFyZ29pUTd3MW9EV3hLbmw4TVBvUytIZ2VCd0VmM2VnbmltY3RvK3hG?=
 =?utf-8?B?K1o1b011akw1SHIwQ1ZocWs2WFVQTDg3a0c2eS80Q1Z5Rm56L0dEYmxNWVY2?=
 =?utf-8?B?Yit1V0dXY1J0SjNrcERLTVdMNHgzbmtpRWpIS29WZ2lwanBaQ2cvMEJmb1Zk?=
 =?utf-8?B?eHJ2S2Yvc1RtUkU1ZmZwdjdkdDM3OU9HdDhlYWxNdGhILzdLNjdiOWYwczJz?=
 =?utf-8?B?enBZRnhkaCtGSGlpNU4wTldBRk1yK3ZTR0tqOUJwMzVjNm9EQ3lOVXlOT3hk?=
 =?utf-8?B?NlNYRHBaQ3B6anp0R0xpSW55WGNzZ3pzY0xVNlVGSnUvbXArclRNUEduZEpz?=
 =?utf-8?B?QmhIZ2dRQjloOVRNN3QrSEg5RklQc0V3amhvNlc3REZ2RVIxSFJWVGdrU1A5?=
 =?utf-8?B?a1QzdFdSUmRuNW01MUJwK1hYV0lRdUhXbDhCTi9uajNpa0F0bEMwa1JkNW93?=
 =?utf-8?B?UUlpaUEyWlZJRWVjb09Ua1YyM0ZQU09Lb2c4SjBTQXhHWStVcEw3aE94OHVx?=
 =?utf-8?B?YXVSTEZVc205d0xiSHF2azFTM3dRYjllalhSaTV4aXZLYiswcUlXUEM0YTdY?=
 =?utf-8?B?ZXlpTUF2TWxIREVoL3dObWlxUG5Wb0NuLzlob3RjMWNhaUYwQ3pzVEc2b2NF?=
 =?utf-8?B?aFFNUWZXT3E3SUNhUlFHNGlET3R2Nnp1TmlTdEtES2RabkYyU2R6VmxQOG90?=
 =?utf-8?B?Q1JlVWlueUY4ZUJUVjhnRit0VVBpNUtIYnd1YW10YlczT3FwK3JtZExES0Vt?=
 =?utf-8?Q?s9xOZMCF5RAYuOVY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6a1a66-4dad-4b63-9654-08da33c474fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:06:49.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6RiT/8LaImuuhBFS/lAG2gGqy+IMI2HGFx71uNPCKrcG+lsRa5jmy/lMixGPl9ySZp2hsm8dX+AYRHArb4Xeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3150
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120015
X-Proofpoint-GUID: AE0xXpJjsiFX1CsUbE1XlZNgiw_d9IoU
X-Proofpoint-ORIG-GUID: AE0xXpJjsiFX1CsUbE1XlZNgiw_d9IoU
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 19:54, Miaohe Lin wrote:
> On 2022/5/12 2:35, Mike Kravetz wrote:
>> On 5/11/22 08:19, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> If memory_failure() fails to grab page refcount on a hugetlb page
>>> because it's busy, it returns without setting PG_hwpoison on it.
>>> This not only loses a chance of error containment, but breaks the rule
>>> that action_result() should be called only when memory_failure() do
>>> any of handling work (even if that's just setting PG_hwpoison).
>>> This inconsistency could harm code maintainability.
>>>
>>> So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.
> 
> I'm sorry but where is hugetlb_set_page_hwpoison() defined and used ? I can't find it.
> 
>>>
>>> Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> ---
>>>  include/linux/mm.h  | 1 +
>>>  mm/memory-failure.c | 8 ++++----
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index d446e834a3e5..04de0c3e4f9f 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -3187,6 +3187,7 @@ enum mf_flags {
>>>  	MF_MUST_KILL = 1 << 2,
>>>  	MF_SOFT_OFFLINE = 1 << 3,
>>>  	MF_UNPOISON = 1 << 4,
>>> +	MF_NO_RETRY = 1 << 5,
>>>  };
>>>  extern int memory_failure(unsigned long pfn, int flags);
>>>  extern void memory_failure_queue(unsigned long pfn, int flags);
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 6a28d020a4da..e3269b991016 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1526,7 +1526,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>>  			count_increased = true;
>>>  	} else {
>>>  		ret = -EBUSY;
>>> -		goto out;
>>> +		if (!(flags & MF_NO_RETRY))
>>> +			goto out;
>>>  	}
>>
>> Hi Naoya,
>>
>> We are in the else block because !HPageFreed() and !HPageMigratable().
>> IIUC, this likely means the page is isolated.  One common reason for isolation
>> is migration.  So, the page could be isolated and on a list for migration.
>>
>> I took a quick look at the hugetlb migration code and did not see any checks
>> for PageHWPoison after a hugetlb page is isolated.  I could have missed
>> something?  If there are no checks, we will read the PageHWPoison page
>> in kernel mode while copying to the migration target.
>>
>> Is this an issue?  Is is something we need to be concerned with?  Memory
>> errors can happen at any time, and gracefully handling them is best effort.
> 
> It seems HWPoison hugetlb page will still be accessed before this patch. Can we do a
> get_page_unless_zero first here to ensure that hugetlb page migration should fail due
> to this extra page reference and thus not access the page content? If hugetlb page is
> already freezed, corrupted memory will still be consumed though. :(

Right.  This potential issue was not introduced with this patch.
Also, I am not sure but it might be an issue with non-hugetlb pages as well.

As mentioned, memory error handling is a best effort.  Since errors can
happen at any time, we can not handle all cases.  Or, you could spend the
rest of your life trying. :)

The question is, should we worry about errors that happen when a page is
isolated for migration?

-- 
Mike Kravetz
