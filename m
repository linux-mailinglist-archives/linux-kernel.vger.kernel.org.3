Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0613547A360
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhLTBv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:51:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:58967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237009AbhLTBvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639965085; x=1671501085;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+AV21kSzQ8QCiBdyC/xVOm6zCdyvpzOsSIUOCNzWvRs=;
  b=TbzTUOeUIAEP47AiQW3yKbKTLqgUNpFRwSWuNLGuZWoloSjoNmR/v4Dc
   p+TG62wcQHO3FyS9h+IgaoXVKlDN3umPEOMB7zZhsyGyJsSjD7NAm4AfV
   gtVHTdioQwUN4UwjAAzDXIpN1Syo/T6y0HdEJ0+0pB3QxnRCsVKbXzT4m
   0Kr9PMdvSD0v17v4k9RUsIWhFdMQUB3qW1Xm2dFJW1IchICN9BntNPD1b
   dxv0CtkaoowigS8Th9Ypj3JX78hrYoJgAzubUJEh9Z/+CjzzmhbIiIzwd
   h+a+uKuaXfYSmOCirnPpjENZd/uoscPG+g0ToRAhpTIcuwE9u9qxeNGhf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="220754313"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="220754313"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 17:51:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="547109418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2021 17:51:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 17:51:19 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 17:51:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 19 Dec 2021 17:51:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 19 Dec 2021 17:51:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CllRHcWRTpNGZ+ZiUMVaBxybp6W5RElff2ldTy/6RJkblVhrOTKO2XxtVnxBsbjaUAbOWN80Vz3lfYeziqoi4Zr8ZQnc93YETJCOP/5B27etPDzpwcR/xbv5wcbRdvoBiO2MJtIPDgj1Pk5R6YsMMOclRJncckGnvG4W+EvuMtn+dO8MmSMXnR29UsRUBHaoxil2S+Pn10CvJBYinbzLMyfcyQBT8V17NfXgMudTWk8Q3KYyL6pQQREyeslzAnwiXAsSw+QCnl0Lj5mo6vyy9fhXkzOH4GoSnfGUxeDlTKpw9adfNFQBgg2CPV8dwjUkIfi5P4Mb2GzqoOPxNryzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q892WJtUqTp546l5Xj64L/8YDg8GnnEzv8EQN0tilUo=;
 b=arLhld62q7+JdcCiX7cQIWrzmtYrUpkGLAZs1z4jsNL78yQ9ZhI4kbb/sW5baKCCDca07ftoucJGuEwA199NY1FyDjOQq0yfPIZ+bGcaxs/A01KYH6XACSpmgBtgg8NMeAeAePargspeW7AgebMeeGW58RVP46wCBeZ3QzK1n985ZlZyUxYkHRSwSBWuuQThqLGBhfR9QglOOPFEkDfTTd7vc55Fhp9a6011SLiDTC5vb6/3BUR8tOJebEbcPdIlqRATGm49rY13DIjxjRDckZN0cKSmqoR5Yb7o6uHVLrs6F49hD30cp02Y1lUerjIFfWD/9DsNVjmBVHX2Au0ZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Mon, 20 Dec
 2021 01:51:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 01:51:14 +0000
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
To:     Borislav Petkov <bp@suse.de>
CC:     Carel Si <beibei.si@intel.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>, <bfields@fieldses.org>,
        <llvm@lists.linux.dev>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic> <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic> <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic> <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com> <YbyIJYzqtHPKRMFt@zn.tnic>
 <b11156b7-e912-5b65-3b2f-4fd940727bc9@intel.com> <Yb2/nqfzu3VYo+bG@zn.tnic>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <5f5d8258-d468-c37c-e480-b4fb9a3eb91b@intel.com>
Date:   Mon, 20 Dec 2021 09:51:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <Yb2/nqfzu3VYo+bG@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d8dddb-26c8-44c7-bdcc-08d9c35b34c5
X-MS-TrafficTypeDiagnostic: MW5PR11MB5809:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW5PR11MB580992ADEA4521F7B94D34BDEE7B9@MW5PR11MB5809.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGEaSlqLw7Vk4o3mv+Of43tpF+Gga53myDsq0quL7g2GiNPBeibnFfR7bJJlfwAJZBQ54yExI+eTutKSJhnkWYwemEbdyuvNmdQD4D314CMTuzuuPRkPddOew7gXaeDAp2EH36+IR4bwP67551csLzctCTSGCO5p7/YE6JkwxpmW7ugEulBH0iRai9L551L3z6zFNmeaeOO1bpz26DvKTmrICB3ldNTLAyuf9u5XzLHeFgnHOLeU6tyNqdEHymPPKi9YkJ83R/ngk2es5Zhz9hiriCR5So4A9BSMrB2OINCBdhZf/sek3DF156RsIjxjNQW/R5IFoIoaZb50HglVvxj2FOOXzXuB9YDjd5WJgKKSGyiW13+hWjaW7ypvdvS+VSS4jxibJjpRUm1IwNBUPVV2tTnC0VNrbkyCf0PKXTqM9TDhtDiuz4R3g1OtUA3ylLcxCu3+rZCvfbSReBBWjhhsyCdNbu6XD2ZbhiqHPtuKmphsr1BFSBMhV6FGdU9UfBKDoweRyodQ0wu7kszLEQP3VPlIZQDh/2sXnVZJs7mfTYX98VRNKMMwGYRAd95vsVcV1LZAYLgvOjOuaoxWOvKDVgc1Ig4rqmNUwClW/+0KWTgnLqROhVb3h4epHpAKbI7N7W973qcrxaQvXX6KrJyfjn38aXZQvRSweEpGL+UlwdIQmcArsSSer66+D48Q9fxkGdRXLHtziN6lt3g7iwDgKlg4FJQMTKV1nAJFb5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(4744005)(6512007)(82960400001)(36756003)(6486002)(186003)(508600001)(53546011)(6506007)(8676002)(26005)(66946007)(4326008)(38100700002)(66556008)(66476007)(86362001)(2616005)(5660300002)(8936002)(2906002)(54906003)(6916009)(316002)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnZzdGhST1FkUXRpdTJJcGVoZGdKZllTdFpPdFpMMko0ZHBUbE8zOHhYQS9m?=
 =?utf-8?B?NE83dkM5WGNQSVdpS0xtc1ZvWkFIa081VFVaeG15QjFkQXZLM2Q2Qjd5bnZo?=
 =?utf-8?B?WlpncXRkMWJJdFlkYStZS2hHa1paMkdVYmd2UXV3bVhTOW5JSjdaSVk1SnVJ?=
 =?utf-8?B?QmljRUtuT0MxYUg2SnhBcjZkSVFjcGpBWFRKbXRCMzJMV1Q1NE5pSmMvSVQ2?=
 =?utf-8?B?TERvTVlRSzdHQmRLOE9RVWNWRTMyL2IzazE3UXBsUjR4K1lyOWF5eERLR2Y3?=
 =?utf-8?B?SUJ3aVJ0bDBnK2NwUUcveWtvUXBQM0tmNVVMdXJTcEMwQVltK09lMGc0dksx?=
 =?utf-8?B?ZFI1dlE2VGt0UUNUSGlsTHBucHFGSVRZZ1ZDUGpBZzhBRm43SG14cGNOVlR0?=
 =?utf-8?B?NmljWEJkaGI3RXduVllrMHAxYTNuREhZWVZUT0NHNXdiL25nTS9TMkFIQ0hD?=
 =?utf-8?B?dWlCVXBuVmxkaXRucGJISGhhQVhaR0xGY0ZLdi9uQUUvUFgra2xRTTlrTS8w?=
 =?utf-8?B?dVhzTmxVWmgyMlpkQ3VvRklxWElEcDRTREFPV3E5WFZ6Zm1EdUY0cndXUFFU?=
 =?utf-8?B?RytvTklOYlVKeDl1Ris4S2ExTXlMMkxMM1hPd1ZFZzRYUGxRem1Oc3NBWnNo?=
 =?utf-8?B?c1JiSzNxTEpwVmpmazEzbzFMOTFJd1AzWjBRaW1pcDQwV25VTTVZS3F2OEJB?=
 =?utf-8?B?RnNHa1h6Yml6ZlRlNXBhZmFtZk56bTNyU1dNK25paHZYNkpEYk5BTkxDbjRr?=
 =?utf-8?B?VmtIMzczMEFSalNNWGtpSFdZeUNpN1BiSWNoV3VEWklVMUZQenNYdXdOOWk2?=
 =?utf-8?B?bjQ1UFM0S3lDb1V2RkFYaTRMb1d5bWpHeDlBeVJBM080RXlITXE3WTRNTCtF?=
 =?utf-8?B?VUU1aU54THB4aHpBd3ZFZXpnTGk3bEhhMUxmZzA3OW5QbUxYUnhLZTUzWmR4?=
 =?utf-8?B?eVRzMFFhcUxTWHl1dlJRN3kzTmRnQ1Y0YnpMTXEwU2Q0UW0rWGN2SkM4U2M5?=
 =?utf-8?B?SFdnVk92Y1U5MHV0aFZabHlFUS9DRDR4Tys2NzBPeU5jRjdDVzRmUEJtbmZt?=
 =?utf-8?B?bFRmdm1aT2w5VERHY2hlKzNLQmd3ODMzcXE4TmhEemVOckJOaTRuUWc2OHJ5?=
 =?utf-8?B?Y1NHRFh5cXZYWTE4MXlKenRwa21vbW1kS1Z4TzljYXFoMW84T2dGT1ZGTDRt?=
 =?utf-8?B?Z2htcUxyV2VYRURRTHRqQlloMlhpSks5S00wZHNNeENXK3dXTjkyb1FDUnNC?=
 =?utf-8?B?L3VTcENyalYvb1hGSGEvYUxTR1FYSEMyZFpadjZLNlVuQVVlelZicTdid1Np?=
 =?utf-8?B?L1I2R2VpYjZSWnl5L1ZEMkFYbDZEMnh0QXZ6RjVVdlROVzFhWjgvM0E1WmdT?=
 =?utf-8?B?UXFvellqcjQrR0ZLMzRMUUZRVHVtTCtqOFBYZGRPVXBMZGNWZndSdkdhV2hP?=
 =?utf-8?B?d3Z5U2JQMXdUMko2TVI0T3VnSUVuVXFCRzl5c1phU2ZJNlBnRzd6alVNM0Ur?=
 =?utf-8?B?SWcrR01sMkpudm5CZjVtaEJvNnhqalp6SjFJTHBzS05abGp3anpqY0VRRkpO?=
 =?utf-8?B?UHJYZkM2cG05REczaitHOS9UZXB5L0lnRTd1bHV3Z28zdHpScnVWVlp4V05F?=
 =?utf-8?B?VENQTjM0N3BmSDVjQnFwVWQ4cFlydWI3T08zUEh2WHhVSGxnODZvNVU2TldL?=
 =?utf-8?B?L2Nnb0x2WngxU1dxeVZmdDJUZVRaUVdheGhBVFM5MDZ1amozd08wQ3l4Z3Fm?=
 =?utf-8?B?eTZObCt5TWlMdzRNL0hZbnNqNDZkbENtRGJvVElOZVg2Ykd4b0JRL3hackQ5?=
 =?utf-8?B?M0twZzc0S1U0aVdSRkZwQjBjdG1IdkZEUk82cEo2NTRFbFlDZGQ2ckhOcStW?=
 =?utf-8?B?WTdFTUpNOHZ4QmVCK3FUOGNKM0ZnejRzMzZEMis0UVlZYjZaN2ltKzYxTXFH?=
 =?utf-8?B?b0NrbkxRdklwVmVIRFk2M0pLeUlTczNrQXVxSnhiNENPeitqN2JMN2xlMDFU?=
 =?utf-8?B?amxFU2dyTDl6UjdyYWh2K1NzNklUZFovQ09wclNwMGx0LytxZHNVMTh6RzNv?=
 =?utf-8?B?WmVkQk5zR3kxdnBNcGk5YSt1K3EyRGdoVzN2QWtpR1RDZjNRc2dYWWM3YzhI?=
 =?utf-8?B?RlZjOEQxMEdMTmRJbUpjQ2k2UFUwQ2pyTlpSL3ZkRWtCTU43SUtrYXZuWlZG?=
 =?utf-8?Q?rje6oELftoZQ3x5zuBJ0VUw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d8dddb-26c8-44c7-bdcc-08d9c35b34c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 01:51:14.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WESqoC0eZ5Ierhjeo9Ze9drMwXR5nNi2K+JYDIIVFPcrOFvlZvaGB/qBKRC0xeXlVFJE4PMs8+YNJPXMcl+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/21 7:01 PM, Borislav Petkov wrote:
> On Sat, Dec 18, 2021 at 06:39:46PM +0800, Yin Fengwei wrote:
>> Thanks a lot for sharing this. Lessons learnt here. Will follow this
>> rule exactly in the future.
> 
> Thanks. And for the future, please trim your reply like I just did. :)
Sure. Thanks.

> 
>> I tried this fix and it works fine in my local env. Will test it also
>> in our test box once we back to office. Thanks.
> 
> Good, much appreciated.
It's our pleasure. Carel will send out the official test report on our
test box.

Regards
Yin, Fengwei

> 
> Thx.
> 
