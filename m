Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654758A4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiHEDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHEDAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:00:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD866E2E7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659668453; x=1691204453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hIfkPcOH4rCYBy8n10ah3XdV/rn0LuWusDPBYCJTBjA=;
  b=L7cI/uyADCHn07I0yguvmvlv1obpfK/xVyhL/UISOZDsEEfnbJ8PrL+u
   SUDuCop3vUfuyBN0jrjShnbWicJyG9d77T8BdieKqeUJXaOpg9FXh+jJ5
   bPQd0rw7/M69QP68iX0ZbRGRZTvjjW8Og6LucAgTQjI2By1S7zG/p+RfI
   gVWGcGA3tFhRVQ3TrTgs1VxQPSckX0F4fUh/LST6S8xTiONBNAHbrf/gF
   4Gc9NgjF6ojrGF4uqB6WVjO540Feeoos1dGaFSL/c3fh0X5s00XMh+Umx
   1tUe+bFX9ZYmDREn8tSVwYrwod0BAPklt3+u2+mJKeiwyUApd7bfm/rCX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354107542"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354107542"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 20:00:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579337536"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 20:00:52 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 20:00:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 20:00:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 20:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/dVyTQ7lClZUNoxGzcaPzzXo20+cIrRXICuUx/F0Ycs0iyA4VwfaE3Pra9IbxPsrx3vZY+kNuUf47wAW2/BtZCJdEmvF1kQzScEtDDJhSPn3qJFNKJ0x69o6/1mz9QdWUioIqyc7dBM8U0wRo9yPN07iG2GgmdEXJDl/fKLkQLgRkL+cxoKK8bKKgOxoVhLtR0ZCsmlH5u/oaj+7GQPs2a6bTS1vOdvDx8JoSG+/n8XCZ++ijrSuqOThpdG7JrgxbRvFHx/mX5OJMeVrUCDp0+XgA6QirwS5a9x+pgwFLNHMNgwFPGidiGA9U1RMQrtC+Cu/Ha8P2FEJ/vOwpxWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOPoMfQz2lHtMYRCMo/u0Ij61emia/SO5NikIaCjSJo=;
 b=GzgMS4qLuiIbAl8cKyjxEZMLtZQwjVSOAcbBGYWcv3cyDA1ivs5FZ/4nMoOhEAVghollFr1/17CRYu5jHTtX8G9Ef3Iz+eZI+BoM6tkV4809GCclg8PzFUedxtAndATuyC6OiDdzDgbztt3+XXkSLJoqAJKN+bgwvsDKtJL8rKQFZLGjDlutFWJCUU0LoHZnIgYrmjvcFVPgdBqt6Hv1nmR6nlatz2aa9Ff+OVsO69qGVrHRtb+NmSgAkK6wCbfjegNnPfEdO/RbhwCNmXzbbiY7JBRQKLkAJ9UNUlYf/Xtk5Rh6GUyIUwHC7euW2spwe3rg8wsIkifLDtn+8U+vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN7PR11MB2625.namprd11.prod.outlook.com (2603:10b6:406:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Fri, 5 Aug
 2022 03:00:50 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::552f:2392:56f8:ca32]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::552f:2392:56f8:ca32%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 03:00:49 +0000
Message-ID: <6876720c-8d3e-3112-30da-357046d4fcab@intel.com>
Date:   Fri, 5 Aug 2022 11:00:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: memory-failure: cleanup try_to_split_thp_page()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
 <20220802021256.162269-1-wangkefeng.wang@huawei.com>
 <20220804004552.GA3631345@hori.linux.bs1.fc.nec.co.jp>
 <dd492213-3e6e-a1dd-75cf-eb8500bcbf20@huawei.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <dd492213-3e6e-a1dd-75cf-eb8500bcbf20@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c4ce71-61b1-4bfa-0ec9-08da768eb39e
X-MS-TrafficTypeDiagnostic: BN7PR11MB2625:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+3mclITJHFvT0RW29cYp8ZDfc0847rXPNpxmT/AEC2MYzN5fJvQxusKbQnDXZMF7nyZjV78JlFAjUfLSYjijE5K6WhZqFq+Bxw3/Ck0q+zr69ym8Hsq2NM4zUUJl8YDPeFUoxVMiWtV9ydKrEzu1Neq3qR7vKVSEnbjeodg7tX9RAUbvGI77HE+7WMMzfElFK7/xTBaol7QjJLKUmNhEtGOlyKWeK4cUW+d36gUIc2xVpgME+AxPxBlelIcMQL0Q1ZLiFDKC3lUjE58Zsfk27NkEuhCWiCJTS5bH5RSPpQyAU8ZjTOT2pkgMqyEZXQZub4ywusWeI7iqKKYk36Un8JJyTV2WLkuyL0JfJnxGOS3PNtkOxMWjTRCs0lH+EcxfA41CFNUmND0fOpsXXF436Gx5phvuYQgin3QSZi83ORaPIBBNFRh5rdbO2VGpfORp0nlv7fMU73V1EOqNCBjNbpdDzsJvDfXQGlnBaHXZXXX8z9E2DMjwTRNCyW3853ZqIxR/bhVxtumrbHCEjmJNNFWSyFiqTDw+lkWNGS0gCZHUVtJtoTlt10I52EdBgchmf0w9msqap1lAvF0H8OO+idwOh+pVRifE75KKhBGNRXujajEdisugQTPzy7maIoaT/5JNFhelJPGvJHg7AbNPKGq2t9b/KgpG9EKYoKjGxokcwm23+nbf+SWWd1H3xDnnB4+hQgZVAWxhybAVfe1zL3mlORNbPd5W4IRs3pMIwZtjOkaUDXqQR8YGuMAKBbIGD8XmVeFuz2NkqutJTWKOxhYuswIshJrbweBM1WyFw0IUb4+uEdFmqOx/Y2+YtzQmSE3eDS3kk6I6QOb3yM5GQ9W5H5XYcTOLb8MjRbcVIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(366004)(39860400002)(136003)(53546011)(31696002)(6666004)(6512007)(41300700001)(54906003)(26005)(316002)(966005)(6506007)(86362001)(6486002)(478600001)(110136005)(82960400001)(186003)(38100700002)(2616005)(83380400001)(5660300002)(66556008)(4326008)(31686004)(66946007)(36756003)(2906002)(8676002)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpVSUI3emdpemhFQlBteWRxOUx2S2R0Wk1GdVhlejVuUXNGZDZBSWJ0aE9H?=
 =?utf-8?B?TUN3bWdwenUyM25yOTZycHVLYzQ4TGx1S1BpeWxIWk9uUEdzOFlHR0drY2pz?=
 =?utf-8?B?dW1aQ21weXNwZ3hFMUNRZW94K0tMSnlMVHVROHBNWm5jOVdqK1FaaUZoS1NG?=
 =?utf-8?B?RmtoS1JabXh5UGZXUnk4UUlpNTVIdDkwcWtERVlxVGRKNnBlRWtNMWc3WUd3?=
 =?utf-8?B?dmh2bHREOXNkODdqUG9Ea25QSnZYSmZTc004SCs1bmhTaVUyNWpZc0U5djI4?=
 =?utf-8?B?RzkzUmdPZEVjTmdhdzBEbVpjVEp1OVFZY3Fvcnd5NWF5Z05rWlhiTDNWR2FR?=
 =?utf-8?B?SEI5OFkzdVBYQUtvRFVlMWlRQVVXVG9DUU1tSW5EMUU2UTlkekRubFd0T0gx?=
 =?utf-8?B?TmlhdDArUnNlQW5ZbUFScG14YTVXM0lTNkw1eU9tMlVCWmxpelRFSGxGeEJB?=
 =?utf-8?B?TWFtVjREc25SNnJhQWQ2T0oyMkdkRVlrQllJVXVBZ29Oc0U4cFRHalBCeFFM?=
 =?utf-8?B?Y1NCWDR5TDA4QW9XZGhIbVJaaW5IQmNib2lsSWdrOHhxdlk2aCs1clpPNFZv?=
 =?utf-8?B?Vng4L0J2TURBVStZNE5rdEhkR0hqNE16bUVYMWZ4OFYxZ1JNMERyaStiVW9H?=
 =?utf-8?B?RHY3WmpTRkVQZlFHL010cCtoMUEyNWhsdFdLdnRKOG16WWs1dUgrMEdtcG5C?=
 =?utf-8?B?UWJTWENTYk5ZNXpEM0FpaWlQNU5IZmJGaXZHVnN2UGdTbDdUaVpWamd1aEJW?=
 =?utf-8?B?a3NUWDZjWXJ3M2lTc3M5Y0NoMncvQllveHA1OWRaSjBtS1UwVFBWSkJoYVBK?=
 =?utf-8?B?NDh4bmU2czYrNHdnWGpFQ2tTZm5QQmRmZzhoZkdvMFdPaU9YS3loRkg3djNW?=
 =?utf-8?B?OWZYejNTMzVnN2RXcXJ2MG0vWXIrUjZzN1JWdzJHbnJObTRrczZhR0RzVkt1?=
 =?utf-8?B?RzljZDNRRXZrT3psQjl4djN2RmsxSlNIZ1ZjMHVGRFo0MmdZWHlROTlJUEZw?=
 =?utf-8?B?UmRKUHNsemxya21hQjg4SjFqVXVVMGJwUGdhKzhCTW94bUdwMlo0Ny9JNTMx?=
 =?utf-8?B?dWVXeVJWYWQyRHB5b2hBTm5PdTRUbjg5VGM1TkExdVJKMjdTSDZaOFY5V0U2?=
 =?utf-8?B?L1lWR1BCUUs4VUE0dG5XMG12Q21Ka0ZEcjl5enRVV1JoVHhPQ05COUhnYkoy?=
 =?utf-8?B?cFpZUGJ2TDdzZ3pwMDNRbnJudGlSR2hZajlHTCtLRk5jaXJBUkJNWnlhRlh0?=
 =?utf-8?B?RmdENkxjVnhmclB0RU80dTV0cnpHWnZiWTFrcGQxYncwV2N5eGNFbVBwY0Jn?=
 =?utf-8?B?bTgvU1Uxa2Z5RU1QWFY3Z2NDNWpRWUN1K3c4a0Jsa3p5M09RMUp4RjU1TFBh?=
 =?utf-8?B?NXJPaU1CWEpYUGpQcGlKSExCVUlHS0dxdlM4S2RsUlluTThYOUZLdEFRYVhC?=
 =?utf-8?B?WWVzajFaMEprN2tOY1pnTW1HRXc0UWhub2RQd08xWEF3VUU5YVcza053MVlv?=
 =?utf-8?B?QTVubkF6STVUTHV0REVFcVJMMDR6ZzZIZjRZd1NPUHVmV0w4NjZOWUk0KytV?=
 =?utf-8?B?QWkyNm5SSmJKREVUWWdyMG1PK28xa21zWE1HcW9qRmhRSlliMnN6NlNHWkRV?=
 =?utf-8?B?NGNIUU5sSnRzQStqalhnOTI1ZldNV1FGOGxuRjU2dkttSlhZQUtzSHZCQjlz?=
 =?utf-8?B?NXRBZUtlMmlnYWo2di9Qa1RXZXhNZGJLMTdoK0RqdXY5bG1vSWNWRXVpQUZB?=
 =?utf-8?B?a2J2dE1qaHkxNC9YekwvUnRuM3lRVWtwWnR5WElzMEVPQko2RmxraFd5WTU1?=
 =?utf-8?B?N1kzSTMyUFJjeDhKOHBobjJpZFVDQXNQZFVIbnVmSXZPZ3ZMNXovZEtPTkkw?=
 =?utf-8?B?NGlCZFdUd253UW1YRFcvSm1ERitUR2hGcW56a09HTG95aVdxSk42cmFKR2FX?=
 =?utf-8?B?VUcxZjhmNHQxZUlSTjRDcGFXdWlhMmM4NHdvcTRnTXVPU3hBejF5Y2NlMUt4?=
 =?utf-8?B?cmRkaHJsaEt1UFVjeWxlQytzamNWNTRuZkQ0ZC9sMHY1eFF2dmh0Mk9FYTV1?=
 =?utf-8?B?Q0ZqdHduWjVRS3BGUjBBNGdvYVcxdmdrbGxObVRxU0dqbmJrUDQ0VTdzOHUv?=
 =?utf-8?Q?FdS2WRTetoz5r+5dNEAnd5Lji?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c4ce71-61b1-4bfa-0ec9-08da768eb39e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 03:00:49.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCjFWY+ejLmJ/3Fc5yhEcWAwX9Pmcxlcoh+m4ZjScNiED9+bY1QjIfbPNhhZuxlmYrLM13Khqdsdu/4hajRsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2625
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

On 2022/8/4 09:03, Kefeng Wang wrote:
> 
> On 2022/8/4 8:45, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Tue, Aug 02, 2022 at 10:12:56AM +0800, Kefeng Wang wrote:
>>> Since commit 5d1fd5dc877b ("mm,hwpoison: introduce MF_MSG_UNSPLIT_THP"),
>>> the action_result() called to show memory error event in
>>> memory_failure(),
>>> so the pr_info() in try_to_split_thp_page() is only needed in
>>> soft_offline_in_use_page().
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Thanks, looks good to me.  Probably this patch may come before
>> "mm: memory-failure: convert to pr_fmt()" to be a cleanup.
>>
>> And recently another patch [1] is trying to change the same function,
>> so we
>> might need to resolve the conflict with it.  I expect it's not so
>> hard, but
>> I think your series had better come after [1] because [1] is a bug fix
>> and
>> might be backported to stable-5.19.
> OK， I could repost after[1] merged into mm tree,  thanks.
Thanks a lot for the considering merge conflict. I suppose the private
data releasing will be moved to split_huge_page. There will no code
conflict and not block this patch merging.


Regards
Yin, Fengwei

>>
>> [1]
>> https://lore.kernel.org/linux-mm/20220803025243.155798-1-fengwei.yin@intel.com/T/#u
>>
>>
>> Thanks,
>> Naoya Horiguchi
> 

