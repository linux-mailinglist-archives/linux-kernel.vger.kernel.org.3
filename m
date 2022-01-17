Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E376A49107F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiAQSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:55:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:54723 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233419AbiAQSzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642445746; x=1673981746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LQrQESAuBmiDBGf8ezAg1KIsoxEHQ5UEfJJMEaZbAXY=;
  b=Se6yB5Mnp7m2UymlEy5jAUTVjDHAja6MbyTV75U+e7C18qRcFoZPq7/E
   HDgEity7mMKCgHj06Et5ew3nSEfKPifvAUdLMtvxWVYUEqJloi3qQ33JX
   7rOMCZe1SjAunJIm36joJ/R7my7/a5RCv4JgrVaZRjZqhPyw+g2g0EAmk
   TqzVOXMOrCEpTK0hmjmNLUzjrzQY3FSenP4YIbeW95beT1QqHjggDf6sh
   Ah8zhvzMUuWd6iKr3xU7Ts4hu2Odmq8z3yVZjABSypTK+E6Y4BgvX4iLE
   I5cNsIa1+uLIRkhzFpgfNKLYJowxXm8tWr5ALB2hNPAs1gsgeZElQF+Ys
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331027471"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="331027471"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="615134298"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2022 10:55:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9XAO-000Bmo-Pp; Mon, 17 Jan 2022 18:55:44 +0000
Date:   Tue, 18 Jan 2022 02:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 76/167] drivers/net/dsa/qca8k.c:1185:3: error: implicit
 declaration of function 'qca8k_mac_config_setup_internal_delay'
Message-ID: <202201180222.WdeTEpLq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   2c17c82cf0078ead3d8a315b2b103f9e5a5cdb1d
commit: c1b605b3b2edac51ad6b687c68f087fe166790ce [76/167] net: dsa: qca8k: convert to use phylink_pcs
config: i386-randconfig-a005-20220117 (https://download.01.org/0day-ci/archive/20220118/202201180222.WdeTEpLq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout c1b605b3b2edac51ad6b687c68f087fe166790ce
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/dsa/qca8k.c:1185:3: error: implicit declaration of function 'qca8k_mac_config_setup_internal_delay' [-Werror,-Wimplicit-function-declaration]
                   qca8k_mac_config_setup_internal_delay(priv, cpu_port_index, reg);
                   ^
   drivers/net/dsa/qca8k.c:1479:1: error: static declaration of 'qca8k_mac_config_setup_internal_delay' follows non-static declaration
   qca8k_mac_config_setup_internal_delay(struct qca8k_priv *priv, int cpu_port_index,
   ^
   drivers/net/dsa/qca8k.c:1185:3: note: previous implicit declaration is here
                   qca8k_mac_config_setup_internal_delay(priv, cpu_port_index, reg);
                   ^
   2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_SOC_CS35L41_SPI
   Depends on SOUND && !UML && SND && SND_SOC && SPI_MASTER
   Selected by
   - SND_SOC_AMD_VANGOGH_MACH && SOUND && !UML && SND && SND_SOC && SND_SOC_AMD_ACP5x && I2C


vim +/qca8k_mac_config_setup_internal_delay +1185 drivers/net/dsa/qca8k.c

  1120	
  1121	static int qca8k_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
  1122				    phy_interface_t interface,
  1123				    const unsigned long *advertising,
  1124				    bool permit_pause_to_mac)
  1125	{
  1126		struct qca8k_priv *priv = pcs_to_qca8k_pcs(pcs)->priv;
  1127		int cpu_port_index, ret, port;
  1128		u32 reg, val;
  1129	
  1130		port = pcs_to_qca8k_pcs(pcs)->port;
  1131		switch (port) {
  1132		case 0:
  1133			reg = QCA8K_REG_PORT0_PAD_CTRL;
  1134			cpu_port_index = QCA8K_CPU_PORT0;
  1135			break;
  1136	
  1137		case 6:
  1138			reg = QCA8K_REG_PORT6_PAD_CTRL;
  1139			cpu_port_index = QCA8K_CPU_PORT6;
  1140			break;
  1141	
  1142		default:
  1143			WARN_ON(1);
  1144		}
  1145	
  1146		/* Enable/disable SerDes auto-negotiation as necessary */
  1147		ret = qca8k_read(priv, QCA8K_REG_PWS, &val);
  1148		if (ret)
  1149			return ret;
  1150		if (phylink_autoneg_inband(mode))
  1151			val &= ~QCA8K_PWS_SERDES_AEN_DIS;
  1152		else
  1153			val |= QCA8K_PWS_SERDES_AEN_DIS;
  1154		qca8k_write(priv, QCA8K_REG_PWS, val);
  1155	
  1156		/* Configure the SGMII parameters */
  1157		ret = qca8k_read(priv, QCA8K_REG_SGMII_CTRL, &val);
  1158		if (ret)
  1159			return ret;
  1160	
  1161		val |= QCA8K_SGMII_EN_SD;
  1162	
  1163		if (priv->ports_config.sgmii_enable_pll)
  1164			val |= QCA8K_SGMII_EN_PLL | QCA8K_SGMII_EN_RX |
  1165			       QCA8K_SGMII_EN_TX;
  1166	
  1167		if (dsa_is_cpu_port(priv->ds, port)) {
  1168			/* CPU port, we're talking to the CPU MAC, be a PHY */
  1169			val &= ~QCA8K_SGMII_MODE_CTRL_MASK;
  1170			val |= QCA8K_SGMII_MODE_CTRL_PHY;
  1171		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
  1172			val &= ~QCA8K_SGMII_MODE_CTRL_MASK;
  1173			val |= QCA8K_SGMII_MODE_CTRL_MAC;
  1174		} else if (interface == PHY_INTERFACE_MODE_1000BASEX) {
  1175			val &= ~QCA8K_SGMII_MODE_CTRL_MASK;
  1176			val |= QCA8K_SGMII_MODE_CTRL_BASEX;
  1177		}
  1178	
  1179		qca8k_write(priv, QCA8K_REG_SGMII_CTRL, val);
  1180	
  1181		/* From original code is reported port instability as SGMII also
  1182		 * require delay set. Apply advised values here or take them from DT.
  1183		 */
  1184		if (interface == PHY_INTERFACE_MODE_SGMII)
> 1185			qca8k_mac_config_setup_internal_delay(priv, cpu_port_index, reg);
  1186		/* For qca8327/qca8328/qca8334/qca8338 sgmii is unique and
  1187		 * falling edge is set writing in the PORT0 PAD reg
  1188		 */
  1189		if (priv->switch_id == QCA8K_ID_QCA8327 ||
  1190		    priv->switch_id == QCA8K_ID_QCA8337)
  1191			reg = QCA8K_REG_PORT0_PAD_CTRL;
  1192	
  1193		val = 0;
  1194	
  1195		/* SGMII Clock phase configuration */
  1196		if (priv->ports_config.sgmii_rx_clk_falling_edge)
  1197			val |= QCA8K_PORT0_PAD_SGMII_RXCLK_FALLING_EDGE;
  1198	
  1199		if (priv->ports_config.sgmii_tx_clk_falling_edge)
  1200			val |= QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE;
  1201	
  1202		if (val)
  1203			ret = qca8k_rmw(priv, reg,
  1204					QCA8K_PORT0_PAD_SGMII_RXCLK_FALLING_EDGE |
  1205					QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE,
  1206					val);
  1207	
  1208	
  1209		return 0;
  1210	}
  1211	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
