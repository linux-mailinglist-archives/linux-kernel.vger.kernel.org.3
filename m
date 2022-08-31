Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18DD5A8121
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiHaPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHaPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3349DD8E23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FD16126C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8951C433C1;
        Wed, 31 Aug 2022 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661959351;
        bh=UUV4vyceD/4fkQRfY+VTKvh+YKjgTH1+99icf+D7VkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBT0WXEsGnhXjac2NaN8BpBswK4wiw/tBVQqrXjG3zfx1Hq+Ni96+UMRPmLtA+sms
         agS7a7naAO4sxcDDMm+aLV8gg57LSICO1XyAz0EdAYq12BZroMqaxXEXkBJ9xWWGl6
         UESCZ3qQ8DiOcdbO4D56hBtywPEfdbdY4trbtWSQYubow0bd4WYz/fylqoJwGyRQG0
         IeNOTLD68ug592FDSZHP6x837FcFXOoKdArXDzIZ322dJJVLcfbS2mkmjPhLeb8/Ys
         02QzeGvk2Q6XQ9ZLZqp2CFJ7SiR4AG8xYbz4GNhzGX8v3oqYW5nZQqDDFiKbeQmiY0
         v+zGylo06no8g==
Date:   Wed, 31 Aug 2022 08:22:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: arch/powerpc/math-emu/math_efp.c:927:1: error: type specifier
 missing, defaults to 'int'; ISO C99 and later do not support implicit int
Message-ID: <Yw98tcXEu0kgbrKE@dev-arch.thelio-3990X>
References: <202208310702.3iydJVg0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208310702.3iydJVg0-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 07:10:39AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
> commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
> date:   6 months ago
> config: powerpc-tqm8560_defconfig (https://download.01.org/0day-ci/archive/20220831/202208310702.3iydJVg0-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/math-emu/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/powerpc/math-emu/math_efp.c:927:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>    module_init(spe_mathemu_init);
>    ^
>    int
>    arch/powerpc/math-emu/math_efp.c:927:13: error: a parameter list without types is only allowed in a function definition
>    module_init(spe_mathemu_init);
>                ^
>    2 errors generated.

Thanks for the report, I've sent a fix:

https://lore.kernel.org/20220831152014.3501664-1-nathan@kernel.org/

Cheers,
Nathan
