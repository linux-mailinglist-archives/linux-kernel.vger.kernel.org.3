Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99605767FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiGOUKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGOUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:10:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8A4B0F4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0816AB82E4C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 20:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A72C341C0;
        Fri, 15 Jul 2022 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657915805;
        bh=HJoPFEFLh4BbRDqJRXWZVqcGp9gCtdCVTUp8CpfJo00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9jtgz8TBxYvw4iLTMWuVKyJqUZQlf1rMd3lHZeDy9NOj7+AjOr0DQBgGiLocunWW
         T1wdkDyQrlbYzIM28qPdLQn3yBt2YHC+/XVOstYOgBF4oUtiliRLinfsNZOUP+60nM
         yYCtzrLVDM8yxKWNS7ldpXaLXzplYV1JQkumDFQC0CfWv16eZXeNcB9wVopjaCnswv
         tRFRZuWmoGbGLOO2TYemv38NF3+VupdTxCmnbj1h7Av9QLIosoXDcW7q9GUJ6KWG3m
         5ea5qBAGcVw6nWX6Er71OXbwY3h7k/TtlyhudFqUkFe2NA26bu1/H4WvopUnZWtWuV
         zWc3+xRZG1vyQ==
Date:   Fri, 15 Jul 2022 13:10:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: <instantiation>:3:3: error: invalid instruction mnemonic
 'annotate_unret_safe'
Message-ID: <YtHJm0Uiv4c7ihTf@dev-arch.thelio-3990X>
References: <202207160308.NAwtZPxG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207160308.NAwtZPxG-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 03:22:46AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
> commit: 9bb2ec608a209018080ca262f771e6a9ff203b6f objtool: Update Retpoline validation
> date:   3 weeks ago
> config: i386-randconfig-a011-20220704 (https://download.01.org/0day-ci/archive/20220716/202207160308.NAwtZPxG-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bb2ec608a209018080ca262f771e6a9ff203b6f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9bb2ec608a209018080ca262f771e6a9ff203b6f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> <instantiation>:3:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:11:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:19:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:27:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:35:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:43:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:51:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:59:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:67:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:75:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:83:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:91:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:99:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:107:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:115:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:123:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)
>     ^
>    <instantiation>:131:3: error: invalid instruction mnemonic 'annotate_unret_safe'
>      ANNOTATE_UNRET_SAFE
>      ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
>     .rept ((1 << 12) / 32)

Looks like https://git.kernel.org/tip/3131ef39fb03bbde237d0b8260445898f3dfda5b
should take care of this (not clang specific, GCC errors too with the
same configuration).

Cheers,
Nathan
