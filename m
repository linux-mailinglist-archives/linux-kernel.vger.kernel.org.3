Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73181598124
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiHRJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbiHRJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:54:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63CA0617
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660816498; x=1692352498;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XILJI79B1EMT0pLm48zCqOu473yeVZbm2kLvnZoe2yM=;
  b=REYVicqhBpWC8sARMXmCnsMghHOziJO/zUVet25p515fFxfd9a98dv3m
   ZPaTJpeMVo+1jkQ+Lw+x8AO3326LYnJQyoOGpuYwfIop8ZYP6g65pjd+V
   0AvPtJdwal6dhVa3elNhe/B8EeFfJbHZX+HMXnPWfbGXWnEqGwcZNqfnz
   xaBA9+ELpuwwneH3LrMRcLmzT+56ybobYzqpJdUWI+6HxRbO27GQOZb3O
   RXdDukOqVxz+HnC3QyyG5M+bbt+MoPMFgz1lGOpB7q7uv5NMf06Ypfp0f
   /65RMZamu/iCHQSzXjctb4TTU/k/JUgZ8Sp4ddHQVF4woph6xTFFfWmuY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275766350"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="275766350"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 02:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584145951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 02:54:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 02:54:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 02:54:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 02:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzwxjwvG5a5v2f3hYHjV9bn7FfJqF09aEsg2NJ2M1OWpfJprU3ItpqGSYxsAtWIpm2nHOgZGru6M4gEaD+3tTZGn/0IoBV/l89szKc/Zcn5XDrns1RUVRveFweajL8RKIh+gcg8qJY98AsqKc+vNwj/c2eFqVt8zF2vYE4HTsIaj7i7bo3mxWBkb4DH8QraOtpqnDIxz/FwomrMUm3mdZMuG6gNrZMfhSbNObuR1qKgrsFXJBfVlJtU8Sp9xN8U+MRYSOTcau3aEHuOxpWa4VI/wvkHioHsI/BeICs/umOVGiM7LNSISBxaEtb7oDlRtmM8fRX1XW/Li5oosSAm/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D77LS0uFi4sy0fmAFvOzu7lTFz+/m2YuoYJcmFayLR4=;
 b=a8iFiOkq1tQeK/zuGtIXOSou4Vf+JZ5ouYfmzw3HbeLF5AeG2I+mTYfMYp7zZsLjCUsEl+duHTGNn8eGFV2grFsReZBRvh57qaDhXAS5u7GXQgN8iAikEkQH9FhWm6lS+ZjdX8F2oaW4VYFjACXoABczePGyetNh6souA3eJ3v87e4cYeBecs5GiPz2UZ3xNxU3/AHV9SeT4tWibbrYRv7l8M18CkmqHdaaXYW5wCxflLaOyw2yUgf7P+c2WWa0frYBL9DD1x7J7ixOjxRMQG6+lfSTW7v0tMWpYVzxYX1FNEhQc933xNzo3Qkfgh51QpWvRPpMiBs2naZPfQkPFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN9PR11MB5417.namprd11.prod.outlook.com (2603:10b6:408:11e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Thu, 18 Aug 2022 09:54:15 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 09:54:14 +0000
Message-ID: <2b70d631-1d59-d841-e9d0-9f6b254ed940@intel.com>
Date:   Thu, 18 Aug 2022 11:54:08 +0200
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
 <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
 <1891bc72834cb6e25d479c3968c04bcef94c3ad5.camel@icenowy.me>
 <c3386d45-b643-b4aa-c868-5c113cd2955f@intel.com>
 <24882ec3fed5c9772e1b04088cecece1b2477b23.camel@icenowy.me>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <24882ec3fed5c9772e1b04088cecece1b2477b23.camel@icenowy.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a34ece-2894-4f3b-6978-08da80ff9b8d
X-MS-TrafficTypeDiagnostic: BN9PR11MB5417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHrwcMz8i5LTrfMoGkKe3a/1DFNXFtqcwJwjPTnzBE8h+C6IruI8bdIsJMJqXoFbWQLWUQT8kewEIVjcQ57NpmhKI50o76jEcDREiEZIwgp2oGDqu8bCYrQtVJfxt/emGdOp+Os7mpm8EUUQKJAg7gmLWkBcMUqGMq5knb6YbLKK4R/IWOyW9FFbaHkiiJsddbbH6aanlPz4SiaZ4IJ/zdZDlqmuvyFVESh9qctVpMzLPKu01cAZwZWW1Gl6uZXlicaJ9aG7GDWiA/5IadJ/8EoltX5nCvX114Ro+RZXxNnfD7K76Na4jEJxqqDRu3L7HtSJSKU+gOuEl8vrixt/Q9ptonEvROBAb50/CfLkdds5wRSm3UjwjmZEgt+yu4DFg0ht43WmgK/p+eV6kfza4233TK2/nsASc0VixmcA1zLeHPD2EteiuGuCmdn7ElQlmjlv2dE8x5/6AuYpuajVMWJ3nTSno42uAHJmIb72UOwf32FHDskr6UvKYVRTx+0CwdEUjwQJX5ISIwLy5/dH43yom6z/I1tMmm1Ocn2M5hbYtmPFAo0INH9C0N6hNorjiSdaMefe5xdV0adKVoZsV5Vdsc+OIuJ2wEQBo4YBBWSN1aE1qt0ybfyMxPM31CS0e8zZAJ2egZmdb/0jmRGxThKpBRGvpR4F7USX911lJyEfROV4WpzH5xW3LHf83mctL2lLhSShBjR6CnyJhBKBEyVFXxfEGHRg3KoJE72A2qN7KLhHiQ/puUIlG1MJd7bq/NJNTEdigvljHQeLkgjHcidYMFAN0T05oljRkHSywBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(396003)(136003)(39860400002)(83380400001)(186003)(2616005)(82960400001)(6486002)(478600001)(38100700002)(6916009)(41300700001)(66556008)(6666004)(316002)(44832011)(6506007)(5660300002)(54906003)(2906002)(66946007)(53546011)(26005)(8936002)(31696002)(31686004)(6512007)(8676002)(4326008)(86362001)(36756003)(7416002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpxWXVXTi9QWWdKY0UveUs0cVZQTmRkdHJHaUt2VkxwWUVJdlMxWlRLNzZV?=
 =?utf-8?B?RkVPU2NidWZxRzBzb0taUHdqeE5hK1hHd0JBVDVUZkMvSHJ5K052WTlYNnl4?=
 =?utf-8?B?NGpaeGdGa24vNlpiMndvUGpLd0hFQTgyb2ZOMHcxRmVKYmtyRTBxakpRZ3dY?=
 =?utf-8?B?R3gyZDhMY1MwSFBSMGk0eXcySVBxVUFvUGZOY0JJeVNOU3JtOVRzMnl0YUc4?=
 =?utf-8?B?TmNNSzJMRmZnZDUxa29NcVZZL3lNTDRpNXBrdTY1bVVudm5Xb0ZIaWhheXZs?=
 =?utf-8?B?eWMwQll0N3BCZHRpd3E0OWlnN2lxcGRoQ1BaM2JZZ01kRXVEN3c0a3NvUHd3?=
 =?utf-8?B?bFVGVEZBVmpEK1FkSVlocm5ubHpsNTdQZ1JpaDJpeGsvRlVEVGNUdTV3TW82?=
 =?utf-8?B?dlppd29tcmVYMG82clJkR0o5bGdWOHEyOURJbTdRUm16ZWpreDZoNjVDZ2JL?=
 =?utf-8?B?RDlhb0xVMzV4SitiY3Zic1JFOW9Oak45d0swWnZCbktDL0poRmtDUGpIcVBv?=
 =?utf-8?B?eGpQUkpmVEo1RWpia08vbkR2VTQyZ2VaSzVidkZJVXRtMFZtZ05sS2dEaFpj?=
 =?utf-8?B?UGV0c1ZGYlplb0ZuUWk2Wm5vRWttSzU1THlkZ1VHT1RoRE1YWlRZQU1McDlp?=
 =?utf-8?B?czVIcVJjaHFtdEt5cGFhUTJlLzZ0SktwaEoyNWM5YXNxdVM2MCtSbzE3Umha?=
 =?utf-8?B?L0tWcFFRdzdCRGhIcFF5Q2NOSDZUc3MyTVcwQ3g4VXNXYy9jWS93Z3ZmMHdk?=
 =?utf-8?B?aXVDREc5MVppajVxbEZlM3VNb0RSTHJxZVBBTjkvSldFRCtuVEVuNko4V2tY?=
 =?utf-8?B?QmU4cWNDWDIzbGlMZzF1NTZtc1IveXVmaXJrQXhsOXlNVEhpSTkvbEk1QTNt?=
 =?utf-8?B?Z0tUUW05aTRkQXZ3WHdWT1IwZGF0U205N3h5aDkvTEJNOW1nMmk2M1UwaSt5?=
 =?utf-8?B?RDI2WWswQUJCS3hrU1d1dWZmL2F6b1BGMVhjUlAxYTg3N2RGbzRSc0RUQ3Yr?=
 =?utf-8?B?T01IWDdScGNjQ1F3RnFDNUxWdDhqMHg2NU1KQmloU1c0OTZnOG4xOTFwNXRt?=
 =?utf-8?B?TjhWaVVDOVExbytsOXR0Sk54VXZWT2RTcTd2RWxXaDExQ0dYWWZqSkRxUHFu?=
 =?utf-8?B?amoySWFpdGlCaGE0V2xLb0JoQVpwL0EvNENvSWk3NzlYSkpEeWJhMjRRajJJ?=
 =?utf-8?B?UlVnaUx1emdsb1JuMm90K1BYQUxac1lFTmVGMlZPLy9TY3Q4TklNM0p3c1Zr?=
 =?utf-8?B?cnV0amc1YW1DYWFSTTByWC8yM1kwak1rNnlPR1hTcmwyY25ZVnpPNk1XV0d0?=
 =?utf-8?B?THh5c3hoMlJ1MTZoSEhkTURxOTZQRFc2NDBOaG90ZzNMR3ZZMm5NNDFRbWJh?=
 =?utf-8?B?VHRTM2QxWDF3M1R6Z3dzeG50ZWlhZHN4UEVYY0xyWDYycExMd3B5alo4azBV?=
 =?utf-8?B?L2R2byt5Q0Fqdkc0Tzc5MGJPMzAwVllRZ004YkJ4V2hBRXhpc29sTXExUnF2?=
 =?utf-8?B?NnlRakt2Tm9yZlhmU0x4cVB4aE5mcW1zVWs0dk9iRmhuMkkzSVNVRkdneTlx?=
 =?utf-8?B?bURRQzlpUks0ei9MeVBDWHRldmlvZlUwSnc4NzZVV0QwQ0FFcTk0dkFjNlda?=
 =?utf-8?B?ak50SzdqUGozalliNmxsTHZiSWNNTFJWOWl2Vm1pY2FrRmFVWVZvZG5IV2ls?=
 =?utf-8?B?NmtURjhKL0NKRllyQ3Fkd3F5M1BHUHlDaVFSeDI5L0xyaURMZUszZWJ0TFh4?=
 =?utf-8?B?L2xQb1dORkhTeWM1OENTdm5wZDJaemNsMmRWcDdsZkx5cUltWWlTWEV2RjAw?=
 =?utf-8?B?QTN4aDk5eVV3NFNjZWNhc2hFN0xYY3dpVzRlc2NYR2g4Vk1GelI4aWRNaDk5?=
 =?utf-8?B?TTF2b1lreXpxOGxtRnNaeXYxK2hMQVQvRGFIdmZ1bVU4ZUw3NDZRTDlZZi9F?=
 =?utf-8?B?VFJxL0g0ckNSb2pVQXdQbjdGMVBuL1JCemczcktXbXNUK2l1a2VwWXc5Vjd6?=
 =?utf-8?B?YUo3TmN1Vm1sNDRpOFpEM2c0aVdHVjdSdG93bnFBRGthaEVZeXp1dXJCMlNl?=
 =?utf-8?B?ckJWTjFHdzAzY1ppSVRSS3pMeFVBY0Nqem9sZzJnUmFnQzQwME8ya1ZDUC8z?=
 =?utf-8?B?MWppZEJaRlo5WWdFQ2VCREtROUJ2KysyRldCdHJjUGZJRE1udVptYWxOTTBu?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a34ece-2894-4f3b-6978-08da80ff9b8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 09:54:14.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWMvkcq6/WRff0ZI2Beqp8FU+NpFDujCSsPE+VS3jd1PNkl9ZgVgXWMD6tcwyS8sWPsYC7h9H6+hzHMkdIytaG2nNi+6hMzIOH6UINMdZpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 11:25 AM, Icenowy Zheng wrote:
> 在 2022-08-17星期三的 15:19 +0200，Cezary Rojewski写道：

...

>> NHLT was left alone across all the updates. Updating it is one way of
>> fixing problems but I don't believe it's necessary in your case.
>> Topology update is more desirable approach.
> 
> BTW how could I fix the topology?
> 
> I now use topology files from GalliumOS (which, I assume, is extracted
> from ChromeOS).

(save)

>> That clarifies things out. Guess the kernel version used there is
>> v4.4
>> (plus a ton of un-upstreamed patches). Again, will propagate the
>> information up the chain. Perhaps one of the solutions for end-users
>> would be providing working UCM files to alsa-topology-conf repo so
>> users
>> are not powerless in situations such as this one.

The message of mine above is the answer to this. Without some ADSP 
firmware knowledge it's almost impossible to write a topology file from 
scratch. During v4.4 -> v5.4 transition several problems with endpoints 
were detected as not all of them were behaving as expected. Long story 
short, I do not believe pure v4.4 on some of the designs (mainly I2S 
designs) works as intended. Some external patches are needed for that to 
happen.

The situation on v5.4 is much cleaner - the problem there are the 
topology files, as these are not updated automatically when you flash 
new kernel. In fact, these were never shared in alsa-topology-ucm repo. 
Only HDAudio topology has been fixed and shared. As long as you stick to 
the original ChromeOS the issues on your machine should cease to exist. 
I need some approvals before I2S designs can be shared. It's not a 
process that takes a day or two, unfortunately.


Regards,
Czarek
