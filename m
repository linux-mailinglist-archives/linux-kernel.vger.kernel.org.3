Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5736D51F241
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiEIBaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiEIAHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:07:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942ADDEF1
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UER95YhL/LdSDTOz/ulO8m1XkwQ4O0+2EBlTjF/ksUc=; b=ov63tU4N3g/lMAU9V7LrP+vhfa
        iJdiZomwAYWqTcm6mrl/mT25qG6BE5WoNCQ/SBnPGJdw9Mk2wkcpY08+8xNVi0FgqacZ7MsJl2Sja
        IXMSwW9v4+Bc9smCeKr7X/DxrQUFbGPaTi9LP/r+R7kzFtN4J5zEVaCIPIGieIn7ygKRtuNwo7qmp
        knKqv20dxmrvqr3Qup2PUm49b0pheF3oCEqXVTqvyij3EwlOPlnb02zk85MAWlbhhgU6tML3O/q7r
        CgZeoxeYwscxuLcvi9RSOfQ3jPPbJlp4tzTG/lOafR1SpJ/VsHmvqnunCsLarCd09KxDhflyfIQEQ
        //QBuf5w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnqrz-002whA-Ar; Mon, 09 May 2022 00:03:23 +0000
Message-ID: <65c92404-1d6f-6969-89bf-20b8eefaeff6@infradead.org>
Date:   Sun, 8 May 2022 17:03:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: drivers/hwmon/ltq-cputemp.c:23:2: error: call to undeclared
 function 'ltq_cgu_w32'; ISO C99 and later do not support implicit function
 declarations
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Eckert <fe@dev.tdt.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <202205080416.vzIXy16B-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202205080416.vzIXy16B-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Adding TO: and CC: that are at end of message but are not
included originally.


On 5/7/22 13:54, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   30c8e80f79329617012f07b09b70114592092ea4
> commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
> date:   8 weeks ago
> config: mips-randconfig-r022-20220507 (https://download.01.org/0day-ci/archive/20220508/202205080416.vzIXy16B-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af4cf1c6b8ed0d8102fc5e69acdc2fcbbcdaa9a7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/hwmon/ltq-cputemp.c:23:2: error: call to undeclared function 'ltq_cgu_w32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
>            ^
>>> drivers/hwmon/ltq-cputemp.c:23:14: error: call to undeclared function 'ltq_cgu_r32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
>                        ^
>    drivers/hwmon/ltq-cputemp.c:28:2: error: call to undeclared function 'ltq_cgu_w32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) & ~CGU_TEMP_PD, CGU_GPHY1_CR);
>            ^
>    drivers/hwmon/ltq-cputemp.c:28:14: error: call to undeclared function 'ltq_cgu_r32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) & ~CGU_TEMP_PD, CGU_GPHY1_CR);
>                        ^
>    drivers/hwmon/ltq-cputemp.c:39:12: error: call to undeclared function 'ltq_cgu_r32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    value = (ltq_cgu_r32(CGU_GPHY1_CR) >> 9) & 0x01FF;
>                             ^
>    drivers/hwmon/ltq-cputemp.c:92:24: error: use of undeclared identifier 'SOC_TYPE_VR9_2'
>            if (ltq_soc_type() != SOC_TYPE_VR9_2)
>                                  ^
>    6 errors generated.
> 
> 
> vim +/ltq_cgu_w32 +23 drivers/hwmon/ltq-cputemp.c
> 
> 7074d0a9275860 Florian Eckert 2017-09-01  20  
> 7074d0a9275860 Florian Eckert 2017-09-01  21  static void ltq_cputemp_enable(void)
> 7074d0a9275860 Florian Eckert 2017-09-01  22  {
> 7074d0a9275860 Florian Eckert 2017-09-01 @23  	ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
> 7074d0a9275860 Florian Eckert 2017-09-01  24  }
> 7074d0a9275860 Florian Eckert 2017-09-01  25  
> 
> :::::: The code at line 23 was first introduced by commit
> :::::: 7074d0a92758603369655ef5d4f49e6caaae0b4e hwmon: (ltq-cputemp) add cpu temp sensor driver
> 
> :::::: TO: Florian Eckert <fe@dev.tdt.de>
> :::::: CC: Guenter Roeck <linux@roeck-us.net>

This driver builds fine if I change it from SOC_FALCON to SOC_XWAY.
Maybe its Kconfig entry should be stronger?

config SENSORS_LTQ_CPUTEMP
	bool "Lantiq cpu temperature sensor driver"
-	depends on LANTIQ
+	depends on SOC_XWAY

?

-- 
~Randy
