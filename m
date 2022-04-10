Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B8C4FAB33
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiDJAXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiDJAXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:23:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C7B53;
        Sat,  9 Apr 2022 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649550091; x=1681086091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YlrW7qRsvgkaGNP8Lr6Xv7UiZRb08rP40QYEzwYj/D0=;
  b=Smc7HBCeqan/NjqPgPZTrNZhhOBNvh25IF1GZ5kjhJJe2bNrUhH1wQFr
   OigaBnWSzyVTmwewpC+uJv16S3uNGQE05U2ROxgsO7IKYtSUVlD+SZ3GK
   7ud1rOurxWF5hl35PnBpXzMv0KBQooL9eYmCvZytLV7Enk/87Tq1UQ4OQ
   0XTTodZUtZrwi0xoGOTnnTAkIQvh8MYhaqTSJSSbtQn8jFjmmksuVK9pF
   03zpFIewRDtIADFzz1QnwjegUicWfUTnV7BXZu999u42Di8P2CGCzI+Mi
   6HoNyGg++76VpT4Krf7lGBEaSgL0bGwi1qrdjrKaMDD4zQK2AUuaPwBF2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="259517884"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="259517884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 17:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="698899382"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2022 17:21:27 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndLKY-0000Vz-HE;
        Sun, 10 Apr 2022 00:21:26 +0000
Date:   Sun, 10 Apr 2022 08:21:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: ERROR: modpost: "snd_tea575x_set_freq" [sound/pci/snd-fm801.ko]
 undefined!
Message-ID: <202204100809.a0WvezZI-lkp@intel.com>
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
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: 9958d30f38b96fb763a10d44d18ddad39127d5f4 media: Kconfig: cleanup VIDEO_DEV dependencies
date:   3 weeks ago
config: arm64-randconfig-r002-20220409 (https://download.01.org/0day-ci/archive/20220410/202204100809.a0WvezZI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9958d30f38b96fb763a10d44d18ddad39127d5f4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9958d30f38b96fb763a10d44d18ddad39127d5f4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "snd_tea575x_set_freq" [sound/pci/snd-fm801.ko] undefined!
>> ERROR: modpost: "snd_tea575x_init" [sound/pci/snd-fm801.ko] undefined!
>> ERROR: modpost: "snd_tea575x_exit" [sound/pci/snd-fm801.ko] undefined!
>> ERROR: modpost: "snd_tea575x_init" [sound/pci/snd-es1968.ko] undefined!
>> ERROR: modpost: "snd_tea575x_exit" [sound/pci/snd-es1968.ko] undefined!
>> ERROR: modpost: "snd_tea575x_init" [drivers/media/radio/radio-maxiradio.ko] undefined!
>> ERROR: modpost: "snd_tea575x_exit" [drivers/media/radio/radio-maxiradio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
