Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC6524F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355019AbiELOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355106AbiELOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:06:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33BB20BF6;
        Thu, 12 May 2022 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652364389; x=1683900389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WIvtdmWtX/TRORt8dlpmlTRf4eOZvfVee018Zhu+TL0=;
  b=hiZBSyl4vpPMMH4iv4Hi9OB4Hdv/g6vPOgI3YDVPeyMEYu97jJ84pXSe
   P9lfYiGPIPNBuzIZj5uC1DwY/zr6Hm9ZdMTwF6NJqvj5fGaS32UbmtQra
   XKcHny5os1JbV0JGvtKiFP1gkeyPkh6PkOfwD8j6OiKcTkqdCs91ve49k
   lSPGbWF9kOkeTOGCVrdbvaNQINPGzbdW4S3zDxr5wXe1s7mvsl80M9R1M
   AoOr0UQPXvGKBwQLxe37k6fUXZ04Npn1bXEyKpCu0i32baSQFzylVBgyQ
   RJeoV836jtBgflJ8cVV74u4gQPXUUFnZImnH/oF7MAl0C9kDzr16JL0su
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="333046938"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="333046938"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="698042755"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2022 07:06:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np9SV-000KYY-0J;
        Thu, 12 May 2022 14:06:27 +0000
Date:   Thu, 12 May 2022 22:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: drivers/media/dvb-frontends/mn88443x.c:772:34: warning:
 'mn88443x_of_match' defined but not used
Message-ID: <202205122148.yhQVSpac-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 8169cf0a02caafd87ee33e66c12f7a35606a6b0c media: Kconfig: allow to select drivers if EMBEDDED
date:   3 years ago
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220512/202205122148.yhQVSpac-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8169cf0a02caafd87ee33e66c12f7a35606a6b0c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8169cf0a02caafd87ee33e66c12f7a35606a6b0c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/dvb-frontends/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/dvb-frontends/mn88443x.c:772:34: warning: 'mn88443x_of_match' defined but not used [-Wunused-const-variable=]
     772 | static const struct of_device_id mn88443x_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/mn88443x_of_match +772 drivers/media/dvb-frontends/mn88443x.c

0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  771  
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23 @772  static const struct of_device_id mn88443x_of_match[] = {
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  773  	{ .compatible = "socionext,mn884433",   .data = &mn88443x_spec_pri, },
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  774  	{ .compatible = "socionext,mn884434-0", .data = &mn88443x_spec_pri, },
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  775  	{ .compatible = "socionext,mn884434-1", .data = &mn88443x_spec_sec, },
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  776  	{}
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  777  };
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  778  MODULE_DEVICE_TABLE(of, mn88443x_of_match);
0f408ce8941fcb Katsuhiro Suzuki 2018-07-23  779  

:::::: The code at line 772 was first introduced by commit
:::::: 0f408ce8941fcb1b6e8431272cfc9337a0407d73 media: dvb-frontends: add Socionext MN88443x ISDB-S/T demodulator driver

:::::: TO: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
