Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FDE4D6915
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351117AbiCKT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCKT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:29:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D29BAD8;
        Fri, 11 Mar 2022 11:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647026922; x=1678562922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4qsA+j3+Ua34swnlx2kfY4l0NMuwAtDeoHe7xnPAdOQ=;
  b=IMJiwJacgZLIxta8kjYkiJyu4fj04wBy2CjWvq/aPwRl0ikGf/+iXmoh
   KAfqEEePil2cnH3/TXUdLdZ1aiXcTAjdnCM9KkH12VfE1KfUvOmirSOjV
   gZAQ0elXa723l8HA1RINPy+ypnBp05ll5tYjKAKoFjbWcx1j5zcj70Jt4
   J4cm0Xy66ND8tGvvZxtPSsVTamlAk+wdIjlaSgmLJcE/bn+oBq87qlvKO
   ywGlKDWBwsRXF7S89sEk3VbrH7xXFt/ji1Wc9PtF8hQ5VPoiUv6qDlVTC
   6ygqjcSVcmKHSkYlXrveD3HjyBTtBjBbOYTGyozMww2Y0LnGWzXvh//bG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="342066616"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="342066616"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 11:28:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="511480091"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2022 11:28:41 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 11:28:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 11:28:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 11:28:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMc6xLtsF5Q0uX1fZNdKGU2ziVvqqUUWh4FI8XEucVQJ+xJIcUeaF7qGU3hsT2DPl4mPwr8bWm/iiQPOqbfM7RMJmOP7qy1P/XMdRJVflt/Ui8OF5gZ4bQZQzfAQv7tMEMH40nVT0uISyUM2+2tEHR+HqDoRpz5H/l1OFLj3Bsc9VpsYTsVDQlpPX7J3H3/2r/BRRLQQ15/EkTGmIeDR7LXCsObBd/TySmHrYsU9+mXxVh9p7n3tFGg4+7W+r6s0u2Ex0y3mvl26DgHu73NZq4YerJpXE3aNsD+8gl0FPQACtwFYfu6AEZOVVu4R7P1paBO4i+IJnV6K/W4UGQMP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZlahcTdcMeHe9VKcpsSDBgmF1Uq72kcCtS+bhSj0F4=;
 b=VPwjxSDGyKabTRnLkiJhmB2lHo2LqqQiEZG9nMNe/lrcaZg5mo/cYtNzW166wIqox4nB0MQv9Fb1gt+nRgi6/VC1o821WF2vfhiCn8FQyPIkhlRzLAxhDFzTLVz3OwQMO3LwBByNHuHCPZqT0Hff62qjOHQw3J3mFNPaHTfVwn5bWMdMqQaLeBBQppAiWzn/p2RTItbkZrcQGoYT7Ze89imCWrHE6bTDGDCPhLJ7nLDIIvaGGt32Zo/2X0FGYVY47RYkHhYoBrLwRnLv8qmaEAolBPyKaLpCANAn0ICQwL1+WLlPa5+6sFpi31wpgaPffJWapNs5BjpXHCaOGrvZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 19:28:33 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 19:28:32 +0000
Message-ID: <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com>
Date:   Fri, 11 Mar 2022 11:28:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <YiuQx+X9UQ2l22un@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiuQx+X9UQ2l22un@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:300:115::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e4481b-7dca-4f2c-fc17-08da03955429
X-MS-TrafficTypeDiagnostic: PH7PR11MB6008:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB6008F81D86F1059AE9C6CD61F80C9@PH7PR11MB6008.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGJHHx0C3DJTUYzsf8jh858Vq9CKIkDfMIm7wzht2RgmKEgpM7+OzwZSDVZsNSCm7+SigWjannzaGActSEDsk+Zk/q0Me1Vr9snFhJY9koyec1yynM7YV9Q/hOOFMCmqZRBM3GEJVeYpPQf85G6AHkaZDhzaverwwFx5KYIkc+52f6tuIKBHfV/lamjzD2RIOXcRNjcs6JWFM+aGEVIpbdOuCL6ZRzo7A30ouigGjplMXt04joTaJrrfVf1KCDEY4LC/mIfvy4IrdW6R7eg/izatMQwi0T1RFgtlSnrTDAH8BXsNKOBBbkmDwDNnMQXPE2ah9ZcUEtQW6S2paFiQSlsQlGf7YmO5JjQgbHr9fRFud0fyNUEWqGWgfJB/rmXuGwbRtllSRfqU9NJ83febFBlXLVOfbkTR3jkRxrwOH3FD/JOhuhTYex51RyvX5OgaDjhRlBgzuUbkZ4ZpEUHGDhOACINodhUccmUsRoZzPLpN9Ol1Vit/zvYRKrTGwZhItQ4ocFZUS2CmcnpFVJGTUNlqfs87YZNzPPbmlFuKwR01pqcAoFmQvAp/asFjBAjjDeC+omcYD2JmALo76Hyu8mhnzauSEZJpRMSaYF40YPtK+dWM1Wu9muaTAdssJIQ9HZILCQrObeELp7tjX+XR+MY1Gm8BnmAvefqf7tdOk95T+jbC87oeIJYDOQjzoVyFLW0N0s5v6wut0qIdz99/Mpvk7ifaPo8ojnK76e0gnlIJEqrsAqXyku3BAzRKyJEv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(6666004)(86362001)(38100700002)(186003)(6486002)(508600001)(8936002)(26005)(53546011)(44832011)(6512007)(66556008)(82960400001)(5660300002)(7416002)(2906002)(6506007)(8676002)(316002)(4326008)(31696002)(36756003)(31686004)(66946007)(66476007)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJlRmxHYnpxUllpVVByRUI0Kzd0WnlucUU5R0M5UEpkMlFsakcwbDJqeTBX?=
 =?utf-8?B?RUxBcVY4S0JQNkY2OW1rbzFJbDdwM0M0RUY5OWZzVnhRdHFrK1ViazJkS3FJ?=
 =?utf-8?B?UHRuVXFkWW9qZmxzeXRoUHV3NEhsMmZBcnFLOVlFTjVOemViUDBmRmZzTnRi?=
 =?utf-8?B?Q1dxZDF5ZHlHZGdkYW1zdHdvTUlta3l6LyszbTM0aHJzNnI4Rm5wcU0vNVVS?=
 =?utf-8?B?Njh6bXRYL1dTeUlxNXNTamdCczlTaXNPZ2RTVGJ3RVdqb2kyRmlpMWpoMzJP?=
 =?utf-8?B?WGZTem9sMFZ3ZDZOS0Jrc3dIUGtvcHdvYlpMci9ibGh3d2lQTlZnZHB4d2J5?=
 =?utf-8?B?OExPam5wVWU5dERrdjFoc0tOQmhHb0NMeFY2aVQwbEFOSzhqbmkzS1E0NjhK?=
 =?utf-8?B?aXRJNlIyVE5NWjRBQUJrSmYyOHlUVU9RSU1Ca0FyZEdCemVVWFMrcjBZMzdV?=
 =?utf-8?B?THQ5VGVmRGcrMkU0cFBTWEF0cVVoVitDNS8yUVhab0RpKzZGZmE4Tm5OUFUv?=
 =?utf-8?B?VGVtMkk1YjdhamFtYndzUHQzREVlVE5YTDFWTk1SN1JtV01LM2ZRaHphU3RW?=
 =?utf-8?B?SnRzeWIrL2dqZXllcU5IVVF6bDA4MVJkUEE0NHZkMTdIUWZoY25Id3NmVzM5?=
 =?utf-8?B?aEMrOUJLWmRlMU9OUFl2YWxvaEVKbzYraHlTSy9YSUR0NkdIYWxxcHBVbk5P?=
 =?utf-8?B?cjhGWmZPeEM0MGJSNTJ0ckZIMGxOY3d0V3BKT0Jnd0YxNUZOZXp4N2FkTWhU?=
 =?utf-8?B?dmFJU2VTZVdPU3BKWXlFK0lHZWFhTGZueW4zaDcxRmpMUGtNSWNYRWxtWkJs?=
 =?utf-8?B?TlNVSEU1aXcyRC9zQkVNK0ljbjZ6LzdaZmg5d3lZdUx3U0hYMnFiU1BQbDEv?=
 =?utf-8?B?cHJwVjVTUG1adlJvd1R4OVhac2FURkxLek4yeXc0ZEt1VnpQTnNBekx5UGhm?=
 =?utf-8?B?UitDSnBOR29SUWk3TVcvNnBtMk9yZjhYWWl0R3VjUElWWk9oVnlhRGlhVjVB?=
 =?utf-8?B?NU0rUnBCaDVqcXlUeThuMWNEbjRKV1Z0RzRySXBwU1VTeXFLRlFIN2VMZ1VC?=
 =?utf-8?B?VVhUaXBPWi9hSHJrZkZ3ZDgzelo1RkZwTHB0QldwaGxDZW44bTVXMmZMMFZ2?=
 =?utf-8?B?dGJrREkxNmZGN2xuYzdGWlU0QkZrKzNYYjMvMWpNS29tZ0RzR3lZVTh4dVBn?=
 =?utf-8?B?MmRxRm5QalY2VzZZaStQY1dpVjBuVUVPcWZaNWdZZUNiUnNNZHQ5cjM1ME9R?=
 =?utf-8?B?aXdYdzhkNDFFbEF0N0VDc3FIemtwVWlLV1h5V1U2Y0hRVlZwUkxZUU1iczIz?=
 =?utf-8?B?czV6S0JFby9xcjI1UTNUYlY5ZjdhN0VmT1pqanJ4Nm9HUHVBczh6cEk1WU93?=
 =?utf-8?B?czhDZjZqNThtK1QvempUV1hyVjRYR0hIaGV5bm1mSXRYYkJteXU3WkNjRXpD?=
 =?utf-8?B?aDF5WVlTN0JoZXVKWHRkbHhTbnlZTllsemxLdk1FN0ZPckRRVnk3MjJGczlI?=
 =?utf-8?B?bGlhSDQ0NDZhTFVyREJXUndBUHBNZmV2a1duZ2NoN3phZGFaM1hpZHhGY1Bq?=
 =?utf-8?B?Yis4RTFtcTBQUGM0YnpLeXNhbWt3YXZRc2N0TWdWcVF5dEJzdklmOTJxcHpZ?=
 =?utf-8?B?SU5RQ1BNQ0lYVk9qcG5JY3lHU1FKUkJZcmhpNlc2NklzVS9NbTBtR3JpU0R1?=
 =?utf-8?B?YTllNWJXNXdyOE15K0RYTm9ycFh0ekZqb1BLMlphOStKYlhJTUcyQkpuS0Nz?=
 =?utf-8?B?UWxvaHVGN3VLK1JvcGVuVWNYYkxoOU9EaWNoSFR0Vjg1RE5Qb1hGcUR5Vm1l?=
 =?utf-8?B?OFV5bWVMd0g4TWNLbWszWEVEbWllK0s5blNKUzREQThEdURKUmNROWpIMGNF?=
 =?utf-8?B?MjhTWGRpNFNxUXZnNUVLSzNvcmdlYzhQZ2pnQ3g3L3JheWw5eEFaaERTeXZF?=
 =?utf-8?B?aFNTVEJWbnJ0SXIyMlRxQXNCYUlJY1dsS1RScDNzZ2t1LzUveEhYYXJrR2FW?=
 =?utf-8?B?NldFODdvYmpoMVdJVVhoWmZqcEljVFEyZkhybWZvMjI1MHJWbkpXTW14MjdB?=
 =?utf-8?B?Q21laGorNi9PQUpnL2xvQzBHV0d2bjhUNDJkVUZoeHBqR2VnbDJiYTJPUy9z?=
 =?utf-8?B?eENLZk9ON3Bma1hDU0pSNlEzWEd4WHEySzZVUDRSQlhhNXI3NG5rcjd2aEI5?=
 =?utf-8?B?YUJWUkRqUW84Mlo4KzZrcU5HYUpxZE1hamk2QXA4aWlseC8xUFN0NkdzbHNh?=
 =?utf-8?Q?1c6j6tHUcUi9zlqbYZwrodIx8lebA4atEf5Rym6bBA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e4481b-7dca-4f2c-fc17-08da03955429
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 19:28:32.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Cyn+DYxeqfY62duuEKO2z0KiStUunaQ2RctdwURPxf1DHZOPYsTB0PHJBRxEd4HaZ8MT3pErKtqXtI6h6cu5spUw9ikkwWfM8NCtajvxT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/11/2022 10:11 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
>  
>> I do not believe that you encountered the #GP documented above because that
>> check is already present in the current implementation of
>> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
>>
>> sgx_ioc_enclave_restrict_permissions()->sgx_perm_from_user_secinfo():
>> 	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
>> 		return -EINVAL;
>>
>> It does return EINVAL which is the catch-all error code used to represent
>> invalid input from user space. I am not convinced that EACCES should be used
>> instead though, EACCES means "Permission denied", which is not the case here.
>> The case here is just an invalid request.
>>
>> It currently does not prevent the user from setting PROT_NONE though, which
>> EMODPR does seem to allow.
>>
>> I saw Haitao's note that EMODPE requires "Read access permitted by enclave".
>> This motivates that EMODPR->PROT_NONE should not be allowed since it would
>> not be possible to relax permissions (run EMODPE) after that. Even so, I
>> also found in the SDM that EACCEPT has the note "Read access permitted
>> by enclave". That seems to indicate that EMODPR->PROT_NONE is not practical
>> from that perspective either since the enclave will not be able to
>> EACCEPT the change. Does that match your understanding?
>>
>> I will add the check for R in SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS at least.
> 
> Yes, I think we are in the same line with this.
> 
> But there is another thing.
> 
> As EAUG is taken care by the page handler so should EMODPR. It makes the
> developer experience whole a lot easier when you don't have to back call
> to host and ask it to execute EMODPR for the range.
> 
> It's also a huge incosistency in this patch set that they are handled
> differently.
> 
> And it creates a concurrency case for user space that is complicated to say
> the least, i.e. divided work between host and enclave implementation to
> execute EMODPR is a nightmare scenario. On the other hand this is trivial
> to sort out in kernel.

EMODPR has possible failures due to state that is managed by the user space
runtime. Being able to communicate accurate EMODPR error codes to user space
runtime is helpful to the runtime in supporting its management of the enclave
memory. Accurate EMODPR error codes can be communicated when using an ioctl(),
not when run from within a page fault handler. 
 
> So what it means that, in one way or antoher, mprotect() needs to be the
> melting point for both.

mprotect() is the syscall to modify VMA permissions. EPCM permissions are
different from VMA permissions and they are currently treated differently
by the kernel. 

Moving EPCM permission changes to mprotect() forces EPCM permissions to be
the same as VMA permissions. That is a significant change. It is also
inconsistent since EPCM permission changes cannot be managed completely
from the kernel since the kernel can only ever restrict permissions.

> This can be called mandatory requirement, however
> this patch set it done, not least because of managing concurrency between
> kernel and user space.
> 
> You can get that done by these steps:
> 
> 1. Unmap PTE's in mprotect() flow.
> 2. In #PF handler, EMODPR with R set.

There is also the very significant ETRACK flow that
needs to be run after EMODPR. The implications of sending IPIs to all
CPUs that may be running in an enclave while in a page fault handler needs
to be considered. Page faults should be as fast as possible.

If this is considered then this tremendous impact on the page fault handler
should be managed and avoided as much as possible - but how will the page
fault handler even know when it should run EMODPR? The enclave can run 
EMODPE from within the enclave at any time without any insight from the
kernel so the only way to have accurate permissions would then be to
run EMODPR on _every_ page fault, which is obviously a non-starter due
to the significant impact (EMODPR and ETRACK) and blast radius (IPIs).

Trying to move running of EMODPR earlier, during the mprotect() call itself
is also full of obstacles since the mprotect() call may result in VMAs
being split, which is an operation that can fail, and followed by
the EMODPR-ETRACK flows that can also fail (and not be able to 
undo the VMA splits). With the EMODPR-ETRACK flows that can fail it
is here also not possible to communicate accurately to user space since
now there is the whole page range to consider, for example, mprotect()
cannot communicate
(a) which pages caused the failure, and (b) what failure was encountered.
This is possible when using the ioctl().


> This clear API for enclave developer because you know in what state pages
> are after mprotect(), and what you need to still do to them. Only the
> syscall needs to be them performed by the host side.

Supporting permission restriction in an ioctl() enables the runtime to manage
the enclave memory without needing to map it.

I have considered the idea of supporting the permission restriction with
mprotect() but as you can see in this response I did not find it to be
practical.

Reinette

