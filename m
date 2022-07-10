Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B0D56CFEA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGJQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGJQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:04:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66E5F7D;
        Sun, 10 Jul 2022 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657469095; x=1689005095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GoMmzZ3OTKheb8dwKWSf1QCt7GHroRG9h7Dj3xvPKG0=;
  b=de4ch2usV4FMIMbnBOaKreTYOi0wux2ew2ObTrH7NUU9z4Oy6Ps88Y+Q
   AYjl+l8K5zUn2QbYKHYi/TpA17Z7sIYy19AqjSwpjs6tU2tO1PsK0TW6O
   99Xj2RgrVC/hJk0ZNefXD17aZVacBr6rkbPLS66pa1BreqktUHWoNPb/3
   rIslllt8gFRPQmWg5eQ3vkvaF6EkY9UKrgdi+JpzDMZPFfhBpMnaM8fhU
   OoEMs/1g5X9qaKGwmgGTzj2oFhNs2zV7EPfBVDR4uuZIq2wo9zcMLmDIU
   3zF/fQJCSWDkOqZj1tqLYuEHlREArIWbOVGOC60Ni5vE8HaX4qSxOisCJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="267564033"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="267564033"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="840771995"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2022 09:04:53 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 09:04:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 09:04:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 09:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Fh+BI2ApTKH+pVhEK8AMDhsfC452iUMVEGerbU9hhtbG6YyJI7LhcA5pxpAWeERIQnDe9eRcFuVx60WmyrQy+t94YzYlknHLoErd9VXmPSD1CO8eioYX5KgzSkMweFVzFHJAHZKZja3LKRP3wwgn/61N6PKzuzkHnWm5Xcji8XxLl5ubGbH7ok74U7XBkZHJecgrSkbz4YkMQ7ZTtYIse22h35e3bULBmuPZlq9aMq5fYUHnkD6jVofGrGjhVyqXmMQfs1pD8IwuA/wv40t9bG4+IBM4CKv9Xeg7u8Rsm/KH61oL+3H1q66GFHv5k/QEz/lK2MDQ7ebRqbnvSEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx2wBGES49BQEKai1WdNc9CAC4+IulnInb+OhIkQPd4=;
 b=e4WQ6HlkZ0kmpnQa62u97bUFVjqXNevVkaKvO/+QEoWVRKBKNSuOe3iw/OTHaaTgVfkJSTThw98h+3dNuEgKIAKuGUGRhlr3agkn3rlFQAkylFwaYCbjPwRYgRoyFOZ+kPvNFuPvV7N9QuAsD8M5fHqql0hT6tNZqCVL7aYt5e8hH1sMHxh9VvTTODhIuu52APj1NQ5TooOzP5pE2DLGvjUzFRZTX0OQ4wFtbSJgtCYn3HszuOohj9VJaDszPpf8vvslxcBSUGjPl5aq6huGHmI2uQJj9V1Ssm47IIdJ8reCKqNk3OktLdKiFAMPIVPmoN4sDh34KIcuHSGE7/ZTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM5PR11MB1945.namprd11.prod.outlook.com (2603:10b6:3:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 16:04:50 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f43b:140f:a945:c4a8]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f43b:140f:a945:c4a8%3]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 16:04:50 +0000
Message-ID: <4483d1fe-417f-4279-3460-dca351ee42e2@intel.com>
Date:   Sun, 10 Jul 2022 09:04:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] platform/x86/intel/ifs: Allow non-default names for IFS
 image
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <markgross@kernel.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <ravi.v.shankar@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>
References: <20220708151938.986530-1-jithu.joseph@intel.com>
 <YshNAh6awfPFmxzU@kroah.com> <33a6193e-1084-ae5f-1f80-232274f71bd0@intel.com>
 <Ysqm1BRbCTtWfAcW@kroah.com>
 <79eae42f-50ca-c23c-9fd0-8c356b2d3783@redhat.com>
 <YsrZwc9P34lICS99@kroah.com>
 <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de9fe211-651f-41cc-5240-08da628deb1e
X-MS-TrafficTypeDiagnostic: DM5PR11MB1945:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUC440+biuC5YgXDvqTamr4acnjLxRODtq++qpxce2N4ItvfPQUKNSjeMK9HYC2NG4FcTVTN9t/GV6HNPRRXVqLYZ/g1rhNJAfcF06wHqhFjKuFq+imUBPUcnnN7w0dQWs6erJN0om6L9MIQhDt+U4PfkKjWIVnPqTL6qjSNJPMMUJpA8YW/XjFM8YWrl8BvIChDYxh+WdjI9sRCrbpMcG5P4MBCxnl4/mNYmZbeQb0M08xWNIZL4a+OF2UamjHnB6NCZ8Co13FzOyClFTuyvaArGqI7db+sRUGPkydMjui9PExuPhw1nxAuL/nhs1d/r/qT6We9UfCsxoD/9I0nU6IPsB/oMi1gfPyV9bHBwLGDAKJpUdPVBGlpGckenHF38FG2/ifJ8glF8e5te9IlVQcBtFRoSd5D4aHBZRphqx0PSZXTWS2drPjHrmqsrQwRbaiRWsfO0oUch8wfkdH5C8aCMjQVYd4QOatI3JeAhbwNv408IJL6A1kzpdE7c7XQh8ZA1HWZ3yFQmBvlrkivGnR9WcS30PTjeywRghTFJdAa+h/wKM+B4912Sy6CoKFE33jWjhmS14znCamdcKWN6GUliT/vJzceWc5SWtBKkqVuJ+ehC2d42eZDxT6ikac1Ysxx2QPvTJqB7LoYEOh+26A2uTmVx+gLGo6e2UTfdF+X1ED8GMdSLa+liYLJUntbKI5juSN0PRO4R7A4oElAt1zXRXX5tjShbyYlt2XyyGbkr11ZGYDyuDundDRREJASZI1vZCh3fl7PNUbBT/nxUvkPpH8bNcTKrFJ/dJWQuF474ldAnkBqkazCY/U+skVA3bPj9x8wVWo34HNZD26l4c3OQB1Dx8Z2gdLYpsvFTsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(136003)(39860400002)(6512007)(53546011)(26005)(478600001)(82960400001)(2616005)(31686004)(41300700001)(2906002)(86362001)(8936002)(6506007)(5660300002)(6666004)(186003)(31696002)(83380400001)(38100700002)(316002)(110136005)(66476007)(4326008)(8676002)(66556008)(66946007)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGtqR1RIVmhSMDdMUjMvSG02elR3bnNldUVRVGZZSUVUMVhNd3lkS1MzdVJB?=
 =?utf-8?B?NFJGUExiVTdUdFgrcW8yYUtsbW9UYWxsYUk2SUUybDN5TGozTDB4VU5OREM5?=
 =?utf-8?B?WDlaVkN0a0E0YmJ4WGE1YVRHSXlHeFgwcmlwbjZIK2tIQWQwYkM1cVJxQWNG?=
 =?utf-8?B?UHJLa0MvRytrTE8xenVZSGxCdkdsUVpadlVocU8wUzdudHVHQXdBVEZENEIw?=
 =?utf-8?B?QVRESGIzbmhuclBBN0dXUnJ2T2QyUzQ3Q2FWcExFeVdYalM3YWc0RE5FcUVQ?=
 =?utf-8?B?cDNYb3J5b3J1RHRwWjJuWFozL3JTSWRVWHoyaURRRnVOK3B2Y3crMEg2eFRD?=
 =?utf-8?B?UjV4dlhhc2srUmdJYzl1bUdiTmMzVE9DSkRGZUljckMyaTd5bm1QQWFpYk11?=
 =?utf-8?B?VEtPQ0pqajlETkxHR05rWE9vSUZoMno5QXd0QW5uNVQ0MUQwNmtlazhpWVdZ?=
 =?utf-8?B?NGpmdU1NbHNyNkE2MkRKY3hOaGNCMXowY2NZK083S1pQSld6T2Q3S0hWVk9k?=
 =?utf-8?B?UUpLNTJoWGMvMllZb2NNRUZFM1JlVENCNHFvNDd4NGNiZGZMZGx0d3gwUHY4?=
 =?utf-8?B?UzRFYUxpNnQyRzVNM0FUMFRnYWV1UzFuZ0FQNFArNXdzUXNTZHQ4TzNFblJH?=
 =?utf-8?B?aEZkWG9pVUZDY1FGR3NXYi92UTZlRWtZSEErSTVhQ0pvaE5kSWdObHhtaEh1?=
 =?utf-8?B?TEZKaEg4cFZUUXRCdFV2bzlzN25vMXJ1M2tvY012ZHpiL0xCSVpvQlBGZEZo?=
 =?utf-8?B?bFJGVWd1NEJLbVZ6QkMzaHBkNGUwVDNka0FXenBnczRVU0dKekJaZ3VuUDgr?=
 =?utf-8?B?V2FJWWFVQVJIVytEK3JWWDk1YVFvRDlMSHE5NFFCWEdtdDg5ZUswWmVBYW1P?=
 =?utf-8?B?MThiaGt3bDZJTXZOVFpOQjFkYkRLdWJLZlkrS3UxMXZNMWcrYW5IQUdIWTVl?=
 =?utf-8?B?a0tzZ21nbUVMenVrT0JNQWtmZ05iTkFVZm9yWVVpeTJjdTFoZkdtRmJTMGpw?=
 =?utf-8?B?MWNpSHp5WFhDdjkwam14VG9lZjdXQ2hqWWR2bkVaS3FxWU5NdWtNbWxkUTBM?=
 =?utf-8?B?MGlISjAyblZMMWcrSjRKRE5keXZkN2JwMmJ3TG1uK0FuN3RRU2I3YmU2MHg0?=
 =?utf-8?B?MmdnRVFBTVFwZmVFdWFObUpoRnExblFJdDhJRXhDaFdPVXQxMXhoaFNmMkhq?=
 =?utf-8?B?R1VyVm1WelpJaFRGcURjRGxWKzkzclYxa3V1L2V1d3lMY0Z0NmIwVUd3aVEr?=
 =?utf-8?B?R2tKKzR5MGJ2R3NSckNkZUhYc3lzYkRFa2JNeE9rcm52NHNQQWdGN21CR3Bx?=
 =?utf-8?B?Z1VBT21nS0ZrWUY5citrNldsZnByMHZkMXl0enJja1g0aWpXRzNmcllXNnFJ?=
 =?utf-8?B?QjVXZENFVzAwWG9rUC9LMThTcWY2WnkvVThhNGdINlgwVktFME8wSFFzelk3?=
 =?utf-8?B?Ny9SODRUdW5kSHQ4bzRSejJzQ3RNQ0tEeUlxbmRTZWZWSW8vMWk5T0ZmSGtH?=
 =?utf-8?B?bEVtSWovMzVkRlJHcU4xOWNtOWpZZCthMnFKTDE3dVh1ODFwNUhHQm5FaUxF?=
 =?utf-8?B?KzIvRHZyL1BXWE9meEhMMi9SSHpBQTJRcEZ3WE91L1ZqYmM0cWJadU42UkI5?=
 =?utf-8?B?QmFNaXRDcWJTNzN0UDg0K25jNUZ2dHVSWVZkZWRuNm1JeFhySzNFV1Iwckwy?=
 =?utf-8?B?RVp2dG0zZi9XcVl6UkErb3RGdGMyRzg2NVFieUkxeUZWWklVcW9ZakFQUEpp?=
 =?utf-8?B?Vnl2ajIzVmU3TXlZYW1ReDg1WDRrbklGdnJJc1M2dzg4aUJrREhzVEl1YzN4?=
 =?utf-8?B?T3lET3NZSnhpV3pOZXc0bDNMeXlFS3kwaGVxRi91aSsrWnJkc1ozd2pXam55?=
 =?utf-8?B?ZDZkc2kwcVk3UlYzUWRGM2RpaGp2cTNjOXExaUxzNXVEV1Awc0IxRHJ4eHlv?=
 =?utf-8?B?Q0VzMG41dHpWZTByQmd6cE0wamtOMkwxWGxJVkg2N1pFcFpleTlhVmR4cFNy?=
 =?utf-8?B?TVBhRXdmaldUL2RCalNVbmI2dGEvaWFzbXhkQzlWbmxRU3N1QTluYi9idzBR?=
 =?utf-8?B?aVluZFdPZ0Y5amc2aHY3eUdzYmVKano2STdUV2RGSDd0VVFxd1dvRFZGcFJV?=
 =?utf-8?Q?BwND4skr7R945lXWTDD4oyQom?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de9fe211-651f-41cc-5240-08da628deb1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 16:04:50.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w9ETpY9g+w36lsgQxIxpw3EZc7zscOmc6jM9ltcw9xwMiq12NyUyoOtlQUjKfPQEeU6BnDazq8JqQsia/Y5wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2022 7:08 AM, Hans de Goede wrote:
> Hi Greg,
> 
> On 7/10/22 15:53, Greg KH wrote:
>> On Sun, Jul 10, 2022 at 03:42:29PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 7/10/22 12:15, Greg KH wrote:
>>>> On Fri, Jul 08, 2022 at 11:34:40AM -0700, Joseph, Jithu wrote:
>>>>>
>>>>>
>>>>> On 7/8/2022 8:28 AM, Greg KH wrote:
>>>>>> On Fri, Jul 08, 2022 at 08:19:38AM -0700, Jithu Joseph wrote:
>>>>>>> Existing implementation limits IFS image to be loaded only from

>>>>
>>>> Ick, you are overloading an existing sysfs file to do different things
>>>> based on random stuff.  This is a brand-new api that you are already
>>>> messing with in crazy ways.  Why not just revert the whole thing and
>>>> start over as obviously this was not tested well with real devices.
>>>>
>>>> And what is wrong with a firmware file called '1'?  :)
>>>
>>> Actually the Intel IFS stuff has landed in 5.19-rc# so it is
>>> a bit late(ish) for dropping it now.
>>
>> We can mark it BROKEN right now before -final happens as it seems that
>> the api in 5.19-rc is not correct for its users.
>>
>> Perhaps we should do that now to give people the chance to get it right?
> 
> That is a good idea. I've just send out a patch doing that.
> 
> I plan to submit one last pdx86 fixes pull-req to Linus once rc6 is out
> (prepping it now and want to give the builders some time to build test it).
> 
> I'll include this in this fixes pull-req.
> 

I did send a v2 just now, which removes treating 1 specially. Not sure
if it is too late, but just wanted to give it a shot


Jithu

