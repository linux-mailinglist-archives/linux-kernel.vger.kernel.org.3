Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9E4F6DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiDFWpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDFWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:45:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AC17FD1C;
        Wed,  6 Apr 2022 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649284984; x=1680820984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=maANxCiTlfVe2CQH12gIgSyQBUAAxeTwyjJWWEFTDng=;
  b=cfnH8jXAuvfIgne1z5UVef82IhJswiuX/fiQDl6iZOes7uUwGbQl2Ezj
   1pWGHBvqu8LT4eviY8O4C6LRiRm3HQFplWYKdnQZs8BZsLGfgjrdXiXA4
   AB3lTtXNW5DOhkYNKKW+sQwwcarlMysLgdGmpNtvgpBSJhE5RCY1uKMOd
   x4NWcBMNnh3fsyiCyMGQpWtkgcFhhx8cjzJbB8PUGCIvn3nSsfHceJQfV
   vQ1anM5rqcxzR3yNkcTBnqwOiTYIgODJIp9tKOIqZIUdmTPl0SqQc/PXy
   HftIdRrmj77+50/YhNHSRLlbZRs/99SUvPTf/6Ccg5uJFnSydcr4Rsd5h
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324336092"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="324336092"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="722701186"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2022 15:42:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 15:42:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 15:42:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 15:42:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCi5hLq5m1Rul/840g3JbRkPb2uQS6pgbjAuvEf3biOAESmrP7PYABHtKVYo2zpYynHcygrfb0lQ5JY6Od+p3OgnQ6IGM8xUDByRxTsz0vBVKjQHLQ/wrxvGuRgOoOFWZQaU4eQijuJLMm5ixP0IVoYBUMIP6JCc/cvsrcYNL56vosSLRmQCje/qzcoYjN3S4czlp0RYu8BQMdUdCgMU2JiIulNK26tR8Dy6tYy2B9g0O54urtG87kVCyIDyMulR4ivcOu73Z7T7HqwoVHrGTA53aO6uceBaZD/02guFCGSSB4Iond4eH86LZYI4TvFe73zWsUf7NCBI13dnV4/PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx+BxQ3In1RLHyCR8FaNeKu3FKSzbA/vEAsn6wYH1kg=;
 b=HnctY3ywbSSizNMhi4b0nwrj2nDti/ITenx6rHb5ICNqMI2ZMKeXV8EjCAZhsoGp41sapoEgUiavLavMgkVHzmKbaREd1b/z3bjM48SwywikcrKdoeoYDI1c0bgRU9jHLdmCGevftPCuaPQRXcEjUw8PGTScCKFNbW5N/KRiVnae4+swQHLoPB1joW5Qn8eoRv0n9Dc6KdiMZXVzAg7IRWg7j1NBDoETNWoeKKBGPOf36hykuUQ4vumSTf+l0vWk7CTcnoM8oV8WMCpxByCaQoSCRAeQRmfqsLifHrZ6DF4OCw1caEsR/TJM7TD756AEEjszo48ZuIM+EFvw0OElpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1895.namprd11.prod.outlook.com (2603:10b6:903:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 22:42:42 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 22:42:42 +0000
Message-ID: <0730004f-add6-d97d-1a92-569c8c5b6453@intel.com>
Date:   Wed, 6 Apr 2022 15:42:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 15/30] x86/sgx: Support adding of pages to an
 initialized enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <nathaniel@profian.com>, <harald@profian.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <50b9da1f491eb31d9b038afa0d75871965f474eb.1648847675.git.reinette.chatre@intel.com>
 <cd2fc405d541eec1cc80e6fbd511ab978c37aa94.camel@kernel.org>
 <ff93ac6db5ff524159dd3261e1bdd68dcbbdddb9.camel@kernel.org>
 <fbe3851924a49e10b5f20160ef99a8075fb4f7b8.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fbe3851924a49e10b5f20160ef99a8075fb4f7b8.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed185f46-5fab-4447-de26-08da181ec2a8
X-MS-TrafficTypeDiagnostic: CY4PR11MB1895:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1895940ED7574EF690302772F8E79@CY4PR11MB1895.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXuo5rN0iZZ4aLc8pl5Bsvqi5FM8wAUviWZxekLO7PbJI7TrKnH2hG5QBviKU8SB8xQXzq7E1YaJx7Fex4J8UQGHKAZO0PdYBnRXRkP2njEeE+bM1ZYNPKUp2dlYC3GNpuR7wNP808a0bcx+OmnbDRuVFSW6TX89b/wQ7Jt8oQ/9omy0yPL88I+AlsauoL/irUurJZaworTQ6VCrMCiunz5My7i4cVwljV2IKnJ6dndkjOHpDcv5vvpWvDH4tzRD1CShId4vmVrDZhXaS98ZQhICj2+4uogSnyRyuU6YtQ+7MJSU7x5DJBcvFKeOJl9zAkKyhk+qGaMIBIGU/5Yupq0DYXixJvXDdUpG+iBfNzPTx68SRew2G0jhRsthY3HlOmQ5/mt+pAnFBvy/UxcwVls1RzOklszHrfkjpEV+Om1hiB6AQ/0d2RwUyV6ripgI9fc3+c0Jsx3pqk47GQw+MgKCze624k7ico8IeYcvYHvE8jUrRpPxScWiy3dT1uEJwKpG9SOIy1JVnbXMVRevoQPMUslLMZfibLBow8RvNBtue4Lwy0flW3SJ+sJxSNyULYUexlyCk53UURxiQvh2F7KlZTIg7xV7a8P46B6+Hedz6lz67dhGa0rd6IKj8XMAvFPtx4TnDM8a+TZ7UEnANe4x7RLT0N+Z3/PuvtKGB7wRnncLQ0ve5J2zpxa2az0mXwESjYtriEWmQYZN2nQKWO33C3Fl3E1f2/6NKWBeV2O9crXxIoE58HwMoSlMjVD3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(5660300002)(8936002)(6486002)(44832011)(6512007)(86362001)(7416002)(6666004)(66946007)(186003)(66556008)(8676002)(2906002)(36756003)(4326008)(2616005)(53546011)(26005)(66476007)(31696002)(38100700002)(82960400001)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FPRTZoN1NpdFhYQUhhZXUzUm4xRi90V2cxWHZONklUOHBYU251MWg2NDd4?=
 =?utf-8?B?aDg0Q281bHdYTlBTV2YyV0lpZ3VtS1pHeDRSWWl2NmVNY2l0bG8raXIrUGJj?=
 =?utf-8?B?WFZ1bjZPOFByVVlvc1dSNFp0SlBWUmpZWGEzZlJvWlF4RVQzYmtDbTh2YjhV?=
 =?utf-8?B?OXBDLyt4UnBxd2tYZ1R2T09jVnU1aUFIUWRpN3FNUHlvYzZ2QjFZM09GL3RJ?=
 =?utf-8?B?NUd2NEpFSWZvU3JVQWgxZGo0clZtS3V0Z1I1Y1dmc3JCYkJhSmFzSThCNVVC?=
 =?utf-8?B?WFdDWHBmYjBWNWJ0WGloSmVSK0dRV2QzbWIxd0tQZ3dHeXc4VXZjNTRROEZP?=
 =?utf-8?B?WWdaQ0xsaXZjZEREc0R2US9LU0VqYy9lSzBRd3BkM1dRMDBhS1pTNXRLanNv?=
 =?utf-8?B?cmxDYmhtNVN0WWNnSTMvT2o5VDA3M21WaTg0d3VNZEdhSlV6MGY1VGJLQjdn?=
 =?utf-8?B?NmJMekR0Y3REeUszVXBjdnN3ZTdEQm8xSWl3c3JUSE52RGpwT3Z4QUQ1L0Rh?=
 =?utf-8?B?K1l3eW1CUjMxZnp4a0N2QkRKTnNpME1CWHJ5U3B1K1V3Um14SUZHeUVaUTdJ?=
 =?utf-8?B?YVZtVlo4ZndiK3RRcUo4em9DU29xYUZZQ1pMK0pFMllMc2Y1RmlhaCtueW1G?=
 =?utf-8?B?SUw2Zk44YmpPbDBMeWdUVGNHR0J3aWZkcjNtc2FXemVWVGNrbUVFa2JkNG1I?=
 =?utf-8?B?amVoWG5VMWJobHNQYUtsdm1EY3J6YzVlcTFmVU8zUDdUcnRvNmw5MCs3Q0tp?=
 =?utf-8?B?SFZvQzJlUDV1RHptTFJ0WWxOaUV1MGNUbmdtN2t4dFVMRU1Rdmx0a0RXd3RF?=
 =?utf-8?B?clpXN0o3YjlweXVRWVRtTXI0WHRlSy9yelk1aHdRUWI3M2tGV1JLNVRDSE1z?=
 =?utf-8?B?S04xTjhCclNaWnBLMXc5SEZualY5YW5GT1dCTkFZcm9DVmg3VmlDTDF2STRk?=
 =?utf-8?B?RnBmcWV3RGFiTThYWUFmVzVRbjNoNXU5N1F1UWhLT3U1WE15ZGtCZkRSRnpC?=
 =?utf-8?B?enVZdVhrVXhpd214VEIrSkUyUXhwTkNyMGZQLzA1dnhPU0tTYUR1OUlKbkdY?=
 =?utf-8?B?TndrQ3NyNjRJU1FZN0FrNXhORDBZUmMyUEJ0TUFlVlM1TFhmd2JoVHplZ1Zy?=
 =?utf-8?B?d0U0eFVPb01reWgvZEt2TzNmYW1SZHZ0N2g5WW43UGl1SkJQK1dGeFdNek1K?=
 =?utf-8?B?VGUwbHE2MmNYUyt0Uk5tK050eVV1SnNZVHhFa0dLQzNVSlRlVS9DNFcwNFdD?=
 =?utf-8?B?Nml0NTdJMW1VdFdPWVJSQ1RMZXFDcHJDRmFEek4rTExPQjJiL01kd25ZNEJ0?=
 =?utf-8?B?MGhqTktLdEhQSC9hZjZXVWsvVFdYU3g5eDN5NmtKaytUN09Ca1QyTlJiVm1W?=
 =?utf-8?B?L1ppS2theVN1R1l4VURNMTV2RWR2bi9Va2czNk9kVGVsUTVqS1NMMkNwRXAy?=
 =?utf-8?B?eURSNFBLR1JpRlFQbW84dG1hRXpXTTNMSVZ1cE5PQXhQMVBESitzMkJXODRV?=
 =?utf-8?B?Vmh2cWc1WVJUZmJCU0YvenM0bXFjTmF2bFRQYS9mb2QyRkFQalBpa1VlVWZS?=
 =?utf-8?B?bHcxUklWanZDS25yT0lZVDZZSE5hUCsvaWRnOEswVm04UmcvMVpaK2lQRVM0?=
 =?utf-8?B?UWs5cWZvajczdTd0YVdLc0lsNHJnbWphQ3JaeXJCenduWG8rQmNRV0NTbG82?=
 =?utf-8?B?ckdXa1pGU1VNMmZQRVcyeTNTU01CME1Ddm5sWjI4WmR4KzRtYkRjL3dCTkFx?=
 =?utf-8?B?Zlk4R1VzMWdrMlRka2FqdXY4Z3dDT3o0Rm5tTExIczdNZlN1bDFtZVl0cDlv?=
 =?utf-8?B?dFB5TkpKWG9wSXNyU1h0SEdXK2h5UXZsd1BMS3E1TlNnc3IzWUxiVmViaW91?=
 =?utf-8?B?TFhmNmswQjZtTUZuZXoydVp0VGN4ZXdKSmZ1UXFUZWkzSnhQWXJCcVJnTHlE?=
 =?utf-8?B?QzlrQkNqZHFNOU9GdW9zQ3VlQXp5dXpPZC9iY3l3K000OXBlOGs1U0s0MGtx?=
 =?utf-8?B?bVdBaDlxU2NCTi9ydUw2MFcrUGMrSitUTEdDT0JNS01BaVFKeU1jRWRxL09M?=
 =?utf-8?B?TnhFb3JDQUF4SlQxOVFEUEpQQXQ3L1g4M2JEOHVlRFV0aExPTk1IMkZFSldF?=
 =?utf-8?B?cmlZSlBaWmJQMVA1ZHRNWUpSUkVCeTJPOVRSQjdOMFU2alNnQ1JwbU1VdE9Y?=
 =?utf-8?B?SE93V0NpaDZZZ2M0TTNORm1vaXh0OXlQUVl1NUk5R29FcVZjOEZkQlRGS1px?=
 =?utf-8?B?WjQrckQvdVQ4Z2NNR2U5Q0V5VVJKN2Irek9aNWpGd1pqS1ExZ3JMWWkyK2xY?=
 =?utf-8?B?Ykl4bzZia3hLdzQxQ1FxcXp1alRDaGdMY3V4ejVWL2tHdTdhR0NZYVdram4w?=
 =?utf-8?Q?KpD+Ktj4BBNXBQHs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed185f46-5fab-4447-de26-08da181ec2a8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 22:42:42.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cb+MgW48qOqQNzXNE6WYhORCU4jkHL/jBmXVVqLoE2KDso2MaPCk+fdIBsk18PA+MB02kJElaJqDK0fk7fsDwl594Osqqim1oWhudmcTZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/6/2022 12:37 AM, Jarkko Sakkinen wrote:

...

> For what is worth I also get a full pass with our test suite,
> where the runtime is using EAUG together with EACCEPTCOPY:

Thank you very much for all the testing.

Haitao is also busy with significant testing and uncovered a bug via encountering
the WARN at arch/x86/kernel/cpu/sgx/ioctl.c:40. The issue is clear
and I prepared the fix below that can be applied on top of this series.
I plan to split this patch in two (1st the main change, 2nd the changes
to sgx_encl_eaug_page() that will be rolled into "x86/sgx: Support adding
of pages to an initialized enclave") and roll it into the next version
of this series:

-----8<-----

Subject: [PATCH] x86/sgx: Support VA page allocation without reclaiming

VA page allocation is done during enclave creation and adding of
pages to an enclave. In both usages VA pages are allocated
to always attempt a direct reclaim if no EPC pages are available and
because of this the VA pages are allocated without the enclave's mutex
held. Both usages are protected from concurrent attempts with an
atomic operation on SGX_ENCL_IOCTL making it possible to allocate
the VA pages without the enclave's mutex held.

Dynamically adding pages via the page fault handler does not
have the protection of SGX_ENCL_IOCTL but does not require
VA pages to be allocated with default direct reclaim.

Make VA page allocation with direct reclaim optional to make
it possible to perform allocation with enclave's mutex held
and thus protect against concurrent updates to encl->page_cnt.

Reported-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 27 +++++++++++----------------
 arch/x86/kernel/cpu/sgx/encl.h  |  4 ++--
 arch/x86/kernel/cpu/sgx/ioctl.c |  8 ++++----
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7909570736a0..11f97fdcac1e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -239,20 +239,14 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 		return VM_FAULT_SIGBUS;
 	}
 
-	va_page = sgx_encl_grow(encl);
+	mutex_lock(&encl->lock);
+
+	va_page = sgx_encl_grow(encl, false);
 	if (IS_ERR(va_page)) {
 		ret = PTR_ERR(va_page);
-		goto err_out_free;
+		goto err_out_unlock;
 	}
 
-	mutex_lock(&encl->lock);
-
-	/*
-	 * Copy comment from sgx_encl_add_page() to maintain guidance in
-	 * this similar flow:
-	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
-	 * deleting (via sgx_encl_shrink()) in the error path.
-	 */
 	if (va_page)
 		list_add(&va_page->list, &encl->va_pages);
 
@@ -263,7 +257,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	 * running without encl->lock
 	 */
 	if (ret)
-		goto err_out_unlock;
+		goto err_out_shrink;
 
 	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
 	pginfo.addr = encl_page->desc & PAGE_MASK;
@@ -296,11 +290,10 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 err_out:
 	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
 
-err_out_unlock:
+err_out_shrink:
 	sgx_encl_shrink(encl, va_page);
+err_out_unlock:
 	mutex_unlock(&encl->lock);
-
-err_out_free:
 	sgx_encl_free_epc_page(epc_page);
 	kfree(encl_page);
 
@@ -998,6 +991,8 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @reclaim: Reclaim EPC pages directly if none available. Enclave
+ *           mutex should not be held if this is set.
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
  *
@@ -1005,12 +1000,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(void)
+struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, true);
+	epc_page = sgx_alloc_epc_page(NULL, reclaim);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 253ebdd1c5be..66adb8faec45 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,14 +116,14 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index f88bc1236276..b163afff239f 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page();
+		va_page->epc_page = sgx_alloc_va_page(reclaim);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
@@ -64,7 +64,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
-	va_page = sgx_encl_grow(encl);
+	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
 	else if (va_page)
@@ -275,7 +275,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 		return PTR_ERR(epc_page);
 	}
 
-	va_page = sgx_encl_grow(encl);
+	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page)) {
 		ret = PTR_ERR(va_page);
 		goto err_out_free;

