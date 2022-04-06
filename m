Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309094F609E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiDFNtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiDFNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:48:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2F3EBBB0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649243492; x=1680779492;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5zAPlitVhq7Zz5awiIbt0Hh0xmnzODkAAmPavcozI8E=;
  b=k82Pod7XocIbdQe/mGxZT7SONngLpWTCE212KTidzgQOx8TnOGxvXZEe
   1C5PDC02mKGZN3K/WfQIVP3VvLEdHsewxM0r/OdJKr9HCRvM8Bl4bwj83
   a8p2j8q4NE3GaS0J8iH2dLsgMJr5MWArPE4Zfrxvg+can6g8zI8OPN/jw
   cXdI3sD3afLnHeCEXx8rPy4ohnvmswJNx4r128L/5eYaRhUl/eMsX5plo
   RPqkHjDfQHuUXKVOpQw+eR9dmnXQe2DEq4fcK16ZCdogdggeAA0GgCTqB
   xW1UhWj1qzrbIZXl0Fo8faHVnvZCwAtgwxNIVwuHJP9fhGyEwwtQbyGv6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="248540598"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="248540598"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:11:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570468489"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.64]) ([10.249.173.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:11:29 -0700
Subject: Re: [kbuild-all] Re:
 [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a 109/158] WARNING:
 modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference from the
 function ieee802154_iface_init() to the variable .init.text:.L0
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202204040012.4Fu9uBps-lkp@intel.com>
 <20220403183040.GP4285@paulmck-ThinkPad-P17-Gen-1>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <53cf3eac-37d5-17d6-3805-416a71256e98@intel.com>
Date:   Wed, 6 Apr 2022 19:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220403183040.GP4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2022 2:30 AM, Paul E. McKenney wrote:
> On Mon, Apr 04, 2022 at 12:20:22AM +0800, kernel test robot wrote:
>> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
>> head:   d9f3e7d671416fdf5b61f094765754269b652db0
>> commit: c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba [109/158] rcu: Add polled expedited grace-period primitives
>> config: 	 (https://download.01.org/0day-ci/archive/20220404/202204040012.4Fu9uBps-lkp@intel.com/config)
>> compiler: riscv32-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/ammarfaizi2/linux-block/commit/c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
>>          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>>          git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
>>          git checkout c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference from the function ieee802154_iface_init() to the variable .init.text:.L0
>> The function ieee802154_iface_init() references
>> the variable __init .L0 .
>> This is often because ieee802154_iface_init lacks a __init
>> annotation or the annotation of .L0 is wrong.
>>
>> Note: the below error/warnings can be found in parent commit:
>> << WARNING: modpost: vmlinux.o(.text+0x432e6): Section mismatch in reference from the function dma_get_required_mask() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xe35ca): Section mismatch in reference from the function mlock_page_drain() to the variable .init.text:.LVL125
>> << WARNING: modpost: vmlinux.o(.text+0x96a46e): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a5b4): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a5c0): Section mismatch in reference from the function rpmsg_send() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a5d4): Section mismatch in reference from the function rpmsg_sendto() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a5e8): Section mismatch in reference from the function rpmsg_send_offchannel() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a5fc): Section mismatch in reference from the function rpmsg_trysend() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a610): Section mismatch in reference from the function rpmsg_trysendto() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0x96a624): Section mismatch in reference from the function rpmsg_poll() to the variable .init.text:.L0
> 
> I freely confess that I have no idea what any of these error messages
> are trying to tell me.  What is ".init.txt.L0"?  How did my patch affect
> ieee802154_iface_init() or the register_netdevice_notifier() function
> that it invokes?  For that matter, how did my patch cause an access to
> be made to __init data from a non-__init function?
> 
> 							Thanx, Paul

Hi Paul,

Sorry for the inconvenience, only below warning was triggered by the commit:

 >> All warnings (new ones prefixed by >>, old ones prefixed by <<):
 >>
 >>>> WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in 
reference from the function ieee802154_iface_init() to the variable 
.init.text:.L0

the others are for reference only:
 >> Note: the below error/warnings can be found in parent commit

The problem has existed for some time before your patch, we'll add it to
ignore list to avoid noise.

Best Regards,
Rong Chen
