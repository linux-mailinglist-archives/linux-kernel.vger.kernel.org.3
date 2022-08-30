Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3755A5B44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiH3Fs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH3Fs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:48:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8915B3B3E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661838536; x=1693374536;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bK7xYNVaoJLkhujS11HrQnDHwKu4xtxVijU01ooiRE0=;
  b=RF9jjhbHlJUHMSkssYeZ9nKVpcL4hVAahf10uzyyyci6I4c/9iCUOoOZ
   savl3egSqwULaTIuGqLg7sel5f0x4mdv8P0FcgYG2+KW7ap0tOXUAHstM
   oLiewHfgIragTR1mitoxi0xS5FVbckX5dpyJqzLtj5rbJGy/ci8rc2aiM
   DFQF1I3uVoNwNovgeQl0xvBU4q53uphJKULfmvJxIU2RS2DbNRQ1fAdvr
   MiQCONXugCcWTkfNaBVL7ZmS1bgcrr0uGnMQc9HZtZrhDyfnHUWO7bEe7
   T200CZwGn7x7+R29fjyecpYKpanXJOvfblB0oM55/aGB7k4WROHOPgbcu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293832054"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293832054"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 22:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672695932"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 22:47:03 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSu5W-0000bP-1Q;
        Tue, 30 Aug 2022 05:47:02 +0000
Date:   Tue, 30 Aug 2022 13:46:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:virt-to-pfn-v6.0-rc1 22/24] main.c:undefined
 reference to `virt_to_pfn'
Message-ID: <202208301324.UnOvJU07-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integr=
ator.git virt-to-pfn-v6.0-rc1
head:   fd7709c9f1119794e96665ae423d79d93bfe43fc
commit: f87ff66fb349ec7d2840f4ebc552bfa0018cabb4 [22/24] riscv: Make virt_t=
o_pfn() a real function
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive=
/20220830/202208301324.UnOvJU07-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-inte=
grator.git/commit/?id=3Df87ff66fb349ec7d2840f4ebc552bfa0018cabb4
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/=
kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator virt-to-pfn-v6.0-rc1
        git checkout f87ff66fb349ec7d2840f4ebc552bfa0018cabb4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: init/main.o: in function `.L0 ':
>> main.c:(.init.text+0x988): undefined reference to `virt_to_pfn'
>> riscv64-linux-ld: main.c:(.init.text+0x9c6): undefined reference to `vir=
t_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `.L0 ':
>> fork.c:(.text+0x90): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `.L=021':
   fork.c:(.text+0x316): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/resource.o: in function `alloc_resource':
>> resource.c:(.text+0x54c): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: mm/swap.o:swap.c:(.text+0xbe2): more undefined referen=
ces to `virt_to_pfn' follow

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
