Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F44D3D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiCIWpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiCIWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:45:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4792EF9FB1;
        Wed,  9 Mar 2022 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646865871; x=1678401871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ahs0jX9WkU8p9c6I2zbZubArtuWpAPWwcw9WbBJsZiw=;
  b=Os3GLOQB08vLtGn11J+3Ed7MvkUIWN1kl7h1WhB1u39m9oMGtWSsAJqV
   F2nL8drtn6ukUTemJRkuhdxuXbFr8r5RfX8IAbUMGkyaf7/7M5tORSrrL
   801VpZh682DXOZuZhpt2GlT2Us3yn/zt7n4SHe4M5lIgvAUny7J8ev2KD
   Ns4WhJCT/GD8BwipjbX3wHnPKZJhYOETL5VvRtzZ854dx/d3vpVse1A+R
   aAjHQTgZBLKB4KuAsmD8BW782JP1A3ysuml2RdyYRJ620ZORbYmB1X2Qg
   9/wZIFvsFawLR1RaNNXi39avyJr7DYiQ7fBOlG22zniG7DHSSgYmRGKbH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255296200"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255296200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="815240507"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2022 14:44:30 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 14:44:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 14:44:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 14:44:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 14:44:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duOSXR7CA130YWZEjE9jpX2qpIs+4tPQJY6IoyMjW5RnhXH7AijR2Tj8NIOfB7/qmuVmy0QBiHdNNUTUQxPOBzG1oQnVHx2Uf9CUCEg3Knrynaz/UC4lRMXvtPdQ9RuPL3DNvdy1cOswgHOfWSFtk7x7iHe4e2DK6QH6LlEsATaSgUcbRHrsh/OjNlpqsSINS44OpslXeop3NWU3SqcCL3DLkjpvct9oxrVtaZMHhIDIEGFCLvjC8q/01qAz1ZEpialIAYO3pc7s00Kkv25Olmngk+UNE1il2riapFZT5S1sht2YXEThds5yZYwjwn2yiaKX/AO1Cab8xi6yY5ix8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6pVzHL6QW263ljAmDLFd4s9u6+X+OJI34WPGJI70/o=;
 b=oMgjqjXC8roq+t53N0LldtiqLmiwWOTcftODzfYiyzfgWGYU2tGJyUxQNpL5p7tPO+TmzCCuLEWm6Pp8M/8TQSqk4uWtmXYw6exchdkAM5tk1dXYUNoi7v7vs2UreQCw/aY7O/Kpij1a7E6Z+MlxyFd6NDuHSE8hcLnN657ZLXhs8YLuoSALvEJzgj1039/X5IOekvt6ZaDSrlSXC5yTLjgzidbXwxng6hdXRMYoq2ZbCGZXVRPt5zdk/n/Wf1oiguxlE9d93wepD6lSPSRIhhu2OvDIYMiPgY9czuuVmexviPJigN1JVbDhsB3OLaSkPs8qhMrO8M8u0/B+WySFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by MWHPR11MB0046.namprd11.prod.outlook.com (2603:10b6:301:67::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:44:27 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:44:27 +0000
Message-ID: <35279bb7-e986-9c90-3751-4758fab2f2e9@intel.com>
Date:   Wed, 9 Mar 2022 14:44:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 4/4] intel_idle: Add SPR support with AMX INIT-state
Content-Language: en-CA
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
 <20211104225226.5031-5-chang.seok.bae@intel.com> <878ry24qpb.ffs@tglx>
 <0B7F49C0-B850-45BC-BEC9-60DF3E2D88C5@intel.com> <8735oa4ipo.ffs@tglx>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <8735oa4ipo.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a300a0-3e51-4753-33a9-08da021e5de8
X-MS-TrafficTypeDiagnostic: MWHPR11MB0046:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB00461CB4B4236229AF47D31FD80A9@MWHPR11MB0046.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8o3cnZWnsHq6iodJnr5EFvrX2tWQw/w5Vy2wpNMz0WH7dsxeX2NVM7Ew+yZjRO2JXdTOH/95Q85DXz+M5etZzuHTw1V7CSmApHYaK2WGNNBkH/Y1PHmt4LZ99pxsbQ0DJ4mkMTwR+p8OOCmLImGfHQwab34HbJY9YWkDidJMKtPVTsMjYkw2kIE1JQVE4TuRqFVQVBk0bAULhGNLNgwfZCuNLxN/gjtrG8Zw6/o1kGLPFO1mV1qD1/Gu7WYAbT5BkMMQ28Mn7BYkEGjqf87kbKHrpvD7D22P4BSdEeS1nabV+9/c0+4ScHHJT7oZvjztgcCekQds7Cblh8soLbeHOxqen1Jm2NvlRt74r0nbLIN2Erxm1xBR9Ar8AsgWD925IT3vOqUQ0iO2olEDe3MbX1p7RUI/22avdY16MQt40FMfamZC2hC0j5u03Oc72E7tUcneY30MlXMfGaEFh2zmE/y9+3mq7jmhst6nm1f1wf493o99W00576fC87BRdXLpjmJOZ58XnbhV5VyeZbLgzZUSPCjylsuFC4pYi/Byazp3sZCubTXUbkEv3QoquRHAHJti7pzGo3q52S2r9L1YOGshzzKaBxpJnRB0jgBn+k8apqe8wlQtkjNAb1SFIMywkpsOXmnQaSTAZH54mXPBUcGJKDPinVchvh3Q6F8RUWSY3fZg1dWm1rORz/yfIuN6Lv4Ac9pETV0cS9/zGwBx8746H/LbTQLjxW1jfwYfWr+FD/HLx1peJOQWQD08Duld6zkx8Upk3iXzPgjr7Qmai8kFUQZiG+Vg8HpPwXgSDC/2gNivZEcbSas6H9Q1/4i0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(2616005)(8676002)(31696002)(186003)(82960400001)(26005)(4326008)(316002)(86362001)(38100700002)(66556008)(66476007)(66946007)(4744005)(54906003)(508600001)(8936002)(2906002)(6916009)(6506007)(31686004)(6512007)(36756003)(53546011)(966005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlBd1lIQWpsUjhvUVcwbHFnd3FjZEZ0bjFPdTcrdzhjaDdNRjBhS0pqYnhz?=
 =?utf-8?B?OFNhS0RHQVN1T3JoVk1xTVo3VDJueXVGdXU0akYzbjA1Q2hNS0g0QW01WThu?=
 =?utf-8?B?MDQ4ODI0TjFxc1VIVWYwc2pnL3dETHN5N2dwMHNNMXlMMkZ0all4dzNOczB5?=
 =?utf-8?B?MnBwNXpOTTdEVnhYWTc3TXA3bU04OG9JUlVQa3Z5bEtLdzZtdUYySkVNdXNX?=
 =?utf-8?B?ejJpdCsrenphTlB3ai8zcjYxMVV1UFBXbjgwQTJMRk4zQ0ZlaUFQczB3WUlG?=
 =?utf-8?B?MXZsV09jenBxd2twRlBiTEpMVUoyMG5JTFJyR2pFWGJ5YWxFZjgzTXREWEVu?=
 =?utf-8?B?N3BURzBIWHpNTlVTaW5QSVNaOUx5TkJRMnNQMVRRektiNTE3THVxWFFGT05y?=
 =?utf-8?B?MFR6TDdWMkVkRnBaYlF6bnozK1R0aFZPMVp6d1c5VDU4ZmZhbTRoY2ZQM3Bu?=
 =?utf-8?B?MTBrUE9yWHdjNU1teUhIVnYxMSs5VWtnRTZUUkV3RVZ4TEZITlEzY3dic0lF?=
 =?utf-8?B?QWVOa2gwbWNCcTI3RHNuREt0aXhrZlRYeHNHMjNzM0JQUTU0WDQ3eHdKU0pr?=
 =?utf-8?B?V08yN0pDaWhsWnMrUXJyeUNKbldWc3JVcE9lWTRBTm1IQmtPVVhPUGdZVHhV?=
 =?utf-8?B?aVcxbjNlWE9HT2Q2T2M1cTlheHAwU0dBdTJzaDVFUXYxdVVpVlBBU1VqUmJ3?=
 =?utf-8?B?SWVQVG1xaTJVU1BZQXJZSkczc2Z0TzIyN0k5KzBrVTU5M0NoN0hXOHRzbGp5?=
 =?utf-8?B?UXpMRDRTb3NlcVB2QW1xRzFnMS8xaDBkR09zNEMrUlFLM3NmWXQ2bVRTYTVO?=
 =?utf-8?B?ZEk4RHNBT3BCZWRtOWJrTDJlZmF2Z2FqSDZuckRuRXVqNDNDS0xJNFlOSFQx?=
 =?utf-8?B?U0tpYW5aTm5ORW93VWlaZkMxaXNlUm1qWlk4dWgrRjg0cXB6bVB3REh3dThx?=
 =?utf-8?B?cGI2QkFENUNNTUljRUJHMWVLcTh6MUtiQ1BrWTFZMW9SWHVLcmxwdFdWSEFr?=
 =?utf-8?B?eHJCaVhqMFdYa0dMaVdyVld5Q0gwNUJKQ0N3Q2ZZcGh4eitBRUdTM1B2aWMr?=
 =?utf-8?B?SGE3S1M3L2Y4OUU5OFhvVEZSRjRVY1VSWjhKLzdkOVkxNDh6ZUQ4NGp5R09o?=
 =?utf-8?B?NGkyZjF0MXl1QTZrU1hvRGtXMThuZi9rbkxrZS91cXVLOGpPd1FYQ2Y3bHNy?=
 =?utf-8?B?a2lqT2Q1UWFub0wyQUtTUmtTbHc5V2JyTHNkaTBCamZRSEJiaEp6Rm80eHZS?=
 =?utf-8?B?di9LQ2p4ODM5ckJUVHVKdFZIU3BXbk55RmFHR0RQZTVLTDVpbXVCV3JraC92?=
 =?utf-8?B?TERmaVNGOFY1NzY3cUU1TnJqTi95WHlNTHFKeVk3QnQ5V0FHVGJGY0c3S1BC?=
 =?utf-8?B?cjVFUWxhc3ZxNWkxNTNYSzRRdmF6ZW9Bd2cwaVV3WHhZZGRQbjBMU2thS0g5?=
 =?utf-8?B?TWRlRkwxQTRIUDB3dW5RNHhYdWorM3k0NEl6cDV4Ry9UL2ZLMHlrMGc4MU50?=
 =?utf-8?B?eTl4WlF4N0pPRTJxTUwzQ2ZYRi9nUnVma3pzbHdMYlFTdE9uR2FFa0VvMUlQ?=
 =?utf-8?B?a05HNUJmMlpHdkRLS28rMDN1WmRJUzVhTnZmMUIyYkRheHJMWDRxVDlaTEdG?=
 =?utf-8?B?UjlIWHdTaEN0b2xldWRuUGRNTTIzN3oyL0QwaHdDbEovVFoyd1BHVXh4SGNK?=
 =?utf-8?B?RXdUdXdzdjk4U1I5NDNXeGtxY3o2TGwxUkhmaUhWRUJvTTYxZEs4aWpLV2ds?=
 =?utf-8?B?K0NTSEY0VUU4dUd5YmJHcXFiWTZKUUpzTXg4ZVcvT3NSMlRhT0E4WmdlZnhz?=
 =?utf-8?B?VCtaZWNweVkrck1HUVlJd0xzTGtUL005MEZGaC9XcXBBMGgrWnJRdVlVQmpi?=
 =?utf-8?B?V2VuRXdUWXl1MUo1RnZCN3hWbUdvcEo3ZXk2Z1hPdnJMamowRGpQaTdYVnlZ?=
 =?utf-8?B?Yk85c0FnL1ZFRm5yUEhXOS8wRDZHMG8zZ3RMaUs2WXBhU2FIWDJoSisyZDVO?=
 =?utf-8?B?b2VjYXk3eHM5Z2E0dklmb0JqcDQ3Tk1MTWNyZGZ0V1FuYTc0ci9rbE54UFVY?=
 =?utf-8?B?OHcwMnFvYmZmTzdMSStwb0ZURmo2cXNyODZPK0hIbjRzYlo1TnczWXFIdnNZ?=
 =?utf-8?B?U0pYWXNveDlvSWFtL2xyVmtzVjBSNjdqeUNlY0Y1RlM5dWNkV0w1TDNzSmJH?=
 =?utf-8?B?OUNSQVQwYlpUNWZPUDN1VDBsWURJZlg2UE80RFNMNkhKZmlaczI1MnB5d25G?=
 =?utf-8?Q?TSeUs9trXjYMBThojQCzGCSHyppDAW8NMYd6pkFZKY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a300a0-3e51-4753-33a9-08da021e5de8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:44:27.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22+P3B6gZQwV/kvX/Im5h6Qx1q/Iy8Ql1PHmpJDDcAZ3ZECSebBBf7kzYw5Cu3K/XzY0ApUcd4tcAErj1UGm/oOks1IgxpoFWxXk3zu6hP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0046
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

On 11/5/2021 10:26 AM, Thomas Gleixner wrote:
> On Fri, Nov 05 2021 at 16:03, Bae, Chang Seok wrote:
> 
> My bad. I should have read the cover letter before complaining.
> 
>> I think PATCH3 is better. Maybe PATCH4 should not be sent together to avoid
>> such confusion.
> 
> Yes. patch 3 is way better than patch 4.

At the time of this post, it was clueless whether this TILERELEASE need 
is architectural or implementation-specific. But the latter is the case 
as it turns out. So PATCH4 only appears in V2 here -- 
https://lore.kernel.org/lkml/20220309223431.26560-1-chang.seok.bae@intel.com/

Thanks,
Chang
