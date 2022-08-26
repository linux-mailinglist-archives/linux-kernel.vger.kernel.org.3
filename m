Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9825A2C21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbiHZQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiHZQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:17:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC23D91C1;
        Fri, 26 Aug 2022 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661530652; x=1693066652;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cU/T9Tl5oXKtgIkvRCpocg3V+12YUUHoBYSl/HSK4uI=;
  b=B82vxBze2LSIqUjOxfCJ3kIr3K86jRQo5ZPKsSLwYbFH6pZaFzIPkcnV
   WLBhNKrbGutMPU3t1sAeOZjoL0TbHQppW0QsWbC5XwVIAbtkuIXJqK3NN
   FbZs9T3xp+fK83McbGohShtlZI4A7CUaOhZvGIuqfvL2LWqr5RrGMiNuR
   o+59xoepijbhjBMkYLQuS7Sp/ZLBxCJIU6CDB7RslOyEI2AvlmWGAIjdJ
   cTJtVI6sduqnh8T/mLtmzjGB54BHWKrW+IorqccR+NA01NsMluvNohgIf
   4BzqL4nN5zP8YeNRyOJhuoGNuDPoCVAhNHg5F9oBz200LF7rnACRPErPw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="358507040"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="358507040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 09:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938804398"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 09:17:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 09:17:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 09:17:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 09:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHvRM28qa3P8JTXtFaC8xrRhmFTDEBGFTfeFSz/JoTlAWKyR7ePD0rqV0KAvjTIumkiEX9B8SnxSBitvGomnQ+UFTPP3AJC2DNBYYueejC1j/AuPIvj/se+QFeVZ3GBmBAAXYonAOtSI6sBr/7k0K6LF/yCPMMLhYGDYhRDPeXHmSjJTKKsN0/xn1Ic+ZRwblgSZoulsSynSgJZIq+2QRe2GAviy9QocY3ze/gMz++mL3A5MqK1QTFQIDOurcGM6tMb3rXUBbv1symaxXgh4y66znzmOGo3JwTct/nOi1PB+f0QHLpev5jxdAptVpa+G/NDZN08yFScqfYlON4MrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BfOZZTk/c5wXgf61xM19ZZuWkBe1gabDYcXRrdrrj4=;
 b=e/wMCsRBhl7rPTnI8U+47ZsY/Ko4hSZvMonCKYqucmYYiZpzwjym4NwgA460i4QkAWD/L/E6SWdchNQuevEJ0bA3s1bJqKzy2xKySRxV2XvJsZYCeog4Ave0Ysag+WEQtOGOW8qB0+KQ/onY02X94T4BWRm5cmx4yAszMy5MNIMSR4iWT4xRdmAFzYTYDl57zw8Xb7k4ztKc5dSlTFMrXQJGO7CWvpT5/mWNOWskDMk0sbNwX051nmWmDyKn62H3sFvbhGWT7c5OMQUVMDkVzRfheUQjksHVyJ+kTtdCt1iETjyf1X+BA3RiZkubFlIpADYvfcxzgTAxr5XrmP8FKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY5PR11MB6305.namprd11.prod.outlook.com (2603:10b6:930:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 16:17:26 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 16:17:26 +0000
Message-ID: <9965edff-c558-2962-4aad-3342480026bc@intel.com>
Date:   Fri, 26 Aug 2022 09:17:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     <babu.moger@amd.com>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>, "Luck, Tony" <tony.luck@intel.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117577662.6695.15496626554784059239.stgit@bmoger-ubuntu>
 <2b7e3511-8e69-2e47-0f11-7f1014b38940@intel.com>
 <1cf62647-20db-646d-ae83-c2ee61f257c7@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1cf62647-20db-646d-ae83-c2ee61f257c7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:a03:255::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e014c934-e23f-4c3d-f2e3-08da877e7749
X-MS-TrafficTypeDiagnostic: CY5PR11MB6305:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAexqBOtx3mEICg2MSF3nysCwnSFr2o28ufrrKOemRJj22EyJETXZ6vVVZbBMbsiEeFtZH26tmFjxZuE959F/UvpTNijX6L+28zmg4O12nG8c6bfbdDPB/XOymFzE9KLM8VwdZCxZSjlpOnZ277qhSryq4PkXUo5SU42nIDJerimlyhWYyMYUmZsUgGAsisq99WmkMefaGr2uaESAibSc7nNgVN0LbfdzM7B+lA8szqcubQc98GYpp0vOaoahqKgVVMdgJg0xtv7RjQpTR36pU/fQudvuoB8LfNY5JuMmBOP4WGHHMmssrVsSBtZYeLFaAQgRMbCtJc8Hvai11nePG1ZZ5DXOUYfT7AnxKy3xorXVFB04cyDkMWureEPkF69xVlp7sDVmTAlyVx4VQWqbN3sfBIoKLNtz8EueYSGEeGieFpknTuUS9lnw9xft+G+vZYRKZMyCFpQmeScw33Vem/8o5bPJV18XMTZL6OLEZ/l04FCnMOmDtCZ6v2Ho8uDEpkctTiKugFqMWBHTm6QUE07Zx/SSEX83jfyDtqI/ls0bKoiycWMTKZQNpXCDNGU2A12JVbHYTX+DKTC47eYwPcPQScss0IBBzNHznxhYdEaGsXSswTWOfk6r1q2z+BwOZ7roVVTnympLDxVzr8lsUyI8j3rjUY8mHf1JChI3YtWeomazhBpHsPuZgVBTWJoJrGdjNIMSJnrFenTXa9Kp9d/ingHcZRu1XQGsD8/QE6i9kbvxW6sZNWAWkSxh50DHwVDRnESzMKqh0wnNEsrW5DxsCNFQ66tkQrV1tW4gBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(366004)(136003)(39860400002)(2616005)(83380400001)(2906002)(44832011)(8936002)(66556008)(4326008)(66476007)(66946007)(8676002)(7416002)(5660300002)(6666004)(6486002)(6512007)(26005)(31686004)(36756003)(53546011)(186003)(41300700001)(478600001)(6506007)(82960400001)(31696002)(86362001)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkdhTUF1OVFMbVIwNjJoOE5wQ2tkUUNMRGh2UWUvUGVTWFdQYTRHNkU5YVdQ?=
 =?utf-8?B?cXM5UUk5dCtWTXlTbWdKSnNZRWVsdEg1M1ptdzNJaEJVd24remVFOG4ya0tV?=
 =?utf-8?B?Y1RhbmdWRkc1VEl2cGc2Qmh2amtUUlRrdlNPSXFMQWUvdXNTNXFvY3JXRG51?=
 =?utf-8?B?YTg4L05NZmpua1l6SjhnNTBpNjA3VkxXRkZQK1RiQkhOM2VTZjFCbG5BL01p?=
 =?utf-8?B?WXZkMlVDYm81UTRocDdaQUR5Zy9Idzg0VytMdTRBSVFvZXFSOEUyeHV4U3J0?=
 =?utf-8?B?SWJLWU0rd0F4UFl2VWFvWXkxNjViZkRWa3JOeUhPZU81dTlHQi9CZzRVZXZT?=
 =?utf-8?B?SlpFOEFCcG41M05BMHhiV1ZDVWJTc0hKd2ptRXNLQ2hMd2NxOEl5NHNBYTFN?=
 =?utf-8?B?bkc3eFlsRHdRSHNpdFMrd1hRYkRoQW5admRWN2RLbEJmVW9uZnp5ZWR1WXdY?=
 =?utf-8?B?YjRmVmRia09GUjJWbWF5ME1WMUFvTkJpY1lCMHVzdEh6RldLVmVFek94dFFT?=
 =?utf-8?B?VThLb2JvcXpUQ0Npdkl3cUlXOUlHaEJXdm5kbm9PbyswdVFKRC9yZ0pYWEVB?=
 =?utf-8?B?bjd5aDYzL2RLTEtRZTcvbnFGeng3TFdBVFUwb1pydW9IQkFpRGxPQjZaUkdw?=
 =?utf-8?B?WGdFVFBsWjNhc3k2U1U0Y0Zpc3JFMThGcDBEbVJzZ29UeERQTlhONTF3aGxS?=
 =?utf-8?B?WmQ3MG42TFRqeHlFRVNyL3NyTWtLNU5LcDlIRldCVG1NY3NtVnpZYnVSZ3Vq?=
 =?utf-8?B?LzAwSHVhRnZuRWQ3S2dicHZHcFI5bHF2SEZMek5GMkNTSndiZG5FMG1oSlRT?=
 =?utf-8?B?VVFBenhvTEZ6eStzMTUyRWYyMVJFTFdBRk5lbjhiWkxnTHR5SkVvVEQ0bTNo?=
 =?utf-8?B?ZEZOY0g3eHVjeCtqby9HWUtsNjI0cUJDUzkySlIyK2dtbEEveUhMRDdpMlJt?=
 =?utf-8?B?TkxKZFgzbmFSN0g0QlFNL0FsMTZod0RCemtTcmc3MWEya2dqMXd3dnlLZG4v?=
 =?utf-8?B?dzJMNHhBUEljbXprZGRmYzZpQWdHeVBtMCt6MlZIWkZ0NVpoNHhGTzJMNTY3?=
 =?utf-8?B?RDA3Qmxja2I3MjRNb3habjFoc1VPTXhvRkNBU1RJYndxNE1QNGNEd0hwSy9B?=
 =?utf-8?B?UGhHa3E3b1hOT0Q5OEpSR1JYak04NGVxT21KOS9BQWhjRm16L2JQWGhueS9i?=
 =?utf-8?B?UW9OVGdscFdsKzg4UWlKdkZ6aDJoWE1mSXRyeHRlTnNBbWI5dG1Nd1Rkai9Y?=
 =?utf-8?B?QitBcUxCaXJBcUo4NHBHcjF4aFZlWXBiUGk3NExiMExBVEhKRlliSTQxdTdP?=
 =?utf-8?B?ODBHRXVwVkMyUGUrYXJOdTdiRERScmJpM1YxRVFnS24xendEbHJ0WXNyMUNB?=
 =?utf-8?B?aU9xRnhRMm9PL2ZoaXlCWW9CTWpySUJiWks2bzJZeXR4K2dUQ0NXZmVwTzNT?=
 =?utf-8?B?cXV1czN4MVBnQ0RCTnY4bkpFU2lYSzBzdTN4dVB0SGFNbTJrWVZuSWF5ZWE4?=
 =?utf-8?B?RUgvOE0zcmt0YTc0RzhTeFhvYkd3aXUyMTc1VkhsaFZ0bk84NG1IQzFZb0s5?=
 =?utf-8?B?NzAvQXArZ1RyZTdVU3Z1Wm41RVI5bjZ4Yno0TXBqdWtYL1o2bCs3RWp0SjhS?=
 =?utf-8?B?UVprcFhJSDlBMHRXVzBjOXlTQ1graFRBaHpvZlo4bk1Va0NyWC9TclJMajF2?=
 =?utf-8?B?RDVtOGw0YU90akcrbWZLMlFmbHl6WnduUFUydTVlaVVTOXViaHFEbGVST2ZH?=
 =?utf-8?B?TGphdXdKcjdFdnlJYXg5TUVlTTRCZS9STEd1dGZENWxrbzF6MFZlNDBJR2pL?=
 =?utf-8?B?WFprSEtYVXBrOXYxWk1WMEI0RG5UMVYzVGpMUUtNWVYwZ0loTENtR042REZE?=
 =?utf-8?B?aHkrcnRwR2loc2s2b3lGYVR4anJ2Z3dKV0tXOGVENTVkNlVmbExQeUVHdlVo?=
 =?utf-8?B?MkNNVWJJTVh5eTBzRnJJVStNa3lpMlErdkJScWwzeWw5MnJ1U1NXTTErclM4?=
 =?utf-8?B?d2tvZkFvS25xMnRWdHl4ZTF2UC82N3g0c3djb00wOUdIaFJ5RUN5RnJnQlJY?=
 =?utf-8?B?RFkwczBlN3ZrZFduSHBGQlcrazlKRjlWd2ZOTVpMNjhsYi8xbnNkNzdlR3M1?=
 =?utf-8?B?VStZNnNnWitMMWRJaWtaNG5UWnk5d2FNNlJ3THd2M1p5V1gwZ2p6blVKSDhj?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e014c934-e23f-4c3d-f2e3-08da877e7749
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:17:26.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i05c4qKiFqDcAamRNovdoqYHCRHFmH7a6xfRf7dce0yFglBawLvWLkSqXszQ8VlkYFnTVSsutVID1A2HTJtQEdPcGtVL0aQCNfinmphANw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6305
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

Hi Babu,

On 8/25/2022 3:42 PM, Moger, Babu wrote:
> 
> On 8/23/2022 5:47 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/22/2022 6:42 AM, Babu Moger wrote:
>>> Adds the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
>>> enforcement policies can be applied to external slow memory connected
>>> to the host. QOS enforcement is accomplished by assigning a Class Of
>>> Service (COS) to a processor and specifying allocations or limits for
>>> that COS for each resource to be allocated.
>>>
>>> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
>>>
>>> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers (ECX=0)
>>> Bits    Field Name      Description
>>> 2       L3SBE           L3 external slow memory bandwidth enforcement
>>>
>>> Feature description is available in the specification, "AMD64 Technology Platform Quality
>>> of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Issue Date: February 2022".
>>>

(snip modified links)

>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>>> ---
>> resctrl currently supports "memory bandwidth allocation" and this series adds
>> "slow memory bandwidth allocation". Could you please provide more detail about
>> what the difference is between "MBA" and "SMBA"? It is clear that the implementation

> In this case the slow memory means memory attached to CXL device.

When you say "in this case", is there another case?

Should "Slow Memory Bandwidth Allocation" thus be considered to be "CXL.mem
Memory Bandwidth Allocation"? Why not call it "CXL(.mem?) Memory Bandwith
Allocation"?

I am not familiar with CXL so please correct me where I am
wrong. From what I understand CXL.mem is a protocol and devices that implement
it can have different memory types ... some faster than others. So, even if
SMBA supports "CXL.mem" devices, could a system have multiple CXL.mem devices,
some faster than others? Would all be configured the same with SMBA (they
would all be classified as "slow" and throttled the same)?

>> treats them as different resources, but both resources are associated with L3 cache
>> domains and (from what I understand) throttling always occurs at the CPU. Can both
>> types of memory resources thus be seen as downstream from L3 cache? How can

> Yes. that is correct. They are seen as downstream from L3.


>> a user know what memory is considered when configuring MBA and what memory is
>> considered when configuring SMBA? Additionally, I do find the term "slow" to be
> 
> This memory completely transparent to OS with little bit higher latency that regular main memory.

I do not think these devices are invisible to the OS though (after
reading Documentation/driver-api/cxl/memory-devices.rst and
Documentation/ABI/testing/sysfs-class-cxl).

Is there not a way to provide some more clarity to users on what
would be throttled? 

> 
> Yes. I know slow word is bit vague. I am not an expert of CXL. But i see that word slow is being used to refer the CXL memory to differentiate it from regular memory.

What is very vague to me is how a user is intended to use this feature.
Would the "SMBA" resource be available only when CXL.mem devices are present
on the system? Since this is a CPU feature it is unclear to me whether
presence of CXL.mem devices would be known at the time "SMBA" is enumerated.
Could the "SMBA" resource thus exist without memory to throttle?

>> vague as a way to distinguish between different memory types. What is the
>> definition of "slow"? Would all "slow" memory on the system support SMBA?
> 
> Yes. All the slow memory in the system can support SMBA.
> 

How does a user know which memory on the system is "slow memory"?

It remains unclear to me how a user is intended to use this feature.

How will a user know which devices/memory (if any) are being
throttled by "SMBA"?

Reinette
