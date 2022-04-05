Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8E4F514C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845602AbiDFBzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573384AbiDETCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:02:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAF6DA6F0;
        Tue,  5 Apr 2022 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649185207; x=1680721207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5NamJdFflsG1hTxHaD8s9eFgBFQzIDfjSaf5NQIZtfU=;
  b=SBOfIrSM1rZJq2j4OE0o8xLAsAJRhewMYZbOzbcvUvPELj1v9mCfUPcE
   j9EQ0/LNlPVMYhdU/+dE51RIG1CMJIeStMCd5QlFa3QtMZqY9FNk09fh9
   /AA6bNgZmp2cwErj27D4eIQLBkOCLLIaDtn3GMUEqYExAxLG/OBlvpPA0
   7bxBc6/bUJ6ef/2pmUVTfyeNCZWQVJiYCSm9HEr7SbexdTq29q/y5bg9g
   HfEOV2Ue/cdxJtbMVrlGioTYI0YQbP5msEWZ4Gr1vkEBqY4Ldk6aNg4EO
   x3kT2P1RPx3e0ZK9xdPDVlnMQcW7ohByupEJMINoxePHB+ZQ2ceU/gfW0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240774674"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="240774674"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 12:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="588047344"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 12:00:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 12:00:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 12:00:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 12:00:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuRylnQYVe0NgVsj00VvF7i7Dq3z+s8/lc6qwA5H8g8kHuIqyYy+GFTGn3FtvWtj+Olq9vHaWUxr/IUoqwLZfe6MjKGAFb0Vb0VFg9e+CO0CTYiGTOCQAic24lKSNTzIkcczJHez4gIRrb1sg1eBwAbTflWACVh4P+JJUBcgHj0DHU9qTNGyW6dtVo1evvhx3WaPzy/hDxNugzFxmxtVU+/p7uJmy9AEQv1xfDw7K2JQfPlk3IkiR/YJoQCKIgR6MJV5NP7JDSBjzAKJwpvLh0wZ7eeDXQCJ2e7oajJdzJn8w7XL2oM5CnivcXTKYvuqmOr63Ik4kCfElRUXdZTFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTM9y+C7auvYY8tTsIi8T8P59qfVzYnzwR+UmortY0E=;
 b=CsWSvi2L20+9QJmSPnRQQbSTN/5vye4AN6Y6bnG2tA6xD8bvcgcUPSlNoQTyjL2Ht1Yg8kbewA2u7eU004L7PAiz1JDSE2TSCwzSqJOmB6yWQ2gqnOOoIbdeFiGATuN9reJTM7ZPfVIXBzqVO6DTb0E9mVUt8rDm3eSLaT4MfgbXJULCBNQ95RNWREEbwOaZ2Ur+Zt/klEYqfb9362NnJX17Ogao2u1yy7AqbGg/5BUm/CQfN8Q7wEadmbmkxfy90FFs5aa1Rpj5ZhLiPVIs6/HskxeoB/z8jmWeP7UoixKPbEgMd8Sfizx6BILanGYqupzzXjIdNRP9fwZuWhHvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 19:00:02 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 19:00:02 +0000
Message-ID: <70962fc4-1624-2fd8-4d8d-f1a31001e165@intel.com>
Date:   Tue, 5 Apr 2022 11:59:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 17/30] x86/sgx: Support modifying SGX page type
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <bac6e77fe04100d6bfebd4e13aa9b916f82bfea6.1648847675.git.reinette.chatre@intel.com>
 <Ykvqf3Ws6jlN5g+p@kernel.org>
 <b41d81ebcb6934765d7f37d4ce95baa16ec9b5d2.camel@kernel.org>
 <d8cc2142-c50d-fbd9-425f-01e279c9a0f1@intel.com>
 <94f62e19a630792f78e3c48895dfb792ecb02c6c.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <94f62e19a630792f78e3c48895dfb792ecb02c6c.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de564746-f7b9-438a-3e99-08da17367d02
X-MS-TrafficTypeDiagnostic: SA0PR11MB4751:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA0PR11MB47514C4C70D0BD24C5DFBDE0F8E49@SA0PR11MB4751.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/pcZGrjNWw7EKcnQxXPcOw/pC4VUEAo9I4J/6SBsyepmLBONhBgst3O3aOTR3ryQuXeIAQojQiAJTvQ0XyoBpKawXvj+oYRvR9N+J7EWtDsmz3fC347lCI287u28REFcpZefW5lPKV74Ry8RK/kAjp19ZjwrXWEkC313ktd6YZ1I8iA3/WLQ+ZTkh284H0V9q+qZ0JtPkgJmpLVjA4JrOEn8ALAgRWyVXgJZY++jl4aV2TNNlki2TBvi9yVILAlT7hT2si+6Kvd9jfkkBybNbg2hpmpRpajAOYtO+h8QJ48420bzw1i2M5TpwvgD7/aUjBo5jGU76Co3AKKBZ9N1s6E/YYkXyYk+TaVuteXoUnVB5BGLXfmUUnMLp0Ys0PmyJtCn6oJpKqtlSIptkRJM26Rl9G4eakMZMTTSv1ZSLmw5LKK86AftnlpxHZ0s6xWvCViJfyg12kTwsWIQ1VPkq2PJ7RNBlTnGUMzdz/823lPlsKYC3dPBAU6Dd4BNR32lkMPU9afQQqub3spTN4SRKWXHuZ+HIztxYe6geYAv8xHQsRXBdZmJ3GOoEHy86J+XqK9yalj4u0ajeaN6k90DxZmrm5NW8JFW7ExCQ/9Nw6TqRHplpOFQ7HeDmL6B+ul1+ETQtBepHEPqbwvWlSILifDZxH5Dfv8xKXeMrHWSexvtvwXMLOEH6Xtac/OqrSQITrRVeFqWBamblQtG/gQRfs9J9VhMZCB67rqqvFRM2Ge+ze6MeoItpo+bTqNX4GF0nYWXZb+Ho9ezpcE1WiJeG15/ozOJRcRv3HIpLYgPlUaj+LUH4pAsc8oMH0EVbBgAQFyLP/1zZh6+9RYABdmhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(6506007)(6666004)(186003)(26005)(2616005)(31686004)(82960400001)(53546011)(36756003)(6512007)(6486002)(966005)(66476007)(8676002)(4326008)(5660300002)(316002)(86362001)(8936002)(66556008)(66946007)(31696002)(6916009)(83380400001)(7416002)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCthbkgyaEw2azMvZkZ4ZHJmT3d5UVBUOXB2L0JmaHZwSksrVmluQWsxQXpI?=
 =?utf-8?B?VkVGVEVaRnRIVnFkZVc0SmJlQUpEM0kzbWluaVowSnFNQjlHeENVSHJ3cE01?=
 =?utf-8?B?dzhucCt4bFc4VmVWK1orMmtPd056WDM0L1h6cXpoWUVHMmRHUjRnd05NZ1RX?=
 =?utf-8?B?ZXRKRk1TajVjaTBmYTA4ait6bC9wSVFoZGx5R2xaMENLaXRmTWtLL3JQZ2dv?=
 =?utf-8?B?OHIwZ3U1Q2hOOTFobUtUZWNhZG9JYUlidU9IN20vVTRZNmJ3WjhDTW1VLzk0?=
 =?utf-8?B?V01ZeitNdUs2TEh1RXlBMS93OWZFU2Q3WldidGw0TFk5a0JZM2FrYWJSYVNy?=
 =?utf-8?B?NjJNWWsvSElBdDY2Sm9mVEZZL2pIUDJSNXJick5lblplQWJ0RkdBUS9PamRr?=
 =?utf-8?B?ZVRBcENTaUNkRmo3UEJUTlc1OUV6bFRLN3B5NlB3TXduMlBwa1BaSnk1bzJu?=
 =?utf-8?B?WXA3QUdGTm8xbDJ2Yit5QjEvdmFTUk5JMWVUY1pob0lzSEhkaDlaZFpaLzIy?=
 =?utf-8?B?RWVEeGZDUE14Z3VsYzBibVd0cVlYNWZReU9aZU9sc3daOUFsS3p0UDZ6akwr?=
 =?utf-8?B?dlQ0cS9kZ3ErY1c4L2g2ZlVLaE9xOTJQYlZKT0QxOGh0My8vVzlEQWZyNXJR?=
 =?utf-8?B?L0ZOTVYvSzVxQUJBNnkzMDBjTXJoekJJRFNCSGZXOWkxMVNWTHFLMllwdnhQ?=
 =?utf-8?B?cFVSUG1FOFZyc1F2T1doa0hQNEhaNllVUHpmZU9FQUdCNENZS2RTd3N2WmF0?=
 =?utf-8?B?NTZMbkk3ODE5ckE2enJQQ3hnNmppUmwvaTUvQ3ZLQXdNakRLTHNzeWJYQit6?=
 =?utf-8?B?YjVIais4OUJPUUFrVTl1cFU1cDNnZWdJbUJ5K29rbDd2cEEzQ01IWnQ3MzFM?=
 =?utf-8?B?U1p5ekErSXphTmp5VFpxcmFDakJ5cDN1cEFEZ0xYcmdqL2ptU0RIaFViOWNM?=
 =?utf-8?B?UWVPaHhXRHg1TDFjWWJaSzlsUmVwc3JyRzRTbEZFSUlvRlJiMHRudWxVbFdz?=
 =?utf-8?B?OFBNckE5NHFBWWN1bUxPL2lkWEo0UnNSQm4yZlJLeHd4YmxzbFE3Vkt3aEZ2?=
 =?utf-8?B?cFY1dzhvSklBZTZHVjVzNWRpMnNobGpLMStXSVNZbi9SQ0dTZGRpOUU4Y1BK?=
 =?utf-8?B?azJiZUFtRVFnd1dxVU4reUlpcmhlOStPNjhVQ0crZ2lwNDdjbmdWTW44WGtM?=
 =?utf-8?B?UWFGLzM2dHpsQVEzWlFNNVpJcjRBOTZzNXV1Sld1aWtFaDZ1NXF2K3Q0aTdX?=
 =?utf-8?B?bmNhaHhEcHkwUlJpVmdudUZzTkFDSzJhOHBQNFZqaTdDU240c1BOUzNqRnB6?=
 =?utf-8?B?L0ZTQlVxQUI5VmlHeHVDYUlUWUh6Vy9wV05qby9TMitnWkt6Q010U3ZHeWNy?=
 =?utf-8?B?ZFYxU0k4UnJXa3VTbXZuLys3N1RIMHFselpYdE01cWJqQTJhOFhuekdLVm8z?=
 =?utf-8?B?UFBMYVJuSWgwcTVjK1dabEJVV2diTmNEaytRdnc2YlhYcTZKVnorcUtabHFY?=
 =?utf-8?B?aW42M2duZHBZeUYrYVF4MW1ncmVxQkpMd2RTOFNEWHQrL0ZVSW9sMHQ3UGNB?=
 =?utf-8?B?K1BaWmZJd3VWNzE2ZG5TR0JYUE9BK2p6d1Q3NTA3ejZQelpNUThVaDNXL0VP?=
 =?utf-8?B?VkE3ejBOUGdkdUF2SFlFUFFmMXg2Q0RudFRIMmZYQ2kvZU5YcGg1eG1mTjU2?=
 =?utf-8?B?YUVZek9qVG9YelpjcVZxWDV2ZEdKTU04M0JzVnpwTVBqejlRdzFDVTQ4V1lm?=
 =?utf-8?B?Wjcybi90VHFyZkprYWl5aXRpMFhWTVVSbTNOZy91NHZCSk53dEcrMldCVjlv?=
 =?utf-8?B?NGYvemJzdllUdjVhQTVkZkdIMmdYVFoyd1pHZjJsejQ2YWxlL1ZqZmFHZDVu?=
 =?utf-8?B?V25Fd242cWRqL2lVblVYbUtDZTBBRGdremxPNFBRbVVydUtDdm85Y2QyeDRW?=
 =?utf-8?B?WWtCT3JFUkltZ3UzNHZoVnRBYUdDdXN6b05HWUhJUnhtR1dNbkgzUCthRmFS?=
 =?utf-8?B?Z2VnV1AzWm9Wc0wxcVhsTXpENk81RzBnMjFxY1N1WC9uZzVxT3lhNXFRUmV6?=
 =?utf-8?B?QWFLekxpajFxUDZkY3JDOGdDR1N4L2c4Y0ZsOUVuc2k2RDF5aGowYUM1TDRh?=
 =?utf-8?B?Zjh1eERMazJzMkc1ZW5CRGR1ZFRJeFhxazNXaEV1Z24zamVDT0gvQzNiUEE1?=
 =?utf-8?B?eG5ObjlENjR2TlRYeCtIb0ZBNEduWmttOTRkM3k4ankxZ1YvbSt1d3RSRUs4?=
 =?utf-8?B?aFJzVlBFcGlDZE84R3NHMkJFU1ZEWTBNUyt5V3ZTdCs1K05FS1k3ZzlYT0pv?=
 =?utf-8?B?OHVrVW8vRlVMTGtlZVd6SkxRbkduMWRaNEpMeDQwc2FQdGhYSlZISFFOWTJL?=
 =?utf-8?Q?tXb/rIAKRxJvAnwo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de564746-f7b9-438a-3e99-08da17367d02
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 19:00:02.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //Qg4jt7H7M71NeXr7ctP8NMxvA1hukS436iTxO4GUWDuwrV68n0ENgkhR8/VVkTJ9LPlaaFy+9+t70NDgNcMUJFWJJbMogrtZkP/RfpjoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
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

On 4/5/2022 11:41 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 10:05 -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 4/5/2022 8:34 AM, Jarkko Sakkinen wrote:
>>> On Tue, 2022-04-05 at 10:06 +0300, Jarkko Sakkinen wrote:
>>
>>>>>
>>>>
>>>> To be coherent with other names, this should be
>>>> SGX_IOC_ENCLAVE_MODIFY_TYPES.
>>
>> This is not such a clear change request to me:
>>
>> SGX_IOC_ENCLAVE_ADD_PAGES - add multiple pages
>> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS - restrict multiple permissions
>> SGX_IOC_ENCLAVE_REMOVE_PAGES - remove multiple pages
>> SGX_IOC_ENCLAVE_MODIFY_TYPE - set a single type
>>
>> Perhaps it should rather be SGX_IOC_ENCLAVE_SET_TYPE to indicate that
>> there is a single target type as opposed to the possibility
>> of multiple source types (TCS and regular pages can be trimmed).
>>
>>>

What is your opinion about what the ioctl() name should be? I prefer
to obtain a confirmation from you since you originally [1] requested
SGX_IOC_ENCLAVE_MODIFY_TYPE.

>>> This should take only page type given that flags are zeroed:
>>>
>>> EPCM(DS:RCX).R := 0;
>>> EPCM(DS:RCX).W := 0;
>>> EPCM(DS:RCX).X := 0; 
>>>
>>
>> ok, this was how it was done in V1 [1] and I can go back to that.
> 
> I would name the fields as "flags" and "page_type" just to align
> names with SGX instead of trying to mimim "posix names". Otherwise, 
> I support that.

I will move this ioctl() to use "page_type" instead of "secinfo"
within struct sgx_enclave_modify_type.

Your guidance of "flags" is not clear to me. I assume that you
refer to the field for struct sgx_enclave_restrict_permissions
where I think "permissions" to only contain the new permissions
would be more appropriate. None of the other values in
secinfo.flags are relevant.

Reinette

[1] https://lore.kernel.org/linux-sgx/Yav9g4+L8zg48DRf@iki.fi/

