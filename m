Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7964B4B44E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiBNIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:53:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiBNIxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:53:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9E5F8F3;
        Mon, 14 Feb 2022 00:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644828775; x=1676364775;
  h=message-id:date:subject:references:in-reply-to:to:cc:
   from:content-transfer-encoding:mime-version;
  bh=7Ax12YyzrBm6pTBb6y5zyVhTGxQP41YEZTCoJlFqF2Q=;
  b=Gmk9FWMl9/L2NYBSnQWNJy+M5Gzr5bfOZC0b8SDFGYGXROCf++/NRlsO
   hF3DrfX7xia+Tg3blO0GLTkAeZb+9+o2EDAqLkfhgX3imzbEG1UOJ2oBz
   ZGvHHSwdl3+C34DXnK0Pz80ZmeCxkq6jRg1zBX9VhxWHh8UFcFELk0j5i
   cgw2RLYW7jWuvGiivZy+3t8fve1xo0goSHrpUwnCUkufavDzpvRwxaQU+
   VsPHrGhBuEzJEQer2jgjdfYRjfyqJH8sShlKDK++IyET3juyoRhFBX/zs
   jd6IiOo9TXqlM06K4tG72doZ56yS8lso9InuMjamHamf/JojqBugC5b19
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237455716"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="237455716"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 00:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="635021310"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2022 00:52:55 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 00:52:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 14 Feb 2022 00:52:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 14 Feb 2022 00:52:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvj6xlrPsc74NLhQkM/m1J7gUMY1YW55Fw6e2eHoAxilefwBV3qmzjWzNeRgiRWc4IR7On5d+bZe0WPiQbHjw3Cy6drFTj5gj8afsigMl80mSOK2gna4jAG63anRFApDFLyuv9TMftkOuz5CTJmJD1kZQXD33OPprCDl/DHZkODWquElqmw+q6bNgHUcdSEKx51gBX8l2dRwSLQet0l+STjT2QHNVgEq0TARyZrpq6hM7ivIuITILKyxbwrDv8WO8cBoqSvLKuWu/BmPiSl3JvL5kKi1Vv5wQ3QSk5N3IuWukNWlePmF+PstbDAb2hvPJRABZhUnW5JuD6nor8K3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh+45WGjB3VFm2hiA72myYlYVytSpG2q2ZwWjDM+wNw=;
 b=RaeyTY9MMnwsPUE1BhnmPxYFypkk8wV/y+tO0aAGzHy/TZEjYUaJ5ALL1R1kjA9X+lVBXfreKFa6ySGMZUJe4/fD+DXs+yYZAiLguiRmJoK+BO3J/d8wPcqW943mI5bpj67tNU5468NcpLnj2hLXLT8DjUtJXWndmBxggaxQDJ4Q/qCsbfRYgMRNiRHEmpnI33dTfznHc0ehu/cPHIti3xJsCmTy4mJjzTlX4ha+/99+vgFxVXHikcz3X3V+zofdgz2s3O4NJMl9IpkLRC5rRobHqQuc9qVGo/V28NyiW3+oJ5RDJlL1rJv6YGWKN9BE/wFg84JspPZe25/aL0CEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BN7PR11MB2562.namprd11.prod.outlook.com (2603:10b6:406:b4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 08:52:52 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 08:52:52 +0000
Message-ID: <58f9bccf-212d-721f-3290-1eadb03545da@intel.com>
Date:   Mon, 14 Feb 2022 16:52:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] Bluetooth: mediatek: fix the conflict between mtk and
 msft vendor event
References: <202202130806.UHxKw5N3-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202202130806.UHxKw5N3-lkp@intel.com>
To:     <sean.wang@mediatek.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202202130806.UHxKw5N3-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1761e92-94bb-499b-1a6e-08d9ef976277
X-MS-TrafficTypeDiagnostic: BN7PR11MB2562:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2562A550A4DB65589BDBB115FB339@BN7PR11MB2562.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0Q0DTAZCxItSrupbUANDlmqY+toAX0eowWFbIMTh0cL/4LoPF44xhd1y/4oKbkvECSAyuEh0CWWFGCqiWVqfpoOE4MJs2UUj6p4ynqR6kKq9MTn2KqrmV3y9tmS0L0GIumblnasswYTt3/y05NVpkQvaacgnEQUfcqxr8EIiMD6KtCKpDrceI4EsTu2wUB4jKJXjojZeYvs5TNb2VyCG1FcX7NBpiH1GKBvfJ7doX+9Pxy926X9TJDsIqeV6HbcXQOaOOS7JksfkUC8MVzy69MQoBwNAYOrmc4s0JZGy3BgIOHj7cGO4MJlfZ95dEVgVuUaa16TjFEx92oZjFisYYPohbFMTWAMqu5DbazBdSqCW0Wbk1Z9UQ+S2Eme3aeQ7nbeaFjtcjtswVEN5Y+Jup9u0fbYnr47sC60fdSjlaoMVjvPv26na/HPlPpoD03NhTbH5RjOyzPENVkEeOhEgMhOWZSAB9RZtnpSnaJJlIqVAOY9p/Er7qcZIqhB+YIZuT4jwUqFqJ+VhOJp1npZvQDVf5cAp6ZS+yYx9zmCtvCpIQCkZ2Y9a5f6u/9Vu+SWjImLX6oCIz1YXiMtcz8e5rke4ainUfUCmGfOyNP/420sjUhku/KBUZd2SJJgcCBMWPN9Yxe+729rNMlBQaOwoVBEkBHrNMKYPBQYIHdwHMxYYQlw8bmk2R6B5Q/371Lb4KV8YNQRAp1hRP0Gv85vpx/w/87IDYQwuV5O8lwE5+pSmmL0A0Wk2ErET1o+dlEsNsohFBdHBKXa9ud6OJAlhK2E2rVI0sc7uHOj+WmIIWXE7h2gajtryjcAHZQ81boUyXMetWxqymP3Ycs+97rgcK94eWoWpDvxSGnCMf57MlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(8936002)(2906002)(508600001)(31696002)(5660300002)(4001150100001)(66946007)(8676002)(86362001)(82960400001)(4326008)(66476007)(66556008)(38100700002)(6512007)(316002)(6916009)(6486002)(966005)(83380400001)(26005)(6506007)(6666004)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTkxTkIvb0ZRK0ZrYWlwc25rTHQrajdIRWFKNUUvQzYxdW1MVnlyRmpMTTRw?=
 =?utf-8?B?Y05DeG5hZkxCSFhyY1QrbGtnVUJwb0hYdWFqMG0rMHlSTm1xc3hrVUk3alFM?=
 =?utf-8?B?NERTRFZwSWp3U0lVajg1SUhnZEIydjRWNWk3aEdUbjR1cHViZGZLblRGbEhs?=
 =?utf-8?B?T0FzWUdtaVZvU3YzWmtlSXFHd3Q4aytDd05Icjc5Rlc4bmtrN1d1ckdWSGlz?=
 =?utf-8?B?Q0hyZW9ieURwUUhxM0VPZnpkSXArM21xYkpISlVtL1dZU3lsVi9CUHFUT0Fa?=
 =?utf-8?B?V1cwZG1TZU5pVHNiVVZkVFIrcnpjZTg4NGVHQWJqZ3dmaEJIZHBka056Ni9F?=
 =?utf-8?B?dmwzOWZNWXRadCs0Tkdoa0s3MmpkUlE0NmxodXoxNGlackh1OW9uN1JpTWZP?=
 =?utf-8?B?TEJUMHZCdEdRZkhLQjNVaVAxVU1KV3ZBODZSVXl1KzI2T3F5OHBWM005RjFl?=
 =?utf-8?B?c3duZStMWU5WZzNjQVdNRVgvMUF5TEl5M2NJWEJWelljZk9IVkZ6aUM4bUZW?=
 =?utf-8?B?WnUvQXNUbk9lRXByOHZQdHN2M0krT2gwRVplWFhZOElGV0Nobk04MkNtSlkx?=
 =?utf-8?B?dloyYXRqeXdMUVpxd0lEc3Z3QzFHWmo0TlQxM0lCOTM0WUdZaDdRVWVqam0y?=
 =?utf-8?B?QldlbG9EcFd6SGxGeWFpN1puelN0eU1PR0Z2aWwwNjVQTUpaWGxTQUtMYlRp?=
 =?utf-8?B?ZXI0YXpDRmpVbjF5amx6d2xGakZrdE85Yk96UmNuV0RQUVJ4eXlMMEc5cFVV?=
 =?utf-8?B?a3hKWVFVVTllMzZrTnBxWlFXZkw1UzFEUU83am1yZ3JwbWk2VllORXhkSFQy?=
 =?utf-8?B?aHZwOERxVmszcG83UzBBZ3lYTHlYTTVITnY3YkNVdlJKRTVWNDRNK1hrcURV?=
 =?utf-8?B?SlRLaDFxL2dUNVdnQlZCc3RheE5VL3VERCtMSXgyVVZTd281VytPZUk3QWNI?=
 =?utf-8?B?OE1xeEhZOTV1NVB3Y3kxQkhnRDY4SzNrY3NFSW1FckVtdzlqRGVWdEIrRXZm?=
 =?utf-8?B?WmFwWHBGT2VrRVBLdVZmSU50N0xpMnZHY0lad2RQOGRWN0I5eTFndEg0azlR?=
 =?utf-8?B?MGhKQW4rTllpOVdOYWF6Nm5yRlNNNUE5UEJXTUNBYlM2STBjRUkrbUllZjZI?=
 =?utf-8?B?MzFIbjJlZzZaRGhLSWxma0gzK2Y2SWN1R1NRZFMwc2JxTFVyNUl3aUU0NDcw?=
 =?utf-8?B?V00xTUJudStleWdkTUxscDFKV3RVSFFoZ2QvOS9ha1hPK3VRRFExWHUrdmg4?=
 =?utf-8?B?MkJVeVNlenlFekdxa0N4MTBHY0dJalFHSGoyK0lTVUxHaXBOLzJIRDYwaFUr?=
 =?utf-8?B?cWVaL0FyVjV2and1K1QyQjdSd0gyb0h6VjRuejFkSlJWYlJXWlp0L2QxV0Np?=
 =?utf-8?B?T1VwRXZWM1hnVDhycWsyRVBJSlVzcEphVjA2Zk1hS09GUXl3Rnd0eDdESVFl?=
 =?utf-8?B?Tzd2QXFsOTgySGdnNXhJNW01UGZRd0FUeVhXakFUVHJyc2trUVNmcHd5Smc3?=
 =?utf-8?B?aUdEbktkZEs5dWlxb0NPRWh1d3lMTG9OSlZDTnJldHVIVlZ5UVJNTkRCUlMr?=
 =?utf-8?B?T0tBdzNYVWtxS2dnU2NVYk9ueUphMzZJRW1LQ1k5dG1BQkY5cUJQNGxyMkZL?=
 =?utf-8?B?Q2Z3N1lFSlpkOG1oT3luMlhnNTZndnhMWS9OUTVlbWpBdDFGMmVyUWN2enRq?=
 =?utf-8?B?cVJOSkdkdlo0ZEF6dThoQ01tbXRsOWxUWExoUENXdXphVkZjLzVZRFMyY3pG?=
 =?utf-8?B?MWRzZWJvYzhXL2RyRHU2RHBUQ3NuWjNpQlJSMUYzeFVkTHRDMEo5UjBCV3d2?=
 =?utf-8?B?Wk9IVTQxTHpFd1FlZGpTS1Z2aUpydTFKZzRSdSs1dDJqY3JFdE4rZnh1QVJG?=
 =?utf-8?B?clFpc01sQTgrcVR5cUlmQ3kwQ3F0YlZTaDBMSE96TTR6V1BmZmNaNFQ4NFhK?=
 =?utf-8?B?amFVVDZzTmZoUGNrQlgyWlVxbnlTZDc1cUV2S1FUdVhVR1ZjQ0hwem5sdG93?=
 =?utf-8?B?RS9teC9hd3kraHdGQk8wMmRaczhjVzZVOHFlYWJQSzBPbHNRT0JkZVNucUR0?=
 =?utf-8?B?a1l0OFFYUmpaZ0t4bUhtRytZQnR2cS92QklITWZBWmVQRWFOMGhkQ0h0bnA3?=
 =?utf-8?B?dTJabEVZb2IzTEx0QU16WFczczlPQjExOXJHQXBaMlR3cW4rSGZvdlpEMnVM?=
 =?utf-8?Q?+G96ZCK7P3OaTBv1J8YskYk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1761e92-94bb-499b-1a6e-08d9ef976277
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 08:52:52.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMCOhQQwkzrq2OPxXYWfzP5FChMXDOQB2g72hNI28HlQkHzLBQM5Yt8sEqMFpaijykgkDNVD46rygw0V2b9fRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Thanks for your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20220211]
[cannot apply to v5.17-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/Bluetooth-mt7921s-support-bluetooth-reset-mechanism/20220129-140313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: riscv-randconfig-c006-20220205 (https://download.01.org/0day-ci/archive/20220213/202202130806.UHxKw5N3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dee058c670593b999fec19c458dbbd882ad9de56)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv64-linux-gnu
         # https://github.com/0day-ci/linux/commit/33092fd43b74594bae07555a6fdf15133cc8ec54
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review sean-wang-mediatek-com/Bluetooth-mt7921s-support-bluetooth-reset-mechanism/20220129-140313
         git checkout 33092fd43b74594bae07555a6fdf15133cc8ec54
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/bluetooth/btusb.c:2273:3: warning: Value stored to 'hdr' is never read [clang-analyzer-deadcode.DeadStores]
                    hdr = (void *)skb->data;
                    ^     ~~~~~~~~~~~~~~~~~

vim +/hdr +2273 drivers/bluetooth/btusb.c

5a87679ffd4436 mark-yw.chen 2021-09-01  2248
a1c49c434e1505 Sean Wang    2019-06-02  2249  static void btusb_mtk_wmt_recv(struct urb *urb)
a1c49c434e1505 Sean Wang    2019-06-02  2250  {
a1c49c434e1505 Sean Wang    2019-06-02  2251  	struct hci_dev *hdev = urb->context;
a1c49c434e1505 Sean Wang    2019-06-02  2252  	struct btusb_data *data = hci_get_drvdata(hdev);
a1c49c434e1505 Sean Wang    2019-06-02 @2253  	struct hci_event_hdr *hdr;
a1c49c434e1505 Sean Wang    2019-06-02  2254  	struct sk_buff *skb;
a1c49c434e1505 Sean Wang    2019-06-02  2255  	int err;
a1c49c434e1505 Sean Wang    2019-06-02  2256
a1c49c434e1505 Sean Wang    2019-06-02  2257  	if (urb->status == 0 && urb->actual_length > 0) {
a1c49c434e1505 Sean Wang    2019-06-02  2258  		hdev->stat.byte_rx += urb->actual_length;
a1c49c434e1505 Sean Wang    2019-06-02  2259
a1c49c434e1505 Sean Wang    2019-06-02  2260  		/* WMT event shouldn't be fragmented and the size should be
a1c49c434e1505 Sean Wang    2019-06-02  2261  		 * less than HCI_WMT_MAX_EVENT_SIZE.
a1c49c434e1505 Sean Wang    2019-06-02  2262  		 */
a1c49c434e1505 Sean Wang    2019-06-02  2263  		skb = bt_skb_alloc(HCI_WMT_MAX_EVENT_SIZE, GFP_ATOMIC);
a1c49c434e1505 Sean Wang    2019-06-02  2264  		if (!skb) {
a1c49c434e1505 Sean Wang    2019-06-02  2265  			hdev->stat.err_rx++;
60c6a63a3d3080 Mark-YW.Chen 2021-10-14  2266  			kfree(urb->setup_packet);
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2267  			return;
a1c49c434e1505 Sean Wang    2019-06-02  2268  		}
a1c49c434e1505 Sean Wang    2019-06-02  2269
a1c49c434e1505 Sean Wang    2019-06-02  2270  		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
a1c49c434e1505 Sean Wang    2019-06-02  2271  		skb_put_data(skb, urb->transfer_buffer, urb->actual_length);
a1c49c434e1505 Sean Wang    2019-06-02  2272
a1c49c434e1505 Sean Wang    2019-06-02 @2273  		hdr = (void *)skb->data;
a1c49c434e1505 Sean Wang    2019-06-02  2274
a1c49c434e1505 Sean Wang    2019-06-02  2275  		/* When someone waits for the WMT event, the skb is being cloned
a1c49c434e1505 Sean Wang    2019-06-02  2276  		 * and being processed the events from there then.
a1c49c434e1505 Sean Wang    2019-06-02  2277  		 */
a1c49c434e1505 Sean Wang    2019-06-02  2278  		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
22cc6b7a1dbb58 Johan Hovold 2019-11-28  2279  			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2280  			if (!data->evt_skb) {
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2281  				kfree_skb(skb);
60c6a63a3d3080 Mark-YW.Chen 2021-10-14  2282  				kfree(urb->setup_packet);
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2283  				return;
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2284  			}
a1c49c434e1505 Sean Wang    2019-06-02  2285  		}
a1c49c434e1505 Sean Wang    2019-06-02  2286
a1c49c434e1505 Sean Wang    2019-06-02  2287  		err = hci_recv_frame(hdev, skb);
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2288  		if (err < 0) {
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2289  			kfree_skb(data->evt_skb);
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2290  			data->evt_skb = NULL;
60c6a63a3d3080 Mark-YW.Chen 2021-10-14  2291  			kfree(urb->setup_packet);
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2292  			return;
de71a6cb4bf24d Jupeng Zhong 2021-02-02  2293  		}
a1c49c434e1505 Sean Wang    2019-06-02  2294
a1c49c434e1505 Sean Wang    2019-06-02  2295  		if (test_and_clear_bit(BTUSB_TX_WAIT_VND_EVT,
a1c49c434e1505 Sean Wang    2019-06-02  2296  				       &data->flags)) {
a1c49c434e1505 Sean Wang    2019-06-02  2297  			/* Barrier to sync with other CPUs */
a1c49c434e1505 Sean Wang    2019-06-02  2298  			smp_mb__after_atomic();
a1c49c434e1505 Sean Wang    2019-06-02  2299  			wake_up_bit(&data->flags,
a1c49c434e1505 Sean Wang    2019-06-02  2300  				    BTUSB_TX_WAIT_VND_EVT);
a1c49c434e1505 Sean Wang    2019-06-02  2301  		}
60c6a63a3d3080 Mark-YW.Chen 2021-10-14  2302  		kfree(urb->setup_packet);
a1c49c434e1505 Sean Wang    2019-06-02  2303  		return;
a1c49c434e1505 Sean Wang    2019-06-02  2304  	} else if (urb->status == -ENOENT) {
a1c49c434e1505 Sean Wang    2019-06-02  2305  		/* Avoid suspend failed when usb_kill_urb */
a1c49c434e1505 Sean Wang    2019-06-02  2306  		return;
a1c49c434e1505 Sean Wang    2019-06-02  2307  	}
a1c49c434e1505 Sean Wang    2019-06-02  2308
a1c49c434e1505 Sean Wang    2019-06-02  2309  	usb_mark_last_busy(data->udev);
a1c49c434e1505 Sean Wang    2019-06-02  2310
a1c49c434e1505 Sean Wang    2019-06-02  2311  	/* The URB complete handler is still called with urb->actual_length = 0
a1c49c434e1505 Sean Wang    2019-06-02  2312  	 * when the event is not available, so we should keep re-submitting
a1c49c434e1505 Sean Wang    2019-06-02  2313  	 * URB until WMT event returns, Also, It's necessary to wait some time
a1c49c434e1505 Sean Wang    2019-06-02  2314  	 * between the two consecutive control URBs to relax the target device
a1c49c434e1505 Sean Wang    2019-06-02  2315  	 * to generate the event. Otherwise, the WMT event cannot return from
a1c49c434e1505 Sean Wang    2019-06-02  2316  	 * the device successfully.
a1c49c434e1505 Sean Wang    2019-06-02  2317  	 */
48c13301e6baba Mark Chen    2021-02-02  2318  	udelay(500);
a1c49c434e1505 Sean Wang    2019-06-02  2319
a1c49c434e1505 Sean Wang    2019-06-02  2320  	usb_anchor_urb(urb, &data->ctrl_anchor);
a1c49c434e1505 Sean Wang    2019-06-02  2321  	err = usb_submit_urb(urb, GFP_ATOMIC);
a1c49c434e1505 Sean Wang    2019-06-02  2322  	if (err < 0) {
60c6a63a3d3080 Mark-YW.Chen 2021-10-14  2323  		kfree(urb->setup_packet);
a1c49c434e1505 Sean Wang    2019-06-02  2324  		/* -EPERM: urb is being killed;
a1c49c434e1505 Sean Wang    2019-06-02  2325  		 * -ENODEV: device got disconnected
a1c49c434e1505 Sean Wang    2019-06-02  2326  		 */
a1c49c434e1505 Sean Wang    2019-06-02  2327  		if (err != -EPERM && err != -ENODEV)
a1c49c434e1505 Sean Wang    2019-06-02  2328  			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
a1c49c434e1505 Sean Wang    2019-06-02  2329  				   urb, -err);
a1c49c434e1505 Sean Wang    2019-06-02  2330  		usb_unanchor_urb(urb);
a1c49c434e1505 Sean Wang    2019-06-02  2331  	}
a1c49c434e1505 Sean Wang    2019-06-02  2332  }
a1c49c434e1505 Sean Wang    2019-06-02  2333

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
