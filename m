Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7B5141F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354228AbiD2FwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbiD2FwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:52:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F415B18A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD5B0B831C0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68F9C385A4;
        Fri, 29 Apr 2022 05:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651211324;
        bh=Tp7mTVYH5uoGc7j1fbM0+/1kb8iDMC+MhnSOZBu/DhI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Y/eZnUagjyS4EnMcMEB+rP3jCgBiM2JxClAoTs25gOJNtaWM2J2ecCN1BmGCvyfP1
         Zdwafi2btGRfH2DO9tf8ObERmithgVnAVMpzeDnPqXdhjI1IBjFSbX5gFxhuuQ9ngH
         Bv8RTiyqvqIF1/0d1fqGvQOzgqddgi/EvhObu6LcNHaJ85WyD6nbhJJzh2mFlKM/zt
         6hKotk5NtYYn/vQ1o7i9MkxfKPo7H1pya0cNQgQyNfWv5YJPU/uGP3rI0S7PYpiYKv
         o6CjcX7NfGZ1E36L7MXtmwS8yyB9VDOcx+yhBgrik4grIgtqn/VD06/CkkTLQ+utg8
         xKUuHw1FGQJcw==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Zong-Zhe Yang <kevin_yang@realtek.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [ammarfaizi2-block:kvalo/ath/pending 7/57] drivers/net/wireless/realtek/rtw89/ser.c:319:2: warning: unannotated fall-through between switch labels
References: <202204290113.w78dhtXk-lkp@intel.com>
Date:   Fri, 29 Apr 2022 08:48:40 +0300
In-Reply-To: <202204290113.w78dhtXk-lkp@intel.com> (kernel test robot's
        message of "Fri, 29 Apr 2022 01:47:27 +0800")
Message-ID: <87fslwfnif.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Zong-Zhe,
>
> FYI, the error/warning still remains.
>
> tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
> head:   5c6cf64b40b98e4d4247fda11e4b4c859a24585d
> commit: 14f9f4790048f684c2b151c899895feae0b5731a [7/57] rtw89: ser: control hci interrupts on/off by state
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220429/202204290113.w78dhtXk-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/ammarfaizi2/linux-block/commit/14f9f4790048f684c2b151c899895feae0b5731a
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
>         git checkout 14f9f4790048f684c2b151c899895feae0b5731a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/misc/lkdtm/ drivers/net/wireless/realtek/rtw89/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/realtek/rtw89/ser.c:319:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>            default:
>            ^
>    drivers/net/wireless/realtek/rtw89/ser.c:319:2: note: insert 'break;' to avoid fall-through
>            default:
>            ^
>            break; 
>    1 warning generated.

This commit should fix it:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=5ddfffd6da9b94e5f6397843ad1a54d6a211f652

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
