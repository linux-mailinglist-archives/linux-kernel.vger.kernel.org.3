Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8D4FC5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiDKU1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349835AbiDKU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:27:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF2135279
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649708692; x=1681244692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=syH9JsSzCccvhJXz8TVfq3s9PNPamTCt5pF7QgomxLA=;
  b=OeDYak59enCSRsenQPv1F334iAV0JYjMRYcmm5Px8f7dm4aFqnfFCNcJ
   kgn+hhTjKJVl+FVzYI6nww75fsLY1nqsKb0VbM2GKfe7CqVnVkQG5a+zI
   TtP5ZdUW6drL9ekLQk7qmwBnErHjkh8hWvZZVI+hw0JnKbtTD/P1cy4IW
   YKUUTWRjBqVF5el0nMiVfIVQirjso0M0uwuosbcAgL7kE5Smil9pjGeJv
   82E1uWM3jglFSKOeDeg3tuB3YY6D1GvjoeRY7ULFRLPmnjlStpiI6HvFF
   BVqdxOXPidm61h+R942CYZAspC5DdYttqMQs6Ciexh4hQMFUgvTQvCZ0k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262388062"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="262388062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 13:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="699529885"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2022 13:24:51 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne0ag-0002At-QI;
        Mon, 11 Apr 2022 20:24:50 +0000
Date:   Tue, 12 Apr 2022 04:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/not-zero-entropy 7/13] ERROR:
 modpost: "ktime_read_raw_clock" [crypto/jitterentropy_rng.ko] undefined!
Message-ID: <202204120347.OQMfBPhq-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/not-zero-entropy
head:   5130a7ce631b0b5722f47cfd764ebbc1ed2162c5
commit: 785ee13e78aa59b5fa183c155a06a54b423e01c7 [7/13] mips: use ktime_read_raw_clock() for random_get_entropy() instead of zero
config: mips-decstation_64_defconfig (https://download.01.org/0day-ci/archive/20220412/202204120347.OQMfBPhq-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/785ee13e78aa59b5fa183c155a06a54b423e01c7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/not-zero-entropy
        git checkout 785ee13e78aa59b5fa183c155a06a54b423e01c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ktime_read_raw_clock" [crypto/jitterentropy_rng.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
