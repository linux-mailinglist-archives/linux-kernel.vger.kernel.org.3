Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253595AB138
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiIBNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiIBNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:12:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56136178
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662122989; x=1693658989;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sEybCS4mScmRq/7ZHkgu/VTiC8pHNgRzrbEQEElBsGA=;
  b=HDCfkdWcjAZ9pFlsJA5QMwiCYBd2pkZtgyzGgqsWyvURb7IYVSg191hW
   hOpG8WExKTcJ/0pw/SdQ6KQyRbTzqXqF8HgwqkkJ13H8MB/0+n+wj4ldq
   maSHYeotafcjLg6IO4rFMMAz02NXYgqg1GOOpuI9DBlBGRBn3QNr39GRC
   8tPgjERpdTvAtgyEI0ott8H12wlDOJzaajOPKGgqaqYDFBPh/HJK3x1jQ
   54UEotZwtD6PjvdYRlT4dCGXhoP/N+b7FRLo2UhQWTYB7drCwzrT6TLNq
   RP4aNsFUtNeq9WBSURI7aLs5zzAoOfSGgc/QDOTz81H7cxbZij58POLvN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="357688356"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="357688356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="738854346"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 02 Sep 2022 05:48:05 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 05:47:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 2 Sep 2022 05:47:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 2 Sep 2022 05:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdxZGP6o8NmtO/w4tsvB88kxwkpYQNxAlNfgydunRJLYJhFmKkl/RQ4QybzZatRqSrRg1a4XwZEATX+0Ntl+J10yqQbyv2iEMG9IsdSn/lPP85wkfWZ9U7tKwBZdb4ZqyXEosUBNlP+AWC2PdS3SM9Wa5K28gioRQWw9pV2p6vyMmsMoOSX8FHVapYkCgtUOFCQZ5uhdouxvqjh9DxAXrfhqf08fS2FZ/1+ko0sAGZBtUo86pq0GOwwQcHSZBfFQoWQMJcnEKIHkCgtoEIA9JEEAtXhJqzFr0ZxRtR1rn1C4iuhCHvhrXSI5bgNNafyNINYbthqqhix+6rCERiCOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkCzUpSgXDolO4LUP0Xs1lt9HVy/n+m+9Zx81CWRH1k=;
 b=aPZQTe+oet6tUHNoIjdF8dj7B9+VpTBAjg8DH4jnO2bwq+w8LLcxge6QFBba8ehu4wbYSpvCg53Yd4fltCcCAT7OqKBVe3R3Uz6hfa6eTHcEzkuCCc9OC46w64eyEdEBMFF/Ta2rcvUXm5SsFto50NJJ+d+4umCki9lYlkYRMjCnpIU7OBrUmhUEKUGKReJ2gkFtqXfPNLyHhEWewbmJMMwD+9su6aUypKDd/ALLWE7CqOWB4Umyi4IjcT8NXbOgHNbh6Ua8hZcyra4tE/S7D6bmmAExrtiq+UTebdi1B36yBXl73NTC6PK9HicZq0pRqiyYGjQBNlj2IpAsY9jIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Fri, 2 Sep 2022 12:47:57 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::f9e1:f470:f60f:fb02]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::f9e1:f470:f60f:fb02%7]) with mapi id 15.20.5566.015; Fri, 2 Sep 2022
 12:47:57 +0000
Message-ID: <2410bc5e-4278-ed69-c57a-868ec01ada21@intel.com>
Date:   Fri, 2 Sep 2022 14:47:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] lib/string_helpers: Introduce
 parse_int_array_user()
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <broonie@kernel.org>
CC:     <tiwai@suse.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <hdegoede@redhat.com>,
        <lgirdwood@gmail.com>, <kai.vehmanen@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
        <intel-poland@eclists.intel.com>, <andy.shevchenko@gmail.com>
References: <20220902122928.632602-1-cezary.rojewski@intel.com>
 <20220902122928.632602-2-cezary.rojewski@intel.com>
 <e48ffb56-f220-adf5-87ca-1826397f2e7f@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <e48ffb56-f220-adf5-87ca-1826397f2e7f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1820fd4-8577-4781-98c5-08da8ce15c3e
X-MS-TrafficTypeDiagnostic: SA0PR11MB4751:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvIaSebmoNBbxHpshviN0ApSA+9GHUE7MDHpuMkE86sdHjN9CWyXFGdmKVMJIOk2/cS+OJ/z1RojJS5uKTiiOzCXpjwAV1GnhvbvoiURtTTkejuIuKi8myPPsNPxDFZdZguV7KGWn1jKfdnTEsrWTkzyOnlfQqyaLFJTQGdtt02A/HIx3MvZmPZRsiCD/9zynkUeEIUG7fBJjuHWCDHCeZE9svRRhbvKk3zB4os1Vt0h+ql65cJnoYvKxM5GAmd/8gmWOyCYHskEEK+LPhH+qluL1X9cIP0qMCHLTasH28nbgyQY6ubItt5nJ7tWiXqf7nmqkhRbTDfp0QKYvN5quF/Q+O4JECw5XFXBUz5RnTk0LbaGG1tBJoOWiiHYOKMsJ98KstBwJsV/9ZNq8eZUrlR/AH/RwgNQALxU9D3/0e4YzFxJc8/JLocJ0EvRk6QOTj0YMA+rWmomRi5CQ2G+33171JYHBw55jQoMhqjXA6XRlp0u4lV/zs6Pr4ydlrf54oBiUAFRIzc1yLogPFChY/+cIlt0PXGENIn2nbzN3mLeODF56Tm6yyMGLoIdPAOqaUdjAHx5jAqNDcyPOjT7s8o/mYtwudH2twvkQ3PiDhLcwm1h4o3h1UIEnNL9d3ldH19bQaS/u6p09O7N83WJtHuEkqmRlfdtckjV3+nUOFH8VnQNUNvf3A1v2vzxSV48jzHhAUJ96AycoX59o4roH5bgud8mhBDrSI8Pmh3mnFLJ3WV+3duc4seMBuVZ9gysubCGhl6plOPMUZ7HXHNleOu1Y6ggquOgi1fvj4i/9HE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(366004)(136003)(8936002)(5660300002)(6486002)(41300700001)(6666004)(186003)(53546011)(2906002)(4744005)(44832011)(7416002)(2616005)(66556008)(316002)(26005)(36756003)(6512007)(6506007)(82960400001)(66574015)(83380400001)(38100700002)(8676002)(31686004)(66476007)(4326008)(66946007)(478600001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnY1Wmo2dmszL2d5UTZHc0xrTHovV0NYcDc4c1ppQytCdE1KYWdISEpMaVZO?=
 =?utf-8?B?Y2dJMWRPTlc3Q2hKWlZTZU92MG1kVG93aG93TG9oaEw2T2QyUm00WFdyYkZU?=
 =?utf-8?B?RmVkbzJGNTU0UDVpQ0pHeExJc2diNCtVSWN4WHdQZWV1bTJDdUY4bmlEMUQv?=
 =?utf-8?B?Z1BEMFg4ZEppdS9NaHZacWNOMHhWK2VPdWpNRUw2dklCUWkzcHFkQTZKQytF?=
 =?utf-8?B?UGYxOVFEZnMraU9abkJBSjJBRWlMT3RKeVZCYk01N1JBZFQ3RTU2Qm5hRXkw?=
 =?utf-8?B?a3ZxU0puRnJxNDROam5ubWhURXFodGR5V0xnbFl3Y2ZFRklmcDJrWHJ4Mjhz?=
 =?utf-8?B?K2JUOHg1dXkvcXIwN0hqSkRXNjFmVTRrRytYd3h6cmxhdklNRTF3QUlMa1J3?=
 =?utf-8?B?Y0ZSQy93MmlnYVppZ094NWtHTXRYLzNKdmlTMHgrZTIxZWNwTnJYOXhiZFp4?=
 =?utf-8?B?SVZJeCswVmNSL01pbURIQkRJNWJqbndMODA1R29wZFJjVW1QRGR2bWVHTGhj?=
 =?utf-8?B?dklWRDNnY3B5cXFreFZXUG1uOGkvaEtBa21XeVlSNWRGN09WODNrMkFSZzlo?=
 =?utf-8?B?VUZJRXN3Y0QyMFVXNHMzMWVqVWRyVUZiakZlTDFxQ0YzRjExbFZxcTJmN1Vy?=
 =?utf-8?B?VmluQWN2aWZCQ3VhU1lyOGk4clZWZnJtSThUTzdKVVJCRUFYUlEzdlh3anps?=
 =?utf-8?B?RTFoR0szWnF5anNQRzJadHFLYXlmRUQzVGZHcWt5anQvT2dDVXhldUlveGtO?=
 =?utf-8?B?aFJib042U0s0K3o3TEpqa1RTTmUvVFptMVIrSTlGSFBXYUtHMitMR3FxS3NE?=
 =?utf-8?B?UWZaYW1HaVhrbEtZT3B3cUl5ck42a0hCN2pDMFNEc2FXYjBJQnNRREZEWGk4?=
 =?utf-8?B?K3ZEdHNsbjVCUm5ZbFVKMUR5SW1nRGVlbXZybFpGWkZsYjhkMm04R1cvSWFI?=
 =?utf-8?B?WmhaZm5qN1Y3OHpCVUZMZ0ZzTEU5RG5pa0o0UTBOcXh4QURXeU1xSEVDaFZN?=
 =?utf-8?B?Q3krVkN2dG9ObnlrTFFJdU1FT3lzMnpjYVJ1Sk1jcGR3TDNobWNKRm8rRVdq?=
 =?utf-8?B?YldwaThxZXFDeVVMYVNVQjVBbDh3YW9keWlYWHNOMlQ3bjJFM3NXNlY0UEwz?=
 =?utf-8?B?S0JCRGI1bUV1ZTNXcERpYXBjaDZXR3F2UHZUS2hnQndLM29WVDhBRnE4UGpD?=
 =?utf-8?B?dzRWZlgwUmZRQ1pPWmNjZnNvdG15K0NMaFNEUlpjajFUSEpuUEYzZEt0aXlT?=
 =?utf-8?B?NlZyLyt6R0lCbWY3NkhvL242ZnRGem0vY2ZQRlRWdzhRTEJVMS9aTEQ5SEtP?=
 =?utf-8?B?Q3lxeU4zaXhWYUFFbG1pNWpzL0pKU1ZDcmV1OFdsYmVxd2tYbTNoMGdoYzV0?=
 =?utf-8?B?emZ1UVFkOWQ2RzRQNXVQSDg2ZE1mZUxHdW1KaFg0a2RaV3NseW0walFtd01q?=
 =?utf-8?B?MElFbGJVdS90UzBRclJTc1hidUFmYWY5dWVTVnJVSFI1RVpUcUI0ZisrMC9E?=
 =?utf-8?B?R3l6aGdhWHoxeTNTc3BhMExHdnlBZUdBc0hQMmRXLy9HOHlkKy9kNVVINU1x?=
 =?utf-8?B?bnZabnBRS2EwbU5zNVVvdWh2bUY4cWk2a2I2Tm9BUlRCRWh6MjVPY1A1SG9H?=
 =?utf-8?B?QmhLRUpxV0VOQlM1RmdPcWNTdFJOeHIwa2h4WklpSGRTc1p6RmdQQ1JkNFZs?=
 =?utf-8?B?N3I4ZVVBVG5RMVdSTnRmWHRpMXd2YTAyYmQ2OFJnalNLVTNNQloxTC9tT21U?=
 =?utf-8?B?TEF5b0V6YW5xWlFsUGF5VStYc1ZVN0lwZkczaXoyc1l6UWl0SVI5aWorUXg3?=
 =?utf-8?B?blpDS1JTbVpFeTBFbHRLR0krYjUzc0xWc1ZCcTYxMDNydmo4SnJTVUh2TzZh?=
 =?utf-8?B?dVBIK2FZdzhmZmtpTDFkSm5Ra0RQRjJzaWZBUmg4SFQwNWtoMThVQVBjRTJ5?=
 =?utf-8?B?MUlEUjEyYVVRNGpoY0o1anlEMmwrU1BHVkxnTkJhTXd1aDZjNjgvU0NiMWVB?=
 =?utf-8?B?V3RGNU9yMXc3STd0ZjF3elV1VlRmU0NRUmVpYk1RUmU5WUx5U3RFcHZqVmhR?=
 =?utf-8?B?RzhjOEd6RG4raG1uZ3d6bFIvblV5T09jUTAwMnlPZ3Njd0Z1WWRKdTdMcWtl?=
 =?utf-8?B?S0xZcWFRU0czVHZWNEVHSmcvb2xrK0NlSjlna0lVSWtBbTFTNkNjRVRuU2dv?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1820fd4-8577-4781-98c5-08da8ce15c3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 12:47:57.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A92N4LQINyvdBV1lKnwUtZO88AsJAfHLmLahtcU/sLvJA93gBi3idKC1jOzkl10vdcXioIeouMng7uPCAjN0CcLC8BV2eDGNzzaD7dQmF/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
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

On 2022-09-02 2:23 PM, Amadeusz Sławiński wrote:
> On 9/2/2022 2:29 PM, Cezary Rojewski wrote:

...

>> +/**
>> + * parse_int_array_user - Split string into a sequence of integers
>> + * @from:    The user space buffer to read from
>> + * @ppos:    The current position in the buffer
> 
> There is no such parameter?
> 
>> + * @count:    The maximum number of bytes to read
>> + * @tkns:    Returned pointer to sequence of integers
> 
> s/tkns/array/ ?
> 
>> + *
>> + * On success @tkns is allocated and initialized with a sequence of
> 
> ditto
> 
>> + * integers extracted from the @from plus an additional element that
>> + * begins the sequence and specifies the integers count.
>> + *
>> + * Caller takes responsibility for freeing @tkns when it is no longer
> 
> ditto
> 
>> + * needed.
>> + */
>> +int parse_int_array_user(const char __user *from, size_t count, int 
>> **array)

Ack. Will send an update shortly.


Regards,
Czarek
