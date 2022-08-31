Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD205A8205
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiHaPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiHaPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909CDCFDC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5BF261798
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5194C433C1;
        Wed, 31 Aug 2022 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661960503;
        bh=4jj0j/Dky+Nul3U5gxPx8/R2lvdkzDGMVz3x1CQBrYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuhYiSBZMeIAlWain0/i9Ps3BSj7fbwp8g1mx94gcYfcJmX9RT5qo3OlcjLime/vX
         Sru2tiIyBsMpakX3GRpT8M0AH2mTG7f0gPUufRTfJl4grMyH3HRmVDvVTAxjVNhHqt
         0edKLEn1ZeJQB12C6wld9cZN//OpLollIBGsQMSOg2qvAHM3P7Izm77eoKjrEt9v+Y
         sdb3woonLdAiAQI/C2Wjv4Q0pUr3vezVpr+YbTs6y9COlupsoUIugY14iu0DY+0mnT
         dHVyKgTKhCwJGZWWQqNII0FIGZoR0OyzrGJ3iOFmCwJmg0qYVXT9U2lMDDMNdL5Gq1
         3yTLgSt/poE/g==
Date:   Wed, 31 Aug 2022 08:41:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: powerpc-linux-objdump: Warning: Unrecognized form: 0x23
Message-ID: <Yw+BNAe9dXPdya0o@dev-arch.thelio-3990X>
References: <202208311529.oy9I92hy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208311529.oy9I92hy-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:14:04PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
> commit: 86ce436e30d86327c9f5260f718104ae7b21f506 macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled
> date:   3 months ago
> config: powerpc-buildonly-randconfig-r004-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311529.oy9I92hy-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86ce436e30d86327c9f5260f718104ae7b21f506
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 86ce436e30d86327c9f5260f718104ae7b21f506
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> powerpc-linux-objdump: Warning: Unrecognized form: 0x23

Sorry for the noise, seems like it is the same issue as
https://lore.kernel.org/Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X/.

Cheers,
Nathan
