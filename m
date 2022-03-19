Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175614DE5E9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbiCSEST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbiCSESP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:18:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4E1D12EA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LiAmXF+XSu8FyM2tNbVP3QUK+/4Lx91AGMoxhIN3FjE=; b=tLT02o4eiuNjEAwQOnQsAzS16Z
        ozLmbaro/1OTHZmnKHyAqZ5oyjGY8IeZr0WOD55ecauENG3uU/OLv34Wj89VQJmNWVElse/uDyDuv
        Sjy95cjebpsWuNp4GF9hM07Zit8wWslay4Sd4aJTg42CEmFLpjKePm5A4L6x+7osegnR0LihpSIZq
        MpVfioBC3D6tNLlUrmANIdktEj/Q8ksT5OCqFns3Zn125SycGNc1G8L/wf6wyeyfbwrrVnMro9XfV
        GSbxMpjbuvEICPPNFvsD7NEdNAkgsHmMpv9u5J7XkPgZrkAs8kSXkTmnWk6UQigR72gaiAPwu8/Ty
        JDtWanmA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVQWD-008YCb-PV; Sat, 19 Mar 2022 04:16:46 +0000
Message-ID: <6a50c7f3-2c1b-3a31-0a03-aa7319190d5d@infradead.org>
Date:   Fri, 18 Mar 2022 21:16:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: via-pmu-event.c:undefined reference to `input_event'
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <202203190015.8LPNVVK5-lkp@intel.com>
 <c22262dc-b71c-bc9-b5b6-1abc593bdc4d@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c22262dc-b71c-bc9-b5b6-1abc593bdc4d@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/22 18:16, Finn Thain wrote:
> On Sat, 19 Mar 2022, kernel test robot wrote:
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   551acdc3c3d2b6bc97f11e31dcf960bc36343bfc
>> commit: ebd722275f9cfc6752e29d2412fa3816ca05764b macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>> date:   3 years, 8 months ago
>> config: m68k-randconfig-r021-20220317 (https://download.01.org/0day-ci/archive/20220319/202203190015.8LPNVVK5-lkp@intel.com/config)
>> compiler: m68k-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebd722275f9cfc6752e29d2412fa3816ca05764b
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout ebd722275f9cfc6752e29d2412fa3816ca05764b
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event':
>>>> via-pmu-event.c:(.text+0x32): undefined reference to `input_event'
>>>> m68k-linux-ld: via-pmu-event.c:(.text+0x54): undefined reference to `input_event'
>>    m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event_init':
>>>> via-pmu-event.c:(.init.text+0xe): undefined reference to `input_allocate_device'
>>>> m68k-linux-ld: via-pmu-event.c:(.init.text+0x56): undefined reference to `input_register_device'
>>>> m68k-linux-ld: via-pmu-event.c:(.init.text+0x68): undefined reference to `input_free_device'
> 
> That config file has CONFIG_INPUT=n which is unusual. The problem affects 
> m68k builds since I enabled the driver 3 years ago but powerpc builds have 
> always been affected by this.
> 
> via_pmu_event() does nothing unless the hardware happens to be a 
> particular powerpc PMU models but that logic is questionable (see comment 
> in via-pmu-event.c). So I think the best solution is to make the 
> via_pmu_event() code conditional on CONFIG_INPUT.
> 
> I'll send a patch to that effect.

Hi Finn,
That's what I was planning to do also, but I'll leave it to you.

thanks.
-- 
~Randy
