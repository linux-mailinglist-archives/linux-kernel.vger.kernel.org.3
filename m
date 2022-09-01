Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2D5A8D00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiIAFAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIAFAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:00:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419B1ADB1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662008401; x=1693544401;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ueruG8WsUTevhyhbBIXLg6A1hVu7N4IpTDEhHSBXoiw=;
  b=HwDwQoxWxyu314APWfSP/6HcH0GBou5tM6GhGEd0BUnchZ4oLi2srGj4
   AE9Wc2P2PuJ7QwO3C77acIrPMVk4z1uhTZ+tRdUbibnOeT2uGXkxcWaIE
   ccO4YFEv5NfDsP5L52U8dbbpORlUNRulZYAAfwdyGAwXqVqWpH81el/EP
   d0R9h7JgYedGB6wP4w8WMfOxi9VSYhCoH47WTbFUkjSOLezMPXtsUrlQo
   UBhNUJoedHmxRaRESi/Jk/2DRdH3fk/4iHmnlMiOcDOuA5O1ljIS1pFy4
   Znm4JUzWrQdhy4gzAb9cZ5TfIYr42Y1MUdz1s6Nx+sVHwcCg6hn4DXbzL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="276017921"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="276017921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 21:59:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673676377"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.213.173]) ([10.254.213.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 21:59:54 -0700
Subject: Re: [kbuild-all] Re: powerpc-linux-objdump: Warning: Unrecognized
 form: 0x23
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202208311414.4OPuYS9K-lkp@intel.com>
 <Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X>
 <b0b8fecd-4041-d04e-9a11-2c7947e5d5a0@intel.com>
 <YxAS9NBjBI/vi0XK@dev-arch.thelio-3990X>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <8d2c3aef-aa4f-1f4d-dc89-622554ffda31@intel.com>
Date:   Thu, 1 Sep 2022 12:59:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YxAS9NBjBI/vi0XK@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2022 10:03 AM, Nathan Chancellor wrote:
> Hi Rong,
> 
> On Thu, Sep 01, 2022 at 09:15:58AM +0800, Chen, Rong A wrote:
>>
>>
>> On 8/31/2022 11:40 PM, Nathan Chancellor wrote:
>>> On Wed, Aug 31, 2022 at 02:52:36PM +0800, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
>>>> commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
>>>> date:   5 months ago
>>>> config: powerpc-buildonly-randconfig-r003-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
>>>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
>>>> reproduce (this is a W=1 build):
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # install powerpc cross compiling tool for clang build
>>>>           # apt-get install binutils-powerpc-linux-gnu
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout f9b3cd24578401e7a392974b3353277286e49cee
>>>>           # save the config file
>>>>           mkdir build_dir && cp config build_dir/.config
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>>>>
>>>> If you fix the issue, kindly add following tag where applicable
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
>>>
>>> Given this is clang 16.0.0 with
>>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y, which uses DWARF5 by
>>> default instead of DWARF4, it looks like older binutils not
>>> understanding DWARF5. What version of binutils is being used by the bot?
>>
>> Hi Nathan,
>>
>> We're using binutils v2.38.90.20220713-2
>>
>> ||/ Name           Version            Architecture Description
>> +++-==============-==================-============-==========================================
>> ii  binutils       2.38.90.20220713-2 amd64        GNU assembler, linker and binary utilities
> 
> Thanks for chiming in! This looks like the output of 'dpkg -l', right? I

Hi Nathan,

oh, yes, I misunderstood, it's not related to this package.

> noticed on second glance that the tuple for the objdump warning above is
> 'powerpc-linux-', which leads me to believe that a kernel.org toolchain
> (or a self compiled one) is being used. I would expect the tuple to be
> 'powerpc-linux-gnu-' if Debian's package was being used. Is that
> possible?

you are right, we used a self-compiled toolchain, we'll try the binutils
from debian package.

Best Regards,
Rong Chen

> 
> Cheers,
> Nathan
> 
