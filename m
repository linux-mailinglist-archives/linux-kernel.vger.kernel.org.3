Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF5505FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiDRW2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:28:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29D2A73F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:25:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so13443421pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kWeSEYtYBPSYXGJ5RGMLqKeBHN5Pc+xvOucSvPfOeZg=;
        b=CnIjaqlaeuJAiO6U112UMkMu+Gs3ua/Wk/YIozUrSHz51MEzfGmavFOIenjJeW0Vgd
         L8aP+vVXpId30nfUrXvNJqLmAaksYO1xM54mkfwFef/KAGXC5KHfNqnunzckHHsCx+co
         jii3Lhdi2Snj9b8i/smtl/SChsn/lBKmKoC7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kWeSEYtYBPSYXGJ5RGMLqKeBHN5Pc+xvOucSvPfOeZg=;
        b=1IDNP9SRMrei/hJ7wxogrcQPzAjI2ZSNEg+DKDAasMPIYjL3aGKI5HOHdV4REbaeTW
         m69I4X9Ekc+exJAFNm7dGlAhoI8L7s+lfMW8Ff/cKBg/5gwD2RQfHOx5N1noIO2Ffom3
         1UyUXoIfktl2dM/bkgMQ1ERYVDNCDRDHFBB5KevThqH4Uou6vFdTGAwZanbxKX1TvFdU
         pHjLbvP0TV71I/zg/PjQEVljCPjc/ezyoyw4hHC2u+x+Zdl020oWBg1J5cFPXB3aoaYh
         vWjgKrVpCKsXDAM9j2H5bqemcRBx5HZfquMQ8boanMT9ZRr86e2O9Ma1vNEfwyrYMA0B
         ww+g==
X-Gm-Message-State: AOAM532IPcx5NSU84qKpHQDVr4i7T6D1UPV+DhM4qDpXaSzaJ1uE/85s
        MfGE3v5atm2YeNPdqE5+eaRWnw==
X-Google-Smtp-Source: ABdhPJymv4/Uhq/UT762Up/mlbsIqwm8nYfkq9DeRGXW5Oq43p/ox3HaSjeX+atWC4G1+vCbPYJ8Mw==
X-Received: by 2002:a17:902:9a8c:b0:15a:a21:b52a with SMTP id w12-20020a1709029a8c00b0015a0a21b52amr1278514plp.86.1650320748108;
        Mon, 18 Apr 2022 15:25:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm13571318pfw.77.2022.04.18.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:25:47 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:25:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [kees:for-next/lkdtm 6/6] drivers/misc/lkdtm/cfi.c:62:37:
 warning: cast from pointer to integer of different size
Message-ID: <202204181515.FC6649DC81@keescook>
References: <202204170710.LwCV5Ec0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204170710.LwCV5Ec0-lkp@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 07:26:33AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
> head:   2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> commit: 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25 [6/6] lkdtm: Add CFI_BACKWARD to test ROP mitigations
> config: sparc-randconfig-r026-20220417 (https://download.01.org/0day-ci/archive/20220417/202204170710.LwCV5Ec0-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
>         git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
>         git fetch --no-tags kees for-next/lkdtm
>         git checkout 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/lkdtm/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/misc/lkdtm/cfi.c: In function 'set_return_addr_unchecked':
> >> drivers/misc/lkdtm/cfi.c:62:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
>          |                                     ^
>    drivers/misc/lkdtm/cfi.c:72:13: note: in expansion of macro 'no_pac_addr'
>       72 |         if (no_pac_addr(*ret_addr) == expected)
>          |             ^~~~~~~~~~~

Hmm. I don't see why this is warning. The macro looks like untagged_addr():

#define untagged_addr(addr)     ({ \
        u64 __addr = (__force u64)(addr); \
        __addr &= __untagged_addr(__addr); \
        (__force __typeof__(addr))__addr; \
})


-- 
Kees Cook
