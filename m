Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8C5A7761
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiHaHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHaHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:18:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB7201B5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661930101; x=1693466101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UFtaGGZcd5hqupfg03iJo60XuDXVT4T/ce2D86efO7k=;
  b=CkxcRjprP3DZ2MkcO0ds1P8ZwWZA1pCorvU8vCZ7bjs+9SLTVyRV3PUt
   5hDuURiH7+PY6LCY3ELaL6qFEyJDJJA8pqgLhzF8J/mWrf9OizXv7Seuq
   RXKJNqs3N2ngXbpx3xj1kOqcrcj+OfTVluVZbld6fibtJBjqUP78bh5LE
   ZPwNMs+4hUTLlsyiGdv8X8HeaGX4E/1/fiohpF3rlruPCcA0NhDzjbXR8
   WZyXd7bU2rJpLrEXTLunsm+5bE84g0fmNA55V3kk5+1zH271GH/RF1cuW
   X/0scpy65pV4TAyxJxvFsgpLgyv3J5BFOKcFszc44f65/StA43QbsaiTm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275138597"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="275138597"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 00:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="940343776"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 00:14:59 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTHwA-00004a-1X;
        Wed, 31 Aug 2022 07:14:58 +0000
Date:   Wed, 31 Aug 2022 15:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: powerpc-linux-objdump: Warning: Unrecognized form: 0x23
Message-ID: <202208311529.oy9I92hy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: 86ce436e30d86327c9f5260f718104ae7b21f506 macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled
date:   3 months ago
config: powerpc-buildonly-randconfig-r004-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311529.oy9I92hy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86ce436e30d86327c9f5260f718104ae7b21f506
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 86ce436e30d86327c9f5260f718104ae7b21f506
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
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: DIE at offset 0xe023 refers to abbreviation number 5553012 which does not exist
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
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: DIE at offset 0xe023 refers to abbreviation number 5553012 which does not exist
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
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
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
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
--
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
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: DIE at offset 0xe023 refers to abbreviation number 5553012 which does not exist
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
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
   powerpc-linux-objdump: Warning: Unrecognized form: 0x22
>> powerpc-linux-objdump: Warning: DIE at offset 0xe023 refers to abbreviation number 5553012 which does not exist
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
