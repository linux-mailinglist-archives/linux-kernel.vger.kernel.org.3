Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DDE5A4FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiH2PDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiH2PDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:03:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FEA84EC8;
        Mon, 29 Aug 2022 08:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y85hDrjzHNn+dbR2rcvb4BaDbWsUpg6f6bqvZPrgQ1MHCYoKxykD4Zj5rnS26gwR3PxKIJp9NHdZsavUK7cp44KWRBmkg+8D1zNfgq25u5Fz7HUnJwk1o4EY1WAzf0hmHH+Pg3HrGcaPTBUHtE2PsbyK5+qFn2A4LfUl3LKoiT3r8tN8JisVcmGS+CNkMJE8Bkm4zc63dWZuQlcsjrKuiK4ogDl5UE20klfDt6thMc0+7iasXjXks5FeZ2uxYAU8dydaKdzSBUtXjkFjOsnmHISi+XKyBVtcwhx+QI65vYyhFJ+1qsqMxvFeVijNyDAmcIWu7HHPM1AQD5QZMyWmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc3B1m5vih34fbDZq2lW3SE2ENcvGZFayBoewfruT1g=;
 b=Xyhd98LWVd6cLHFnEOJ7AKcl7qac+L9kRGtgjXfXx0brUYcH1d3fSwokPTsccdgk5/VSzwK05OF8E7EL2dzOld+oN5kwhej8hY4r8RS3KBsBX9Nrp8fvWLSdrBgTnx4s7xJf/ck/mmr9oeto0trkg7ti6ahrauesejW9u/FKQXcuYkRUjtvaiMYNiB56Wmnjib69T5jXXxxzRoRWr0xtKWR7GmOkp/BFEovcJiDhyCV/5KQCclH4i1tF0cTGiJdni1dqbvi1JsyurZ9pI0EtzyKBj7pA87R3c/fs2LIrE45iejzWH8/Qmzy70BJmEOs5seDFRt5+YPV8OSKYG79e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc3B1m5vih34fbDZq2lW3SE2ENcvGZFayBoewfruT1g=;
 b=cIxvpli6G1vX9dY2jUjaSECDcWQR/VndcqV82ObWqCNPdaTJi8QW/A260GF74wjZ9A7oioGoei/b3syjhKFOaG7AHbSwl5eA+vYRVqIRWdsJCh/oaH203Sv3ni9fX6m6SMC3/pEQ9WwSkc7yZsuvT1yoPoOV/XOIWz1cDVC7E8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 15:03:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:03:13 +0000
Message-ID: <94540126-0881-4501-6941-10bbe68a9610@amd.com>
Date:   Mon, 29 Aug 2022 10:03:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
 <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
 <UVMZGR.6LXKPONA9OS33@ljones.dev>
 <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
 <4e4c5234-3327-0e49-989c-1117ffb2f13d@redhat.com>
 <34bf5d3a-adb6-ce12-8c9c-ee9144f5262d@amd.com>
 <fda6b7fc-b307-f4f3-1176-6b15c639b3d0@redhat.com>
 <80a42677-81a1-dc97-5ee3-86c80c79500b@amd.com>
 <UTFBHR.7QAVRH751VBB@ljones.dev>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <UTFBHR.7QAVRH751VBB@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:610:11a::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 130107ab-c2d8-455d-2eca-08da89cf9815
X-MS-TrafficTypeDiagnostic: MN0PR12MB6197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SxyzAsbQDC5l1uWvt5kN1wRvOnMAh59GH50v8rFt9G92BcGKzBiggqZE759FwZrOA3Kj59CQkYFZQKoPPzFoH7mAD0VHvU8Wla+2ZyIedPAmsaF0mbe5DTC/L2rgkHaxIY+5F/bJbg525ufb89PsvCUD8H8bS/CHn8bAoIHPHT70yrD/VJJU7ybOc4zc6S3eymjvxnOzAUN9f3S1WZrrbzSV0lQXjhcS2orf9m/TX9lE5jHYafp9y2XTk09ZZQA/nR5qu+R795qP7+Dcki2vBR7HxlojAtGTJX0txFkARXcDLcvmIPv2aW3/B8ydNBe/gYZHWrOkYbYaBkkziC4LkFmcWANtJKwuXxl3tAtiyB+kKPFozJHshaWp8u7yCn5daoQPPpJ3/V1AwhFYPqjxL3nZUIuY3H0EGimb9vxHgI48Q/0ZymvEq26ownR8xwE1sZX9dt/C0TJ7bLeT8GPS/ZxaBFOUpOxcOaocG8bGNyVkmQL5qPHXk1yIkfkzP03aTRVLYV0qyZ+tfLNuhUsUkpbTFo//BbOA+s5SY4S+/K2J4ux16uVlia2Lgm9ZutMm2G59GF/5S/aNCXrZHtYjgTaSSKI5TIcw+2groqCJKdRfL8E366UrxEEXQMgALfhId1mGRSL13xwdu70gan/YGxY2fuVyJVjD3S2TQoLULojDUdE7/E8rJwQZ1vHwFrkP+s/CipER9hCM/S2eT+5Hx7lM9GlFd1HwssV7ztpKgAnIomMqvcZZLGYqnch8hJbGPGrCxid7oKsXAdIgkhbUIkJzatR5iY7f6kPFQQNZieaJiZ69GQcWeA2yZE9DtVq/jjVKZ7j/RfmoDGF0LYOCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(8936002)(186003)(2906002)(83380400001)(53546011)(6506007)(6512007)(41300700001)(26005)(5660300002)(30864003)(478600001)(36756003)(31696002)(6916009)(45080400002)(38100700002)(31686004)(6486002)(316002)(66556008)(86362001)(4326008)(966005)(8676002)(66476007)(2616005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BqRVQ4ZFR6amdlbnppWUFvVGdRR0wwVWVXcTVycTBxQUJvWWJTanFXUUFQ?=
 =?utf-8?B?Z094VFB6ZnhIblRpZVdzcHBOVVBjK094d0ZrVXZ0Q0htSXk0NXFvOVhiR1RP?=
 =?utf-8?B?UW04ZUVkcGpKSHFUT3BlSVZZTXNiSzh4M3JWbjB2WUEvcCt5UmtkYzhYaUsr?=
 =?utf-8?B?dFJ3MWV5Y1BJRlNDSExsYTVYUnRLOGp5REhla3AxTi9ZZGJQK3FMbHhZY1d4?=
 =?utf-8?B?eGxmV3FSd1NmeEpVMW5CMG5hdytuQkQwa2w1bk9iL0ZRZ2xXS2dlS3YweHp5?=
 =?utf-8?B?OXdVU3dyekoxSzRaMFZzNFQvLytZTVBxVC9PL2srSmQ1d1RLM1RSWGY3ZFg0?=
 =?utf-8?B?MlduRlgvcWVhakpISGtncVY1aWlHYkp5ZXFsZjk2aXJLUU5lTlBLMlIrMjB4?=
 =?utf-8?B?SVBDN1d3aHBUWUtONzVONWxDaThkVkRjTGx3WDBvcndyM1dvcURydm53WjRW?=
 =?utf-8?B?QVo1UklQZSs5UkZhcThkUVpHRGJBTWltekFkSXBhQTl1cGlkVENzR0dsWTcz?=
 =?utf-8?B?My9ZWVJGM3JmTWxJa1lodk1UWUJBU2dWODU3UnlGSE5oSEJIcnY3RFB1SkR0?=
 =?utf-8?B?RlpJWFZkSlI5dTNKQWdjLzFnTWZwbFpQQWxVTXUwdlBWRjhzZzFiNk9kMy9J?=
 =?utf-8?B?aktoUjdXSnBkQ0VoRmI4cWJ1SzgydCs2R2I4WHMwNm8xL0dPT1M3MlVXMGRr?=
 =?utf-8?B?VmdORTY1czJzUW9SRU5CT0U3amozWTNkS3NOU29HdUJvYVBqb1FaTU90NDJm?=
 =?utf-8?B?QUhJM3Y1SXNpTjF6TGVtdEVlMFpwNC9DTXVSOTViZndjalRhczJBSUJUUExn?=
 =?utf-8?B?N0tBMWV5MS9wU2dha1gvM1N5RVplbmVPOXBaT2dzTHdJUldpSVhoSDdYVVAy?=
 =?utf-8?B?SHo0L0k5bW9yZlcrZWxIU1prTEtlUjNHWTZueTRYMzcranBGRDJBMTlnTlVQ?=
 =?utf-8?B?SXBhMmNvRGdYYXNtUnlQTGRhUVRERGNVdTBVMTRrUVh1MExTbHlocVMyeThj?=
 =?utf-8?B?SjZHMnFzT0hJNzc4R0Z3UmRoYW0xMTIxTWlMVUhxc1owd0V6TnQ0Q3A4Y2RY?=
 =?utf-8?B?bURCa3lWazd6U1ZCZmJJbzFrWE9PMXlwaU5TbFZpdGdyUVNqZSt2ZFlwbE0y?=
 =?utf-8?B?MHErSEVGODhIVkFrUEUyMmRUMnU5cUY5N3RkOCtpMlQzVm5DVHRweXNla08r?=
 =?utf-8?B?TWxCMmJsL0dJd0R1SUMvUk10SXBFV3k0WFdta1ZSNERKMDFqSEhYL0dTT0ZQ?=
 =?utf-8?B?NW5zSXZjNEQyKzk0VjQwL2NFNUc1Q2FSSnhtQnBqTVBrOGtCYUJFczZheUw3?=
 =?utf-8?B?TzNacVpySFRHbGZpNVdEN3FKTXdVdlF3MUdTNlBEVENmMkJIN1hJRTdiaHIx?=
 =?utf-8?B?ZmVMb0RDcjJuTVBKZ3ErSzZ5Y25LY1U4TTU4SVBZd1JnWXdVT1NIdTZtRkdt?=
 =?utf-8?B?aG1tV0pUU3ZrSWg5RU11d2VRY0FMQkVOZW1vaGUxU2RDV3FQekJhWEozL2Ur?=
 =?utf-8?B?WGE4MGtsVkFyQkRIMi9yWk94US9pa3hGYjZwaEZ3RE5vS3J2UTFGNFdEZU54?=
 =?utf-8?B?VUpYa0xUeFBFUnpCNnJjeXlTcHljaG9LTFMvSzVWekVuTDFLb1FsdmN6cXZH?=
 =?utf-8?B?cmlZTVJyNUpiZkN5VUp0Um0yakRXUU9ZdmFxVmFJdlFkcVRHNE9tbFU2ZVBF?=
 =?utf-8?B?a2Q5QXhpZWhnbUYxR1dFTlVpN045RDlhL05oTytCNk9lSnRsdDdxanJLZk5H?=
 =?utf-8?B?OGF2ekdBbTRoaFRQcjcyWGF0bkdIZlBPSzNBUlUwNm1pQVh4aHRZN2NOWmIy?=
 =?utf-8?B?WHQvN05hWnJMMVVOZkwxVUtTWGw1eGdZdjNCQityY0JDMGZYNW5aVWU2Y1V3?=
 =?utf-8?B?ME5CUFdTYyt0aEhZWjJIbUR0L3NhR0NQaUVJelFiaVc0MDV1M0RDcjRWamUy?=
 =?utf-8?B?NDZWL21tZlUwUjFCS1gzb0pFZFREZ3ZLcGYvVmhETDIwcUhxOUpWOXl2aU92?=
 =?utf-8?B?aTBydkc1K1lIZlBzcWg0QXcwQ1ZLOEdaOWxUSFFKYW84UUlrbFNtdFhacDgz?=
 =?utf-8?B?cEQ1dlhYSUxRQXZTSzNJUzJCN2FYSkhaL2xOUW1SaVM4TWNUTjZCYk04S05K?=
 =?utf-8?Q?RwHu2wUVsWnimy+hi3e2ieJh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130107ab-c2d8-455d-2eca-08da89cf9815
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:03:13.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhrDNO5AKdhAoi06kF4xOYJ3hgcaVTe61f9I6CJbwO/+RIzBoXgkCf9eEmRs1gpDjrmDlFnh6uVbCFcYkKrF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2022 03:05, Luke Jones wrote:
> 
> 
> On Wed, Aug 24 2022 at 08:09:08 -0500, Mario Limonciello 
> <mario.limonciello@amd.com> wrote:
>> On 8/24/22 08:03, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/24/22 14:53, Mario Limonciello wrote:
>>>> On 8/24/22 07:40, Hans de Goede wrote:
>>>>> Hi All,
>>>>>
>>>>> On 8/22/22 17:43, Limonciello, Mario wrote:
>>>>>> On 8/21/2022 18:07, Luke Jones wrote:
>>>>>>> Hi Mario,
>>>>>>>
>>>>>>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello 
>>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>>>>>>> Support the hardware GPU MUX switch available on some models. This
>>>>>>>>> switch can toggle the MUX between:
>>>>>>>>>
>>>>>>>>> - 0, Dedicated mode
>>>>>>>>> - 1, Optimus mode
>>>>>>>>>
>>>>>>>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>>>>>>>> mode switches the system to have only the dGPU available.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>>>>> ---
>>>>>>>>>     .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>>>>>>     drivers/platform/x86/asus-wmi.c               | 62 
>>>>>>>>> +++++++++++++++++++
>>>>>>>>>     include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>>>>>>     3 files changed, 76 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi 
>>>>>>>>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>>> index 574b5170a37d..03124eab7f01 100644
>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>>> @@ -58,6 +58,17 @@ Description:
>>>>>>>>>                 * 1 - overboost,
>>>>>>>>>                 * 2 - silent
>>>>>>>>>     +What: /sys/devices/platform/<platform>/gpu_mux_mode
>>>>>>>>> +Date:          Aug 2022
>>>>>>>>> +KernelVersion: 6.1
>>>>>>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>>>>>>> +Description:
>>>>>>>>> +               Switch the GPU hardware MUX mode. Laptops with 
>>>>>>>>> this feature can
>>>>>>>>> +               can be toggled to boot with only the dGPU 
>>>>>>>>> (discrete mode) or in
>>>>>>>>> +               standard Optimus/Hybrid mode. On switch a 
>>>>>>>>> reboot is required:
>>>>>>>>> +                       * 0 - Discrete GPU,
>>>>>>>>> +                       * 1 - Optimus/Hybrid,
>>>>>>>>
>>>>>>>> This feel like it should probably export using 
>>>>>>>> /sys/class/firmware-attributes.  That's exactly how those types 
>>>>>>>> of attributes work.
>>>>>>>>
>>>>>>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it 
>>>>>>>> and you don't need special documentation.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>     What: /sys/devices/platform/<platform>/dgpu_disable
>>>>>>>>>     Date:          Aug 2022
>>>>>>>>>     KernelVersion: 5.17
>>>>>>>>> diff --git a/drivers/platform/x86/asus-wmi.c 
>>>>>>>>> b/drivers/platform/x86/asus-wmi.c
>>>>>>>>> index e2b51b5550e8..0421ffb81927 100644
>>>>>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>>>>>>           bool egpu_enable_available;
>>>>>>>>>         bool dgpu_disable_available;
>>>>>>>>> +    bool gpu_mux_mode_available;
>>>>>>>>>           bool throttle_thermal_policy_available;
>>>>>>>>>         u8 throttle_thermal_policy_mode;
>>>>>>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct 
>>>>>>>>> device *dev,
>>>>>>>>>     }
>>>>>>>>>     static DEVICE_ATTR_RW(egpu_enable);
>>>>>>>>>     +/* gpu mux switch 
>>>>>>>>> *************************************************************/
>>>>>>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>>>>>>> +{
>>>>>>>>> +    asus->gpu_mux_mode_available = 
>>>>>>>>> asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>>>>> +
>>>>>>>>> +   return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>>>>>>> +                  struct device_attribute *attr, char *buf)
>>>>>>>>> +{
>>>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>>>> +   int result;
>>>>>>>>> +
>>>>>>>>> +   result = asus_wmi_get_devstate_simple(asus, 
>>>>>>>>> ASUS_WMI_DEVID_GPU_MUX);
>>>>>>>>> +   if (result < 0)
>>>>>>>>> +       return result;
>>>>>>>>> +
>>>>>>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>>>>>>> +                   struct device_attribute *attr,
>>>>>>>>> +                   const char *buf, size_t count)
>>>>>>>>> +{
>>>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>>>> +   int result, err;
>>>>>>>>> +   u32 optimus;
>>>>>>>>> +
>>>>>>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>>>>>>> +   if (err)
>>>>>>>>> +       return err;
>>>>>>>>> +
>>>>>>>>> +   if (optimus > 1)
>>>>>>>>> +       return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, 
>>>>>>>>> optimus, &result);
>>>>>>>>> +   if (err) {
>>>>>>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>>>>>>> +       return err;
>>>>>>>>> +   }
>>>>>>>>> +    /* !1 is considered a fail by ASUS */
>>>>>>>>> +    if (result != 1) {
>>>>>>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 
>>>>>>>>> 0x%x\n", result);
>>>>>>>>> +       return -EIO;
>>>>>>>>> +   }
>>>>>>>>> +
>>>>>>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
>>>>>>>>> "gpu_mux_mode");
>>>>>>>>> +
>>>>>>>>> +   return count;
>>>>>>>>> +}
>>>>>>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>>>>>>> +
>>>>>>>>>     /* Battery 
>>>>>>>>> ********************************************************************/ 
>>>>>>>>>
>>>>>>>>>       /* The battery maximum charging percentage */
>>>>>>>>> @@ -3165,6 +3219,7 @@ static struct attribute 
>>>>>>>>> *platform_attributes[] = {
>>>>>>>>>         &dev_attr_touchpad.attr,
>>>>>>>>>         &dev_attr_egpu_enable.attr,
>>>>>>>>>         &dev_attr_dgpu_disable.attr,
>>>>>>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>>>>>>         &dev_attr_lid_resume.attr,
>>>>>>>>>         &dev_attr_als_enable.attr,
>>>>>>>>>         &dev_attr_fan_boost_mode.attr,
>>>>>>>>> @@ -3195,6 +3250,8 @@ static umode_t 
>>>>>>>>> asus_sysfs_is_visible(struct kobject *kobj,
>>>>>>>>>             ok = asus->egpu_enable_available;
>>>>>>>>>         else if (attr == &dev_attr_dgpu_disable.attr)
>>>>>>>>>             ok = asus->dgpu_disable_available;
>>>>>>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>>>>>> +        ok = asus->gpu_mux_mode_available;
>>>>>>>>>         else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>>>>>>             ok = asus->fan_boost_mode_available;
>>>>>>>>>         else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>>>>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct 
>>>>>>>>> platform_device *pdev)
>>>>>>>>>         if (err)
>>>>>>>>>             goto fail_dgpu_disable;
>>>>>>>>>     +    err = gpu_mux_mode_check_present(asus);
>>>>>>>>> +   if (err)
>>>>>>>>> +       goto fail_gpu_mux_mode;
>>>>>>>>> +
>>>>>>>>>         err = fan_boost_mode_check_present(asus);
>>>>>>>>>         if (err)
>>>>>>>>>             goto fail_fan_boost_mode;
>>>>>>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct 
>>>>>>>>> platform_device *pdev)
>>>>>>>>>     fail_fan_boost_mode:
>>>>>>>>>     fail_egpu_enable:
>>>>>>>>>     fail_dgpu_disable:
>>>>>>>>> +fail_gpu_mux_mode:
>>>>>>>>>     fail_platform:
>>>>>>>>>     fail_panel_od:
>>>>>>>>>         kfree(asus);
>>>>>>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>>>>>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>>> index a571b47ff362..c023332842a2 100644
>>>>>>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>>> @@ -98,6 +98,9 @@
>>>>>>>>>     /* dgpu on/off */
>>>>>>>>>     #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>>>>>>     +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>>>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>>>>>>> +
>>>>>>>>>     /* DSTS masks */
>>>>>>>>>     #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>>>>>>     #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>>>>>>
>>>>>>>
>>>>>>> You can see previous discussion here 
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C92a9d94ff13d46f453b608da88cc2e2e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637972707813632096%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Lr6UVW5cxrkItsWMLtI2M7NcaqoEVDCubajSA75K%2FwI%3D&amp;reserved=0 
>>>>>>>
>>>>>>>
>>>>>>> Below is Hans response verbatim:
>>>>>>>
>>>>>>>    > Yes it sounds like a BIOS setting is being toggled from within
>>>>>>>    > Linux, which would normally be done through the
>>>>>>>    > "firmware-attributes" class, but all existing 
>>>>>>> "firmware-attributes"
>>>>>>>    > class drivers allow changing all BIOS setting not just a single
>>>>>>>    > setting, so using the  "firmware-attributes" class here is 
>>>>>>> not really
>>>>>>>    > appropriate.
>>>>>>>
>>>>>>
>>>>>> Although the two consumers thus far (Lenovo and Dell) use WMI 
>>>>>> interfaces to build and discover varieties of settings there is no 
>>>>>> requirement for how the backend for firwmare-attributes works. 
>>>>>>  You can just as well poulate a single attribute statically from 
>>>>>> your driver.
>>>>>>
>>>>>> So I guess Hans and I disagree here.  I have a feeling that we 
>>>>>> shouldn't be introducing custom ABI to userspace just because only 
>>>>>> "one" setting is offered.  I anticipate that some day the DE's 
>>>>>> will offer a GUI setting built on top of fwupd which is built on 
>>>>>> top of firmware-attributes.
>>>>>>
>>>>>> If you *don't* populate a setting with firmware-attributes the 
>>>>>> only way that users will discover such a setting is by installing 
>>>>>> other custom userspace software that has the knowledge of it.
>>>>>>
>>>>>> At the end of the day it's up to Hans and Mark though, this is 
>>>>>> just my 2c.
>>>>>
>>>>> Mario, thank you for your input here, it is much appreciated.
>>>>>
>>>>> As Luke mentioned in my quote using the firmware-attributes class 
>>>>> for this really seems like overkill. As for discoverability, the 
>>>>> firmware-attributes class only standardizes how to enum / change 
>>>>> BIOS settings. The consumer of the API still must now the name of 
>>>>> the setting which can/will be different per vendor.
>>>>>
>>>>> AFAIK fwupd only uses the firmware-attributes class to check for / 
>>>>> disable some BIOS flashing protection. So having the GPU mux 
>>>>> setting in the firmware-attributes class is not really relevant for 
>>>>> fwupd.
>>>>>
>>>>> If in the future some generic tool which uses the 
>>>>> firmware-attributes class to toggle GPU muxes is created 
>>>>> (presumably with a lookup table for the exact setting's name under 
>>>>> the firmare-attributes API) then we can always add 
>>>>> firmware-attributes support for the GPU mux to asus-wmi at that 
>>>>> point in time.
>>>>>
>>>>> I just don't think it is likely such a generic tool will happen 
>>>>> (any time soon), so for now I still believe that using the 
>>>>> firmware-attributes class for this is not necessary.
>>>>>
>>>>
>>>> Actually I've been actively working on that.  Take a look at fwupd 
>>>> main (what will go into the next tagged 1.8.4 release).
>>>>
>>>> It's got support for "fwupdmgr get-bios-settings" and "fwupdmgr 
>>>> set-bios-settings" which will follow the rules the kernel API uses.
>>>>
>>>> So I expect that if this attribute was implemented as I suggested 
>>>> you could do:
>>>>
>>>> # fwupdmgr get-bios-settings
>>>>
>>>> and find the mux (including the possible values if it's declared a 
>>>> kernel enumeration attribute and possible_values is populated).  If 
>>>> you populate the optional description attribute in the kernel fwupd 
>>>> will show you what your enumerated settings mean.
>>>>
>>>> followed by:
>>>>
>>>> # fwupdmgr set-bios-setting dGPUMux iGPU
>>>> or
>>>> # fwupdmgr set-bios-setting dGPUMux dGPU
>>>>
>>>> To set it.
>>>>
>>>> fwupd will prompt you to reboot the system after it's done changing 
>>>> it as well.
>>>>
>>>> It's implemented such that GUI clients can use libfwupd just the 
>>>> same, and I really think this increases discoverability of such a 
>>>> setting.
>>>
>>> Interesting, I must admit that that makes your argument for using the 
>>> firmware-attributes class stronger.
>>>
>>> But in the end it IMHO still feels wrong to add firmware-attribute 
>>> support for just a single setting, rather then for something which 
>>> actually exports all or most BIOS settings.
>>
>> OK thanks for your thoughts.
>>
>>>
>>> So for now I'm going to with this patch as is. If eventually it turns 
>>> out that having this inside the firmware-attributes class would be 
>>> really useful we can add it later, while keeping the sysfs attr for 
>>> backward compat. My thinking being here that the code for the single 
>>> sysfs attr is quite small, where as adding firmware-attributes class 
>>> support will be more involved
>> At least looking at the context of that diff I see a whole bunch of 
>> settings listed and this is "just one more". I noticed:  "eGPU", "lid 
>> resume", "ALS enable", "fan boost mode".
>>
>> Maybe a later follow up should implement ALL of these as 
>> firmware-attributes but keep compatibility for sysfs.
>>
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>
> 
> Hi Mario, Hans.
> 
> Quite a bit for me to follow here. But going from the gist of it all I'm 
> not opposed at all to implementing support for fwupd. I realise we 
> already have a series of attributes under the wmi sysfs, and there will 
> be more added - but in the first instances of this I (personally) wasn't 
> aware of fwupd and who it was aiming to enable this, and secondly it was 
> a very fast way to bring up support along with being easily discoverable 
> with udev libs.
> 
> Unfortunately it looks like it is going to be a large body of work to 
> start doing fwupd support, and I'm not likely to have much time for it 
> although I'd love to do it. I may well have a go with a single simple 
> attribute and see how it works out, but man I wish I was getting paid 
> for all this so I could justify the time cost.

I'm not sure how much effort it really will be compared to a "regular 
attribute".  It's just controlling where it gets put and what sysfs 
files are exported.

I would think it was a subset of this kind of stuff:

Get the class:
	ret = fw_attributes_class_get(&fw_attr_class);

Create the device:

	device_create(fw_attr_class, NULL, MKDEV(0, 0),
			NULL, "%s", "asus-wmi");

Create a kset:
	kset_create_and_add("attributes", NULL,
			&class_dev->kobj);

Create a group:
	sysfs_create_group(kobj, &group);

Create sysfs files:
	sysfs_create_file(..);
	kobject_add(...)

Various cleanup stuff:
	device_destroy()
	fw_attributes_class_put()

think-lmi's implementation is easier to follow (tlmi_sysfs_init) for an 
example.

> 
> Mario, as I seem to be the single person adding support for various 
> things with ASUS gaming laptops, please feel free to CC or email me (in 
> addition to others) whenever required for the ASUS stuff. I tend to 
> stick to the gaming laptops for now however (as I have two kinds I can 
> test with).

It's too bad ASUS doesn't do any of this and only you do in your free time.

> 
> Kind regards,
> Luke.
> 
> 

