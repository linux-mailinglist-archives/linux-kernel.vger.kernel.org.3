Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3016D573BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiGMQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGMQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:55:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938E29831;
        Wed, 13 Jul 2022 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657731315; x=1689267315;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4OfcG8agJZEp2X5IajFsYj4gvB1kduclKQlW9qrtf30=;
  b=iJKXX8XB4+HjYlFU1/o6BqYhXcuYWDWQXavZT2x3D9VrOgtcmDiP/Tdp
   GcIyIbjm5SukChShRM1IONsk2pUU4iM3VgywcAhBCXe8TvD5cGeU4konz
   x/hWHEOuKlp5bKwd9rkA2g5giRpbbA/NonTDg+pPzlYDDOAE7YnkjTzao
   RjyvrO0aRirsppRjbkloci9lfNJs27RiYizHzjcTYYlnk+YNt5F+HizO2
   Q4KcRjlQAdQetZJ0uLdewykHjh8nrgfZaPECIWre2eak7hCyYavKuvinJ
   S25WnGbv5w7wbjOnWUSq+EVSWxb6qyL2GMRDaNj88A3ZFeTywhvg2m4JO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285307537"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285307537"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685237082"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2022 09:55:11 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 09:55:11 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 09:55:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Jul 2022 09:55:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Jul 2022 09:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4XQVYNMi8CIXb8JB6CTdIR9SnqMcsAtR7uprjIIudd01pMyvT3SmyOb65T5nPrVgH9QHw6DH7UJGccs0juhJBttUJLTc6GmpB/Z09r45c2JIC8jY/X12L+XDCeoI61WYYFaoqjhpilnjdrpgiGC+ura10gR6SLiquxT4UFJb/aS5lNh6jMZQfaKPBkt345GKCQAU2/l3k85M9ZMgRDiWKaHVwJnGN3BMPwJgwJ2GTrQ0vydR/XeiySUir38UQA86w8FuXLu4BuQeHomzB5DD1NxTFtk5b7a9+G9TDiTi0T8hNFNk5/I2ggabdTWmEl6f28a5Dmn5gJkdO0oOmYPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5dsP5L8MFaJXqpFcNNYpqZuarEh2xzqepOyUGkzVIk=;
 b=jdpj9FPo5A6xgXDCSz8WLDAsOfaZtdpYv18hSDTkwa50B7Pgee9X9hUjgu7/Att2WezsTuSIyKSxnyYMoDICbQITo4m4aCFQC9Kf6ZtUwc3I3mC3U4AGqbHTm0gYoy9/HGXR/sz1dfmpn4Uz9MkIKwnBWaCxfzGjQ9npa/7LF9+vqhZSA1hyhUV41z8bQSBKuE3zjOWp1UTUbcedcDFudpJ/nsK2MtT+EMiTTfd3TLlmyky6/QeTVBwrQpRYw9IAvKBIUBdiY3aUWubv5QXIRNpjTJMgviTisrGus5nDlD+0CiQNxmyjx28RxNqOCUb+C8OdZKjXEim1lS+0PJOqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 16:55:08 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::2571:e226:9e71:c544]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::2571:e226:9e71:c544%5]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 16:55:08 +0000
Message-ID: <9c311d86-303b-3673-a4e4-52f7d21947db@intel.com>
Date:   Wed, 13 Jul 2022 18:55:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] acpi/acpica: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, <robert.moore@intel.com>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>
References: <20220710045218.55021-1-yuanjilin@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220710045218.55021-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::8) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c16615-03c1-41de-ff68-08da64f07171
X-MS-TrafficTypeDiagnostic: MN2PR11MB4517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdbV7N2ecqJTu0Ftic7eZuKettegulU1uyLf7P+DdQ7+wGWF+439b9ymUpaNBRrLdPDiq0OSPykyXev0Hdvbo/MBXp2Q8D1DNHQIVHVa8DZEBjkzKGSor7/aymE7hOL5EjXI9CyivaDzUvz6op4nMDjFnnYfYtoRm7Vg5H70POc2SsLySr2FwZyhJQcy2ZKG4k9tab6SQkEWjd+LYc/1ITkslhF+b5+VLwkX3xwXBwHcEbJunhs6JtwuPKHThef+zEgLyl46ktzTV7K/Vd8RcA8UXYFCBjfRWOaoVOK5gVSEc9QxvEXFJh49ZuGsjYctyZb+ijX7WNXI3IBsFhSpgL8f26p6WrT5jj94/uMug+sADEQ8V08Upf/Rl2myepx4qn7ZAjxAi+Fp3VVphDg6nZkNWyWAmbaR9/CLeVgtwesm16lYslcLCruM2WkSNpT/n21o6HfPItPQu8e5ehGo5sJzmWKclbivJrFetV4jBFQpJVfXp5GDNLHoRzElUJV/Os0LlDeBROntxLzfatcQuEo62OV5LuNDEEvgPGSinCok3EWj2h+vQDfBVTVcELBXKIsVaAVeLgsZjd4Tw+F6tnfdJdTYR6mTVcMLjiFrPhRF4ZOwzTqQfJmKmjpxndQUsz2eFDVN7Z4WMBt7EVRL8eSwJVgIfxv4fEA5pzSLehXNHN4jaddjTaa3QX4dlTbZlITjYtK1OwbGDBK0IfUsjnR6jl/PcEtFz8YEd1M2s+HtQ1ugxSqARjPz+6kbHTE76IQGPJ0fkBNDaq7Mg+i4ahNTxl2K4h8meqoAWE3GIYbTZUVwoNvbNk8INhv0PKkKUl0a23zLuV8CiroYizxJ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(136003)(366004)(346002)(4326008)(6506007)(31686004)(66556008)(38100700002)(8936002)(186003)(83380400001)(5660300002)(82960400001)(6486002)(53546011)(2906002)(2616005)(478600001)(66476007)(36756003)(66946007)(86362001)(36916002)(31696002)(6666004)(41300700001)(6512007)(26005)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVZeXMxa0hlQVpYdWZnb3FtSEVnSlRXbm5HU3ZXZXRtZUJMVEpaSlhodTBB?=
 =?utf-8?B?NTJTbkJRdHVBU1N6SUtLQXZFTm5aaml2T3NtempZcERuZHl5dkcyR3JhZmpp?=
 =?utf-8?B?REI4U0EwbFFlQ1dWNHY4Yi9zWmhCMXVKbzlOKzQxUzNqOE5pRk1NYkFwTU5E?=
 =?utf-8?B?ZE1YdlRYMW9xNXRrVUtMRE1zMUpGUWF6Ym1icVpNcEZ0S3lIOEZjVWtUSmd0?=
 =?utf-8?B?UXlHc1BmVkM0cVREN3FpWHhpOVRnTWVMdUJBZ3EzOWdTWFdUczV0NFIxUDFZ?=
 =?utf-8?B?SHREQkpzN2pvdHVrak5lZW9qU1RLVXBNUFZ1VnVqNmp5SjNVZkhlTG40aFFt?=
 =?utf-8?B?NlVFS2hCUERMTU96emZpR0FhcldYVU1GVjh3b3dQSlcxWXh6ZVZGUTdxc0w0?=
 =?utf-8?B?M0FPSjNJbC9kTnVFazhsTFhVWVVhS1g1elNLaDY4dHppaCs5Z1hmYU1mVnZp?=
 =?utf-8?B?U0t0dFU4MnN3VThnYTNyaFVCOG0vZjRGUENMY09meUFaWkUwS0U2N1dQMHcy?=
 =?utf-8?B?SnNKdTFSdEVqMnNQZzJSS2VwRWt1SDlXZ2NFNGlueEROSXhuUENTZE8vSGxS?=
 =?utf-8?B?OGdhMEhaRVBSNjRCbkVONVJaSkc1Q2w3bFpNQ00rUXZrRUhzZEMxK3BqTDl0?=
 =?utf-8?B?MklrZWV6MEFxZEVsMkZTem9SMGovelF5czhhTnNWczZrTGE2OU1wNm9ybHYx?=
 =?utf-8?B?Z0xTZ2E4RWpQUm1GMkFFQ2szWUZtdTBmRWxZZHk4TElVc0g0MTlMUW1zVnVJ?=
 =?utf-8?B?ZGk5MlF4VDExN1EwMXo1SlBVV3hCMERWbTNYeE02aUErWkJKUDBzaWNxNmlk?=
 =?utf-8?B?dDZKMzZnZlBoeWtNNnZ5NENNK2pEOWY0UWZvanVCTlc2QXpwaGNreGIyaU4v?=
 =?utf-8?B?S3VJbXN1WTZnNUhDUysreXNXUkJmLy8yZmEyL052VW1lc3gxNXd3UUtFcTha?=
 =?utf-8?B?ODJTR1o0Vk9ZRGJqYlYwL3YxOU9SMGVZVlNPa25FT3hncU5qbTMyditUU253?=
 =?utf-8?B?SXJyZTRMck54emlPNlhLNHlPWVBuMkdHdFpDTEVHOFNJVlpGdjB0NFRIaWRy?=
 =?utf-8?B?cElhWjFHM05oUHUzVW1UdmVGS0wrbytuMWxxN0RzZE1rTkN0M2FJaVdOTGtk?=
 =?utf-8?B?SjAyVXUrZFBPWVBQQXFMaUNNb3A0bFBCVlBldk5hWVZjUnJKM3FTME9rc3pQ?=
 =?utf-8?B?ditIbnJybnhtV1p3b0I3Z1d0OU1Eb2xodG5tcWVnbHU0dU0vdTF3NW9IS3A2?=
 =?utf-8?B?cFdpUStoZk52cEhaNjFyVWRsMzNsMzlDWmlRdVdxOEI2MGZQS1E3M2ZTRnhW?=
 =?utf-8?B?a2NNNEtuU3FsTEQxRUcxQ1hWc2k5eEFDa0QyK29MekZtdURKTnByZHIzZXJ6?=
 =?utf-8?B?K2Nja29NcFRWOWtwTUdoc2dWQWZDbHRISEVvRU1WZGpWSXovbVducUdjM1lZ?=
 =?utf-8?B?NlNNNlkvdWk4MmJpWm9QTkhLWG9EZXNyZFl6Q0dMZXIranNkNjR1bmhQS0Fo?=
 =?utf-8?B?VFlia1RTWDFsdmNVQnBlYStNWXcyRmlPOEVqVzM3TUdySnQxeFhveEVwTGkv?=
 =?utf-8?B?RGJCWGJlVU95RDUzSE1iMTM1dDhCNndCTWl0OU9jN0FqWE05UFAxNTlLbzcz?=
 =?utf-8?B?cjZoSzhzNkdleXhmMUp6amc1YVNMVStESFcvM2lCUHAvVWNlY0NLUTRHeUtL?=
 =?utf-8?B?d2JXYzQ5NmhyUlJ4UUlmN2xnT0dYY3FzNzYxWnFCN1hXSGZINDNuSTdGNGZ0?=
 =?utf-8?B?THdEUDhsTGlYdjZaazFIcHk4bzFxeWltdzl4ZmdEZmQ1WHVqZWNvSzcvd0ZI?=
 =?utf-8?B?NmNqV0E3eFVjeVJsNkE5TXUwVEJNS2hJbk5XYUpVbU55NGF5aVd4VjRKVVg3?=
 =?utf-8?B?bUpGb1FKdURwY0J6V0RnTXN0cnNvLzIrSjFZckVKdklvMGN6UEJaRFhVZXh4?=
 =?utf-8?B?ZnNuTjRPQmhJOW9BalZGTU1BWExQTm9rdXRSSUpSV3BMUGttOFVmU1RNUEpu?=
 =?utf-8?B?RGsyUWh2Nkg5Ymk3dlYwU1J5TTZPQllaS1dMQ0hmTHc1R05zUktvNEJkMk9l?=
 =?utf-8?B?ZGVWQzRCcnU0R3NuTE84aDdubkk4SUc2WHVNV2hXeXFOVVFobGxYdXhndEg4?=
 =?utf-8?B?NFhiODkxWHlFZFNZeXZDZ3MzbDdKelhaUHhRbkgyQllHNGRlVklTdGxWMVox?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c16615-03c1-41de-ff68-08da64f07171
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 16:55:08.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov6z/4SgeQgSx8eeutdg6kijfRFXWc9w4Z00sh4kFHppMfK1T8mFwfD5p4cgcbAYH2PlRjMGdHXseapu/V7f2+OuPFTXBtxNhkEO2GKFzgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2022 6:52 AM, Jilin Yuan wrote:
>   Delete the redundant word 'is'.
>   Delete the redundant word 'a'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Please note that proposed ACPICA changes need to be submitted to the 
upstream ACPICA project on github.

If your change proposal is suitable for that code base, please submit a 
pull request for it in there.


> ---
>   drivers/acpi/acpica/exconvrt.c | 2 +-
>   drivers/acpi/acpica/nsprepkg.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
> index 8de5d47ad485..7a66a70fa974 100644
> --- a/drivers/acpi/acpica/exconvrt.c
> +++ b/drivers/acpi/acpica/exconvrt.c
> @@ -446,7 +446,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
>   			 * Explicit conversion from the to_decimal_string ASL operator.
>   			 *
>   			 * From ACPI: "If the input is a buffer, it is converted to a
> -			 * a string of decimal values separated by commas."
> +			 * string of decimal values separated by commas."
>   			 */
>   			base = 10;
>   
> diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
> index 82932c9a774b..2afc5baa325c 100644
> --- a/drivers/acpi/acpica/nsprepkg.c
> +++ b/drivers/acpi/acpica/nsprepkg.c
> @@ -540,7 +540,7 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
>   
>   			/*
>   			 * Make sure package is large enough for the Count and is
> -			 * is as large as the minimum size
> +			 * as large as the minimum size
>   			 */
>   			expected_count = (u32)(*sub_elements)->integer.value;
>   			if (sub_package->package.count < expected_count) {


