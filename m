Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412958C822
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiHHMH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHHMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:07:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4825CF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659960445; x=1691496445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qlzPcIpwo1Gd5Q00tnfHVO5N+S6w3G0CLHMv1RMiWwI=;
  b=oAFjOQSxAjqwTKKv4w0mVmvOnMA8VdP4AhgZCtNl7dPTiGEqUKR/Gkth
   GZ+81DHfPD0igzbOk8ldwvSHabAXHf9BE7fSQmKd4KbqhJWCLJ1Dyx6lb
   Z1eGh1Gij8Iib7NCumAATxbqMZCw6hB/99wI6AzbwDILwikhl/NkfjGFT
   hj5HP0NfaXK2nHyUboK8PODjb0TBfsvC13kOTx6Ke7HBm1bTGfPPWfNBr
   lx0KWGR+bmY+yJC56UGNKWB/X7gWWHQKZhp1Exqgx+VBQaBZlDFCTXwoJ
   Xaql7kUFPH28CplZoxl5uGzmHKo+NPI174tF2lRK42QccSe5uIfrWyz86
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="273623586"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="273623586"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="693731680"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2022 05:07:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oL1XX-000MGg-0N;
        Mon, 08 Aug 2022 12:07:23 +0000
Date:   Mon, 8 Aug 2022 20:07:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 9/9] objdump:
 'arch/x86/entry/vdso/vdsox32.so.dbg': No such file
Message-ID: <202208081950.O1OI4l9B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   29d7baa1e13b4304df93126e0c8baf56584b720a
commit: 29d7baa1e13b4304df93126e0c8baf56584b720a [9/9] random: implement getrandom() in vDSO
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220808/202208081950.O1OI4l9B-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/29d7baa1e13b4304df93126e0c8baf56584b720a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 29d7baa1e13b4304df93126e0c8baf56584b720a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/entry/vdso/vgetrandom-x32.o: warning: relocation against `__memset' in read-only section `.text'
   ld: arch/x86/entry/vdso/vgetrandom-x32.o: relocation R_X86_64_PC32 against undefined symbol `__memset' can not be used when making a shared object; recompile with -fPIC
   ld: final link failed: bad value
>> objdump: 'arch/x86/entry/vdso/vdsox32.so.dbg': No such file
--
>> objcopy: 'arch/x86/entry/vdso/vdsox32.so.dbg': No such file

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
