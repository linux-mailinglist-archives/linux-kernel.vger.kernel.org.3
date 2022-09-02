Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841375AA90E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiIBHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiIBHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:46:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F494F1AA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662104805; x=1693640805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zsE8wYVh8AlDjh9PisMZmKbUdzOw7dnQsMSB3A7HtDQ=;
  b=iUIYPD73+aKk3IbHl6qs7KtEDyAY+1O9AMb9X0PqVMX8Tt7OC/P5EqBp
   jERaJRyP4CNNg5a76ppsBuvpeTfbvfo2ffCoR3hUZGa3RgFmLbPrs4V20
   sz7jq0bSN0koCo/Ic1jRDLpkSwKUk5M/I3jUvOVWPLYk9jBXru5hLeWpp
   kVZ8V+SGJR6r//m61z9Qid+9Sm6gKrCzo8lV9EM6TjlWCoPpdL+JH9+vG
   5nfSTU/zjUToRQt6GIC45jK+qKrrZ7KVgVJPSl3TxG83SYfSKxBXlnag/
   gFTUm+8ZCEj1jgqIsS5yYg8OdDz0EHvv6Yz3hvz5CKcrLjXb0dR8zFpIA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276325039"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="276325039"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 00:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="941195333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 00:46:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 00:46:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 2 Sep 2022 00:46:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 2 Sep 2022 00:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7Vz/U6LxUELuTLx8bffRIkVgIWYDDkbVxWmuOFDrZDHXVquQadJXxdnKAaXjvyYrqHqx4Z0ZBT9QzcV6Q8i0iWLP7G0zZroxMgWlQO+FutM4OFoD9v3+JhV47gpoZEpBywcjyY/FuLETOZLZi9q3JgVVc19uSmHLM79OaiK0JT4mKoWA1XMOWiDJAHXw1HjGO3MNJ3hUKbEF3LTVFs7aXD/hnKMIpLfkgdb7WWiVgbZjvV65M9Ye+pU2ZIPSMtdlznBy5SDbh7t9ZwSg8eX1f59ybiY9TCImZnTqL90hagQjrcRrIyS3bH4Zpxqs+p/uIdyxnGi8tHbZ8noHsenWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg+gjuTfs3tM9NcciF1Omk1E1EhBFptp8B67/CcWBX0=;
 b=bWBfCjfn8SrzyrJGrl1Q1y8Q0f1Z9QXB51MnDjjDOF4Dyrh2m3RExD7JgB1oYsY0kApDcE939WRpFiwap0H4IWji6rIgUgyjJLHHfHyP0m7SZtQtkmdted7OPcCu2UGPj1PYDp8IVOHpH961UreTE3BE/AnQ3jRkAuOEQf4zshSKdbI0ryeXPTsHI0uzxGBOOYgP9PU++IhJJHKsyjHRGbnQK3z3LG5T4PCKwdnUBwTayLb3aC4xUHw3yL2qFc1AI4wCkdIVwX85Od8CmK1Czeo8TQpuMjUzDIdr0G7qiv6/FBN2MiqAhTUq6thSnTIFopaI0viUOo4rJTHeGdZXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM6PR11MB4315.namprd11.prod.outlook.com (2603:10b6:5:201::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Fri, 2 Sep 2022 07:46:35 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::f9e1:f470:f60f:fb02]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::f9e1:f470:f60f:fb02%7]) with mapi id 15.20.5566.015; Fri, 2 Sep 2022
 07:46:35 +0000
Message-ID: <e8a06f76-9414-6391-0582-667cf817dbcc@intel.com>
Date:   Fri, 2 Sep 2022 09:46:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/2] lib/string_helpers: Introduce
 tokenize_user_input()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220901175022.334824-1-cezary.rojewski@intel.com>
 <20220901175022.334824-2-cezary.rojewski@intel.com>
 <CAHp75VfO7_ASHGdpkcb1dwvhyHPT31eYuAkCm2q7B+2WmtZC4g@mail.gmail.com>
Content-Language: en-US
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75VfO7_ASHGdpkcb1dwvhyHPT31eYuAkCm2q7B+2WmtZC4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: accdfada-df98-48db-792c-08da8cb7429f
X-MS-TrafficTypeDiagnostic: DM6PR11MB4315:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/5iEsn1cOS0rAHVBE2aZi/9vU2b9qEJnWl4E/Qr3dc9otM4XSoFjLjlbQRaoDCCksQoxd9BC3Z8GlQ0npPaGGwnDFon6xYBbyI5vhgsHeWLPS17O/gk8Yo9iPWlKUyn8QuF1SIP+6Ht9vHSTq37/Z5QGf0lFCw/jNcXjnpq+AEJfUxoM1mNR1xIzShlOSVftWaHBegMC1+FMiubuE6Eb6Uy55K01BfB4qDI8Ef5drgbAqTGawzENe8RZ+RAomPI8jYzid6xx7n7fDccP7YNDbDxzzw/RMu7wMzJBg112RlIBIKdetAvjcWWQhpqmn0Xe2f3x6jLbROf3MwLTFSZUxjaIfA2Ff7Y2wOxOOL8lYHElzYvYKusOsaT7JCxxUKuvg/a3i1c2jwcidaSbIykW/PK9B/4APfybOmyq/UbG4nWBGX7x4TZhRi73K2WDqah5troJdJOHxaWwoNMSmWzxGUHapgH/cc7Wn+Swm2a8ktl8ZUU8nO4v7pE0PXVGa0P5cdh8/qILMVj14xMIAxajWV/MSuUKvz07XQTUK+b5PafRsC8ZhZ+NKifRDyIkqos0SKrvGBrwBqbbLujbywVbek+eJ+BkO+rtKCV9R+1qWXZWT394XS6H7jM1nTGKO04GkoPTD4SopNynbBncgUlhY7GyIcZ+NEwbGVB0HTPJwixCvoOfY7PILhqpPXVQghIWCGYUU5rF48ubUkhinQJ2O3mSO1nOX7oyKrTl0IaeQ5rOjz8Vg6ClVafgmMZ+71sSfm5E7/AJdFsoBPifaJEO4zG4nAtXkkao3aw+CctUNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(376002)(396003)(53546011)(83380400001)(86362001)(36756003)(6506007)(38100700002)(31686004)(31696002)(186003)(41300700001)(2616005)(26005)(6512007)(6666004)(478600001)(54906003)(4326008)(66556008)(6486002)(316002)(66476007)(66946007)(44832011)(82960400001)(4744005)(8676002)(7416002)(6916009)(5660300002)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9rdEJJTGllQjM0NzFLWnFXcEhZeFQwUTM2ZStja0F0WUJWWFVNYzdYMFdK?=
 =?utf-8?B?N0VXNnNpTlo4QmhOeUZyQXZyNnZVdmxXSUVhd0dvWDBBMlIweFNhSVFxWWFK?=
 =?utf-8?B?dHBBUVAxMVNPQW01UWFlT2IwS2QxSTBsWWFQMzlWYnRsVzA0dk5ZUkxBQmJG?=
 =?utf-8?B?ZGM5RGY2QkRSV3kzZko3eHlPMUNDZ0RabUVuVkM4RDV2NVllUExGajl1WDZq?=
 =?utf-8?B?bHZvZnRuYysvdVJBVXFCMStSanFCdDBtdzB6R1JqTmZ3VG9wZnVWNjZMR3NU?=
 =?utf-8?B?ZGgxaXUyL3I4VGZXRVJlamk1UmdqWWFRUVJFRXBadUIxNWdnczhqZnJGYlB1?=
 =?utf-8?B?SXFINkVoRzd6endKM00xNXBSL0FlbWN1c2hHTk5YTDRTblFEdzZ3WC9seVV5?=
 =?utf-8?B?bUIwa1pTODNkZTJjWWFFZEgyQmV2RmlQOCsyOCs2UGdrNDlURmRDNHdkQ21B?=
 =?utf-8?B?QU1WR0dvTUc1WitkZTNTU0RZZllsOEUvNzlmUjMxU2NZZ29CWGtFYUFJYVlG?=
 =?utf-8?B?OXhwYnBCOXpZTnJXdGtBVWc4MWJJWTBmV1pXeGtsUkI2T2NKcXQ2bnphaWxn?=
 =?utf-8?B?c2RqYTRuQ0cxNzNZQUhsVWd5YVptL1ZjMTUvOElsTHNMVy8yN3grTytjb1ho?=
 =?utf-8?B?Uy91L0lFcUhDNHVueXFsWFhPQXp0ZmhEYWNGMGZadVpyNzBoVVlqQlZOUEYv?=
 =?utf-8?B?SWpDS2E5Y3dtaGw1eFZlQ0k2aEE2WEtmWG9xY3l4dXJQNFpjLzREMUh5ZHNz?=
 =?utf-8?B?MXluZFVpOGVMOEVKYnY0eHVGQTR5MFJIbVJRQXZ4M0FvWDhlanhYRUxoS0RC?=
 =?utf-8?B?SGxWbDlmQ2o2dTl1WnBoaExod2lSeUk5WVZLZmk1eFhiNkxCaHdNUDlKVnRp?=
 =?utf-8?B?blgvNm1jcER6U2FsSW90Zk9XaUtFaml1ekVJaDFZbnJJUDJkTnZWVDY4dlQ4?=
 =?utf-8?B?Zkc3ZzVNU3BSV1FjSG45REZsREF0SzArVkRXODBnVEVYeUZmZlVZaTBQOWJz?=
 =?utf-8?B?RVR4U3hhLzhVK1ZtSHArbUdNMmdNVTlMaVFCUm9VcUg2UE9oak9WQUlIckxS?=
 =?utf-8?B?aWtHUTNKbG9SVkVqSGNGUkJRZSttTU5HbjdjVnkyQWhxSkc0S096NUM4VjZ6?=
 =?utf-8?B?MGRGNkJBeDZJeldRYURNVG56T056RE9lcjU1YndoajVRSk1iZTYwT2ltZm52?=
 =?utf-8?B?K09DdWZjVkd2S0lQU2xZcnloUTRmSUFTZzJZM1JuVFBhcUJodDRJYmpaU1hz?=
 =?utf-8?B?QzZiajhENFN6ZVJlOXpzaHZ0a0t0RHZYK1ZSNWhWQm1DTm5Hck9kbDVualEy?=
 =?utf-8?B?UU1ZRTRZd2x1Ykx5WUZPclhXdzlnY0UyNlhzbXVXeEc2cGxLSHUralRnY0c0?=
 =?utf-8?B?QnlwMnViaUl4VDRqRlN5ajl2SGQ2MEpNTm9MYW5aZWZic1E4WVBDZFh2cG9K?=
 =?utf-8?B?NS9tZUo4VzNSdDdNTmZqc1NSbkdBd3FoWE5OcllsRWk4Z2pYMnVKVnNBRlhB?=
 =?utf-8?B?TThzY0xWVEszcUZnRFBUTkh2K3pCQVFIdUVyd3BLbVlaNEVsQTFTSldoS3gz?=
 =?utf-8?B?eHZocTIxdUhBeGVEUHpCeU5HTmZ0bGVzVE5zZ0JVRDlLNC81RzBydmlWejVM?=
 =?utf-8?B?dUhRT1dBczMrZS9HNHplYjJhSHltRGNxRDhPWDQ1NnlMNVZac0lRQWkrKzMv?=
 =?utf-8?B?d3RyTUl4cnB0YlZPdUNoUlVaNE9zQWVGUFRoT1BNdk9kTHpocnplR1BmRmhE?=
 =?utf-8?B?UVBPZXlqMnB3bWZodzlIWUt5djFPVHU2ZmNZakhTNDh6b0NCNzQ4TStFcVhh?=
 =?utf-8?B?SGhZVkJ6elFucUlRRVYwaHp1eXcwMytBL2dOTHY1WDVLSlQyTWpFUGJLNngr?=
 =?utf-8?B?VUtUSnZxUmVTQlhOdEFaL3UwZzJzdDYxRFdLU0J3OEM3SVRLZ05pV0tkK0xy?=
 =?utf-8?B?NnluVlZSN25QNnVQKzBXdmNqQ0dZN24weFZNR3owQUZ1cVdDQ1phc1hTeGpj?=
 =?utf-8?B?TklYWHB1c2U3SUpmK1ZSeW9XK1htSjlNbjVnY0J5ejZIR3Z4c2ltWCtHQVVM?=
 =?utf-8?B?czdYb1FUcjhVa1g4MXNkZDYyeXFxUXZYcnNQYW9NTEtFbko0dkVkWWZQMGJu?=
 =?utf-8?B?SHo3RXFNTEsxcHpUb0dFclRKcFdXazhjeE9YM1FMWmUwUlRyL3BFWUZPSzV4?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: accdfada-df98-48db-792c-08da8cb7429f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 07:46:35.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV9LSzCb2zk/99kJEQszRqFlAFPSPeDb3vB5aTvb8kEaZoTUz8yRRf9xXxEuOdccb4Twh8WGGw2LhLVKEUklQiQxOqsVjH5UozxNK6CHTM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-01 9:34 PM, Andy Shevchenko wrote:
> On Thu, Sep 1, 2022 at 8:40 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:

...

>> +int tokenize_user_input(const char __user *from, size_t count, int **tkns);
> 
> Not sure how I can deduct from the name what function is actually
> doing. Suggested new name: int_array_parse_user().
> 
> int int_array_parse_user(const char __user *from, size_t count, int **array);
> 
> (Note that we have _user suffix for many APIs in the kernel that does
> interact with user space memory)


That's why I've added '_user_' in the middle! Anyway, I guess the 
expectation is that it's a suffix - precisely at the end of the name.

Could we reorder it a bit: "parse_int_array_user"?

>> + * @tkns:      Returned pointer to sequence of integers
> 
> array

Ack.

> If you are okay with this, you may add my
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
