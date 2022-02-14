Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4014B455B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbiBNJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:15:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiBNJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:15:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5360078
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644830123; x=1676366123;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=g4X8dpX/+mCUFOoP+dXV/zOMvjLvYWK2RiNmIDoXfiw=;
  b=XkwiXRUCHc5t17PuYia7CDZAe3VcBDWs6qX9M3mQKGRlRgvnWF/Fn1hX
   KbSyWQsgZoE1Mtr2nxNMBadxvvhTb35wDV0d5JUZjDktAMmzLA0YU/3dU
   E83wLEJ6/5uWKHOdQdelWSiIoQ46q43eXFFaM5hyh9BTbVCeJZYuQJjWC
   /yrXMnahB3oXeJBHdEcSSP/1J722upLdQQ0F26ux8BE9zG05tPympZw/R
   bAOU8rp0iteXXZWOxxSZWXNCF4k8vitiA3Kll6l9OK0dq4PlYdKZRJQut
   OB65KbzDeL5Mm2dgJWcvGJMSwc5Qpe7xFKpEx9btgKX3lZPxW4TZxiQke
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336475968"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="336475968"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:15:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="528017856"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.201]) ([10.255.30.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:15:21 -0800
Subject: Re: [kbuild-all] Re: gcc: error: unrecognized command-line option
 '-mno-space-regs'
To:     Helge Deller <deller@gmx.de>, kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202131837.mZeWy9J4-lkp@intel.com>
 <a7181772-ff49-fd35-2e9d-cfc2c2ce653e@gmx.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <5a693363-521b-3d9e-7ce7-6844a5eee7c3@intel.com>
Date:   Mon, 14 Feb 2022 17:15:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a7181772-ff49-fd35-2e9d-cfc2c2ce653e@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2022 6:26 AM, Helge Deller wrote:
> On 2/13/22 11:39, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
>> commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile failure when building 64-bit kernel natively
>> date:   6 months ago
>> config: parisc64-randconfig-r035-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131837.mZeWy9J4-lkp@intel.com/config)
>> compiler: hppa-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 prepare
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>>     scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>>>> gcc: error: unrecognized command-line option '-mno-space-regs'
>>>> gcc: error: unrecognized command-line option '-mno-space-regs'
>>>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'; did you mean '-mforce-indirect-call'?
>>>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'; did you mean '-mforce-indirect-call'?
>>>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>>>> gcc: error: unrecognized command-line option '-mschedule=7200'
> 
> Same issue as the other error.
> Here a 64bit compiler was used to build a 32-bit kernel...

Hi Helge,

Thanks for the explanation, it seems kernel still can be 32-bit if using
make ARCH=parisc64 randconfig, we'll check CONFIG_64BIT config directly
to decide the ARCH value.

Best Regards,
Rong Chen


> 
> I've queued up a patch in for-next which should give a better error message if
> someone uses such a wrong combination:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=b160628e9ebcdc85d0db9d7f423c26b3c7c179d0
> 
> Helge
> 
>>     make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
> 
>>>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>>>> gcc: error: unrecognized command-line option '-mschedule=7200'
>>     make[2]: *** [scripts/Makefile.build:271: scripts/mod/empty.o] Error 1
>>     make[2]: Target '__build' not remade because of errors.
>>     make[1]: *** [Makefile:1216: prepare0] Error 2
>>     make[1]: Target 'prepare' not remade because of errors.
>>     make: *** [Makefile:220: __sub-make] Error 2
>>     make: Target 'prepare' not remade because of errors.
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
