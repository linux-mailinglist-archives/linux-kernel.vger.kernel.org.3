Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166A475C01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbhLOPli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:41:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:43525 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244022AbhLOPlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639582896; x=1671118896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CjJ+tgJJPL5flJh/JNBmJt/Y5lrbJ+grzjzHvXPHEx0=;
  b=mg72frMlZLR3Ch2+L4C8stPSrj9dWDuXfHRt4jzgX23sQW+fMX+15aDN
   W1Lje1roD+Kr7pvMmBWxxcTM5rXWnXQnsoksvOf61PPCM3F8pqS5cucNy
   m3s1Ps76zjpY8H8ig9rpnw/0w0OaH/+gr9P+wpsSX3dwXCr2SHv4m/uKz
   vf/yJWCJtX7XBi6BpXYTH/ogEyz8ksou9Rent/QgCVRxn1H46om5opDBC
   btP7JPyDJrvciuF2CgAjl7WLnPak3XPrdZfeh0QXz7l5Yf2bVQKk9/j43
   74pWjtjYgkgDEbrcuiOnv1Ljba34/0W6bUzbDH8aArFIxmeAyfJdq8wm1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="300030801"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="300030801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:41:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614740413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 07:41:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 07:41:35 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 07:41:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 15 Dec 2021 07:41:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 15 Dec 2021 07:41:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU3e7pGXppj7rm2W9XTXeq4ISBCX0PKJXuxcPKdlO406peW8u/F2pjSbW6xdq3yKM3lmGyC30HAYGkbQAisQMBLWggYPBeTtGh6dXo7Fp35dWRnAdWiLUJiiJTCYAibNLUSloHyLEBp8FR9AoCwlUsmiCsmAuBYOKKn+vTQwjAi/TvcI8D4rwXvmkO74NgnwIQSrTQlgNtrjmZ+FhmFM3OKRf4/AcZVIy8h+OlRp9Q7TJU71meL/++/9TzXkLWgBYS0BNZXDSYht29tSQEtc715DrEnUAxkyUkSHIYCmpE3Xg3+zThX3piBSj6WdxMi8FSe6/STIiq68TcfxsSLJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VHq3hFQWXf7mtFTA0K13P2vZ7Yg+XB10RwUJXcqFJ4=;
 b=hlRzHe247dMTwZhW6EDiNRtEG3ULIRuJkmLuG1+e3Fwwei2940Jy0A+AETdXp6HZPpyWYbwFin1gRriy6/tVSRN19bPB9iOCvSDGgJqhFDHns34BPbkRhPbO1Q9kS5MylwdB3ZJBh6M6Y4szaG0bHPlsNxHuv44Xvyb3o/j7rqayZ/simdlS217fW5HXt8tHwuJ1aTlRxAVDMouFRzyt0OAkygrPj4v0vMVb7d/jhmiKYuklP6VzLoRwUhzBL6lsmOdrFireZCqwwDNZrXEwVUtduKwttRqJ7m8QvDuZKGEWSfjmwJzu7BMMxSuuN7oPwWDJaltZw2dynS1jxyUkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1729.namprd11.prod.outlook.com (2603:10b6:404:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 15 Dec
 2021 15:41:25 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::f956:f3b8:2f14:5458]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::f956:f3b8:2f14:5458%5]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 15:41:25 +0000
Message-ID: <e7678d20-6dd5-dd13-fec5-1881ffbb8995@intel.com>
Date:   Wed, 15 Dec 2021 07:41:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [selftests/sgx] f0ff2447b8: kernel-selftests.sgx.make_fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>
References: <20211215153206.GD34913@xsang-OptiPlex-9020>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211215153206.GD34913@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:907:1::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c56c021-48f8-4b12-0f24-08d9bfe159d2
X-MS-TrafficTypeDiagnostic: BN6PR11MB1729:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1729309AC9CFB91952870524F8769@BN6PR11MB1729.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVcL/KOh/QO9vv4fVT+d/n7KGPa3+XK0MqO+LGAjM8g1+8NXpI8bl5C9Njp0BMsdoiLxWhFBpqcX83AJt/nlwHLGHNPDDoV3sN24eJmTVB9wRWefhR1U2PIKtcVImH8iIAuhOuB5L0NDzvrlc8Yc/RlXaX2Ch4aDzCjrfKtq83O2Zm3LSW92Xk/mKnCm0YAmxNOE8AbOcRwM6wk9TawLF1Idfjo0K2hhCp1uRHCAm/xplqXzyFYxHziFf7Op+fzXit9F86s7mIUdWivtuFZbjgnjEKwJ79tiZ/RAz1dEHQErKMLlswjOmQkme0p7mENCi8ZVYoLz220yqefHy1mwkHyIXfik5W25yYXwXqOJKkYZhVo3o8hx8J6V3VHOkoLMm9Xt2dfMXy6Tkvk0rgBUg8IGtdamk3ePek3PRGkiJBeQR9U7TbH6pofK9XmbVddSr6pXd/xasiwRYw9OaQ1ByFwoNydIhhw+OmTSFitX5OYk1uYcNIDLGzdP+FqTxBSANUHrgiO4aaUmwdzFz9VIM5Kyy31cNfvJSrwYA4MIQHf8NMN5i/WHU66AZXNUZ838blvLU1TOJTnjeCqi+1sE6P9O8xBNviiAbSIb0CEzkcK3q92yCfz3fjMone+aHwz6xmooQVfNXG020mqIPMy+ZClapQnTt9YY0jLBp5UHo4jdD44eQ/7At6Vs9zzkXoaSSPlvPEqehCDpeM7GJXVSi+qGz9Stc1tm0sZK2RzNIcTkcBgllAvpvpqp61x/hj/ImRu1iCwfMSIOcOJdT3apbPxRFOZz8W7E0/+B+kH0ovKq7gJbRvxk96jQ6LEkpISV97+PiwF+mWpmrKdo6dTskIY3JdXnZvlE87CfqsA4Scw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(53546011)(6506007)(82960400001)(54906003)(5660300002)(6512007)(38100700002)(508600001)(44832011)(186003)(4326008)(66476007)(83380400001)(316002)(66946007)(26005)(6666004)(2616005)(2906002)(36756003)(4001150100001)(6486002)(31686004)(110136005)(66556008)(86362001)(8676002)(8936002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlrM2tJL3ErT3N2SkloQmhzOXhrSWYvVk5mVC9xaHFXbkdkdEUvMGFXVmph?=
 =?utf-8?B?QURFUHU3ZlRvN2ZRNjBMdmNDL0xNWWptYVJwWkZWZVVJSjNVc2t6b1JZMTdy?=
 =?utf-8?B?dTFFL3FRcnU4eGk1Rzh4NSt2cXhJaCtPNVNkY3dYYjJhbU5URjBQSXpYa1Jl?=
 =?utf-8?B?WWVEamhRQ29WV3UrWXJhSnJUN1RwZGNVazA0YXorSG1vSURzY1JIaUt0aW1a?=
 =?utf-8?B?U2p5SDhIWElPOS9qUHV5WW54Y3h0WnR0ZnZpQmwxOUxzNnMwT0pSeUR2TXBw?=
 =?utf-8?B?eWhwdnJ3UVBaR2FXNjZSVEYzN2JpazltZVpab241amdSSXJDWFZTYnFzcTJ3?=
 =?utf-8?B?QXRrNHdyN3hVbVV2ZFlWYzhoN0dPQmpGeXhtVFhmZjB6a1l0aXBKMTV2cTZl?=
 =?utf-8?B?RWFlN0h1RE1Eam1SZGo4SGxCZS9yZ3lTS24wY1ZIZXZJbXJZYUgyMHBvUW9k?=
 =?utf-8?B?YzBZZXFFU1B5NWphV0dydVRYY2xDcUd3d3J2dTVUUXN3ZnVVUFNZYXdoUFY0?=
 =?utf-8?B?NW45L2wrYWwwYkRkT3RUcGh6ZDVOUTF1ZmJTRHVxVytZcGJqQWhaWXgrZnJZ?=
 =?utf-8?B?QjBtSit4bGo4cUc4SnVVOVlzeEllQU9BSzFOd3VFSkE0ZW8vUExWZG15bC9W?=
 =?utf-8?B?bVJMVzJUcGcwVjIxVGlmU1Y0TWhPQlBncVFhb084ME51RFBKWWkzN05YYk1Y?=
 =?utf-8?B?TEM5aGw5QVduSmtxZmZrc0dwcVFGeVM2RkJMOHB0eWdETWJQeFJObzZaU2hK?=
 =?utf-8?B?NEZCaXdBOVBQdE5GaHVOalNsSlNQdWJLNm1wZkVIZ1FXQUNUVkd3YlY5UHlt?=
 =?utf-8?B?RW5iRnNKczUvR2hBdEpvU1NRakJ0N0wycmlLbEdvV3RNdVlrOFhiTDZjMnFE?=
 =?utf-8?B?VWlsODl2R25xVTJwTnFXVTB6aEhoWjIrS1dSQmtYc216bTZFVWFXVjU3ZE1o?=
 =?utf-8?B?TTMxWW8ydmNIbDdXNGJ1TDZmWUc3cUtiQlk0bjdDQnE0VTRsTnFWVVNnaTJ2?=
 =?utf-8?B?V3Q4cU15TjhSVW5iUU5pUTB4SW9UTTRFbGxiMFhDclpTcWw5T0Z6OWo4VmxK?=
 =?utf-8?B?Z09KekdZdGozV2NRcVMySExHYVNrSDcyRm0wM3A4L0duR1duNTlLZFZDaXJJ?=
 =?utf-8?B?Y2RBdUxLeENGTUtIRDdmTmNnKzlobDhOMW1TL0o3eXhFdEpVTEpXMFNsVUxt?=
 =?utf-8?B?SFNRaDMxaVloc3lVY0J4V2dZTlBWenV6TFdCN0NPb2NDT3RQQ1pRK2pLUnJH?=
 =?utf-8?B?MWxzZEhuMWNYMnZVT2dWbzl1a1NTeERsd1U2bk5mZ1d2NWxtOE5jS1hMTDJr?=
 =?utf-8?B?dXl6REtKWHZJRXhodXQ3Wi9YdDcrRERkc1pIUnJEajFkaElSeWtqcFBsQjBv?=
 =?utf-8?B?Rk1jZDJXQUZJak1QV1EyTUtjV2FROVViTG94L0lvREh6TXkzR0x3NHpUZnVY?=
 =?utf-8?B?TXFwR0c2blUveGxGekdNRktrQ1dFQTNIUERmY0xGVUhtRkJpKzNTaFJVL0p3?=
 =?utf-8?B?NDZvcGhONVF5enJ5K3h3V0RmbEYwaVBGSGpsTGFXeTh5dFNUZzZwT3BLT2JT?=
 =?utf-8?B?VlBzQmEwZ3lsL04vMm55Z2JKTEJpWStsNTdWM0trOW5wMG9kU2ltc051TFQz?=
 =?utf-8?B?cURDMVhJV2FLNG1VRU56ZlNwQWp3Z0Rzc3kyRVNqejhkZ0lmZDcrL2w4TjRo?=
 =?utf-8?B?UGVKaVV3NHozZmFEUHR1OFUrTi9iaDlLRXBSL2J0WXNwWmdqR0ozczI2V09D?=
 =?utf-8?B?S0VjUUdpQWVJU045eE5sS1VyMFZCU29XNkN6TktNeUNUT2xXMzVLR0dncDdI?=
 =?utf-8?B?SjhFamw0VXh4MUViYnd4ZHJnRDFFRnIwY1Jsakh1MHpmUGxCQ0FzMC95UXM0?=
 =?utf-8?B?RFZ5Z2wyYVZ6WnM2WkI5MjllN3hnRGVpQWxTOXpRViswS1NNZWxjWVp0ZE11?=
 =?utf-8?B?ek5BenJCdzlRK09Eek5pNm5kTWtmUzhaNXl4aFNXbHcranZXWTliQmdBc0di?=
 =?utf-8?B?eHdZdzJsYkhpTXhFdDdUeG5FVnEzWmVBTnlGZ1VCRDh1ZEhHTFpaaUw2N3Rv?=
 =?utf-8?B?LzFsaHllaDlJUUJBbXBHc2VlZXdVNm93dU8rMkpZQ3IydkdtUHh2Y1V4SDlI?=
 =?utf-8?B?Ny8rc0hkZzg0WXVaaUJyZTVJV3ZCckUxTzFMaml5NHpYZlNLd1N5Y2xPWXJM?=
 =?utf-8?B?K3UyK2Y2YTFINUVkMXBKTERUQlMzOTYxNjZuNlErVUhweXJSdUZtVDlxRmVo?=
 =?utf-8?Q?li2TkcHmYhpKR1J6KX1GfWm8HuyXIYjqSbQ+pCc0GI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c56c021-48f8-4b12-0f24-08d9bfe159d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:41:25.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6mzukJfXMrmgB5OJU9fkE//hNvlSQ3Prb1OMNurZoVli9fgUQKrULAoHrJcsOvjNb/dcoxJ9ozvjUfFQA/J0cOINeq3340WO1Eo6PaWkVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1729
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 12/15/2021 7:32 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: f0ff2447b8613b883f41ae845b6cc7540d6e5f71 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/sgx
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-99d09ee9-1_20211206
> with following parameters:
> 
> 	group: sgx
> 	ucode: 0xde
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71
> 2021-12-11 16:33:38 ln -sf /usr/bin/clang
> 2021-12-11 16:33:38 ln -sf /usr/bin/llc
> 2021-12-11 16:33:39 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
> 2021-12-11 16:33:39 make -C sgx
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx'
> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx/main.o
> main.c: In function ‘get_total_epc_mem’:
> main.c:275:3: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
>     __cpuid(&eax, &ebx, &ecx, &edx);
>     ^~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:33: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx/main.o] Error 1
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx'
> 2021-12-11 16:33:39 make run_tests -C sgx
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx'
> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx/main.o
> main.c: In function ‘get_total_epc_mem’:
> main.c:275:3: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
>     __cpuid(&eax, &ebx, &ecx, &edx);
>     ^~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:33: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx/main.o] Error 1
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-f0ff2447b8613b883f41ae845b6cc7540d6e5f71/tools/testing/selftests/sgx'
> 

Thank you very much for the report. The fix has already been submitted:
https://lore.kernel.org/linux-sgx/20211204202355.23005-1-jarkko@kernel.org/

Reinette



