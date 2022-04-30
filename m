Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B267515E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382848AbiD3OuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiD3OuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:50:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C1BF45;
        Sat, 30 Apr 2022 07:46:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y76so19231707ybe.1;
        Sat, 30 Apr 2022 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDYTvI6znr01rMdYpkDq6Ypp0H3WErEbHLUo/gJSeUU=;
        b=gizhXjlc4dddGAyXHCWUzeJ2Gi8/5XiA/tllzFIGgLQLafptQfYoOodtweAYj0rvze
         UGRH4LGXjIdFMmtdfuO0xctNhDVa6ekPvB+sXgVvL1LQ1vHncJXqKSWZa4hxPWa7n4wh
         sfqBSFbOQQTcFmeRztpT42/kcsStIAFO/NTPd2e5zRjDTTqdY+gH2Kb4M9P1Mxl5uEen
         gl2fooV8ozixScBRzt4R7vrP8B2L21cfyCLKq0fDAROsZhYVJ+oMMKi++ZiR8tCm/LPO
         4qjxN5RCUri22u42lcBPBTTwyLuj5ReqZzMaCONCqDXaGz6xNxfBLmiWT3pABclT3ITy
         eiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDYTvI6znr01rMdYpkDq6Ypp0H3WErEbHLUo/gJSeUU=;
        b=HqxgtlQaioRFZYW47VVxxNVzrPtiq7BirvcGktpnb5OJTD9DOnOW6c1HB5zIWiSQmS
         6F2a0D+APhkBMyATgjsldCQ3CFPonyIC9W+X3hFxJW1F2yIkLzeSGkkjacFVORTGxB2P
         b9Nn7UgktDg/qKAmIlf1zJYPRuxZeJMSO5rTawNKPcWSMzKps+rDY2jHrkHZsBTAoAqZ
         1ZAypzOprUy8fSRjyXIMwRWeJGlC1FL9uxyFfurU5nzfB5toJMBYG3gtVdXOGYlJkHH5
         NLOvPNxdIwzDp8z/TcwofSCdjTiUB/fYS+y/X+fV+wcvQL6BvBfFwDiB4o9sphbM+/po
         nIcA==
X-Gm-Message-State: AOAM5301sWn1OONrRf85cn8k0QXtEibUsQms/DRQadHJyLf/s/Tdb+t8
        hMLe4eieXpPuijA1oQZnuE5QXMdSBgzkJqx75wonlng12kg=
X-Google-Smtp-Source: ABdhPJwjjBnxPwFO1b856aj8QWPk0F9kl/t1qCkPl+APt841wQfOimBoRG8A9Q9/kWZxIcl4i5IH+KuoR7LSGuIZ3lA=
X-Received: by 2002:a05:6902:cf:b0:641:32bb:53fc with SMTP id
 i15-20020a05690200cf00b0064132bb53fcmr4141174ybs.232.1651330002683; Sat, 30
 Apr 2022 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220429115252.2360496-6-pgwipeout@gmail.com> <202204300850.X97CRcO6-lkp@intel.com>
In-Reply-To: <202204300850.X97CRcO6-lkp@intel.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 30 Apr 2022 10:46:31 -0400
Message-ID: <CAMdYzYoBgeTthb8-uycis+BPDmSC5OGVHz2doKYLeh3OY1m_vQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device tree
To:     kernel test robot <lkp@intel.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 8:17 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Peter,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next shawnguo/for-next soc/for-next v5.18-rc4]
> [cannot apply to rockchip/for-next xilinx-xlnx/master keystone/next next-20220429]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

The three new device trees are dependent on my usb series which was
accepted through Heiko's tree.
I can drop the xhci dependency, but this will just happen again adding
it back in if it's done in this RC series.

>
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-randconfig-r021-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300850.X97CRcO6-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/d933bfeea016da20a99bce012bbf071f9d86e2bf
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
>         git checkout d933bfeea016da20a99bce012bbf071f9d86e2bf
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> Error: arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts:601.1-16 Label or path usb_host0_xhci not found
> >> Error: arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts:605.1-16 Label or path usb_host1_xhci not found
>    FATAL ERROR: Syntax error parsing input tree
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
