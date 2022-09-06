Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5805AEF0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiIFPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiIFPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:39:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03836491D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662475785; x=1694011785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Py91eawjRRpI9osRmA7hJiPlHYoerMlxNQfbEUcaGdA=;
  b=N+VmrECV+VmcTAPuDP02fmb1PRpedec5/FifELdtPOPvLvZJD34n+V7e
   2jVATChxCE20Ra2y1e72mwnmfMDHvSsKxgXwXhhjnfKNmrWTflzmHt1KV
   zQNKo27dz/JYos3YvdNiQITEgFyAhZV+sT6YlWI02ayz1E8ML2/hx8zeO
   fwd648vOVQZf7m8nA4pEBQ8yDDr9jGPihzjnhYIgO1iz53AcjhPjyLwfe
   k+GwTdR9556oxXJdKJqZzt4B7TC3NHvVyEmNZT4bVrg4mzCDkkGztVDuV
   z2Eq5xZVzsEBMBTVlpNYTH+16L4a5OpbfgFWOPfGWeb8piBiQ/gX+QuMX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279625246"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279625246"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675719828"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 07:49:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 07:49:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 07:49:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 07:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AigbgOCWOit9E8SSm3/1zM6fueb82gsq+W6rGn7kWmxrUaWVY0d437RO3KcgDop5z8mYNewJbhBI5JvRH/jwU7KHPx97H+uoVlR7d+eAeZuNtncOFZymXR3ABddEv2jOe2Ao5TO9UfBdTwrIlpsTwqCBUvctKpUVZORogB5KDIAczL46ZrkA0pZ87/KPEjwsW3Fs21NHdWP7PFl8TM0x+BBLMs3n6q5wi2fFDbbgoI5X9LnU6oflDKMc8LyVkNJVksXG978ewpHkgpUvjJ7D5cRvMhDzV1xmRDSZ458DU45glcIbhWxL1TqT+s3Sd71sw3A0f7sW0FXiPkX/C0tbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iq/gseL7iHrd/IT8guL4Mbn6twHLDPqFuJbNHCWTOw=;
 b=ktSh83tF2uSu+K1BO2sDLNUSHquqz0TEi1b1+N9qBmKj99vjOaxgaMR+Ufpmz3vl0EjFKaOquUmjvrnVlV4NyXVs206g9z87oqB2qwrSNrqXkebL+DqmCpmdPRlLlpVpuFW2oG9VwGAPUmtYPvYkNbez5+49xnjY+jVL0DvzrksHv+HytbdZJMJBjP22MltGSYU3+fQX2FnkaRHTgt3oYadQzaG6AgjuYmW2M1PGxsXefNmb3DweN5i9c9Qo7i98kc61xoKsWcUGvDXlSqaR3MIpZ5goupUTRkuz3wSAUo6hK37JCkEn1S+/5cT4IN1jFAdOWF0IAnazJdbW4NXkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by CY4PR11MB2040.namprd11.prod.outlook.com (2603:10b6:903:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 14:49:39 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 14:49:39 +0000
Message-ID: <08a018f8-a991-d3b9-c022-ee40ce8a2c21@intel.com>
Date:   Tue, 6 Sep 2022 22:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] memblock test: Add test to memblock_add() 129th
 region
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220902024007.58041-1-shaoqin.huang@intel.com>
 <20220902024007.58041-2-shaoqin.huang@intel.com>
 <YxdDqZgSjBKjcvYE@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YxdDqZgSjBKjcvYE@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e183d995-5815-4655-ca3d-08da90170624
X-MS-TrafficTypeDiagnostic: CY4PR11MB2040:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBuzN3q1VQcwXQvxkjUP4XzRM6AM/cQdrjZLrnu9ZgAvNtCAaviqlhHLHrVr0ZlaO+DGca+FUcGBlzQ6LtsucqD+NUSFMIxmlzS0z8oKlEdan3zHBVNWwJ7NvFc0h+alrKzXCsc09mPJDHsOnuCq7nNX8I1R8NSmX3MCTrgiJwop/Vrj8GWuQ6lb8yWXWx1l8lSsTnFJdJRg3WKd65EJUFOYpGSeYl/qjYTtZeuaw4FqdH6jnEw7LEKXu8KnnwzXdXOxrDvH7r2z6rZNQFICCOJAlo+OkVhXzd3LYfuVTpe5C2Ya5i17TfItO1p4WeI+M7/fvqCRMnnuCmaDBrZPpeikNfBe8Y4gyEHJMaAso+kCVaaztKjg5LinP6/yrU5hRzWdvQ0J3z4PHhcC+q2l+IFQCvWQa7XXUCLiYmvJE3MV/MlOX6G4ihhcq5l/Rly2M1dMy45srqb6BTqSKtXMo4YoqUDx0lIJV9uOzIcRKKQ1Bp4drpHXPxYva3cjJOWgTWI71kYy4APoFnKZB42kSI2oYT+/DzpCaj9eGSRdKyopT5nmc0QYkyoKQ6+cLggBXSQdHG2fFeDIvwxb6rppoWAqH/eNxgR3AWjyLYrXkJs+aHUwML7oOGgWLB5dK5pzEMHLdzBWx2ZinbyTtWGaJXF0ClfctqefoxP6o1RyJNCkZpn3x5zfRymcFFG1gubwtLdiPm1i96qi5QY3emLFYLQxLUxo78MDClB5bHK1RqSHV/dshLtu2R4DLZ70IejXekuedea43gci4i8APXWRanWdzMZZvdi/GCTOaqimfv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(346002)(396003)(39860400002)(38100700002)(478600001)(6506007)(41300700001)(83380400001)(31696002)(6486002)(6666004)(26005)(6512007)(186003)(2616005)(86362001)(2906002)(8936002)(53546011)(5660300002)(82960400001)(54906003)(6916009)(316002)(36756003)(31686004)(66556008)(66476007)(4326008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlZYmdFZW9wY3NkeU1SYm55R01YZzlFWHBEaUloRE1vV3NmckxzYnVDUUJh?=
 =?utf-8?B?RExkTncrTFdxbElEUjNWNmhFazNYelVJMzd2RzVzSnI1NG1oOWZyTURIVmZ1?=
 =?utf-8?B?aURxNUpQN1daT0ovOXVyazhXalVjL3BOTzdjbVFwaW83b2FwUzdERTFESEZ4?=
 =?utf-8?B?VWVselRZbkR6amhsWW5COTdGd09rVjA2SUtiOE9IQmJ5OTlTZ09zTHpwWDRk?=
 =?utf-8?B?N2pqWnZrYnJmVzRSMU81N3F2UDRUbXNzWHRPOGhROGg3RE5McjZpSktrYW5m?=
 =?utf-8?B?K3NlMEFPcTdBdkpYQ05IbXBsazQxTGs2UWpLbUwwbDZrUkNJd290MDR4TDFh?=
 =?utf-8?B?VmxzUmFINTl0ZEViaGFySUJTWC9adW9OcTZDQjNqN3BkYnRuWklpY2g1REFh?=
 =?utf-8?B?SXNwc1dWRlFFczRrckRCUHljUzMrOFkzOWI3QmMxb3J5MUtiVy9FSUpFMVNG?=
 =?utf-8?B?U3FkQUo4VDNkRGZFNDhrRkdkbGtlSXBiSTVYNWovVG9LL013SmRoMlJLN0tG?=
 =?utf-8?B?RXR1VmRCTTRTOXhUQXdjSm05cm1BNzZrSzRuWjkvb3FRNlBBT2dncVdLYkxO?=
 =?utf-8?B?Vm1XcVFHZXRMdklNN3E4NmJ4S3NuSVFlTDMxKzZ6U1IxSGM1Z1p5WExSWEgr?=
 =?utf-8?B?NVA4RzZUV3p4Qm5Fa0g3UTNSbklGRXA5NFhHVEUwMk44aFhkdHdGdVh0Zkhz?=
 =?utf-8?B?QnlUS3luajl3eERVd1JlU1oyV2hJS2ZLNVgrTlZiQXZwbDMzS2ZQdkdoa1lP?=
 =?utf-8?B?UjFWaGlReGd5U3pSWkxRYVcxUGhYZEtDVlYyQ3k2cWtFWWpvVjlJeUhISzU4?=
 =?utf-8?B?M2VuWVRIcUN1aURHOHlzS2VkTEJqa2V4eGdPMjBGVWt2bjRqTEhEYjd0UGpS?=
 =?utf-8?B?TUdBWTZ4ellqK1N6NWphSTRnV3pya2RkTGNab0hHbjJ4ZFJXcnZMMFlJZlJX?=
 =?utf-8?B?UFlLWm1US1VCMmpoWnUyZDBoZTRkemE5QVIxenJqTHlubmVtL1VEYnJxdDEy?=
 =?utf-8?B?SzlsZFJ1dEhhOVRFOWhMcHFZVUt4Qjk1Z2tMQkZrY3RCMzkvZk5wdjQ0UFBP?=
 =?utf-8?B?WmZEdTAyWWh0OTcrbTFHMXhKNzJlZ1F6NlBORVF0aGN5WUpORHNXZ1luR2V0?=
 =?utf-8?B?bytaTmpnTVM0QnBJOU5lbjluSHhSOGlGMFVFSWZTL29JQ2NCSUJONStOSWd4?=
 =?utf-8?B?Sm5ZNEFUYmI3Wms3MGtnRWEreE9SMlRpN090L0p4eTdXbHRBQzNRUDFRMHlt?=
 =?utf-8?B?V084NmtpOHhhK2JGTVBoRW1hSUJnZ3ZjMEcwWUNWSHc2VnhTWi8xU1RhUmd0?=
 =?utf-8?B?emdNTk5URUVNcGFLYm1vVlBZQ0pSNHFyb2ZsZ3JMRzdRd2U3cjFqZmt4bm9E?=
 =?utf-8?B?NmxEVGllaTUyc0QvaHZlY21sMzEybmN0cGJVUVE3VTNlb0tsVlFLa29ZMkVD?=
 =?utf-8?B?ajJBMTRXSyt5LzJ4TE4vTEJLRVJTeFlLdndBNjd2eDdxMjVnWXZ3dC9yRkp1?=
 =?utf-8?B?Z0FwdzNwU1pMYVgrOWc2RHhNWVZtOW80Q1VJZVZIOVFSekFPbWdNdmUwRG1B?=
 =?utf-8?B?NnBSSWdRaUhPRTduQlRidTFyZ3V5c2IvRC9nWmhJVmthWjFYV0taVzJwaXZI?=
 =?utf-8?B?aHVGK2xnZ3JQUHVHWS9ReXN5U1JmcHhpbVJYNEt2WUVFclFDaGpCdFdxRDJx?=
 =?utf-8?B?TTV6MkZ6RXI3VDQ0bFhJNmhINVY0UThqNG4yQ0dVbjJ5N0tXOG9BNzI2eUVt?=
 =?utf-8?B?WHlaZ1hZMzFsa0N5Y2k5MXM3bUFsbUpSMm45UVdNQVltOER6bGdYWHp2TUFX?=
 =?utf-8?B?cHRoZUJOOW9ITG9lQXBpbkV4V1lxUDNXajJNSFhUYTFGazc4ajEreEhKRmRB?=
 =?utf-8?B?aVFZWitTdHFrK1JuUG9kaE5mL1hIeXhOaDVackxsZzI4RkxoWkRjMWkzbENW?=
 =?utf-8?B?aFhldFVKS2RDZ1JxTTVIcTNVMUFqRngxdFFIcEI0ZUI5WDRSR0QvaktNbU5x?=
 =?utf-8?B?UFFxb293MHgyVmRpdHNBWlZqbEJnZmlBUEU1UXkxUVpXSFphdkR5QVBXUldZ?=
 =?utf-8?B?UWJTRnpoK0I1Y3VHMEZrUVg0TUorK2lxVnVoUnZyZk0vUWFQTFdoNGExUHdt?=
 =?utf-8?B?OGtyQ3lqUm9jdnc5UlFIOXlnRlNrcDBPRVNRVm12N0kxem5aWndOZTdZcmIz?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e183d995-5815-4655-ca3d-08da90170624
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:49:39.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vec5NhotLSzvK/HuZ7kZDAkOB9YcD9wN+rPqwLU3kxU5Yi8gTCqY0XSQx8v7vN2U8ooRBFhfpfoiyp39LzmTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 8:57 PM, Mike Rapoport wrote:
> On Fri, Sep 02, 2022 at 10:39:59AM +0800, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> Add 129th region into the memblock, and this will trigger the
>> memblock_double_array() function, this needs valid memory regions. So
>> using dummy_physical_memory_init() to allocate some valid memory region,
>> and add it into the memblock. It make sure the memblock_double_array()
>> will always choose the valid memory region that is allocated by the
>> dummy_physical_memory_init(). So memblock_double_array() must success.
>>
>> Another thing should be done is to restore the memory.regions after
>> memblock_double_array(), due to now the memory.regions is pointing to a
>> memory region allocated by dummy_physical_memory_init(). And it will
>> affect the subsequent tests if we don't restore the memory region. So
>> simply record the origin region, and restore it after the test.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   tools/testing/memblock/tests/basic_api.c | 91 ++++++++++++++++++++++++
>>   tools/testing/memblock/tests/common.c    | 15 +++-
>>   tools/testing/memblock/tests/common.h    |  4 ++
>>   3 files changed, 108 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
>> index a13a57ba0815..b9877344d3a1 100644
>> --- a/tools/testing/memblock/tests/basic_api.c
>> +++ b/tools/testing/memblock/tests/basic_api.c
>> @@ -423,6 +423,96 @@ static int memblock_add_near_max_check(void)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * A test that trying to add the 129th memory block.
>> + * Expect to trigger memblock_double_array() to double the
>> + * memblock.memory.max, find a new valid memory as
>> + * memory.regions.
>> + */
>> +static int memblock_add_many_check(void)
>> +{
>> +	int i;
>> +	void *orig_region;
>> +	struct region r = {
>> +		.base = SZ_16K,
>> +		.size = MEM_SIZE,
>> +	};
>> +	/* Record these allocated memory, they will be free at the end. */
>> +	phys_addr_t base[INIT_MEMBLOCK_REGIONS + 1];
>> +
>> +	PREFIX_PUSH();
>> +
>> +	reset_memblock_regions();
>> +	memblock_allow_resize();
>> +
>> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
>> +		/* Add some memory region to fulfill the memblock. */
>> +		dummy_physical_memory_init();
>> +		base[i] = dummy_physical_memory_base();
>> +		memblock_add(base[i], MEM_SIZE);
> 
> Looks like we are going in rounds.
> The simulated physical memory is what dummy_physical_memory_init()
> allocates. Every memblock_add() may take a range from that "physical
> memory" and register it with memblock. There is no need to allocate new
> chunk for every memblock_add(), just make sure that
> dummy_physical_memory_init() allocates enough memory.
> 

Do you mean dummy_physical_memory_init() a large memory? And split it 
into 128 regions to fulfill the memory.regions. If so, we may need to 
modify the MEM_SIZE (now is 16K) to a larger size to make double_array() 
succeed due to the new memory.regions will occupy 8K memory.

>> +
>> +		ASSERT_EQ(memblock.memory.cnt, i + 1);
>> +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
>> +	}
>> +
>> +	orig_region = memblock.memory.regions;
>> +
>> +	/*
>> +	 * This adds the 129 memory_region, and makes it double array. Now
>> +	 * MEM_SIZE is 16K, which is enough, the doubled array will occupy 8K
>> +	 * memory region, so it must success.
>> +	 */
>> +	dummy_physical_memory_init();
>> +	base[i] = dummy_physical_memory_base();
>> +	memblock_add(base[i], MEM_SIZE);
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
>> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	ASSERT_EQ(memblock.reserved.cnt, 1);
>> +	/* This is the size used by new memory.regions. Check it. */
>> +	ASSERT_EQ(memblock.reserved.total_size, PAGE_ALIGN(INIT_MEMBLOCK_REGIONS * 2 *
>> +						sizeof(struct memblock_region)));
>> +
>> +	/*
>> +	 * After double array, we want to make sure the memblock.memory.regions
>> +	 * is actually on a valid memory, so we try to add a memory region which
> 
> What do you mean by "actually on a valid memory"? How would
> memblock_double_array() succeed otherwise?
> 

The code before this line has checked the memblock_double_array() 
succeed. I just want to test after it succeed, add a new memory region 
into it will still succeed. So the "actually on a valid memory" is a 
little confused, I want to modify "After double array, we want to make 
sure the memblock.memory.regions is actually on a valid memory" to "The 
next we want to test if the memblock_add() still succeed after 
memblock_double_array()".

>> +	 * the base is very small, it should be insert to the first region. And
>> +	 * the memory.cnt and memory.total_size will both be changed.
>> +	 * Let's check it.
>> +	 */
>> +	memblock_add(r.base, r.size);
>> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
>> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
>> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	/*
>> +	 * Due to we dummy_physical_memory_init() many memory region in this
>> +	 * test, we need to free it. Instead of expose the memory_block and
>> +	 * directly modify it's base, we pass an array which record all the
>> +	 * memory base that we allocated to this function, and let it to do the
>> +	 * clean job.
>> +	 */
>> +	dummy_physical_memory_cleanup_many(base, INIT_MEMBLOCK_REGIONS + 1);
>> +
>> +	/*
>> +	 * The current memory.regions is occupying a range of memory that
>> +	 * allocated from dummy_physical_memory_init(). After free the memory,
>> +	 * we must not use it. So restore the origin memory region to make sure
>> +	 * the tests can run as normal and not affected by the double array.
>> +	 */
>> +	memblock.memory.regions = orig_region;
>> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
>> +
>> +	test_pass_pop();
>> +
>> +	return 0;
>> +}
>> +
>>   static int memblock_add_checks(void)
>>   {
>>   	prefix_reset();
>> @@ -438,6 +528,7 @@ static int memblock_add_checks(void)
>>   	memblock_add_twice_check();
>>   	memblock_add_between_check();
>>   	memblock_add_near_max_check();
>> +	memblock_add_many_check();
>>   
>>   	prefix_pop();
>>   
>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>> index eec6901081af..1fb347c5c099 100644
>> --- a/tools/testing/memblock/tests/common.c
>> +++ b/tools/testing/memblock/tests/common.c
>> @@ -5,8 +5,6 @@
>>   #include <linux/memory_hotplug.h>
>>   #include <linux/build_bug.h>
>>   
>> -#define INIT_MEMBLOCK_REGIONS			128
>> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   #define PREFIXES_MAX				15
>>   #define DELIM					": "
>>   
>> @@ -84,6 +82,19 @@ void dummy_physical_memory_cleanup(void)
>>   	free(memory_block.base);
>>   }
>>   
>> +void dummy_physical_memory_cleanup_many(phys_addr_t *base, int cnt)
>> +{
>> +	for (int i = 0; i < cnt; i++) {
>> +		memory_block.base = (void *)base[i];
>> +		dummy_physical_memory_cleanup();
>> +	}
>> +}
>> +
>> +phys_addr_t dummy_physical_memory_base(void)
>> +{
>> +	return (phys_addr_t)memory_block.base;
>> +}
>> +
>>   static void usage(const char *prog)
>>   {
>>   	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>> index 78128e109a95..310f0be2b2a2 100644
>> --- a/tools/testing/memblock/tests/common.h
>> +++ b/tools/testing/memblock/tests/common.h
>> @@ -11,6 +11,8 @@
>>   #include <../selftests/kselftest.h>
>>   
>>   #define MEM_SIZE SZ_16K
>> +#define INIT_MEMBLOCK_REGIONS			128
>> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   
>>   enum test_flags {
>>   	/* No special request. */
>> @@ -104,6 +106,8 @@ void reset_memblock_attributes(void);
>>   void setup_memblock(void);
>>   void dummy_physical_memory_init(void);
>>   void dummy_physical_memory_cleanup(void);
>> +void dummy_physical_memory_cleanup_many(phys_addr_t *base, int cnt);
>> +phys_addr_t dummy_physical_memory_base(void);
>>   void parse_args(int argc, char **argv);
>>   
>>   void test_fail(void);
>> -- 
>> 2.34.1
>>
> 
