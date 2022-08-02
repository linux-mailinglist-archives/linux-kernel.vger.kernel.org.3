Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DAD5877FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiHBHjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiHBHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:38:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D901B86E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659425934; x=1690961934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vQK31SfDHYouF8xwDQqMKz0YZb0Dgr/72qU8dIVtCrE=;
  b=QXXfsDnfqSq+TRy6d0epQa5ZwB/iWH5HLU0sPuZyL55I2Rg9cpgdkw6D
   3zCftuIoShiqt7mcPnYLkT+gzwuPfsQau7Ysni3UxBmGxbcUK6DSITEPZ
   ry+/YgMvbfx2QlNnUJsEnCb/uIYnXcEojIy4JFa/1cYNhpoSKvL8et5BF
   UPu8gb4tgGG00XgpIjBzD/Ug4SNEGvH8bzhg7HLimugsKhrHig/MHxs2B
   DPis8bLq9jakWCSDQwKm6DeKCmVMjFV2R9TEmJ5vKTV0FpBa4xY7L6Ul+
   FNKu2pvUzncnPEbFIv3A1DguDrRmsF4ZcAtYBhobCXSoawalg2sSxFd5D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269727105"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="269727105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="705282837"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2022 00:38:54 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 00:38:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 00:38:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 00:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1ZZ0i4Omcwesfwhmfh49ehFF25EElHDCK7O1hOhJRb4pBT85Ci5HftT+yO0YLJL3k9/tJijZprauWYENy8yKVAKqiOIJurrDgPy8kdYVLOb9tv0VVLqni4nMkQ7/YTHvlVHdJhj+JIPHGcC00QYU1lpRZikflGuEWwtQPyCYFnODQOlP7cc+ybHWmeWv6t0O3G1VQNZD+gLmD/iMhWoY1qw2AtRwA1C/HMBq17MN2G9ukLrpgshTgjb96NV9PkYBePPN0STWZirJTJKrfAwIjFYJqo6vhx0oJoZ6TaB9I//wTKz2IHqR820cGqZsfzyTrcZNl4Dmeg9Ot9cazAugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFDkMNaUeRannKtKvDdLkZarH7h4gixrCINIb/XkC+s=;
 b=horL5VwFAPcanYFjIvCT3c0Zw7SQwqah5kRk993T58yyJEzpyIRQEa6cB30RFtnV9TLWauSgsndwlArylXluAupAB3CrgDhXx4CldrkVNuFv+PCMM0JwPm6eyp3x2Wdxpb3qSchhN2bEG3m+eJLAjcK0R6MJZLfbdl5KfozxkRV5t32ir71Z9l85iGokwAb+xYIkNnzUeNEXBBvPzYFjVIY7XVC3F1z/9XS5GfY3TxAd2eVFK06xPEl8ZEhPCEH2p1oMXiXDTO3m07PbV6NbRByRvaHa+c/x0MYhCQhFQeNq7NLOgveXZB9I4yUwAZBoGCPg3OBxWVLmWk20S+UiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 07:38:47 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5c8b:5ea5:b5b9:70c1]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5c8b:5ea5:b5b9:70c1%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:38:46 +0000
Message-ID: <4c8def19-650e-7bc3-a581-3ce2b7c0b3cf@intel.com>
Date:   Tue, 2 Aug 2022 15:38:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] memblock test: Add test to memblock_add() 129th region
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220801064901.980558-1-shaoqin.huang@intel.com>
 <YujPDHym0Ly8sxqP@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YujPDHym0Ly8sxqP@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844f13c3-af90-477e-0820-08da745a0866
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PZkVIH6PDIQ4ax1pCRRw74mxwIQnFIeFemRRs3EFxsfCv5CgvfOb9gT45wk/rGgqHrXZCS1Qj0HjL6Cba3I5jBdibmOq4g1cyOvAi9eaKFTdEjfFExmX2U8dTjhr2mplGkpSx641k/iFUNQnmKukZZLVk9DIjfd/a6JrHmWqJV+gegM5FdLW6xeDEabCDA+UyafZtyzaNuQpJ0OwRRVLt0IJPoPlcwCe5yvJtDdV0t4tp8dMkmmyPNP9IGLTBuzl8d6MJqrpKLc2NtlpYCFx9pXlh50Dd1tWl8hTZza0JVdYtv0rfZhdujgYZb5l3snLoXP4OAC/9OmIw9lfocjqeLUzItBsR0hHzm26mN+sKgdbXj7528oHB8AJdQ2XEP54FjP6osJviypnBPxLpVRz/wUtGsUGaO3zc+lt5mHKjjUaiyj1pP69PBFb0UFIwR8judhZseOeP6PzH/HG5xV210/lNdeeSv/UtKLttn/o6FvkIDLe/l5ST5g6eK6klk94ocAMXP/hFEqR3+HrMu3zquiu+oyr8xb7XTWDW27bB8W6jn0eG13DdSCysMZSAEdm9AIBIKEIjs5hxx4UVMKonEvYk1N9kn9sppmyKL+IZvjLL853xjguOeczi4hJEfS+UnVG/swD7jTQa3uDJBaAou9qV+ySQgfiLXJMy7rEBxdxWaxRxmqIrSnXXIelBKg6phHJ5aGb8mGXEjiGo0DwzCyWJRWdKgxR6f4Fyw+MwYniQ/J9V1jMBeP/wytdz7PhN6k5Wm+LXYLgt9xYYv5ia9/rG7KRaY2gO7T8KydCKZNwtWx5XFmysuKrRYdWt4ZW1VJg+gi62tD6XdAXJqPZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(346002)(396003)(136003)(6666004)(6506007)(41300700001)(6512007)(53546011)(26005)(316002)(54906003)(6916009)(86362001)(478600001)(31696002)(6486002)(82960400001)(38100700002)(83380400001)(2616005)(186003)(4326008)(2906002)(36756003)(66946007)(66556008)(8676002)(66476007)(8936002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdPdXh5WjRZWHlMR2V6TW92d0RabG1pS0lSYVhmMjVDQlpOamtQRzFSM0RU?=
 =?utf-8?B?a3N3bFBORnVRSVNNcXZIeWQzQXREbERTT2Z5VFU1VUt2STYvTmZ3V01VMXNu?=
 =?utf-8?B?MXpUalZlTm1HNnlPR0NadjBqS2dqRnhpMlJoQWRRZE15cjk2UEt6RkprUXdy?=
 =?utf-8?B?N1NLWTZxeDZWZml1NTBsWVMzOTF1R2FXTS9TSGptczZHZUluY29pcnB1am5K?=
 =?utf-8?B?RC9Vdm1rbDFTNnBJeFdkWnlZN29hZjA4NFo1YnFSaUZFT09Od3dDbURsdjhO?=
 =?utf-8?B?aXN1WDY5QitaZjlaKzhIMm5acGJiSlB6S2JsK2wrZVp0N1NHdjBjVlB0SEhH?=
 =?utf-8?B?eCtWT3NDNGg3dW5Vc2h4ckMvdXdQOXBING9paVVGOENxdDYwMis0SE8vczhw?=
 =?utf-8?B?RUE3VVhybGRXeGsxRGhQUlY2L0Z2cnR6TDlkcy9pTHJCRmlZUm9RN2VSaCtW?=
 =?utf-8?B?dVg0RlpTZFowZnJaOTZ1UEhmd0dNUmdTcGltT01PNVV0eFZ5WG94YmFHR1hp?=
 =?utf-8?B?cVFVSWx5N3RDbnl5TXFZYzEzdWZ1cTl6NjRnai9FaFJEYWJLS3kvM0Y4cSsz?=
 =?utf-8?B?MmlFUE5hMS9EcDY3TnhWU0l0ZWxtL1ZBZkV2VUNOcjlCTkNrOVJONE5acjZp?=
 =?utf-8?B?Qm1GU2NqcUNpV04zZGdjMWl0dFdCNlJFMHQxWWs2Z1cyNnU5Qm1nWjlyUkNk?=
 =?utf-8?B?QStBdGVwd3ZkSnA0S3BMYVlzMkpjTnVSNFhlNVpwZmRiSlF0UkMyRTRCOG80?=
 =?utf-8?B?aXRESlc1SExKc2dLelZmY2tSTmFaVkNBU1VsQ0pJc01Wd3ZBL2xVTkdSN1Fa?=
 =?utf-8?B?M2J2MmQxNUJ2VER6TW1ETE9UeERUUTZ1cEZDKzJiRStJWk84WFdTZjJqWURn?=
 =?utf-8?B?QjNUYVV1V1JCTFNlZ21qR3NUZXJubkJDalhDY3g1U1dEQmwzN3NqQ1c4L2N2?=
 =?utf-8?B?dG83RnBULzVyYlB1ci9KaHNaeFNGTlFWd2JPRzAxeHRicE9iYmRGeHMyTE10?=
 =?utf-8?B?cUdURjJHc3MxbkVLMmdyR09yd0c5Q25BbW1IcmcrbHQvaGJMaVB1T1FDUW50?=
 =?utf-8?B?dUVuS2ZDVi83UStVNUJ6bFF0d28xemtEaGxKSjBvS2x5OW1LRW8xUVhHSjZy?=
 =?utf-8?B?OEd4NWNvSkxoOXlOWGdRN0pad0xoVy9vcVAxbzU2QnZkZjRwQzEydjFxU0NI?=
 =?utf-8?B?L3hVampOc3RxWXlNbXhuTWxWSFNONWVPV1N0UksvaXZwS0p6MnFjSGtLTngw?=
 =?utf-8?B?RDhVcFZZOEVGYXBYVVBtSXFyQzB6ZGxKMDY1NDBHUGNzaWlvazRHUjBiS2hE?=
 =?utf-8?B?eHVIbnBUUWlwV3ZaZG5CSDBWUm5yUVBMOVdOQlcyaU9zMzhHK28wSmd2SkVQ?=
 =?utf-8?B?bTRRWHJNSnpObkFZSEMrQ3l1d01CUVNFWDJzLzFUTElTanpsK0FhU2lLbWV0?=
 =?utf-8?B?bEVFQS9CeVdJeEp5ZnFlYm43UExtN1dPb3BDN0FNemxkdW1YSlpTNlpER2w1?=
 =?utf-8?B?UGRKNXpIRWxHam8xYVpuY3FWeXNVMXRoVUZEbXZmQ0lybXNWUjg4QkIrekN3?=
 =?utf-8?B?bGJJQkZXQkNSUnpHSzNOUW01SThQbDZPcXg0M21QaCtwUGdMQzlnRVNkL3k2?=
 =?utf-8?B?WE5LUld4TVJhS0cwby9MaXp1YVN1RGE4MEgrZ3h3NlI5SWUrMjExbmFwQW1O?=
 =?utf-8?B?Q1JNYjhIaDlGOGNUdzVhUkhTejdkTXhlSllMR1ZRR2ZnZGJsUjFiQXBIUitq?=
 =?utf-8?B?ZVNJaDhUakc3blovKy9TclRBUnV3bU5KaTEveG1RTnpsRkVRekgzbjVSWEN5?=
 =?utf-8?B?Z1Q0ZTYvbDFOYi9ydHV3ankxanpYMGllMjhoYUVGc0d1YlYwY0NSQ0lzLy91?=
 =?utf-8?B?QS9UT0VCWU5LYkg0U2tjVHNwOFBhT25yMHlBNjJZOG4vWjFlbVlIZnVPbzNa?=
 =?utf-8?B?c0o1Zmg2ZDNwbFkyZUxVZ3RwWHlFaXhaMWdVRFhUTGQySU5CZ0hEdHJ4Wkxn?=
 =?utf-8?B?STB0MVlOUWJvU1cwUnlzL3ZlVHVSRml2U1hPK1lrSk16eXdsbVhSVUc1Z2ph?=
 =?utf-8?B?VU9KME15bXZCSlZaVmVoeTF3emM1ZHZiTE55Q3FmaDUzNUZBcDlwNXNHNldx?=
 =?utf-8?B?dFIwaVBNc2F1NVlOM2loanZJNUVXWE5BQVlXRjVxRGpKUWZvcjRnNXltNU5m?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 844f13c3-af90-477e-0820-08da745a0866
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 07:38:46.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpQFuQJvnemYZh1cYzM5ZXUonBMoyCjeWH7NVbRvs+F2P+9E0/+DQkQRMneHt+DvJkcNEoDnbZlaKeqScX8CGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2022 3:15 PM, Mike Rapoport wrote:
> On Mon, Aug 01, 2022 at 02:48:36PM +0800, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> Add 129th region into the memblock, and this will trigger the
>> memblock_double_array() function, this needs valid memory regions. So
>> using dummy_physical_memory_init() to allocate some valid memory, when
>> memblock_double_array() choose a new memory region from memory.regions,
>> it will always choose a valid memory region if we add all valid memory
>> region, so the memblock_double_array() must success.
>>
>> Another thing should be done is to restore the memory.regions after
>> memblock_double_array(), due to now the memory.regions is pointing to a
>> memory region allocated by dummy_physical_memory_init(). And it will
>> affect the subsequent tests if we don't restore the memory region. So
>> Simply record the origin region, and restore it after the test.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>> Changelog:
>> ----------
>> v2:
>>    - Use ASSERT_EQ() to replace assert().
>>    - Not to expose memory_block, and add a function get_memory_block_base() to
>>    get the memory_block.base.
>>    - Add two functions for common usage, and now it has been used by this patch
>>    to allocate many valid memory regions and free them at the end.
>>
>>   tools/testing/memblock/tests/basic_api.c | 54 ++++++++++++++++++++++++
>>   tools/testing/memblock/tests/common.c    | 38 +++++++++++++++--
>>   tools/testing/memblock/tests/common.h    |  6 +++
>>   3 files changed, 95 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
>> index 66f46f261e66..46948d5a975e 100644
>> --- a/tools/testing/memblock/tests/basic_api.c
>> +++ b/tools/testing/memblock/tests/basic_api.c
>> @@ -326,6 +326,59 @@ static int memblock_add_twice_check(void)
>>   	return 0;
>>   }
>>   
>> +static int memblock_add_many_check(void)
>> +{
>> +	void *base[INIT_MEMBLOCK_REGIONS + 1];
>> +	void *orig_region;
>> +	struct region r = {
>> +		.base = SZ_16K,
>> +		.size = MEM_SIZE,
>> +	};
>> +
>> +	PREFIX_PUSH();
>> +
>> +	reset_memblock_regions();
>> +	memblock_allow_resize();
>> +
>> +	dummy_physical_memory_many_init(base, INIT_MEMBLOCK_REGIONS);
> 
> Why do we need this?

I want to memblock_add() 128 regions that every region has a valid 
"physical" memory. So it can make sure the memblock_double_array() 
success when add a 129-th region.

In the last patch, I didn't put this function here, I just 
memblock_add() 128 region at here. And after I think if we can 
encapsulate it to a function, later it can be used to init some valid 
memory regions into the memblock.

And if no others may be use this functions, the function is not needed.

> 
> dummy_physical_memory_init() allocates the "physical" memory, so to trigger
> memblock_double_array() it's enough to memblock_add() 129 non-intersecting
> chunks in the range [memory_block.base, memory_block.base + MEM_SIZE].
> If MEM_SIZE of 16k won't be enough, it can be increased.
> 

Yes. And now MEM_SIZE of 16k is enough, no need to increase it now.

>> +
>> +	orig_region = memblock.memory.regions;
>> +
>> +	/* This adds the 129 memory_region, and makes it double array. */
>> +	dummy_physical_memory_init();
>> +	append_memblock();
>> +	base[INIT_MEMBLOCK_REGIONS] = get_memory_block_base();
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
>> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	/* The base is very small, so it should be insert to the first region. */
>> +	memblock_add(r.base, r.size);
>> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
>> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
>> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	/* Free these allocated memory. */
>> +	dummy_physical_memory_many_cleanup(base, INIT_MEMBLOCK_REGIONS + 1);
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
>> @@ -339,6 +392,7 @@ static int memblock_add_checks(void)
>>   	memblock_add_overlap_bottom_check();
>>   	memblock_add_within_check();
>>   	memblock_add_twice_check();
>> +	memblock_add_many_check();
>>   
>>   	prefix_pop();
>>   
>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>> index e43b2676af81..960b3ce07696 100644
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
>> @@ -58,10 +56,20 @@ void reset_memblock_attributes(void)
>>   	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
>>   }
>>   
>> +void *get_memory_block_base(void)
>> +{
>> +	return memory_block.base;
>> +}
>> +
>> +void append_memblock(void)
>> +{
>> +	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
>> +}
>> +
>>   void setup_memblock(void)
>>   {
>>   	reset_memblock_regions();
>> -	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
>> +	append_memblock();
>>   }
>>   
>>   void dummy_physical_memory_init(void)
>> @@ -75,6 +83,30 @@ void dummy_physical_memory_cleanup(void)
>>   	free(memory_block.base);
>>   }
>>   
>> +void dummy_physical_memory_many_init(void *base[], int cnt)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cnt; i++) {
>> +		dummy_physical_memory_init();
>> +		append_memblock();
>> +		base[i] = memory_block.base;
>> +
>> +		ASSERT_EQ(memblock.memory.cnt, i + 1);
>> +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
>> +	}
>> +}
>> +
>> +void dummy_physical_memory_many_cleanup(void *base[], int cnt)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cnt; i++) {
>> +		memory_block.base = base[i];
>> +		dummy_physical_memory_cleanup();
>> +	}
>> +}
>> +
>>   static void usage(const char *prog)
>>   {
>>   	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>> index 3e7f23d341d7..848900aa8db6 100644
>> --- a/tools/testing/memblock/tests/common.h
>> +++ b/tools/testing/memblock/tests/common.h
>> @@ -11,6 +11,8 @@
>>   #include <../selftests/kselftest.h>
>>   
>>   #define MEM_SIZE SZ_16K
>> +#define INIT_MEMBLOCK_REGIONS			128
>> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   
>>   /**
>>    * ASSERT_EQ():
>> @@ -68,8 +70,12 @@ struct region {
>>   void reset_memblock_regions(void);
>>   void reset_memblock_attributes(void);
>>   void setup_memblock(void);
>> +void append_memblock(void);
>> +void *get_memory_block_base(void);
>>   void dummy_physical_memory_init(void);
>>   void dummy_physical_memory_cleanup(void);
>> +void dummy_physical_memory_many_init(void *base[], int cnt);
>> +void dummy_physical_memory_many_cleanup(void *base[], int cnt);
>>   void parse_args(int argc, char **argv);
>>   
>>   void test_fail(void);
>> -- 
>> 2.30.2
>>
>>
> 
