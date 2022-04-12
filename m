Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28574FE674
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357938AbiDLRDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357919AbiDLRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:03:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340C5C647;
        Tue, 12 Apr 2022 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649782866; x=1681318866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jgwijNu2ZezTRwUgeRa68DVn7L7cEW8MPUo/U76CR2Y=;
  b=GZyCu0mxo97UI/ZjTKcMjJYXRPzz55+qogA8jocOLJN1C6moYGv0LQ6m
   G6X0UB53PSfh0MxBIWX9oijJAa1J7lI8zH+rXZ1WUK//eoU5K9VDAMZV/
   05uxYKsb1D5TaOFsJBthHmZraseLKqNyN7pQzPoaGQYKEjiCfBSvYxU2B
   C3wTgaQw4ecF0vzYU43LXVPu1AQDuS1JMrnrem2tWjjUOXn8NpFZnHOw4
   oujkzRQ2V2bsCWXSiHzQZCcMJipbGw903keajfiareg9+1ZPETw4Em67t
   BTXRqeEEsYNewyrXcq4caEZGi+sxm+iSisG99q4tQ2WEFJwic3s3ha6ru
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244323955"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="244323955"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="644824295"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 10:00:40 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neJse-00030y-1Q;
        Tue, 12 Apr 2022 17:00:40 +0000
Date:   Wed, 13 Apr 2022 01:00:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     kbuild-all@lists.01.org, j-keerthy@ti.com,
        linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Message-ID: <202204130043.PiaWoNtR-lkp@intel.com>
References: <20220412101409.7980-5-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412101409.7980-5-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keerthy,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on rafael-pm/thermal v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Keerthy/thermal-k3_j72xx_bandgap-Add-the-bandgap-driver-support/20220412-193526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: microblaze-buildonly-randconfig-r002-20220411 (https://download.01.org/0day-ci/archive/20220413/202204130043.PiaWoNtR-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de47884b9759d99f1971558a45283b912efbf22a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keerthy/thermal-k3_j72xx_bandgap-Add-the-bandgap-driver-support/20220412-193526
        git checkout de47884b9759d99f1971558a45283b912efbf22a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/thermal/k3_j72xx_bandgap.o: in function `init_table':
>> .tmp_gl_k3_j72xx_bandgap.o:(.text+0x69c): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
