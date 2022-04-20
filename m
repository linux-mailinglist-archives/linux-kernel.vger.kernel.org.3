Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39A0508275
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376314AbiDTHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiDTHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:46:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7313B572;
        Wed, 20 Apr 2022 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650440595; x=1681976595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLZ3Oiyauf4PXpEX5Cd3P8yK2szKUl8ted+JLr34T8s=;
  b=O39xguA1G39ziqlPw8qZTsneBbsU8qMTlnIulZrtmnVnya9eIE68PQpv
   pziHmSpYeSt1b69PSYMfwuSPmNpAVvy05fUbkEpNjWSxqmTNpER958QAv
   Yi8uhO0FiHBjR9Cfwr+E/HBUJiyrdnPADgV4zM1cttE8MLx4hvO8I4b5d
   Rlk0KUhwszqw86W4HdWnOt9miBselBzFDY3ebb+Fd++cqpU2L8GyBLL0O
   JrTfL8x+UTAUKWEOO/oRytulJi3r47MU3IS46LX5ifeyQaQGfqxJ9Dtlh
   MOU9BEjeaTMHPxk9Rx7TKBJafkuM0CKdybJEWGMZIJtos69NwyEiN/OOc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244548604"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="244548604"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 00:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="510453668"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2022 00:43:11 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh4zW-0006jC-Ps;
        Wed, 20 Apr 2022 07:43:10 +0000
Date:   Wed, 20 Apr 2022 15:42:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Finn Thain <fthain@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] [v2] m68k: coldfire: drop ISA_DMA_API support
Message-ID: <202204201546.tAlqEoGg-lkp@intel.com>
References: <20220419132716.1392407-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419132716.1392407-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I love your patch! Yet something to improve:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on tiwai-sound/for-next gerg-m68knommu/for-next v5.18-rc3 next-20220419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/m68k-coldfire-drop-ISA_DMA_API-support/20220419-212846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: m68k-m5307c3_defconfig (https://download.01.org/0day-ci/archive/20220420/202204201546.tAlqEoGg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0adee00b1eb9676cd3c269f898b1fae518d8c9e5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Arnd-Bergmann/m68k-coldfire-drop-ISA_DMA_API-support/20220419-212846
        git checkout 0adee00b1eb9676cd3c269f898b1fae518d8c9e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'arch/m68k/coldfire/dma.o', needed by 'arch/m68k/coldfire/built-in.a'.
   make[3]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
