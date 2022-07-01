Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9A563129
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiGAKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiGAKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:15:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BBC7697F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656670554; x=1688206554;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ICpk4BeG3cKDQKqNlOkXAbISepMtYgBugI1m55Tl1M4=;
  b=jkZSdTqHMVrXBaEDcHJ4KCemJVHqb+qikZghjMbSCUdmJsmLIW2xfG3R
   Hn4YjOFzpovbz3VH6cOn4/+m8WcgjyRoEjif3iqickKQs2www9640qnWH
   +nt47nwk2gNMIQWd7CqioowSJi6dPkKN+KNcqtdnqWNxuZXgCGFC/FMjs
   KPDRzQBA1lnTX0NjOZCTyLYKD1g7z/UNCgSwonUxYK5EHKGFEZfG6EPKl
   HTebzG7Lvhyv77Tzf24hRhNLtKHFTUSyxVu5V+KLm0oMGrwZ+etHU2RB/
   xQdxL6cZSfOhqj8FU+VSKr4E/uaRhlXoLPFODldhHf4b70NZz77QL1moA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346605277"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="346605277"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 03:15:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="648293947"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.109]) ([10.255.28.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 03:15:51 -0700
Subject: Re: [kbuild-all] Re:
 [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a 123/140]
 xtensa-linux-ld: arch/xtensa/kernel/entry.o:undefined reference to
 `context_tracking_user_exit'
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202207010405.MVCHQe6d-lkp@intel.com>
 <20220630230823.GD1790663@paulmck-ThinkPad-P17-Gen-1>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <fe28b30e-dbc9-dba3-7275-2baa2e68197a@intel.com>
Date:   Fri, 1 Jul 2022 18:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220630230823.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2022 7:08 AM, Paul E. McKenney wrote:
> On Fri, Jul 01, 2022 at 04:15:11AM +0800, kernel test robot wrote:
>> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
>> head:   0ba7324b44282870af740a5a121add62c7f5f730
>> commit: 9d16390cc0d00ae1100bca4f4adb0ae2906631ec [123/140] context_tracking: Take idle eqs entrypoints over RCU
>> config: xtensa-randconfig-r004-20220629 (https://download.01.org/0day-ci/archive/20220701/202207010405.MVCHQe6d-lkp@intel.com/config)
>> compiler: xtensa-linux-gcc (GCC) 11.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/ammarfaizi2/linux-block/commit/9d16390cc0d00ae1100bca4f4adb0ae2906631ec
>>          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>>          git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
>>          git checkout 9d16390cc0d00ae1100bca4f4adb0ae2906631ec
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> This should be fixed in the current version of this commit:
> 
> 6a87dff9f33a ("context_tracking: Take idle eqs entrypoints over RCU")
> 
> Please let me know if this commit does not address the problem.
> 
> 							Thaxn, Paul


Hi Paul,

I have confirmed that there's no such issue on commit 6a87dff9f33a,
but I'm not sure the commit fixed the issue, I can't find the error on
parent commit 24a9c54182b3 too.

   $ git log --oneline -2 6a87dff9f33a
   6a87dff9f33af context_tracking: Take idle eqs entrypoints over RCU
   24a9c54182b37 context_tracking: Split user tracking Kconfig

Best Regards,
Rong Chen

> 
>> All errors (new ones prefixed by >>):
>>
>>>> xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0x0): undefined reference to `context_tracking_user_exit'
>>>> xtensa-linux-ld: arch/xtensa/kernel/entry.o:(.text+0xc): undefined reference to `context_tracking_user_enter'
>>     xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception':
>>     arch/xtensa/kernel/entry.S:459: undefined reference to `context_tracking_user_exit'
>>     xtensa-linux-ld: arch/xtensa/kernel/entry.o: in function `common_exception_return':
>>     arch/xtensa/kernel/entry.S:542: undefined reference to `context_tracking_user_enter'
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
