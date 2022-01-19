Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7919494045
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356961AbiASTDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:03:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:43150 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231845AbiASTDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642618982; x=1674154982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hA94tR9E+EV8Zk26TRDkNjpj0VOtO/hCsQLa9GYFpqU=;
  b=YB6xzflSf/Z/HpTKTS3ZU0jkk2scSy65zvR1ishbNCrXiXLvyMNJqBlu
   YRtUrjZ1/ruVFW4JlJIRttruo8LaHD4h9PdrIjUGK7FCujXMC9dDd8PUE
   +yv1aSt15N4fKITfxpE6FyD4QRiwe/YGD/p5aOjLvbI8O+e1UH7Z1Ttso
   87TywrV5bnT52Gd34DK4VAMYGOYJj4MqSdv8VQIPUiTXTv4cLSeqtPxeM
   yuAOCwwVfuApNX5wSZvjYCgt2zsbS0Kcrj7CrNM5XfTRxWP3yTqWOPIaj
   iIeA6+P6AME7IOrMSvLoQrUwF3LEdslZhgOc0dHYGC2+7ORRdNJuf8Cfl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225829839"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="225829839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 10:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="561132325"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2022 10:18:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAFXY-000DgZ-H6; Wed, 19 Jan 2022 18:18:36 +0000
Date:   Thu, 20 Jan 2022 02:18:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Schambacher <joerg@hifiberry.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: sound/soc/codecs/tas5754m.c:246:7: warning: variable 'ret' is used
 uninitialized whenever switch case is taken
Message-ID: <202201200259.nNgbKOJd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220119-210919/Joerg-Schambacher/ASoC-adds-component-driver-for-TAS575xM-digital-amplifiers/20220110-164852
head:   05b8bf5544bc621031f5a0a6bdf1ac6468a7367b
commit: 05b8bf5544bc621031f5a0a6bdf1ac6468a7367b ASoC: adds component driver for TAS575xM digital amplifiers
date:   5 hours ago
config: riscv-randconfig-c006-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200259.nNgbKOJd-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/05b8bf5544bc621031f5a0a6bdf1ac6468a7367b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220119-210919/Joerg-Schambacher/ASoC-adds-component-driver-for-TAS575xM-digital-amplifiers/20220110-164852
        git checkout 05b8bf5544bc621031f5a0a6bdf1ac6468a7367b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas5754m.c:246:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case SND_SOC_BIAS_ON:
                ^~~~~~~~~~~~~~~
   sound/soc/codecs/tas5754m.c:267:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   sound/soc/codecs/tas5754m.c:247:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case SND_SOC_BIAS_PREPARE:
                ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas5754m.c:267:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   sound/soc/codecs/tas5754m.c:242:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.


vim +/ret +246 sound/soc/codecs/tas5754m.c

   236	
   237	static int tas5754m_set_bias_level(struct snd_soc_component *component,
   238					   enum snd_soc_bias_level level)
   239	{
   240		struct tas5754m_priv *tas5754m =
   241					snd_soc_component_get_drvdata(component);
   242		int ret;
   243	
   244		switch (level) {
   245		default:
 > 246		case SND_SOC_BIAS_ON:
   247		case SND_SOC_BIAS_PREPARE:
   248			break;
   249	
   250		case SND_SOC_BIAS_STANDBY:
   251			ret = regmap_update_bits(tas5754m->regmap,
   252					TAS5754M_POWER, TAS5754M_RQST, 0);
   253			if (ret)
   254				dev_err(component->dev,
   255					"Failed to remove standby: %d\n", ret);
   256			break;
   257	
   258		case SND_SOC_BIAS_OFF:
   259			ret = regmap_update_bits(tas5754m->regmap,
   260					TAS5754M_POWER, TAS5754M_RQST, TAS5754M_RQST);
   261			if (ret)
   262				dev_err(component->dev,
   263					"Failed to request standby: %d\n", ret);
   264			break;
   265		}
   266	
   267		return ret;
   268	}
   269	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
