Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA84596FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiHQNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiHQNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:23:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F3140C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660742602; x=1692278602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ve6HvRiYaUSZf7SKsX68rfiZHOupAtCPVH/BK9J/zIE=;
  b=lsIt4QepJl4LPIAgrBqDSO0uwvPYAAaeayV/5lRZVO/yOX3iz8vbUHOG
   Y6/q68mqnUEhuugraTqnXPLfP8+Ls7tsnRd/mItjEf3Si8pVXoCqVzCbB
   bAj/8f90iBUAyVY0HjakHMlatn2dvyz+vmPkmcoi9JQosy5rWu1e/h2hj
   3zdMi3ISwJQCOQeyl0ekHlVoRuIpzrfFjrvsQmDQqhURQuJEyj0CGu6Zi
   CcfC+Rne7iLd+1S3o0Nt7oGHsW72krkHszdO7upDcMgnZESClD1cMNb1f
   Ht54zk3C8Ml8VBsNh/dDw9qp/stzOjrjHqmUcqBDSsc2Us1kqaTQfxz7u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356485955"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="356485955"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="583766299"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 06:23:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 06:23:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 06:23:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 06:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5BiWOeU6sknlIMyF/kATx7WRfqDlExyBlLZd//EdSbXjRhk9pnSSWGmZJ6og2VNP3HbOIpiO2d6rFl2rDNqfSGRYCYhSLTJvKIkym2RvKcD382dKu99OLnpx/l/YzPRkBahfm7a9gH28ACnDUGOZX85NpRHhsDNYIAgqd4Rw/I7m9+MYk82ROQhq2OGo/vgKpcp2Qzex/IIhusUbGJlIYM+s/YHOqJEDr4/QO155Gt1V6KFmdEEOa9C82XYIKj5lMDO2Xr6DOz0FEQdre8/j1Za+5N8C6H9xjfJhTRItx8TMeHVbQv8sDow9M28pXxlAy6MOb5Y2F0QD5kGiW5IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9I/BXGvSlXsF6kkHY6wq/dKgxp/MDVrNMTWQkToog8=;
 b=Rjn0wscsyJUsGbzRIpOnWIH7fXatZSfp9LbJHYhQX1fvqNFcFxLYkZg12x3BlxpydzPhAPxZupN4rNY2Z0ZyqhCaHl7R9ytFJdbJ84vxI/FYyyj8yUQAKnX+St9ALlwlbpvmyY2nWdV5/UnLTPi6hWtUlD2rjKd6IfBAIDxnBUfxaiby0xqzPaA6pw1F5b/4M7Ob6b53o1GVJ3vipLfz2ph2okolajJ8H4AmCFbdedOICHVGbhOJqf6X06XBs4+tNKHnVbCZhLOa5oBkuyi4ZX76Alj3CqkH9gBYbDXvFW+7TUOpD9wNFe9jfw+a6bDRMpfKHW/jjIqYnHdDUiovCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Wed, 17 Aug 2022 13:23:18 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae%5]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 13:23:18 +0000
Message-ID: <617fce3d-4661-bba4-4e64-a43dfae38ea2@intel.com>
Date:   Wed, 17 Aug 2022 15:23:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] ALSA: hda: Minor cleanups
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>
CC:     <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c170a2a8-bb91-491e-1972-08da8053a607
X-MS-TrafficTypeDiagnostic: SA2PR11MB5049:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paYXhW7hY/oCKCjHQt3CJQYf+x1AZ+4j66pWP/qne8bDbw8TnwXRJyH4W9WXrSR8E3wzyd87JcPNSa6dpcYR2ZfGsotTAiiVc1tm7oXWcJhN24qLEAse+RNM3BQX4mzMW1usTTGbcwlbuYqGU7+QDhvS3dgNxgpR3FlwGtJ8QfNcZYZdhIeU1D9XhGqcc92CYTAAYzK+SPjWvDdKpAwnd4avYTjAOk5FwdZvAcVx8VNLAHnW13duMZp2NZcJLVjAxABRoaaV44BRb+Bf3176zM0/c2NN7nkUputhE8V2RLzQb4u23pD2z2kX8MMruV3pWqg/PnqNRnmAsbOKS2yQ2GQ6dJQXDR7BdQfg11mjxdN3MvvC9Eu0uQZ/2nWHIT5Ea1QDus15dJL87APh+N8LMmDowiG3r2BzXKj55jQ/Ah/WcaEXOeARb6f3YE16MbZEzlGON9PIFEX4v+fvbF+p78iUX+oKtEyBU9jsrU8eHh4fKxFLHgZqKxw8Fc+1JNvnEZayS7Poj7UpmkxdArTKyNxhXCP+e/rCfLOUe9n6w83l658y8CN/nXOxhjIGnJMjXX6REH73ODhNnyB7pKAW3NloDRlemSTXwD+2qRHUG58Rr4ySWKxbz3iy1dGEPaIxUZLLf5VY3YWhloO5U1Ll27Blrh/1fEmL2+DJxFeRWTRJ/e3RCcqQHaM6boc2mg1iNc71UgSpvXo+iwcWmqe8oYo89J/g54+SFDeCkJOvE3IylaKcBoz5Fc+5RlWCwmRxAF6cWwosFC7n3TP7YNSBchUg54jGshbHZjj3P753gBslS2mU5V+IYzMkhP47OhNNecRze3NG9SIp+q7nmNd4xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(82960400001)(26005)(2616005)(44832011)(66556008)(5660300002)(6512007)(41300700001)(4744005)(36756003)(31686004)(6666004)(110136005)(186003)(8936002)(53546011)(66946007)(316002)(38100700002)(86362001)(2906002)(31696002)(6506007)(6486002)(478600001)(4326008)(8676002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dTdzMwN0NqMk9FVC9JeXBLR1N6YWFYTWoyQ1QyUHRCS1Q5UjZUeEY4UFBv?=
 =?utf-8?B?Q2tRR2wvSGhQbTJrdkxDMW01N25SWHdleXJoaHJTei9TOGVnbWNQNEpkYldi?=
 =?utf-8?B?UnhyTTQrclV0RFBxYUNGUm9JN1ZLT2IrR0J5UUpuYXZqMHpaYnBMbnhyL0tx?=
 =?utf-8?B?ZndKbERaMDhuNm1xUm5Hb3BEdE1ZbmRlRFZOWUVhTEJNRUJmSnpGeno4ajJt?=
 =?utf-8?B?WXExS3JrUDBXekc2Y1ZneTRvbTBCM0xleTRzdTRFQ1AxN2tkUXJVQjhyYU0v?=
 =?utf-8?B?QWZxakRZSm11MEoxQU8yVXlRYmR6TkplTnlHY1BteXVFTFU4a2FDZ092bXN6?=
 =?utf-8?B?VS9zdjdhaGdveDE2ZXFVN1hFRUdtV0FmMVQ1OGUyVVo5Nkh3UmkwV00zQndm?=
 =?utf-8?B?cUxtRDNpWFpNQmc4RStYMHdYRHdEbEgzSnNVc0ZOcVoxUjZSTXZNd01NMlFi?=
 =?utf-8?B?dTF1SWUvYTRNU3N4S0hiQkZLR205elp5aHliNGhsUmpLMUxWc0RvYWhBOFVB?=
 =?utf-8?B?ME9WSUhDZU5MZ1VmSlF5MFVpdDRaeVpEdkQ3dC9SWDB6Rkt5YjdHczhueGRt?=
 =?utf-8?B?ZnkvSjBkaGJ6aEFqQTRLMkd4SFdMUmNBRlVONnNhVm1vcVRCWmNGcmxUbW4w?=
 =?utf-8?B?bnlaUUpCTFVGcGJ2cTUyREgvc0JuYmNjMlNIUWo5MTFHNnBVWUFOS3ZwakZt?=
 =?utf-8?B?RU9QUmx5a3dveUhOOURxRU5KRnhOWHMxZFdKVFEvVGV2anZpQk9odHBZUTZY?=
 =?utf-8?B?cVhBMzU1SWdUcWZpeVhSYlU2U1A4SW0yT1J5SXBSYjhRZUJmUFdTS1g4d2kr?=
 =?utf-8?B?d0l2SElVM1QrTTZMaDdHQk1KZTdNeXVSb2hseVVxU3ROUWJRbHluZkhSL3FG?=
 =?utf-8?B?UXc1SmUzTkt6cXowYWYvZHE0cXJYcENCekF5NkVFbkEvcVo4UFVkSGE2Ym9p?=
 =?utf-8?B?RU1uZHh1UjJobEdsQUF1V2tDa080WEhTNk9vcnc3OEpUcitwMkNnVHUrQ2dP?=
 =?utf-8?B?RU1Eb1M1amJ2K3pvcjVsMzlsOXNZdFNFcWhobU1YMmhDaFdETWptd2JDWnM5?=
 =?utf-8?B?QVZ1Um8zNklVWFgrUmFkdXRSb0VXNGtObjZRcWpvdUs0eGZUVStpSUMrUWxD?=
 =?utf-8?B?QVFOQnhYRWZTOXgvUzNwZzJ2cFQxNFJNSTNXTmdqOEVzdWpIN2UxNUlNNmZX?=
 =?utf-8?B?aUF6dEhKTzNUWWI5UXNlL0ptN2xNa2ErcGJsTVU4WHMxdEtKQ2U4QWFPWU53?=
 =?utf-8?B?K0ZKQ2RwVHBBV3lpV1d3T1dzSmltWHhlWnNPTitzUm1pYXlxWWt6R1l3Ym50?=
 =?utf-8?B?eXRGQjJ3VFdlN2pTL2hGMSsxWklVZkhGV04xU2lidUpEM3dQRDRQei9aZk1H?=
 =?utf-8?B?N29ybnd0OUw5cUF4eWs4aW9Zd3RGTkppRE9FZFVtZVg5RXYxcTRucDJvcmpz?=
 =?utf-8?B?OGtuRHk5QURzVSt4RFdnYXNtVTYyQ2l2aG81NlRlV04yQW1wWTMySldQK0hu?=
 =?utf-8?B?WFBvM3NyMEhmb0RaVFdJeDJ1Mmg2VFgweFNkWGU4SmlnMnBrZk5ENDNIU3Y2?=
 =?utf-8?B?ajhMNmFWUTh3cUJNdWNnYzYwdzNIL3JMVFhrRFJFZzJXNFF6aTBUdlgzWTdF?=
 =?utf-8?B?THdiWHJ4VGdtRkVVclBDTk5XbnB4STlubE5vZ3NtV1ZoeDVrVUdWTFhhRWVB?=
 =?utf-8?B?L1NtQmFYektHU2V4dEJqQmhiSy8zeGwwcmRxbDV5MHdrUXRGQjlCWEM2UmNP?=
 =?utf-8?B?T2JGWXJOYXJHejNWNnl2NzhQeUVVL0tLL094N2IxNHR3cUdxR2FtZ0l6WVRw?=
 =?utf-8?B?cURUZmtpcHJOcnRnZ2x4KzQ5aFc4R0ZXcUhuRlhRanNIbVBOZS9vRk1KYmNa?=
 =?utf-8?B?U3B4d2k1ZzFBcU96Rit6RStUVnZ0SVUrVUdmM3pjTmVSaWp1bTI0VHArVXRW?=
 =?utf-8?B?UWcycVlCYURnUXFLM3ppaWY4K290dDkrR0pDMHJKMzI1bmRJUTJwZ3E0akdO?=
 =?utf-8?B?RzhaQTFKK29qcE96VXRJNXhXRWpTamhmOEdLSlA4dnFpZEl4amJCMTc0Q0hW?=
 =?utf-8?B?bndrbnNkZ2Y5V0tlM2FCNE9XOXROb00zTEdEeXM5ZzFDcHlrL2dNMXBsdUQw?=
 =?utf-8?B?c1ZFUFhPd1NIc2pXRWFjdVE0bmxzdG5DcmE5MVFUNFo5R3Y1cnBxMnhPdmVW?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c170a2a8-bb91-491e-1972-08da8053a607
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 13:23:18.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1Wa2VxAUVrkuCTloQwsN68E/ZXtiYYkt3gat29TxfmZou4VJATdS3XBwc2BeA3LR52BZ8fIFEH2puw3gstDb/fMe4bAbOuE9yzOulTaQW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-17 3:11 PM, Amadeusz Sławiński wrote:
> First two patches are small refactoring of code to use poll macros
> instead of open coding register checks.
> Following two patches remove unused defines from code.
> 
> Amadeusz Sławiński (4):
>    ALSA: hda: Move stream-register polling macros
>    ALSA: hda: Rework snd_hdac_stream_reset() to use macros
>    ALSA: hda: Remove unused MAX_PIN_CONFIGS constant
>    ALSA: hda: Remove unused defines


Reviewed by me before sending, plus from the test results patchset 
causes no regression in the avs-driver CI.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
