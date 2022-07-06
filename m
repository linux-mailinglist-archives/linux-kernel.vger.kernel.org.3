Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A7568832
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiGFMUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGFMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:20:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FE1EC6C;
        Wed,  6 Jul 2022 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657110049; x=1688646049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a40tYHtNaMgPl05KlceNH7JBPsY6eHgPJh9pxVymfmo=;
  b=HCfvGRRKD24Qg1LGkFZje7p8Jfv8bhcOg76KGfEcH8Xc4rDHPkgIW82K
   SaeTNXcJtY+LEice0VM0pjbew9CvK25vCcauot1CzqXTvZNbygTzBeEwM
   IMFR3mJaYvSlV/cwiu/J9CRi/aSGVDM1UQF8huiPOlgD9bHBoAW1/CeXn
   YFR9GKEobHvVNr5+m8F+iJLComzvpuZa8KF3ez1oiwxUI+2PyGCRvoWQC
   vDSIb7agRhc9o5kEMMJ7Rp6tpQVuioCPsaKEBQtdIWKdbdmOOgin9r2fx
   pXicyD2LmYzVEjfkayI7SrVlrfPz/ySLbCnd5leaiAcUI8SaeBpVh8MOQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272518357"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="272518357"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="770028062"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2022 05:20:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 05:20:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 05:20:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 05:20:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csmBgpxkjlGgJjA8grnXaBSyQF01nNRAczZZak3HJ2L3CsrNOV43wcCVZU3xWeO5Jtg+uTXaXzAWzR8+drADVlWE+oc+LAaAQ54ScPdeLgCZphxI7OjYR5sDuZCHdjxMJlWMLSQWd77H1UAgLI3GHREq+wddhWRcCFcodxCYsbgqrhRwcyhmqgxBW22seJd6vQg43wHkA+AE6SujfopeuvjZCoOj0X0MXw/DqAuxNdMZdHJgm58BUDaNcBlhMvb8P5td6u8o4AXsUCk/lm3v8ziHvS8CqRDm3x2FifaqtTI/yQdM8Ia7vPAoSH/tZbeN2EMt6iGfBPUiD3UeZklRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZibYtr3NBX6AA70dPoms8XNnrWDTkOjN6m8iKL426bY=;
 b=MHPqfcN+L6J9VwOHgzOZa0Bpuj8Ht3i9TyA09XYlBAIcygfs2yFtrznzizWYStv3EIrg5x/PG4oGsGIpjRoqkNn6gOi6lZuIgMF2+n02mLXd95+izMhKZe4WsYCkxgq8sXG6O0axtf0GhMsKRhhVE8wNwWhRVP2wwIp1S+ocj74lipJos63lu3xhpagHrsgTugyJh64OZmDakiwCfetGxeRo1ZTZ00G2MkwwjH0Tq8c/RVRQWOmirykXp5mJULBdk2dYA1JOu6z0uqVnpgdriCCD5ALavYeug2ZZa2Xq4UpV/4KibtDa55Xh/Kr7w69MENbcHiErWuWqmCbFO2MQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN6PR1101MB2098.namprd11.prod.outlook.com (2603:10b6:405:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 12:20:32 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 12:20:32 +0000
Message-ID: <3c32390d-6ef6-82b2-7765-1ddad1ab39d0@intel.com>
Date:   Wed, 6 Jul 2022 14:20:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220706115529.7deea289@canb.auug.org.au>
 <YsV7jC2eoEx6G3qH@sirena.org.uk>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <YsV7jC2eoEx6G3qH@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3f074f6-2ddc-42cc-c677-08da5f49ebd9
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMkmEiRL3bMsG5rtAv6hRxBSl735H0CCr2Jm84pj+rpV4TJTPriEySS/weGL/ws7DJj/dD0oXqTFZO5TcKcqDR3w5KZeJ0TaGUwdTLW3S2DsZl1ZSmHm/hsLPH8TnbrlTvsVbZaf/PHKj5LoE7LY3AI8YYiverm5pShas0yN+eH4sR7O5AJh9ayTakY0uhe9d1dk5v5L0Oshg/rcK3jRzmBCKLby5d7VjNAZeB8kjW/t4f3yu813YSfRX9iJVzSW2IHslW3EvUtwtgM0qXOHhwAU0BGCQ0dHC3lpkl6b49STvr0wohRLrmPlrrpJ2JSpojSWAfFSg74amTifSbwHBFwVtec/7nHoGyHz65WnZU7VGjhDOePM5+fVAhPuiMonJvzn4dgn6dVCfMaW6Sx9bWkTAmk1VawROO8pSSuNDF3DRpzk673I4uCw8saeM5R7aOfdxCU75LAbj5kdQ+9Wzj1g3rjrHCMYb5phlg6ViDFfpb1mJPQxkbALNH2HnlDVpeNhwE2VyvJl3TkmL84FlUMDDA6PNgKStLK/4L8mn2auMf+2R3cmLcczDxd47k1NoeDKj1Zzyg0kZa05dIfcBOQrinV7lyv9U7jJEWtdyO3tapSLmqutgC7hoGPS/EBQJtE1k3CxpfdvHEgdx6Ptzrc7abFXq5prTJkjLgFIsqR3xOtE45nGGaqOACe5YqXZ4OsAMqbFy//pv6METjn8wOeL56+BcmNg5kSn5XF9aTvaZ0Q6nr+rFgIZ6M1fAzSnBgw1YGjMEudLn/DU+R4rOG8b0xchL4Trh0UH4IPdyPgxnCdua5kcUebFGBYDEQvzpOCEjx62eIB4ElC7CtopcnNUl9z7nnYHGe0y4LSU1a6DSqQvvATkpb9QlQMsPmzPGvjcOJVzYhq71X92d/tGavsx3nWXUMdQHyXRgOUfRt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(136003)(346002)(41300700001)(6666004)(316002)(6512007)(26005)(186003)(2616005)(54906003)(110136005)(53546011)(6506007)(83380400001)(86362001)(38100700002)(5660300002)(31686004)(2906002)(966005)(6486002)(8936002)(44832011)(478600001)(4744005)(8676002)(4326008)(66556008)(66476007)(66946007)(31696002)(82960400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5sVTQ4SlQxT2FJMElLUHBmTEd4aTc3TVduM0hTYmMzNUJOM21tcGZvYXRx?=
 =?utf-8?B?QXJFNndibW5MaGMvcDZaTDZmc1RtNko4Mlp6NkJvQzZLRStRRXIwaGpPdGxz?=
 =?utf-8?B?MWdoS0hVb3c0SndGRjA4RnJqZUlLYzN1d3JNSmlJcnhmdWZXVDF0RVR5S2ph?=
 =?utf-8?B?azlvM0YzS2dYdXVTR2dLdmlvVS9iQXdrSFhXZVdrdmlzNDZ1ZjVhOXcvOVV4?=
 =?utf-8?B?Unl5SUYvbVFGYTNGTWozUUhtVFNUb01VV2ZoSFo0VktFVStCa3RrYm50MFVx?=
 =?utf-8?B?TVl5YXBPZ0tRMG5zVzVhQlhWeVVKU20xNlJiOU9TS3pheVNLTzRRODNmZGZn?=
 =?utf-8?B?cTFBTFR6UW5vLzhIOGIyVld5eU9qemxkUGcrT1dWR25mUm5sUjBmZEJMbWVN?=
 =?utf-8?B?UHV1a2hmNnJSdjZkbkp1L3plTHk0dXMxdDVSV2s0N0NZQXFneTN4cW42Tnd5?=
 =?utf-8?B?VkZBU0h0KzdOMkNNcWtpZTlTRVFMalpmRUd2ektPdWFyd2tuY2tqRzBNazlS?=
 =?utf-8?B?WE0vcEcvWmdjaUdsTXY4WVNaVmhhdGRERGJrQVdiWXFMdXAraHJQN1BwSDdL?=
 =?utf-8?B?TFhBZlFSaU9TZUlHUEZ3T21VSkRlcjFVdkZoRjFCUTJ0UGNEczV2T1hqc3Q1?=
 =?utf-8?B?dTdoMGYxbm9aMDZDZGJKakRmcFNzVU1HTk95cENJUUVZREVRcS9tWnRWV3dB?=
 =?utf-8?B?a3duakMzOXYyLzRuYndKRkV2c013L0RXaUd6aUFEUzE0bmQxUjRPckUwbngz?=
 =?utf-8?B?RVVWN0JjZ2FuZEtLczk2Rk5jU28wNFNwZEsxT2RJbnNTOC9yWi8yNTR3eWJR?=
 =?utf-8?B?azJvMzhLcENjWlJxZTBkNWF2bEFNV1dyM0IvSlprZkZCUHFBNFIvTHhYOWhr?=
 =?utf-8?B?cFFNaE01Ky84WGFvYzBoc0FHUEZyT0RmMCtQVGxCL2ZvbHA0T0pNWkRDd2FT?=
 =?utf-8?B?alRDcWdBcEQyU292akpHL2FwckxtVUJ4Q1BMQS91ZENMYmNLeWp0Z2xMV0x3?=
 =?utf-8?B?OUhMRnE1S2dDWitUNHBwRHZvMEYwWk80L2t2cm04VHVNZmpMT1VYSHpnSHk1?=
 =?utf-8?B?WjJlbzcxQlgvenJyTFdZdDE2Nm9WYVNXMzJ1N0tQMEdnU21BOGRidlkzRG05?=
 =?utf-8?B?VXVESXk5bUpPOVN4T0xGU0JiYXFIaTllU2VRbkxpd3pqY0Y1UEpScU9udnNv?=
 =?utf-8?B?Wjk5QzJld3BFSDhIb3NwQ2MzZGMvQ2lyQ2Z4WUM1dHgzKzZ2cE9FeU1pbVA2?=
 =?utf-8?B?S0YzY3UxbzMvb2xQWUpIaElKZU93SWp6b1FQZlpBNlNENGhodVRmRktXN2FJ?=
 =?utf-8?B?elZlMDNrdkZRSEVwbGJRUHRtd3lnSVhHRWM4Q3RqVjIvNDVKbTJCUVhzNlBE?=
 =?utf-8?B?RUR5cXhqdFRPT3MxSVFLRHRxSWdmS2xEckVNUTdqMVhsQ3Erd1BwTWZMWFZP?=
 =?utf-8?B?T3gyZHF4KzJ0QVhJMml6Y1J4Q1kyRTRsenQ1SVYvQ0VBclUvYWRNR2ZsNnAx?=
 =?utf-8?B?TXpJb2ZwSFVGNVcwZTFpOTdTa2p1WWg0a2RnSEc1aHEycEJsWmNERjgxYjlO?=
 =?utf-8?B?KzFTRVJleWh6cjBVY3RLYzJkelpJcnJSZksxdVlTMUtDQWg5OFpXbm5uTmtz?=
 =?utf-8?B?MjhLVisxUmdEd0NxMGlqRVMyeTM5VUN2MVhDdlZybW0zbzMwbmE0d0RVU0du?=
 =?utf-8?B?V0hmeFB4Q3JXRlZZYk1ZRGFVY0JXMlVnZXNGdVk1ZGtVVFlOSHlpTjdiVnhw?=
 =?utf-8?B?V29YT2JqRUZ4ZXhVaU9PNmtpeHNWZFdDd0lodGNNUTk5eFJSQjloVFVOenlj?=
 =?utf-8?B?VU4vNnphd1BwQTF2THNzU3NDVFljMWpMQkJxUTN4Rk9lVzhFaC9lU1ZQamE4?=
 =?utf-8?B?bWZ5SzY0cFY2RlAwNzZ4MnVXWlR5cTFISFk2OEsraG1sU0NYNk9DNU5ac1Vz?=
 =?utf-8?B?ek5iNk5nMkhhYWhWazFEbDN3UzFweWo3SkNUNmV5SnV5UU5ORUZhZVZ2V0xH?=
 =?utf-8?B?SEVEQ05jZnRjMlN4L2d6WnduWHA2YmtZU3JUWS9VRVd0d2IvTEF1Q0Q2MDRM?=
 =?utf-8?B?aWxYdjdHaFBjRURGWW5MMjdQeFV5VnJqcHlYR3ozM0VuNStvdi9QZUE5Qkpa?=
 =?utf-8?B?L2M0WDlCYjhUR0pRcW1Hd0FsbnFVQWJXZXdwZVNQMGFoZzNHeXNyVCtkaHJ6?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f074f6-2ddc-42cc-c677-08da5f49ebd9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 12:20:32.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVxE8KfWVHDxumzhhFQmvDUCwxgcNgr7F5K4hX9qQtRlwUUdqBTAw3F6K1wrYX4LiBvq5lifRvSyYZ7x9Vw/lt+xufIo8YqWBNsPSPxKTwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-06 2:09 PM, Mark Brown wrote:
> On Wed, Jul 06, 2022 at 11:55:29AM +1000, Stephen Rothwell wrote:
> 
>> After merging the sound-asoc tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
> 
> Which toolchain do you use?  I've been using GCC 10 since it seems to be
> what Linus is using, anything else I try has tended to get spurious
> failures in from his tree.


Issue has been revealed by the yesterday's fix [1] - there was a 
spelling error on my side in the most recent (and integrated) version of 
i2s_test machine driver. As my CI was 1-rebase behind the schedule, we 
did not notice.

As mentioned by Amadeo, fix has already been provided [2]. Sorry for any 
trouble caused by that issue.


[1]: 
https://lore.kernel.org/alsa-devel/20220705103238.7484-1-lukas.bulwahn@gmail.com/
[2]: 
https://lore.kernel.org/alsa-devel/20220706062952.251704-1-cezary.rojewski@intel.com/T/#u


Regards,
Czarek

