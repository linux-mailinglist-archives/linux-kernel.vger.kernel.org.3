Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E430567034
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiGEOEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiGEOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:04:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC1AE5D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657029074; x=1688565074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GZT7VSGI0ApXibcGwCpKc7f4P6jLaEHJ4OmDvMtBvVI=;
  b=HPFNt5I+yzcV7HGmn2c4LjT6uV76YUo55Yg0ELWhj1MYeEDi8yCyoGty
   SaRqa9Zzc732CxCe0Rcl2INangUpkABHLIUZyU8YFkonUYgbNDgKvHHL3
   7NcltrIs+ZtRJvQRXwhQAjQRyalO9v9v1ENPxiB4pMeUjvjYCcCdFYyo6
   DYQj6oHTuKcdYAF2+tnvrC9ma9vZOQbDhw6XFLqf2II3S8Y0ZAvTYI6uV
   prDXzYwV0lzl/tMb5Qh+IWFGHnNSaD4wa4k0dKLjdKr7GvcSNlybQy3o+
   8tlspCPIeD3MHZU/E6wBUJuSeDWG0Quj2kRi/O7XyoOSO/9VsM+2RNlb8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="282113308"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282113308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 06:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="625459427"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2022 06:51:13 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 06:51:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 06:51:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 06:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRWqnK747tuWFOC6HawEcFw2IZeNG1NYFIU7LQbXyAn7roIlBELsp8pds339uxPUZ75a6/oaO8us8h2LM/3dvW0RXyTgxmGCe3jKy87VvHjX59g7D+sbr5eMK1YEf+Hp0MsN8UpJVqBhOa8VaMojxmhUZ9IeTmGyiI9V3WzLvwEOjtug1HwBYHJkViOw9dKqQG9VZ3+aTErc9a/9SF8kFbL0/Z20ZyFPTQ8EQGPBZetRWun2urHaq51NEuztmZ+2EezmGZ54b64QQBrn0MSHa9EhyvZFjyfblojwWIiuvPkVyknAtD8wHSfYWkErRJ+Patnzx3SRtMPsBkzS+NvXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrXXsZg4HkMPn7IhtRkZUbE+vunwycLaTbRvh3sAFzw=;
 b=aeXNLHE+oEIDXlKQ2rPC5j7MrEZchCxERXDmd9QJxSAKe14wAs4KJhHfNIgYr/g7FTdJHljV78dU5YlJqZyiU3brXkFrc4wbO+2cJXNTcrlTtS2NIMbtQ5vKiLAK2gb/l1TuEfQc1fW+GgNNPg4R/xlXOJjB6jQ2rzCGK1hfIQvK9SVcfZfaEEabHEsJtEU5wo0G/1tbjRutn6E5Zgrf5W9djc0N3cWCEu4w42uFVJEbA3tg/ME4WksF2iwMt9AkZjZpfZDBGbfXjAtKehEsgnDrKgv/FCJpPSBFKg9/EKESvB3N0A26kUzYKFX7HJjEK/KfSVs33y7/FWraIojIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 13:51:11 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5008:4f0:1078:7ba3]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5008:4f0:1078:7ba3%7]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 13:51:11 +0000
Message-ID: <c89c993e-7a7a-15df-85ef-8d9b7be16b71@intel.com>
Date:   Tue, 5 Jul 2022 15:51:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Intel-wired-lan] ice: Error setting promisc mode on VSI 6
 (rc=-17) @ 5.18.x
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        "Siwik, Grzegorz" <grzegorz.siwik@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC:     <intel-wired-lan@lists.osuosl.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com>
 <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
 <CAK8fFZ6hS69JMtnvFnLVt9aiWEivZ9-izNgMHtB+KeAWAfaXaQ@mail.gmail.com>
 <6f52ccd2-8411-0c53-2deb-885bb1234ce5@leemhuis.info>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <6f52ccd2-8411-0c53-2deb-885bb1234ce5@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da4a85c-2f15-49ae-cdc4-08da5e8d6b25
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFqdStfy+yFiwxuOOvBVzJSrBtZVvjO6aMo8gBuPQ+L7I8BKMZNjqAWGWzNR+q1VlKVMaVVRgXuzjePaVoWUCVoLemHgCN3CRc9id9ATy7nqgZ5UG6eUj57+YAczrgy4jpIpyfnDl3gR8z4COKqcMZMcHpi6/w/BB3fKQwi3FW8K5R4YlIxUWmIYs4RODA6JHaAAiLZyIPWLJ2pyxsxtu6BAruhaVT0JFIRJZUMQVy6hhea5K90pGONvEa9XbAtrg2W/4ViK+v6JgzBnQfhRPd88sgt0FNMb9NbozRXE0be0PZ55V72ADeUnx3K6uZowQjMNo2CNCvUcN5jT7GPhbscIKFZId8951F2LtIqKWtQ3GtkY0JXNwlXOBBkuoTcZQ0skde0YAL+mrXrVm1Bxg0HviwNE03Is3YpXDntEzmkRdpKU9oPUAHVfcmU02LEAHaLdptUr+haEMqiVzUKCfcHJOlFzlk16WnqHaU1g1yaTnvnChDL1V/1t2Pl61BuqGRo/i05FE+/NSQX/hf59D8DKU6/pAzMn1qiV2RZPFq2WiRGSf18oBIASsAcS0V59Z6poJs9b4ntV9yvqFNFOLlcYTBv/O0XCSizgs5+XfTivN5BCawueHIJ/E+xnrPHm0a9mR0K45IDws9XCYZKM8VqYO7ZK7nRXObm/hMUW1HuehWAaW3LPBY1nDEnm7kKm5KrtgYuS5EWKTn+f0TmNa+qqBpswog77qE0iQjBsRYpRzKZ49RGDLGcssPWKDhrHhcXqLikwZTUuzi5rTFmdzh/NqFhUwP9YQYcDnImEl8oDXvfMQjndAIlQaT7F487wiivfs0H7tl8GwkzOddWJLzfrRZB9HlzcjIOgtvdbDnSpBrbW64Xof0HLh8/6QYQjcDB2aU1IzkHmtSvitVXxjdGCaFqebTnsIHW5SOMdawY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(5660300002)(8936002)(66556008)(6486002)(966005)(83380400001)(186003)(82960400001)(478600001)(66574015)(41300700001)(2616005)(54906003)(2906002)(8676002)(86362001)(6512007)(26005)(53546011)(31696002)(316002)(110136005)(36756003)(6636002)(4326008)(31686004)(6666004)(38100700002)(6506007)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBCNkc4OHJJTDAvNCswYjZoVlJaTzA1KzUydFZGeXR1VzBOdEI2OUphbjU3?=
 =?utf-8?B?bEJiNUorQWs5bW04c3VnNXJrcVpoNDVMaUFLSmp1WHV4NkFVS2IrVWpmeC9k?=
 =?utf-8?B?MzAxSzlKMERzYmFoZFpaOUdLb1BrbE8vbi9mWCthRTdTTVRLMGI4dFB2c2pr?=
 =?utf-8?B?OUpmWnJRVUlaSGg5WU16cFcyL3BKR1hIcnhyZytUUzRWQ2Z1WlFaNlR6LzRG?=
 =?utf-8?B?SWp1SDFkVUtidVNUZS9zMXpOYnZBY3pCdTc1R21wV1ZOTFhBMlJpVURqcFhX?=
 =?utf-8?B?RmF3VzY0Z3hSN2NFcFBUL0RTZEZWbG02bFYva2xzU05IZGVRbjNpYzlSR3hM?=
 =?utf-8?B?OTVBaXF0RFAzQjZ2L2RpWXF3bG1aNjJrblY0S0ROcWpvSk16MFNjTSthNkg5?=
 =?utf-8?B?c2RoRnl6RFBIS0hESWFZN25ZR0ozN1JQS1phcThPWXREVkI2WDUzS1ZidThz?=
 =?utf-8?B?ZkROQnphQ0F0SkIwNi9sTG9pbi9QVExjZGZ5b1FJZXBycnlXNUtBMTFSbTIv?=
 =?utf-8?B?VUdnRGJ0Nm9NTXNyRFNoK0VmSDk0MGVPNXU3QTN2cFl0N2VEeEZVQkx0RzFt?=
 =?utf-8?B?STRqUVZZZGFrL0RlRmsxVmVsM25XdVRjeGtjM3F0d3pBL0VVdjFIUWZ5Q3ky?=
 =?utf-8?B?UDA2Z2duL295bGhONUdQWHhVMFg5Tkw4d1NuVFg2a0hMbXdFbVRIa2h6bkJG?=
 =?utf-8?B?dWR6MEdiVjlDN3gzY2tCN1NuNEloTHlMeEE1U2NnaE5icjJuSDlubGdnRUFs?=
 =?utf-8?B?UTRHQXMyNDV5TVpZdDFQaFdiN2FoM0ZGWGQ5UUJlMkxNR0ZQd3g4THZ0Q0Vx?=
 =?utf-8?B?U0ZLeXZ2MHV2UnUzQWdQVURWYVhlRGl4RFprd0VlQUVwR0w4VzdNa21DcUZ2?=
 =?utf-8?B?MWEvS3RKRkViWmJuUS9nRGFyR25PMzRiK2ZsVnpqbFZQbXV1VW80S1Z1TWZn?=
 =?utf-8?B?eDJKMWxNOUlsSjNxTHhBclk2dVp3YTJMM0VseWwvbnlkUzdadEh1MGlCZWFC?=
 =?utf-8?B?N0txR3ZTNEFmdDZCc3AzcFp4SXhnZUVqV3o5cFlvVXNzY0IrRWh6YXR3Y2FW?=
 =?utf-8?B?UnprZHcxMGpJOXFnaVErS0Z3Mm1yd0ZEYnNRenU1WFFPV1BjeldHSVFHakRm?=
 =?utf-8?B?aExvWVpzSHBZNkF2b0tpQWdwaFpJOUhLYnczY3ZwZDFNRXQ0NWhPbXpuVmRm?=
 =?utf-8?B?VWpZL0dUa05LdEJrTHFJcEZZeG1DaTNVZk8yVUFvWmpzODBpMnFLWjdPajRH?=
 =?utf-8?B?cVJ1cXVYUWNMd0lieUNPUGFqUDBSYlR4VkxZcmEwbWxQdUE1WjZSa2VhM1Yv?=
 =?utf-8?B?R0d5dUdEQURNMkxKa3I4ZFVYcDFVQk9WWVFZZGhrV2dFTE9aRGF6cHdYVHNO?=
 =?utf-8?B?OUhrLzFobkZsUmVjWWhZUTB1dnJISGhBbFkvVjFyWUhQNEpkbGJySjBPUXBC?=
 =?utf-8?B?Qk41b1FJL25aZ1VkUjRzZjd3Rk9wNVM4cWR6SUFQekovQnZqQ3kvb29oNnFT?=
 =?utf-8?B?QnVMbUI2YWVGRkhXcklSOFI2dUg5RzAvSW8zTEpLRFR3VUVQR2pOeDF4QTh5?=
 =?utf-8?B?UXUwRjJwbllMbFBHQjJocStmN2JyVU1qQTFYYVpDSzVScXVwekswdGV3cXBv?=
 =?utf-8?B?ZDFaUmhLdzVncW5lK3QyajlsSzJKaGFVbytwd0hLWDJ2Mld0TThYRGthLzg3?=
 =?utf-8?B?NTRmS29YYyt2eXpSQ3IwODJjK2lGVXZLa2tSOWhuUWRFNkJYN3ppSy9IT3Fo?=
 =?utf-8?B?VmV5MWNsSjNjQ0o3cmpyUmwzZCszNEFPRDdQRnBibnBIVmRHME5XUzdwMW9J?=
 =?utf-8?B?TzNnNjJlYTBKUDNTK3E3U1A4eDd1V3FKcjJzdDhIY3hkN0w1bWp6SUg1R05j?=
 =?utf-8?B?QWpHWXpYTm16SkRSeE5QWlBmdHh6WUJqa2dHT0xyYTdEQkg4SzZlcXM2M1J5?=
 =?utf-8?B?VU1TRksrWFQ3b0NmdmRYc2p5c0lnK0E3cTRqNVFBanV4eUxUdkFqN1RBb1pS?=
 =?utf-8?B?UVVDN1c0d2FXOTN4R0YzYWkzb0tsTmZxZ0xvSmRvOVozelpXK0VVOFA1MmJz?=
 =?utf-8?B?OS91U093MnIrMzUvam1pTHljMXNQRjlIQUtkUUpYeFpvdzM0S3EwVjFwaGNH?=
 =?utf-8?B?UEpsUkxQSUlpY0hySGRuMjlUZXBMT3NnTmJYVU8xUTNpSnVzd0Y5QjIzanh3?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da4a85c-2f15-49ae-cdc4-08da5e8d6b25
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 13:51:11.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KDtk2ycZW2SLKKJ+Sk/R+4uOPOF6NztGgedePA9Pe/Y3gP3td2sgKovbnkka87Zon+TTVgS87duMOPu2VI7eCp/DKWdty4ct4Y7fCJnVSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your e-mail, unfortunately my patch is not fixing this issue.

Adding Grzegorz Siwik,  since he is working on similar issue and already 
has a patch that is being tested/reviewed internally at the moment.

He can you a send patch tomorrow so you can test if it also fixes your 
problem.


BR,

Michał


On 7/5/2022 11:43 AM, Thorsten Leemhuis wrote:
> [adding Michal to the recipients]
>
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
>
> Intel network maintainers, help me out here please. Has anything been
> done to address this regression? It looks like Jaroslav didn't even get
> a single reply. What's up there?
>
> BTW, took a quick look into the issue and noticed a the patch "ice: Fix
> promiscuous mode not turning off" from Michal:
> https://lore.kernel.org/all/20220704131227.2966160-3-michal.wilczynski@intel.com/
>
> Is this maybe fixing this? Then it would be good to add Link and
> Reported-by tags to that patch.
>
> Or is this something else and Jaroslav needs to bisect?
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>
> #regzbot poke
>
> On 19.06.22 19:00, Jaroslav Pulchart wrote:
>> Hello,
>>
>> yes, I revert that commit. Still the promiscs cannot be set and the dmesg
>> error message changed to:
>> ---------------
>> $ ip link set em1 promisc on
>> $ dmesg
>> ...
>> ice 0000:63:00.0 em1: Error setting Multicast promiscuous mode on VSI 6
>> ...
>> ---------------
>>
>> Jaroslav P.
>>
>> ne 19. 6. 2022 v 13:51 odesílatel Thorsten Leemhuis
>> <regressions@leemhuis.info> napsal:
>>
>>> [TLDR: I'm adding this regression report to the list of tracked
>>> regressions; all text from me you find below is based on a few templates
>>> paragraphs you might have encountered already already in similar form.]
>>>
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> On 09.06.22 08:58, Jaroslav Pulchart wrote:
>>>> I'm struggling with broken network connectivity at VMs using linux
>>>> bridge at host after update of kernel from 5.17.x to 5.18.x @ Dell
>>>> R750 server with E810-XXV NICs.
>>>>
>>>> I noticed the kernel reports "Error setting promisc mode" in dmesg.
>>>>
>>>> # dmesg  | grep 'Error setting promisc'
>>>> [   24.863557] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>>>> [   24.878369] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>>>> [   25.045834] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>>>> [   25.129840] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>>>> [   25.144440] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)
>>>>
>>>> # lspci -s 0000:31:00.0
>>>> 31:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>>>> E810-XXV for SFP (rev 02)
>>>> # lspci -s 0000:b1:00.0
>>>> b1:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>>>> E810-XXV for SFP (rev 02)
>>>>
>>>> It is easy to reproduce by:
>>>>    # ip link set em1 promisc on
>>>>    # dmesg -T | tail -n 1
>>>>    [Thu Jun  9 08:48:19 2022] ice 0000:31:00.0: Error setting promisc
>>>> mode on VSI 6 (rc=-17)
>>>>
>>>> Could it be an 'ice' driver bug introduced in the 5.18 kernel?
>>> CCing the regression mailing list, as it should be in the loop for all
>>> regressions, as explained here:
>>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>>>
>>> Jaroslav, did you try to revert the change that was suggested to you in
>>> https://lore.kernel.org/all/d993bbb6-e583-5d91-76c0-841cc5da86af@roeck-us.net/
>>> Did it help?
>>>
>>> Anyway: To be sure below issue doesn't fall through the cracks
>>> unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
>>> bot:
>>>
>>> #regzbot ^introduced v5.17 to v5.18
>>> #regzbot title net: ice: Error setting promisc mode on VSI 6 (rc=-17) @
>>> 5.18.x
>>> #regzbot monitor
>>> https://lore.kernel.org/all/CAK8fFZ68+xZ2Z0vDWnihF8PeJKEmEwCyyF-8W9PCZJTd8zfp-A@mail.gmail.com/
>>> #regzbot monitor
>>> https://lore.kernel.org/all/CAK8fFZ61mQ3AYpdWjWtyUXzrs-RVMW61mBLrjRDXBxB-F9GzbA@mail.gmail.com/
>>> #regzbot ignore-activity
>>>
>>> This isn't a regression? This issue or a fix for it are already
>>> discussed somewhere else? It was fixed already? You want to clarify when
>>> the regression started to happen? Or point out I got the title or
>>> something else totally wrong? Then just reply -- ideally with also
>>> telling regzbot about it, as explained here:
>>> https://linux-regtracking.leemhuis.info/tracked-regression/
>>>
>>> Reminder for developers: When fixing the issue, add 'Link:' tags
>>> pointing to the report (the mail this one replied to), as the kernel's
>>> documentation call for; above page explains why this is important for
>>> tracked regressions.
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>
>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>> reports and sometimes miss something important when writing mails like
>>> this. If that's the case here, don't hesitate to tell me in a public
>>> reply, it's in everyone's interest to set the public record straight.
>>
