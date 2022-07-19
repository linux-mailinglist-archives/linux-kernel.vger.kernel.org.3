Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F55798A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiGSLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiGSLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:40:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E59A3F310
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658230823; x=1689766823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E4kVFZH0dGNFHLKSihfqRwz9VXbFDUMkahW0CcOWamU=;
  b=NU3cwfDiLpZBMzG4B4HQMIWfic512SYhsOCat5+D3ecabAxOLQGycnCH
   1VH63zNIZKMiuey1VA5jsva3qKr5kpRTlGtFg8Xf8Oiah2jUaMfm4axcv
   en6Bm3BbpAxO7pKtzOBIhF2wcX62YQc3IRlH5oymOdkaKGUn5tgqqmge6
   vUnR+k6Io+Zbwkqyk8ULPGRkDlj4RNv4/ypTAo8fHtg0+6aJ1gLaOBKeg
   +bckdyhb//m5D75iW+0EoU4P/gFR9PYee4Vv6WyyUHRcgiBfyQ2ZtBT5A
   4XreI+goGJgY7YQNKivpjTu08O1x0D2RkDHIb6m0fy6ZTulmPFykYyKrI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312154923"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="312154923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 04:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="572815533"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2022 04:40:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 04:40:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Jul 2022 04:40:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 04:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekWxvDLAy3r/MDecjNG/YaVifFQHeVpEKGvXfV8gb12Tv9KIdj4utCot69GB0zIxwNTY1NU+w8q14J6AH3JYPJhd/rkGuQSwVWnxP9QwuuJyyTOW8ZV4czYOYm1ZHz9pLbBn/Qajf9VZWxIqXFqT/PwDcQEqooHYmaeVUlSfbayzKoIVQnxXaaiFOQJZBw/Ktqu0MckXhgUuInqCwzwmmYHWDr3j2cPoPS/kh8hcs3lugohvkhPpNCaIKgHyFeZQaFXqad8MknySQv6c5/6wv+ijwdafxRYB8DEziCfgvcXmhRFSxXOvVA8SiRcTB0BGl10O84cLBldmv/H9H/7MPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/lQQYRdvqxDySNzIWHHwM9NV1X4W7l/GIzED3IRXl4=;
 b=eIi+OQNBkg6F4/p1qfCDknj8jPXgMVLuQMkS8Z4m6EkvmVrdep5TgVIWC0BWfJKMXb9p92Q+kjpVzYKYHU2nWrzaNB4iRutfXeKeLJjce4gqLr2/egs6j386adsomzWnzSdlo7I+JvCOEK7RxCUGyolART9djA02Y1W01637vQbqA8GneeoqhDVmJlDujq2mQGo7ncfiGva/JYF6QNlBux6j/yenmyh6gyby5Oe3InS9waJVllPDKYO4PEkEwdKGEhDx7XPRlRXo/E0Pwe0qCQjxaFofs3ox0sKOkuh1mwhgKe1ssXobnE8ClGafM2TDhxWY8tYl8mXED7XDEZzt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN7PR11MB2548.namprd11.prod.outlook.com (2603:10b6:406:b3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 11:40:15 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::852b:5f7:46eb:fca6]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::852b:5f7:46eb:fca6%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 11:40:15 +0000
Message-ID: <c4c73918-edbc-8cea-329b-51be967b26ba@intel.com>
Date:   Tue, 19 Jul 2022 13:40:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
 <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
 <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
 <YsnoH64cKCT7gndw@smile.fi.intel.com>
 <2c6a4a61-e6c8-0487-8d29-dc3fbb90bbe2@intel.com>
 <Ys2EFtNVL8ZALQ5Q@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <Ys2EFtNVL8ZALQ5Q@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0029.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::35) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e78cfb9-9664-48df-4824-08da697b72cc
X-MS-TrafficTypeDiagnostic: BN7PR11MB2548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfUGV1LjfqIHsTjAkO4QLVxZLP9We15D7fv/AXzPXXbCfL9gAUgY943K4A0QXBBwa57ZaZVnYiqgtFeJLI/8MZZYlybmo5siQAQMNZlV9pos0QDbnLU5Buh/611LMArueDCDMzMyJb9vd+8P9jPgu1jhxh+7MYAIC+VBAVg/Tf3sF0wCIPPBhCoogNgh1kUzyUtkNgkqTMYJXSpVmN0zUpkthp5o3mJVB9Ieek4+8QQ8/fCF3m8WQ0O/YirEgQ2ZwkozYWSAMmEnn54FrDCCthNU/yj4J4jLvXy4nJSo96zz9GX39raUgKuDsvjYonryf/8ion5yIZ77DJiuXlmnZURYrZSl4TPIfXZ/3oeeVSkloBrcnRg8rholt2M/GNl8EI1hULz4qtv0pFqrTJwl2emAZhwLoEVkzLUWElSMGNCEJJ1xX6kp74u+vo6S3VJrL2m8AY84g9rBLereG/ksimuISa3gxvb75IDetR5luWyV/RHTo4voJfILZ3ktA+lByTUwlHlTeHGGe7WUSYwDVlYNbSnLLdWymcHk3bemfs9DABdzj5kyLlq6PUKdRypJ5s99tV5y4pSnAJLrSEO+1gX81W/Js0Ri6yFCKZUBXBwWcGP01pdt5PlMHkNGJmaRfpZ5XQ4U1AnZvEMsD7EK3TDmMjM7k4sNYghS1fHrHfMsnqcOU4joc0WkVtuilew6nOk7TRzftLSWECCe0fuKMV7vVPJYLAGxqy/td3Lh+Wc3Z6R1HhCFarM4ucRd63ruOaFT+Fu1S9cUNmVX+a7R2nLrFLFCBd9YZVuN/GGsLS2SQQAxFZPviIQ1McqvtNEeRL3a8cwwHnFhR8DGsR6hhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(376002)(136003)(396003)(478600001)(4326008)(31696002)(26005)(6486002)(53546011)(66946007)(2906002)(86362001)(54906003)(6916009)(36756003)(6506007)(6666004)(66556008)(66476007)(83380400001)(186003)(41300700001)(2616005)(6512007)(44832011)(8676002)(5660300002)(316002)(4744005)(31686004)(38100700002)(8936002)(82960400001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0EyKzhEQ3RuazNZZ0V4MHMwK1dndGZCeGliQjVyeUc4dkJTVDBFNFpSdEZP?=
 =?utf-8?B?SnJyWWlENkdaQW1aUGJMajlHa0thV0lkMjJpVDlhMFZFN20zRGNqeGpvK1Aw?=
 =?utf-8?B?a1VoanJ2SWI5L0NRQldiWElVdVA4WmM2eDNiMWhVVHEvUzYycDhGRXczWC82?=
 =?utf-8?B?NzUvOU9Qb2FrUVRaWHdMQ2JadWkxTE5rTzRsbVY3WXZlVWtmdUQ1ZlB5VGpF?=
 =?utf-8?B?cWxCVFU4bTd1NTM4ZDZxU01NMnN3bjYrUkc1ZFpoa25Eam1JZGs1UjYzdnEz?=
 =?utf-8?B?ZUcrc1p6Qm05eTY4bmVyNGhBbEp6UmVFUGhWQ2R4cW1ncTRMa1BaTzBSTGRo?=
 =?utf-8?B?bHZkTzhSVlN4WTlKSlNoK2xUR0VNTkpFVFFHUVlzRDQ5WVJiOHloMzVNWkV2?=
 =?utf-8?B?REYwVWpNR1VuSi9HMU1TUmJ3ZlNINlYrTEtWS21WY2s4aW52aGxrRE42WHRH?=
 =?utf-8?B?bEg1QTZyWHZBZ2w5WlBXU3ZEUDIzMnF3YnViM3Y0TWF6V0cwakkyMHJiZkhY?=
 =?utf-8?B?U051bzNPNjQ0SmVJeXVjSmhlMW9NTEZXUFZwUld0TmU5K21UdzlINm13UXhw?=
 =?utf-8?B?ZUVVd3l2UVpFN3lRWnNHZnVTaXdVMkVJTnhIOWpLTThxN2RNNTM2emV5NFN3?=
 =?utf-8?B?SndWZnJGbjZBckdzMWZjS3NrOFlPclZ5M2pwa25mR0xsQXhwMlhydUdoMy9F?=
 =?utf-8?B?WThMK1pQeSt5SUIzYkd0KzdjOTFxRHVFaktvWHdSamdZUUNIL2JiZk1xRis4?=
 =?utf-8?B?bjFjUVdBVWxRdlpnTWRSNWpPZS9ZdmtuMHE0alAvbHVVdFJLYmo2cWZHdHgr?=
 =?utf-8?B?UlhSWGxYL1VmaUF5cUxVRUd0Y1J5alBzQzNoVzUrdDlQSFpVeHlnLzNRQTB3?=
 =?utf-8?B?bWt1QlpsLzRkK3UvWWxIMVVSNEJvQmZFWjJJRmFpMzVzS3k5b0RnZ21FWS8r?=
 =?utf-8?B?b3NrbTN6Vys3bmNDRnlWa0NzcVRCMFBseEc3dFFkdmhKMHF0YnIzeEpidmFF?=
 =?utf-8?B?TkVzU3BoaFRoWWEwenVza2EyZzBYMDA2NGFseU1GOUtnanRFODNBL2NsTUIx?=
 =?utf-8?B?OC9rVnZRYUUydmlXYXlyZmwvUlpELzFLZzYvSldVaXBDYkJuTzFFeVdmSXlE?=
 =?utf-8?B?ZElqYmNFNElZTzhicWdzN0lmNzJYWFJiTXl1Smt5d0hoRTRhK2NxWStIUFNl?=
 =?utf-8?B?NUZkVi83QklCMGpaUFdKTitnbTF2RDJ3aHd0aklNNjRTYkNRcmorVnNiUDMv?=
 =?utf-8?B?MmFZSDROZmFXK2YzWmV6L1hRcHlqdi8rVFJWYzl6UlllR1ByOWJBbXViMDBR?=
 =?utf-8?B?MVdtaXBhRXl4blZteEtrZERjczNYVlNMbktldEdDRmRrbFU3UlFmd0NVZW1Z?=
 =?utf-8?B?TXptdXFIZjFGcmpiZExrY29vNDBWSlladDlLTCtvVWlUd0gyaTlUU3JmSllp?=
 =?utf-8?B?ME9yM2pEU1VGcWE2Q05aUi9keTcrcGZhZGdyMkdYSlptTzE5YXI3c01QbzBD?=
 =?utf-8?B?amliZnREK2Q3Y1RtTkNtbnNNOWpOYjRjWTlWa2tMWnJ2byszZXNMeWJMdllu?=
 =?utf-8?B?d2k4VU51a3c0TDhZQVlGbkJaWDBxT3lsZmVxSlRKM1JzYllUMlY3dS9mU1B4?=
 =?utf-8?B?c0czT3lSK3dzRm9ncmw0d3FBZFk0N1ZzdE5YYy8vSms3b3VKbEVXM01QY1BD?=
 =?utf-8?B?UERYUW5ZNFFxZE5CK0ZlYWFvV1BNRm1TZWpoVXEwbEJtVjVNZ2huUVcvZVNp?=
 =?utf-8?B?U1NONithRnlhV3phNzAzZFNkN1JObkRtM0I4bTdVVDgvNU0rZHdQd1lpZks0?=
 =?utf-8?B?TW0yRVFwcDBQVk56Y2F4bjhSQWR2dlFaUDdjZGlhUU02ZDk2OXdJd29oaWNQ?=
 =?utf-8?B?T1hBblEySGozdlB5S09DaXF4Nk1nWk5aSVYvSXhBa3VNMFdZMWxhNmd6Z01O?=
 =?utf-8?B?clkyYkNMMWFROE9LTENoNWk5VnZHWHVsdWdlZzJpUWllSmlSQmxTZWZWdXpH?=
 =?utf-8?B?OWRpN2JtS09sbHIrVGxGdTRHMnFQUXZqcmxNOXZnazZFUm9wN2p4dVBRaDlt?=
 =?utf-8?B?b0NMZVVQMDNjS0xzSXZaeFJ3SVFPQ0FvbTdNRUdmZ1pnQTAvbVZYdmpQcVhw?=
 =?utf-8?B?SFl6dE5yTEN4SFBPRXpVeHFmaDRHdnZqNEJ5dmhXNjRySWhhcWZJb1VsTVVM?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e78cfb9-9664-48df-4824-08da697b72cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 11:40:15.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3uEmssJjrzuAe+uf9mwjYH30qK/pmugU/5m3out7/jZ+8+tfgqWsoL7IinCJRIZKVYTR7iQiHpn+GkUm4UqCONrOVhUJ5bX9H1fQLNqgyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 4:24 PM, Andy Shevchenko wrote:
> On Tue, Jul 12, 2022 at 03:51:04PM +0200, Cezary Rojewski wrote:
>> On 2022-07-09 10:42 PM, Andy Shevchenko wrote:
> 
> ...
> 
>> I still believe that casting blindly is not the way to go. I did explicitly
>> ask about int vs u32, not int vs unsigned int. Please note that these values
>> are later passed to the IPC handlers, and this changes the context a bit. If
>> hw expects u32, then u32 it shall be.
> 
> What you can do is probably utilize _Generic() which will reduce the code base
> and allow to use the same template for different types.


Writing to let you know that the feedback is not ignored, just my TODO 
queue is large. Will come back once _Generic() idea is verified on my 
side or when I have more questions. Thanks once again for your input Andy!


Regards,
Czarek
