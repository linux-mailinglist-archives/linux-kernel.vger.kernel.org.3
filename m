Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DEF503086
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356127AbiDOVpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356192AbiDOVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:44:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423DC48383
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650058898; x=1681594898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EiE7+WLdmrls3N6fRhJV8VbuBkpIj55ZCw32IOgRz78=;
  b=Li1SooxiVGG9F34QtPUk9WF31mT3YgsQF3kWMAer73L2am3CazST4w0W
   AEwTUlNB7v4/4fePrubg5EzM9Nu3rL305JkjJTRKZP/J3bEsoItO+Qt04
   tVgfVbn6N1lYX/lghyaouEJIPVru/vU27PgNHnXi4nwtXU22mqF98Ta97
   rKGckwTkNIMc7Lp6VzJFvRU5M3IYkpLnmDrNW9lL4sgkYRuVCA9QFCj4j
   nK4RTwOBcdiiKNQYXiEG8lAxs2ZeFc1e35UDPkhkL+h1uhig+VpEN4phl
   vEbqLpy8fYFB0olROD37CIZD6GmpB48yAo+GgDesDEIcc7tTWC/yvJst+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263410333"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="263410333"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 14:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="646192303"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2022 14:41:35 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfTh9-0002S5-3w;
        Fri, 15 Apr 2022 21:41:35 +0000
Date:   Sat, 16 Apr 2022 05:41:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.text+0x1778608): Section mismatch in
 reference from the function binderfs_binder_device_create() to the function
 .init.text:set_reset_devices()
Message-ID: <202204160549.K8MMhRsg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   3 weeks ago
config: riscv-randconfig-r004-20220408 (https://download.01.org/0day-ci/archive/20220416/202204160549.K8MMhRsg-lkp@intel.com/config)
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

>> WARNING: modpost: vmlinux.o(.text+0x1778608): Section mismatch in reference from the function binderfs_binder_device_create() to the function .init.text:set_reset_devices()
The function binderfs_binder_device_create() references
the function __init set_reset_devices().
This is often because binderfs_binder_device_create lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x178fa2e): Section mismatch in reference from the function binder_alloc_free_page() to the function .init.text:set_reset_devices()
The function binder_alloc_free_page() references
the function __init set_reset_devices().
This is often because binder_alloc_free_page lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1875f90): Section mismatch in reference from the function ethnl_default_dumpit() to the function .init.text:set_reset_devices()
The function ethnl_default_dumpit() references
the function __init set_reset_devices().
This is often because ethnl_default_dumpit lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x187ed7e): Section mismatch in reference from the function tsinfo_reply_size() to the function .init.text:set_reset_devices()
The function tsinfo_reply_size() references
the function __init set_reset_devices().
This is often because tsinfo_reply_size lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x191d390): Section mismatch in reference from the function ieee802154_llsec_fill_key_id() to the function .init.text:set_reset_devices()
The function ieee802154_llsec_fill_key_id() references
the function __init set_reset_devices().
This is often because ieee802154_llsec_fill_key_id lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x8844c8): Section mismatch in reference from the function vduse_init() to the function .init.text:set_reset_devices()
The function vduse_init() references
the function __init set_reset_devices().
This is often because vduse_init lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x8850c6): Section mismatch in reference from the function vduse_create_dev() to the function .init.text:set_reset_devices()
The function vduse_create_dev() references
the function __init set_reset_devices().
This is often because vduse_create_dev lacks a __init
annotation or the annotation of set_reset_devices is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
