Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1682956088F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiF2SFu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiF2SFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:05:14 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA402403F6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:04:09 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id f14so12731907qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+DyMdSELpMsE9UL+Un7HNtT9x0W8nOtMV/6G+JcfLhY=;
        b=4F9DmHmrS0XlWzGobT3K552GJ1FZ9HyIXDCV1x09B4IkeGCOFKcxU7whPgcsgWs0qg
         m1yTKRvlpFvbIcIWVPPlUYWcpbAcEgdGQuq2n7Lo9RE4sbxMa8f4yANJ0VirI/0Pk+Dz
         7nP9jc1uTXXSq0WlvCc8fxpL3BoLqL5AfYUznvNy8vqzDris78VIWS/7YfTxkyeATXR2
         i+2MZtbjj7VtRKUyQdkPSkm7b2wMzEWvfJTRGxhxLN2Fz9FBi7TKyzk88tJ1g8X/lLmU
         bagKjHq9ntghhBiGLuZ79i7NfLCBb1ww2JxOHAwB0VTSXhc3TQQ3V1AIwJsb90XfNJkK
         KBNg==
X-Gm-Message-State: AJIora/cWqk3SqWBiqsx0T7tFLPrtMKSMJoIYVB5IaTPgyFS6GgBy7nC
        tMJtLWZ92oKBbpD6KaJctRuTdQF+4X0vng==
X-Google-Smtp-Source: AGRyM1sdY+l5WIl81j3Xnv93Ze5pjM9o9Isv7Vu4rbTqxiDHsz0xwhY+f4aXYFnk9NpJ3qXHlC1KYQ==
X-Received: by 2002:a05:620a:d86:b0:6a7:92ff:cfbc with SMTP id q6-20020a05620a0d8600b006a792ffcfbcmr3173430qkl.176.1656525848540;
        Wed, 29 Jun 2022 11:04:08 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d71-20020a379b4a000000b006a6a1e4aec2sm13521427qke.49.2022.06.29.11.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:04:08 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3137316bb69so155717267b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:04:07 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr5215357ywd.283.1656525847711; Wed, 29
 Jun 2022 11:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <202206300147.qdDDrtfw-lkp@intel.com>
In-Reply-To: <202206300147.qdDDrtfw-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Jun 2022 20:03:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXA5fNgGxoYfb=9GNxYtXyVn-ENH8u5gXkKcVufhnciXQ@mail.gmail.com>
Message-ID: <CAMuHMdXA5fNgGxoYfb=9GNxYtXyVn-ENH8u5gXkKcVufhnciXQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel Test Robot,

On Wed, Jun 29, 2022 at 7:57 PM kernel test robot <lkp@intel.com> wrote:
> First bad commit (maybe != root cause):

Definitely not introduced by my patch.
Looks like these functions were never used at all.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d9b2ba67917c18822c6a09af41c32fa161f1606b
> commit: ade896460e4a62f5e4a892a98d254937f6f5b64c drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
> date:   1 year, 8 months ago
> config: mips-randconfig-r016-20220629 (https://download.01.org/0day-ci/archive/20220630/202206300147.qdDDrtfw-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ade896460e4a62f5e4a892a98d254937f6f5b64c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ade896460e4a62f5e4a892a98d254937f6f5b64c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/kmb/ drivers/net/ethernet/mellanox/mlxsw/ drivers/scsi/ufs/ drivers/staging/ fs/xfs/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
>    set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi
>    ^
> >> drivers/gpu/drm/kmb/kmb_dsi.c:824:2: warning: unused function 'set_test_mode_src_osc_freq_target_hi_bits'
>    set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi
>    ^
>    fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
>    clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
>    clang version 15.0.0 (git://gitmirror/llvm_project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
>    Target: mipsel-unknown-linux
>    Thread model: posix
>    InstalledDir: /opt/cross/clang-a774ba7f60/bin
>    clang-15: note: diagnostic msg:
>    Makefile arch drivers fs include kernel mm nr_bisected scripts source usr
>
>
> vim +/set_test_mode_src_osc_freq_target_low_bits +812 drivers/gpu/drm/kmb/kmb_dsi.c
>
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  810
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  811  static inline void
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04 @812       set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_dsi,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  813                                                  u32 dphy_no,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  814                                                  u32 freq)
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  815  {
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  816       /* Typical rise/fall time=166, refer Table 1207 databook,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  817        * sr_osc_freq_target[7:0]
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  818        */
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  819       test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  820                      (freq & 0x7f));
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  821  }
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  822
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  823  static inline void
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04 @824       set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  825                                                 u32 dphy_no,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  826                                                 u32 freq)
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  827  {
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  828       u32 data;
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  829
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  830       /* Flag this as high nibble */
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  831       data = ((freq >> 6) & 0x1f) | (1 << 7);
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  832
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  833       /* Typical rise/fall time=166, refer Table 1207 databook,
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  834        * sr_osc_freq_target[11:7]
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  835        */
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  836       test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES, data);
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  837  }
> 98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  838
>
> :::::: The code at line 812 was first introduced by commit
> :::::: 98521f4d4b4cb265374a4b1e13b41287a1960243 drm/kmb: Mipi DSI part of the display driver
>
> :::::: TO: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
> :::::: CC: Sam Ravnborg <sam@ravnborg.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
