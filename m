Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B727582A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiG0QSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiG0QSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:18:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED434AD7D;
        Wed, 27 Jul 2022 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658938719; x=1690474719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tBeOUp/yxaWMe5c9npreqRETmrBhESTwQGPebnMPCV8=;
  b=WM6Zer+CYEHxp3MM/UrGAq+kb5Y9zI9bIJqfyt4yjQgtDWlrPiGd46BB
   MlfW24giCYqtwn1VRqTXKCwGkEG0Ea3XP/n7SeDoyWK5ESGRYq0d2a++Q
   bpucvPZtpPhYyGRQVE89XtvUF4kbjOmtY+2q9S9R4q3zP5bRVKsrO0Yd3
   HU7/FfRVoB+dJGw55Ezqhznrc9D4+ls0SYKus5+kUexmT1YPE63QYBYUC
   rZz/qn6yiV5VIsLSthg0B6haw3G24JV250wkg0N0REuyLo+EehCC5DhbI
   neLaW3ZhuWQalWRIfa4xUn0TmvOGRAyZoS4xJ6uJNUqnRfZvXY1pGIXX0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289473329"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="289473329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 09:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="927851599"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2022 09:18:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGjk2-0008tK-0M;
        Wed, 27 Jul 2022 16:18:34 +0000
Date:   Thu, 28 Jul 2022 00:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34:
 warning: unused variable 'c8sectpfe_match'
Message-ID: <202207280016.r8tOLF4N-lkp@intel.com>
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

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   39c3c396f8131f3db454c80e0fcfcdc54ed9ec01
commit: e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2 media: platform: place stm32/ and sti/ under st/ dir
date:   4 months ago
config: mips-buildonly-randconfig-r001-20220727 (https://download.01.org/0day-ci/archive/20220728/202207280016.r8tOLF4N-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/ drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34: warning: unused variable 'c8sectpfe_match' [-Wunused-const-variable]
   static const struct of_device_id c8sectpfe_match[] = {
                                    ^
   1 warning generated.


vim +/c8sectpfe_match +1175 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c

c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1174  
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30 @1175  static const struct of_device_id c8sectpfe_match[] = {
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1176  	{ .compatible = "st,stih407-c8sectpfe" },
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1177  	{ /* sentinel */ },
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1178  };
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1179  MODULE_DEVICE_TABLE(of, c8sectpfe_match);
c5f5d0f99794cfb drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1180  

:::::: The code at line 1175 was first introduced by commit
:::::: c5f5d0f99794cfb675ecacfe37a1b33b352b9752 [media] c8sectpfe: STiH407/10 Linux DVB demux support

:::::: TO: Peter Griffin <peter.griffin@linaro.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
