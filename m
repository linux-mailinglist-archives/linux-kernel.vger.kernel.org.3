Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817351A05C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350316AbiEDNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350223AbiEDNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:09:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C22F002
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651669558; x=1683205558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n4A7MdVwPtpOI9q/UbrISb5liqCGVv5ceBErQfQVT7s=;
  b=bRpTXR6fEi+SU6XZyxq8O9lACQtH/Qw6slM+0bfZ3rI64puS4HUnvhgU
   wZQZI234G/ruGlhI9ZgMR6iRsjZ2BmsBUd+76W4HqjyEslv8finGAGTDH
   o2cHWkPcZViPxQzEboQPFaGJUK5zKDKd+WK/35Cu2l6NiJfeCguGB28pX
   9N/1qNvYI/U0kyp6R+l5lu7P5iX6gIwEBKvbE4yCyasFrNu9OoPIPj9+U
   UJKrrNNRbaYY+sLefGQLS7qbxjtLByqMypaRNefi7y4c0pd7k7rFa6qML
   EWk9dH4kbM5bvm7DM9/oUdxsRM1xoTjJ46xpL44g2N7+J4cxKIG4bSnOh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330746428"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="330746428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 06:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="599523510"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 06:05:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 06:05:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 4 May 2022 06:05:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 4 May 2022 06:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmvHxC3TpF6m+Tq4l4zBfrvdpELrEYCjMRl5wC46EvJ9D97k+bLEpMTac8EpfFaAQejxLvc+rHpngIlSePxrbE1c4mpfXd+9CYhxTYJEVgkeQiReXzUAHNJb0eXMPDaMPNNv8nMLH0zFTfRRtO4M8WEaTvWJwzymUazidYmOEZVhqPlfbTbbzEoUDUbnNPfkKGN5oupsK4esUCwWLkc1mA8M2JWDAr3DL85wDBZAD4GiZempTiK5rBmOEH6xHCOcBRrEv6HHdoLfzD+tVEWQ5Vnbtf16Nd4DwVeQPjCP+GohjlvHzz0neTU8m5sNHYwy3E8LhBZybYCjYi6f9pQNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV/hgefipcTkUKWjCAgtEgU31nhJ0E83zCe9aK+vpnE=;
 b=ZIC5AA9KpirdmVZu1Oz5iEZ/A91CeJbQWSVUxpthgujL+y/Vp1b/4mhEs+kKKq19cAeJADG0omuTM1SBupQFkbv0TmaKAOCfsNLN8AnPISVIoUpM03X3o9yFQs/tnbp8idKpCxctSO2cLTrKessrmxMX+YJ9Vfababw5EJvHg2/mt04DToNKCkId2BCPYk1oeTg70ysXjzVr+IE0DmJxNcChuUjD2ZlWB4eVMNlooyC3ehtiWMz6WtUy2Db2ZsCvxUi0KRXKG5FmH9xrZemtuBUddGFnZR5VbB4ULjWP13iE/6QNBUN1DvVgH3HOFcU+24vVayuq0qdZvxDlOSMQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10) by BN6PR11MB4035.namprd11.prod.outlook.com
 (2603:10b6:405:7a::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 13:05:47 +0000
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::b1bc:45f3:e805:6942]) by MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::b1bc:45f3:e805:6942%10]) with mapi id 15.20.5186.028; Wed, 4 May 2022
 13:05:47 +0000
Message-ID: <34417784-dbe8-17ff-a0d0-8ed4834a7ecb@intel.com>
Date:   Wed, 4 May 2022 15:05:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: Intel: sof_cs42l42: add support for
 adl_mx98360a_cs4242 and BT offload audio
Content-Language: en-US
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>,
        <alsa-devel@alsa-project.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <brent.lu@intel.com>, <cujomalainey@chromium.org>,
        <seanpaul@chromium.org>, <casey.g.bowman@intel.com>,
        <mark_hsieh@wistron.corp-partner.google.com>,
        <vamshi.krishna.gopal@intel.com>, <mac.chiang@intel.com>,
        <kai.vehmanen@linux.intel.com>, <linux-kernel@vger.kernel.org>
References: <20220504122450.117256-1-terry_chen@wistron.corp-partner.google.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220504122450.117256-1-terry_chen@wistron.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a615ec3b-06d7-4f26-b25d-08da2dcece1d
X-MS-TrafficTypeDiagnostic: BN6PR11MB4035:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB4035D82A99A1502DF5F5DEB3E3C39@BN6PR11MB4035.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oBBRRc7ZqlS5SDbJEbHfdJTOiL0UarzTUGpc0zOzwbsbv3e3vtLgl9OaKFHxH6AqmUPOfmx3clnvSd9YOZcUoISFmT7dngjqLQ8JPClBPIfLf9SCJuFUGfKoradWc33pgC9ElpsvfYvO86s41c+vy/5v5GR4mq4WWtCyWCzXk3FU2ss3RjsCUNeuzLTJSvgzW3rv0tMYSFr4RWxl5BlUvjXnftjj6mMpDxqMQSQvciVTzM3CldlsF5qVf+jOLVX6oS7ICW9/ofVU0RBifqi9l9/FDf1BxkCBSG2fTcU9r1gtr5ul//siPgGtYVCG80/szhGq+9vovh89XGKZvWmlfVWa3VS0ha6xxVhkYJsN51SlVLJJGLpk9vJr+vp3ZJCkRJwtdvaa61SRVcOPr0sbyZDnm6Oz0VpkhoE0q8WB55InH+Cm7FZStBzh2PoRQSjWkTu3mgkbLaHExiK9x8c0qkmSeVtp0HNmCSTsUfPw6Q5HYRWWDyCJ4if9Nk1WrvkYdKpXOS+BOAI4oC9UGwPxhr4WqkqEZyx4gX95sHpDdG36L7574OFKIGrYUlAKGG5giyNIBez7MUShp6XGS7Z0wM8LYbP7EgLUJ1o44YRijT/ytFk9om7DasHHzt/6rDVXe8pnimo7Uw5dUUrJsfOSOzV76OMljKvvi6MySbFJ9lcK/drIPSG+kMifWA4cIuKXn1apr8ItKSkqgpcpxlyAhhoDfvR9JKqmZTq2ePmfQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2157.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(6486002)(6506007)(6512007)(53546011)(186003)(83380400001)(82960400001)(31686004)(4326008)(8676002)(86362001)(66476007)(66556008)(66946007)(31696002)(36756003)(2906002)(44832011)(8936002)(5660300002)(7416002)(38100700002)(316002)(6666004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pWcWRZbHlBUXJDVTdMcG5EQVpOM2JzTVJqQkl5Yk5oNG1WZ0o5cytTdkVv?=
 =?utf-8?B?NVRKMDBFMUc0V05zRGttdzExMjR4bzNxdEt6b0Fsd3pNc0cyUlZtTzVSWkFF?=
 =?utf-8?B?ZUxmdkxlREcwdnFiVjRQclNJazlNY2dSR1hjeWZmc0pSWGNqUUFUNDNuWVFG?=
 =?utf-8?B?YWNHdXBZbjl5VkZNL3hBdU9GMnZRSFVKemxQTHBPZDFSZnM3eUkzN3VuQ1Zr?=
 =?utf-8?B?UmhLUTJRUFNLK0VwcEJQNHVRYWhNaG16QXJIaEI5Z2dVeDlDMkdKTi8ydVFF?=
 =?utf-8?B?clgwSVIyT0hxZXhOcDNTeTEzOUk0QWh6cFBGb0g0cFd0RnA2b2RIU3c0RXVq?=
 =?utf-8?B?L1ZvdzJFa3drM0NjREx2U00vQ05EMDJESnE4YXJGTFdUQnlDS0VYNTh6VlZu?=
 =?utf-8?B?bmtNNEY3RFFTMVlUZDNaMzR3ZXdYZmRlQ3AxcWdlZzBRaFRuZnFkYjJYdWgz?=
 =?utf-8?B?dEVydno3RVNZN2FiMGE4aVgwY3JtNWhNNmtieTROMXcyU2tkdTRKdWpHbWcy?=
 =?utf-8?B?TG5TUy82VVZJU1Zwd20vYm5iMjBMSldyeUNpcER1eUp3MEpBMmpsam1hNktE?=
 =?utf-8?B?TUFLc3pSVVl5Z2NHeXhrc0JFbFN2TzhkSUVud3VLd0MrWkVSa1ZRdi9lTGw0?=
 =?utf-8?B?enFxb2RuZko2Sk5xRHR3dGllVW0zZU1vSWFZL0drTFdObTkwK1pqd0JHVjd0?=
 =?utf-8?B?WkF2S0Z5YndKVTdNbG0xUHlKekRhR0t5TlhZYzE3V0hJc0hDWWNraDN6dmdS?=
 =?utf-8?B?dDFnM1pXZlV4SUMyemdENUNFSEx2b1NCRG9aT0xGUmJBRTk5OWJXY3d0dk41?=
 =?utf-8?B?NmMxZFFhZkZxMXAxVUJzMFd6VnZBbjdIQ09tblV5L0xCUjdNYS9XSDAvN20x?=
 =?utf-8?B?eVB2aEVGUy9ydFdOakdKMEh3anYvTUs5Q2NrdVkyd3BFL0V0akpSUkN5Yndp?=
 =?utf-8?B?TTdaUjJIaVowVURvcTVPeTg3QzdCMTM0SnRYMG1FdndKK1ltcGNFRVZnTUVQ?=
 =?utf-8?B?T3dQUnpxRjAvbTZrd0lpT0RkeGNCeW52aUEyZjVHbE5SZExrQWg1R0RJRHlh?=
 =?utf-8?B?RnNXenp3dUhLbEQ5c1YrOFlJUFV4UDgzY1hhNnNZNFM3dG1BT3NqV2FrT0Fw?=
 =?utf-8?B?d0ZieCs5bExYdks2dG5ZV29qY3JYdjY0d2RwQTJHY3pwR0Jzamlwc3loSkNs?=
 =?utf-8?B?UmtWQ2NESXJMdjB3bDZTY2hpeHFkNFlJdk1hd2ZCRzNleTFCc1doeHdySzUv?=
 =?utf-8?B?WlgybzhEZnNzYkF1aE9ncWZJQ1dwYXFQZ0wydHpNOGdBWmdEL2t6VUpvSm1w?=
 =?utf-8?B?UitoZ3pWcEMxY0FuRW5yVExaaXoycy9aNUswRVN4TzVSeFVVVDdkTVJORnVG?=
 =?utf-8?B?eEFwTWt2QTVxSTd6S0lSMyt3aUdsbnhmSTh2UDdmRzRiWVYyb0wyWlRMSG5F?=
 =?utf-8?B?WTRDYnBBTklhdDFoaUJKdEFZVzNhSTlnTDFrcytJeENHTVlJakxic012TWo4?=
 =?utf-8?B?ZzZKOE9YSlVZVmVYWDMvMmRHYVZQOUR4UU1VWWZKek85cXpGVHYzRDlVc3pj?=
 =?utf-8?B?Q3FJN3JEOFRoOUFqbTRKQnppZUpGcW9rZ0dzckxyY2ZNZGdIN3I0eU9LWUtm?=
 =?utf-8?B?RWZjMG1xUUpROWlBU2FRVGFXNXZzMS9BMURxNjdZZUVyemFFRmNPY1B3dUI0?=
 =?utf-8?B?cUE3MUdQSUNSbHpOSnNVMGtlTzkrU0NlUm5iYlhHcTdtRGI5RGpBR2gyTC9h?=
 =?utf-8?B?cHFRSHQ3RytTTkNuSTZ0eEFzZlE3aHE1cFkzM2QvbXp2RGVzbjArZ2VabnRz?=
 =?utf-8?B?OTZWYlVRcThHcXhBWUYvckYzU01GbmZ0U0NpOHRqVzdRWFNKc0UvRUZmSFlP?=
 =?utf-8?B?WkFrQkw3RHIvcFBTSUdxNnFtNEdLTHZBeVV4MGpTa09jTjhhTStlV1FPV3pu?=
 =?utf-8?B?aWRCMmNRUUFmQXhaSS9kelJKaXhJL2F6WGNOWW9tU1R0eUxxTHB6d2srbUw4?=
 =?utf-8?B?dzFnVnNUNy92bFhFQWxiK25BbEpCNUMrWFZLenhueXU2bWF4UU1kekZSRkhD?=
 =?utf-8?B?RGtRYnhpSmdlV2NmKzZLUmpIZzU2bXN6ZnRSbmhjM2x5ZlA1WDJBaVNjcXNj?=
 =?utf-8?B?SGQ4UFJGSDRCLzV5di95VGpxTUNrWEJ5VGNDUUpMWmRSZi83a2wveEFxOUFQ?=
 =?utf-8?B?OXpuWndLdTBxWVAxU0ZleXlFMmtFc1ZXYXFYZExhWEpyQVZaK3V5R1JwZHdy?=
 =?utf-8?B?TWR5ekh2UjA1RCtKSHhnTndRQzlrZFc0aGZUT0JLUDNFaWxlS0VNaWM0T2M5?=
 =?utf-8?B?M0VXcHY4V28rbWs2MldDdWpnYm15R25kK0JGS0lIT040THMzTGNUcUNvMjlS?=
 =?utf-8?Q?b3LIXg2hpvGwfVz4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a615ec3b-06d7-4f26-b25d-08da2dcece1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2157.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:05:47.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGwmfvQxVWHwzqxDS3CQwC50gJWnTG1uwTVMmrB2dSPBK+Fx4M8hBuS55Rr38jokVEDlw82fBaQ3VJW6vC6ejAafmOvwstnY3T6RQnJ2NpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-04 2:24 PM, Terry Chen wrote:
> This patch adds driver data for adl_mx98360a_cs4242 which supports
> two max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec
> on SSP0 running on ADL platform. Also add the capability to machine
> driver of creating DAI Link for BT offload. Although BT offload
> always uses SSP2 port but we reserve the flexibility to assign
> the port number in macro.


Title's length seems off. Please shorten it a bit. Commit message 
formatting (line width) is not cohevise across the lines either.

Another suggestion: skip redundant bits at the front e.g.: s/This patch 
adds/Add/. When adding new code (new functionality), it's good to 
plainly state: "To be able to do X we add capability Y".
The last sentence in your message is a side note. It's good that you're 
being transparent here, my only advice is that you add a new line before 
such notes as these are not the main dish here, really.

Title suggest you're doing two things here - adding support for some ADL 
configuration (1) and BT audio offload (2). Recommendation is to 
splitting non-atomic changes so each patch in the series answers single 
problem.

> Signed-off-by: Terry Chen <terry_chen@wistron.corp-partner.google.com>
> ---
>   sound/soc/intel/boards/sof_cs42l42.c          | 88 ++++++++++++++++++-
>   .../intel/common/soc-acpi-intel-adl-match.c   |  8 ++
>   2 files changed, 92 insertions(+), 4 deletions(-)
> 

...

> @@ -278,6 +284,13 @@ static struct snd_soc_dai_link_component dmic_component[] = {
>   	}
>   };
>   
> +static struct snd_soc_dai_link_component dummy_component[] = {
> +	{
> +		.name = "snd-soc-dummy",
> +		.dai_name = "snd-soc-dummy-dai",
> +	}
> +};

Isn't there some SND_SOC_DAILINK_DEF() macro for that already?

>   static int create_spk_amp_dai_links(struct device *dev,
>   				    struct snd_soc_dai_link *links,
>   				    struct snd_soc_dai_link_component *cpus,
> @@ -467,9 +480,52 @@ static int create_hdmi_dai_links(struct device *dev,
>   	return -ENOMEM;
>   }
>   
> +static int create_bt_offload_dai_links(struct device *dev,
> +				       struct snd_soc_dai_link *links,
> +				       struct snd_soc_dai_link_component *cpus,
> +				       int *id, int ssp_bt)
> +{
> +	int ret = 0;

Looks like there is no need for 'ret' variable here.

> +
> +	/* bt offload */
> +	if (!(sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT))
> +		return 0;
> +
> +	links[*id].name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT",
> +					 ssp_bt);

Current limit is 100.

> +	if (!links[*id].name)
> +		goto devm_err;

This 'goto' statement seems redundant. I might be missing something but 
returning -ENOMEM should suffice. Label 'devm_err' does not do anything 
special anyway.

> +
> +	links[*id].id = *id;
> +	links[*id].codecs = dummy_component;
> +	links[*id].num_codecs = ARRAY_SIZE(dummy_component);
> +	links[*id].platforms = platform_component;
> +	links[*id].num_platforms = ARRAY_SIZE(platform_component);
> +
> +	links[*id].dpcm_playback = 1;
> +	links[*id].dpcm_capture = 1;
> +	links[*id].no_pcm = 1;
> +	links[*id].cpus = &cpus[*id];
> +	links[*id].num_cpus = 1;
> +
> +	links[*id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
> +						   "SSP%d Pin",
> +						   ssp_bt);

Ditto - limit 100. Applies to every single occurence below too.

> +	if (!links[*id].cpus->dai_name)
> +		goto devm_err;
> +
> +	(*id)++;

Are the parenthesis needed? Should be save to drop them.

> +
> +	return 0;
> +
> +devm_err:
> +	return ret;

Once 'ret/devm_err' situation is clarified, this block can be dropped.

> +}
