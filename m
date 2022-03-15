Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1F4D9CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiCON6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348924AbiCON6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:58:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A2653E0F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647352620; x=1678888620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I8Gt8y0vsmRDtxHhIYuOjDGSdsVYVup+8tVe/S4t024=;
  b=BBObsAkyYmn7BEGszk3X0fVod6VP8lveY0leg5emz4aHIjOE8mcfftcT
   H0M6THeIErSH/q2mDWSL+j4/xBsJTOVxd1bOAyBoDhaOTjxMZsJO5j1Q7
   NLhkRkuL8XF7aQo0ZKUvb7dzozPrJYo0Usw++jt3qhcRnV5lB8Q31S713
   k4DD9CeZfOPevpFRTXU8g9d2d8wJtjJ3Y9ZnKeMbaKWS9IOUBYbi46Us9
   jpnY382qb6yRzWarv3EDhhetxH/m7BYaASP8XufnWviZDorDj4/W87wfI
   zu6EB8LkBDadloCHJh2Svs3iPZZD4+NMQIOgAHYD13clQRhbIq/Ml8nDR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236252540"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="236252540"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="498021669"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2022 06:56:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU7fT-000B4B-Eq; Tue, 15 Mar 2022 13:56:55 +0000
Date:   Tue, 15 Mar 2022 21:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>, broonie@kernel.org,
        tiwai@suse.com, arnaud.pouliquen@st.com
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH] ASoC: sti: sti_uniperif: Remove driver
Message-ID: <202203152111.fltopk2x-lkp@intel.com>
References: <20220315091319.3351522-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315091319.3351522-1-daniel@0x0f.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc8 next-20220310]
[cannot apply to broonie-sound/for-next tiwai-sound/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Palmer/ASoC-sti-sti_uniperif-Remove-driver/20220315-171525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
config: x86_64-rhel-8.3-kselftests
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/7970e4bb3de4ff810c1dafb8ac38d222d90ca071
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Palmer/ASoC-sti-sti_uniperif-Remove-driver/20220315-171525
        git checkout 7970e4bb3de4ff810c1dafb8ac38d222d90ca071
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 distclean

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> scripts/Makefile.clean:15: sound/soc/sti/Makefile: No such file or directory
>> make[4]: *** No rule to make target 'sound/soc/sti/Makefile'.
   make[4]: Failed to remake makefile 'sound/soc/sti/Makefile'.
   make[3]: *** [scripts/Makefile.clean:68: sound/soc/sti] Error 2
   make[3]: Target '__clean' not remade because of errors.
   make[2]: *** [scripts/Makefile.clean:68: sound/soc] Error 2
   make[2]: Target '__clean' not remade because of errors.
   make[1]: *** [Makefile:1838: _clean_sound] Error 2
   make[1]: Target 'distclean' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'distclean' not remade because of errors.
--
>> sound/soc/Kconfig:86: can't open file "sound/soc/sti/Kconfig"
   make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[1]: *** [Makefile:619: oldconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> sound/soc/Kconfig:86: can't open file "sound/soc/sti/Kconfig"
   make[2]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[1]: *** [Makefile:619: olddefconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +15 scripts/Makefile.clean

2315c6e42278152 Sam Ravnborg   2005-07-25  12  
2a691470345a002 Sam Ravnborg   2005-07-25  13  # The filename Kbuild has precedence over Makefile
db8c1a7b2ca25f3 Sam Ravnborg   2005-07-27  14  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
db8c1a7b2ca25f3 Sam Ravnborg   2005-07-27 @15  include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
^1da177e4c3f415 Linus Torvalds 2005-04-16  16  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
