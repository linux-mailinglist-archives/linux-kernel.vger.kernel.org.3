Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9F522FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiEKJuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 May 2022 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiEKJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:50:37 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3EA53A74
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:50:36 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id kk28so1709977qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8dmQh8Wju3vGFL/3ZvcxyWkLncPpUFikYQUoZDWGxhY=;
        b=pC1aZPuCdD9MFJufIweXVkX7N6kNtHTLJkQ3QH/IovlD9zGUG59ieUDZJw2rSFPv8c
         W7QSQFcreOXS5z8mGYlTYBtC6IPqK0nZwPdYVeq8FW1Qk8V3tP1Snzuzo+fbPH3wMHkB
         hr22bmR+Vv0+0wWJl3XjJkfBxSus/LUkZ4AcXo0FtKSqC94SEL0UyhBV7Foa4xNVGsTB
         RCE6hCVD06rH8h7C4ehcTYPvZFLZHciih7yn+kJJTCDLSqySWGJUPLTKpRmAO2ozqqDZ
         M4fXIW1Seg61NVp+pJvdkMUADKZOuCtB47+BIqPE+csztjgmgNWkogsLT6RKFE1wh35w
         +2aw==
X-Gm-Message-State: AOAM531P9ZR7P+U0UquAzbjMY2FKoVbiJ2nXw6y5d7aNhON9KYW4beue
        CIhPXmT2LtODaCxKuaiBXIgsMpNUJ29dUQ==
X-Google-Smtp-Source: ABdhPJyHY7raPg71dFU7UWyVAetDIoF8MD+WB335J2cEl4B2yO2hPtES6QO32Kw8JLtjj/kHED3kcA==
X-Received: by 2002:a05:6214:401a:b0:45a:c665:e56f with SMTP id kd26-20020a056214401a00b0045ac665e56fmr21157016qvb.45.1652262634978;
        Wed, 11 May 2022 02:50:34 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 133-20020a370c8b000000b0069fcabfdaebsm895709qkm.70.2022.05.11.02.50.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:50:34 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f7b815ac06so14496707b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:50:34 -0700 (PDT)
X-Received: by 2002:a81:2143:0:b0:2fb:1274:247e with SMTP id
 h64-20020a812143000000b002fb1274247emr24150345ywh.384.1652262634057; Wed, 11
 May 2022 02:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <202205111652.rA2Gh5Sy-lkp@intel.com>
In-Reply-To: <202205111652.rA2Gh5Sy-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 11:50:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFqBUnm9Ukw2aac2nZv-9dAxBcXnwWpa3Snyani8-jpA@mail.gmail.com>
Message-ID: <CAMuHMdVFqBUnm9Ukw2aac2nZv-9dAxBcXnwWpa3Snyani8-jpA@mail.gmail.com>
Subject: Re: {standard input}:1155: Error: operands mismatch -- statement
 `divu.l %d0,%d3:%d7' ignored
To:     kernel test robot <lkp@intel.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:48 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
> commit: 9012d011660ea5cf2a623e1de207a2bc0ca6936d compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
> date:   3 years ago
> config: m68k-randconfig-r003-20220509 (https://download.01.org/0day-ci/archive/20220511/202205111652.rA2Gh5Sy-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9012d011660ea5cf2a623e1de207a2bc0ca6936d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9012d011660ea5cf2a623e1de207a2bc0ca6936d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    {standard input}: Assembler messages:
>    {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
>    {standard input}:369: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `add.b %d3,%d1' ignored
>    {standard input}:505: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d3,%d1' ignored
>    {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
>    {standard input}:650: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a0){%d1,#8},%d1' ignored
>    {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
>    {standard input}:752: Error: operands mismatch -- statement `mulu.l 8(%a0),%d2:%d4' ignored
>    {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d7:%d6' ignored
>    {standard input}:755: Error: operands mismatch -- statement `mulu.l 8(%a0),%d7:%d5' ignored
>    {standard input}:765: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxl.l #1,%d0' ignored
>    {standard input}:768: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxl.l #1,%d3' ignored
>    {standard input}:819: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d0{#0,#32},%d2' ignored
>    {standard input}:835: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
>    {standard input}:835: Error: operands mismatch -- statement `mulu.l 8(%a0),%d2:%d4' ignored
>    {standard input}:835: Error: operands mismatch -- statement `mulu.l 4(%a0),%d7:%d6' ignored
>    {standard input}:838: Error: operands mismatch -- statement `mulu.l 8(%a0),%d7:%d5' ignored
>    {standard input}:853: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d2{#0,#32},%d0' ignored
>    {standard input}:926: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d3{#0,#32},%d2' ignored
>    {standard input}:937: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d3{#0,#32},%d0' ignored
>    {standard input}:1062: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a0){%d0,#8},%d0' ignored
> >> {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
> >> {standard input}:1166: Error: operands mismatch -- statement `divu.l %d2,%d4:%d1' ignored
> >> {standard input}:1166: Error: operands mismatch -- statement `mulu.l %d1,%d3:%d0' ignored
> >> {standard input}:1169: Error: operands mismatch -- statement `mulu.l %d3,%d2:%d7' ignored
> >> {standard input}:1174: Error: operands mismatch -- statement `mulu.l 4(%a1),%d0:%d1' ignored
>    {standard input}:1211: Error: operands mismatch -- statement `divu.l %d2,%d4:%d1' ignored
>    {standard input}:1211: Error: operands mismatch -- statement `mulu.l %d1,%d3:%d0' ignored
>    {standard input}:1215: Error: operands mismatch -- statement `mulu.l %d3,%d2:%d7' ignored
>    {standard input}:1223: Error: operands mismatch -- statement `mulu.l 4(%a1),%d0:%d1' ignored
>    {standard input}:1282: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
>    {standard input}:1293: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d1{#0,#32},%d2' ignored
>    {standard input}:1314: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d1{#0,#32},%d2' ignored
>    {standard input}:1416: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxr.l #1,%d0' ignored
>    {standard input}:1420: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxr.l #1,%d2' ignored
>    {standard input}:1425: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `roxr.l #1,%d0' ignored
>    {standard input}:1451: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d0{#0,#32},%d2' ignored
>    {standard input}:1461: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfffo %d0{#0,#32},%d2' ignored
>    {standard input}:1554: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a0){%d0,#8},%d0' ignored
>    {standard input}:2057: Error: operands mismatch -- statement `mulu.l %d3,%d3:%d0' ignored
>    {standard input}:2269: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a3){%d0,#8},%d0' ignored
>    {standard input}:2401: Error: operands mismatch -- statement `divu.l 4(%a4),%d0:%d1' ignored
>    {standard input}:2483: Error: operands mismatch -- statement `divu.l %d3,%d0:%d1' ignored
>    {standard input}:2585: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a3){%d0,#8},%d0' ignored
>    {standard input}:2970: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a3){%d1,#8},%d1' ignored

Thanks patch sent, should appear soon at
https://lore.kernel.org/r/e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
