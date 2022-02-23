Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807304C131D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbiBWMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiBWMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:48:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886A4A3EF;
        Wed, 23 Feb 2022 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645620455; x=1677156455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqju8IXdyV7NCCHhUut3vmqr4DdqWtFCCvY5rooimh0=;
  b=fpCAjUPoeG1ddRqNywzQBvLQ9R0XGls9ZJ/tqm6sFLF6yVRj/s8/FyZO
   UDfzAvwasJs/Wllyf2I0Lzi/mX9o9hIyl9A/iGm5IUv/Q9CzymC5VKwOk
   bWeu9MsujROwepMjcVxa7JqwmeWLbhODPtXb9rD4FOs4Sf4p2LvFWBp1k
   SPvTArN0es4hRgxUVm29QgnVb1hKaLUpSTP1FNHleFPxQWgfMwxRioijm
   B1Y6t0+xssWgEnKLzoWciCKP95wodIonOTynZvQp50MVkGcrpXfNhLNhf
   JlB27lMVeowMQDHa1J7ceVGF9GPgwOi3x3MiLqrigeD1HA7RRM2y9xmHU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231927545"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="231927545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:47:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="639294376"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2022 04:47:30 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMr3J-0001Oi-VB; Wed, 23 Feb 2022 12:47:29 +0000
Date:   Wed, 23 Feb 2022 20:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: Re: [PATCH v2 5/5] spi: tegra210-quad: combined sequence mode
Message-ID: <202202231856.T049n8gm-lkp@intel.com>
References: <20220222175611.58051-6-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222175611.58051-6-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Krishna-Yarlagadda/Tegra-QUAD-SPI-combined-sequence-mode/20220223-015906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: riscv-randconfig-r042-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231856.T049n8gm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/3b852b330b0b8332a67fd7b183ae798031c7a207
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Krishna-Yarlagadda/Tegra-QUAD-SPI-combined-sequence-mode/20220223-015906
        git checkout 3b852b330b0b8332a67fd7b183ae798031c7a207
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-tegra210-quad.c:1044:20: warning: variable 'len' set but not used [-Wunused-but-set-variable]
           u8 cmd_value = 0, len = 0, val = 0;
                             ^
>> drivers/spi/spi-tegra210-quad.c:1140:3: warning: variable 'ret' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
                   default:
                   ^~~~~~~
   drivers/spi/spi-tegra210-quad.c:1148:16: note: uninitialized use occurs here
           msg->status = ret;
                         ^~~
>> drivers/spi/spi-tegra210-quad.c:1051:2: warning: variable 'ret' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
           list_for_each_entry(xfer, &msg->transfers, transfer_list) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:639:7: note: expanded from macro 'list_for_each_entry'
                !list_entry_is_head(pos, head, member);                    \
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-tegra210-quad.c:1148:16: note: uninitialized use occurs here
           msg->status = ret;
                         ^~~
   drivers/spi/spi-tegra210-quad.c:1051:2: note: remove the condition if it is always true
           list_for_each_entry(xfer, &msg->transfers, transfer_list) {
           ^
   include/linux/list.h:639:7: note: expanded from macro 'list_for_each_entry'
                !list_entry_is_head(pos, head, member);                    \
                ^
   drivers/spi/spi-tegra210-quad.c:1041:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
>> drivers/spi/spi-tegra210-quad.c:1140:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   drivers/spi/spi-tegra210-quad.c:1140:3: note: insert '__attribute__((fallthrough));' to silence this warning
                   default:
                   ^
                   __attribute__((fallthrough)); 
   drivers/spi/spi-tegra210-quad.c:1140:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   4 warnings generated.


vim +/len +1044 drivers/spi/spi-tegra210-quad.c

  1032	
  1033	static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
  1034						struct spi_message *msg)
  1035	{
  1036		bool is_first_msg = true;
  1037		struct spi_transfer *xfer;
  1038		struct spi_device *spi = msg->spi;
  1039		u8 transfer_phase = 0;
  1040		u32 cmd1 = 0, dma_ctl = 0;
> 1041		int ret;
  1042		u32 address_value = 0;
  1043		u32 cmd_config = 0, addr_config = 0;
> 1044		u8 cmd_value = 0, len = 0, val = 0;
  1045	
  1046		/* Enable Combined sequence mode */
  1047		val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
  1048		val |= QSPI_CMB_SEQ_EN;
  1049		tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
  1050		/* Process individual transfer list */
> 1051		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
  1052			switch (transfer_phase) {
  1053			case CMD_TRANSFER:
  1054				/* X1 SDR mode */
  1055				cmd_config = tegra_qspi_cmd_config(false, 0,
  1056								   xfer->len);
  1057				cmd_value = *((const u8 *)(xfer->tx_buf));
  1058				break;
  1059			case ADDR_TRANSFER:
  1060				len = xfer->len;
  1061				/* X1 SDR mode */
  1062				addr_config = tegra_qspi_addr_config(false, 0,
  1063								     xfer->len);
  1064				address_value = *((const u32 *)(xfer->tx_buf));
  1065				break;
  1066			case DATA_TRANSFER:
  1067				/* Program Command, Address value in register */
  1068				tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
  1069				tegra_qspi_writel(tqspi, address_value,
  1070						  QSPI_CMB_SEQ_ADDR);
  1071				/* Program Command and Address config in register */
  1072				tegra_qspi_writel(tqspi, cmd_config,
  1073						  QSPI_CMB_SEQ_CMD_CFG);
  1074				tegra_qspi_writel(tqspi, addr_config,
  1075						  QSPI_CMB_SEQ_ADDR_CFG);
  1076	
  1077				reinit_completion(&tqspi->xfer_completion);
  1078				cmd1 = tegra_qspi_setup_transfer_one(spi, xfer,
  1079								     is_first_msg);
  1080				ret = tegra_qspi_start_transfer_one(spi, xfer,
  1081								    cmd1);
  1082	
  1083				if (ret < 0) {
  1084					dev_err(tqspi->dev, "Failed to start transfer-one: %d\n",
  1085						ret);
  1086					return ret;
  1087				}
  1088	
  1089				is_first_msg = false;
  1090				ret = wait_for_completion_timeout
  1091						(&tqspi->xfer_completion,
  1092						QSPI_DMA_TIMEOUT);
  1093	
  1094				if (WARN_ON(ret == 0)) {
  1095					dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
  1096						ret);
  1097					if (tqspi->is_curr_dma_xfer &&
  1098					    (tqspi->cur_direction & DATA_DIR_TX))
  1099						dmaengine_terminate_all
  1100							(tqspi->tx_dma_chan);
  1101	
  1102					if (tqspi->is_curr_dma_xfer &&
  1103					    (tqspi->cur_direction & DATA_DIR_RX))
  1104						dmaengine_terminate_all
  1105							(tqspi->rx_dma_chan);
  1106	
  1107					/* Abort transfer by resetting pio/dma bit */
  1108					if (!tqspi->is_curr_dma_xfer) {
  1109						cmd1 = tegra_qspi_readl
  1110								(tqspi,
  1111								 QSPI_COMMAND1);
  1112						cmd1 &= ~QSPI_PIO;
  1113						tegra_qspi_writel
  1114								(tqspi, cmd1,
  1115								 QSPI_COMMAND1);
  1116					} else {
  1117						dma_ctl = tegra_qspi_readl
  1118								(tqspi,
  1119								 QSPI_DMA_CTL);
  1120						dma_ctl &= ~QSPI_DMA_EN;
  1121						tegra_qspi_writel(tqspi, dma_ctl,
  1122								  QSPI_DMA_CTL);
  1123					}
  1124	
  1125					/* Reset controller if timeout happens */
  1126					if (device_reset(tqspi->dev) < 0)
  1127						dev_warn_once(tqspi->dev,
  1128							      "device reset failed\n");
  1129					ret = -EIO;
  1130					goto exit;
  1131				}
  1132	
  1133				if (tqspi->tx_status ||  tqspi->rx_status) {
  1134					dev_err(tqspi->dev, "QSPI Transfer failed\n");
  1135					tqspi->tx_status = 0;
  1136					tqspi->rx_status = 0;
  1137					ret = -EIO;
  1138					goto exit;
  1139				}
> 1140			default:
  1141				goto exit;
  1142			}
  1143			msg->actual_length += xfer->len;
  1144			transfer_phase++;
  1145		}
  1146	
  1147	exit:
  1148		msg->status = ret;
  1149	
  1150		return ret;
  1151	}
  1152	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
