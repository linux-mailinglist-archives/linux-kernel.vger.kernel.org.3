Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696B44EAB26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiC2KUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiC2KUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:20:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD132BC82
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648549111; x=1680085111;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=v84C/fu7mQ9bv1JSxNzBdkKtR7LAOGb5+Lg5prYh3H0=;
  b=AocAtbem1RSx1SMCVskh0dZKhYzxxZdsgAEqRWqGfd/6HSxDhZQdkGgV
   q3scfOQ6nQegZOQX8Hj9CH6Cj/vHhwia4f21cdTuQyE9EB3Q56lHx7Zga
   7t+4IXV+/vWA4WOWnFYhOt3m1cnMhQpiswUIKGCv3DXuhtZBJB+zDBbQx
   OqfR4OTAzh5CvvFeJ882OmHGfnYyzr+ucewfqje21Oin4IrgfVimWXGP5
   4+6OqqETQfQAxXuhvnlFXPuxyuXqtwpeqDlxCUON9PEpLBJh4XXPaHQS6
   M36DcXyNopP9O4MjM82eQiXOPTY9DwIDvzGZ9zBKauI6m704srQ3gUNb2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259185125"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259185125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 03:18:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="564509223"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.108]) ([10.255.28.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 03:18:29 -0700
Subject: Re: [kbuild-all] Re: lib/zstd/common/debug.h: zstd_deps.h is included
 more than once.
To:     Nick Terrell <terrelln@fb.com>, kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202203270632.BdIMZ4Zs-lkp@intel.com>
 <6F25888B-F700-4DFD-A60F-7A542D2DFF5F@fb.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <e21b9fff-57c7-b1e3-6928-46d6088a57b3@intel.com>
Date:   Tue, 29 Mar 2022 18:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6F25888B-F700-4DFD-A60F-7A542D2DFF5F@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Sorry for the inconvenience, we will add it to ignore list.

Best Regards,
Rong Chen

On 3/29/2022 9:43 AM, Nick Terrell wrote:
> 
> 
>> On Mar 26, 2022, at 3:26 PM, kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   710f5d627a98e86f821aceb840b8f2f1fcc6cf75
>> commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
>> date:   5 months ago
>> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> includecheck warnings: (new ones prefixed by >>)
>>>> lib/zstd/common/debug.h: zstd_deps.h is included more than once.
> 
> This is intentional, and working as expected.
> 
> Best,
> Nick Terrell
> 
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
