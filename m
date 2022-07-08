Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132756BEFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiGHQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiGHQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:32:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFC10EF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657297971; x=1688833971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=elJ6UMdCCehzzo8LYe7jT1CPL1XSd/IDjxWKkLocVm8=;
  b=BqxklxsNTtbXcG2BZQirr9Ia27PPnhKV4ARGHTcv55GfRscoe1EGvlD+
   TfHc97nbsGH+fOTtrhurx5ycU6jprqhmJquw0KV7F0Gi/P8T/4U6zdeG4
   RELrgU65BPDSRRjDJVI4Ii9qFEahcDEaRZxv1fpaxH7KCo0KqXXskCGfC
   8B0VZ6IoPezgsvEI7WuHPBP1xDSRe+fzofeLeJX+9smQbvbOB+S66ThSk
   ycOvrFoD4cjxDs4coNgNRyiRjA7dBcJJfbIsH6PvupGS29g9SSgjFpUGl
   EDL7m/Lk7p8SeUwAgaZfIFtAbBjXFK+VNR9V1asg83VhY7Z2Tg+FaZn/3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="281871902"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="281871902"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="598423738"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2022 09:32:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 09:32:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 09:32:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 09:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMGsuScCH5Ks0EYdM4dNO8eJUtS8gdLuWRtMvfob8H2SUfI/uJV/4XlZXkl0k4cys2eTfU9qLTZcKg4JG1Hqyeo00tjTSnhPfstHUHI8Pq+PdwbUfx7IYODXq7njNJe68B6LzxhAjgvpMhg6DG0Sj/2equAY6+g2ztcHikCH+mQa/WF7Ygz+PoofSWSy+d0sAmahlCZlNgIu4VRdaldn7E8rjvmr2parZrAdgK7kO9tPiqwaAh1YuiM8xNDH0sS8xn56rG2BI+0hrqjgote5FqKXga79cnhHdewRfI4nGV+bnoKaRZzT4bNocv5V+7mjsR0IEKxepn9ao3AFHaaInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPJj+YQ2zrdyqxDIdzWWKLYDIlHIBsvE3kbDZtNrVg8=;
 b=OFGA8XvoXQEvvTVWPlnnA6TWqjZo6sFzLT4kC91U8sIMPzaNyWudcxZ8VW5cQDk9K27FyM2huhbNMAJRVn918uJ5aGy8Uurj/yekgFGPeWqiwcR0o9sYgCZid6FfuORFttZA/8++4GbUjAfNTvwH7/x9doiPqTCpwgQvP6f4rySD0fvLl0m4sMILWXxO6Hsf/rEIHP5xy0gPbKa0OgdVXMSCVcBgudCH1+to7fEtr/Lp5wEBItiGpzKnAunpQemapypzEtgsd7xZVgcsw+DaCGGVw2Xkl8qSpJ/UkhuN60B8iZd4Eor3v8ZEQqXDSzsc/IlM2xHsZvFeYUiAF5A08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 16:32:47 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 16:32:47 +0000
Message-ID: <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
Date:   Fri, 8 Jul 2022 18:32:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
CC:     Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
 <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0038.eurprd06.prod.outlook.com
 (2603:10a6:203:68::24) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c12ab39-dbc6-4caa-1213-08da60ff7dac
X-MS-TrafficTypeDiagnostic: DM4PR11MB6066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80Co1s6Xt6FV5z+g8GwGMkLwhyPe6PaJHG2Rz1FV+4Pf7hB0gl3/9iStxUnvbdxSDgCPx+IOye6G/oPh+OWkhON1EmoDRpGvRQD/TSHFprhLzDKVDr1OHvsAqDRHpIx2t2i9GtwfPOUYKUsO8nZOYuiaakuGA+hPIt+9Do3Pi985BHMUYFrwXeJxUG0XJpt9K112KX2CQRu1vw5jaaMa+1tSQQH5iWOhcSPlmc+qtnUXI+zDoWwL0IIIqTRMedD3yuBlUECftTICZc4HYTLvWyEPTp7aGz+ZrzzSHB1w3o21LVlf1N0AUFp2ps4jQGNwVRjk9Cu3xdnHrqfTCSrsJ1ETN+2aGRLpcMSLOhmD6inz65FFxtwkdcLkZf5Fg5oWIdkLYq9X4h75tO+roYFpziVM6vYi1JwdfY2/B6LBig0d/I/UU5Y+ExmzhItZ2Ae2L/9Zgvq6fWH8JSbfiDMyjJp3rgCQDKG6hSSSeX6SwW4BYKWBMsnqYDWJtg9aNd/KdU+qt/IHLmmHkUCWOkzt4KiAEqG2ExHD3iQQU8/lfURt9/KNDK0I/9VQ2C8bgIbA7ehjHzHnkyyCsOoie/Ln3+0AwAszQTzfKOj3sr6Yuu54yQ5dRylWJF6yUOvq0XhUOgcBruBvdhpYK7eAkpkrBsHbw5ooqIJFvnpOnslYyLl5HbFq1uZqO7f6GjVQbnx2N/R1ypFfud8YMHiQUfrpYuDJjOioogxXGZ6XKBQUT7j4ON0UyL+wQb3MFKvrjmpO0oNmm2EVeAt7L7b5ibuQJ1ZrlXsFSLToc9HKXVL383UKem4bOiStzxSuANRy0G1RTdA3ehQ+zRdsQjws36CwOh7XygEroNLgfr7Fmx9stlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(136003)(346002)(36756003)(186003)(8936002)(31686004)(5660300002)(38100700002)(4326008)(82960400001)(66476007)(66946007)(66556008)(2906002)(7416002)(8676002)(44832011)(6512007)(110136005)(6506007)(26005)(53546011)(2616005)(31696002)(6666004)(86362001)(66574015)(41300700001)(83380400001)(6486002)(478600001)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUh6Y05DblViKzE3Y3dXc1d6RG9BYmh6cFZnZ0RmWmRrV3AxU1BwZ3VzN1RB?=
 =?utf-8?B?ajJiemszUlM3cGxwaHZ0R2dYZVBVU3NlTjFEcDVJRHAzNi92cXdJK2F4eTUy?=
 =?utf-8?B?T1ltK3J6TFkrNGlrK3dYYldPNTRKWTVoY0lacDZEdmkyVU9tRGIxa2VKbWpX?=
 =?utf-8?B?RXdsNHBrcXg3aEM1dEt0b1h6WGNmSkxQOVNKam5yMHM3eE11aHkyZGM1OFR1?=
 =?utf-8?B?RzJxNTl3RXBiWlM2aGpSRzJuN0t0cklpdHpKYzRKRXhGRTlUOHlEUUxoZWt6?=
 =?utf-8?B?WUY2TC9DUTFaTGI4SWxyR09YWDhTU1N6Q3hWL1VodURETmRuZndMSFdaeUQ3?=
 =?utf-8?B?aGF2OTVBQnV3Y3hJa2RWVHdBVnA3MlZjdnM4YTRFOGFUZndtb2tzRnFWMFdK?=
 =?utf-8?B?VlFobnpzSGtDc2UwNndQVWkyOFgyV2NyVi8zbUlHSnNjVFA0VmVZblFqN3ZO?=
 =?utf-8?B?WDk0a1lNVy9RaXY5U200dE9odEh4OTVmWVJMOFd4dnptc0hyNjhiVFFqd0Q2?=
 =?utf-8?B?RkUyNGRMWlBDRGh4YUoweXJTSDkrY0RoQTFZeDN4Y0Rkc3czS01sQnY4c295?=
 =?utf-8?B?SGh0aUtDMWcrTXZ4TlcyV2JManovTHdac29jWkxNWEhHcjBsU3lyQ0ZzSGV2?=
 =?utf-8?B?MzhhT0J6clUwcWlCZCs3V3BWNlZhZXNyK3lrdVhiazhjaGg2ZkVZOUZGdW9z?=
 =?utf-8?B?b3FtMmloYUNiR1J3NmVwTmZjMmJwcHB5Vjlhd2RXZDJGaUJoOVlwSFQ5TkJP?=
 =?utf-8?B?aGdlMzVoZWdEc09kM05aVUt0M1Ayb05URDRQaHg0bUJDb2lYTjdyQ0VHMURt?=
 =?utf-8?B?cmwxNnV5TXlQRmY0VEQ0WWU1a0FXaDFpMGdtTEdrZ0JqNWh4VTdQWVBBb3JP?=
 =?utf-8?B?MEJ1ZGxIMWdpRkFLUDluUHVETU1VZHZvYUlBYmUyU1MvcHIzVm9SdHJZaG1s?=
 =?utf-8?B?eXdDRDRjK2xUZUZEWmRiNGEyeXFWdVROYUVHZFlkdnZ0eVJuV3RZc0RML0J5?=
 =?utf-8?B?SG9Pa1l6YkZCc3VMTDlZMG9JbDQ4bEp6SlhkM1BRanVBdUVHblJNbGhoMDZu?=
 =?utf-8?B?allaSmppQTdyay9jc3RsdFlyK3BUcnVaR0hUOHdwR0JkYzZCWVI5emZaMlFK?=
 =?utf-8?B?dXZoeUV3SU5rcFNLRURBb0U1cnNLTG52RmdaZkUzeVR0M1pmMWI0OHhRRHFR?=
 =?utf-8?B?Q0FqaEZmTFRIMkhWNTl6LzFDdWN0NjNVUURUeHlWUDRFR1hQOHJpRWZ2WS9S?=
 =?utf-8?B?c1MyUjArVWpOYXpjT1Y5dmloQ2JNajdCZSswbHd5THpKb2FzYTdZenByOG41?=
 =?utf-8?B?TEdoSTgzY2tzUnpsclI2TmtsdkppcVFjZzRMdXRYTFR2a2FKUHBiRmJ4Vmtj?=
 =?utf-8?B?RGlmVHM4SFBicGVMWG5Ja1g2eDdMSjgveUpDbXJTNlpUdjZ0eWN4M0UrK1FQ?=
 =?utf-8?B?UTlycDFIRUFhRUJoNFVmcEFLbmo4OXBOYmY0SGQySnJnQkxkMHRWRjNxUUNI?=
 =?utf-8?B?aTdDQ1NEZE1aTVpNRzAydThWMG9EbFl4MUFsL01FclRFZTZtekpXZklKM1dG?=
 =?utf-8?B?OERHVWQwWUNXbVVFeUpKYXp2N0R2VjJUMmsyWEZzTkFLTGZZYWtPNXhVa09Z?=
 =?utf-8?B?ekhpTHM5bHFQZnI4d1QrdCtPTkZlZnZtRUVma2ZCNUlUZW9rcllBQ2s0dEJp?=
 =?utf-8?B?d1QxcHlMcEhJcUU0WjFld2NJaTRoL2QzZ2dOa0hnaDRBdTZtU1h0cDEwSnBt?=
 =?utf-8?B?WmVtT2FZancvOGxWU1M5R3UzYXBYVTFqWnB4emZ0bEl0d1QyMUt3UXVrSysx?=
 =?utf-8?B?bEgvN3JVZVlERldiUXZLOHNPUWhqSC9FRXpoR0RUL3gvUk5pRjJST2ZKREhy?=
 =?utf-8?B?YldmcGJ2a1ZEWW9meFpOTUo1R0wybU9kMW1OSEF6VDFkQWlJQ2wxOHI2aE5L?=
 =?utf-8?B?Tk1SZ2ZpTy9nTFJrM1F2WmplTzlSSG8yTHJCblZDMGlYMzFrK0dJaG5TN0kr?=
 =?utf-8?B?RE5GeEFLN1N3U0RBUksweFJIZ3BadFk1Qy92dkJwcVZhSWt1dkVRNXVDOVBu?=
 =?utf-8?B?MzNaTjF4Rnh2Q3duSkwyeUZMTW85dndYN0hCYU1haVpUMGVHdFdKaDhyZEtj?=
 =?utf-8?B?RTRSaWhHZmtpTGtlRnh3Vkd3dzM4VmVERk8wTDNlclVCbm0wNHdqazd1d0RJ?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12ab39-dbc6-4caa-1213-08da60ff7dac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:32:46.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW1fkcRQHtok8x+cevK0pco6Q1K6sLJKvSynChjWoNNr3dx92WjPbZ1rGPnKiqq6+cL23PisakV15MWeplXH1fLjPQxPLN0jRTwMShDexhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
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

On 2022-07-08 5:25 PM, Andy Shevchenko wrote:
> On Fri, Jul 8, 2022 at 2:34 PM Péter Ujfalusi
> <peter.ujfalusi@linux.intel.com> wrote:

...

>>> It seems you are missing the (1). The code has checks for the case where you
>>> can do get number upfront, it would just require two passes, but it's nothing
>>> in comparison of heave realloc().
>>>
>>>    unsigned int *tokens;
>>>    char *p;
>>>    int num;
>>>
>>>    p = get_options(str, 0, &num);
>>>    if (num == 0)
>>>        // No numbers in the string!
>>>
>>>    tokens = kcalloc(num + 1, sizeof(*tokens), GFP_KERNEL);
>>>    if (!tokens)
>>>        return -ENOMEM;
>>>
>>>    p = get_oprions(str, num, &tokens);
>>>    if (*p)
>>>        // String was parsed only partially!
>>>        // assuming it's not a fatal error
>>>
>>>    return tokens;
> 
>> This diff is tested and works:
> 
> Thanks, Peter!
> 
> But at least you can memove() to avoid second allocation.
> ideally to refactor that the result of get_options is consumed as is
> (it may be casted to struct tokens { int n; u32 v[]; })


A long shot, but what if we were to modify get_options() so it takes 
additional element-size parameter instead? Something like below - I've 
ignored get_range() though. Will re-visit if this option is viable.


diff --git a/lib/cmdline.c b/lib/cmdline.c
index 5546bf588780..272f892b71df 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -53,7 +53,7 @@ static int get_range(char **str, int *pint, int n)
   *     for the sake of simplification.
   */

-int get_option(char **str, int *pint)
+int get_num_option(char **str, void *pint, size_t nsize)
  {
         char *cur = *str;
         int value;
@@ -65,7 +65,7 @@ int get_option(char **str, int *pint)
         else
                 value = simple_strtoull(cur, str, 0);
         if (pint)
-               *pint = value;
+               memcpy(pint, &value, min(nsize, sizeof(value)));
         if (cur == *str)
                 return 0;
         if (**str == ',') {
@@ -77,6 +77,12 @@ int get_option(char **str, int *pint)

         return 1;
  }
+EXPORT_SYMBOL(get_num_option);
+
+int get_option(char **str, int *pint)
+{
+       return get_num_option(str, pint, sizeof(*pint));
+}
  EXPORT_SYMBOL(get_option);

  /**
@@ -104,15 +110,15 @@ EXPORT_SYMBOL(get_option);
   *     completely parseable).
   */

-char *get_options(const char *str, int nints, int *ints)
+char *get_num_options(const char *str, int nints, void *ints, size_t nsize)
  {
         bool validate = (nints == 0);
         int res, i = 1;

         while (i < nints || validate) {
-               int *pint = validate ? ints : ints + i;
+               int *pint = validate ? ints : ints + (i * nsize);

-               res = get_option((char **)&str, pint);
+               res = get_num_option((char **)&str, pint, nsize);
                 if (res == 0)
                         break;
                 if (res == 3) {
@@ -133,9 +139,17 @@ char *get_options(const char *str, int nints, int 
*ints)
                 if (res == 1)
                         break;
         }
-       ints[0] = i - 1;
+       --i;
+       memcpy(ints, &i, min(nsize, sizeof(i)));
         return (char *)str;
  }
+EXPORT_SYMBOL(get_num_options);
+
+char *get_options(const char *str, int nints, int *ints)
+{
+       return get_num_options(str, nints, ints, sizeof(*ints));
+}
+
  EXPORT_SYMBOL(get_options);
