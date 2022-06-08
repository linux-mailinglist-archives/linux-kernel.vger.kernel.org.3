Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF51543BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiFHSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFHSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:55:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4158DE7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654714546; x=1686250546;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sigDhzIeadKw9Rowo0QrBbAxZifqII/1TowpL5HAW1A=;
  b=ZJQGI4Sww/S2FG5rA+dISw23KFbPNdLDg2D2bvsAxCk/POAiabTaMLxw
   W5yOzGc8M/KGwPdcBO1a2S8VuYuLhzT1/r5GhVhrPQmkGC0JvifbzJclt
   xxuT/QO6bNuVu8zGyMxe8JyBr/ftyW80w7KRW4KTNZT4om61y2zMpXlhU
   n62dUIZY9FuLXg/7nASTkSGSTxwsmx+Vao1TKuDgKf9GOQrBUI93Ty4XK
   EzbX+oQuhMAUOBt0Ox304oWMk6b+8d3cJ3ZHzBoLTJhctQ3l5sM2m5lbC
   hmLnZGKpSuHbQy9yWzqLqH6OiuqcahPvNl1mYt+k8YKtAczbCxgr4Yqxu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265804092"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="265804092"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="827124928"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2022 11:55:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz0qG-000EvF-4Z;
        Wed, 08 Jun 2022 18:55:44 +0000
Date:   Thu, 9 Jun 2022 02:55:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 28/33] fork.c:undefined
 reference to `virt_to_pfn'
Message-ID: <202206090239.mJaQrFRX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integr=
ator.git kernel-in-vmalloc-v5.19-rc1
head:   512fc95a58c7b2e91e267db91a4ec5a54afedd01
commit: 851c5f699d64c4ed8f53c7a21fb5428bbd3a8d87 [28/33] riscv: Make virt_t=
o_pfn() a real function
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive=
/20220609/202206090239.mJaQrFRX-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-inte=
grator.git/commit/?id=3D851c5f699d64c4ed8f53c7a21fb5428bbd3a8d87
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/=
kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 851c5f699d64c4ed8f53c7a21fb5428bbd3a8d87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: init/main.o: in function `.L0 ':
   main.c:(.init.text+0x97c): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: main.c:(.init.text+0x9ba): undefined reference to `vir=
t_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `.L0 ':
>> fork.c:(.text+0x90): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `.L=021':
   fork.c:(.text+0x306): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/resource.o: in function `alloc_resource':
>> resource.c:(.text+0x544): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: mm/swap.o:swap.c:(.text+0xc90): more undefined referen=
ces to `virt_to_pfn' follow

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
