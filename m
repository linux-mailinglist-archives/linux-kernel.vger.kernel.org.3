Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2A4E9EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbiC1SLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiC1SLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:11:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA9CE033
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648490991; x=1680026991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ki2UseKoAuMd4Vbi4ddnrYXJjdxLlr3MYwAs0guVxjI=;
  b=PlXtb2CwD4dIRAb0Y+wqyJSxvr3k5MO18MtsmCAI0seQT0o3H3SFBkKB
   nYFg1GWJHZfMWHwDco6/CsFO36lZRHS2rM/8zCkNwVwuiSOR0HuUjlWAU
   YYFT6eK//Zi7Tf+G5tZlvAs9k6j9lIiS/BjDDMR8eG9eYyD/sNj2ZJLGM
   yCqCHrUauRsvWeKz5YUtUep1Re2PhyxvSs8hBvPSJpFO9TqyB25QncrBa
   0tQ+9SvE9IuroueQ9gJIm4fmlsgJVkOsr4r3tYhFImauy/lgs51rg+SiT
   49ptuHXhqaiLfB8GxkO5dHmL3XwBaBvnI2Oc2jM9an5bDJhBCXOB3kAn1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="257900608"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="257900608"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 11:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="719214363"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 11:09:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 11:09:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 11:09:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 11:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Pp6tJx0KMg1MwS8aShegUgO+IQ9TEfi55TbKYFHT+6pL9LXgjZ3bl7sODecMG53wDEX/jeoF67cvlAQXrktw/CE1FSkn+qPHXNdspnvTsa4n+EqTtyccXglOaCI98fHHjUgtQZcpFpfCyDKH+AkwMJbLa670W4iWxK0HesOY4Q0NbKW/V7kO20JjmaeuePkWcWvFK4j0glAVA3YtWPSGQtg71TDkDzZ7LmkXHVK/L2e3zqzDK3lyBNdYCENR16A7f+faiz7RlOBRe8mAZHqbsIo2gX77OUvZOHbZffZ3M3vGNmB5ZTGsJhFjkw3j3BtHORS2KYBzBroY5XQv/odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki2UseKoAuMd4Vbi4ddnrYXJjdxLlr3MYwAs0guVxjI=;
 b=UcLJdiuJ07SiS1M0RX5ENm8hN2RC9MHNfP1DIRdIAV6NaNQn30qKqvA07ncDVaDdJicNzCmS7H5RS3fkvXX3BbTL5CSKajKoi+1zD2Qzr26ZHPM6Rdqaop06u75ScQVCj0IECGrnoc2ehWBoPO0jCqjjC8sc8rcIlvokKI0BbNdKlKL8stGwlz17dgugPHVuGQe9ANipaYvgoZDmhF/RMhdIqJywMtrbWp8nXEn5Oc35SGUciL4bVPQfGnuFrn0kX2eoDiLTSUWlebwfF+Cgu0MsjEycLxwO+BizpCX36g/T4HT40vMxshKD9ZwK3Ib7mXI/HmjWYzsH1tU7X89NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CH0PR11MB5722.namprd11.prod.outlook.com (2603:10b6:610:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 18:09:47 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d%12]) with mapi id 15.20.5102.023; Mon, 28 Mar
 2022 18:09:47 +0000
Message-ID: <2bd89743-78b8-0e1a-bbda-10d2fedb863f@intel.com>
Date:   Mon, 28 Mar 2022 12:09:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v1 1/8] firmware_loader: Clear data and size in
 fw_free_paged_buf
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <mcgrof@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-2-russell.h.weight@intel.com>
 <5ec3e671-53aa-b8cc-1360-c454f3db277d@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <5ec3e671-53aa-b8cc-1360-c454f3db277d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0256.namprd04.prod.outlook.com
 (2603:10b6:303:88::21) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3df7f4d-8801-4b4f-0915-08da10e624c5
X-MS-TrafficTypeDiagnostic: CH0PR11MB5722:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH0PR11MB5722A9A4B2ADF0AB1A51B65EC51D9@CH0PR11MB5722.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5F6+nmZtZ9W4w0BLRwqg+ZVxtgYUfUwWxN/flHhSJT1tURf44mKZ5QnPab0yT4WVmJ0gEFji20OBcLmnisHvvdbEigsEIAjrtCqM780o0N2WVeP69OZ3rPYbYYz1VoCNUl9t+28kaWRuxs97EEb9OnDcHpWNYy6Rqir+OSMMRehVn2oKfhPOdTuTwzSeUPvvhT5v4KpF1wJUvMSVGgc3ZR2onXIwiuWzF+9E5eD7kIbfejXrXc0QmX8UMnz4hJYKKr1R7ObpqE/NTQFJwThR02W4JXlWjkQLd6N574KLJ0rTA/jKnVwOjvRxZapwziOqwEA9LJkidB3IQ001iP4vU0lnDzmrIfYGY4bj9NhonLDh81bNnK8BrQJEWZJVs94mIYyOx1+7EkjS0DKO64s6dEZd3XUOioB/PPNbgZFMFTaE1aRqcZVOaaNGSZ0blI7gZSBwAI3M5X6tG0dqjh96tJsvPuvTlCJlqcjefSA60R9XQYNSarUKWV4AJhllQXXfvPT0iKrEqHEJdzhYRWq8vTLtK0D21v62imCXRmDuByjgc01PFkO9Xmy1UPXMrqUkIIJc+AFWI3xdIUd2tPLiRvxhrltiuJ86OROkprGfiZZhG2l5LJJmKPiIK0w4r4WCNAYD01XA9z9wtrq6oHVVF+zW12nO5ITnH703aOPse3vJrpBYB1MStRWbb9/M469QuO6g2TTBCsX5bbPQhi//w8C7cyr8euy67O1/W9DN428Zd8ntAbjAA/VdhligmzF16Xav0mC+JgAdeRMuBhcNy+BzUx0BrU4Xa7+WuazcbbZsNzDPqJ40lWMIjSlcNEMzGBwoSjqnLMQi4zA7rOvtKUWmSZl8uCZD1ORalRCTYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(4326008)(31696002)(66556008)(107886003)(53546011)(82960400001)(31686004)(2616005)(5660300002)(316002)(66476007)(36756003)(83380400001)(66946007)(6512007)(6666004)(508600001)(6506007)(966005)(8936002)(6486002)(186003)(26005)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFMcGhsdXQ4MUpDdE5nWVRWWCtvR2V2SElRNmRrMHdjYStDVzhWcU8vUWhV?=
 =?utf-8?B?L0pDNTRQZW8zY01QaTFTTTh6aGhGUHJkRmgzNHY2QnI4SlhZa0lNNEpZTEtw?=
 =?utf-8?B?TWZkc1Y4ZDNXOERRdlBNeDllR0ZzWlRwK1FtMVhxL0pHb1NJTUZRWEp1bnpQ?=
 =?utf-8?B?d2pxUFNCOUxTYmt1MVQ0dSt2Q1d2TTZzazkrUWtxODBRWXFJWXpxSWtLQnlW?=
 =?utf-8?B?VDVId3dUS2pVTEtFVE90UWYxcGNDM1JpcHNDZzRBbzlNNUNveVdVdmpEbnRI?=
 =?utf-8?B?QlhTS2ZZTENCN1g1dXhyeWZ0ZSt2aTB5ZVZBZzllY2ZKaUhyNWFqUmtjWkQ2?=
 =?utf-8?B?YlkvNUt6aWpKK01nb2hpTlhMTXlyOGtUeWNIOFF5R0ZnQkdzYzR4Q2ZQY3N4?=
 =?utf-8?B?NmdZU0NuODlDOStUUTBrL0VVT0hjeGRIUTlPR1dsdkdma0RSY2ZhSGFpc3Q4?=
 =?utf-8?B?VXFQYTlyNDBDN0JPaThyTXduUHI5K3Q1VUhvd0lXdzBJbi83S3lRci8xNm5l?=
 =?utf-8?B?VlRmUW1uR3FxM1lPWlozWWZYS3pxa3R6NUpUMThMSko4ZTc1eFdkRitPRkZO?=
 =?utf-8?B?RnRsTml4S0RUV0VwZDhzVW1HdlJDOGZldEJUTWJGN0VDS3cyMnNINzNhN21t?=
 =?utf-8?B?MDJLZmdyTWtJOFVGeko4dTl4MW85aTd6SW9qOEs1TEM4U3puRng4VnVGbmJ6?=
 =?utf-8?B?RWgvYm1NWXJvaTdZNE9KdmR5Q250ZklzQkZId2gyclZsS01zem5DM3dDcENw?=
 =?utf-8?B?MlBEaXR3NElnUU1pSVdOYWJsUzQ5YjZocE92b2ZxS0NUSXlaMDJDd3dIN0p5?=
 =?utf-8?B?ZnF4U2huUXlwNFFwWU9nb0ZRWmVRaGhtdU1iZG81K29CLzBJb2Yva2F1Ymdz?=
 =?utf-8?B?Umd2OWtVZXpyRlFMdDN6c3JZcFhLb2o0cWdjUjdPRFVmelNYdllXUjk4cFNB?=
 =?utf-8?B?eVRpZlBLWlVRWVg5dWs0SmVRcEVyQXB4ZlhzOEhZMTdjMnZKRkc2bEh2SXlU?=
 =?utf-8?B?dWJwM3NvbXI4cGV6THg5U0g0VVZSVyt4RFdidVVidzVZaVh4K2dHcHg2NGxx?=
 =?utf-8?B?NG83L2lOUlFraEpaK3hQaVk4ZXhOOVY5dmd2TXRnQWZNdTV0aHpHMEdNb1I2?=
 =?utf-8?B?b2trMDJMbjg5cUhES1VwRjVyZjgxeFZMWGFKS1lJZUJqMWZ0bzBYbEV6ZE9O?=
 =?utf-8?B?ZFRubmthR3BzeGxrRytYSGNYbG9NM2EyRmRoWjZtZXRYSDFwcFMwQmEvNlJn?=
 =?utf-8?B?dm1EV3ZISjNadGJjSFJ0T0N4eGkvaHM3Z01ONjU2emk1MkNWdExEcTlOMkdp?=
 =?utf-8?B?NkhIbWUyaEoyckF4KzlDNmV5cHQ1WlhyblhMcm9VeWpBR2UyMnRVNlhpVjR1?=
 =?utf-8?B?U1NMRkU0WlJ4Ym51MXprdDQ3THpuZndBR1hxbEtqSXZSVC9ocXBVSTlocDZF?=
 =?utf-8?B?MWJYYkllTjRUZS9XS0xvNDcwdElpS0E0U1VEdWV3Nlp0a29DUWtJSjhaRWhi?=
 =?utf-8?B?S0trcGVIcE1vMjVac2NuVWhBQ25zTXFCSXZ5eE9Ba0Foc0RNRDg4aHF5cUxU?=
 =?utf-8?B?Y3pVT0FZM0wydytCOXVTazRNMTNpdUZ3NVlsQ2ZKSGpOZ0ViNllVVFlxQjRF?=
 =?utf-8?B?aHprcXVka2NSaTRyVEYzZXRwSWtqeUJaM0RxMmlXOTA3ZXhSM0Rqc256eFBC?=
 =?utf-8?B?bWYraXZjdERSSWloZitsVGJIdVFFcDFlMXY1WENjM3ZZYVdMK25aekVjMHdB?=
 =?utf-8?B?Z3A0RnJEOHVDcDg3UG5EMWx5NXZjTnJzZjJydk1DcWdNdFBtNFREbktJd1pK?=
 =?utf-8?B?bDd1VWgzRERiMVZZM0pLQ3BqYnpjM0s4K1lFejgyUklaVXB4YlErUjR0SGkz?=
 =?utf-8?B?c3RrdEliL1VwTEJ3L2dFUnlUYmxFNkZCa2NhMkVmeFhKSzNWR3NuTUdSVWJG?=
 =?utf-8?B?L0M4K3duejJxVG9lcEV6aGRZYk04clA2ZXRxbnFiRUR3Y0pYczhYbjV1aU5h?=
 =?utf-8?B?dHRMajROMHdlcHV3QmtpTWNQUVg4M2tRSGlDR1pRSFJuclhmZ1Jac1YweU9C?=
 =?utf-8?B?OUhkTlhCemxMWkFRbUFmVVpLc2x2STQwdnJSMFlBYjVpUjB6S0dVSnp3TWFL?=
 =?utf-8?B?bG14enRUSzJabzAxUHNGQVdlOGt0aEpOdGtBUGNWNHlPOUZDTDdhTlo4S0g0?=
 =?utf-8?B?UUxQVXhONndHeWxoOGlGakZXWmM5OEt2YmxINm9WNnZWZjlHSG9rS2tudWU2?=
 =?utf-8?B?SlhTb0wvTGlYS0Z5Zzl6VkwwazhOUFRsVFV5aithUmg2Q2ZNb1dZblJUWjFI?=
 =?utf-8?B?dmdyQjJCM0tvVllXTUdHS0ZhRWhjYXg1NVVwKzMrKzJndjdHLytoWUJaWHlD?=
 =?utf-8?Q?oIv7C3Gd/AMDyzK4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3df7f4d-8801-4b4f-0915-08da10e624c5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 18:09:47.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtiX0tOehc3IDL3+3+lfvXtrJV4xFfCE356z9qRqV5zST7Y6sQjVAQ/PEpvPkSNWxzjI65nVplmkzYy2bPx4JtoZUwaJVMDVEMi4ixAB5vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5722
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

Hi Tom,

On 3/28/22 06:27, Tom Rix wrote:
>
> On 3/23/22 4:33 PM, Russ Weight wrote:
>> The fw_free_paged_buf() function resets the paged buffer information in
>> the fw_priv data structure. Additionally, clear the data and size members
>> of fw_priv in order to facilitate the reuse of fw_priv. This is being
>> done in preparation for enabling userspace to initiate multiple firmware
>> uploads using this sysfs interface.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v1:
>>    - No change from RFC patch
>> ---
>>   drivers/base/firmware_loader/main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>> index 94d1789a233e..2cc11d93753a 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -253,6 +253,8 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
>
> Why isn't a vfree needed or realloc done?

The free and realloc support was present prior to my changes. The page
buffer support was designed such that if a firmware write was cancelled, the
existing fw_priv structure could be re-used for another write in the context
of the same firmware upload. However, there was no prior case for completing
a write and then reusing the fw_priv structure for subsequent firmware writes;
fw_priv previously had a one-time use. The changes I have made are to enable
the re-use of the fw_priv structure.

Initially, fw_priv->data is NULL. The "realloc" functionality happens during
the write of the data binary attribute here:

https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/fallback.c#L426

The fw_priv->data pointer remains NULL until all data is written and the
user writes '0' to the loading attribute. The fw_priv->data pointer is set in
fw_map_paged_buf() which is called here:

https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/fallback.c#L274

In the unmodified code, the fw_priv->data pointer is never cleared. My changes
reset the pointer to NULL after the memory is released so that the fw_priv can
be resused.

The new firmware-upload happens in the context of a kernel worker thread and the work
function is fw_upload_main(). At the end of fw_upload_main(), fw_free_paged_buf()
is called to do the free. This is the function that is being modified by the lines
below. This function calls "__free_page(fw_priv->pages[i])" in a loop to free the
memory pages. It also calls "vunmap(fw_priv->data)" to free the virtual mapping.
You can see the unmodified implementation of this function here:

https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/main.c#L241

- Russ

>
> Tom
>
>>       fw_priv->pages = NULL;
>>       fw_priv->page_array_size = 0;
>>       fw_priv->nr_pages = 0;
>> +    fw_priv->data = NULL;
>> +    fw_priv->size = 0;
>>   }
>>     int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)
>

