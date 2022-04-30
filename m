Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523C7515F5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiD3RAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiD3RAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:00:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB1E0CF;
        Sat, 30 Apr 2022 09:57:20 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nkqP3-0002Do-Ak; Sat, 30 Apr 2022 18:57:05 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     kernel test robot <lkp@intel.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device tree
Date:   Sat, 30 Apr 2022 18:57:04 +0200
Message-ID: <7373923.EvYhyI6sBW@diego>
In-Reply-To: <CAMdYzYoBgeTthb8-uycis+BPDmSC5OGVHz2doKYLeh3OY1m_vQ@mail.gmail.com>
References: <20220429115252.2360496-6-pgwipeout@gmail.com> <202204300850.X97CRcO6-lkp@intel.com> <CAMdYzYoBgeTthb8-uycis+BPDmSC5OGVHz2doKYLeh3OY1m_vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 30. April 2022, 16:46:31 CEST schrieb Peter Geis:
> On Fri, Apr 29, 2022 at 8:17 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Peter,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on robh/for-next]
> > [also build test ERROR on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next shawnguo/for-next soc/for-next v5.18-rc4]
> > [cannot apply to rockchip/for-next xilinx-xlnx/master keystone/next next-20220429]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> 
> The three new device trees are dependent on my usb series which was
> accepted through Heiko's tree.
> I can drop the xhci dependency, but this will just happen again adding
> it back in if it's done in this RC series.

Of course dropping that part is not necessary :-)
I.e. the dependency is in my tree and this stuff will go on top.

I'm just not sure if I should give Krzysztof more time for patch1.
The binding of course looks great now already, I guess I'll let the
Quartz-B sit some days more.


Heiko

> 
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > config: arm64-randconfig-r021-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300850.X97CRcO6-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://github.com/intel-lab-lkp/linux/commit/d933bfeea016da20a99bce012bbf071f9d86e2bf
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Peter-Geis/Add-support-for-several-new-rk3566-SBCs/20220429-195433
> >         git checkout d933bfeea016da20a99bce012bbf071f9d86e2bf
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> Error: arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts:601.1-16 Label or path usb_host0_xhci not found
> > >> Error: arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts:605.1-16 Label or path usb_host1_xhci not found
> >    FATAL ERROR: Syntax error parsing input tree
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> 




