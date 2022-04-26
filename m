Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885E451075F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352260AbiDZStb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbiDZSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:49:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EB589CC5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650998780; x=1682534780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ExvTUqp4Cjsjj9KvvRDjdEWd96EAzK6PTkx67YvD0yE=;
  b=bnoR1AxrZJRDxqnttZ6b/DYPl46u5YHlSoTHBK8C1LRQkm44JGZnsknn
   aLCuUeV/Ff04xkyahSPJjims/LgF6sdTMbYoYmEcdI25QbgirGnVLxhp9
   OZDPM/+M6cFOWnWFbBVrx+Pebp2RjRtbl4sukpl83PMBTZE1KSF6vByIH
   ap0ZP5/6sroQBFDm7IhHN36mhGJXG9MBsbdydDLEJo60TEjVK2S7wJKA3
   FK2sMRrarqyfBB7w72pfFQgFQVnG1djtspb09Z5FtTc7QXUcAqSanRtok
   4gly2ormTlZK0oqjYruUaPdXbBcUPEWBR5P4O+DOS+0GReagKtBgeO8Hl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328629592"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="328629592"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 11:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="513301710"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2022 11:46:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njQCX-0003tW-5z;
        Tue, 26 Apr 2022 18:46:17 +0000
Date:   Wed, 27 Apr 2022 02:46:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [matthias-bgg:v5.18-next/dts64 30/31]
 arch/arm/boot/dts/en7523.dtsi:6:10: fatal error:
 'dt-bindings/clock/en7523-clk.h' file not found
Message-ID: <202204270225.KTBJUC4B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.18-next/dts64
head:   cf11eccbf44d24cc7f8d16fbbf59afeff99e73bf
commit: 09f4afc44ba9ebd33d389af345cff4d7668437ae [30/31] ARM: dts: add clock support for Airoha EN7523
config: arm-randconfig-r012-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270225.KTBJUC4B-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?id=09f4afc44ba9ebd33d389af345cff4d7668437ae
        git remote add matthias-bgg https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
        git fetch --no-tags matthias-bgg v5.18-next/dts64
        git checkout 09f4afc44ba9ebd33d389af345cff4d7668437ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/en7523-evb.dts:7:
>> arch/arm/boot/dts/en7523.dtsi:6:10: fatal error: 'dt-bindings/clock/en7523-clk.h' file not found
   #include <dt-bindings/clock/en7523-clk.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +6 arch/arm/boot/dts/en7523.dtsi

     2	
     3	#include <dt-bindings/interrupt-controller/irq.h>
     4	#include <dt-bindings/interrupt-controller/arm-gic.h>
     5	#include <dt-bindings/gpio/gpio.h>
   > 6	#include <dt-bindings/clock/en7523-clk.h>
     7	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
