Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8D501FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348088AbiDOAmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbiDOAmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:42:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728FE13EA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649983180; x=1681519180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JHI6WIU6yj9Jo8/UvXK9UDuoKvfr0+A3mwMkQwohhgc=;
  b=bxBxCztlZpK52AJiwqBcfA4S46WdByCepfT712DbFU0WsmgL+sqQfAjT
   bRLjtQwpkuU/v0xrxvvxdoW9e7BkahznBkIqL09od82kZlmytP5xQkOGz
   qrpNsv6qSMryAcQWN3JgO4UHR/d4Mjy5XAuovCQznDTMKoxJKvjJraVgk
   9VWvE5Dcn9WYQphqVUPF8BTBnPOLarEeMlicP+eKrHRzyBQze1E+VOjHG
   fTmhXJGpFNFT0dqSSw/dfNp35WwfPcuCbo7kRFDvZmWT4yOaXAjESfU1t
   lxG5/NbMNt4tNsbof704hyEqaJqs81smUQ4ZGPGija32F3P6HqYJPKk3u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="242997207"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="242997207"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 17:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="661587335"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2022 17:39:37 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 17:39:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 17:39:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 17:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOJObAPIlEJ560WhDLDhesnNkJLD6wyUVxJX2atiNDPaHnKPt27d1g9/0vSvN8HsZCoAk1cTsAysaKu1/X9BsTTiGSQmM74mVU4NJ96fQX8+Z7y7d3PFJ0F3p3Num2xa0qQMr70kXlGQ9Ndx6Y07Rtt0Ovko8P+1iHNaIiPL6mnGRIH/bk1Ext4qz5P7GFKlY5nS7oRzY1sD/lWJujTO/bXqbW1qjzZDmm7vz59+qAT1ZbnnEUtQkdKB9DqViSh5+RKwVK1CubMCbpzhij80gy3/bsghsY/yIM3WgeY3zH7jKON0e2s80kCejfSCOFnnrefaFEXfx4p/LzB6f4Kazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHI6WIU6yj9Jo8/UvXK9UDuoKvfr0+A3mwMkQwohhgc=;
 b=bJp9XHn+cRauOTZiTgohGG98A9vvPqvE41VTBEpKIdGwZJwsa9czBiiq7IDzMNZjnFL6Eo1UOZa35G+y2I+HqNHL6GF+tmT7IpSW93hxw4LAn5kDppUb2endjoN3eTd3pDm18tBVZKh7M42U7U55wM6nVHKi1eBxSNTmCPx6cwgNIVkouG5z1uZYgN9zEPXKDmF26MTp38k+4d2W7S3YyzNF3mIwvqGMqM4u/sxOEHS+MQH/rwpW0MeDWo3d4a8Ytwkkw/HxYfypteb20C4DeR9UGJMzBSaX2T7InjpxsGO8uf25hMj9C5pYW9I7DNxLRGgy8NFvPWwhaQcI4uf9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BY5PR11MB4209.namprd11.prod.outlook.com (2603:10b6:a03:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 00:39:31 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b105:318:79c9:1606]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b105:318:79c9:1606%9]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 00:39:31 +0000
Message-ID: <1a5228c3-4ab0-0e2e-0d93-15ca9a90f1c2@intel.com>
Date:   Thu, 14 Apr 2022 17:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v1 3/8] firmware_loader: Split sysfs support from
 fallback
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <mcgrof@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-4-russell.h.weight@intel.com>
 <346561f8-df45-c3aa-a6b9-1328abe80e8f@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <346561f8-df45-c3aa-a6b9-1328abe80e8f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe9b8bf-482a-420d-826d-08da1e786759
X-MS-TrafficTypeDiagnostic: BY5PR11MB4209:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR11MB4209F9276D779EDBCBA04ED8C5EE9@BY5PR11MB4209.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNxCTtpip0RRndfkSTCFvkwyIcOs6HdcD43IHdnuac/mEgPv3+DanXj9G4jOuw1hVRAka20K1Hr+kQ958TUY6lLx62KecbvZujOW1wILsPpX/faW6eR9uGWadKNHxQEY+yywRhNmse7yaQl/qxVglohABY5a6jA9nr9u6UROcP4BlvZ6laVZth57DaCsGEWermimPsE21WZwYFmvgnM9XxfenjhcfyUFRbUYBBcAmHC6Y7RH09v64+NUmtwK4yqLdPvxYkpjMu/+ixwxWK4rRGMzrmwZv+xklfGu9y4i7Iw/abBFzx9IuetqqvtD9gzlxFXDEO76p3wOWQpPSpWgH//qhOvj6F6ydTD07eQucnQf327/W3ERulSZCguU0Ch+QshaYVO/XPgUr2C1DKsUy8BOXBJmbTp0KnGnDZlB7WExerde7DwFw+Rnf3+RY4TRsNb5+Zpr9uose2LpxOTwM0tQIsQoLokLuBbu7TC+rlTESBW3pm0MW7uglicqnU6Dh6lTptMF4l5jooJrctwiWMUYyLmRpowUBc8M3w+UWxuDoo/6pckIy+sr8cYqDJp6lk4c2oE7YLwRT6g7XXqjHAfkhVTsJKIfdvFU2D/EdYFvKivZDdi6PVqfzDVYeTdvWdH03Aloog4e6ZgbmridN6WTHgRwRQZyMhsCEbgB2LCxvrnos9lYFgq2OUzLNqbNsl0jzqa8cUKzY6RHKR7mkkR6D8tLKyOaZjAmDEQpRPATNDfmBfnP5ppDwY7gs62D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(31686004)(6666004)(82960400001)(2616005)(107886003)(6512007)(186003)(26005)(6506007)(83380400001)(53546011)(2906002)(66946007)(66556008)(66476007)(38100700002)(8676002)(4326008)(31696002)(86362001)(5660300002)(508600001)(6486002)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MncwTDVBMVE2MVRYUG8vOVZ0ODJwZllTTExVbVhXZ1lZckQydkg3NmdDUHRl?=
 =?utf-8?B?ZURhQmJLR25sYVlsSlZNR2RrWWdGUFVqSEVob3JPUGIzU0RwUVJBaXVzc2Q0?=
 =?utf-8?B?SEJqeFpNK1hscm5JU3NlMExhczVobDJINjlZMFl5aU9IWFBjc3BnblV4QXJK?=
 =?utf-8?B?cHY3bzBWREp2SGVGVnF0L3JtM1VsWFhjRXlzNTI2RE9JVmRBM3pMM0N4NzBB?=
 =?utf-8?B?WDZSZzBrYWpsdEd0QVJrN1NhK2drSFFxTUJFVW9JbSsrTTQwc1ZiQTcwNFJM?=
 =?utf-8?B?SWFSMXJjRU9CenRISmJQMFhGdWJwam5ZaEJ4VGhuQi9kUEUxYmg5ZzhzRnBy?=
 =?utf-8?B?MFdKZWwwelo0MG16U1NUZThlM0NlQ1YvT3BBZytBVVYzaDYyUmtYNzA5cExy?=
 =?utf-8?B?VW90cnJHaVZSNmZqVS9uMHNweVlTZnJCYkozN0RVUVk3dDlNTWFCeUxKb0Zr?=
 =?utf-8?B?Wi9ZZnVySDJEM2k1YjY3N2g0UGhDSkUrQVQ4bi93eTFPKzFHMXB6RnRGNzNK?=
 =?utf-8?B?WWxYRXNZb1dQeExaZjhKNFdmaFYyWTNaVnhoMXhjZnYrWEhxSkRmNEVvbTFi?=
 =?utf-8?B?U0thN0RHVUlOZ2c5VVhJWVo5d3Bhc3pORmNWdGZFUzdacUhOeGNvOHdaYzFs?=
 =?utf-8?B?cVd1OGpRazdiY3IvVjlKNDNoWWU3VTBPK3pnTGh3d1o5dGpEZFVJaUtaeEho?=
 =?utf-8?B?Rm91SVNPNUFRMTQxQ2Z6Tjd3N2xLR2tTaWVYSkFoRWRQSUN2dXBhUERUdnBm?=
 =?utf-8?B?QkVmY0ZHLzFWMlpncWdiMDBFS0h1cXU3SWlmeG5aSXRacUdCSUJtaExtaDZT?=
 =?utf-8?B?dHdxMi9PWlhTUnNiQ3NiYkx6NlUxZjVnNGJZSEVFSDZqMEFUeUxoSmx2MXhH?=
 =?utf-8?B?RFpyZk5IbUhZWCt1QkNwd09IS2VSLzZYMkJZbEk2K1Q3WWo4dEtHMWNPc29M?=
 =?utf-8?B?UkJvcjZIMTJiVXZNMXpwbmZ0TlE0bW5CVlcrQ0FFajlVS3paUXR3SWN1d3lG?=
 =?utf-8?B?b3VRNHRaUEt1cS9lT0l1cDhjSHE3S1dHcmxJaWRDNFZ2RS84SjFnM01EU0RX?=
 =?utf-8?B?cXJIYk1CYklWTndjcVNHTEYrVGdmYWdJTVFtb2twV2xqTXhldk5IRDJKaUpP?=
 =?utf-8?B?YzNDOXYrbG9TUkpCVkJOOW5sZWVKcTRjQzlONFNMQWtLSlB0SUJvZkdJUDZh?=
 =?utf-8?B?cERPaHpWUmRuc3czMFhyZTlYRW1IYmtPWng1eEYxbmlVOGJ1cmxaeHprTVFn?=
 =?utf-8?B?Z0F1V3psRjdRekd2RDlDNmtTTGVtZFlicWp1UmpKWkhIMjhGSEJ3Y2xJcHg2?=
 =?utf-8?B?STJhc1M1Q296QXNZVE5SMzRJK01lTFRBMzYwUUNOcG1nNlRpMEs3bGRrVXFT?=
 =?utf-8?B?SUFONFBrSkszVVpJandDbUVYY0pWQjZuSzBKNmJsMnE4ZVduM0JJeGJCQVJs?=
 =?utf-8?B?L0xvTTZKc3RzWjhMMytDdjVaQk91YksxVmlqM1g3b1hLdDljS1c5RXZWTUdU?=
 =?utf-8?B?VWNCdEQvWkg1TEZsYzlYa1BhV0IrTEY0eElGbnlNRW1PVjBMblMvZEdFVlB3?=
 =?utf-8?B?RVFxZ3puREFzb2dMR2cybFB3MUg1VTlkZFFoZWtQcmtGeE12YUp0U1VZZHdC?=
 =?utf-8?B?L2lrY0Iwb0s5SWs5K0ZOTnlEZ2ZYdXltUFo1NE9lYlpLVXdiL2xUNFNOTDlG?=
 =?utf-8?B?Q25rQ2tWZTVxcFBiNU9McmVoMFRYR1VleUxDTnRJK3YxTGViTlk3aG9Cb0RJ?=
 =?utf-8?B?c1JiQVRIZ0ZHYWFRejJMUmpxSmRDOE5CK2RxREE5a3J3N00ra3ZlcTZBRnpI?=
 =?utf-8?B?a2crbjcxSEVuMi9lQ0Zaak5lRGhybHdOYS82N3l4S0RXbUZXNEk2M09jNTFt?=
 =?utf-8?B?bHR2aXZPaUdQYVJFZURhZzNsMERIM2FOR21Ka0ptTWliKzRJRG5NWWpxdTBY?=
 =?utf-8?B?cHVmL0ZUS0Q5RXlEcVFvYmQxVElMM3lWWTdKVEZvelJ0R2Uxem1RZVRiMXhI?=
 =?utf-8?B?NGIzK21CNFJkUjhVS2FyR09tWUVuWnUxWlVYVVNYck16bkthMzJ3Qk56K1d1?=
 =?utf-8?B?dm11UTRERjVNTzhvOEFtUkhhenp4YUpUc3FweDVoQlVFbXp6TUt5WjRUa1hy?=
 =?utf-8?B?RnYrcXlkR1BsME9HYWVFUDZUQzI1b3d1UXliOUljZkdrS2JEY1lZQjJOWHF3?=
 =?utf-8?B?SXhUUGRUd2ovZjFCTkduVkRXSVJIb2t3bDlGM2lkNklya0FvT0ZON0JtcG9C?=
 =?utf-8?B?NzlsVlY2dVRicFU5THBtMkxGNlkvRVhVVDRqZW1KM0ZrTy9QaUdCc2kzVW51?=
 =?utf-8?B?UGlvWVZNUXNxUWJuZERNNkkyWGhYUHlDR3pSdS9LTjFHeGY5RWVJdUNiR1pS?=
 =?utf-8?Q?f7OJSuHdsz/YScPs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe9b8bf-482a-420d-826d-08da1e786759
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 00:39:30.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDWXdM1+CRYdWo+Ex1jPBy3IDlcBr515L0XyUZOxMBZQ9mdJTgTuvnIoayRUv0s1eepnnr4cScPDxTrEMo7zwvcvpoa4BkyejIEBH8H2s9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/22 08:15, Tom Rix wrote:
>
> On 3/23/22 4:33 PM, Russ Weight wrote:
>> In preparation for sharing the "loading" and "data" sysfs nodes with the
>> new firmware upload support, split out sysfs functionality from fallback.c
>> and fallback.h into sysfs.c and sysfs.h. This includes the firmware
>> class driver code that is associated with the sysfs files and the
>> fw_fallback_config support for the timeout sysfs node.
>>
>> CONFIG_FW_LOADER_SYSFS is created and is selected by
>> CONFIG_FW_LOADER_USER_HELPER in order to include sysfs.o in
>> firmware_class-objs.
>>
>> This is mostly just a code reorganization. There are a few symbols that
>> change in scope, and these can be identified by looking at the header
>> file changes. A few white-space warnings from checkpatch are also
>> addressed in this patch.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v1:
>>    - Renamed files fw_sysfs.c and fw_sysfs.h to sysfs.c and sysfs.h
>>    - Moved "MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);" from sysfs.c to
>>      sysfs.h to address an error identified by the kernel test robot
>>      <lkp@intel.com>
>> ---
>>   drivers/base/firmware_loader/Kconfig    |   4 +
>>   drivers/base/firmware_loader/Makefile   |   1 +
>>   drivers/base/firmware_loader/fallback.c | 430 ------------------------
>>   drivers/base/firmware_loader/fallback.h |  46 +--
>>   drivers/base/firmware_loader/sysfs.c    | 411 ++++++++++++++++++++++
>>   drivers/base/firmware_loader/sysfs.h    |  96 ++++++
>>   6 files changed, 513 insertions(+), 475 deletions(-)
>>   create mode 100644 drivers/base/firmware_loader/sysfs.c
>>   create mode 100644 drivers/base/firmware_loader/sysfs.h
>>
>> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
>> index 38f3b66bf52b..9e03178eee00 100644
>> --- a/drivers/base/firmware_loader/Kconfig
>> +++ b/drivers/base/firmware_loader/Kconfig
>> @@ -29,6 +29,9 @@ if FW_LOADER
>>   config FW_LOADER_PAGED_BUF
>>       bool
>>   +config FW_LOADER_SYSFS
>> +    bool
>> +
>>   config EXTRA_FIRMWARE
>>       string "Build named firmware blobs into the kernel binary"
>>       help
>> @@ -72,6 +75,7 @@ config EXTRA_FIRMWARE_DIR
>>     config FW_LOADER_USER_HELPER
>>       bool "Enable the firmware sysfs fallback mechanism"
>> +    select FW_LOADER_SYSFS
>
> Is this code reordering necessary ?
>
> This config is not removed or renamed later and has the same configs are the later FW_UPLOAD.

FW_UPLOAD and FW_LOADER_USER_HELPER both select FW_LOADER_SYSFS and
FW_LOADER_PAGED_BUF, but they aren't exactly the same. With the split,
you can have fallback.c without compiling sysfs_upload.c and you can
have sysfs_upload.c without compiling fallback.c.

>
> Maybe leave fallback.c as-is and rename FW_LOADER_USER_HELPER to FW_LOADER_SYSFS because the name is more descriptive.
>
> The 'sorry we suck' help message replaced with a shorter message to indicate this is now a more capable config.
>
> The later FW_UPLOAD would have a 'depends on FW_LOADER_SYSFS'

I could, of course, leave fallback.c as is and add to it, but then you
couldn't compile in the firmware-upload support without also including
the firmware-fallback support, and vice versa. That seems like a
disadvantage to me. Isn't it better to allow a user to select these
features separately but have them share code if they are both selected?

>
> If you end up needing to do the reorder, move it to patch 1 because bisecting-wise it should not depend on improvements in the current 1,2 patches.

Patches 1 & 2 are standalone patches. They could be accepted
independently without implementing firmware-upload. They don't depend
on the code reorganization, and in my opinion, they are easier to
understand when viewed before the code reorganization.

What do other's think? Should I keep all the code in fallback.c? Or is
it better to split out the code? If I keep the split, should I move
patches 1 & 2 to after the split?

- Russ

>
> Tom
>
>>       select FW_LOADER_PAGED_BUF
>>       help
>>         This option enables a sysfs loading facility to enable firmware

