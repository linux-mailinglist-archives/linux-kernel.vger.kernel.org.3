Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8739558F9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiHKJFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiHKJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:05:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439520F45
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:05:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B94exG026605;
        Thu, 11 Aug 2022 09:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E4BMAuSupZFa4uDJEnKmk7LMYkgSoDs1DRbkaAH2x/U=;
 b=XzRxB8onvJHoBZaRfetopT1mebOKklbj/LNRN8XNbnWeSTVMsBNCpqswwfBiypOrK0nY
 Qjqs3wkY1uRVUCZiEwfSgo0tq1BTnWsGQRSsSBPHFgp/htelCGNdB2Pf52gf73rwfpyR
 rDGeHLyZKWdyk6YdX5aIT/tBJa7h7VXLUvd3nOnBRr/AAvsGa+Q/o65W08iI7DwLuqzH
 IU3nEZ16Ul+lIqpdhIf/J91Ab9X2dt+EgAYXjtWlUyOltcG9fublZgy5M3qyRB1tkR8t
 F6zalGLTwuKxg48kfcuD9KRptgEVg70daQxGOMHx/U0/X8ObMjJSJaWieQ3jSlF02cE/ Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq949xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 09:04:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B5YcBr023692;
        Thu, 11 Aug 2022 09:04:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqgxdc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 09:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdiZPgtPmXmMxCZyqr17p+9yzv1dXCKMxJFy47g9DiznPad2A4kXLK6kNM91z8HWYdkpMdQwBDKZ0zMtlPOqxbD7P285rUHVUvWJfJRKYE9NkpKWeNEVXZvYz4dnVLJ8r1VucgU8M2clNRnKJryplCpU+bAe9uZ+Ke7mcUP0djEJPwuaI9PPHmFYQC6z1W3FcbEP/sHrGLwFerBPvy0jgWDvAEBLD2ldd3LSEELEwVZF0rOVbC3eoTPXCxHdzDpxnURWUDf+f6V12Jz6a6A13XwVhOqrTrb8Z0HRSVoF31kbEQXFhMg30HRGeZG6aN94nQYebprI26Px/7+bjhbhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4BMAuSupZFa4uDJEnKmk7LMYkgSoDs1DRbkaAH2x/U=;
 b=GgjSW1Slr8/5/dig9QMVg3mnvw3/lvbAF/x1W54vPSU/Aj10lIgIcmrYFkmWXI2OP7tATZMR3IKg4QDd3OwAzdXPO6i9SutYvQE3tT+znluu9phkE9x6bHMwZTgKHY+NteqlRV0sVGmmjjsiu5tX3bAuwA9hz34jXmUqeBUUsuHrQV6iRk5XIBztYEOy0grWVfcFPVr1FKrvt0tplocAa8qQur59IT+eazNfpusHyK3k4gHGL0VQ+rd0zC93mMN1+pLQ1gz77yteHjQPJ66SzqImNOuWXvqRYj8Juo1suOL/4TSNC0OCmYjtoyQSPz7NvPyJzcFZEUMpQt+gmgOXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4BMAuSupZFa4uDJEnKmk7LMYkgSoDs1DRbkaAH2x/U=;
 b=M0QO/PXk1cnWe9pXkJmdL/N2s0mDi6vpSmYwsNgGrDhbKV2If4OEq9V5eCTosWC2otvXk2uF4krKyjFWj09aalYLYO07GL6WWchSnEMWp72z3L9IMO+NAL8Mj661xf8qL9qXzl6yaXN6mzEiVYmSkyKXmEXEeljwKkLtDSO1LP4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB2744.namprd10.prod.outlook.com (2603:10b6:a02:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 09:04:34 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 09:04:33 +0000
Message-ID: <8fcf8e26-5d96-85c9-bc55-8bee7a2444c4@oracle.com>
Date:   Thu, 11 Aug 2022 19:04:20 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH] Introduce sysfs interface to disable kfence for
 selected slabs.
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <20220811072551.2506005-1-imran.f.khan@oracle.com>
 <CANpmjNNDy5-OssTWP6sm7r0BOFkBVdOa1_ZsPWGQOKjLwGZoCQ@mail.gmail.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <CANpmjNNDy5-OssTWP6sm7r0BOFkBVdOa1_ZsPWGQOKjLwGZoCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::10) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d876a6f-5219-43df-bd74-08da7b7881f5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2744:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwZIorDMNiLmA5U/vquiUOxE7coOp5LdGGy/0BPRsXuxT4l1Dn7YgJBLdCIWCG9zgOgvzZ9Owxvl4bHD8i49Ern9YTF3GI0Ut0hBKEd/PPmn29BJ2cnIil03Z/kEil0/VtBClG/Woxfi51HB8WvfT1GYd/9GweOrqRBjeUkh3tULW0n4SikjtKCyJeOLsrlXTZSsKqwrO/A/oQ2FjA5PCPrQOY+5kS7OYS1ZSc5ZJW7SJkuFGf02GblijuHgZ+ITFef4n3/DIKvBLwHTEorJ9ziwlD+H48VeQLJ2sTk+ReFVuA0RbO0pilJmhE0H4Po9+qdzyKuRnHqTGQFghBhIG3EQ8H3mos60H5Qdz+amuuJcUxVx155i5IblI36DVT+HmkRtBpLv7ITdherEUBMrKfpPjuXeW71HMYn3F8Ld/q9UpBxdp97MvpLYbfqXt121C2eJl27DqvzZLNEA30n4LxUjaC11grYM+1SYaByPidWBt0k1yphVc4+F/BYPJmDo7M1sUKhVlKhdLJlmvCPlBasZklXQk2mDbLh1o04qVOWhAFIyGO8al8sOx69H8smMCQyUoSPlw/LrYL+Flcc7ELzOwQT2PSQ4x9z49jDOA5FwZ3DPnR5lG+bLzUQvJ99b8JySSrAVZ6C8XsBBg6hZlEVZfPqHw6VwaqVFcd8bXj+bn1Pi5qPrIcYF14jJ4y2oWreUWax35zwPZ5ptlDy8p0lEdJEOgZe/SmP9Nz52zdvCrGNkqai5MpGZH8US7SJqBs1+m+PSyyItU8xBaM/3xYNuUz3Sltwvr/VHHocjoIbIGQTcCykNzrCrpMDQ4JWEfk7JPGzOVuc0aNIINuWM4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(66476007)(8676002)(5660300002)(66946007)(66556008)(36756003)(4326008)(31686004)(478600001)(7416002)(186003)(2616005)(8936002)(38100700002)(86362001)(6486002)(53546011)(26005)(6916009)(31696002)(316002)(6666004)(41300700001)(6512007)(83380400001)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVNVGRBbHljeXR6NGM2UjlEUHo2QW80cVo2TDlXbWtXVzFJejhyVEJlNFc0?=
 =?utf-8?B?QVgvdEJRUytxQnBEZHU0b2IyUFZETEY5ZS9jZVM3K2tCeFJEek1XMHFSUWx0?=
 =?utf-8?B?cm5QMXZsZGxyN3VDY2JoSm9ORjFyTy9TelJHZEZHcmFXbE1KS0tFVno1QUZJ?=
 =?utf-8?B?OU9YNXhVbmZ6clRFT0pCamxidVM3MDJmakZRc3NtNTlHbTRoUDJaVFhKemo2?=
 =?utf-8?B?RnhINEd5Y21FYjNpNUJ0OElTWlNVdUZMSE4vMmV4M3VqQUR0SVlRamxVaGZG?=
 =?utf-8?B?Ky9MYy81c0hMdGk4cFJlQS9BbTM3WWt6dnJPaG5ud29GUTd1Si9rcVBUNnAx?=
 =?utf-8?B?bzdpR2dMTDV3SzhBMG5kREhqMnNJcE1iMU1Uc3N1VTNoM1c0L0kwWXBUY2hr?=
 =?utf-8?B?c0dWQStTczFyWmhQNXY0RldNWEl1ejVSbzVEdnhiaDhTSVByb3ZQUndtZ3V3?=
 =?utf-8?B?Lzg5YVZyK3BZKzFpZWZ2N2ZDZzBvY1hVbVpSNy9yTDdYcGtWbkFyZFg0aUw3?=
 =?utf-8?B?M0pEcmN0MWEwMUErU0pyWmlQMkxRUUp3d1RIenc3UHpVZVVKa2d2MHhaYlVx?=
 =?utf-8?B?VzM4V2p5RDR4SWVLUnRpOE9FalpXcXNBUHB2aHI1L1VWamE0S1BTeFBBSHpI?=
 =?utf-8?B?eVRjUnZmNjQwT2l0ZVYraXJlbngwM1ZCcW9xclhpNjFrMzl1MmdDamMvQ2RW?=
 =?utf-8?B?S2JVWm91T1VTYkRwYkp6QVpBbzcyOGJBZVBYVE1MWUNJam0zUkZIU1EvZ1R5?=
 =?utf-8?B?THJDMlQxbmpVNHpxY1AxZVAvSkwwaGZXemVjWWIwWEFCc3ZSZGJvSVlZei9i?=
 =?utf-8?B?RjA0TytmY1RrRFFYbUcza1U2ek1CQVZoT29CK1J1blhUZmlxdjBWbDBPa25y?=
 =?utf-8?B?SUtNS2RKZnhpZGdzU2JuWmgvQTZndTVxV3E0akVpMlVweWpvU1FPVW5rUnhN?=
 =?utf-8?B?WFJhRGg0bVh1VEQwZW1nUXFPWGVhcFNmTUtZVElaMnZDRkVhUHdYUURyWThG?=
 =?utf-8?B?UTRtWm1aNDVaZkpCM1F2U0dqSGVsWThURkRTWE9qL3duLzhERHJWM2hjcS9N?=
 =?utf-8?B?Q0REcDVxZk5yQ1pXcFdtSGVwVXZnbGwzdTlkZTh2aUxkWElkM2g0WUFPZ1Rw?=
 =?utf-8?B?MHQ1VVJZT2ZjMEdYVVJIUTRlRkxGWTBhem5hcDc1RVdpOUlrVEZ2OXd3M0Jy?=
 =?utf-8?B?RFp1U0liZVRhWVlnWEcyeFpqS3RnU0NxOUdna3VZRy8yNnhjSnBsbjljcEtj?=
 =?utf-8?B?Y01YeE54c255S28yL3ZZQnEzSVNjMVJEcm5IWU5JbE93dStjWmtGMDFTL2dx?=
 =?utf-8?B?TXVlM25wbVNVd0JZREZTakoyeSs1QUZ5NSszWmdHeHZ2bndzSnBtUEFPMm5E?=
 =?utf-8?B?dUhDcFJKS1lJZ0lIdU5JWjF0Z08xZE9xZFVCbDljV0NkT0VmVFdYR05qcFRK?=
 =?utf-8?B?SkRFbTl1T1NadmpLTmlQYkhEbW05TWFkdDVzVzFodTQ0d2phTFFqTS9OTlV2?=
 =?utf-8?B?TitTWHFWZHlLQ0ZLd01yQTdWa0psK3oyb1pyRnhPRzhzeHlNVlFteExGZzBT?=
 =?utf-8?B?aGgzUG9UNVg2NFRiakQxNTRvbDl5L3lEWEZiU0k0TVFnaWhxQS9TdWY2aGUy?=
 =?utf-8?B?L2ZKZXJoTUFNWEpkaVFMMWVyWG5QeUJaTU03aHBMRWxWcWxjbjNQSFlQUDZB?=
 =?utf-8?B?MkE0SlBjaDJoQmxOY01ZVHdoVC9XU2xyTE9odzQzSkU2RkFOZDBwUWdTL0Js?=
 =?utf-8?B?RmgrdTROMitkd1AyU0ZTbjRGNG9QcktxQWdWM0JlcDF2K0dDYUMvU1V6aTc0?=
 =?utf-8?B?Z096aXZmK2xzRysrM1hGKzMzRjRHUEJDQVRNNlE1Tkd6RkM5YU5TQ1NOejFL?=
 =?utf-8?B?Yjl5YStjVCt4ZmZ2QUttSU5KSUVQOGZZOFJWWHI5TUZkUnBhY1ZjZ3J3QW1m?=
 =?utf-8?B?K1c5RFk1bGNTdzZYRno4dUsyczR2V2lGNmN4NXZMOWtxS3RiLzdMcXFidjAy?=
 =?utf-8?B?VzNjNlA1MzlyRm84THdPaHg2SytZUkhtZDM3M21PQUFORk42UEZyY0dRa081?=
 =?utf-8?B?OWF5dU1hQTA2TXUvY2NWZVAzVU1ZMHJXUnliNzNWQUVLNkdVeEVNaWpWOU9T?=
 =?utf-8?B?ZUdJU0I4UEU2YkEzSVlXSW83cFB6eVVOWTgrbE1SWmpzUnNjT3QyU0dPNE5K?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d876a6f-5219-43df-bd74-08da7b7881f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 09:04:33.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06MlfQj7V0WOhU72+M1tOeOrvf9Av1L46NITziHKHTqPQnYdHQsrS4+zmxktVUfSYDUmYfYtW98wfYIIi7USgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110026
X-Proofpoint-GUID: UoOn5lhbnkxETcDt12sMl1PAh_vJ3iNl
X-Proofpoint-ORIG-GUID: UoOn5lhbnkxETcDt12sMl1PAh_vJ3iNl
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

On 11/8/22 6:40 pm, Marco Elver wrote:
> On Thu, 11 Aug 2022 at 09:26, Imran Khan <imran.f.khan@oracle.com> wrote:
>>
>> By default kfence allocation can happen for any slab object, whose size
>> is up to PAGE_SIZE, as long as that allocation is the first allocation
>> after expiration of kfence sample interval. But in certain debugging
>> scenarios we may be interested in debugging corruptions involving
>> some specific slub objects like dentry or ext4_* etc. In such cases
>> limiting kfence for allocations involving only specific slub objects
>> will increase the probablity of catching the issue since kfence pool
>> will not be consumed by other slab objects.
>>
>> This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
>> to disable kfence for specific slabs. Having the interface work in this
>> way does not impact current/default behavior of kfence and allows us to
>> use kfence for specific slabs (when needed) as well. The decision to
>> skip/use kfence is taken depending on whether kmem_cache.flags has
>> (newly introduced) SLAB_SKIP_KFENCE flag set or not.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> ---
>>
>> This RFC patch is implementing the sysfs work mentioned in [1]. Since the
>> approach taken in [1] was not proper, I am sending this RFC patch as a
>> separate change.
> 
> This design is much simpler and looks good to me. Feel free to send as
> a non-RFC.
> 

Thanks for reviewing this. I have sent non-RFC version of this change.

Thanks,
-- Imran
