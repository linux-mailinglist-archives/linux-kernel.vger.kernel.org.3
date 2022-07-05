Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2700A566B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiGEMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiGEMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:02:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4918378
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657022527; x=1688558527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCkQYT6nXowoXv9bKzb0aaLlc49SqaCoPZz+tDnFXzo=;
  b=ECxlH2W2MJRdgxkp9OX+KTI0YncyEHXou/Q5ne43hzKScp2gRhQVCxnA
   T45UFnTOqvEkP5x9l0o4QzFx8KMxFdP0TE5xvrLHo+BarRFmrUluXjaWP
   fMik22PAkOPger+rli3G+YsnIniFrsvaKx73Fl9f8BgpcOQRHfd/LctK8
   DXlFJST1fcvXBfaqT4IRiFaCEswqgwVj6WNo06J9rdXtGApfGHejGtuBP
   5pHnn2gGXsyOBOBOjQ34chhPfkv4ZNw2oPRv0kYFEf9J9CCetYWIy8btK
   9ST9Z45rMexMOXlQyISN3B+x0D1meSjLJEgsfAK/89vDIw6jWi5nPffF2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280887998"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="280887998"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="567587745"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 05:02:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 05:02:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 05:02:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 05:02:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeP6imMC7FHHBow+JmbQMh8oO5xo6BBjQDCUseZ7a9LMDm5n7eDDSJS1ecqYvYsSQi1XZOGGjmyEf6CX+9Ut75wKXSR2A3Vq2rhT/UpY6zykKdsGsNZ2cT/Ie2tO1wM450qEuLZAvj96ypMXOGWmhNiMjsDjszLcXKjxwljmEsO7RmRea8EHkHnW35tPP869mWtkn9UxtOQEesW9gCqXCXQYLWUAPbmkHcFof2QzEtcsHGyxODg/l31t7qwiUyvGir44ATFyzOyz991FtZmyYYQJeAr/6n3WqYeODkb/r3l1K4+nEGBvPdjNlx4azwcUMcTxTnHMsQz3+u/Lf38Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYvlX8utYe1JbilHK05OzlopbhRWnq6+WKMJ8ImxvZ8=;
 b=bvF0uffpMBJa7M8o6JpEkm8lXah8VqL8QOdhsdX1muCC3fagU+bJuoqIz8/VchVIghF5Uix3Z60AnzJK8VzAImcoxI9vObPOA4XDAOnEJux6b7l5zARXhdcDJrt8swmi4muEpptP+GrCsg1ShAR5uWgZzUVrzHRUE4GI9oAuJa4SfCfpisUbP8sYlTzzNLI/K4KzClRYXsEw3IblM7yNbi9lCHF+nhhE44zcczzqXAuCQEcF2mcGxUYNNk7A826kEwL+ncxlFYzGL2Br6KS/78rJlw6b3YTnH0W7TyumRJoGH9DfY8UBtUODgMZ45RsN91stsO+RS/HCgxFZBugKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 MN2PR11MB4317.namprd11.prod.outlook.com (2603:10b6:208:179::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 12:02:03 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 12:02:03 +0000
Message-ID: <f0deca9d-3089-a84e-17bc-fe12587771a8@intel.com>
Date:   Tue, 5 Jul 2022 14:01:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v2 02/14] ASoC: codecs: Add HD-Audio codec driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <alsa-devel@alsa-project.org>, <broonie@kernel.org>,
        <upstream@semihalf.com>, <kai.vehmanen@linux.intel.com>,
        <harshapriya.n@intel.com>, <rad@semihalf.com>,
        <pierre-louis.bossart@linux.intel.com>, <tiwai@suse.com>,
        <hdegoede@redhat.com>, <amadeuszx.slawinski@linux.intel.com>,
        <cujomalainey@chromium.org>, <lma@semihalf.com>,
        <linux-kernel@vger.kernel.org>
References: <20220511162403.3987658-1-cezary.rojewski@intel.com>
 <20220511162403.3987658-3-cezary.rojewski@intel.com>
 <alpine.DEB.2.22.394.2207051218200.513966@ramsan.of.borg>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2207051218200.513966@ramsan.of.borg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:203:91::22) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e72a2a-29fb-4467-8ca4-08da5e7e2cbe
X-MS-TrafficTypeDiagnostic: MN2PR11MB4317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tsb6lvWZ/eeyXEc7NW27xsHwhZykEzfZm1qy6SEfdhiUZWbX2NBRV5HOkq/DSrOm3QzeTsfkinFsUSqDES2+C7qHFIYaa3BYE8KAbhLj9FKGPWZxpwDuCx+eZ4k8Mr0gXAzAs2+h9sxxarYqA4tBWzN5A3FOeCSl/4JiZBb87yKnq6jJFG9CRj5CnL+zKm3imt2J5uht1u0YkuO6hZy0nrPS8MROTrLtChCS4Csml4bSNrjkN3qAiYO3peMEQ0AbsPMh1cl8DUp8DkdY9gHnj1xVrbM0CmOQWYlHCeZrzmbkpxLn4wHAJxB9Ph0VeJfGCaBAmUJXMfkunkvIuX7qO43UChS1Ys3rUapFIRU3SDjBwMVCdY/5QR7rLCgEJ/0p8CfDHH2nDaa1PCfnWsdGKhF0f8i4gPqyfGEFXc3CXbpANtCqMMpr+c+NtVCmBzC2VwYkon3ULZgfQ0JqnDiucvMTpPZdcLL3IiZLa9CJ+FDCqO4mCK72ud0ZjNVBo+nzTevU350jBr0ChpRYqFcUioBLl8o20JksqwLgbKohBAMnOc0lRFrHqrOgMwgsL5asYcV1eb+g81NCAXyA4dcuKA8tkuwH0vvlz2/JkJvg3n47g/Av9D4v96g6RCBzK6Pqt5MDfuKyr794gfE8BQzUx0JHktZ9h2fZ5mCqjI7kuBL9M264HGHULEe9RsN1lT9EZAYZ1oTs7dsr8cTGXeiMwzKcOqKIG7StB+6tnPR2lFwXxkg/49qOtpoKcc682F3LV+aKRPdOqb1Yw3K7fv6MVnVvdU//TtB4MYVTdPGpt6Go9Q5eWg3oIpS7Qt8ZoPCiuFjOmkyR7bjl/Rre8qyWWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(8936002)(86362001)(4326008)(66556008)(66476007)(6916009)(8676002)(31696002)(316002)(66946007)(186003)(38100700002)(2616005)(41300700001)(82960400001)(478600001)(6666004)(6486002)(6506007)(26005)(53546011)(6512007)(5660300002)(44832011)(36756003)(2906002)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRLdlhja25KSTlXVWQxK2hiV1J4elRZSU5EWFUzemFrV3dPQzE1dS80ZklB?=
 =?utf-8?B?akRzc3ppcWllVGRjdjF1MTlWeGxZa2ltckVkWkphNTJBNFB5UU0vb292MzJT?=
 =?utf-8?B?U1BvSjg2NFNrTUJra0M3TkpGOXBEZkFVVFRVM1ZRYWpUMUFzTW91UExFaHpY?=
 =?utf-8?B?WU90MHJGT2p6NXBKOGNKQncrNmtFV2hmc3Z1WmhTRTZ5V2VLTlNiK2tpL3Fj?=
 =?utf-8?B?c1plNkc5WDdTUTQ2WnMzZkRrRHZBcDA3bk9NWGlMQURucWEyK29ibDFTWjVo?=
 =?utf-8?B?bE01dWdXTkR1RVM0bXdqV1N4cTlBenhRUXlUOENIeG0zUmJ1bTV0RWhsQTJT?=
 =?utf-8?B?cXp4NEZvYzFNV3NFclRFeldMeG5Hd1hQWnVEak5jL2lMc05WclBuVml3dVht?=
 =?utf-8?B?bC9aQktWenl5em1LT0RSQjZlN2hLUy9XaHlMRHlOblc1NG5jYzR0ZGY0QU9W?=
 =?utf-8?B?MFg2N0NFbFo0Yms3dlpyUWJtcm4vSW54ZC8rMjk3VEdiTVloNitveDFJdVFV?=
 =?utf-8?B?czN0N3VHYncxZXZvMlVydFFCeklSdUkvRjhERkhaN3B6T0JoRk4vRWoyeUg0?=
 =?utf-8?B?NXdKTDVuRHZpTmFiQkZ3clU1QUV0Z3RIb0N2Nnprdk1aZTFwYk82RTZpRy9U?=
 =?utf-8?B?UXhIa2kyK01yck9hN0Z5WnVoTjh2NWQ3b0lmRnBrazJuU1NLYU9uZHFtdGtB?=
 =?utf-8?B?d3dEc3NDU0p2K1psRDBYc2xWSDM3L1h4N3M2TEFoUGZYN3lSVmtONGg3VGNv?=
 =?utf-8?B?OFRicHEvZ1BTVDNzTWhOOUhVS0tDZkJMVzl6b0YveUpUZmdpZHV2M2xpTnBn?=
 =?utf-8?B?dzJyMldMSTNkZVVyMndKeGNaNThKZDA2Zlo0cnRkc3hVRzVhQ1dsT1BtYlVX?=
 =?utf-8?B?YStDS25XL1d0eWFheVRnb0VzamxPeXhuMDZ5Sm43a2Y3Tks1MFczL21Ya2F4?=
 =?utf-8?B?aUIramkvQWlWNDJWcUQvSE9FMm93dTkxbDRJU2hZZWovSytWeVAzSXNtellz?=
 =?utf-8?B?YUJYajlWSCtmL2lHVExLWk4rdFFFNWU0eUY1MmhlRHc3N2RVZHlxUFNMYmkw?=
 =?utf-8?B?QjBhVWdrSXE4cVFMSmxNVWVVOUJvQWhhZ1FUQmZDY0cxSVEvS2FPWks2dTAr?=
 =?utf-8?B?TVdXWWUyMEFrbXJ6V0wyZ1NwMEhGaVU4S2c3dUJnYUtwU0EvdEh2b29GZGFD?=
 =?utf-8?B?amd1SWdiQ3c3eUtubjNVT0ZscC9mamt3U2tZem0rR2htcEdyWC9SZGM4Mllw?=
 =?utf-8?B?Um52blR0NGRPMXk5NG9MSVVwbW5tMzBwcXpQaWNqNTdRaWw4Rm55REcwRm1i?=
 =?utf-8?B?Q0daLzRmeFNXL1FaajlPUWNPeHYzdTloekxVT05pcm9YdGMwU3Yxc3hEazY2?=
 =?utf-8?B?L0Q4b1ZUQWhpR2ZnbklmeTFLeERlYTB1VWxnMEo4NUNmZzhOZzkvdTBvY1Ba?=
 =?utf-8?B?aEpMcnBTTkV5cmkvNDBWTEVERmdYcm9pREc4LzFIOEUrVENDYlc4YzU2dmIz?=
 =?utf-8?B?ZXhvaG8zOFBERUtvcmlHTEVmQUJycDdjeVlYUWZERkVLNWlnUEo2U1FOVmtz?=
 =?utf-8?B?SC9nR25nUVY0Smk4MWNqajROMVRpOU9meUdGTEdGRUNRcElRYzUzTmkvRERE?=
 =?utf-8?B?M2tJL05WK1FubmcvbHEyNlpoYVMweXFGaFdzc1RPMGxLd24yZ0ZFWHJGUjBI?=
 =?utf-8?B?S2czcVdUbEExSVZaQWoyT1cyTUMxc1NWd3NzSk9TU2JaYXpySTk4cDFmMVMy?=
 =?utf-8?B?M05xRzVyYVBpalZSK1JKZGhlQUdGMFZ4NnZrdDBCQi8zS1JwcURMMUVod2JC?=
 =?utf-8?B?a0dnQ3hSQ1Q1bHJ4aWNBa2Fmdnh0YlV5Ykk0cEg4MTNmczlkVTJ4WXg1dGZN?=
 =?utf-8?B?VGVpdDB0WWJzRUhoQ2pSWldVcklybWx0aC9LVUJNYThaRlUwTnZpWlFsOTVo?=
 =?utf-8?B?L2xSNUJtNU1HVkpaS0pseUZ1dVBqbE1wRDU0TW1BK2pvR2xOV2wxMlk5Yk51?=
 =?utf-8?B?SytkN1BTMElxOVQ5WXBRSnliNG1zd09aQ2dRQmZsQjRJajNRWmY0Q21HbkVu?=
 =?utf-8?B?OXpIcVlFVXpRNE9FY3ZvbjBVTVJybXg0dW13WHhad3lCaURvMk9hTGFzVnNV?=
 =?utf-8?B?Z0p4SE0yc3VMQjRCYzg3ZWpoS0UrUmRNM09RaVNacW9HU3NPR3dpc1hodXYw?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e72a2a-29fb-4467-8ca4-08da5e7e2cbe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 12:02:03.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WgHFCgFs5aKNiWaUco6Al/GsKob82EkG2/ZzAoQuvG7yRGx+RkD4CZud6hJ2rbb7koWQfADAPJP+mamIIPpkHKlG3D33yUcInTztquxcdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-05 12:20 PM, Geert Uytterhoeven wrote:
>      Hi Cezary,
> 
> On Wed, 11 May 2022, Cezary Rojewski wrote:

...

>>
>> Relation with hdac_hda:
>>
>> Addition of parallel solution is motivated by behavioral differences
>> between hdac_hda.c and its legacy equivalent found in sound/pci/hda
>> e.g.: lack of dynamic, based on codec capabilities, resource allocation
>> and high cost of removing such differences on actively used targets.
>> Major goal of codec driver presented here is to follow HD-Audio legacy
>> behavior in 1:1 fashion by becoming a wrapper. Doing so increases code
>> coverage of the legacy code and reduces the maintenance cost for both
>> solutions.
>>
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> 
> Thanks for your patch, which is now commit b5df2a7dca1cc6c6 ("ASoC:
> codecs: Add HD-Audio codec driver") in sound-asoc/for-next.
> 
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -937,6 +937,16 @@ config SND_SOC_HDAC_HDA
>>     tristate
>>     select SND_HDA
>>
>> +config SND_SOC_HDA
>> +    tristate "HD-Audio codec driver"
>> +    select SND_HDA_EXT_CORE
>> +    select SND_HDA
> 
> I am wondering if this needs a platform dependency?
> Or perhaps this symbol should be made invisible, as it is selected by
> SND_SOC_INTEL_AVS_MACH_HDAUDIO?  Are there any other users?


Your feedback is much appreciated!

So, this codec-driver - HDAudio codec driver to be strict - is _generic_ 
i.e. works with any HDAudio codec type, be it Cirrus, Maxim, Conexant or 
anything else.

It makes heavy use of HDAudio library found in sound/hda/ and re-uses a 
lot of non-DSP HDAudio related code found in sound/pci/hda. It's 
basically a wrapper for logic present in ALSA (sound/) so ASoC 
(sound/soc/) users can have first class HDAudio codec support without us 
duplicating the entire implementation.

Right now the only user is avs-driver found in sound/soc/intel/avs. By 
design, any HDAudio bus driver in ASoC framework can make use of it 
though. Because of that, we decided not to couple avs-driver and this 
HDAudio codec driver tightly.


> Gr{oetje,eeting}s,

This made my day :) it's wonderful!
