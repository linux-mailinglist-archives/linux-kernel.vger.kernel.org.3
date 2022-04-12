Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0274FDFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352828AbiDLMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354707AbiDLMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:10:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099C82D35
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649761947; x=1681297947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jel9Ue/TUnUIFCH7U+XPws+iEu8CN+HTDU/wDhRAkhw=;
  b=mvvEXoEdeBygC2CK9gwz47d9P0whc0zLfwE7rvmUKo2cYZyKu/Bxft+2
   rpdPVeAhKfBAaWEuiyT0DRDKNTKgqY0Z0WPQ9Xpb9hE5bfinRMlQEij0c
   tSNun0u/FZhT1PDa3c9ddKhHZ+JyveTGZzNu7s10xH1vSpgCCxg/A1mDk
   9kkAWSyL/FvScEfdPeo05DHwmoRZzsCUFuA+gHa1DHeIPGRGfsqapbAd3
   U8eYftrL6hKJvxewAzOTFbCfDIFD9nhggNNY/qCJlDFnpzF1aSfQm2Jzu
   S3izTKN5Cr6qtY88lSrST8KvAt3u1ujKKluR2zBD3rUWRGagcWSK6WV4C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="249632850"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="249632850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724404539"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 04:12:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neERd-0002nY-Ec;
        Tue, 12 Apr 2022 11:12:25 +0000
Date:   Tue, 12 Apr 2022 19:12:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/not-zero-entropy 3/12]
 kernel/time/timekeeping.c:2388: warning: expecting prototype for
 random_read_entropy_fallback(). Prototype was for
 random_get_entropy_fallback() instead
Message-ID: <202204121944.p7MPjuCv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/not-zero-entropy
head:   4ee3bf173a552cd996e048d57f65bb5b471ab577
commit: aeeed98e20910aeafd5db8c56b449810b60bad9f [3/12] timekeeping: add raw clock fallback for random_get_entropy()
config: arc-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121944.p7MPjuCv-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/aeeed98e20910aeafd5db8c56b449810b60bad9f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/not-zero-entropy
        git checkout aeeed98e20910aeafd5db8c56b449810b60bad9f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/timekeeping.c:1684: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * We have three kinds of time sources to use for sleep time
   kernel/time/timekeeping.c:1705: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * 1) can be determined whether to use or not only when doing
>> kernel/time/timekeeping.c:2388: warning: expecting prototype for random_read_entropy_fallback(). Prototype was for random_get_entropy_fallback() instead
   kernel/time/timekeeping.c:2396: warning: Function parameter or member 'txc' not described in 'do_adjtimex'
   kernel/time/timekeeping.c:2462: warning: Function parameter or member 'phase_ts' not described in 'hardpps'
   kernel/time/timekeeping.c:2462: warning: Function parameter or member 'raw_ts' not described in 'hardpps'


vim +2388 kernel/time/timekeeping.c

  2382	
  2383	/**
  2384	 * random_read_entropy_fallback - Returns the raw clock source value,
  2385	 * used by random.c for platforms with no valid random_get_entropy().
  2386	 */
  2387	unsigned long random_get_entropy_fallback(void)
> 2388	{
  2389		return tk_clock_read(&tk_core.timekeeper.tkr_mono);
  2390	}
  2391	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
