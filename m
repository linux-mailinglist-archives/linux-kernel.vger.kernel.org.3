Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04358C58A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiHHJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiHHJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:29:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693613FAD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwolzdgNqannMZh2+rAga4q38vyhqJAg3/rsDbJ999U2V2As1mJ5IOvhGGrAqjHtvmoQSv/9uQRsiZ3CKYqLrBKjZtIyrc62P3THPTQ37PjYjX0c2xpySMOsbD6fI0+cV2cAhDjqGTbMlFClq4pasWChU/OaGbT0rdbznF614CTN8KLtCwELMLBc8IMjK0tVdsvwEndZK7K7ISLQ7nOobZdpk0aNXmpa4/DUXQXxxtCAb/1BkZYGx/HZIbDlZNsGuuCzDZAlsXy4G3InsWQAcOna9DqLgI+Z8cBEh1GNyh/NnrdjoRsm7HvJ/zGRmIWfIktiMLoQalz+ULa1VarY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC8Dk56csW+/D9IAyE36BUXV3oi3nX+YD7G4MjPQ30E=;
 b=AkNVfWpR+VdQZ6lVXmAhHzMa2DaDI2rotIOFr4w/UAIffU4V2dAtHY4118QTHUpRNfJQaG3O6mLkv/pKshsGEcsev/z2TnLcJDYo38VVrgyBFpJHjnzMP5ETJ08awvRwsMzxEA3CaPo04bl5cvdxhsSuYIdi+4x6re6dReL5T+cslT/FXUL7m2Ayl1PmWVxk0Osf8c+Mk2W4UKmdibfULWropytnh8BC5SZHFAzU6AhBNeuf4ZShZjPVPrqVgFNpjYseA2rIxXeLdl18xm2U2WurIFtgu3/O013ZbY/G/ImD431j1SjajVAnGn3BA7UNqYthD7JVMcVO8xeFIPfUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC8Dk56csW+/D9IAyE36BUXV3oi3nX+YD7G4MjPQ30E=;
 b=VMCZDI9C04KbMPhQQbze3zN2XjOH28MrNiGUJG0aQqt5qagcdfsP7/aUlXlNq24S5QEZpn7ZCc1TyWmpjzZdj3kT13wE7+JE2Pri7TpxM8GRPr9uavOwIKe882DqkZK0W3uOBKcb9TjOJpos884Gv8uyT7IeZfWNU6U2vOdJrH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 8 Aug
 2022 09:29:28 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 09:29:28 +0000
Message-ID: <deaffe26-d164-cf59-5847-f80ee4437dff@amd.com>
Date:   Mon, 8 Aug 2022 14:59:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [BUG] perf/x86/intel/pebs: PEBS timestamps overwritten
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, ravi.bangoria@amd.com
References: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
 <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688ae933-c37e-4125-ebf7-08da79207da3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAsMAbbNtNcq5zAWthDtk18yLSqGIQ1pfEQCAvNeawlHqMpz2VgK/Kq1t50K087Vkrl4xTGJTie+ctN/UOp+ofVWE2uy5ElessRxGQ8LEb5YhIsVnCizWMYRIDQfGryVhy0pw2/4lJQIE4q8mEv79ZcE1TBfJypHO2utMctHRGE6T83PVtkxOofh+pVJ1fbdVqShMjMaPRlh5sPaFEGERr1B3qTZMHT7tyV7yTx8fhc59uM1nn9M4KyOwV+XDj42d9d7SAJCCuOL5+AkHgdnqTbx4p/+9x3jkgp75Kr+JYZWx9AxhHG7JgiyvioUb3zKzwAqNCeira7FPUWLLr4ZE1BJ3ZoyWyw9p3kEEJgh6+RFN2kOfX1d6/DMsMeOt2HD8Q1YIzC2wh1SG9IwWWqx5cwfFtXbdW+dk6YwTr09VHtfqLX7w47580I92UyqzsIXJLMFWeGduIrnvuQN9zKDD6m9mahtRCmHEbewkosWECuuWPiPaa3+vazAPuEyenMLzCiPF3wQxuDYWOA1vRjqBGddekOaZlIj2D/o3fuEwIvhcyJAKFDJQQhSbU6HRS3zfxl9iTPBJieDuEljiD+ho9cbidirX9eTfuO+IH6WkGoRdDq74aDuj0tPzPi7x6agG8pymE62TFZodofxW3lDUbByhfvuAfdeB6S32byD4kOSRw4qh3QLMQNJE3q51b8IuJlciO6I40oFSCi1qUtDKXeG/lmHBOjcaO/c8jee7YXxKEDSYRtzy/WaOd/0YlbGyRYc9m5uO890rgv9PZ0L9aGBCRQstzViCESssA5a0+T0afC+u37vLzldb/PIR0sOE4mmfZaGV+8dffa36k12oA3hDKlrYPK+aXB/wIDyXRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(186003)(2616005)(53546011)(5660300002)(478600001)(6486002)(966005)(66556008)(66476007)(66946007)(6506007)(26005)(8676002)(6512007)(31696002)(86362001)(36756003)(31686004)(6666004)(41300700001)(44832011)(83380400001)(2906002)(54906003)(4326008)(8936002)(316002)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlTckF0TWt6OTNkclVYeDFoQk45czFBcGI4dVphMDNBS0RXb25XU3BuS1Nh?=
 =?utf-8?B?clBUK0Y4RVAzTGQvWmdJc0k0bUtuUDBjRm1XK3dkZVhEZml4L1EvdnBjL1Bo?=
 =?utf-8?B?RXplRlpBdzBGNUdDRE5XSWFTUlBRK2o4ejlPelN4QTJ4UmtGWXBZb1BhWFZr?=
 =?utf-8?B?dXBJVi9EVHcyeTUvbkRCY3VSbUJyVVF1cG1JN1hSUnBYMm1lQTBKZ2hsbTFH?=
 =?utf-8?B?VUlWbGtwdlczWjk0c2JnWmwzTmJoc0dycnpXYW9XWkF5d0VVeXdrSzU0RXhx?=
 =?utf-8?B?V2pweVVaNlYzTENER1dLTVFYbGo1K3dJdUZud0w4WW1VUkFtMzBCd1kralo3?=
 =?utf-8?B?SVVTN0N6VWIwc2wyaGREZmdBVFNmYmFBQVhSbkRkbmNXVTBUTS91NUk0b0Zz?=
 =?utf-8?B?MzhicDhMQmFad3lPdlNMZnRvTTV2d3NRVWQxUWtuK0gvNHQ0SmVhSnZkQWVW?=
 =?utf-8?B?WUF3TVlHQmRlcklhdUtZNnBEOERhUk5QM1pQWEVRaTUycTFKay9YbEVRMG5B?=
 =?utf-8?B?N21uMXJ1MHZJaVJia1VRVzE0NXhOclZxTzBCbVQwc0tyTHE1TXZaR0dNSWtP?=
 =?utf-8?B?VTkzK1Fjb3FaTyttdHhxNFdYejRiZXdyN2t6NnlZeW5rM1ZIVmZnNG5JOFlw?=
 =?utf-8?B?Njg0c1JsY1RlS3gxZ1VzVmtndlA2aDFNSWhTbkRaNmJ0WUxPQ1N4NUV2cVFy?=
 =?utf-8?B?Ky84bEVOTUNqS3FsUFlveGMzYjVpb0hxcDdhYUp1VkhoUmxXamo1aDJKd3Vm?=
 =?utf-8?B?Q3Y0V01meSs1dDBKdDVlQlNMUjRpWWZVMUdaQWh4MVlLR0J4c29zZVVnaVow?=
 =?utf-8?B?TzN2SUZMRmMrTFRtblo4dFl5c1NtTHhGVlBEcllvQ0tldVBtanZvSkFzcTBr?=
 =?utf-8?B?QTRwMG9xNG1nd2NxYlZJV2xRaUhINjlPVlkxRHJEOHpPUWlVOEdTVXpqVWIv?=
 =?utf-8?B?akZ2NHAyclEreGhKaDExSy8wZWEwK1p4R1R6dEd6REJyYXNOclhFa2pSNnl0?=
 =?utf-8?B?RTd0bHVxMXFwbHUweG9RWEhwdk1IZDQ4cElzTUhMcHFnNVVweFNtc2FtRmVt?=
 =?utf-8?B?S1N6WHl0c3ZDN3NuZEF3Y2cxTWYvMVVFalczdi9HNGFrakYxRjVlWEdqUldx?=
 =?utf-8?B?eHVhYS9KaS9SekpIY25aMUxCWDRHaFhCaWhxOVQ0eTNBV2tQelc0Q0lHMThu?=
 =?utf-8?B?V21aWXBtd2VIMEFwaWtKMFJrdUdIUVh6dVlSY1VwNmxZMjRhR2Eza2ZoV2Q2?=
 =?utf-8?B?dUM4WjVpYklMdGJLWjZJYkJ5SHk2Y2Ywa2pFTEdwT3BuVC8vYytPa004MklZ?=
 =?utf-8?B?ZytSWEUyMTk0cmNvaU1vVWFoNzJLa1NJUit2VTdQL0NnME5SR0JhZDNJNTBN?=
 =?utf-8?B?NjBNQWwyK08xcFV4STkxK01McDRCNFNMeWFkTjJseWxpeVZKUXc0NW1saVhL?=
 =?utf-8?B?ZnJmNitSRkg0QnYrQU8yVys3UXR5ZnM0eTBCTnBRTWdoZFIrRG91VHhXRkdQ?=
 =?utf-8?B?QWZPbElGVjZrK3QwTm9EaHZiQ09CRmFxMEJNNEFxb2tZSkRYMzB5SGtzVCth?=
 =?utf-8?B?RnhOWTZYRmRPTGVVYmswL3hBOHY0YXppQ1FWNEt6VDhQTDZvZCttWVFpRGlI?=
 =?utf-8?B?YlZTSVJwbmg3N091ellucUR0OXZHdm9GTEZ0THdBa1hucEcxRXFmVi81L1VP?=
 =?utf-8?B?ekVWVDBnYUR1MkpnT3ovaVp2WU0rbE9xbWVuMDUwSXorQUdESlNLNldSdnEy?=
 =?utf-8?B?SkVuaFNRSnRNK2gzaU8yVWEzZkVKV3VlMTlMekQ0VUtMT3oyRG1BNTJBelBy?=
 =?utf-8?B?SGZNMUc3MStMNVgxbFMzU2RNTDV6eDRIOGZLTW5ibEo2c3FNNEUrd3kwZUo2?=
 =?utf-8?B?TEVodFViZTN1eVpOUGdlSm5UWjV4OEpaSjF1T3lLQ2lpdzVKY29ENFVTKzRy?=
 =?utf-8?B?RzhlRzVuUnBucm5oaGNvc3ZCM2pOMGxRNzhhdSt1RWdEYm5CUzB6Y05zc0Nx?=
 =?utf-8?B?bkgyajcrc0R4bVVxV3d1OXFCQWpsbVM2TzF6K3BieWM0SkZad1FiY2FmdmJN?=
 =?utf-8?B?WW5RZDZhWEp1MDRRcFgycGpCZFZWU1Z3UHZINDN5VU1XcUk4U3pZU0wxOXZo?=
 =?utf-8?Q?4WapjGycGFhbOw9t3Ar6DQDuR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688ae933-c37e-4125-ebf7-08da79207da3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 09:29:28.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElZ7r3LdZ/BV7IZtTlbCjn5tCggxNffS8Y9kW1+blGJQK2YGMk2Wj77e8kb3v/mze8itECQ1eM9DLmqkEHlfmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Aug-22 7:06 PM, Liang, Kan wrote:
> 
> 
> On 2022-08-05 6:49 a.m., Stephane Eranian wrote:
>> Hi,
>>
>> I was alerted by an internal user that the PEBS TSC-based timestamps
>> do not appear
>> correctly in the final perf.data output file from perf record.
>>
>> After some investigation, I came to the conclusion that indeed the
>> data->time field setup
>> by PEBS in the setup_pebs_fixed_sample_data() is later overwritten by
>> perf_events generic
>> code in perf_prepare_sample(). There is an ordering problem here.
>>
>> Looking around we found that this problem had been uncovered back in
>> May 2020 and a
>> patch had been posted then:
>> https://lore.kernel.org/lkml/e754b625-bf14-8f5f-bd1a-71d774057005@gmail.com/T/
>>
>> However this patch was never commented upon or committed.
>>
>> The problem is still present in the upstream code today.
>>
>> 1. perf_sample_data_init()
>> 2. setup_pebs_fixed_sample_data(): data->time =
>> native_sched_clock_from_tsc(pebs->tsc);
>> 3. perf_prepare_sample(): data->time = perf_event_clock(event);
>>
>> The patch from 2020 (Andreas Kogler) fixes the problem by making the
>> assignment in 3.
>> conditioned to the value of data->time being 0. Andreas also suggested
>> an alternative which
>> would break up the call to perf_event_ouput() like this is done in the
>> BTS code allowing
>> the prepare_sample() call to be made before PEBS samples are
>> extracted. That would
>> generate some code duplication. Although this approach appears more
>> robust, the one
>> issue I see is that prepare_sample may need data that would be filled
>> by PEBS and
>> therefore it would  need to be called afterwards.
>>
>> Any better ideas?
> 
> I think Andreas's patch is the most straightforward and simplest patch
> to fix the issue. But, if I recall correctly, Peter prefers to minimize
> the cachelines touched by the perf_sample_data_init(). So initializing
> the data->time in the perf_sample_data_init() seems break the rule.
> 
> I think HW will provide more and more such kind of precise information.
> Maybe we can use a flag variable to track whether the information is
> already provided to avoid the overwritten.

fwiw, we had similar quirks in the past. For ex: __PERF_SAMPLE_CALLCHAIN_EARLY

Thanks,
Ravi
