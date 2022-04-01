Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09D4EFCE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiDAW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiDAW5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:57:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87410CF17
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648853721; x=1680389721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iYG/mQ9vX7ap7vKXpiz0ZbmB+vYsaZDNqIxKobdMPzg=;
  b=SlM4r/YbYhzNAyLH/qq+WsbE90QladqIJZXTXa0cq3J2Yc0LWgPC3siR
   i54qpkRKb4usYZ9q2fQOySsLildQjgEsNHuPwxHVNURKKBXw9lHwpH4Nq
   YKf+v3v2L6TK4FibzxAMGm7cqutnFJoKvIk/qHPD3UYb7WGDIhRh8CMrN
   HnVUg48g2s/5mEqgIQBI6My740/hl0OVzPD+6Fg8YyPmw/yVrDesxvrhq
   sdu6MmglS2VwBvoBXN4CujytoB8V78UkNWfIAaNG8TtbJmePBWM3IUSKa
   c4nNYuy7H7h6KOaK1wX6NkmhfZn9eKelN6Kf2IHU6xX9mquiHOPTbM13X
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="323422534"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="323422534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567887187"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2022 15:55:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 15:55:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 15:55:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 15:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnxwqBnUJOoNeiqH6PLAsJv38PKmY/1bYBmNraQfS8MbW9GwMnPjjLG+mJG0zbnj38vT7SnTSH0cmAyk4FLueb8/jXykC9m4h3lLbbIOqxwWFgo8eLRSUVhAvEurvJoFu2ccCa20vAZWzbCcmbuvAurebW44i1gZ7XC8rmU1/jH4IGFtQ79l/fVvappc5DJ0L7IAkretxYeTS28yHoUrqwO3RnPWEtS1frbYIfzpQvgR2gAp1SmQ+LciPRZkohXpJXY12439GRiLpjmacKQa6vwNcMbvotSbmwYEdPCcri0ctD6S1VgmW9+1nojQ29VLEVUQpUKtAttkr5L+iimzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws3wKCOHJxuPlSs/b3qn9PMCso8Ky3egDcOZFUok4dI=;
 b=BVZZ+SnwZ/yCJu778uY24B4R7SHo6spUT9WYSwWGZegR5cxD9iDIaC42Sy0U2CADC7ZNWw5O4iN7WLxAtDyS4iOI27KXPdD35+vS2gd58U9CrZTqCsLK3fvdWeuVdUQVKfJZepR7CH4FdZXuo/TGBVhoKpf4zgp39zFEEhtvkxL6TRUcVgxlN4mpbuk0YnHEwkNIcO7uxdIUf5musQlE+41uxZCPgQ0RBHS/jQZsFhnuDziCEng2WLwTceq0PR2ZrYkudAZe5IrCOvfZPlpnov+n4wBjnZf+jUF3JLPy+fMocZEZB+R8tXPKh+O746oU2ADL117aEXTXVEbJW/Kq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 22:55:17 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.029; Fri, 1 Apr 2022
 22:55:17 +0000
Message-ID: <72d7ca0d-7235-2ac5-4639-38d27aafa222@intel.com>
Date:   Fri, 1 Apr 2022 15:55:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 19/21] x86/resctrl: Rename and change the units of
 resctrl_cqm_threshold
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-20-james.morse@arm.com>
 <87c00fe2-e4fc-b006-f608-3dc2a209ed77@intel.com>
 <1d4220ef-277d-fbb0-edb7-14f09bae0c23@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1d4220ef-277d-fbb0-edb7-14f09bae0c23@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c26e22f-babd-47cd-8494-08da1432b096
X-MS-TrafficTypeDiagnostic: SA2PR11MB4859:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB48592A0CB997662ED00CB0FEF8E09@SA2PR11MB4859.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdtDZj1rO/miIzbsO3stp6k2IuaE0nwF1U4ZWce4BXorhdYtV3eJ67C7OCz0ehTjPeTyH4G/aMy4BOrZjYvXvMQDhyJYruRVGk+eZQgvDXytvRSo9ujDKHebk4AR6ofj5Z7lUro+6i58idmkAAcU6QFweM0ulJpVp0fps/Gil96T0JYBBfFc48yzsLUlk4gHSE2me0cE6PT05AdmDTI6oIAAAarjCxF4K1xw07Z7JucKGQKcUsJUQsKlgD00FdlGWtQgqLsuWUPPLpwoFegl1nxo3tDC+eC38HMpEfPBzO6qgxTvd7JNu5ML/ATsVjEvYZo/kEUwQYiH+7k8nXrvmUvub4CEscNu7M8dD4jPLbJ1J1+k2Av6rDx7u7s0gxsIQzWprXn1f+AglQfCefhgCziQqn72R5q+o609d7RnFraIKch4wWTSYxBU+HU3VNhWBumlLU9O0CsWgQROx4uyB7mo8pJzzMPvZseszDfO43U73B8VWGzKERH1jXJ+xQ9OWTnWZcGAb9Lws5Rd7B6ern/QQ1VlSCnq3+QuKHTlWJ8GCwUyFPfcZAQNNhzUKQF/rc8c4o2Zw+XEplw0I6kfTC9xEejR7dY/uz4ZzN9H8BM/IcS7c91C9hv0zo1XMUBOC2kYO1kHec9Ox0C7y+i092nVmvkFg46TpY4di95RxCNj84TxLrMQ8K3c+1an9q4qjkcOB2SjC5b6ExGNLchmS9nT0qCBDC34jdlExxH/haI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(54906003)(53546011)(316002)(2906002)(6486002)(6666004)(6512007)(6506007)(31686004)(508600001)(66946007)(86362001)(66476007)(8676002)(31696002)(38100700002)(5660300002)(66556008)(186003)(44832011)(4326008)(26005)(8936002)(7416002)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1Y4THpnZW9CM0tIdVhNczNJemNGekVhMHovRzM5UnJMSDFXWjNudThxc2x2?=
 =?utf-8?B?a2ZKNnVtS25aNHROK3pzRy9PV3lUL20zSkhQajdEMHdJQms0QlRjbXJDQU1E?=
 =?utf-8?B?OHFZbGZhWXR0M0NKbk0wNWdoa1NEUk1ENk5DOEhpbWFOMVpyUDlJQ0pGQ3lW?=
 =?utf-8?B?QndsNk1TSzYzZS9rM29zU1dKRnMwWlV3eFRmeG1FUVBXRVlNbVFaaC9SelNz?=
 =?utf-8?B?QkFjQkRlZ3g3OWEzbEMvVTEzM0gzcmZPTUJ0NUxsU0VEQnNvWDhZckQ3U2ZK?=
 =?utf-8?B?L1Rha2l5OFp3L3pzY0o0SjVTcVMvUno5aWVWOE1mTEhVbDA3d01JcWlQUTFj?=
 =?utf-8?B?SlIyUnVIdGdONjZWZFRhY1N4cjFtTDI2VnNoZURVMmRZaFVVd0N3Q2hyRFJh?=
 =?utf-8?B?MlA2RUVkVDluaW5aQy96enpYTUc1cXJ5NHJES2llNS9oUTZ2MHFXUFhkMkd3?=
 =?utf-8?B?bXltRVk4a1JmL05wK0oydk90NUkxVDl6WFdPc1BYV0pqbm1YRVVwNWJ3Y2pt?=
 =?utf-8?B?eUx1dTNBVUM1MUE4elJEOVBuNDAzeUtlT2VCK1JDb05OekwvUDU4VUNtOHFL?=
 =?utf-8?B?dEd4M3U5VGI3R3Z6TmJmaisvSzlaZWFWcW9FVWRRcGpVUHJZb1praEQ3eGIy?=
 =?utf-8?B?Q3VJbFhpdzlYQVNYWUxnRWZaQjVnWHgwdjB3RktqcHo0RTYwWlhCUWdYRUMr?=
 =?utf-8?B?WlgybnEyWjBxZ1gwTy9IcXNYNXQ3bnc2NkhBMWFySS8zak9GeGVIa2pxaTZ0?=
 =?utf-8?B?NWYxYzdBQk1VVnB5K245dE9YSFFZamROcXB2QWc5NjNYV3dDeEUzZVRPVXd1?=
 =?utf-8?B?SFBPOWFWY2tXMEhOOEx0ditEdHQ4N3ZzMlpkSkczdmM4K0pSZitweEVCbkxk?=
 =?utf-8?B?WHhOY0hvQzlSelh6bXBDdjVJelBqS1dOQTV3eW4vQ0JndW4xRnNrbkg0VEtG?=
 =?utf-8?B?QVRwYWxiSDBKYlVHL3VtOHA4ZUVtSm5OUUlyMmwvNWhtbmU4eWw4UUtIV1FF?=
 =?utf-8?B?S3EzNkVIOW10bmFud1V1eTdUb0RwbjZOSEN3bXBmTlp3Y25yd09lL0M3c2xq?=
 =?utf-8?B?RzYvS2ZZdldBbi8wdTdjd1FLUjF6UGhSaTY5bEtMUC9JeGVvRUtDK05GWUVB?=
 =?utf-8?B?S3M3TE1tSU1tRDF3ZmN3RTMvUUJjVGplZFViQlVIVWxnTythSElGa2Y0aHIy?=
 =?utf-8?B?NXF6cG1BWjZpWmNMVFE3MTh4SGdlWDJlNzRSNkorbkREaElBSnpUYm5LTDNP?=
 =?utf-8?B?TktjYWNJSENaZlZtRkxFWFdtM2c3R1JkU2VmY3poWnZoY0g0VTBVOWlkZENU?=
 =?utf-8?B?ekVsVGQyL1dsZmZpRGJob24wTnlpRS94RHdwYk5oSzcwQUxEVjU5VDRrbGZU?=
 =?utf-8?B?a3JVM2ZFZGN4bHNHdVlvNGUxWnhYZ2VPNHBVZmRDZ2FJdSsyY0hueVRGQU83?=
 =?utf-8?B?TFB6akpnQjZxY01VQUVjeFNLUW93ZXErOUJkdWs1b3lRNWdZdXd1cTN0cGRP?=
 =?utf-8?B?KytTNlhzeTlJQ3pKNVhmZzdiSXk2NFExUlVOeU9yZyt6UlBiazFlZ2RGc0Fi?=
 =?utf-8?B?N3VTdy8zNDdldklWSCsxdVR1L2pocktVQ2lpQVNXRFVvY1QyS0tiblQ4eFBP?=
 =?utf-8?B?RTA1VmpWM2FOL2U1R29ENXZ6UVdXbUhINGpBZVNJY3BKeXliME92SlpINW55?=
 =?utf-8?B?YXlxSlF5V1N2Qnd3OFl5YjFyb1ErUkMyNlJVNjI4ck03MVgyZlFzZ01SM050?=
 =?utf-8?B?VTF3NFBiM1Zyb0thVGM3SDRGTmlYOEVBaHdZb0ZVWlJvVHdNWGdKNm9GRmhn?=
 =?utf-8?B?b1NicDRrSDhxV0pHTDFvaXp3cHRMTlg3K2FWM3RLdUNxbHJrQnlTMDdqRk1F?=
 =?utf-8?B?cjdENHRTZm9meTE1Z0gvaXNtN2J4RUdOU0JXZ0pjeXpwMmRDbHY0S2hQRVNL?=
 =?utf-8?B?VSs1a0VMR3R3RWk3UUtJbUEwdzdHY3FOdXdOb25zUGlPclZtWEtkWjh6Y2xZ?=
 =?utf-8?B?OUl4amtlTG5sRGtBYk1yTm9NeHZ2aEJ6TkxZYis2ZGVHdEtXenF3a3cyRkgz?=
 =?utf-8?B?NkZSY3lQd1VYclE1azNkbFR6bHdwTmo0bFdsTElPT0c5WlAveHM2UXJrakpP?=
 =?utf-8?B?ZzUyMzZMbklwN3ZhZnZEazkxempVeTdZd2t3WS9RRGNDVGpKUmI0eSsvbytt?=
 =?utf-8?B?bkl5czFFL1dwWmc5cVlYL2NqV2s1aDR2OERmREh1N0xzeEZ2Q2h5d2RDR0pK?=
 =?utf-8?B?Mzk4Zi9TdnNCVEJDYU5FVEYxSDdxSnVCSlZRUTNJamoxMDF5T3FXaUVqWFJH?=
 =?utf-8?B?WUgydVVWdkEvZTA4WFZYMDdNZ2lUVE14WkpKTGZiYk44UGNCaUR0aXlhSDlO?=
 =?utf-8?Q?uoWJP4hZ8J8GIyFY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c26e22f-babd-47cd-8494-08da1432b096
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 22:55:17.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAegrgXXlhwTnzX332cpdA/qZYnFKa+eNjSJOsnqNePkMnZJSy7gUaTohyz0xNWccEKyR6TZnUy6vIj7HC5p1JrGD7dXSavPW01vpDvm1no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/30/2022 9:45 AM, James Morse wrote:
> Hi Reinette,
> 
> On 17/03/2022 17:00, Reinette Chatre wrote:
>> On 2/17/2022 10:21 AM, James Morse wrote:
>>> resctrl_cqm_threshold is stored in a hardware specific chunk size,
>>> but exposed to user-space as bytes.
>>>
>>> This means the filesystem parts of resctrl need to know how the hardware
>>> counts, to convert the user provided byte value to chunks. The interface
>>> between the architecture's resctrl code and the filesystem ought to
>>> treat everything as bytes.
>>>
>>> Change the unit of resctrl_cqm_threshold to bytes. resctrl_arch_rmid_read()
>>> still returns its value in chunks, so this needs converting to bytes.
>>> As all the callers have been touched, rename the variable to
>>> resctrl_rmid_realloc_threshold, which describes what the value is for.
> 
>>> @@ -762,10 +763,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>>  	 *
>>>  	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>>>  	 */
>>> -	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
>>> -
>>> -	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
>>> -	resctrl_cqm_threshold /= hw_res->mon_scale;
>>> +	resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
>>>  
>>>  	ret = dom_data_init(r);
>>>  	if (ret)
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 7ec089d72ab7..93b3697027df 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1030,10 +1030,7 @@ static int rdt_delay_linear_show(struct kernfs_open_file *of,
>>>  static int max_threshold_occ_show(struct kernfs_open_file *of,
>>>  				  struct seq_file *seq, void *v)
>>>  {
>>> -	struct rdt_resource *r = of->kn->parent->priv;
>>> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>> -
>>> -	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
>>> +	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
>>>  
>>>  	return 0;
>>>  }
>>
>>
>> This change has some user visible impact that I am still digesting but thought
>> that I would share for your consideration.
>>
>> As seen in the above two snippets, the original code did:
>>
>> resctrl_cqm_threshold /= hw_res->mon_scale; /* resctrl_cqm_threshold used internally */
>>
>> resctrl_cqm_threshold * hw_res->mon_scale; /* this is displayed to user */
>>
>> The original loss due to truncation during the division is not recovered
>> when the value is displayed to the user the user may see significant differences
>> before and after this patch.
>>
>> I tried this out on a system with a large cache and the before and after 
>> information is significant:
>> Before this patch:
>> info/L3_MON/max_threshold_occupancy:147456
>>
>> After this patch:
>> info/L3_MON/max_threshold_occupancy:196608
> 
> Hmm. I hadn't considered that information would be lost by the current way of doing this.
> It looks like this happens because num_rmid isn't necessarily a power of 2.
> 
> 
>> As I understand this change indeed represents the information more accurately but
>> I found it noteworthy that this is not just a simple "change the units" and
>> may thus have broader impact and may indeed result in different behavior that
>> should be considered.
> 
> I agree it more accurately reflects resctrl's calculation of "the number
> of lines tagged per RMID if all RMIDs have the same number of lines", but if that
> produces a number the hardware will never actually measure, then the rounding is still
> happening, but somewhere else.
> 
> I think the right thing to do is round resctrl_rmid_realloc_threshold down to the nearest
> multiple of hw_res->mon_scale in rdt_get_mon_l3_config(). This way the filesystem parts
> still handle things in bytes, and the architecture code provides the quantised value that
> will actually get measured. Its this value that should be reported to user-space.
> 
> It doesn't look like the 'Upscaling Factor' is guaranteed to be a power of 2, so I can't
> use the round_down() helpers.
> 
> I've added this to the commit message:
> | Neither r->num_rmid nor hw_res->mon_scale are guaranteed to be a power
> | of 2, so the existing code introduces a rounding error from resctrl's
> | theoretical fraction of the cache usage. This behaviour is kept as it
> | ensures the user visible value matches the value read from hardware
> | when the rmid will be reallocated.
> 
> and the hunk below, which fixes it for me.
> 
> 
> 
> Thanks,
> 
> James
> 
> ---------------%<---------------
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index b18e227d585c..fb81d650c457 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -753,6 +753,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>         unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>         struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>         unsigned int cl_size = boot_cpu_data.x86_cache_size;
> +       u64 threshold;
>         int ret;
> 
>         hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> @@ -771,7 +772,15 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>          *
>          * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>          */
> -       resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
> +       threshold = cl_size * 1024 / r->num_rmid;
> +
> +       /*
> +        * Because num_rmid may not be a power of two, round the value
> +        * to the nearest multiple of hw_res->mon_scale so it matches a
> +        * value the hardware will measure. mon_scale may not be a power of 2.
> +        */
> +       threshold /= hw_res->mon_scale;
> +       resctrl_rmid_realloc_threshold = threshold * hw_res->mon_scale;
> 
>         ret = dom_data_init(r);
>         if (ret)
> ---------------%<---------------

Thank you for the added explanation. From what I can tell this also restores current
behavior.

Reinette
