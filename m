Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDC59C2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiHVPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiHVPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:30:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADA1400D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3B60B8124F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EB4C433D6;
        Mon, 22 Aug 2022 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661182221;
        bh=Osn/TvzKVciA4mwkERYhF3h7t0rS17gg1cHqOwvFDgc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V3+Oaax1aaLO7FcE9oTBHj4TSWJddrxpl4ywZVMjD1C6qaYdsm9SDKUbGlsrkPx4A
         1dnJTk58ji2YCWOdP36Fhnb3bvHQij6Dv/fz5itENqRNjm+bwU72HjmuUj4GDctJRv
         qc236Wsk0tU3pbBQccKxA1r8lMj9zUY48EaF7kTR17lroBZe6IYb07xnYEaCMjflcC
         hKNNZI2hM+44stlY4xN2ETyB9gWXn/H84I787loIpB0B/RvlM5/q+kylDq2Ecnbq/m
         7MvA3/ZtOKHQ3dEeui3LvxYqynxL+3o7ppV9cc0/G/haaFREBr3FoDGPQweslppdNH
         PQ6/CuttsRIGw==
Message-ID: <7753698c-8059-9ce7-66bf-415fb5cd85cd@kernel.org>
Date:   Mon, 22 Aug 2022 17:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol
 'da_mon_wip' was not declared. Should it be static?
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202208210332.gtHXje45-lkp@intel.com>
 <20220822104354.2ea2a6f7@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220822104354.2ea2a6f7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 16:43, Steven Rostedt wrote:
> On Sun, 21 Aug 2022 03:57:25 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Stephen,
>>
> 
> I don't know who this "Stephen" is. There's no-one on the Cc list named
> that.
> 
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   50cd95ac46548429e5bba7ca75cc97d11a697947
>> commit: 10bde81c74863472047f31304064018c40f488ee rv/monitor: Add the wip monitor
>> date:   3 weeks ago
>> config: arm64-randconfig-s032-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210332.gtHXje45-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 12.1.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # apt-get install sparse
>>         # sparse version: v0.6.4-39-gce1a6720-dirty
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10bde81c74863472047f31304064018c40f488ee
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 10bde81c74863472047f31304064018c40f488ee
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/trace/rv/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> sparse warnings: (new ones prefixed by >>)
>>    kernel/trace/rv/monitors/wip/wip.c: note: in included file:
>>    kernel/trace/rv/monitors/wip/wip.h:30:22: sparse: sparse: symbol 'automaton_wip' was not declared. Should it be static?
> 
> So we have:
> 
> 
>    struct automaton_wip automaton_wip = {
> 
> Which is used only in the one file that includes it. I'm guessing it should
> be static. Daniel?

Yep, I think it should be. I will change the monitors and to dot2k tomorrow, and test them.

/me is back to work after vacations.

-- Daniel

> -- Steve
> 
> 
>>
>> vim +/da_mon_wip +20 kernel/trace/rv/monitors/wip/wip.c
>>
>> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  18  
>> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  19  struct rv_monitor rv_wip;
>> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @20  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
>> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  21  
>>
>> :::::: The code at line 20 was first introduced by commit
>> :::::: 8812d21219b9c649dd25eb93915e00939944aeb7 rv/monitor: Add the wip monitor skeleton created by dot2k
>>
>> :::::: TO: Daniel Bristot de Oliveira <bristot@kernel.org>
>> :::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
> 

