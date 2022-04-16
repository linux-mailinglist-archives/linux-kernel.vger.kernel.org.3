Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24066503841
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiDPU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiDPU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:57:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74781CB20
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650142521; x=1681678521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YqggBscwBR8kECPE8sV7GZRQg0PKKtnXg81Oh6vwzgQ=;
  b=DN2GVcCkTuh4O95lmxlJnBVUf6SWMVtsaUlNOYd2SAODmqjYfcUrSE/s
   Zs74pEzXKnSCf0J6p/6JI3khhkGxl5sckyQs6eEvNHGbkutSuQVWyd498
   yhPYrbZTmBIV0IqL+J1Sk3KJvS6W1Kig7vGjnY00NhtVoM5CKxU42aLx6
   d3pXjQQFKtw0pzQS7MVRBU7ax9tYRgNfXgd4KrBOsOc0sv78eRGpO20U4
   J9ScJwnVWQYrCDzxYWhugn0B2Mc2BQjKE/jn35vGOpBnQZEOjgoT+hix/
   AgYn9SsNYEs1RwOXxcuI8bUBqZ0HCSj0gAsdPR1ykMXR4oFvf8oZgQ3SL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349788711"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="349788711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 13:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="646434100"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2022 13:55:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfpRt-0003UF-NH;
        Sat, 16 Apr 2022 20:55:17 +0000
Date:   Sun, 17 Apr 2022 04:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.text+0x1718cce): Section mismatch in
 reference from the function bmi160_i2c_probe() to the function
 .init.text:set_reset_devices()
Message-ID: <202204170429.sEZb8tjA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   3 weeks ago
config: riscv-randconfig-r004-20220408 (https://download.01.org/0day-ci/archive/20220417/202204170429.sEZb8tjA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9b3cd24578401e7a392974b3353277286e49cee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1718cce): Section mismatch in reference from the function bmi160_i2c_probe() to the function .init.text:set_reset_devices()
The function bmi160_i2c_probe() references
the function __init set_reset_devices().
This is often because bmi160_i2c_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x172619c): Section mismatch in reference from the function st_lsm6dsx_probe() to the function .init.text:set_reset_devices()
The function st_lsm6dsx_probe() references
the function __init set_reset_devices().
This is often because st_lsm6dsx_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x175c62e): Section mismatch in reference from the function mb1232_probe() to the function .init.text:set_reset_devices()
The function mb1232_probe() references
the function __init set_reset_devices().
This is often because mb1232_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x179066c): Section mismatch in reference from the function binder_update_page_range() to the function .init.text:set_reset_devices()
The function binder_update_page_range() references
the function __init set_reset_devices().
This is often because binder_update_page_range lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x179c6b4): Section mismatch in reference from the function altera_cvp_probe() to the function .init.text:set_reset_devices()
The function altera_cvp_probe() references
the function __init set_reset_devices().
This is often because altera_cvp_probe lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x179c8e2): Section mismatch in reference from the function altera_cvp_remove() to the function .init.text:set_reset_devices()
The function altera_cvp_remove() references
the function __init set_reset_devices().
This is often because altera_cvp_remove lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x18738e8): Section mismatch in reference from the function ethtool_rxnfc_copy_from_user() to the function .init.text:set_reset_devices()
The function ethtool_rxnfc_copy_from_user() references
the function __init set_reset_devices().
This is often because ethtool_rxnfc_copy_from_user lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1873c7c): Section mismatch in reference from the function ethtool_copy_validate_indir() to the function .init.text:set_reset_devices()
The function ethtool_copy_validate_indir() references
the function __init set_reset_devices().
This is often because ethtool_copy_validate_indir lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1879d9a): Section mismatch in reference from the function ethnl_set_linkmodes() to the function .init.text:set_reset_devices()
The function ethnl_set_linkmodes() references
the function __init set_reset_devices().
This is often because ethnl_set_linkmodes lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x187ebf6): Section mismatch in reference from the function tsinfo_prepare_data() to the function .init.text:set_reset_devices()
The function tsinfo_prepare_data() references
the function __init set_reset_devices().
This is often because tsinfo_prepare_data lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x191c146): Section mismatch in reference from the function ieee802154_start_req() to the function .init.text:set_reset_devices()
The function ieee802154_start_req() references
the function __init set_reset_devices().
This is often because ieee802154_start_req lacks a __init
annotation or the annotation of set_reset_devices is wrong.
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
