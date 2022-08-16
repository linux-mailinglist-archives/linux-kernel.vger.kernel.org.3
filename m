Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3885962D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiHPTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHPTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:08:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243F53020
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660676921; x=1692212921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kWt7U1fAfBnGGiRGSkV5kreKFRJsy8neCHQUheSflpk=;
  b=HDtT9cppI4HkBZRU2UbgUbVmAjL0m03a76+edLjbeFaJEWUq7fZU+gCJ
   EMvrhB7bG8Af0/cQOMXNmiW0pgyhqdv1LJVRJ8h24mCFBJ7E3zNMHUo8j
   sG8dzsR4ncGE5BKVXnM/ZgISRWR23TfyZpNglvWkeJ+CkgsCPE1Mvjfpz
   ggGTik3Qwc+CIhBaQU5rDLgNwxp2v+zdEFcQl7iXrSHoRC7jyON396kGs
   hsJB4azcW6uJPf4s8CB6ZnEpoiTED8qwZdBBQHtwAj4/BZeU6n+A+1bIg
   h80CYD+D1KIU5PsJoP2NjbhbagxPsu08/3ozmIBRgQzLZXWj/Kb8xb2uT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354051700"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="354051700"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 12:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675344827"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 12:08:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 12:08:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 12:08:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 12:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xl6ipeJQVsoZzrYGuoA297bXjTg8wie/mVZiE84qi3MqwFMSde7HXjlj8nroEEe7v2UB3uxGvw9mVHS44XmUFkJdFf09Wux1sTz6VnTZlz7HFAIeAUkXHzd7DxTMf9iY6z4y9SZ3ZS4dHQk8RvJmcEy4By0NgVRjHeB7gto3ZSklSJK1dYDMx2J4aSQYdwSJC3LfsZpZnqxA8uboiRPW0Y68expwZVEoDWOmQjv1aO/dAPx+FvXT3zB1LXNjeKsmJX+YWn63NyIjdjEgpP4TieHXa46btsLnZPjIvjNkUlxB61zPh1iXogRZ9wo9v8jnfxAjLeTrpXdMcH8ia5Cg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtmLQVIbJPDgZ5TX5qYaOLgbm3d7ZAB4SCJlFh2Lvyk=;
 b=CreMwLfBi5hKZYpMNfBbs78wc6T6LvW4ujS/WXM/2mG4NO8YOLMOJdB4v57FRhUkZ/bJltzoSv6gUwBUZ5GBPenOosRYvnPUAQt2jaHOF/jYuMd1MuzR4HopELLly9s2ZyfO8LPg7VrpmtW6B7MmqVUL2er86+CZBjwimvy2zS8JNe/IoXtTbGGzXTkNOj4cPVof/GnkJQHSudc5L0TrFEgR4u+186nUk70tOj6GaCoACOshjqVQIkaCHtkaagg7chpH5wjLo9w84qjhdPPCSpgiIgSog+BZRNwYejikcxxTTcnXUauVoJSIjx2KyPrYz2nJviWx1CbsMOFrn67lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BL0PR11MB3089.namprd11.prod.outlook.com (2603:10b6:208:79::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Tue, 16 Aug 2022 19:08:38 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 19:08:38 +0000
Message-ID: <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
Date:   Tue, 16 Aug 2022 21:08:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] ASoC: Intel: Skylake: try to get NHLT blob with PCM
 params as fallback
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20220725111002.143765-1-uwu@icenowy.me>
 <20220725111002.143765-2-uwu@icenowy.me>
 <4208aece-0aea-ba86-9a00-9e217546e1dd@intel.com>
 <3346b62c3cd7e07766457c9140849a31d6d8775c.camel@icenowy.me>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <3346b62c3cd7e07766457c9140849a31d6d8775c.camel@icenowy.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f6b7fde-8173-429b-79c9-08da7fbab9d1
X-MS-TrafficTypeDiagnostic: BL0PR11MB3089:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIIjliayH+GTOVYR7SX0uAdb2yyJ5YWufrghgi+3pGuu4aLh7p5n7eca2xXxcdoNV1BKR6qi2+6DjKj8KlJpFk/eyQQPJz7z1IvhzCg00cSZjQ02IHmYRwp8GL28dT5wu0c90vgoFaRQHOmmD75HLSmn3vuKMTE6fTEaL8hwHyvIK5CgBYwYUYQxea5aXdMy60KDtDczm6tXCRHCktOghs0+eh7GJ8fYb9bLspRWnHIoWN3ROrq6uybfGnTAQwUnqL1QyVOfogi+yy6x39WkpwtI0MsxoOCsPhQTrBp6e5nlfdRcrJA/UODvkazVaYJkvthrGxnuT1xFmts6zIjSMATiovBMn4z/UPr85Y1r9T1QYArH0axQ/WjrCFMFqA4mm/cMNQTaRApR0YIT+J/2vph17eNa9eaEkKNXO71vjStIAVI1WFPW0n76H/GBoe8l2aEmSeyR9DwwDC300DXoFTJEmJrUmnGTYUVHocaIguo/668DaO9qb76zQnSrNBbu2DXOzyuv33JZCLFE14Xc8sLtWGHorQVAQJJG+4Lkl22YS7WxDQMl8jWRoilf7AY5u8V6gSLx+IP+j3xSeWVB+Zqq+fRrVW26d9pW/BqLb8cNaWQsFhn8d236sb7KjEyiZvE6Cn7wPQ1DyGEN0yiXrOYcFgK4FeUzX3G2+ftcpjJet7pIyGI90mbXqd/kOZoB+RCIdu1a1n0KDfqvrqwv57hQ/JTwj40zmCXevK3WXJEbs3REv7lL80LWJ5tNZX6L5R8ASPTXqgBnnijbSM1mfdoTBSdxfXbvCaDFextLC6TbKepmQTelvYjIx/hc1Sn2Oqfa/41fApqoEMSQVOmMog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(346002)(366004)(4326008)(53546011)(316002)(38100700002)(66556008)(8676002)(83380400001)(6916009)(478600001)(36756003)(31686004)(66946007)(54906003)(6486002)(31696002)(44832011)(26005)(2906002)(86362001)(7416002)(5660300002)(8936002)(82960400001)(6512007)(6506007)(2616005)(6666004)(41300700001)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtOUS9IRzRobDVrSXI0akVNVHVwR3JpUG5Gcmp5TVBGajhJMDhYejBwR2ty?=
 =?utf-8?B?L2JkZS9SbnZoQ2pYRGdqRTc4d1QyVVhrTE5xRS9YZ2trcFlDbkNXQ2YwN09K?=
 =?utf-8?B?MXp3Q3prWG5IMjBDNUk3T3ZGa2ZzNWtwczBhYkRZMGZkbFRwcDlkeVJWdnlk?=
 =?utf-8?B?Y2dGbGRwTUtKanVqY2ozOE1ZR2VBek1KYU5uNEhVamhoNGpSdzRudnV1blJK?=
 =?utf-8?B?VDZDdXlqbVBhRFUrMEtTS2hJR0tjSTgzMVZUMnV6dldXRzVQdjFBUDU4Uktn?=
 =?utf-8?B?dlZzZkh1NVZ5Q0FCc2YrdjF1U05nR3ZzV205T3Z6bDFTWExoNTVZTHU2NEMv?=
 =?utf-8?B?MlFBNjBxVVNYNW5zei9yTytUeit5c0lyaE41M2dHczZ3RDByYmp3QjVjVWdW?=
 =?utf-8?B?Mk9uWHM4MDlQZHVTelkweXRXektrekZ6MnQwM25vT2l0akoyaGhBQWdvR01R?=
 =?utf-8?B?a0tTZE81aExhei9SanFZRGJHQU9EdUloQ3NoWUVUSmE0MURRd042QUg5NjZK?=
 =?utf-8?B?WFNQTC9ZNUR2NE4vN1RVbU9mRzFLdi9BelBpWDBoQnFqWDJ2M2VtaUN3R3l3?=
 =?utf-8?B?Sk5nck5aOGs1Rzkxc1cyUW5uYmZCNFJobHByTGR2cS9kZlBIb3M0azkzMWRj?=
 =?utf-8?B?N29mQS9icmlsRWFlNjFRMFY2MTZMVnN3U3FzNHR3MTdLcXhaVkR0QnZIV1Ir?=
 =?utf-8?B?MHhCY2VtS1BMZEt1TGJSYXEyRDgwZWdiTVhzcW5GSXNiaWMxQ1hMVFRUOGI5?=
 =?utf-8?B?REk2Y1E1OGlmNVVwcjkrZ2MwL2lJOC9hSzhZOTBvUkcvWVplb0Y1Mm1Wczkr?=
 =?utf-8?B?NGYvajJaVEhEblJCU1orWTl2Q3FISkszYlpjeFllaVozZ3AvTjhYa1kxd003?=
 =?utf-8?B?UkgzL1lSQ3pXd0RzOXVZYTJqTmhLdVlIUklWM1JabS9lMFBuaE4rQ3AxbDk0?=
 =?utf-8?B?NWN5dG1QalBWYk1lWVhYWFFZd1V6MWdkRVpXNUZIK0l5RUM0eUFyMTdVRS91?=
 =?utf-8?B?SWFjZ2s4eWlrR0NQdHl4c0JiN1pEUGlIQ2IxTzI0R3NRRmhNV09TUVc3eUl3?=
 =?utf-8?B?MnhlKzhlb1hZZDZValAySlhVL3l6cWRiQnowMFVZR2hjelZ0allaYjUwYWJT?=
 =?utf-8?B?ckJENE13WE1NTzE0OWsxdFN4SWg1UURJMXlsNktxNVJiT2F6TE8yK1RtZWcz?=
 =?utf-8?B?MmJ3QXlSZ250OXhQVlVMODZWaTNMUW1VK3VRSVdsYUZoeWx3SURJaDlsZEtQ?=
 =?utf-8?B?VXp4c3NHTWc5NjFDME1BSi82VGFRU2hBdzNCZnhocEYxZ1hIVEFiTjNMWVR4?=
 =?utf-8?B?UVVPVnFiZjY0VHZ0ZnZHNmVQSEQ1ZS9ucGYyUm9DMXBIbzd5ckVYeWpXdVpF?=
 =?utf-8?B?NWNyOHVZWmE5TFFGUDg1UFhLZlEzelJoL0M1NlNSWng1eCtRbFVDN1FNZERx?=
 =?utf-8?B?K0dvaVRiRGU0WDZpRXBwSE5JWTBZZWh4a2U1TENEaXB4QWlkMytGYVR0ZXZy?=
 =?utf-8?B?cUVEcHBSb0FYZ0RscnFYcDY1c0t6V3BTc1ZFUS81MldUUDg5YmJMZjdLQ0F1?=
 =?utf-8?B?RGcrazQxdmprMjNET3BXakRRUE9lMlBqU01yMklxOFl0L1VKU1hZenB4QStB?=
 =?utf-8?B?S1ZZOW9SOXJCelB3eTMwbmdOQVFNRzJBb1NrTDByRmZmbWtJSkI3bEdQYzYr?=
 =?utf-8?B?ckpnblN5SDVURkpTOEpNMnhuWkdoN2hNMDBDZnVwSGFIdEkySnQrZ3UrU0Ux?=
 =?utf-8?B?dE54SGNQRHoxK1NWWEIzM1NyU1pIQzEvNWpub3d1T01HcW5wcVJGYXdFUlZQ?=
 =?utf-8?B?blRKWGZOOE8vN3BKL0R6SE9Bek4vU3EzdlJ6NnZCZjdWL2pmVSt2djU5a2lR?=
 =?utf-8?B?d0phdkttZXo1V1k1bXAwMElRL09SVFBhTk1HaFVtcjFUS0E5TmlBdVdUQWNN?=
 =?utf-8?B?THJUbjhTRTMxRmlOc1NXOWgwb2NNQ0UrWTdyUWtNZ3FRWG1haUZIUDh5SDdN?=
 =?utf-8?B?R1RrWkhnQzNvVjd0T1dyd2VHUUJxNmFtNjNZSk9WVEswb0gwRDZEMmRDUnNN?=
 =?utf-8?B?ZGdJL25DNnBsajBzSmdQNHppcWFXdUhyaCtCQ2VadXkzYzAvd3BNa0QwcDEx?=
 =?utf-8?B?RDhWQ1NDVEZGeUhkbDRoZGNnV0ZNVzVCbGcyd2FaeDJ2cWk3U0VIVC91clRu?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6b7fde-8173-429b-79c9-08da7fbab9d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 19:08:38.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3mcLo1lq9dQbEo07hldU9GSl68FAJjJLhPuSv5qGV/u7EZr7d1Y0yW3f6TxzixP9dcz4YuaWSdVYE6dqGUQZnNjRqGMUjY+90UODo/QMuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3089
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-07 7:26 PM, Icenowy Zheng wrote:
> 在 2022-08-02星期二的 12:30 +0200，Cezary Rojewski写道：
>> On 2022-07-25 1:10 PM, Icenowy Zheng wrote:
>>> Switching to use pipeline parameters to get NHLT blob breaks audio
>>> on
>>> HP Chromebook 13 G1 (at least with MrChromeBox firmware).

...

>> Could you share the NHLT file from your platform plus the format used
>> by
>> the cras/userspace tool? Did you try playing over simple aplay tool
>> instead?
> 
> I tried 48000Hz 2ch 32bit with speaker-test.
> 
> Attached is /sys/firmware/acpi/tables/NHLT.


Thanks for the NHLT dump. Total of five endpoints are part of the 
description:

id 0, DMIC capture, formats:
	[0] 2/16/16/48000
	[1] 2/32/32/48000
id 1, I2S SSP0 playback, formats:
	[0] 2/24/32/48000
id 2, I2S SSP0 capture, formats:
	[0] 4/32/32/48000
id 3, I2S SSP1 playback, formats:
	[0] 2/24/32/48000
id 4, I2S SSP1 capture, formats:
	[0] 2/24/32/48000

I know not what "speaker-test" means. Could you specify which endpoint 
you are speaking of? Providing either alsa info or at least output of 
'lsmod | grep snd' would help. I'd like to be aware of which machine 
board are we talking about.

What could be guessed with the current info (and some google query), is 
that we are dealing with SKL-Y m5-6Y57, codenamed 'Chell' and the 
speaker-test is playing through an I2S codec connected to SSP0 port. 
It's probably max98357a. The skylake-driver version you have gets 
confused with 24/32 format (userspace is probably attempting 32/32). 
That or topology file is incorrect..

..and at this point I probably know more than enough. We have tested 
basically all of the KBL and AML configurations when fixing regressions 
during recent skylake-driver up-revs. But Chell (and Lars for that 
matter) families were not among them as these are based on SKL. I'll 
follow up on this with our partners and come back here. I'm almost 
certain topology files for the two families mentioned were not updated 
along the way.


Regards,
Czarek
