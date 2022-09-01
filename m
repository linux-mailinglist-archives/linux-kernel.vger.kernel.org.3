Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D95A8DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiIAFwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIAFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:52:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742BD1178F2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662011568; x=1693547568;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uRo9p3jFlj0FmuG121IKZKYM2BdiNLm74eHX8SYd4d8=;
  b=I0yjYPMGr7G1gdi0OCr70zoKk1+6wbwPj9NAHJkrpYG/ZyIQAFGiFm8Z
   GjTlkHilREz65GIH1Wrldb2fLn8HHyP/qCx9jyHXrpTq/OJK9pu5Mdj5Y
   dPwtU+trThSoS6KKmJzDeUPO/7hCOjiyaTFbCjH+Aw3SYD46xCts16yyu
   6EWOsoLQdJJH4HY8MC1lK7aWWbOv21fvA99DdjbZO4MweUo9xDNA2ztEO
   W0R4zmM7ZMy1CJBGRQpF4KmzTRZqLV4mpBmTt4hqPrpZ8e8fkdjq0LV0o
   xtvU0McFoyyZkAHjhvcMzECnG9YOiQKNzcsT2st3unM1uAMc4RSHQmMWn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296407715"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="296407715"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 22:52:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673691146"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.213.173]) ([10.254.213.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 22:52:45 -0700
Subject: Re: [kbuild-all] Re: powerpc-linux-objdump: Warning: Unrecognized
 form: 0x23
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202208311414.4OPuYS9K-lkp@intel.com>
 <Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X>
 <b0b8fecd-4041-d04e-9a11-2c7947e5d5a0@intel.com>
 <YxAS9NBjBI/vi0XK@dev-arch.thelio-3990X>
 <8d2c3aef-aa4f-1f4d-dc89-622554ffda31@intel.com>
 <9d77cb93-2eff-d87d-6554-1636d5e7d5ec@csgroup.eu>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0acfb209-a792-a47b-0261-9fb29824e4b9@intel.com>
Date:   Thu, 1 Sep 2022 13:52:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9d77cb93-2eff-d87d-6554-1636d5e7d5ec@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2022 1:45 PM, Christophe Leroy wrote:
> 
> 
> Le 01/09/2022 à 06:59, Chen, Rong A a écrit :
>>
>>
>> On 9/1/2022 10:03 AM, Nathan Chancellor wrote:
>>> Hi Rong,
>>>
>>> On Thu, Sep 01, 2022 at 09:15:58AM +0800, Chen, Rong A wrote:
>>>>
>>>>
>>>> On 8/31/2022 11:40 PM, Nathan Chancellor wrote:
>>>>> On Wed, Aug 31, 2022 at 02:52:36PM +0800, kernel test robot wrote:
>>>>>> tree:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>> master
>>>>>> head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
>>>>>> commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug:
>>>>>> make DEBUG_INFO selectable from a choice
>>>>>> date:   5 months ago
>>>>>> config: powerpc-buildonly-randconfig-r003-20220830
>>>>>> (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
>>>>>> compiler: clang version 16.0.0
>>>>>> (https://github.com/llvm/llvm-project
>>>>>> c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
>>>>>> reproduce (this is a W=1 build):
>>>>>>            wget
>>>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>            chmod +x ~/bin/make.cross
>>>>>>            # install powerpc cross compiling tool for clang build
>>>>>>            # apt-get install binutils-powerpc-linux-gnu
>>>>>>            #
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
>>>>>>            git remote add linus
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>>            git fetch --no-tags linus master
>>>>>>            git checkout f9b3cd24578401e7a392974b3353277286e49cee
>>>>>>            # save the config file
>>>>>>            mkdir build_dir && cp config build_dir/.config
>>>>>>            COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
>>>>>> make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>>>>>>
>>>>>> If you fix the issue, kindly add following tag where applicable
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All warnings (new ones prefixed by >>):
>>>>>>
>>>>>>>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
>>>>>
>>>>> Given this is clang 16.0.0 with
>>>>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y, which uses DWARF5 by
>>>>> default instead of DWARF4, it looks like older binutils not
>>>>> understanding DWARF5. What version of binutils is being used by the
>>>>> bot?
>>>>
>>>> Hi Nathan,
>>>>
>>>> We're using binutils v2.38.90.20220713-2
>>>>
>>>> ||/ Name           Version            Architecture Description
>>>> +++-==============-==================-============-==========================================
>>>> ii  binutils       2.38.90.20220713-2 amd64        GNU assembler,
>>>> linker and binary utilities
>>>
>>> Thanks for chiming in! This looks like the output of 'dpkg -l', right? I
>>
>> Hi Nathan,
>>
>> oh, yes, I misunderstood, it's not related to this package.
>>
>>> noticed on second glance that the tuple for the objdump warning above is
>>> 'powerpc-linux-', which leads me to believe that a kernel.org toolchain
>>> (or a self compiled one) is being used. I would expect the tuple to be
>>> 'powerpc-linux-gnu-' if Debian's package was being used. Is that
>>> possible?
>>
>> you are right, we used a self-compiled toolchain, we'll try the binutils
>> from debian package.
> 
> Can you first tell us the version you are using ?
> 
> 	powerpc-linux-objdump -v
> 
> That will tell you the version.

Hi Christophe,

the version is v2.38:

$ ./powerpc-linux-objdump -v
GNU objdump (GNU Binutils) 2.38
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later 
version.
This program has absolutely no warranty.

Best Regards,
Rong Chen

> 
> Thanks
> Christophe
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
