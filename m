Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F524F46BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiDEUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573383AbiDETBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:01:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E7DA6F0;
        Tue,  5 Apr 2022 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649185191; x=1680721191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cnIE4ZoiPBqQnp/oE8azTYxXwaH6d4y320m4zhZDNVc=;
  b=HTqKrxEYHwKzS52XRmfdH+uJSu4dxv1J0E67F6f81Jfd8DWJ4KBqPZs7
   Dp8gTWT2Bl1XbNnoQFTFe4HZFUhwns4JnKlnWCi2V9Kfuf3vneGekjrma
   8tmXQndCHw8nzy3f9tU0AsY+vgMfL7t0e3Ood8c2KTSpO9CrP9LuQZ2Xs
   2EISN5elXF9zE4jjfQk/+0YcVWlu0/o8rIG7hhuBJ5+hLBOwksCFs9QOJ
   O9xW459NwmqqHzLyjDlSNknBtGjk3Otb2ySW7ibF7x1jrWWbJHlt3FbH0
   ovhom8EUFsPODnZp0IIXBGT5X8OPxQ0XyobiRBSHRrp/HOMhEFkRWr9eY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240774595"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="240774595"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 11:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="588047240"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 11:59:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 11:59:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 11:59:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 11:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaAeRXQ3rWG2Eks1IyO+qkvjD2MHa0rzIo5DF+zUmWJUxCK6lth3gF6wlH1m9gH/gn2ga2iBAmehgQg9Jdh2PW10VG8r0ZrUvW7y9hdA13adUPAvvkDc0qHZz9PA2/HjIkeRZdI6KTDTQQckNkvb9/ZwZR+W6ThxT7N59c42KsQBZ+JG/cC5zPfwjHo2Zc4tW35zw0BSmyzTy8UWgag7woqsaR3SGIqdqHVEfmplJzwnTcJvTzCaVn2SN1s5QdjADuq9Jv0iM4LJNCUr+YGvsr+ajt6OFV+IquyKV8KGBXwWPijg/F1WlPYDcRZb3fiQbN9g+2ETqT0Hxbw5THSTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpTvogofZqgVWN/qVydGHJnM/2T4bxjGI1ejdL0yi3g=;
 b=Vbnj0T6nZiyMmMcQJqv6d3Dx7H7bAaH+0TEoAm5CgJO5WM3zzQ/gwzXed8XyLuCdH8Yaekn+TfDlou38U/5JMkb6CRvRTbVCeG+N2F/kZTaOsLZdTBvIPuFLpTTSFrSRYAm8UGeRaE+MtXkMvYPlqN8FFHdVzEZyPi8ZSVa/r2XStrAO1Bb7d5KzlhyIQv5a+e2PR4ZjDM8qpY2F37s/OIFq3vSuCp7BunH6Nyjg8qbitWmcMPntLLKzFs38T8doyDZVlRMun3Y/A0LZXDwvAE8k2Y2uuwUjMQ2aIDxVVcabwCAlYYDKJgEJLx6ic9c03zGAwkEoPvU3ipLGK0j+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 18:59:46 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 18:59:46 +0000
Message-ID: <38603303-f683-cb79-57e5-57fad5c5ae3b@intel.com>
Date:   Tue, 5 Apr 2022 11:59:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 14/30] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <nathaniel@profian.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <8ed9ee98ca26c9eefde0fd49062bca6e7b9efe80.1648847675.git.reinette.chatre@intel.com>
 <c9071aa19076c7c618294f0c9cb830a8be96ae09.camel@kernel.org>
 <26ab773de8842d03b40caf8645ca86884b195901.camel@kernel.org>
 <91a02d50b2cba34dfb058fd864ba20ef1e6a5554.camel@kernel.org>
 <10303ca73ea02a300636580e87446766374f66cb.camel@kernel.org>
 <6e0feeadc562b9e3f0a524040469d4f5c3484824.camel@kernel.org>
 <ca08465b6fa8af4121592c6381023fda5e0ade70.camel@kernel.org>
 <59910ad4-a898-4eb2-5e2b-856c686b53fb@intel.com>
 <0f44fba956288bcad69e076f84118bc50f8e5d2f.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0f44fba956288bcad69e076f84118bc50f8e5d2f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78edb2f2-9fce-4788-1b00-08da1736734f
X-MS-TrafficTypeDiagnostic: CH0PR11MB5300:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH0PR11MB5300427ABFB800FF5724CD19F8E49@CH0PR11MB5300.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZwxwvDqH/efKeACRGBN+FpTOzfHUrDL8McxPXG/jjQoOPTdjvh5zsZU27ndGweC+DUHfi7T//jA9mTY93uBC/R9eruo1+5H5hdd/G2GzBeYxxDC0PiScm6ltLOoisLpMJncZLXYoTcSOXj86VAWkDtL61zlTtb7lo7YmIquvuhFvXjNPkFYEDHw9yY9l3QC9R6k3joxtD4K1jwhP1sX2ukjsrlKjIBpZqf9cYsuXmrvcaYdyd6mBs8uhPI9JS7xVoaZ+F+Z5qnVDdJQXl7LiOmGVnAtI5O9RwdAwDHvqy22oY5I4zhXRD37b+9xBbwG3Y4v+dsIZEU+yXNAaE4Y3wk9pJnjVfWEXcVaMBJyF4y4w1PNTLTCIKZYg634CqzfkfcctaEaVVhMz1bqT3yqxzGl4tK9aYsLu0noETkoAUM3jM4cOoGHuAzh4WOOOJPqrpwEjAiCkij7O4djZLFcmy9CrOdpLepF/CO5KhNwcdvC+roiM/5TJrULGOY/BIe6hzCWvLhIr8Pf6LkaxLyJuj7lUwtzWiGpAVcqiOYCAPuDZ1X4CStKNLRH0nS141NVZhpMNcSMbXH77YfaWqyLrfc0FRZYWUioQqO35GeomjmB8T17d8r1EtSxjKlNP5HsoE9N64u+LKJteGxqpFWK7JvDMinnR/AfME//aeAwC33MndMA6vso3uhZRkM4ghfufh3mYstLRr9VYtVmhl/VcZoFGC8zn9KeeSwdO6H/icxLgZD3Iz742sgfOU+i0OYvcD4baF2oQhplDoc92TOJVvYkqutNSIepby/ooeKZlGiWTK2uRCuFJP5ZLI5h0HN3OKFC1+av9D658NUw48bspfI1dJhXS+dfn15t1exKWQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(2906002)(6506007)(186003)(26005)(53546011)(5660300002)(8936002)(83380400001)(7416002)(31696002)(44832011)(36756003)(66556008)(66476007)(4326008)(8676002)(66946007)(2616005)(6486002)(508600001)(966005)(316002)(6512007)(86362001)(38100700002)(82960400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUtNVy81Y3g0R2lxdTBjMWtLblgwRmQyZEprVFFDTnRCUE5MVUsxOHVrSTJO?=
 =?utf-8?B?eU55WHFzVnUrYlY5TzZOY3ZCdVNxaUhuUE5MMHZjMjUxTUIwQzZkb2c1L3d2?=
 =?utf-8?B?Si9RZWVnYUxvSjdCcmNudDlVcVg2ejE3Z05USnpTejAwaExyYy94R0JnbklD?=
 =?utf-8?B?bFg1ZUJDZmJpUkdmTWRaV2ozR210SjhJN0JGUjFaYVVVang5c2thRTdLbVVl?=
 =?utf-8?B?eVdiZHI5Q21UZjBwR1RmVUxaT29RSTU1eDVmbDFkZ1BUTEJzNERlbHZyaFA2?=
 =?utf-8?B?WklTUTBjMFpiNElnbHR5WE00WjZFNmZJRktabU5EYnFHRFFNMThmV052dnpl?=
 =?utf-8?B?anFiUHdhMVN1N0l5U0N2cmgzbE9tQW1TdEV6MlkzZzZrMERwVEt2TGVWOExr?=
 =?utf-8?B?SENyalpJNkEyM0R2RWdPdlBjSlg5ZVhjMWxsYzR0NFFrdUpaTkJtanJrS2lp?=
 =?utf-8?B?VDR1bms5UU8wdlZTbWtxU2h1V2hmVEkrbEhmb1lvVkhXYXpIRFQyMnBvcFg5?=
 =?utf-8?B?V3RVMzFnVnVnMTBvL2dXUGJUY1Jpc05pc090WHgrUWtveDNIYkJGTWwxSWlm?=
 =?utf-8?B?TCtFUXoxZEpWbUpPUHNBUXo1MEtZU2lma05Sc3FyKyt6NkJSa0s1ZU13dXAz?=
 =?utf-8?B?V0tZRmV4cDM1c1YwQmdUT1JYVVhCZGhMMHFTd3o1ZmF2cVBCb0haTG9OOGow?=
 =?utf-8?B?aWlRWmRJMEpWbFJtd1dOUllsTXRoMWVzKzRwQUpZUWpWRWk2YnNxWVZBemFp?=
 =?utf-8?B?L25qUHVIRFE4eUl3SXZOWUlYMDNCS21mTnhtR3hiK2NNeDJDOHJlZUdLUWpw?=
 =?utf-8?B?RmZsbDBlK0Q5UjJxcERPbyszTlVjQnZ0WTdpc2drejAzYmlQTDc5NzYyQ3NY?=
 =?utf-8?B?NjZEMEpaczd5UmRxTGlrTHREcThJN2c0a2I0KzN6aEUxWUY0Ujd0elFmUmNB?=
 =?utf-8?B?K2lDaW5mYWRGKy9VdE0rV05NdG9udTFnbldackltWk56YWIyQzl6WDVtT0dG?=
 =?utf-8?B?UDNqR1JhR0dwaFVoTzQ1SnNzSWRQZ3daREFKR2xkUFlJaG1PZmd0YmtWZ3dR?=
 =?utf-8?B?MVpoci82U09aY1VsVFIwTHI3Y2pjYlpwUFZNZENlbTAxdWpSVXhZMzdvK2dN?=
 =?utf-8?B?Z0pmVEtHRVVPTGRoZStnUk9jSE1yVElGZmhOMUVFdFlZZmtIVU8wdDFmcEVt?=
 =?utf-8?B?anEyUEpWYUhySmluZmJFbFNSUEp3cHRrM2RSK3NWOEZPNXowNXNBU3h2QUVI?=
 =?utf-8?B?WEhuSllkalJha3FZbk1TVTlxcCtrcXhBOFQreXllQWFOajVmM0pPR0ZjODZ2?=
 =?utf-8?B?dnBicE00OFNDWGxqN2sxMHNBMnpjNFBIYjJqUzRxa3NWYjVzdzJkemlKdS8w?=
 =?utf-8?B?bURlZUZRaGNDNHdnWG8xZzBYR2cxUUlFN2VxRzVRbHB0OGZFODVhUXRuS2NT?=
 =?utf-8?B?NjhEN3ZjRVVrM0dUMERmbGlQZWpGY3JSNzlGM2VubTljcUJwNEI0RmV1Zk5U?=
 =?utf-8?B?MklQN08ySXdGQzJtTjEzYTU3QWFsVzRQS21qajNvSkVzWlRmZmZrOGxCV2JS?=
 =?utf-8?B?Y3h3Zjh6SFFoODA1WnFrUUlWeXlSVDl6V3lWL2p5VWdDVTdxOThTdUs2Y3Fm?=
 =?utf-8?B?SXl6YTA2RUgvbWxYaDFFK1dEcVVuRGVYbmhlRXVkTGFrQzVONWRxQzBndnEx?=
 =?utf-8?B?NEF6MFhFUVJrcEd2ZmQwTjVNYi9IeTh3cUdyS04wZDNXTjRkZ25zcHVmcnRw?=
 =?utf-8?B?MUZNWUV0TnptVW5VM3haaDFSUmp0ZXJKb1U5L3NRMlJ6QmRjVDkxaGIrSDVn?=
 =?utf-8?B?WlUyN2xtdXQ1L3Z6ZTFmZ0FkaXRCbkoxT21nOTl3cmlsbjZ6UVVZU0VSQSsr?=
 =?utf-8?B?N3MyK0RNTlRRZnI1NFgyT2NscGlSY0RFaUdhdFNOZndyaHhzY3pMQzlQRWVQ?=
 =?utf-8?B?ZXlDUXFsN0MvbTlESVFuSmFGUExCcThPNjA4QThrKzc3UFhpZ3hleU44VmtP?=
 =?utf-8?B?NmZXSE1paS9LMzNmUUNGVngvN2szVktxUlVjNmtYckZRd1hZQkg2KzJ2NFg5?=
 =?utf-8?B?SXhDVW5iWXFrcyt4aHN0bUJBZENoMjRML0FXTVdxYW93R3FCcTdUMWhXa2Yv?=
 =?utf-8?B?R0RScnM5RVdZeng1VzlpQ3dxNDFaYk82NTJDM0VPYVpmM2p6MHVWRlBmeFJQ?=
 =?utf-8?B?bzN5NkFjVmswY2d5eFRETzIyZjhxbTk0RTZjRnU2WUJ1M2NlUkN5bXlOOThL?=
 =?utf-8?B?WmoyaldqTUpGK1RMUi83dHB3RWY2cUYxSE1SY1BhQ3RMb2hoaXJIaUovRXRt?=
 =?utf-8?B?aHdVV3Q1KzR2eDlHeittVWN6NEo0UkRhdTBqdUtVTWFMMVNmRXFucmpML3A1?=
 =?utf-8?Q?SEj5vnlc+kOKr9P8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78edb2f2-9fce-4788-1b00-08da1736734f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 18:59:45.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmZfFpx92W8DxR9obg1Gur03hnkzdMXOz8hF1hitRPAqbX+R+j0RLqqwkIDXJh2R4cCB2l8HdGXIBu8dWkF3PSbefjYLZSGJGm4EKu5AW7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 11:39 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 09:49 -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 4/5/2022 7:52 AM, Jarkko Sakkinen wrote:
>>> n Tue, 2022-04-05 at 17:27 +0300, Jarkko Sakkinen wrote:
>>>> According to SDM having page type as regular is fine for EMODPR,
>>>> i.e. that's why I did not care about having it in SECINFO.
>>>>
>>>> Given that the opcode itself contains validation, I wonder
>>>> why this needs to be done:
>>>>
>>>> if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
>>>>                 return -EINVAL;
>>>>
>>>> if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
>>>>                 return -EINVAL;
>>>>
>>>> perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
>>>>
>>>> I.e. why duplicate validation and why does it have different
>>>> invariant than the opcode?
>>>
>>> Right it is done to prevent exceptions and also pseudo-code
>>> has this validation:
>>>
>>> IF (EPCM(DS:RCX).PT is not PT_REG) THEN #PF(DS:RCX); FI; 
>>
>> The current type of the page is validated - not the page type
>> provided in the parameters of the command.
>>
>>>
>>> This is clearly wrong:
>>
>> Could you please elaborate what is wrong? The hardware only checks
>> the permission bits and that is what is provided.
> 
> I think it's for most a bit confusing that it takes a special Linux
> defined SECINFO instead of what you read from spec. 
> 
>>
>>>
>>> /*
>>>  * Return valid permission fields from a secinfo structure provided by
>>>  * user space. The secinfo structure is required to only have bits in
>>>  * the permission fields set.
>>>  */
>>> static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
>>>
>>> It means that the API requires a malformed data as input.
>>
>> It is not clear to me how this is malformed. The API requires that only
>> the permission bits are set in the secinfo, only the permission bits in secinfo
>> is provided to the hardware, and the hardware only checks the permission bits.
>>
>>>
>>> Maybe it would be better idea then to replace secinfo with just the
>>> permission field?
>>
>> That is what I implemented in V1 [1], but was asked to change to secinfo. I could
>> go back to that if you prefer.
> 
> Yeah, if I was the one saying that, I was clearly wrong. But also
> perspective is now very different after using a lot of these
> features.

No problem, I understand.

I plan to replace the current "secinfo" field in struct sgx_enclave_restrict_permissions
with a new "permissions" field that contain only the permissions. Please let
me know if you have concerns with this (I also discuss this more in reply to
your other message related to the page type change ioctl()).

> 
> Alternatively you could have a single "mod" ioctl given the disjoint
> nature how the parameters go to SECINFO.

During V1 review [2] there was clear guidance to not multiplex within an ioctl() so 
I plan to keep them separate for now.


Reinette

>> [1] https://lore.kernel.org/linux-sgx/44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com/

[2] https://lore.kernel.org/lkml/0fb14185-5cc3-a963-253d-2e119b4a52bb@intel.com/

