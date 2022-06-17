Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C154F75E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382092AbiFQMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381721AbiFQMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:18:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975548311
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655468328; x=1687004328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UPN+XZqMruRI2qkzBDBXCwoO88HI41NU8PWXn4+Ew/o=;
  b=VaPxIPvRzDQRB6n9Sl4EKQvZqQtKIadpEKwdbiJRv2oZ2pMgX8J/VKtZ
   nsUXfN/MUmPlPvRVmN0RlPVgv1A7SaCOHXdp+FCsUoXSbQCHZzn/1qNBT
   P1GgG+jdBxnQZybj+YCkZxKmzez1HZea0BbWkWOoyoAs7DelT3yAMmX/l
   GZoezywacAqyxm76pTtJ6+s7wS/IzrfoKX19cC/wl71/YVowqE5KlYPRK
   HO0xA60IEjeUbgI1mrfS22Eysx13Xy1V3+NeVUYm95dNX3EyOhI33dwsP
   53hE+defpi7LlGWmvC24EbBF4rsEaqKEpl50PdgLsN2Pyjpz9vkOIedjP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280533622"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280533622"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 05:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619247561"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2022 05:18:48 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 05:18:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 05:18:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 05:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4Qd6LzBycBPVx8F5AL/ieOcTGNgBQtYvka+OFlqE6XYETWHzOvUdQG9cUVRGwX5NFarGwICKLaY2ELx9lS2FlSSEeURsvwc5aB8s3vlebSF3AA6mXdPwRdzwv5Tkgf9JNmXEcwQAkBsRJn23iPfSVnnB1uWxnvMHlm844E6v8bVrZ2Up9nTSXNuDjKk11n/4Vm2QvawXTu+8rycmKjfSck5FbV3dgbWTITrzda83olYPICQW3rpBGZN8IUTbF9OIaqaRbegP6K+uP4/26/ldBjHLe0wQzBofjJTVN5twRoUeiaYKxzw8u3digoQEUP/P35+yfczoh2VB90tjqQQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPN+XZqMruRI2qkzBDBXCwoO88HI41NU8PWXn4+Ew/o=;
 b=VdLVC7Ajvd+EMxGHuIFN1Qo3TLdM9GqWyFI2Wy323Uiq9sKtgIuHdI/J12NcWV2WksN9bWGoDDuQX0VWO4eATqG+gkPdV2eGY/lMSc4+2sgAsCWFuw426SuaSCp2OQDLdHUY19K7d1CnxRslq10HhgHy2g3ZpI/pMAqaWGcNb20eyYdANM2aa0qT4yd+hPBwNkr8KYZE066EmAdwc50M8XxLBQ6i6gAAxzFVyQ8Irv9Ne929eEtdMUoObh5LUCWprHJy71p4mn30VsPJm00NSggI9Ghnl90wEifhFkAuu9yS/1aD50O7hrEmOduUP5SCSI9eMXXgK52ZrPrO8Nnu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM4PR11MB6384.namprd11.prod.outlook.com (2603:10b6:8:8a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Fri, 17 Jun 2022 12:18:46 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::a879:23a2:1836:2691]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::a879:23a2:1836:2691%6]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 12:18:45 +0000
Message-ID: <15c3d3d7-6f15-adb9-f809-446f4b568fdd@intel.com>
Date:   Fri, 17 Jun 2022 14:18:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 01/11] ASoC: Intel: catpt: use pm_runtime_resume_and_get()
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.de>, <broonie@kernel.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Lianjie Zhang <zhanglianjie@uniontech.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
 <20220616220427.136036-2-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220616220427.136036-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::18) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524f5389-12af-4271-f3f1-08da505b869d
X-MS-TrafficTypeDiagnostic: DM4PR11MB6384:EE_
X-Microsoft-Antispam-PRVS: <DM4PR11MB6384B98CD3E6A33F4314A7D5E3AF9@DM4PR11MB6384.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vu3koafl6MvZCaTfGIRzCFHGc8dWl2HM7WxRqLlTu7ZqyWXZBSEfYmLzh/EZ3fFU2LNrcL/SYAbvxWQd89T3V/C0gaXmYTyAyB3d1joAoMj7c2ZT1mfpDev5R4bpt1w66StFYOu6PEyMfwRzgaHkT6udbjcjL/V8i47zhNxEenqz6pIXZSdk/PCP2c7+OBGk5W1ka8i/6pAFYAAB+80n3O1gMsvhE2YmEhfLtzY8uWyx7uQ3LiDWj+I0yVfUfD2Lsn1+FbDE+cB/OZ4PVS+2KSa38nHGh0h3Ru/HJ+QWqlLAtvd4tYgJ8pI9am9Civwqd3vTkhZimKvRXXYBUozuCYWPepxE38jWHXXfyuvIyGI06b5r1JDysVghZk4wMVsns6V0dBpIgB5uQuzdFeL8U9THobXgDEb+V5LlF26fjDSj2LUPQ/MWCOykOsSxAWcd0gUVUEQipn5gaGPdzToCL8CzfVjiUA5L49GpW1hWKqSbFTozOWh/62hegGGrinttfNo4Nr5rWRBzL4YlfAty9pVa0+iyH1DikEl6pz4ueZxx3jGyWd7OgOZR+bGeahwXaDlNR71YBmYFmWzTT7B4xUJ7+UKOT4Emu+tUmt1gP2cIoed8wSAd2IX9E5sDZxggTPK+T6Fp7XOxIYDVpKHxpJY3A6/Gb1zjxHHNv/311GskRyOnpD8I7QbiGo7DCGMHYAbpGxrLkDLUwRoD7izwYEx8vgvsnjEylvccjEgjT4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(7416002)(44832011)(66476007)(4326008)(66556008)(86362001)(8676002)(2906002)(36756003)(66946007)(31696002)(5660300002)(316002)(54906003)(558084003)(8936002)(31686004)(498600001)(53546011)(6506007)(38100700002)(6486002)(26005)(82960400001)(6666004)(186003)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFZYUURQSWM5U01ubldIcTdVdGI4MzYvN0FxbFFHU2pOMFNtd2E5Y2RIaVJR?=
 =?utf-8?B?OG1icUdlU3BHaXFqV3JLSVBYV1lvMytPL2VsR1Q5VGVJbkN1S21KUWlaY252?=
 =?utf-8?B?bFNxNmJtWXpVeHh4SXJwZGcyV2pqcFN3ajUxMVk4eGx4U3pmNlV0NU1hSm1q?=
 =?utf-8?B?aTdsU2Z2L25hUGUzTmxJWnUzVjJranhUZTVOQksvV0VnYm9CdVZVbCtWU1A3?=
 =?utf-8?B?RnlOSnFsUE5qWW1KdWlFY0hRQk0vWk5nVUNoUWc2YllYY1p5WUIzam5LbXp0?=
 =?utf-8?B?cCtITWYyaURkYXlKSHpmSGc4ejdLald0RkNaYnVXWm9NVzJWKzJtRWExNUdC?=
 =?utf-8?B?dHhuSzFyb0JmYUdGeEJ3V3BtVHRLa0dQRmN1N1NiRE9OUXgzYnp1SzBBT0Ny?=
 =?utf-8?B?V1ZaeGc3UFNxOW5DQml5M21aOGVMcU03S1NxdXpTM2hsd2ZQWVZVdkU5ekRw?=
 =?utf-8?B?R0ZLbGYrNDFlR3BhUkVZdjk1UjV1TTR0bDdrZlMvOVlMeWM0K3BJdjdSMTFq?=
 =?utf-8?B?d2VPeGc1S3kxYUoyRFFlZ01MMDdEZ2wwMlY2OUZ6UEJyU0lMRW9KU3E0U2lw?=
 =?utf-8?B?cDh0Zm1CQ0RMeGc3RmRaazBDdlhLTzh6US9KL21Pb2p4ZStPSGdOZjVBRHkr?=
 =?utf-8?B?QkJYT1VhOHNQNVN5Mm9tcWxNYjdOSnIyTWZ1enlQZlJSdnFkYUo1WWF2MndR?=
 =?utf-8?B?SU5MWVVzcm9PZjRYTWxOWVl5cmVCSFpLL1JwRGR3WGpGK25sRFMxTjgwRW1Y?=
 =?utf-8?B?Zm5LLy9yeElmSTdyS1k4bUFjTG1ieDFrVE1yNGNzV3NsQlowaFJacDF0aGpC?=
 =?utf-8?B?Yng1eW1lQWJSS1h1amZXckJyNGp1YjJVRTZvRmk2aXkzemIzN1hHQW9sT2Zo?=
 =?utf-8?B?WkdhYWlROEJER2JLZS9MaXRuOG1IUjRxei9LclI4VVV6Rzd0TzdQWnVVb3dr?=
 =?utf-8?B?RFF6amx3c0tXS2lWd1liZ3gzT2QyS2lHU1RQci93V0pHY21zTXZ5K21ZNTJv?=
 =?utf-8?B?ZVVLVkhpNUtvVEpTSlVqbVpOOTJUMHB4eTZqVXdVWW9hL3hUa1g0aWRkeVVE?=
 =?utf-8?B?YmpScFlVY1lrWEhheFcvM1lqV09aUW1aUXczQU1BOEE4dE9JYzV2bFpWWkFZ?=
 =?utf-8?B?NU5yWExTOW94RjBOMHhnb3M4aE5EODA5RnZBMFNQVTFBOXBPUEtQY2JYenlH?=
 =?utf-8?B?WkgxeDRvWUlqOFRsQnU1anRyVXRGSmxyajlmS25mYjlwdnkyVHNaT0RyZFZw?=
 =?utf-8?B?eEUzTjhuaG1KY1A5V1h1SVZnbkNmclpWQ0c0ZmY4dlZxSWswem9heVJab0po?=
 =?utf-8?B?YTVvQ1kvWjM0aktDaWhXRGRCaGYxOTdZbUpsejJqSVpkaE94SjV0ZDJPMEVj?=
 =?utf-8?B?TGdpQmFTN1l2Wll2YWdtcEozbEMvQmJ3SmJNcHY5S1Vya2UrOVU0NFQ4UVl0?=
 =?utf-8?B?QytOdHNDeEZYNHl1NjNLMmN6aUV3Tm9lYURYbytITmppZ1Npb0x3LytITGNt?=
 =?utf-8?B?QmlTdzVNVTFJRk5tSncxVURXd25ocGh2QVF6SVVBa0xSaXhUa0tJWmsvOWhr?=
 =?utf-8?B?TGFOcDhDNXpURTJpdHFVMGYvL0NZaGg4cllEdzJLeGh5alNkVWl2RjROS3pP?=
 =?utf-8?B?ZnF1VUxPYW10R3pPbW5sS3RYNjZ1UXpZeHRBcU1oYmhBaTYyVCtGTjZxaW9B?=
 =?utf-8?B?TTJRSjAvMWdGbHZLd3dHVVh0Y05nSE5CbkF3cUI3VHdNWkovaDFNenRvdC8w?=
 =?utf-8?B?cHpYRGVtamRtYU1nSEpYWFRRSmtnNVlITDc4MHlVN1JBZnczZWc5b3I5amo1?=
 =?utf-8?B?VFdWT2VMMmdaUVZOQmxmaTJReTBHN2tUL3N5ei82N1EzNk4xTUg3Ymw5UVJq?=
 =?utf-8?B?WGJMY0pnMHJLTFk4aXkxU3R5cUxpRXVmZk05RGtVYmRpWVovTWtySkIxTFF5?=
 =?utf-8?B?QWpwbFlUQ3F1RXV3QlZKU1ZlMFYyYk4vc3phYWU5R1NyRUx3MC9JQUllMHY1?=
 =?utf-8?B?TGs5UTkrYTJRbWdFbCs2bjdDblM1MFZGeGJGd0R0blB5MUZLUm5pZVc1cURP?=
 =?utf-8?B?NytzY2NmWnZnRHhwcmh2NzlSYTB4STRacjVGL2RTSzQ0L29PY0lHdGFZWm9N?=
 =?utf-8?B?elNXVEFBR1ZQUjZZMFBDUSs1b08zRHVQUHVnbWMzQXZvN0lSNDNlc2pEUWpt?=
 =?utf-8?B?dkd3RTVTdjVZd1JMb0gzRUN1QlZDUjBtdjFsdUMydnFTQ2pEYmxGbTJSNWhy?=
 =?utf-8?B?d04rUE9uN1RnQ1RBemg5OFVpL0N5TEg1VTdONXJFM1cwaXNCSXVmUUdhMVVr?=
 =?utf-8?B?WHUzQktCWDkzYk44Tjd0OFRTOE9mdHBPaUxPdWRQM2R6ZDAxaGdpbjVkd29x?=
 =?utf-8?Q?nBoUcYfGwKcPSy5g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 524f5389-12af-4271-f3f1-08da505b869d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 12:18:45.8028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5tGJsm+cT5z4iAHS/m6OXSsuBQg6/paxYpulyPlriuTcJnT9t/TgZJvjPbtUqjUJ21x1xqKrI6OfvjkQmSD9LWh6Kv804A2jlqWJAUDJmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6384
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 12:04 AM, Pierre-Louis Bossart wrote:
> The current code does not check for errors and does not release the
> reference on errors.


Thanks for the fixes.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
