Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B771C50AB28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442319AbiDUWIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380775AbiDUWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:08:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A6FD2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:05:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LM4v18009531;
        Thu, 21 Apr 2022 22:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zd3o5h+lY11IRFx7AELR/3SLRICYm3o8V4WwyRHngb8=;
 b=malOAxIujsgU2Lllt2LoXDxQr2UVTn6Qw6rdg5S/FBOGpHC/GQOWR32Kei0lpyNoLLCl
 aqDD4us2PzD7PkF66A0TUGILYnv4kcZQPHLvZYQhUZ2ltXB+1K9IYDGeATPbQpnLSkzu
 m9ouTRetvCtAHgC5CzowHp4gurcE2dEaam2/eNTFe9ClbSrF3DL7xzpwe2RBdCJJTz6Z
 yEL1OMVCTS+l0qv91wFtgFO00yi2O70Knt7fUFk9aIUvkDMo33OaY0oxasSUdQJjftOW
 Yuu/kpQwCzF5mR+QHxX9KXUWVGdapE57eyx/UWL5Q0WVTRrTaMk59VLJEF7bD4lCFlTW CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2w9hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 22:05:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LM1sYa031655;
        Thu, 21 Apr 2022 22:05:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8cnwx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 22:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1bdZaAqm0atQ86g81N25mZ61qU0BkuPpURpKYJXdQK7uaJdKQnvryNDSwkGhNW6tfCa1YSnnFBFHRWeqAP7MbBuf1RssLQIFas9LXm1rrJyS+id4/ifFiiwwjvk4841VZbnP2HKa+xWoD8GpyjiuHIn9T2N+TwcRTE5KofJnrXPhReEvJV4mcl1Y55nvlaWqQjN/MeOuYJIc6Oh/tgMbQR3bn2SNckKZPcLXXsxucsbW1kuNC/yGjx62xteHA3QjYa1ZwDR2THLtI9Q41uGnU9udJAlGhCpocB04gSNwTfcT5ciaNITXOVMOEzK4ApcDrbMXuDe1UF3J+HcOcPVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd3o5h+lY11IRFx7AELR/3SLRICYm3o8V4WwyRHngb8=;
 b=Wza3a5w8FyM49IwqgyX+uGo9FquxtRZslUMCleELs7akBx68BaxnFbRZdSB/jg0d4JZ4pI4hzX8kvbQfjklV3x5AxbwcevxxlJUj6cVON6Nfvrvnl7L2T578dAcVKAgnQkNUE8w9B84J3CrzJDf1ff2zAIFxLxyiCsn5vy/IMmyVxSy/DLz52UtPWfus4CbGbtuhnjXy2V1KUCUMjpVaJlYQ5ktituMqX1eUGCG7U8xebRv0kQF7Q+wI0dXUtcgKvhil2wBjAdkijdhAyRNGmnCF210bfeWYfZjclqn9qoBSeB638Ea025O5ZdaPIF79XBYxms5jP98+LcHg21SQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd3o5h+lY11IRFx7AELR/3SLRICYm3o8V4WwyRHngb8=;
 b=WqMA96mVAFlFNjUOF4cYOhqGM/LWwNwG/+pAX11RzcuXbDd/1WN7oi5p/bGycdoMx+q2EWfAE787KIDPeMHy5Dl9GEZYh2naTgobcz8yS/AAQsLpbjr+pqeUyHj/jV6qirLr+6LKP8SlGrFNHv02r1mbk8CQj0vHJN+uR3/9SLI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2710.namprd10.prod.outlook.com (2603:10b6:a02:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 22:04:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 22:04:58 +0000
Message-ID: <bb011aaf-a45c-c0a8-5e5f-211900d17f19@oracle.com>
Date:   Thu, 21 Apr 2022 15:04:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm/memory_hotplug: avoid consuming corrupted data when
 offline pages
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220421135129.19767-1-linmiaohe@huawei.com>
 <8fae51af-b12f-4232-1330-54f7b0943907@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <8fae51af-b12f-4232-1330-54f7b0943907@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7f3637-02d3-4560-8662-08da23e2f984
X-MS-TrafficTypeDiagnostic: BYAPR10MB2710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2710BA34418AD736A2D3DE02E2F49@BYAPR10MB2710.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+7palrz7z46T5RLLQghG2Td8i04wjEE1fUgUos4GrGv/7kqQVWyxkRhQqU0x51orwGDoFc7KuPNJQ/i6LZBLeg2wYRA64BXnNiKgUBTasU1leEzst7KnhMrxxVzFQ8XbQnE26mf5oZvhWEnO+f0MuqXSbKqwzc3gujtjSjH6CAblipJleI62skuCTtxkpOCtl8El1Jw3YEeLDYkFkfDQZYUFSqxUfByKgyZdRh/gxX+nKxjhR1l2z1gMNcWtUgI/VXgT2EFq3jgCG1nfqjWh/9OzSiWUlIqN72iBckvAmNKWJijxBQUH00f/shWEHNiFfNzaCrxcdiLaFUO7SQOmNDLpArqX3yyhUu1Gg6ax51hVmsoacWTMbJKROnI9FOnCIQCGL/St8oWNnnBXjpFhOD1grJfYRdPDqxu4+knVXR2RQTMW6LGMi+8VEjeOlasSmQs9e74DbUDP/siYNA2/wVR8SEObBu13eXvgK6c4GWHw5vDwMH5UnyP5Wv9OADTfojjt7psNqVtrbjypJFLw21qR+B8sS2sdNnL521DuOueS/bqmch/wS2DwTplHS8Hz4eYhsVpV+oRVcGsQkhEM/7a3cJ4PwGm+4j8YpiD1Bm59PjQ17dO55fxpQbrlItQl+Oe/X3XurKbdeoEk88GWOI4Mx7zt0yD7ZOcbTK3b5k9bzmColyL9nB6YRmeVZu9XO0tE6H4yljj2cJY5b/3m7qykTtXSSMwzBTq3J7h6iakhwYDS4BvQ7U79ROpjzO1JF/awVK3ThEBK+era6odNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(31696002)(86362001)(44832011)(508600001)(66946007)(66476007)(4326008)(8676002)(66556008)(54906003)(36756003)(110136005)(31686004)(316002)(52116002)(5660300002)(38100700002)(6506007)(6486002)(38350700002)(53546011)(26005)(6512007)(8936002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNYRVcrL2pYd2diSXdqR253UVZ2azZ1SVJlVzZWampNb2pJZjVheGhheGpu?=
 =?utf-8?B?QUJhT1A1QkJhS3A0RlBVNWFmTUJKMkNmQ1c2ZjE4ZlI5TGpRZVhvR0d0dVh3?=
 =?utf-8?B?U3ZlSjFtSmhoL25aK05mRmozcnBibWJtYlFiM3JqK2dQWURyN3hEN2lKYXRV?=
 =?utf-8?B?ckNqTkhXbHpMZi9wS1NwcHZiSWZwMWZFTmZDNGd1ZDJqT0oxYkwzU1Q1VmZo?=
 =?utf-8?B?WmRTQzlsdTFLaTNLWDVsbU5IOU14Q1Bkc0JlODZyaUhGbzcrcDlTWCtJVHp4?=
 =?utf-8?B?U0lLaGNjMXlqWkxIYmZ3QkdFUW9Hb3F3dFRzSFc2ZEozV2hHSm0xYzBCdEZl?=
 =?utf-8?B?aEpNdEJsVDJ1ejlMWlYwMXpIVlZyN2lIMHFxQitVc01QelU4TkdOckN4WjQz?=
 =?utf-8?B?MGZRNnlSYWM1WnoxRnpjYjZyazljNlhPMmVXdjlFdnA4THl5OGsya21sVW5Q?=
 =?utf-8?B?N3pybExRaTE1aG83cnNBYnA0bXd0K0g0bk15dFNLSHJmanhQV3VHRVVSTGNk?=
 =?utf-8?B?R3hicFBMcFB2WDVGZEw1L3JqdUJJc3RlZ3dBcjdGa25XcEdQSmF5RktHZFNv?=
 =?utf-8?B?SmNHMXlwTHF0M2NScWhnZ2xRL2lMQUpzQTh0RmJVNnlNcGsxUjBTTndKTG5i?=
 =?utf-8?B?SkFpK0ZpTngrU2tXbHFUbnI3NmNEbzZ1dlZnMCtFNWpRUU80TjhvM0xGM0pP?=
 =?utf-8?B?UEUxRjFXOVlGam9ZSGpNMXJ5ZnRoV29jeGg3MlJ1NnRzcVAwampLUXJ3THhQ?=
 =?utf-8?B?UjQ3azQxRkFubWt4eXNCbDZlbUxFTGkyMEh5YkI1eHFMWGlrMlhZbXpWSUk1?=
 =?utf-8?B?N2dSNlIxbDVLWmY3eXBZSkNZVk0zN0ZmSldSdDA4REE3VWx3UTBscWxvNWJJ?=
 =?utf-8?B?R3B1SmpIOHZTUEJOMURhZlRSRmZxbHN6L2VWeXZvYVlEeXF2Q2c1UkNsYVgw?=
 =?utf-8?B?dTZJSkx1RTdaV09ZTVF1Q3drOERQV2lIdXQ5SzF2LzBneUFBN2tsNVlsWVdC?=
 =?utf-8?B?M2ZmRTNSVWZEdkVsZmJxVzRudm9QTTlNWnZWSGNiVkVkbDNGMEI3WEtramhE?=
 =?utf-8?B?VjQ0U25GN2FFR0tqUTZoWExwRTUyUUE4WHU0RXY5RXVwODB1SGhEUWRVS1RH?=
 =?utf-8?B?WEZhSjdaWnJ3QXhOQ3l4djVrUFJJemJXSkpySWR4MHEzOUR1dHloN2ZWRWRF?=
 =?utf-8?B?c2VyYTUxeHNMSVBXeDBJR2hDMkorYXVlL2xRaXFNT2ZSdmlUbXdmUC9hcXNQ?=
 =?utf-8?B?Z2V6aDJsb3pXQlVXMFBKQjc1blRvdUFYTjlFQm1RbGcxcnFlYXBocmZvSXZE?=
 =?utf-8?B?cElPSWZXeUlSTVhmRHh6OW5BZTAxZEFnWE5USEUwY1NCTEFhNklJWFVkMXBH?=
 =?utf-8?B?SFpxZUtsTDdxWnBrYkdrWnhyTmRsNldSLy9lWFhRS3NHcXhUeEQzOUI0U2pH?=
 =?utf-8?B?VVFJbGh6R0dLTVZCUEdRRERIUGtYZDJXVkxFNmxTN0Rsc3FIdzdDckVxWTJy?=
 =?utf-8?B?ZjVtSk5na0EwMFlLSGlBZVJJWWs5dEhZTTMxdGVxQTFnT1hoOXhKa2ZyZFh3?=
 =?utf-8?B?UmtTZDQyTVR6dEdKa2ZxdmJhc2k5bmFrOUU0WTE3QmlCS1lsTnBrdlNmTTRr?=
 =?utf-8?B?QXZhRk5JYkNZR1NUU0lMdzdJVGVKUGpnMm1kSnRuL09DYXNZcnlBZm1aTXRt?=
 =?utf-8?B?QVJjQVcwTkNsZW51aDFTNytqR3pQYTVUeW9ZRHBhVXJ1YWNBSXkvZks1ZXRH?=
 =?utf-8?B?TW11MWRXY28vdVVWVm9kWG82dUlxeHZSU1BNc0psc2s1UlFqWHdIS1FJekFo?=
 =?utf-8?B?aXA4Q0dKREYvQ3I3S2lUd0k2cjhMMUR4ZFdSaWxnMVZMcTU3ZmZuMG01V0pw?=
 =?utf-8?B?TDlqUnNaNGF5UVBqMlRjVEkvUFhTUGxZMzl4WEJnSGE0Y0tKNnpEbGh0Ullx?=
 =?utf-8?B?RGR6emhMcy9SQ2FHbUM4cXkwSXYwblR5U1NhQlQwRG1YOUYwb2FXcStuQ2NX?=
 =?utf-8?B?SzlEZVlXOWpkaUI3anNUdDNtcTMxMlZidGlCZm5Xd0VaOEc2elpqZnNTMWlu?=
 =?utf-8?B?UDYzODZUd08wM29ubzhxa3dhTFdob09IVEpuckliYnFRNnJvQkN0WUNPNXE4?=
 =?utf-8?B?OGIrL3VkTVFxWFZSTExaNFo1MTg2aUUxSXV0R3g2Y1ljZzVjOGh2MEoxQkpz?=
 =?utf-8?B?UEJBRkxvWnA3MmVGRjRGVFR1eVJGMmpiUE5hV0lPdGhkb0JZMUdFQnIyd2xC?=
 =?utf-8?B?MTl3bnYvY1I4WVhoUk1lVnFCSW1iSm0yLzJBRTdtYmhaTDZaVzFkSHZBRHBN?=
 =?utf-8?B?OFprK29ITTU2ZzNIVlZVZ3pweXVJdVUzTVJ4ZFRweFMvMUVrcTErRHY0aVR6?=
 =?utf-8?Q?u4uUc39Tc+5CQ2m4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7f3637-02d3-4560-8662-08da23e2f984
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 22:04:58.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7UXPiGUbZR5RQgq75Tx8jYzOte5jm5Uac+9Kfe5k35HxNAJ6eDRFAYQFHtBkWZRugEp2kTXdb9z9cUuAFOqdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2710
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_05:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204210113
X-Proofpoint-GUID: _WmdRW9gL1Wx7MC6YYx5JdWnHiiguuas
X-Proofpoint-ORIG-GUID: _WmdRW9gL1Wx7MC6YYx5JdWnHiiguuas
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 07:20, David Hildenbrand wrote:
> On 21.04.22 15:51, Miaohe Lin wrote:
>> When trying to offline pages, HWPoisoned hugepage is migrated without
>> checking PageHWPoison first. So corrupted data could be consumed. Fix
>> it by deferring isolate_huge_page until PageHWPoison is handled.
>>
> 
> CCing Oscar, Mike and Naoya
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory_hotplug.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 4c6065e5d274..093f85ec5c5c 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1600,11 +1600,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>  		folio = page_folio(page);
>>  		head = &folio->page;
>>  
>> -		if (PageHuge(page)) {
>> +		if (PageHuge(page))
>>  			pfn = page_to_pfn(head) + compound_nr(head) - 1;
>> -			isolate_huge_page(head, &source);
>> -			continue;
>> -		} else if (PageTransHuge(page))
>> +		else if (PageTransHuge(page))
>>  			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
>>  
>>  		/*
>> @@ -1622,6 +1620,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>  			continue;
>>  		}
>>  
>> +		if (PageHuge(page)) {
>> +			isolate_huge_page(head, &source);
>> +			continue;
>> +		}
>> +
>>  		if (!get_page_unless_zero(page))
>>  			continue;
>>  		/*
> 
> The problem statement makes sense to me but I am not sure about the
> details if we run into the "PageHWPoison" path with a huge page. I have
> the gut feeling that we have to do more for huge pages in the
> PageHWPoison() path, because we might be dealing with a free huge page
> after unmap succeeds. I might be wrong.
> 

Thinking about memory errors always makes my head hurt :)

What 'state' could a poisoned hugetlb page be in here?
- Mapped into a process address space?
- On the hugetlb free lists?

IIUC, when poisoning a hugetlb page we try to dissolve those that are
free and unmap those which are mapped.  So, this means those operations
must have failed for some reason.  Is that correct?

Now, IF the above is true this implies there is a poisoned page somewhere
within the hugetlb page.  But, poison is only marked in the head page.
So, we do not really know where within the page the actual error exists.
Is my reasoning still correct?

If my reasoning is correct, then I am not sure what we can do here.
The code to handle poison is:

                 if (PageHWPoison(page)) {
                        if (WARN_ON(folio_test_lru(folio)))
                                folio_isolate_lru(folio);
                        if (folio_mapped(folio))
                                try_to_unmap(folio, TTU_IGNORE_MLOCK);
                        continue;
                }

My first observation is that if a hugetlb page is passed to try_to_unmap
as above we may BUG.  This is because we need to hold i_mmap_rwsem in
write mode because of the possibility of calling huge_pmd_unshare.  :(

I 'think' try_to_unmap could succeed on a poisoned hugetlb page once we
add correct locking.  So, the page would be unmapped.  I do not think anyone
is holding a ref, so the last unmap should put the hugetlb page on the
free list.  Correct?  We will not migrate the page, but ...

After the call to do_migrate_range() in offline_pages, we will call
dissolve_free_huge_pages.  For each hugetlb page, dissolve_free_huge_pages
will call dissolve_free_huge_page likely passing in the 'head' page.
When dissolve_free_huge_page is called for poisoned hugetlb pages from
the memory error handling code, it passes in the sub page which contains
the memory error.  Before freeing the hugetlb page to buddy, there is this
code:

                        /*
                         * Move PageHWPoison flag from head page to the raw
                         * error page, which makes any subpages rather than
                         * the error page reusable.
                         */
                        if (PageHWPoison(head) && page != head) {
                                SetPageHWPoison(page);
                                ClearPageHWPoison(head);
                        }
                        update_and_free_page(h, head, false)

As previously mentioned, outside the memory error handling code we do
not know what page within the hugetlb page contains poison.  So, this
will likely result with a page with errors on the free list and an OK
page marked with error.

In other places, we 'bail' if we encounter a hugetlb page with poison.
It would be unfortunate to prevent memory offline if the range contains
a hugetlb page with poison.  After all, offlining a section with poison
make sense.
-- 
Mike Kravetz
