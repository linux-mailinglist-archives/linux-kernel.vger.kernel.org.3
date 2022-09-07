Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569AF5B0648
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiIGOTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIGOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:19:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB2B18;
        Wed,  7 Sep 2022 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662560364; x=1694096364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mb8iuybAB+Ow3ntbR/Nt2puuaVdPIstTH2e0zbuav8E=;
  b=CBNLQ7+wj95L9RjUX/21TY4bobgtI1XIozjPhuAmRTc4UWkoKh94d7OM
   6Vq9S4kyOAlQh5wh7clX4fgOOMy63h6/NUnr9WcQ4G4G1H56vQNDIogEk
   XbVUZSmyrFckd/ZpAAEZs9dRoOksp/Bh5JtW8XcjAQl8FI/uWi45CqDKu
   PFWaPrGPaEWnMMqRY0i6CVyOu5HVHSM9P+EyCy7CyJpnynOXaDN3Paj/c
   P4J1gVIXpHjaDG/CpjLC9xqg6ruoH4pqPgha6OvbQJFiZp56ZOICzn4VA
   mfLzVu+AUhCOriAK70n98L9FXtwfRGhNsDN7Z7x7/+L7Dnd3TbI/XJVYG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="383178126"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="383178126"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="682822800"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2022 07:19:18 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVvte-0006eH-0A;
        Wed, 07 Sep 2022 14:19:18 +0000
Date:   Wed, 7 Sep 2022 22:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Acayan <mailingradian@gmail.com>,
        bjorn.andersson@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sdm845: add sdm670 global clock data
Message-ID: <202209072255.CLVCZ5HY-lkp@intel.com>
References: <20220907025035.15609-4-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907025035.15609-4-mailingradian@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.0-rc4]
[cannot apply to next-20220906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Acayan/SDM670-Global-Clocks/20220907-105158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: riscv-randconfig-r031-20220906 (https://download.01.org/0day-ci/archive/20220907/202209072255.CLVCZ5HY-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/bfed597346daad9f2f2a30c553c855fbefc1fe7e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Acayan/SDM670-Global-Clocks/20220907-105158
        git checkout bfed597346daad9f2f2a30c553c855fbefc1fe7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/qcom/ net/mptcp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/qcom/gcc-sdm845.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/clk/qcom/gcc-sdm845.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/clk/qcom/gcc-sdm845.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
   drivers/clk/qcom/gcc-sdm845.c:3619:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk_src.clkr,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/qcom/gcc-sdm845.c:3618:29: note: previous initialization is here
           [GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/qcom/gcc-sdm845.c:268:30: warning: unused variable 'ftbl_gcc_sdm670_cpuss_rbcpr_clk_src' [-Wunused-const-variable]
   static const struct freq_tbl ftbl_gcc_sdm670_cpuss_rbcpr_clk_src[] = {
                                ^
   9 warnings generated.


vim +/ftbl_gcc_sdm670_cpuss_rbcpr_clk_src +268 drivers/clk/qcom/gcc-sdm845.c

   267	
 > 268	static const struct freq_tbl ftbl_gcc_sdm670_cpuss_rbcpr_clk_src[] = {
   269		F(19200000, P_BI_TCXO, 1, 0, 0),
   270		F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
   271		{ }
   272	};
   273	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
