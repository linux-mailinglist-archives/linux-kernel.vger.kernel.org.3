Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32951EACA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 03:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiEHBek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiEHBeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 21:34:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F9387;
        Sat,  7 May 2022 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651973448; x=1683509448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sib+d6+cqt5Eiu+1X7rZe8uzqxg471SpMUYOVvHO9Ag=;
  b=Y+RdIXTcpXM8gqLfSruAchAOAxO7afxJUJneXJMBuS4Nbo5TLiksMVeK
   5mmCR1KX5zJoIyAvrMqMNkNCTxpXEaV3jMIcR8whhgxjNkQEvxriKiF6R
   wh1afvHsczcEjlxacNDBtZI+jX75QBtEiBhpkRIX9OSiNP+wkjPa5/Aqx
   sPCAWKxzXchm94wQ1TWRrSeyR42uHSh8Y6cEXsOBZS1Mw539enYmyYWos
   esZGP/CsfKUlrUESuW7Ogj/1Zi7dxzYCH/ny3hJwyDWo4fzS/S0H2jbEQ
   aMGPXBtiYtRVgWqHnGcbSaqXilxeHo2ImBqgbu4xafxwAsBiwAsMDn/nC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="266365251"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="266365251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 18:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="737522781"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 May 2022 18:30:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnVkw-000F83-Dj;
        Sun, 08 May 2022 01:30:42 +0000
Date:   Sun, 8 May 2022 09:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Marko <robimarko@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tdas@codeaurora.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH v2 04/11] clk: qcom: ipq8074: add PPE crypto clock
Message-ID: <202205080949.pqPzSf93-lkp@intel.com>
References: <20220507202948.397271-4-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507202948.397271-4-robimarko@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Marko/clk-qcom-ipq8074-fix-NSS-core-PLL-s/20220508-043100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220508/202205080949.pqPzSf93-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5e068bcac126049b1674076f826b97e3c63ae636
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Robert-Marko/clk-qcom-ipq8074-fix-NSS-core-PLL-s/20220508-043100
        git checkout 5e068bcac126049b1674076f826b97e3c63ae636
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/Robert-Marko/clk-qcom-ipq8074-fix-NSS-core-PLL-s/20220508-043100 HEAD 5022d9e2153ec876e88b3c4efa587e69642de0d0 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/clk/qcom/gcc-ipq8074.c:4665:10: error: 'GCC_CRYPTO_PPE_CLK' undeclared here (not in a function); did you mean 'GCC_CRYPTO_AHB_CLK'?
    4665 |         [GCC_CRYPTO_PPE_CLK] = &gcc_crypto_ppe_clk.clkr,
         |          ^~~~~~~~~~~~~~~~~~
         |          GCC_CRYPTO_AHB_CLK
>> drivers/clk/qcom/gcc-ipq8074.c:4665:10: error: array index in initializer not of integer type
   drivers/clk/qcom/gcc-ipq8074.c:4665:10: note: (near initialization for 'gcc_ipq8074_clks')
   drivers/clk/qcom/gcc-ipq8074.c:4665:32: warning: initialized field overwritten [-Woverride-init]
    4665 |         [GCC_CRYPTO_PPE_CLK] = &gcc_crypto_ppe_clk.clkr,
         |                                ^
   drivers/clk/qcom/gcc-ipq8074.c:4665:32: note: (near initialization for 'gcc_ipq8074_clks[225]')


vim +4665 drivers/clk/qcom/gcc-ipq8074.c

  4436	
  4437	static struct clk_regmap *gcc_ipq8074_clks[] = {
  4438		[GPLL0_MAIN] = &gpll0_main.clkr,
  4439		[GPLL0] = &gpll0.clkr,
  4440		[GPLL2_MAIN] = &gpll2_main.clkr,
  4441		[GPLL2] = &gpll2.clkr,
  4442		[GPLL4_MAIN] = &gpll4_main.clkr,
  4443		[GPLL4] = &gpll4.clkr,
  4444		[GPLL6_MAIN] = &gpll6_main.clkr,
  4445		[GPLL6] = &gpll6.clkr,
  4446		[UBI32_PLL_MAIN] = &ubi32_pll_main.clkr,
  4447		[UBI32_PLL] = &ubi32_pll.clkr,
  4448		[NSS_CRYPTO_PLL_MAIN] = &nss_crypto_pll_main.clkr,
  4449		[NSS_CRYPTO_PLL] = &nss_crypto_pll.clkr,
  4450		[PCNOC_BFDCD_CLK_SRC] = &pcnoc_bfdcd_clk_src.clkr,
  4451		[GCC_SLEEP_CLK_SRC] = &gcc_sleep_clk_src.clkr,
  4452		[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
  4453		[BLSP1_QUP1_SPI_APPS_CLK_SRC] = &blsp1_qup1_spi_apps_clk_src.clkr,
  4454		[BLSP1_QUP2_I2C_APPS_CLK_SRC] = &blsp1_qup2_i2c_apps_clk_src.clkr,
  4455		[BLSP1_QUP2_SPI_APPS_CLK_SRC] = &blsp1_qup2_spi_apps_clk_src.clkr,
  4456		[BLSP1_QUP3_I2C_APPS_CLK_SRC] = &blsp1_qup3_i2c_apps_clk_src.clkr,
  4457		[BLSP1_QUP3_SPI_APPS_CLK_SRC] = &blsp1_qup3_spi_apps_clk_src.clkr,
  4458		[BLSP1_QUP4_I2C_APPS_CLK_SRC] = &blsp1_qup4_i2c_apps_clk_src.clkr,
  4459		[BLSP1_QUP4_SPI_APPS_CLK_SRC] = &blsp1_qup4_spi_apps_clk_src.clkr,
  4460		[BLSP1_QUP5_I2C_APPS_CLK_SRC] = &blsp1_qup5_i2c_apps_clk_src.clkr,
  4461		[BLSP1_QUP5_SPI_APPS_CLK_SRC] = &blsp1_qup5_spi_apps_clk_src.clkr,
  4462		[BLSP1_QUP6_I2C_APPS_CLK_SRC] = &blsp1_qup6_i2c_apps_clk_src.clkr,
  4463		[BLSP1_QUP6_SPI_APPS_CLK_SRC] = &blsp1_qup6_spi_apps_clk_src.clkr,
  4464		[BLSP1_UART1_APPS_CLK_SRC] = &blsp1_uart1_apps_clk_src.clkr,
  4465		[BLSP1_UART2_APPS_CLK_SRC] = &blsp1_uart2_apps_clk_src.clkr,
  4466		[BLSP1_UART3_APPS_CLK_SRC] = &blsp1_uart3_apps_clk_src.clkr,
  4467		[BLSP1_UART4_APPS_CLK_SRC] = &blsp1_uart4_apps_clk_src.clkr,
  4468		[BLSP1_UART5_APPS_CLK_SRC] = &blsp1_uart5_apps_clk_src.clkr,
  4469		[BLSP1_UART6_APPS_CLK_SRC] = &blsp1_uart6_apps_clk_src.clkr,
  4470		[PCIE0_AXI_CLK_SRC] = &pcie0_axi_clk_src.clkr,
  4471		[PCIE0_AUX_CLK_SRC] = &pcie0_aux_clk_src.clkr,
  4472		[PCIE0_PIPE_CLK_SRC] = &pcie0_pipe_clk_src.clkr,
  4473		[PCIE1_AXI_CLK_SRC] = &pcie1_axi_clk_src.clkr,
  4474		[PCIE1_AUX_CLK_SRC] = &pcie1_aux_clk_src.clkr,
  4475		[PCIE1_PIPE_CLK_SRC] = &pcie1_pipe_clk_src.clkr,
  4476		[SDCC1_APPS_CLK_SRC] = &sdcc1_apps_clk_src.clkr,
  4477		[SDCC1_ICE_CORE_CLK_SRC] = &sdcc1_ice_core_clk_src.clkr,
  4478		[SDCC2_APPS_CLK_SRC] = &sdcc2_apps_clk_src.clkr,
  4479		[USB0_MASTER_CLK_SRC] = &usb0_master_clk_src.clkr,
  4480		[USB0_AUX_CLK_SRC] = &usb0_aux_clk_src.clkr,
  4481		[USB0_MOCK_UTMI_CLK_SRC] = &usb0_mock_utmi_clk_src.clkr,
  4482		[USB0_PIPE_CLK_SRC] = &usb0_pipe_clk_src.clkr,
  4483		[USB1_MASTER_CLK_SRC] = &usb1_master_clk_src.clkr,
  4484		[USB1_AUX_CLK_SRC] = &usb1_aux_clk_src.clkr,
  4485		[USB1_MOCK_UTMI_CLK_SRC] = &usb1_mock_utmi_clk_src.clkr,
  4486		[USB1_PIPE_CLK_SRC] = &usb1_pipe_clk_src.clkr,
  4487		[GCC_XO_CLK_SRC] = &gcc_xo_clk_src.clkr,
  4488		[SYSTEM_NOC_BFDCD_CLK_SRC] = &system_noc_bfdcd_clk_src.clkr,
  4489		[NSS_CE_CLK_SRC] = &nss_ce_clk_src.clkr,
  4490		[NSS_NOC_BFDCD_CLK_SRC] = &nss_noc_bfdcd_clk_src.clkr,
  4491		[NSS_CRYPTO_CLK_SRC] = &nss_crypto_clk_src.clkr,
  4492		[NSS_UBI0_CLK_SRC] = &nss_ubi0_clk_src.clkr,
  4493		[NSS_UBI0_DIV_CLK_SRC] = &nss_ubi0_div_clk_src.clkr,
  4494		[NSS_UBI1_CLK_SRC] = &nss_ubi1_clk_src.clkr,
  4495		[NSS_UBI1_DIV_CLK_SRC] = &nss_ubi1_div_clk_src.clkr,
  4496		[UBI_MPT_CLK_SRC] = &ubi_mpt_clk_src.clkr,
  4497		[NSS_IMEM_CLK_SRC] = &nss_imem_clk_src.clkr,
  4498		[NSS_PPE_CLK_SRC] = &nss_ppe_clk_src.clkr,
  4499		[NSS_PORT1_RX_CLK_SRC] = &nss_port1_rx_clk_src.clkr,
  4500		[NSS_PORT1_RX_DIV_CLK_SRC] = &nss_port1_rx_div_clk_src.clkr,
  4501		[NSS_PORT1_TX_CLK_SRC] = &nss_port1_tx_clk_src.clkr,
  4502		[NSS_PORT1_TX_DIV_CLK_SRC] = &nss_port1_tx_div_clk_src.clkr,
  4503		[NSS_PORT2_RX_CLK_SRC] = &nss_port2_rx_clk_src.clkr,
  4504		[NSS_PORT2_RX_DIV_CLK_SRC] = &nss_port2_rx_div_clk_src.clkr,
  4505		[NSS_PORT2_TX_CLK_SRC] = &nss_port2_tx_clk_src.clkr,
  4506		[NSS_PORT2_TX_DIV_CLK_SRC] = &nss_port2_tx_div_clk_src.clkr,
  4507		[NSS_PORT3_RX_CLK_SRC] = &nss_port3_rx_clk_src.clkr,
  4508		[NSS_PORT3_RX_DIV_CLK_SRC] = &nss_port3_rx_div_clk_src.clkr,
  4509		[NSS_PORT3_TX_CLK_SRC] = &nss_port3_tx_clk_src.clkr,
  4510		[NSS_PORT3_TX_DIV_CLK_SRC] = &nss_port3_tx_div_clk_src.clkr,
  4511		[NSS_PORT4_RX_CLK_SRC] = &nss_port4_rx_clk_src.clkr,
  4512		[NSS_PORT4_RX_DIV_CLK_SRC] = &nss_port4_rx_div_clk_src.clkr,
  4513		[NSS_PORT4_TX_CLK_SRC] = &nss_port4_tx_clk_src.clkr,
  4514		[NSS_PORT4_TX_DIV_CLK_SRC] = &nss_port4_tx_div_clk_src.clkr,
  4515		[NSS_PORT5_RX_CLK_SRC] = &nss_port5_rx_clk_src.clkr,
  4516		[NSS_PORT5_RX_DIV_CLK_SRC] = &nss_port5_rx_div_clk_src.clkr,
  4517		[NSS_PORT5_TX_CLK_SRC] = &nss_port5_tx_clk_src.clkr,
  4518		[NSS_PORT5_TX_DIV_CLK_SRC] = &nss_port5_tx_div_clk_src.clkr,
  4519		[NSS_PORT6_RX_CLK_SRC] = &nss_port6_rx_clk_src.clkr,
  4520		[NSS_PORT6_RX_DIV_CLK_SRC] = &nss_port6_rx_div_clk_src.clkr,
  4521		[NSS_PORT6_TX_CLK_SRC] = &nss_port6_tx_clk_src.clkr,
  4522		[NSS_PORT6_TX_DIV_CLK_SRC] = &nss_port6_tx_div_clk_src.clkr,
  4523		[CRYPTO_CLK_SRC] = &crypto_clk_src.clkr,
  4524		[GP1_CLK_SRC] = &gp1_clk_src.clkr,
  4525		[GP2_CLK_SRC] = &gp2_clk_src.clkr,
  4526		[GP3_CLK_SRC] = &gp3_clk_src.clkr,
  4527		[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
  4528		[GCC_BLSP1_QUP1_I2C_APPS_CLK] = &gcc_blsp1_qup1_i2c_apps_clk.clkr,
  4529		[GCC_BLSP1_QUP1_SPI_APPS_CLK] = &gcc_blsp1_qup1_spi_apps_clk.clkr,
  4530		[GCC_BLSP1_QUP2_I2C_APPS_CLK] = &gcc_blsp1_qup2_i2c_apps_clk.clkr,
  4531		[GCC_BLSP1_QUP2_SPI_APPS_CLK] = &gcc_blsp1_qup2_spi_apps_clk.clkr,
  4532		[GCC_BLSP1_QUP3_I2C_APPS_CLK] = &gcc_blsp1_qup3_i2c_apps_clk.clkr,
  4533		[GCC_BLSP1_QUP3_SPI_APPS_CLK] = &gcc_blsp1_qup3_spi_apps_clk.clkr,
  4534		[GCC_BLSP1_QUP4_I2C_APPS_CLK] = &gcc_blsp1_qup4_i2c_apps_clk.clkr,
  4535		[GCC_BLSP1_QUP4_SPI_APPS_CLK] = &gcc_blsp1_qup4_spi_apps_clk.clkr,
  4536		[GCC_BLSP1_QUP5_I2C_APPS_CLK] = &gcc_blsp1_qup5_i2c_apps_clk.clkr,
  4537		[GCC_BLSP1_QUP5_SPI_APPS_CLK] = &gcc_blsp1_qup5_spi_apps_clk.clkr,
  4538		[GCC_BLSP1_QUP6_I2C_APPS_CLK] = &gcc_blsp1_qup6_i2c_apps_clk.clkr,
  4539		[GCC_BLSP1_QUP6_SPI_APPS_CLK] = &gcc_blsp1_qup6_spi_apps_clk.clkr,
  4540		[GCC_BLSP1_UART1_APPS_CLK] = &gcc_blsp1_uart1_apps_clk.clkr,
  4541		[GCC_BLSP1_UART2_APPS_CLK] = &gcc_blsp1_uart2_apps_clk.clkr,
  4542		[GCC_BLSP1_UART3_APPS_CLK] = &gcc_blsp1_uart3_apps_clk.clkr,
  4543		[GCC_BLSP1_UART4_APPS_CLK] = &gcc_blsp1_uart4_apps_clk.clkr,
  4544		[GCC_BLSP1_UART5_APPS_CLK] = &gcc_blsp1_uart5_apps_clk.clkr,
  4545		[GCC_BLSP1_UART6_APPS_CLK] = &gcc_blsp1_uart6_apps_clk.clkr,
  4546		[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
  4547		[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
  4548		[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
  4549		[GCC_PCIE0_AHB_CLK] = &gcc_pcie0_ahb_clk.clkr,
  4550		[GCC_PCIE0_AUX_CLK] = &gcc_pcie0_aux_clk.clkr,
  4551		[GCC_PCIE0_AXI_M_CLK] = &gcc_pcie0_axi_m_clk.clkr,
  4552		[GCC_PCIE0_AXI_S_CLK] = &gcc_pcie0_axi_s_clk.clkr,
  4553		[GCC_PCIE0_PIPE_CLK] = &gcc_pcie0_pipe_clk.clkr,
  4554		[GCC_SYS_NOC_PCIE0_AXI_CLK] = &gcc_sys_noc_pcie0_axi_clk.clkr,
  4555		[GCC_PCIE1_AHB_CLK] = &gcc_pcie1_ahb_clk.clkr,
  4556		[GCC_PCIE1_AUX_CLK] = &gcc_pcie1_aux_clk.clkr,
  4557		[GCC_PCIE1_AXI_M_CLK] = &gcc_pcie1_axi_m_clk.clkr,
  4558		[GCC_PCIE1_AXI_S_CLK] = &gcc_pcie1_axi_s_clk.clkr,
  4559		[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
  4560		[GCC_SYS_NOC_PCIE1_AXI_CLK] = &gcc_sys_noc_pcie1_axi_clk.clkr,
  4561		[GCC_USB0_AUX_CLK] = &gcc_usb0_aux_clk.clkr,
  4562		[GCC_SYS_NOC_USB0_AXI_CLK] = &gcc_sys_noc_usb0_axi_clk.clkr,
  4563		[GCC_USB0_MASTER_CLK] = &gcc_usb0_master_clk.clkr,
  4564		[GCC_USB0_MOCK_UTMI_CLK] = &gcc_usb0_mock_utmi_clk.clkr,
  4565		[GCC_USB0_PHY_CFG_AHB_CLK] = &gcc_usb0_phy_cfg_ahb_clk.clkr,
  4566		[GCC_USB0_PIPE_CLK] = &gcc_usb0_pipe_clk.clkr,
  4567		[GCC_USB0_SLEEP_CLK] = &gcc_usb0_sleep_clk.clkr,
  4568		[GCC_USB1_AUX_CLK] = &gcc_usb1_aux_clk.clkr,
  4569		[GCC_SYS_NOC_USB1_AXI_CLK] = &gcc_sys_noc_usb1_axi_clk.clkr,
  4570		[GCC_USB1_MASTER_CLK] = &gcc_usb1_master_clk.clkr,
  4571		[GCC_USB1_MOCK_UTMI_CLK] = &gcc_usb1_mock_utmi_clk.clkr,
  4572		[GCC_USB1_PHY_CFG_AHB_CLK] = &gcc_usb1_phy_cfg_ahb_clk.clkr,
  4573		[GCC_USB1_PIPE_CLK] = &gcc_usb1_pipe_clk.clkr,
  4574		[GCC_USB1_SLEEP_CLK] = &gcc_usb1_sleep_clk.clkr,
  4575		[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
  4576		[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
  4577		[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
  4578		[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
  4579		[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
  4580		[GCC_MEM_NOC_NSS_AXI_CLK] = &gcc_mem_noc_nss_axi_clk.clkr,
  4581		[GCC_NSS_CE_APB_CLK] = &gcc_nss_ce_apb_clk.clkr,
  4582		[GCC_NSS_CE_AXI_CLK] = &gcc_nss_ce_axi_clk.clkr,
  4583		[GCC_NSS_CFG_CLK] = &gcc_nss_cfg_clk.clkr,
  4584		[GCC_NSS_CRYPTO_CLK] = &gcc_nss_crypto_clk.clkr,
  4585		[GCC_NSS_CSR_CLK] = &gcc_nss_csr_clk.clkr,
  4586		[GCC_NSS_EDMA_CFG_CLK] = &gcc_nss_edma_cfg_clk.clkr,
  4587		[GCC_NSS_EDMA_CLK] = &gcc_nss_edma_clk.clkr,
  4588		[GCC_NSS_IMEM_CLK] = &gcc_nss_imem_clk.clkr,
  4589		[GCC_NSS_NOC_CLK] = &gcc_nss_noc_clk.clkr,
  4590		[GCC_NSS_PPE_BTQ_CLK] = &gcc_nss_ppe_btq_clk.clkr,
  4591		[GCC_NSS_PPE_CFG_CLK] = &gcc_nss_ppe_cfg_clk.clkr,
  4592		[GCC_NSS_PPE_CLK] = &gcc_nss_ppe_clk.clkr,
  4593		[GCC_NSS_PPE_IPE_CLK] = &gcc_nss_ppe_ipe_clk.clkr,
  4594		[GCC_NSS_PTP_REF_CLK] = &gcc_nss_ptp_ref_clk.clkr,
  4595		[GCC_NSSNOC_CE_APB_CLK] = &gcc_nssnoc_ce_apb_clk.clkr,
  4596		[GCC_NSSNOC_CE_AXI_CLK] = &gcc_nssnoc_ce_axi_clk.clkr,
  4597		[GCC_NSSNOC_CRYPTO_CLK] = &gcc_nssnoc_crypto_clk.clkr,
  4598		[GCC_NSSNOC_PPE_CFG_CLK] = &gcc_nssnoc_ppe_cfg_clk.clkr,
  4599		[GCC_NSSNOC_PPE_CLK] = &gcc_nssnoc_ppe_clk.clkr,
  4600		[GCC_NSSNOC_QOSGEN_REF_CLK] = &gcc_nssnoc_qosgen_ref_clk.clkr,
  4601		[GCC_NSSNOC_SNOC_CLK] = &gcc_nssnoc_snoc_clk.clkr,
  4602		[GCC_NSSNOC_TIMEOUT_REF_CLK] = &gcc_nssnoc_timeout_ref_clk.clkr,
  4603		[GCC_NSSNOC_UBI0_AHB_CLK] = &gcc_nssnoc_ubi0_ahb_clk.clkr,
  4604		[GCC_NSSNOC_UBI1_AHB_CLK] = &gcc_nssnoc_ubi1_ahb_clk.clkr,
  4605		[GCC_UBI0_AHB_CLK] = &gcc_ubi0_ahb_clk.clkr,
  4606		[GCC_UBI0_AXI_CLK] = &gcc_ubi0_axi_clk.clkr,
  4607		[GCC_UBI0_NC_AXI_CLK] = &gcc_ubi0_nc_axi_clk.clkr,
  4608		[GCC_UBI0_CORE_CLK] = &gcc_ubi0_core_clk.clkr,
  4609		[GCC_UBI0_MPT_CLK] = &gcc_ubi0_mpt_clk.clkr,
  4610		[GCC_UBI1_AHB_CLK] = &gcc_ubi1_ahb_clk.clkr,
  4611		[GCC_UBI1_AXI_CLK] = &gcc_ubi1_axi_clk.clkr,
  4612		[GCC_UBI1_NC_AXI_CLK] = &gcc_ubi1_nc_axi_clk.clkr,
  4613		[GCC_UBI1_CORE_CLK] = &gcc_ubi1_core_clk.clkr,
  4614		[GCC_UBI1_MPT_CLK] = &gcc_ubi1_mpt_clk.clkr,
  4615		[GCC_CMN_12GPLL_AHB_CLK] = &gcc_cmn_12gpll_ahb_clk.clkr,
  4616		[GCC_CMN_12GPLL_SYS_CLK] = &gcc_cmn_12gpll_sys_clk.clkr,
  4617		[GCC_MDIO_AHB_CLK] = &gcc_mdio_ahb_clk.clkr,
  4618		[GCC_UNIPHY0_AHB_CLK] = &gcc_uniphy0_ahb_clk.clkr,
  4619		[GCC_UNIPHY0_SYS_CLK] = &gcc_uniphy0_sys_clk.clkr,
  4620		[GCC_UNIPHY1_AHB_CLK] = &gcc_uniphy1_ahb_clk.clkr,
  4621		[GCC_UNIPHY1_SYS_CLK] = &gcc_uniphy1_sys_clk.clkr,
  4622		[GCC_UNIPHY2_AHB_CLK] = &gcc_uniphy2_ahb_clk.clkr,
  4623		[GCC_UNIPHY2_SYS_CLK] = &gcc_uniphy2_sys_clk.clkr,
  4624		[GCC_NSS_PORT1_RX_CLK] = &gcc_nss_port1_rx_clk.clkr,
  4625		[GCC_NSS_PORT1_TX_CLK] = &gcc_nss_port1_tx_clk.clkr,
  4626		[GCC_NSS_PORT2_RX_CLK] = &gcc_nss_port2_rx_clk.clkr,
  4627		[GCC_NSS_PORT2_TX_CLK] = &gcc_nss_port2_tx_clk.clkr,
  4628		[GCC_NSS_PORT3_RX_CLK] = &gcc_nss_port3_rx_clk.clkr,
  4629		[GCC_NSS_PORT3_TX_CLK] = &gcc_nss_port3_tx_clk.clkr,
  4630		[GCC_NSS_PORT4_RX_CLK] = &gcc_nss_port4_rx_clk.clkr,
  4631		[GCC_NSS_PORT4_TX_CLK] = &gcc_nss_port4_tx_clk.clkr,
  4632		[GCC_NSS_PORT5_RX_CLK] = &gcc_nss_port5_rx_clk.clkr,
  4633		[GCC_NSS_PORT5_TX_CLK] = &gcc_nss_port5_tx_clk.clkr,
  4634		[GCC_NSS_PORT6_RX_CLK] = &gcc_nss_port6_rx_clk.clkr,
  4635		[GCC_NSS_PORT6_TX_CLK] = &gcc_nss_port6_tx_clk.clkr,
  4636		[GCC_PORT1_MAC_CLK] = &gcc_port1_mac_clk.clkr,
  4637		[GCC_PORT2_MAC_CLK] = &gcc_port2_mac_clk.clkr,
  4638		[GCC_PORT3_MAC_CLK] = &gcc_port3_mac_clk.clkr,
  4639		[GCC_PORT4_MAC_CLK] = &gcc_port4_mac_clk.clkr,
  4640		[GCC_PORT5_MAC_CLK] = &gcc_port5_mac_clk.clkr,
  4641		[GCC_PORT6_MAC_CLK] = &gcc_port6_mac_clk.clkr,
  4642		[GCC_UNIPHY0_PORT1_RX_CLK] = &gcc_uniphy0_port1_rx_clk.clkr,
  4643		[GCC_UNIPHY0_PORT1_TX_CLK] = &gcc_uniphy0_port1_tx_clk.clkr,
  4644		[GCC_UNIPHY0_PORT2_RX_CLK] = &gcc_uniphy0_port2_rx_clk.clkr,
  4645		[GCC_UNIPHY0_PORT2_TX_CLK] = &gcc_uniphy0_port2_tx_clk.clkr,
  4646		[GCC_UNIPHY0_PORT3_RX_CLK] = &gcc_uniphy0_port3_rx_clk.clkr,
  4647		[GCC_UNIPHY0_PORT3_TX_CLK] = &gcc_uniphy0_port3_tx_clk.clkr,
  4648		[GCC_UNIPHY0_PORT4_RX_CLK] = &gcc_uniphy0_port4_rx_clk.clkr,
  4649		[GCC_UNIPHY0_PORT4_TX_CLK] = &gcc_uniphy0_port4_tx_clk.clkr,
  4650		[GCC_UNIPHY0_PORT5_RX_CLK] = &gcc_uniphy0_port5_rx_clk.clkr,
  4651		[GCC_UNIPHY0_PORT5_TX_CLK] = &gcc_uniphy0_port5_tx_clk.clkr,
  4652		[GCC_UNIPHY1_PORT5_RX_CLK] = &gcc_uniphy1_port5_rx_clk.clkr,
  4653		[GCC_UNIPHY1_PORT5_TX_CLK] = &gcc_uniphy1_port5_tx_clk.clkr,
  4654		[GCC_UNIPHY2_PORT6_RX_CLK] = &gcc_uniphy2_port6_rx_clk.clkr,
  4655		[GCC_UNIPHY2_PORT6_TX_CLK] = &gcc_uniphy2_port6_tx_clk.clkr,
  4656		[GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
  4657		[GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
  4658		[GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
  4659		[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
  4660		[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
  4661		[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
  4662		[GCC_PCIE0_RCHNG_CLK_SRC] = &pcie0_rchng_clk_src.clkr,
  4663		[GCC_PCIE0_RCHNG_CLK] = &gcc_pcie0_rchng_clk.clkr,
  4664		[GCC_PCIE0_AXI_S_BRIDGE_CLK] = &gcc_pcie0_axi_s_bridge_clk.clkr,
> 4665		[GCC_CRYPTO_PPE_CLK] = &gcc_crypto_ppe_clk.clkr,
  4666	};
  4667	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
