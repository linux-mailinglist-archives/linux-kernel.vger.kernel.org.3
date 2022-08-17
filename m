Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB72596FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiHQNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHQNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:38:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971095B787
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660743520; x=1692279520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mQRv1ld77+vGqoheufHWofsP2s8jvQZ8PkmgDpgjB8=;
  b=F1XNFO/AVQtr6J4ljq6LNu/rdnmQW2/kY2zvYlslN8+qb0WWzVgFwrh5
   T3hN5Ed1wvWwo5FYAYaTAXnU4/2UKT9z9FCtpZy7vdz34Abipbh06B+9o
   lJBi6A6tvOe9F0t4iNIZTTqf0bn+UQ9lSA5QTJdnU8AuOVYIszMmMSgTt
   Feki/SDRZgU7dxgmpV4nWbn9yWb5NXka33/lcadFYmxgzE/nI47xpslOO
   YRJKQ+yjsIjjPsbbBGf52xMCRjYUoJ+QJUdvzTCm813krEoQKOIkfmtMk
   tgxmyxXASE0Qy32IcWcsuxcAGHUlmsfu6gEawKBWsIaMkwIU67qfIiTQ1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356488913"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="356488913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="636379768"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 06:38:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 06:38:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 06:38:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 06:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9+ZFiRk4eX3Nwr5eAoQrF/+DTXJNVHN77osP1ar1/ks6NgAU+KbpX5/7yaEzdJrUk70X3PAfWAeJMx5rZa1kLMDrBDTkPyzrs48QpsL5UHiq4N6OoFRe5cHDRByDKahajLSHWxgRoR1s3Ms4g1kJoC/Tv5EYmRw6WTefKLcP3ugnOqg5azFnyjGjPzXVxWKJWG+ftV8MM4YmYkS+Ld/rv1IIQIwnSDpVa9NZ0ayvhAHJT4lXfrzT2CfV9Gl2ZehP2cSotZWoeEaY1nekkFPIND5jx/UPjKSm5UneMjHdtnF04jwEugy1gYhycqoWCqRKiBr6mExgI3naYEQ7p8a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/ezUiA7v53O/fJkrfS5EpqqwUfwOJRRNoGaSAnK97Q=;
 b=c05q1JJIHQUzI9+AKbwoKeZrCVB04gLRmkIkBHvooLzr3xBhODn0f6sSCxwyvhrauIZuEwVG0WBAuAjajs0V5YNdGH0VPTRqaLOlvdxfonekfJjV09xcKCpPkMDQ02XFWBBcSuKQJ6LBvNBMUunuDwqwNrdLBYEoApnHhsSnA73O749EwyUaLWSv3doOKIWc+H2mI73HlOw7BwvtKZeup9JOBjn30zQmr3JnDpmHuGBNc0FUSQ/7mJonO9RRW0KmDfQ63uZzKyN+Vt43r8aSA4JHO/zQQeVg8MV/qJT7MMzTKhuA6oZuHjofHo8JpRQkU0YijcCYXjFTphRPxYs9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 13:38:37 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae%5]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 13:38:37 +0000
Message-ID: <2bfe31ed-ee7b-ab94-741b-0f6e970e95cd@intel.com>
Date:   Wed, 17 Aug 2022 15:38:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [RESEND][PATCH] ALSA: info: Fix llseek return value when using
 callback
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
CC:     Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>
References: <20220817124924.3974577-1-amadeuszx.slawinski@linux.intel.com>
 <7324df1d-0424-a589-f7c9-df089a6cbefe@linux.intel.com>
 <87ilmrauad.wl-tiwai@suse.de>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <87ilmrauad.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0096.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::37) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39217872-cfdf-485d-d46e-08da8055c97f
X-MS-TrafficTypeDiagnostic: MN0PR11MB5986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFsCE9TeN+Zny0c3X44hEpa5t18B7BkCHM2MZk8ofFAdky71smyCj/9NgGmGvvsGK7q+wtYOyl9CApaZD4xKZV0+tX4tMGIwquvLss6tEW6zOSayAHgDoK4KHbZvu/0IStBdW0kEH1JKiOruVbLQqhgytdzCmuGEa5xq4cJ7c1zW/96XZSuheluhRnfKKM0nyMO7j6EkIXy44lNFEEjeo+wrJR2tj65ZJ+AHrWMnDLf8lJrfchO359QIP5PBqPhaBeSwFT81NbIdRow6AVFvb3BMY6YTxkZZNu/0WjfL/++AzWiYBwbHfxAafP3/D2twl7kRNIcYq29T4sXbNLKSjPDS9iPBW9KgRoBYlL0htm4PkCnikS93+Tk43ay9MgaNlwbBvepZJB7sfN0qc5tfvk49kUcTwQWAqBEGVuO8FBpbbLg4zAM3HHZZMrXE/PcIBvPuw+hr40eLcV02QB6Te1jmC5WuRH/wwHDfCE5QUQ8u0pJIhaA8Njn6tSSLSKJe25jpwN4Lt+ovbI5Xyvvuy31dvFiq8kUZzLXWMBEyen9Ev8f4KFx6cgocuSrKbLicSWr2DzAlrOdUI3p6TlRglk40mAGNY+f0Jegkr98oDnYA6OQ8bzfqcl+ip34N39NApmF1UF7c8wNy8ror5FQYliOpTIB/WYmKPm6sKlSObsFk1QwL2skehUf3phJgZVOQPFVxNkReImVA7rtFVUUXlMXwpEqFQi8vbVBgaNMj3noUSBvO9ZGA7qkpwgM1F2Hes7v428XhSd/7f8DVEvHjnKWqZMKZMtwcJyPqnhPRv9TCIolurAtlQyFHh/JDwB8qtIu/10bk5SaxWkSjo7O9QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(376002)(346002)(44832011)(36756003)(31696002)(82960400001)(316002)(5660300002)(110136005)(66476007)(86362001)(4326008)(54906003)(66556008)(4744005)(66946007)(38100700002)(8936002)(53546011)(6666004)(8676002)(26005)(41300700001)(6506007)(6512007)(186003)(478600001)(2616005)(31686004)(6486002)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJEWkVGZ1dwUmtKTmZmc3BteDlVd1B0M09BM3hhMzdSYlV1eVNoOU1xcGZ5?=
 =?utf-8?B?TmlQckRGdnIwRDU0MVBBTVN3cFd5dEQ4UmtGWVkzWGYwYThNbFNubm1jbm93?=
 =?utf-8?B?ZllTUmZBMFIvZFJINDA3M1YxTDBqb0dNVnNBUVRMdEl3WUpBYnh1V2pNMnB6?=
 =?utf-8?B?eTFDbTlucEJWOC9EeEtWbzZFbVhYUi9UZngxdGIyL1Y3aHcrTnRpczgwdDNt?=
 =?utf-8?B?c3hpcWZ6UWVvTDdjV3NHSCsrUWEybEdTZWlMSTZEM1Q2TUdTMkxUMldzTUI0?=
 =?utf-8?B?RTE5Yzc0RGZ6bzlKQVQ2U2JObGFVamhCRGVaNWsvcHRWWmpsL0xCaDVSeXlW?=
 =?utf-8?B?bzM2S2orbnZOdkc2cmZONVo2cTRvRkx4bUkwTVRyNVMrc0wzL3lTRjk5U0s5?=
 =?utf-8?B?clhEQnF3OXQ4OHZHM0ZHMjczTzd6RHVDNTQ4VEhBZjhTWURnMXc1djBiWHh4?=
 =?utf-8?B?UWluSWtMYnZyVlo1S2VEa2J1M2NjcHZWa0F3OXRmSzI2a0lHU202Y1BNVno4?=
 =?utf-8?B?UTkzQ29raTFqN05qc3JrL0dQbk1Obno5MWlVWGk4Wjc2ZTRMeFV5SDdvSVFm?=
 =?utf-8?B?MFdEM2tjaUF3TmtVbUE2YXRveHExN09FZXpNYUVWakZCSUljSTlncWNaK3VL?=
 =?utf-8?B?bkNVeXA0aW5SU2lEejJlUVM4OW12QmhhWFlqbjhCTFVTcUJuOHlybitqeldr?=
 =?utf-8?B?Q0N4NjhaQkNPeW00M2NCakgyeEdKSEw0Q3F0dkt1d2RZSUsyR1hxaUdjWlQ5?=
 =?utf-8?B?QUZBV2FEMTQyMWhPUXkxQURGVHRGU0Fyd2NWVXh0UTM3cnp3TUxnZlVQNDdE?=
 =?utf-8?B?TVBVZlllQzl4bGo2RWxSZFoyWHE4K2VPa1FBaDBFcGMxRUExVkwvVk9XQ3VQ?=
 =?utf-8?B?aVBQU1AzYlVqOVBwK1lJeGR1c29FbjhuYjVSMjUwanhxVmJ6cWc0MDVhb0V3?=
 =?utf-8?B?TzlEM2d5QitWUzhycXlmT0RHQkxUK050NlhrNlJJRkJSM04zMzNYSDRiQXQy?=
 =?utf-8?B?WHJNSTU2M1ZwMHBSaUtOS3dCZjVDSXhzb3NHazNpVGFnMEl2VGVpMkdnMHh4?=
 =?utf-8?B?ajc3Z3NSL2RwVFowTXhtOWsrb2IwRXpWeVNUeGREaFFzbzBra3hUU1MrNkV2?=
 =?utf-8?B?aXNuS2JqSnFuNUl5Z2M2S1RtK21OUWRWQTFNREw1c0RDSGV3ZSs3aituN2dt?=
 =?utf-8?B?c0VaU2tsM0lqTGJsbzFSdlN2NUV3Vm5jQktadExFL3h0V3lGZWtxeVdyTWtj?=
 =?utf-8?B?QXk5a2hKeHBwZUppdVFhbnNPcGppVCtIZFZuTWZUNXlON3ljbVBidGdkaFpT?=
 =?utf-8?B?SmZLZ0JpNk4zd01KR0dWRkd5RXhYY0gxL0dlY2hUNkxhdHZUeWhCL2p4bFpC?=
 =?utf-8?B?eFpJNTlCZlRVc3JrN3hjaE9jQVNKTTFlb0tHQXorR3gxVTNzSGkvaEVxelc2?=
 =?utf-8?B?aGdZRmJQNVJ3YnFoSUMyYXZ1Z2V6ckJ6bTNrb1pPR1c5VDZTbVlrRG9va1l6?=
 =?utf-8?B?TGxBMTRxSWUrODlReFZ1eXo2UDAvbUNHZ3NVSitFY1hhTFZ0RUNDWERSR2wv?=
 =?utf-8?B?dFFFZXN2T25nakFlQThnQWtpZ0FTTXpkNmh6RlJ0WG1DUHBYZDdlTVIvbEF2?=
 =?utf-8?B?WlFpQkZxd0VFWXkrY2xzZ3VuT1JYOGVBd0diSGJmb2hMakxyV2twTjg1Z2Nn?=
 =?utf-8?B?TjBTUGhSSHZsTDB3ZWNLQzdxMW9nOWZPWG8rbloyVndPN1JEK212NEMvU1dy?=
 =?utf-8?B?SkVKZzhNalQwc3FCNXQzdytzZ0UzZ2VBMDR4UUJmY2xlZ3FHRVF6ZEJTemJy?=
 =?utf-8?B?akFRdTJWQ2tsb1BzUE1pMUZzZGdpanh5Z0hQMzVDZEhBeVlNS3pwTllwK3gw?=
 =?utf-8?B?ekdUM1I1SDdndG9jNE5WMzdaMGtzU0Y3NFNiZDJQZXhNSVhKQ1l0aTdJdVJH?=
 =?utf-8?B?M0R0T3VrN0pUUW1JZEo4MnAwY1k5d1JubURCTWQ3SGNERmlIZWVjMXNEL3Bk?=
 =?utf-8?B?L01VQXdmME80N2UyRVdRVVRaMFN5WlJqYjhqaEpscXJqeld5NXJwR1QzeTF3?=
 =?utf-8?B?YUFqcmxtQXV2ek5icDJVd0FlQjJsZmhuRnE2QzIzaHdHMGROK0FDT2MwZUZV?=
 =?utf-8?B?R1luMVZHZUt5NXMzVlBrakZNSzB4c0pMOFRGWDh6YWh4ZC9lYUJ4ZC9NMkdW?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39217872-cfdf-485d-d46e-08da8055c97f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 13:38:36.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB+kTfJMO4bh1/rA0I4IA1U3bru9ZK+9qa0awbE/h+Z+U5zVUeLJvunrOSXWuZkR9//NAIvjIOVsl8fwwpPz9rXfbrM3do0Wu1CGDt2yBEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-17 3:12 PM, Takashi Iwai wrote:

>> Doing resend, because I did copy paste mistake when pasting Takashi
>> email to git command, additionally alsa-devel blocked my previous
>> mail.
>> I've seen that Cezary already discussed this issue, and it doesn't
>> seem to be fixed, can this be somehow investigated? I guess we can
>> provide response we get from server when email fails?
> 
> It seems working now.  Jaroslav mentioned that it was some DNS
> problem.


Unfortunately the problem seems to still be there. Yesterday received 
"bad connection timeout" from Jaroslav (perex@perex.cz, other recipients 
were not listed) for "[PATCH 2/2] ASoC: Intel: Skylake: try to get NHLT 
blob with PCM params as fallback" thread.

And now my reviewed-by email for recent Amadeo's series - "[PATCH 0/4] 
ALSA: hda: Minor cleanups" - was not delivered to 
alsa-devel@alsa-project.org.


Regards,
Czarek
