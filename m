Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D861051D32F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390015AbiEFIUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390042AbiEFIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:20:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342468305
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651824972; x=1683360972;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BY3tPmPvaQx1ru0VWeKlChmcFens1nBoj2sS3AuvwKA=;
  b=Q/aCyQhEVi/lMZXLtP11LolDqtVHo/7WbFhzUbgum8EsoNaRbvk84rqy
   VSQZzez0aQR9IpRUgQ6yYJT9z6tlDkBbKnoKyGwQ6zZlFU1sSXN2ynMMu
   WXV1TIXC8KanD9hDIBnkSqivYyECDdY3puM79HwZyw3m40gy6CI+OUcDH
   iyLlAaGyl6JjAcwL8LOuvmoYT9v57Hgosj+vqv71YzzvpjU7oOw3nUM3Z
   a1zS87X1dwkON9UULPgn3ENf8oKPtB6rU4aolAiF+WWHWJZJCB/0emXvo
   MpiWqL/6epvKdOTMC8upNmWnjmRfwGOXHDqGn7/7MTmlLlMr9j0HdNLUk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267993529"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267993529"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:16:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585848694"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.35]) ([10.249.170.35])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:16:09 -0700
Subject: Re: [kbuild-all] Re: time.c:undefined reference to `mach_get_rtc_pll'
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>
References: <202205041720.i8wJ8uXq-lkp@intel.com>
 <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <45842084-938c-1e86-8b40-e883c9ae40bb@intel.com>
Date:   Fri, 6 May 2022 16:16:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2022 5:25 PM, Arnd Bergmann wrote:
> On Wed, May 4, 2022 at 11:14 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
>> commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>>>> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>>     m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>>     m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>>
> 
> I think this is just another build failure that was hidden before my patch,
> not caused by my patch.
> 
>        Arnd

Hi Arnd,

Sorry for the inconvenience, we have added it to the ignore list.

Best Regards,
Rong Chen
