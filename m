Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9706E4805BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 03:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhL1Ca7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 21:30:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:18827 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhL1Ca6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 21:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640658658; x=1672194658;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=51+Gxzl2eIYvWYwWseMGRHPdO25r3Y9FGCoM81QVbFQ=;
  b=lNcSe3h71s/2CuMPA9YVUi+BRkFmNtGIKKjzYAgsNvnIh4B8qrqYTqEm
   ZdiaQQ9UNMfKXB1R8RPhketCtvf5nRK+lcIH7HPCupx+ovrX0VoFecTOt
   WzXrL8gaJc9/mwEscWUvQ1dOWkPEkjAPqPuewF60fBm2egFwq3+pnfhK6
   PrjsHCWq7fsLyXj2sSeAE2kaK4pDBtXAAZsyC1CCO4rstxOSEHTZPw7Qz
   ORBl2EjIO+zPevD8Ahc1C2tQWqdFIBtnlFZ0Jb0Ik2sTqbPcgOd1JiNBM
   d0pMbICb5CAVVmmg9IsUakuo3DouCRFTUcMyaZSymBBdsGYAgVxep6tcJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="302053217"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="302053217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 18:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="572196650"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2021 18:30:56 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 18:30:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 18:30:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 27 Dec 2021 18:30:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 27 Dec 2021 18:30:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM27imHVltddvDFWno1y4GBOqnoFvGdYFkAZsnUN3LBW1JtIQk/xhA67hsh2+PKmlRYFptleZEWeYGaTBnKdIv8OJ06yTBzodF68Vsxjnk+eEWmhK+JCFVwpCy2nWBLD8Apa5/hp0F62qoFncyLXR+i59NiCGBjRIga4LZe09SNA8dEULr2Rggx4/P/lgzRK/8PGuS9wzNX6ajTAp1s2AQ7OP1cfXmVyrDho4z+ym6IJ80J5WNmpBH4HU4yVZ3eutanGsQbgCLIziT7kXu1avQNPnFb/Tt/9c7VUKW+elKomtwVq8V1u8vcd1ccSlyMPEH4QSDSc3EmI36p3nmqulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPt3TZguxDMfGuUcx+2U64iuXIkuKDRRqiJw1iN1RXg=;
 b=gp6IZIN+pJb36jNNLp7a9vPBIFPeo/LJjEzTtydN8ygxQuwaXYpt97X854Cm7UQ2VgTOb7W7EBXnvLjfaO31kbORw8ijAZTlGeb6rBNdcgkT/Sj79XdJKHl142O1xFOInY4Bac2wjflTyeyh1dfzPE21IBT/pColBqjr376pTK/85xIO085uTR1mAjwFO+2HuRYVTsI/7vYjVANnV/SIxeTXBTQj292YuVRymbyBt1brjGFet1BMt/CgP8YWtYoxz3TuFoNmgrE1JFBpjFhXogv9BzihWabdlNB08TxMEWAltSqfByzfoCWTAxY3kiEmZMDJEVjnKC9Zywivp0G3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Tue, 28 Dec
 2021 02:30:53 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%7]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 02:30:53 +0000
Message-ID: <27973649-193d-a485-1ca7-983a53c7cf78@intel.com>
Date:   Tue, 28 Dec 2021 10:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: RE: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, Jens Axboe <axboe@kernel.dk>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "Li, Philip" <philip.li@intel.com>
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
 <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
 <BYAPR21MB127067C16809209C019BC83BBF7B9@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <BYAPR21MB127067C16809209C019BC83BBF7B9@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e054199-d152-4c39-c48e-08d9c9aa120f
X-MS-TrafficTypeDiagnostic: CO1PR11MB5123:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB512354DEC6F26520B8490B74EE439@CO1PR11MB5123.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q+P7B0FfnXHxz719f4GKXgSDufi7tpg4uWrp4fwFaujAyEdG/3VYDFRsAFJ1e9Kvdk1g4f3qZxKDOH1Cm/xmd0WGl2I25jHhRvsrZzXXkKo8Nm4HxBdsfYtVA3B1KdlxdH2+du1FQ6399Qxr9CLa0rzgyCbLJwJX0DIr5qk9DIBvfwnJGXpcNfUzAnXOXTlytR031260Jaj3zMmOTsNFSTCHITluv8gKeAhSfi9PSsfNgih60Q1HutVkuXObQRWeodC08ul6XZPoH1cJIj5nur2ONFfwJz/TxEYBgb1ZG6RajGRyLAjIM5pRF7AD4V8SrZ5X9ZU5/eX8zadxv7I+SRuoL4yt2bjGoEayK16XoecfOlnI2/33UsV9UG/Lv3ABR6sTMWLyvVCp3boxM2zlPJOVU7wGJTHq+QvIS1X3ad6wnW5XnYY9SyWJw4izGRBGdpyh0sdYaSjSPK7CnAjbyPSTL/y1LT7xJ6WvZLjfu9C7xZugPKAukAklJEwiYjHwXa9izYPr68qhkcQg1wqO91BAlAVVueJFpLiWu+4xLsXYdXK3eS5k0v4KIB0hqjSU1GpIB/ahAXqTCcZD0iVSaI0bwPFgBMkYesg00rK0K9rmFs8cyqD6QTSOsP7ZGAs2VwC7YnsZ84fLtoBxQL0r53kdLdCuRASfyhNI4+Nhoi7idwAmqlqCgsrD7BAQCvKL5CBQ8a9BaWScQmg2xZ5Bywu8FAfo7SyDLyjEQWoQ+1qm8qdgSAvs+Cbk1IYYNnI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(6636002)(6486002)(38100700002)(110136005)(186003)(8936002)(36756003)(316002)(53546011)(2906002)(26005)(66946007)(82960400001)(66556008)(6666004)(6506007)(83380400001)(8676002)(921005)(5660300002)(66476007)(4744005)(508600001)(31696002)(6512007)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtmZ3YzTk5TdlI2dXVaNVUwTFNjK3RYdDFvRkkzMnFTYi9meGFCaUg0alBO?=
 =?utf-8?B?RXVLN2N6Q0ZpRlZZQVRKUEZNZjkzOWczV25yS3RNblI4L1dRUk5hT2p3anVU?=
 =?utf-8?B?T3pOUGN0VUp2VWtRcjhaMXc1Z1V4Um9vZVBYVHpvOFZpTUo1V2prOXhESEVr?=
 =?utf-8?B?bjNaM3JpV1pZUkF1M0t4cDg0ZU1mbzlQRmZnL3VnWmhEbGI3YWpja2ljQ1Vw?=
 =?utf-8?B?d0FHOGhKZkZ5ZllxZ1VnSHVid3owVXZnS3RjKysyU0tELzhQQmpublJIdE00?=
 =?utf-8?B?U3ZRL1dQakJTTmg2WGp2WUppMlJSeVdpWDhCOGFFaWN2Sm05WDdEQ2lOcm9w?=
 =?utf-8?B?bkhiaVZsZWdXZXVkYkV4QktWVGZyTUw4OGx3TVdjUytmcXlOMHF5TEVXb1Zm?=
 =?utf-8?B?Z2JrWkROb2NJUFU2SHV6N2pIMXhOMXhhT3k0UUxnTGxjMDl5SEVGa2NGQU93?=
 =?utf-8?B?WVdJdVVhRnlTWmxVQTZwVFJLQ0Z4NTNhZXNuY0I2ME5jWkRzdENRSlR2a3By?=
 =?utf-8?B?NEk4b0p5d0g4QWxzNTN4THQ4RXpxQUxoRlY2YzRWc3hiWXEvT0IxeS9SUHBa?=
 =?utf-8?B?ay9MbjFSTVVZR0lDS1B5RkxrRnAxTFg5VUdaVEh6bEUwNUZWTlVGSnJ5ejRs?=
 =?utf-8?B?SkE3RXpXQ3dHNDQwMytja3VGbk9ndVp1d0J3OWdwSUlnM0lRdFMvVTRJcnFJ?=
 =?utf-8?B?dFBnU2p1L1ZpM2JuZVZSMFdrRDRlUGtwQnU0d3pYRGh0dmdoVFpmQnhPWUli?=
 =?utf-8?B?bmRIWmNHTDZhQUhWUUttakk2QlRnUkxiT01ybklJdlVWSnk2NnFFYUVtZ0lU?=
 =?utf-8?B?UnM2VU50eVlxakZLQlNTNE5vV0FGMXNkaFBmMDZ5WUNvU3ZSbnpuNzFOMENv?=
 =?utf-8?B?eVBUQ3F3WWJsa0c0NW1VZWpRRitOcUc5M1NBMW5OaWg2VzhEbkFuaFFSaEQy?=
 =?utf-8?B?VWZ1K2R5bU0yRHFsSm13NjB0VnE4QUROQWJ5dVJ6RzE0bnZYY3lnQnIxQ1B0?=
 =?utf-8?B?dkJweHB4OWo1Vnh6NzhIYjJlNEdQSkNmeXBXcjA5eFdrdlRpYksveDVBS0pR?=
 =?utf-8?B?RkJSUTZNcVZ3MW5CTWdFald6eGVRNzI5OVM5OS9BMU1iZkpxYlJ1NWZwTXNC?=
 =?utf-8?B?NlJ3WHNESE9vdVNBTk9DelV3eFNRR2NobVlGREN6MlREZDBGMEM5YldsR05i?=
 =?utf-8?B?aEUxZFhuSWp5ZDVyYXNXQ1QvbXEyaHRWSUR4cnpnay80TTFPWEY3R0ZZenIv?=
 =?utf-8?B?SEN6RVZhMmZXdXRGSkxzV294UEJJcEpIL0hVeFdTQldPVFhXRVRVRk5SeFZJ?=
 =?utf-8?B?c0c5bVNabExNVFhTVTNMYVpBb2ZGMXFTa01GbWttU1ZIRlFRWDhCdTdqeUpz?=
 =?utf-8?B?RTNkSk5tZWtiUEJaaE1uNlN6QlY0RTh5RmpKaXZZL1o3UHFtSWlMM2YxNTd0?=
 =?utf-8?B?Uy9jNTFORUdINm9KQndBeHVKNWhrak9CN2NWL1NEY1VtL2Y5MVZMUi9XY05l?=
 =?utf-8?B?bFNzSTNEbm9FRmcyRmd1L082N3R6djNaeUNCKzY1Q1F5b2VySFUrQk5sVlB0?=
 =?utf-8?B?QnVYRjQwZXYzTVRwdUJIekpENDRTdFJJbGtrTkRsZE4zalgyNisrZXgreGUr?=
 =?utf-8?B?OVQvanNveUZzSExzVGw3bU81c2xoNktsRTNDbWVXU3o1K1d1cnhEd1FRUkxn?=
 =?utf-8?B?Ykh1dGF3eExYWGpUTzZzd0dFS3k5ckx3NE1wd2g5U2lNUmJZZVI2cHE1c0c4?=
 =?utf-8?B?bGZjRWhvRVdJalJxcjB2M1NsZ2praGVGaDBWYzQzM2V1czZvUkJmbEVheDlQ?=
 =?utf-8?B?SVhBbFlwTDZQMERZdGptYkEvd1lNWkNvcVRKRWhxWXVSQlgrRmR2V3lUTlFn?=
 =?utf-8?B?ZUZGd24wNGtvM1JUV1Npdk5QUWhvQ2UxVm9SenJxRHRUb29iaGRERFhKNndJ?=
 =?utf-8?B?Mkp0S0J0MGVaREE0MmE0NHVVR1ZBY3JQZ0dGNi94bm14akpaT3pPaDVTM011?=
 =?utf-8?B?aUtvNlVZWGxaNFdJejA1Y3UrZkZDMDN6REc1VjlWYXJDQWYxVFhXYmdMMGlN?=
 =?utf-8?B?b3B3NERHTVd5T29IMGJDRnprOExoQ055bEhHeXFTTGpSS2dZaFpvQmhjWTVh?=
 =?utf-8?B?K3I3N0lWV2JRc2xYVS9vdU5pZTFRbWNhTkFZVnJjQ2lJRnZZQVRVRU1FY21Y?=
 =?utf-8?Q?rnMID3FOrt0OTtaD7uimLuo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e054199-d152-4c39-c48e-08d9c9aa120f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 02:30:53.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10V+u5FKMlqfYX49aT5d5aQl0ltbwRmAiR8fBgMUpn8+Rc8KjoY13lgyZwu9l+6zoFxIKtNb+5tSJR46hCf/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Dexuan,

On 12/20/2021 1:15 PM, Dexuan Cui wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>> Sent: Sunday, December 19, 2021 7:28 AM
>>> ...
>>> Dexuan, can you test this for your test case too? I'm going to queue
>>> up a revert for -rc6 just in case.
>>
>> This one should be better...
>> ...
>> Jens Axboe
> 
> Hi Jens, sorry -- unluckily I lost the test environment.. :-(
> I pinged the user to set up the test environment again, but he's
> on vacation till the beginning of January.

We hit this issue in our testing env also and will help to verify
your fixing patch. Thanks.


Regards
Yin, Fengwei
