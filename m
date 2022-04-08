Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2514F8E96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiDHF2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiDHF15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8B59394;
        Thu,  7 Apr 2022 22:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E26961E6B;
        Fri,  8 Apr 2022 05:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B753C385A1;
        Fri,  8 Apr 2022 05:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649395553;
        bh=QeG7e3it6xxlS97YcIp53LJohPxHBHQayoT1m2dcYRs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uy1+Efjrm8Psbhx5lRdKfFCeV5bDzw4z8FUthEHDYEPTP1vA6AcCzoEB3IZgheWBJ
         fS/TUaZ1Af/ru/ySHzYP5ECpM58OSUfBUDNvhCL8A/6CNuRfJbiwb/Fv+VJkPiD5ij
         gItwanegZG9lorKJzLvZpE4U+t1bxf4OpfcM+g3kZcxqGCNHQnXnPMGd/NES2rlKx+
         j2BnAGyq/yRGLRvv2v3Ze5aRYn+J6DhrHYANCg4z/DdS4V3a616p/G9QUWbXNcQkMU
         VgNRSpoGyuB5tPm6YzHUZyLSj8XO0/5tLJ61d48VFBsuGvphrHXSiI7SGUTu8wQs/F
         ZHu0na+eYUn1g==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Zong-Zhe Yang <kevin_yang@realtek.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [ammarfaizi2-block:kvalo/ath/pending 9/45] drivers/net/wireless/realtek/rtw89/ser.c:319:2: warning: unannotated fall-through between switch labels
References: <202204071343.R89skHKl-lkp@intel.com>
Date:   Fri, 08 Apr 2022 08:25:48 +0300
In-Reply-To: <202204071343.R89skHKl-lkp@intel.com> (kernel test robot's
        message of "Thu, 7 Apr 2022 13:29:53 +0800")
Message-ID: <87k0c0p2n7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
> head:   e1bd1e32fab0c91cf7a87e96fee9270e98e79351
> commit: 14f9f4790048f684c2b151c899895feae0b5731a [9/45] rtw89: ser: control hci interrupts on/off by state
> config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220407/202204071343.R89skHKl-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/ammarfaizi2/linux-block/commit/14f9f4790048f684c2b151c899895feae0b5731a
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
>         git checkout 14f9f4790048f684c2b151c899895feae0b5731a
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/wireless/realtek/rtw89/
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

This should fix the warning:

https://patchwork.kernel.org/project/linux-wireless/patch/20220408001353.17188-2-pkshih@realtek.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
