Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF35A9C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiIAQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIAQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:02:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3C7E339
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662048125; x=1693584125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kV1q/nNcwWvxjGpKRrrBy2KdO1T8/pUMUGibv0S0e5E=;
  b=hKx2LfEk32qlaF4Sn+lMjv00hS5LbFHm1NNU8m/5xMypXfe4BT50xQNn
   +Fo3UpM1YLy328K+91payK7XSP6e1SW81P/MU9QPDBpbuHEt33cmsDbNT
   OFWt/i0C4yyTjtseZpj9JaH6LJ4/deA2v9+wijQXL8GHJFu2ELrPkeRiu
   00Dv5mkvnPP8jzOYbyFhS0EBLKkY4dw/2ifv/kXuqBiTVFUDqbdTss+cA
   Ysin7D2KQA6h0CcThx4m4aQ5TK7npDTffQwZr5SRnld80jf+blYqkUalj
   NzGDC0urJARJk2a6nMlB1O2wd25NqJU8qXjR1vgIkPHvrpfy1uAIMf3er
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282737906"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282737906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 09:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="701788363"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2022 09:00:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:00:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 09:00:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 09:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCbKlnht20b0EvC1LZSawQlv3cWjEvduW6uEX43Ot1s0hu5GfcnLyQApJ2iNxEIXzglrOxxb3SDihov0clcJ13b77ZGpHEyxXGTTWc4/1M4MR00ldXjAEYseeujKrN9ujM20+6irEEbbadtlspn3oOOF85bnoXFiI9ubg9U6MphSEqb/dzuxSNDaXrgSXM+bFk9Yp+NJwd2prcduHbfkPK+ltUyHaXYAv93ocxt+mCQTbDnuZ6tmoBaMBc4NQoA3uT72973pahWq+hpTM5MNEI3SY6ifidKMyptJhoX4VuAI1XeYS+W3vDRpXbtwFJ+lFF9MblnaVXUM364FGfjfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/cjRvFFjVafA6Y8wOxEvIKFeWlDL4tGmae4Dvb8fX8=;
 b=j+2KAcqd1iYt557zTRBiokGsDzeGGJZPw1LCK56DDJYjoG6PZJ9+jPp4xlkQD+dqIYU9RJhvPWHYtvezOcibEk58VNKZ24C8Z5J4OZZaRqLNRqLJjFK33GHD5Nh6MzaTVRF6mnwA+L15S2Ku5hPrteiqiP4mP0DOnyS40y27am/pQqdx8PyZh1jMnrZ0GtosQYOs5b9918iI2XqDvl+vzCyhcLGseUxhszxW7BOF7UxaCP/jtqYor4TQujXQugg0J6OcB/fqEkoYARdfL+3sU3ikX1J+pz6N8/jpBXB+w34LTPcRY8eeKJH9MI4Jfu5r/QMmMo9y1C/gOdp3VOAlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 MN0PR11MB6087.namprd11.prod.outlook.com (2603:10b6:208:3cd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Thu, 1 Sep 2022 16:00:57 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 16:00:57 +0000
Message-ID: <3c62fec1-9df0-fe5b-484a-a1da533a25a1@intel.com>
Date:   Thu, 1 Sep 2022 09:00:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v7 06/15] mei: gsc: use polling instead of
 interrupts
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-7-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-7-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba1451b9-6fa6-4f1f-405d-08da8c33282c
X-MS-TrafficTypeDiagnostic: MN0PR11MB6087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2JfuIjQTMKxSXbVH8DqpMQCxTsOmpnBpc9idOil3wKfzBUNZygfAeSmwnA19vTkrLHj+6HQU2AYk0SYFjzpy8CLCYvPnVHRi4qRYXRxF2eMyGMjHadRQCxdMTou1fTD+ZlSr+JFf/3FmQoS32YoFpb+pZWEEv/jX8ugPDgbdDC2sT6uNmZ0xlAI/+BjvHPJNeP8XDtGI0dRd7WiK8pKzWz4FlmOTuWDShn8pPaNV502AGFfpEhriKcUZXFobixzFihON87WpVe38PFlqn7AA0LZVTBzimFNS1frWhK+Pr9r09Mj1WZREgYGKEScfonh+XEeyaTODs1edMgjIRDJ4BopLGyJ6kHYHDT1AD0fw9cv7EBxg3jlDcpqDhr9Pg5nUjHSQOWVwhD6LEUPGXHfrbmEXuwaETmdOiHLYr5+JODHUCb7iCfVbY8Tx/9corHuuGbdKk9uNSwoGDGx2GX7iPNruiAV4WZOdZWiRlMbXfQKgVQsJJnDp95CicOYdcId/h61mz4VEDne9GYi7erL61KyeFiK5txp/l3Azk61lPYdUSSafWv4OZVK8Lyk2wIkuYN15ynr8H6Te00OAZUwE3T3k04RU8oPfwwRYgip8lq5c34C6+flhSi1a4swA6phJza6Ph7/PDqE7Pi/Q4eyedaiA/KxLuD0B4lJLcjKhE3uFoZGRYL7gc/ok28j0aEqkUc0CK3VWArtpuudSdXciNPnlfHWTac27kXyfqezfxpJbWgvS0rs70rt+ogFsDtOUuZMjCs+dHnMA2rN6v+53JoNzIcr7lc5JLzfQvyOuc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(376002)(39860400002)(66556008)(6666004)(66476007)(82960400001)(316002)(38100700002)(31696002)(2906002)(6506007)(8936002)(110136005)(6512007)(36756003)(66946007)(53546011)(86362001)(54906003)(41300700001)(4326008)(478600001)(186003)(8676002)(107886003)(26005)(5660300002)(6486002)(83380400001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDFpaVZGSitWVW5mQmsyWEVhRm9wMitQS0ZqWFRDNlZFM3lHbVVzb3ZOUFlv?=
 =?utf-8?B?Y2VaRnU5OXk1cko3N3hmbVhxaE1XQ3RrVHZUZnl4bW5Sb3pnUnNiZ0ZLS1pG?=
 =?utf-8?B?L1hZd0owNXI3dTR2bWJiS210QTVMQ3grTFgza2ZYOVNVM0l0eUlsdWl2T3Zw?=
 =?utf-8?B?V1lCWVdxTGRSVjFGNjZaTC90Uk1hV0Y3eGJYeGhyTnlqQ0cyb3Q3QU1RVzBG?=
 =?utf-8?B?OXM0MzBScEtYM1JzRy9CR3dBMm1sVjI5U25SbzV3NnlHV0dKN2hZandzV0c4?=
 =?utf-8?B?QW14NkEyQ3Fib0lWbEcwWWVyL2NpUWZFcWpkTG5RbzkzdkJBQStaL1lGREdO?=
 =?utf-8?B?SG5TNmVHYXZucjc3T1J0dm9tbDNsK1BHd1JxVVlpcm42bEFyUmFiVUhOd090?=
 =?utf-8?B?b3hFVkdLSDhjV0J1aDRkZ1FVQUpFdWZORW15Q0RZeEZpelJEUEUxQ3R0dmRY?=
 =?utf-8?B?NHFpVmhndnlpZ05CZmxKa1hucXNyWkFXOVF3SHc5V2gwL3ErM2t3OUd2TXgr?=
 =?utf-8?B?OGV0TnpkWlBURHZXdkJoYWU4T20ydmd0SlhaZVNIWXBjbit6T0hiVG90L3hS?=
 =?utf-8?B?L253MlB4SUVnVm1mS2NGTkZyYWVWRWRpUVRtb2pKQzRzWHdkMlBEeTlKQnQv?=
 =?utf-8?B?dkQyb01hY0JlSlRKNmhDQ2pvSnlKdlhVNjM2Z3FkMmpiUUJvZzJ0YXE0elhR?=
 =?utf-8?B?c3VRTG5jZzNKQVFub1U5WkVoMUp0NHFTZ1owTGpBMm9SMWpvcjFyY05DMXN6?=
 =?utf-8?B?TVdOQzZkTVNsd3JQU1drUC9kU3ZQSlpBSjZJSFVyOG5vR0FYMG8xb3Nucm9G?=
 =?utf-8?B?ZDhRSk0yOXdZVTI4cVh4SmdTVVQrM05jb01Kd1Y0V0hERmpEUnpSbjNxL1dL?=
 =?utf-8?B?aTRKY09lazBPcFJ3aGRrVjB6TXNIclBvUmN1eDRaMlRYWmJsNEUveGJRQjM2?=
 =?utf-8?B?QnRMU1pTSXNWWU5kcHd3TzRwTXR5NUpCVXE1LzN2NWg1Nm1VZXc3cWhRWitO?=
 =?utf-8?B?ajdvc1JxUXVRSzhCcTZGMlhhQmpKYWs3dURqR0V4MHBXeUJjUGJMQ1ArTFdh?=
 =?utf-8?B?Q1lOS3dBOERUQ2FjdHJ0RFJkNE5LK0g1OUJ6elBmb3Ird1paUGo0TDdZOEg3?=
 =?utf-8?B?RjlKMkQrK0JhNTNsOVZCQTBXdlh3aldWYmpEOUt6SFMzekIvZmF2dFRleDZa?=
 =?utf-8?B?bmdocGJLMWovRm43UkhBTWlHbkFMUlVWakFhV0lLQmU1cVJNWXlVTTNJOWt5?=
 =?utf-8?B?U0lxM1hRUXp4cEhCcmdqaWRMQlI0VkQ0T2grRmhsZFRyeUNNbFIwRGJkSkNk?=
 =?utf-8?B?dXhwWHFjRmxrQnMxUWw4VzJOL2NwdytKYU1YYTBiN0JNRDRUd1RsNEw0dkkv?=
 =?utf-8?B?R2NVUVJSZFFHNUVhVll6WWpDNE82Tmw1ekQyTDREV3NMTHJ2YW96MGxHVCtp?=
 =?utf-8?B?c1ZBZDlFMWs0aFUyZjZzMzNCVnRzaGh5WFprSHpsT21FRHVaaFdoNEtLQXFV?=
 =?utf-8?B?ek1CcW5DUk42dlZpZFJhMWkyVVRCd1FXYVBkdnF2M3NvQmt1aGRtWVNka2VV?=
 =?utf-8?B?UGltYUsxQTd0Z3RtcDY3a1NkdnVMMFFDdmh5OWxXeEFaMzc3RzJ4TDNUUFZp?=
 =?utf-8?B?WHVQWTRlNXBuTG9YM3RxN2hVM3EzNFZGVlE1aVBoa1VGQ01iNy85R2dXU1lm?=
 =?utf-8?B?ODVFRjZlVjFVbEJDWlg5eTl2Z3NJbjBXVTdjanh0L2grc1dLdVBQU3B5aytK?=
 =?utf-8?B?K2ZHS1JiUjlHZC95enQ3ZElpbXdnUXpSbHJwY3hERTMwdjUzbU1JcEVpMk8z?=
 =?utf-8?B?b0YveHU3U1JqQUJpb1M0bWxocG5OT3BiMzRrUFpCbVZ3U3ZuNnlHdzZoL0VT?=
 =?utf-8?B?Nkp0WWtMT1duZkxsSWFOUWRmSUFKTVRYdkdRQWhCWDIvS1Q3MWxPRmNGUzI0?=
 =?utf-8?B?bmF0K25nVGRIbG5mQWZ0NVo5ZDFwSHk0b05UUjhWRm41UDd1Q1NZbTdHeW1m?=
 =?utf-8?B?MHh0dmxtTWJ0Y3duVWwrNWdSQ2EzWWFOS1lja09XdmRjWGpZMDF2SEMrZDkx?=
 =?utf-8?B?SUpKRWsvYzRaYlZmUTQwNmdwWXVsU0FLekxpVHR0SUxYRUsrMGxKNFB5aFk1?=
 =?utf-8?B?V2VaZFhHMXNrTFNNZWpkUHNEUGpET0laTDZrNjRyWkRYQzlPV0F5M3dSVmE5?=
 =?utf-8?Q?Cb4qUuPmHIPzQ7m4vN6tf3w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1451b9-6fa6-4f1f-405d-08da8c33282c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:00:57.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlTHZb9oh0D8StcoWLW1LeUUzZjbZdUpEDJi4pUt16f1rJY0j6dryrCBZqkHJnaMpADH/Eaim6uVgghfuJLPcC65SPugha5jBVLyw0AqAtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6087
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> A work-around for a HW issue in XEHPSDV that manifests itself when SW reads
> a gsc register when gsc is sending an interrupt. The work-around is
> to disable interrupts and to use polling instead.
>
> Cc: James Ausmus <james.ausmus@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/misc/mei/gsc-me.c | 48 ++++++++++++++++++++++++++------
>   drivers/misc/mei/hw-me.c  | 58 ++++++++++++++++++++++++++++++++++++---
>   drivers/misc/mei/hw-me.h  | 12 ++++++++
>   3 files changed, 105 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index c8145e9b62b6..2caba3a9ac35 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -13,6 +13,7 @@
>   #include <linux/ktime.h>
>   #include <linux/delay.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/kthread.h>
>   
>   #include "mei_dev.h"
>   #include "hw-me.h"
> @@ -66,13 +67,28 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   
>   	dev_set_drvdata(device, dev);
>   
> -	ret = devm_request_threaded_irq(device, hw->irq,
> -					mei_me_irq_quick_handler,
> -					mei_me_irq_thread_handler,
> -					IRQF_ONESHOT, KBUILD_MODNAME, dev);
> -	if (ret) {
> -		dev_err(device, "irq register failed %d\n", ret);
> -		goto err;
> +	/* use polling */
> +	if (mei_me_hw_use_polling(hw)) {
> +		mei_disable_interrupts(dev);
> +		mei_clear_interrupts(dev);
> +		init_waitqueue_head(&hw->wait_active);
> +		hw->is_active = true; /* start in active mode for initialization */
> +		hw->polling_thread = kthread_run(mei_me_polling_thread, dev,
> +						 "kmegscirqd/%s", dev_name(device));
> +		if (IS_ERR(hw->polling_thread)) {
> +			ret = PTR_ERR(hw->polling_thread);
> +			dev_err(device, "unable to create kernel thread: %d\n", ret);
> +			goto err;
> +		}
> +	} else {
> +		ret = devm_request_threaded_irq(device, hw->irq,
> +						mei_me_irq_quick_handler,
> +						mei_me_irq_thread_handler,
> +						IRQF_ONESHOT, KBUILD_MODNAME, dev);
> +		if (ret) {
> +			dev_err(device, "irq register failed %d\n", ret);
> +			goto err;
> +		}
>   	}
>   
>   	pm_runtime_get_noresume(device);
> @@ -98,7 +114,8 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   
>   register_err:
>   	mei_stop(dev);
> -	devm_free_irq(device, hw->irq, dev);
> +	if (!mei_me_hw_use_polling(hw))
> +		devm_free_irq(device, hw->irq, dev);
>   
>   err:
>   	dev_err(device, "probe failed: %d\n", ret);
> @@ -119,12 +136,17 @@ static void mei_gsc_remove(struct auxiliary_device *aux_dev)
>   
>   	mei_stop(dev);
>   
> +	hw = to_me_hw(dev);
> +	if (mei_me_hw_use_polling(hw))
> +		kthread_stop(hw->polling_thread);
> +
>   	mei_deregister(dev);
>   
>   	pm_runtime_disable(&aux_dev->dev);
>   
>   	mei_disable_interrupts(dev);
> -	devm_free_irq(&aux_dev->dev, hw->irq, dev);
> +	if (!mei_me_hw_use_polling(hw))
> +		devm_free_irq(&aux_dev->dev, hw->irq, dev);
>   }
>   
>   static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
> @@ -185,6 +207,9 @@ static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device *device)
>   	if (mei_write_is_idle(dev)) {
>   		hw = to_me_hw(dev);
>   		hw->pg_state = MEI_PG_ON;
> +
> +		if (mei_me_hw_use_polling(hw))
> +			hw->is_active = false;
>   		ret = 0;
>   	} else {
>   		ret = -EAGAIN;
> @@ -209,6 +234,11 @@ static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
>   	hw = to_me_hw(dev);
>   	hw->pg_state = MEI_PG_OFF;
>   
> +	if (mei_me_hw_use_polling(hw)) {
> +		hw->is_active = true;
> +		wake_up(&hw->wait_active);
> +	}
> +
>   	mutex_unlock(&dev->device_lock);
>   
>   	irq_ret = mei_me_irq_thread_handler(1, dev);
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index befa491e3344..46559517a902 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -10,6 +10,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/sizes.h>
> +#include <linux/delay.h>
>   
>   #include "mei_dev.h"
>   #include "hbm.h"
> @@ -327,9 +328,12 @@ static void mei_me_intr_clear(struct mei_device *dev)
>    */
>   static void mei_me_intr_enable(struct mei_device *dev)
>   {
> -	u32 hcsr = mei_hcsr_read(dev);
> +	u32 hcsr;
> +
> +	if (mei_me_hw_use_polling(to_me_hw(dev)))
> +		return;
>   
> -	hcsr |= H_CSR_IE_MASK;
> +	hcsr = mei_hcsr_read(dev) | H_CSR_IE_MASK;
>   	mei_hcsr_set(dev, hcsr);
>   }
>   
> @@ -354,6 +358,9 @@ static void mei_me_synchronize_irq(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
>   
> +	if (mei_me_hw_use_polling(hw))
> +		return;
> +
>   	synchronize_irq(hw->irq);
>   }
>   
> @@ -380,7 +387,10 @@ static void mei_me_host_set_ready(struct mei_device *dev)
>   {
>   	u32 hcsr = mei_hcsr_read(dev);
>   
> -	hcsr |= H_CSR_IE_MASK | H_IG | H_RDY;
> +	if (!mei_me_hw_use_polling(to_me_hw(dev)))
> +		hcsr |= H_CSR_IE_MASK;
> +
> +	hcsr |=  H_IG | H_RDY;
>   	mei_hcsr_set(dev, hcsr);
>   }
>   
> @@ -1176,7 +1186,7 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
>   
>   	hcsr |= H_RST | H_IG | H_CSR_IS_MASK;
>   
> -	if (!intr_enable)
> +	if (!intr_enable || mei_me_hw_use_polling(to_me_hw(dev)))
>   		hcsr &= ~H_CSR_IE_MASK;
>   
>   	dev->recvd_hw_ready = false;
> @@ -1331,6 +1341,46 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
>   }
>   EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
>   
> +#define MEI_POLLING_TIMEOUT_ACTIVE 100
> +#define MEI_POLLING_TIMEOUT_IDLE   500
> +
> +int mei_me_polling_thread(void *_dev)
> +{
> +	struct mei_device *dev = _dev;
> +	irqreturn_t irq_ret;
> +	long polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
> +
> +	dev_dbg(dev->dev, "kernel thread is running\n");
> +	while (!kthread_should_stop()) {
> +		struct mei_me_hw *hw = to_me_hw(dev);
> +		u32 hcsr;
> +
> +		wait_event_timeout(hw->wait_active,
> +				   hw->is_active || kthread_should_stop(),
> +				   msecs_to_jiffies(MEI_POLLING_TIMEOUT_IDLE));
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		hcsr = mei_hcsr_read(dev);
> +		if (me_intr_src(hcsr)) {
> +			polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
> +			irq_ret = mei_me_irq_thread_handler(1, dev);
> +			if (irq_ret != IRQ_HANDLED)
> +				dev_err(dev->dev, "irq_ret %d\n", irq_ret);
> +		} else {
> +			polling_timeout = clamp_val(polling_timeout + MEI_POLLING_TIMEOUT_ACTIVE,
> +						    MEI_POLLING_TIMEOUT_ACTIVE,
> +						    MEI_POLLING_TIMEOUT_IDLE);
> +		}
> +
> +		schedule_timeout_interruptible(msecs_to_jiffies(polling_timeout));
> +	}

IMO this loop could have used a couple of comments to make it easier to 
understand what's going on with the various waits and timeouts. Not a 
blocker.

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mei_me_polling_thread);
> +
>   static const struct mei_hw_ops mei_me_hw_ops = {
>   
>   	.trc_status = mei_me_trc_status,
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index a071c645e905..ca09274ac299 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -51,6 +51,8 @@ struct mei_cfg {
>    * @d0i3_supported: di03 support
>    * @hbuf_depth: depth of hardware host/write buffer in slots
>    * @read_fws: read FW status register handler
> + * @wait_active: the polling thread activity wait queue
> + * @is_active: the device is active
>    */
>   struct mei_me_hw {
>   	const struct mei_cfg *cfg;
> @@ -60,10 +62,19 @@ struct mei_me_hw {
>   	bool d0i3_supported;
>   	u8 hbuf_depth;
>   	int (*read_fws)(const struct mei_device *dev, int where, u32 *val);
> +	/* polling */
> +	struct task_struct *polling_thread;
> +	wait_queue_head_t wait_active;
> +	bool is_active;
>   };
>   
>   #define to_me_hw(dev) (struct mei_me_hw *)((dev)->hw)
>   
> +static inline bool mei_me_hw_use_polling(const struct mei_me_hw *hw)
> +{
> +	return hw->irq < 0;
> +}
> +
>   /**
>    * enum mei_cfg_idx - indices to platform specific configurations.
>    *
> @@ -127,5 +138,6 @@ int mei_me_pg_exit_sync(struct mei_device *dev);
>   
>   irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id);
>   irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id);
> +int mei_me_polling_thread(void *_dev);
>   
>   #endif /* _MEI_INTERFACE_H_ */

