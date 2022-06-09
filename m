Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E19454547F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiFIS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiFIS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:56:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FA4F9FC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654801007; x=1686337007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XlQtuHTcmlmO6Lz07Qt9urDkSFiz1K0wIvZltBOCdsY=;
  b=Y5neSEnfyaxmE5KRAa9zGvo1c9vStKq8ms3EnhLc6Mqx2/uWCr1liJQX
   3wSazeV7kFQmI3fB0vl+UGVrz6fZpyHR7OT+Ylk/1bB9AlfYqi6n4G4oQ
   BbbQgsnCzUmKRXcbV9WmV28ysWmwpUShPzGA7POXvShiQm6GY9d4vILSf
   ncf6S7cA+qtHjzwdMiIYrNk8QprCgqqM2JGrOkKZYZZommFfaaMZeZruQ
   SIkgKyxtr/Xxyj34s8SOKFTA/qnziEdnJl8jAjPwXN1C8F4WLBS4rLGbK
   CaJK5v0XOU089vsLPOxN/QgFOMbP1SagDyXsABDoI+ZBEg73WyYMDU64X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278530554"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278530554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 11:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585743490"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 11:56:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzNKn-000GHp-6C;
        Thu, 09 Jun 2022 18:56:45 +0000
Date:   Fri, 10 Jun 2022 02:56:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/test/ctl-xarray 8/8] ERROR: modpost:
 "xa_store_range" [sound/core/snd.ko] undefined!
Message-ID: <202206100253.iaeKg9sp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/test/ctl-xarray
head:   2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
commit: 2abf12b6cfb00c1904dc99425ad19a6c03a1fef3 [8/8] ALSA: control: Use xarray for faster lookups
config: m68k-randconfig-r014-20220608 (https://download.01.org/0day-ci/archive/20220610/202206100253.iaeKg9sp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/test/ctl-xarray
        git checkout 2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xa_store_range" [sound/core/snd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
