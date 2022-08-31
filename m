Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F165A76F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHaGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaGxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:53:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC9BB01B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661928781; x=1693464781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=18kO/PexrqlieiG1gwkrVuZZrV9IdV+EuhOhfubb5X0=;
  b=jIC+oOx5IZMy0QSW/rqccDV4PmoWQ8YMPbrgTVhTjnVYA4Mx/7xcTPve
   jTRZ4WAgnjHtMFKCtkqdQJMkBTt4d7FOb9iYTEc/sRQH94tvRUuJEzpE4
   NTK73Oqc4P3Bn+/ToFRkeJKRqehSaP1B5S9aHXNE2DuePbrhKNX37XSgv
   HTHbbsguosgaPDZx0BRlPovZsCreMpALoodJok6ME0sCI4P9zUXcC9KaM
   aicw045xU4bIvxt7HHiE5A+jEb60TSC20wGiJ/9pxMgRSoBORncVWC/bs
   Ac9DdaDiPKBLCXfqsxSgZzeU92GYl1RuZs0goJQVsQB75VuRqCJDvz8PO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321525252"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="321525252"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 23:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="562940505"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 23:52:57 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTHaq-00003K-2C;
        Wed, 31 Aug 2022 06:52:56 +0000
Date:   Wed, 31 Aug 2022 14:52:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: powerpc-linux-objdump: Warning: Unrecognized form: 0x23
Message-ID: <202208311414.4OPuYS9K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   5 months ago
config: powerpc-buildonly-randconfig-r003-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9b3cd24578401e7a392974b3353277286e49cee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
>> powerpc-linux-objdump: Warning: DIE at offset 0x382c refers to abbreviation number 2753 which does not exist
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
>> powerpc-linux-objdump: Warning: DIE at offset 0x382c refers to abbreviation number 2753 which does not exist
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
