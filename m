Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B897545663
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiFIVTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFIVTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:19:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF195DF3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654809591; x=1686345591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gfyhXXo27GkQGMxpWCd1bH5lESB+He+9oYSHM0JWOqg=;
  b=DAplvBRxB568yidd5cljGvdHwIym8vdNcfSLW4YFkZldM7jv8/XTDAoZ
   TX2PBBHit7cdWhKQ5PSbvrHM06DZgHpnoNrm6R3lijQjfwI2Bl3Kujqb7
   RGb7y8VDpkr0pI+unVVdOI7rgC2Zy5PfFaexKDj/uyke/ABNjwVUMkCru
   Oj8li5TwuQznKZh5a1aVjtWFg1yL1743T60LxLXEawhTAjGS7wdlQhLUf
   pqNdGuNzA8jMLLbud1pc25k7CymKsPVIiC5lpKNqWjCqRRNiQNFp2MuDf
   zaBRwaao7Nk9AM8hx6zoUWQskyi5B0kRmJp3GFWm89ElmWaNhfip6C6DH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277452137"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="277452137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 14:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="908539139"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2022 14:19:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzPZF-000GOy-8c;
        Thu, 09 Jun 2022 21:19:49 +0000
Date:   Fri, 10 Jun 2022 05:19:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/test/ctl-xarray 8/8] ERROR: modpost:
 "xa_store_range" [sound/core/snd.ko] undefined!
Message-ID: <202206100538.Gz40sURP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: hexagon-randconfig-r041-20220609 (https://download.01.org/0day-ci/archive/20220610/202206100538.Gz40sURP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/test/ctl-xarray
        git checkout 2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xa_store_range" [sound/core/snd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
