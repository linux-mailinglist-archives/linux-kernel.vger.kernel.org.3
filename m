Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0150ACB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442896AbiDVAW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442906AbiDVAWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:22:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4516434AE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650586771; x=1682122771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Cae91wgwoUISIVHNJhqDC1JX0AUtWS/8naJ8Bp4mNc=;
  b=TQisveG43cPKG7aZXVjJFWgdrbTihhto8PMXB39ilwlpUgTUJuddMeSU
   bZ+vU6JAEfRBU+bPLqud7Kfje3/I3HTOvEAyr+yyCBGNsOjl2cQvu4X6X
   lyJVI9itbbZjLxQbWwcMaE4eaKnap5FA5KNhNhXWUnvH7j/X8cuddodD2
   HLqE9I4ZkmsIIla8/yRx85HQu3Z0NU9ILcs3Zi0sYB+pl40Zi7og37wrV
   cfLDNqQamTPsKNESNiNBUuXesnAmqlrYD1R6FCnPCrMMFitBK7JvPR3YA
   8PYmhzGx/8welCaHT6/algvXwdvrGoVyA7nqFzjhjNxSXrofkpUFFVY/Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324970338"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="324970338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="671443824"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 17:19:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhh1E-00090L-1T;
        Fri, 22 Apr 2022 00:19:28 +0000
Date:   Fri, 22 Apr 2022 08:18:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     kbuild-all@lists.01.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        daire.mcnamara@microchip.com, lewis.hanly@microchip.com,
        cyril.jean@microchip.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 3/4] riscv: select vitesse phy driver for polarfire soc
Message-ID: <202204220822.swSeha61-lkp@intel.com>
References: <20220421085805.1220195-4-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421085805.1220195-4-conor.dooley@microchip.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Conor-Dooley/polarfire-soc-kconfig-maintainers-updates/20220421-172138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b253435746d9a4a701b5f09211b9c14d3370d0da
config: riscv-randconfig-r002-20220420 (https://download.01.org/0day-ci/archive/20220422/202204220822.swSeha61-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dc055eafe9cad74b3b01bed537c6f1496cddabe4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Conor-Dooley/polarfire-soc-kconfig-maintainers-updates/20220421-172138
        git checkout dc055eafe9cad74b3b01bed537c6f1496cddabe4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc8221_config_init':
>> vitesse.c:(.text+0x10): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc73xx_config_init':
   vitesse.c:(.text+0x30): undefined reference to `mdiobus_write'
>> riscv64-linux-ld: vitesse.c:(.text+0x44): undefined reference to `phy_modify'
>> riscv64-linux-ld: vitesse.c:(.text+0x58): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x74): undefined reference to `phy_modify'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc739x_config_init':
   vitesse.c:(.text+0x96): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0xaa): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0xc2): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0xda): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0xee): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x102): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x11a): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x130): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x142): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x156): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x16a): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x180): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x196): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x1ac): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x1bc): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x1d0): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x1e0): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x1f4): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc73xx_write_page':
>> vitesse.c:(.text+0x226): undefined reference to `__mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc73xx_read_page':
>> vitesse.c:(.text+0x238): undefined reference to `__mdiobus_read'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc738x_config_init':
   vitesse.c:(.text+0x260): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x274): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x28c): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x2a4): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x2b8): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x2cc): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x2e4): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x2fa): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x30c): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x320): undefined reference to `mdiobus_write'
>> riscv64-linux-ld: vitesse.c:(.text+0x332): undefined reference to `mdiobus_read'
   riscv64-linux-ld: vitesse.c:(.text+0x34e): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x362): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x378): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x38c): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x3a2): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x3b8): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x3ce): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o:vitesse.c:(.text+0x3e2): more undefined references to `mdiobus_write' follow
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc738x_config_init':
>> vitesse.c:(.text+0x438): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x44e): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x462): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x476): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x48c): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x4a2): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o:vitesse.c:(.text+0x4ba): more undefined references to `mdiobus_write' follow
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc738x_config_init':
   vitesse.c:(.text+0x53a): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x54a): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x55e): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x56e): undefined reference to `phy_modify'
   riscv64-linux-ld: vitesse.c:(.text+0x582): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc8601_config_init':
>> vitesse.c:(.text+0x5c4): undefined reference to `mdiobus_read'
   riscv64-linux-ld: vitesse.c:(.text+0x5e4): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc82xx_config_intr':
   vitesse.c:(.text+0x66c): undefined reference to `mdiobus_read'
   riscv64-linux-ld: vitesse.c:(.text+0x68a): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc824x_config_init':
   vitesse.c:(.text+0x6b8): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x6d8): undefined reference to `mdiobus_read'
   riscv64-linux-ld: vitesse.c:(.text+0x70c): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `.L39':
   vitesse.c:(.text+0x766): undefined reference to `mdiobus_read'
>> riscv64-linux-ld: vitesse.c:(.text+0x774): undefined reference to `phy_error'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `.L40':
>> vitesse.c:(.text+0x788): undefined reference to `phy_trigger_machine'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc82x4_config_aneg':
>> vitesse.c:(.text+0x7ca): undefined reference to `genphy_setup_forced'
   riscv64-linux-ld: vitesse.c:(.text+0x7fa): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x814): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x832): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x850): undefined reference to `mdiobus_write'
   riscv64-linux-ld: vitesse.c:(.text+0x876): undefined reference to `mdiobus_write'
   riscv64-linux-ld: drivers/net/phy/vitesse.o:vitesse.c:(.text+0x88a): more undefined references to `mdiobus_write' follow
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `vsc82x4_config_aneg':
>> vitesse.c:(.text+0x8a4): undefined reference to `__genphy_config_aneg'
   riscv64-linux-ld: drivers/net/phy/vitesse.o: in function `.L0 ':
>> vitesse.c:(.init.text+0xc): undefined reference to `phy_drivers_register'
>> riscv64-linux-ld: vitesse.c:(.exit.text+0xa): undefined reference to `phy_drivers_unregister'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VITESSE_PHY
   Depends on NETDEVICES && PHYLIB
   Selected by
   - SOC_MICROCHIP_POLARFIRE

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
