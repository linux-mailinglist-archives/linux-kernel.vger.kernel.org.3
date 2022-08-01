Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCE586232
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiHABbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:31:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D977B840
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659317497; x=1690853497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4sjJzWSfRDTmCzZr5sDLwd/uAPQgfaas4jIcie3+uIY=;
  b=BLUSL+8fBNOgtLUiwVzKYO72xATw7NFFKQWyJ2Gg8iAwGfulInrtouHJ
   oZqo/DFw1pbOEnSLMk01oFpKikxzLZMAG17NlDPmqaQLZDdctdWYrkxIZ
   IZplaSdQcj5M8L6peI/ZPKBmp8r07XCZQSZrPtKEDpczAPaYSV3Jjq6bn
   W4zcka9ywMRUqOXIV1GM9yXEvDfFB3MFrV4/5wqOup1MtagaVgChlhzbb
   yUolbe8O5cn+QMbjFIpVwWyl6cEY4EuzJSsR2SQGzkRKcX/M9EIEXCrGn
   r0dj0i65ExPnCak/2l9YIQnqxhwv4MOZjVb1AB3Q93pzE4WBjVDyoNtib
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="353046733"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="353046733"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 18:31:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577605354"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 18:31:36 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 18:31:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 18:31:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 18:31:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJHPGvc107KXWnP5t7EEmdHpqAaz8jMEjPN9U+RPeqhCcX+u1Ki+tQVGCLcbDDdbht9Qu3W4dnMRGQF6MJVENgUajXrQc4LH9yHhyoRX6shNNIiH4HiSOFaS8d6F/Dj+ZPgWS46geuqO5MMbPytowaQIzijpiHYlGm0bi65cuIsl1V/qW2dFBFFvweE2BIEuT+bqIPYeFfWqQ6JCYZw7WVUPeUfBpoq1wvovBdDQS76pGfkM4VeM9K9YihFaJkc/TqycGrITCiHQB6QZptwgWxVobifOcE5FgQYts8OLchFpz9ugNIHIBEKWGD6mBm6nxhKtca+yW0bQtzq9EKHPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG6uz2LlPXm+7UNeNCSMqoadlWEpKqoplRuMpJkRrWA=;
 b=g4SjxwzD2lI+Ip7JSK383OYQp7rZ+yUoC/fy0hIKjV8kZ/z60IfYdJ/xKbRHT+gKUGkIZEnwzHqyPDslZR88GPhm8kiHRSm7sb+Vd3OiNcGFjt9BYbp3S/DtH1K90Bhwak5L/RFq6Gvt4IfIeYUqJVcS1b4j+7boa+OOIxvhEJswnBn8rsk3tMQhjWmpo0sJ3b7GaFRKM9E62my0XBWRsA5Cauh224nWzsZLwy2hakQsSF3hTVdvLD/UHWAqFYxuA1b5Ov1MM9uISPJaeLo9GJPMmVxlmTtlsK1O+lcV7cUMtywUwk8Z1Ms0QKmtRyQJYPl3Ft7taWGDk4srMCRSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 1 Aug
 2022 01:31:34 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5c8b:5ea5:b5b9:70c1]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5c8b:5ea5:b5b9:70c1%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 01:31:34 +0000
Message-ID: <83060dcf-8209-8a76-ea8a-cc50bddfc791@intel.com>
Date:   Mon, 1 Aug 2022 09:31:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] memblock test: Add test to memblock_add() 129th region
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
CC:     <rppt@kernel.org>, Karolina Drobnik <karolinadrobnik@gmail.com>,
        "David Hildenbrand" <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220728190051.237437-1-shaoqin.huang@intel.com>
 <YuS8kTgCBtdGy9XL@bertie>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YuS8kTgCBtdGy9XL@bertie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07517362-90c2-40d7-fc58-08da735d9190
X-MS-TrafficTypeDiagnostic: BN9PR11MB5257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+Peua8vblh/Nj79y9CtY4Hbr5yRA8xst4yA6Dn96FqSPw5ld8NuDiHJV9Qcuo1w/VKAsiL5Q3V7x12kyyA2MIawFBQgNZU2OTexiGU3sqnQhw1jtgyY9CoJgC/tLP1Q6DXrq/qACIeN5VInrKtJZvVxoDsmiz6abHaF+zIxaRexAos35Tl+HlSji6DJjK9rEFQvdDJOxow2u2dw+5xufnGamBporvUa4rRe4LZe8pLaPvMERAxukzslRJgpgGaCEn2zVvxMUdursrBkEkHNg7YdFjF1BN+dVmRiBKUuFB0vIYmPtJy2Rlr105VZWMco85ilHmZKz4Bw8QODyMBmkUL6DgN+QzWWkysCXQ6DigPZx/7g6wvckfF67U+couJ8HW3AgNkMqAFb9NOyfoorlsI7Net7/NNwba9e3Om5N/BFXCE3F9aAudl12RkNavWa+ajLHS7NOTmBm/5VaOUxu5scnn3L/gG9YVGyygNXR5F23RyCHr8N53/MLmL9kP/TiO3K2soiLXkYNjmDWgd/D8Gp29uAieGeMIlXzOchgwK+N4G5z9tnAVK0i+M4vjJyt5X30yTwj6jKzjPDszlxsgDtMLl6ReGNAx+xKqFRD1oJSm2NHaTApNNiC/8oDf2TmuxQJBCZOSeoOUSj4Sgu7Geh2YUM6E+PL4ieAicApdwI+vV1x/eS2YBrCseCR5zxu1Tr30iqZw5m2lmv3hYqouNNlEIZIRdw66Vr9qX1whAFZMYngDUjmoOpjOruYv9Ctm541d9bBLxA2DoVnqskctgd4JH48BnRz1P8KIdkdiWS5IYY8bEW+ciy55SiS/U9dkEu+XDMlRRFkOH6ynHpPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39860400002)(41300700001)(6666004)(53546011)(82960400001)(6506007)(83380400001)(26005)(6512007)(2616005)(2906002)(38100700002)(316002)(186003)(36756003)(54906003)(8936002)(31696002)(478600001)(6916009)(66476007)(8676002)(31686004)(4326008)(66946007)(66556008)(86362001)(5660300002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M29FNE9sSnhEemhvZXJBdCtVa2s2dlJ4aENPT3QwRzRkT1pxMjZwejkxSXUw?=
 =?utf-8?B?OWhuVHY3Zk0wRks3TWhYdDZtYUdYR2ozbm9QTnBLenh4c3RFM0FTOEZHRVF6?=
 =?utf-8?B?LzNIUVBrSVNGUnlmc05icDdUdXRvNEFra3lTNkp6WkdQN0ZkK2hDMXBNdzFz?=
 =?utf-8?B?cEg5QllYZEZXdnArbmk4a3VKSGM3RXRkYmpTbmd0R3JBSWs1YkhyR3VrNmpY?=
 =?utf-8?B?QzY3N0h4YWpiU3BPclZNQXhUcGozc3RvTVN0V0k4VGJBeFFHL2lMZk1NYkdL?=
 =?utf-8?B?L0hoS1kveUxySVB2RTk5OFVCNWd3eHU1Y1ZjdEdyb2JvVENVVnFZbUM2K1ox?=
 =?utf-8?B?L0paVXE2TmpDeWJwRGR6WVN2Z1YvYVVsUzRpdXl3SG1FTDJ6dDdJRldjVUha?=
 =?utf-8?B?N1VocjJSOWtWSXJrNXV3RkxkU0VDTFg0eUJURW9ySmxZSFRhQVNxWXY2T0dK?=
 =?utf-8?B?UHY4WjVXYXBzV09aM2FLdnZmQVljZ2VrMUhoSnFuL1lYYUl5eWpWNFpVN1ha?=
 =?utf-8?B?S0dNK2s2RFg3OHoyT3FEK3dlcTRpWjJ2L056VW1LY1RUOFBGVTBCSmF4OUtv?=
 =?utf-8?B?elROVTVXeFRNdllvNm1NbTZFc1hrNWV6bXROS2RYSEhQTTBPeWg4eFh3RXlE?=
 =?utf-8?B?Nkt3R2cvUjZCVkVEQVpUL1BFeTQwcSs3ckVSSGErT28xQllxZlVES1d6aWEr?=
 =?utf-8?B?SUszMkxhL1J3cHQ4UDlaeU5ORFpFZ0Joanc5Vyt3NElSVkRBUWoxYXBVMEdn?=
 =?utf-8?B?YU1IUi9Ya2luemRsTG1zYTlnMmovNjV6RmNNNjh5eE9EWmE0VEo1R0JrTGk5?=
 =?utf-8?B?clZTLzJmcHV3WWduZ2d3SElYaWNIVDZ0RVFydVl5ckl2S3FTaWFhUHNCNkF0?=
 =?utf-8?B?L0hCQWkvMHREYXFEUG9OVUZLUU9vM0ZMd296OGVUVzRuZ1JDNzJTRXFORXB4?=
 =?utf-8?B?MFIwOFZaSXFCbTIxekhNalY1RUNvYU9kclM5UlZzcmRhRTBiUUVEUTZYWkxu?=
 =?utf-8?B?Tm1KK3JkcG5sK2tKUkJCaE02UzJTSEx1WnJiWVpSaWpwVTE5bzF3ZDFPeFVT?=
 =?utf-8?B?NlFuUnNzdEVrOUtHTUJndHFadWtQNTU3RG9vSDl3Y1crTE82NXRiZ3NpRmd1?=
 =?utf-8?B?YXpLd2NQaUM1cnQvQ0VjUFNQc1EyOTRSdVNCM2Z6SFlGbVgrRTZjci93M3ph?=
 =?utf-8?B?TjQ0RTBLaFgwWEJJUnU4WUo5VnJkMkM1UzVBYTdwbUx3akVuVzA3UllZL2VH?=
 =?utf-8?B?cGxURXJwbVFGNUlDS0p4elU4cGh2aTA4VFpLQUpMTzY5a0RjanVhZEt4a3RX?=
 =?utf-8?B?WjA0WmVDKzZqNWhqcXlJS0cwS2J2TVA5U0JBOCt5c1FkRWc0c3RJb3hSeHdn?=
 =?utf-8?B?b21NVDNtYlNFUmpiRGt1SmRvSmdrZ3JkTGY1WjJkWEVTbVdPQlFJSFNNbDBv?=
 =?utf-8?B?c0s5SEVKV2trYmE4VGYyMGZIMXBweWdWN1QzZ2RZSjdSbDRMdnBoTFloY2FR?=
 =?utf-8?B?QXU3VFluL1p5Nm1SRi9nbFVERnBnZzJkYWUvRWM1MzRGMVBvZDJsSXZpY1c4?=
 =?utf-8?B?NkVhTUZmRVYxNTBHMFpsZlJRdXdDdFJmS01yZm9rZDBvQzFGdTFDV216dFI1?=
 =?utf-8?B?aGhIdWhmc1JWK0Rhcy9GTkhJWXR3dWFZMkFuL0hoVVVCVFBYS2hpTWhWeUd4?=
 =?utf-8?B?ZjlNaXN5QUxqWmhpcXlmSjk2dUNjZHJHVTVPbUNBMUpsUlRZZGJwY0h5K1pX?=
 =?utf-8?B?MGxDQ2owTFM5Q1FkZWY0WGZGS3ExaTFuQnRIdFkxMklkQ2hFZ1RQVVV0Tnhi?=
 =?utf-8?B?N0ZpR3pReExscHpLRGo1WXBmNCtpYTh1bzJXRjZlemYxenFMYnZxaUt1ZWtZ?=
 =?utf-8?B?Q3RFSHNrYmtXNVFpZDRXbDRmT0lrdjl3OVAxbm9DSFkxVHBkVytYdW5OcmVX?=
 =?utf-8?B?a0tURWZGRTlVMjNwZEVGdnd0eVZheWdIck5OYVRlaFdrakVlUkphazVCNWkr?=
 =?utf-8?B?TTI0aFkwdlpVQXBxY2NtYXNxcGR3SkhEWDNoRW9HN2UzT3N4MEI0OFJ0clJK?=
 =?utf-8?B?VFBPQ1Fmb1hXTklKS28zQkxuUmFsdTF1V1NaeGJ1ZWIxaWdLbGpLNGY0RzN1?=
 =?utf-8?B?ckUxd3ErTjQ3YXNzbzdDOVJDUlNMaFlsbWl3OFdxZG9FbW9SVmJvcDBFbTVX?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07517362-90c2-40d7-fc58-08da735d9190
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 01:31:34.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFLrEUhbF3eaJ6u+ZCdsjNoeQWmNlUsO2j6B8fIfJhD/7aruO+1QOhnBxhUvnR4Egj3+Uzi8YqbiKgCKLmOOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2022 1:07 PM, Rebecca Mckeever wrote:
> On Thu, Jul 28, 2022 at 01:00:47PM -0600, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
> I tested this out, and everything is working well. I have a couple of
> suggestions for improvements.
> 
>> Add 129th region into the memblock, and this will trigger the
>> memblock_double_array() function, this needs valid memory regions. So
>> using dummy_physical_memory_init() to allocate some valid memory, when
>> memblock_double_array() choose a new memory region from memory.regions,
>> it will always choose a valid memory region if we add all valid memory
>> region, so the memblock_double_array() must success.
>>
>> Another thing should be done is to restore the memory.regions after
>> memblock_double_array(), due to now the memory.regions is pointing to a
>> memory region allocated by dummy_physical_memory_init(). And it will
>> affect the subsequent tests if we don't restore the memory region. So
>> Simply record the origin region, and restore it after the test.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   tools/testing/memblock/tests/basic_api.c | 65 ++++++++++++++++++++++++
>>   tools/testing/memblock/tests/common.c    |  9 ++--
>>   tools/testing/memblock/tests/common.h    |  5 ++
>>   3 files changed, 76 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
>> index 66f46f261e66..ded93f97d98e 100644
>> --- a/tools/testing/memblock/tests/basic_api.c
>> +++ b/tools/testing/memblock/tests/basic_api.c
>> @@ -326,6 +326,70 @@ static int memblock_add_twice_check(void)
>>   	return 0;
>>   }
>>   
>> +static int memblock_add_many_check(void)
>> +{
>> +	int i;
>> +	void *base[INIT_MEMBLOCK_REGIONS + 1];
>> +	void *orig_region;
>> +	struct region r = {
>> +		.base = SZ_16K,
>> +		.size = MEM_SIZE,
>> +	};
>> +
>> +	PREFIX_PUSH();
>> +
>> +	reset_memblock_regions();
>> +	memblock_allow_resize();
>> +
>> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
>> +		dummy_physical_memory_init();
>> +		append_memblock();
>> +		base[i] = memory_block.base;
>> +
>> +		assert(memblock.memory.cnt == i + 1);
> 
> Maybe you could call the ASSERT_EQ() macro here instead of directly
> calling assert. That way, if the test fails in verbose mode, it will print
> out the test prefix. This applies to the other asserts as well.
> 

Yes, It should use the ASSERT_EQ(). Thanks for the notification.

>> +		assert(memblock.memory.total_size == (i + 1) * MEM_SIZE);
>> +	}
>> +
>> +	orig_region = memblock.memory.regions;
>> +
>> +	/* This adds the 129 memory_region, and makes it double array. */
>> +	dummy_physical_memory_init();
>> +	append_memblock();
>> +	base[i] = memory_block.base;
>> +
>> +	assert(memblock.memory.cnt == INIT_MEMBLOCK_REGIONS + 1);
>> +	assert(memblock.memory.total_size == (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
>> +	assert(memblock.memory.max == INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	/* The base is very small, so it should be insert to the first region. */
>> +	memblock_add(r.base, r.size);
>> +	assert(memblock.memory.regions[0].base == r.base);
>> +	assert(memblock.memory.regions[0].size == r.size);
>> +
>> +	assert(memblock.memory.cnt == INIT_MEMBLOCK_REGIONS + 2);
>> +	assert(memblock.memory.total_size == (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
>> +	assert(memblock.memory.max == INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	/* Free these allocated memory. */
>> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS + 1; i++) {
>> +		memory_block.base = base[i];
>> +		dummy_physical_memory_cleanup();
>> +	}
>> +
> This could be moved to a function in common.c since it may be useful if
> we write similar tests later. For example:
> 
> void dummy_physical_memory_many_cleanup(void *base[], int cnt)
> {
> 	for (int i = 0; i < cnt; i++) {
> 		memory_block.base = base[i];
> 		dummy_physical_memory_cleanup();
> 	}
> }
>

Thanks for your advice. The another thing we should make sure at here is 
the base[i] is both allocated from dummy_physical_memory_init().

> Since the other usages of memory_block in basic_api.c do not need to
> modify it, you could then replace those usages with a call to a function
> from common.c like:
> 
> void *get_memory_block_base(void)
> {
> 	return memory_block.base;
> }
> 
> to avoid adding memory_block to common.h and changing to non-static in
> common.c.
> 

I will modify it.

Thanks,
Shaoqin

>> +	/*
>> +	 * The current memory.regions is occupying a range of memory that
>> +	 * allocated from dummy_physical_memory_init(). After free the memory,
>> +	 * we must not use it. So restore the origin memory region to make sure
>> +	 * the tests can run as normal and not affected by the double array.
>> +	 */
>> +	memblock.memory.regions = orig_region;
>> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
>> +
>> +	test_pass_pop();
>> +
>> +	return 0;
>> +}
>> +
>>   static int memblock_add_checks(void)
>>   {
>>   	prefix_reset();
>> @@ -339,6 +403,7 @@ static int memblock_add_checks(void)
>>   	memblock_add_overlap_bottom_check();
>>   	memblock_add_within_check();
>>   	memblock_add_twice_check();
>> +	memblock_add_many_check();
>>   
>>   	prefix_pop();
>>   
>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>> index e43b2676af81..4741e860123a 100644
>> --- a/tools/testing/memblock/tests/common.c
>> +++ b/tools/testing/memblock/tests/common.c
>> @@ -5,12 +5,10 @@
>>   #include <linux/memory_hotplug.h>
>>   #include <linux/build_bug.h>
>>   
>> -#define INIT_MEMBLOCK_REGIONS			128
>> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   #define PREFIXES_MAX				15
>>   #define DELIM					": "
>>   
>> -static struct test_memory memory_block;
>> +struct test_memory memory_block;
>>   static const char __maybe_unused *prefixes[PREFIXES_MAX];
>>   static int __maybe_unused nr_prefixes;
>>   
>> @@ -64,6 +62,11 @@ void setup_memblock(void)
>>   	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
>>   }
>>   
>> +void append_memblock(void)
>> +{
>> +	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
>> +}
>> +
>>   void dummy_physical_memory_init(void)
>>   {
>>   	memory_block.base = malloc(MEM_SIZE);
>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>> index 3e7f23d341d7..8946a3b77f24 100644
>> --- a/tools/testing/memblock/tests/common.h
>> +++ b/tools/testing/memblock/tests/common.h
>> @@ -11,6 +11,8 @@
>>   #include <../selftests/kselftest.h>
>>   
>>   #define MEM_SIZE SZ_16K
>> +#define INIT_MEMBLOCK_REGIONS			128
>> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   
>>   /**
>>    * ASSERT_EQ():
>> @@ -65,9 +67,12 @@ struct region {
>>   	phys_addr_t size;
>>   };
>>   
>> +extern struct test_memory memory_block;
>> +
>>   void reset_memblock_regions(void);
>>   void reset_memblock_attributes(void);
>>   void setup_memblock(void);
>> +void append_memblock(void);
>>   void dummy_physical_memory_init(void);
>>   void dummy_physical_memory_cleanup(void);
>>   void parse_args(int argc, char **argv);
>> -- 
>> 2.30.2
>>
> Thanks,
> Rebecca
