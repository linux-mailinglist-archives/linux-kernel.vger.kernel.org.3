Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF34F0D57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358670AbiDDBMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 21:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352019AbiDDBMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 21:12:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865D332EFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 18:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649034652; x=1680570652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xwJpgPcOcKsEY1jrTsJv5dBIBNxu+5Kn3H+XzfONfdo=;
  b=Pjh/eAbIqkKymBePntpmbsqOCwH/C3HWVq3JQcwC8o4vG7CkrUTi9ljl
   mO9aP1Gx3aHfxMpDHG0zVcmGqyYNnAkepj5GcKpL+a3d+vL/iCJSm5M7i
   VVi769Hp8JLSvHKTxfwuHiWmgVI/gLtG+znPWpF+8IwRZVYz5rU+cHyyY
   DKyvgz5lzG86Zjt98vUocVAnP81uvrmz2R0gEEbG0jxcQWeq6xCv8JxE2
   FoSpy93i4uRAXaTnrUh4h3Ow37gAgzhHICFPdVRYTopVxk0PuUpOQhxqz
   egiJhs28+qjOmxos8sMLf9MsaBf/5qaV4pz6ndS1AQ+/va1swUB+oWicE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323595125"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="323595125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 18:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="522808462"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2022 18:10:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbBF4-0001Kd-9K;
        Mon, 04 Apr 2022 01:10:50 +0000
Date:   Mon, 4 Apr 2022 09:09:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:bp/bp/test 21/23] drivers/edac/ghes_edac.c:18:10:
 fatal error: asm/mce.h: No such file or directory
Message-ID: <202204040936.kxNxgvNn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bp/bp/test
head:   aff0e90f2a981e0350187c8a931071d7f35df6e5
commit: ef3a8acde71eb676a92d9f3158d7f112061e2bf9 [21/23] ghes_edac: Convert MCE to its representation
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220404/202204040936.kxNxgvNn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ef3a8acde71eb676a92d9f3158d7f112061e2bf9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bp/bp/test
        git checkout ef3a8acde71eb676a92d9f3158d7f112061e2bf9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/edac/ghes_edac.c:18:10: fatal error: asm/mce.h: No such file or directory
      18 | #include <asm/mce.h>
         |          ^~~~~~~~~~~
   compilation terminated.


vim +18 drivers/edac/ghes_edac.c

    17	
  > 18	#include <asm/mce.h>
    19	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
