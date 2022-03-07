Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ABF4D0401
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiCGQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244134AbiCGQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:24:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D293527C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646670191; x=1678206191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZgS3FMVi+ebFzquTI5XCSZk6nYJE6yVCX0GcyCxa0w=;
  b=bcu12pMvzzCtIBNQ2lQkIbdDJnK6XQ/vLkN36uxud4O2m19BwoO7kUNz
   sFyTgeEEKhIW97FDjWuA5vLYQlNdjBJO7VEuef261Eaw/q1hCNmMZON86
   2NCdWQq3fegocBd16lMIWjNGe0dxaC1P9aiwwftOviYRcIkbNj78U3+pq
   t6BrbivXtwfxJUoZlKqTzKfNG7bRwjnLTXKS/85i+5rgFRwmo62A4l0Uk
   qczcViYWgfEAO7b/JvIiNr5SkB7uBFzI7p/taHgzpsKWFxX2o028VSh8W
   qBL0tfu/j7iV5ayiZ2RzVuwpKNNI5fNXziaUG0LVO1KQf3fLF6dflk6iP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254623524"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254623524"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="631892752"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2022 08:20:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 08:20:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 08:20:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 08:20:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW3RScx5hG9QQl7WdAmIMVhbP0jWazKZxfnaQyqKjC5DvExDdBV7Yw1KvoeNLuTe3YunlysvDZbUhtt0+7rlu5lhI0R/gX0Y+F32vkZqAiVik0I3XBG8nIEQGHCWb5R+z8F7y1hDEaIDlc8m13EXa0T1VpX4sMhNWTRJINVWoauysUVsuCGJIiW5HVEZXnzpZGx+jAW5DJNwdz9g+Jo9EZ8Ic02yKIW2FWqDx4kF0iKPeilApMvrWrBManrfstrxvBUhFNX4Z3vT9PevLBnN1kVRsH5egdyePos5YXbpYKLCLu9JCY/9LhVWGoFQp7Gk3+Q1KAwBUnHTAP865MSu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYehPEbZfoAFexXrEE+IlRsGa8Vm6q7QBXL86IYHJw0=;
 b=HIZVXKhD6KdYU0//R/RTEum30wpXmIRvSMq2ySg1JIz/NDEj5/kTD1md9Fl1HTvPzdSQn4++13gFahoyk8SM+GA1Gu5dWydKA2qpqcnbhlpW2ll3jLjuiIFYOXmHTuKDZjYwjcp2ycbBaqg4595rxHSfAD2NqRuor0U6PCluu5DiwXb+KFLtV/XWDpQoEPIV0HnsifKg+cN3AY5mqdZBUY9yrUZOJRqSOW0AlSf4PWjzzC7DwC4DM/XCNETJIB+7tehI/BbTpFgqWGSX69tU9zEuEKn7DXn7TXcEcXaEo7/BOm0pWScJydJr/cj4cWaI+UozdFsL4eQt3KOGEVDVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10) by BY5PR11MB4135.namprd11.prod.outlook.com
 (2603:10b6:a03:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 16:20:02 +0000
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::24c3:c14:92a4:22a6]) by MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::24c3:c14:92a4:22a6%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:20:02 +0000
Message-ID: <f621882b-f962-15f4-ac74-4e93edc5fde6@intel.com>
Date:   Mon, 7 Mar 2022 17:19:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v2] ASoC: Intel: catpt: use asoc_substream_to_rtd()
Content-Language: en-US
To:     Lianjie Zhang <zhanglianjie@uniontech.com>,
        Jaroslav Kysela <perex@perex.cz>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20220307151939.32870-1-zhanglianjie@uniontech.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220307151939.32870-1-zhanglianjie@uniontech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::33)
 To MWHPR1101MB2157.namprd11.prod.outlook.com (2603:10b6:301:51::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72cc8f77-de17-47e7-fcee-08da005654ff
X-MS-TrafficTypeDiagnostic: BY5PR11MB4135:EE_
X-Microsoft-Antispam-PRVS: <BY5PR11MB4135479B08A851D13DA8C9BEE3089@BY5PR11MB4135.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNUS7wBTIpp4Puc0+0KxcM/ythHXubyhydLewtKXkfp6W5A+jcZq9fBjyQOq0zAxHGV3yCUe5gKBPckPHeHume2OLdLXG50IMhGwnLug+fXohpRSW+DWnKtDrvfPnBMJSKujRssIi+/fAnh+QtFdIFbwzQ4w0eZBwScUAuM/EUe3u1W/DDwIFGm7DQr5P2LETMcgumcmamg54Qo5Hu4yi7+14HWcLAmVg4dPh2vVurQE/OWhoCT4qynXb6zL8BmJ7j6sMXf09Jgtgt/LOIQ3SVPAHSBu7UtRGZYTwJFopbQr4a/RIR7lIEr9mQ0h4n/1MXSjWHm0U1QvZoKMv/Ghak77w8Lfwyop2+3+P+K1SsS3iOxatY3vRnYY8h7TIr/yo98cBfsq0e9dUgTYRnYG1fez5fCa1LPLubqC/K9gBNEo3i1C8hoA9n3quyaBkFLWMEy2GKl1a3mFu31cX31uWmUt9Oz/LLScw5HB9YxNb8nVOBuxFhixz5In6dlmlopO6/8MNbnlAEutfW4v2AyyyPcLa6ZjEnqNlLPHZykHMBLzqS1+mitf7WsjfNfAkuwOVqXh99FbNXaMbpJcYaEg7w5ejln1GbROsZeHi0fIbK8AXv3AIQHC1hlCdBSpiwx45QZlM9ck7H8GxY7zOvq7upqZ1jXKcGOL7/3MBfDuR9v9vOVHZyEuiyUfdmqKW58s1u6Io9BLi/04yzRCCwgFP6crsAB0DOA/U9Px7QrLT7XY634fAeo/rivP6cfUFH0c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2157.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(66946007)(8676002)(6512007)(66556008)(4744005)(44832011)(316002)(66476007)(54906003)(53546011)(6506007)(4326008)(6666004)(31686004)(38100700002)(110136005)(2616005)(5660300002)(2906002)(82960400001)(26005)(508600001)(31696002)(36756003)(86362001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXh2czN6U1pFZmtiRzRMZEZRRHlmbFJlR0lEWnhOU2VqSGRsVkx0a2ozLzFk?=
 =?utf-8?B?dFBFSWRxQTVPVit0MEsyUGdnSzVpeXB2emgreUtVblJkalRBcExHQW9yVGto?=
 =?utf-8?B?b3hLbzl6UUJqNGRkV3QrNkk3RzlOaEFLY2tESmNmb0xwRlNGRnlFOWVZdGhk?=
 =?utf-8?B?ZGp0UkhjZk5vdzZ6eVh2UWd6SEQ5N082S292elpLSTR0LzhnaktIZktEZm1U?=
 =?utf-8?B?aCtzZ28rRDc4RWxIc0kvOFRzUGdzSDU5eWROdEFMM25ob1hxRHZ1VTk3ZGlt?=
 =?utf-8?B?SFRxbnBPT2VWQzRUVHZEUjlwdjAxeGxNSko5N1MrTUVCR2Znc2I2UzVoUUFZ?=
 =?utf-8?B?b21SSWxVS2paUFJUQ3RqNUNaR2tNSHVWdUdqWDBHMGY0ZCthN3A1YzFaVGtI?=
 =?utf-8?B?M2Y4eTZoY1VTM0xYNldqbnd1SnJ0MWZyQkQyQzFNUFFySldNd01uV1JnNWRB?=
 =?utf-8?B?RzNORjgxUzZJTFh3Rzh3bGJjTFBoalZlYysrMHF6ZHU1Q0NNZTYyVDltbk5R?=
 =?utf-8?B?OFF3WSt1aGJSYXRYNGhlazBiRnFRdXp3ZTcwaWZxMjltd21KcnV5NmhRczVj?=
 =?utf-8?B?UW4zeE5YU05PZFByN05MczNqZGpGMHlDS2VOQnZEMElYcGFPQzkvSFY1QkxZ?=
 =?utf-8?B?WFhjdWp3WVJlK1diNGJnY2JuTlIvUWVsQzc3bHltK3M1K2QrOW9vVE5Ud0J0?=
 =?utf-8?B?MDJOd3BVdUFWVitvenlmeXpDcUVBRFo3YVZoRDdrOHdDaUEyQWJSWXVvK0E2?=
 =?utf-8?B?OGh4amJUUm1SU000anNHV2RnWU5ZaW1iNmVGK1I5Z1JaWklLTTIxeTg1NlBr?=
 =?utf-8?B?VjNyKzlxbE9ycW9ROHA1MmRuL0kwRnp0VEhkeDJMbUFlUHJtZkJDMWt6cWRQ?=
 =?utf-8?B?OTNwWWt0R3A5TFVLb25ETzI4VHRHOSs3elp3NmxlSXNBK29STG9zcWZiakN2?=
 =?utf-8?B?MldHN2RwUDNMVGVhK1daaXhxMVEzcHdkcldzbnZOYldveG0rWnpMcEF6QktT?=
 =?utf-8?B?YTdtNldvMGZQM2JFQUpNSXNoYjZRTHZid2RYWHorSDk2N0JWQk1kc2NlY05M?=
 =?utf-8?B?aHJkL0tPN1RwaCtBeXlwN0hMbUhxMzBDWTRXb2dvZzZ5ZDJ4T2FoMlZkWTNW?=
 =?utf-8?B?TXlSRkVUa0RkWXJ4eHpIRWI1NitJMmdLUlZxL1dIbjRFeTdGVXRGMWJxRlZP?=
 =?utf-8?B?eDJwU0VUZ3ZzcVhvbW9Uc2RFU1l0Q09PYWR3Nm8zSnExTDE1cUdGMng2Wi9u?=
 =?utf-8?B?ZjhXbGJ3VjZtYzZFc1lmM2ptZDd1S2hNRXc5UlB6M1NNK0RIaDRwbE04ckFv?=
 =?utf-8?B?MWxKc2VHenpvVXdPUkxzc2llbGJ6QjI4aGQ0Y1NWRVRWUE93bkorQjhONUdS?=
 =?utf-8?B?b0JDMzRjYThGcXgxdEFaMzI3M09IVU5hZmJ5M2NMc3ZFQUNBSjJiSXJrUThx?=
 =?utf-8?B?eWIrbTk3SkxlSFpzdjJzc1dtdkwzSEZ1cXBwUzJPMXVGVHpTcVhuZThVT0p6?=
 =?utf-8?B?UFNnTWlyM09XeEkxcWVlZEJSK0RzdG1RM2pzVFAydm1FdzFtcjdxSHMybHNL?=
 =?utf-8?B?VXA0RlpCbjRJUGZpbVNYeUZac3hGL2lPazNHS1B4TmkxZFN4SWpCbVprYUVU?=
 =?utf-8?B?NHRSWEprWldkMHpmdVNKLzNNRFVCdXZUK3ZqQ0RucUZOc29jUEc0eVlpcFJ1?=
 =?utf-8?B?WlZ1MTVQK2JNWkdrelU3TDBoVWlYLzZhZllIL1R6VnJad3ZDc1ZRZUkyYWNr?=
 =?utf-8?B?dEtVMGFVekkzcGlWZStCaVMyQWx6R0ZYVmlndVRKczhwZ0ZvTWdoV1F3a2lR?=
 =?utf-8?B?MEhxYnpEZU1nWDdLaGdVa2NIT1l2YWsxZW9UaGRETlFxOTJ6WVlHRkRISVVY?=
 =?utf-8?B?SkhCTm1UMVZ5RUk2VEVHQlY5YUdsSUdMZHFhckZJYlFyNThqU3EvOGx5T3gw?=
 =?utf-8?B?eDVWL1orUlN3NzNLeEpxTDZJTWRsQ2ZhRzNOeXIyZnovaDVrV3E0UlFRRlRQ?=
 =?utf-8?B?ckxSWUJtNHhPNUdCdkZ5dmF3Uzg0THg3QTlWRW1ZckRvSXp0cVhlV1RvUkJS?=
 =?utf-8?B?SXk0QzR4cFdDK3FxZklodytSZFk3Q2NmcjFVcEhOU09EbFpmSUY4eHhaaEpy?=
 =?utf-8?B?L3hSdnorcjVsZFB0OHRlbHFxZFBhc2tBOC9zV1hEZm5NSXJZSFhwRkpxV2gx?=
 =?utf-8?B?dm5lZ3ZGbkF6RnJnaCtFNnZQT3dBWkRGMlVvc3pLMUhwQmZIMXRtcWtSRzBG?=
 =?utf-8?Q?ROaWRj8sjuaSKTTXUnzRcTTClzl7PtcXEvki+jI1f4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cc8f77-de17-47e7-fcee-08da005654ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2157.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:20:02.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5OD37w5pxmzoqOjjkahWdHcU/6zZSJyAuQtg3MRNaaAaFPPR00Wv6IYbp7W8uDTvyHi2hjyVBkP2MlVqcUbX8LzIosCMtpu13VA6RuM6W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-07 4:19 PM, Lianjie Zhang wrote:
> Now we can use asoc_substream_to_rtd() macro,
> let's use it.
> 
> Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>


Hello,

Please do not add reviewer tags until it's actually provided by them.
In regard to v2, thanks for addressing the title. Patch LGTM.


Regards,
Czarek
