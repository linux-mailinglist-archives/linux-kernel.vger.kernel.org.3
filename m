Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA885ABB0E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiIBXLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:11:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D1BF47D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662160290; x=1693696290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bs2N+4jA8VNqEDPs2v0c4mrKLHEnEKpC+6QMV8EQT10=;
  b=BEiOWHwLNkJzIjlJ3A8lHCugiUKik97d8RFXL8L3q0n3XQTTIZgxQn+j
   gZLLzEfDO12SadFp50wr7MBGOl1V1HSf07nQorVlfdg/fcypM1QWLgBkI
   YvoNwHHV8zLMMuDB9hwclAAc+W56jOed3aQQfguDPXzG3Lqou0smjeBuK
   8RabGqAe2GO+zG2W/p5G3Ti+ftE+C0W0BWoDBxHcAp3t4NNOx4LZpszcu
   rw3hGUSIzYrsfSFRrhohsQomPAhwjXtAjcRh1+F2TbnBu6lKBjzk7zd2W
   tj9FhhsCjAhlxKfWguOlBx+dEnOFzxc17axDySqg/oVrJorNmbw1uVIZU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="294845751"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="294845751"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="941459673"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 16:11:29 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUFou-0000ix-22;
        Fri, 02 Sep 2022 23:11:28 +0000
Date:   Sat, 3 Sep 2022 07:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matt Flax <flatmax@flatmax.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-misc:asoc-6.1 3/80] sound/soc/codecs/src4xxx-i2c.c:28:34:
 warning: unused variable 'src4xxx_of_match'
Message-ID: <202209030710.XtZRjxNg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git asoc-6.1
head:   376be51caf8871419bbcbb755e1e615d30dc3153
commit: 4e6bedd3c396014ba70de2b4c9995c8e024e82b3 [3/80] ASoC: codecs: add support for the TI SRC4392 codec
config: hexagon-randconfig-r045-20220903 (https://download.01.org/0day-ci/archive/20220903/202209030710.XtZRjxNg-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=4e6bedd3c396014ba70de2b4c9995c8e024e82b3
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc asoc-6.1
        git checkout 4e6bedd3c396014ba70de2b4c9995c8e024e82b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/src4xxx-i2c.c:28:34: warning: unused variable 'src4xxx_of_match' [-Wunused-const-variable]
   static const struct of_device_id src4xxx_of_match[] = {
                                    ^
   1 warning generated.


vim +/src4xxx_of_match +28 sound/soc/codecs/src4xxx-i2c.c

    27	
  > 28	static const struct of_device_id src4xxx_of_match[] = {
    29		{ .compatible = "ti,src4392", },
    30		{ }
    31	};
    32	MODULE_DEVICE_TABLE(of, src4xxx_of_match);
    33	
    34	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
