Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A590F52FC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiEUMip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiEUMin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:38:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E604B878;
        Sat, 21 May 2022 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653136722; x=1684672722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IyTRlf+BZEOiH+hxY/98sq/q/v9Xw3LX1jAeSkinu6s=;
  b=HqZgDv7+3xqxYKBDKusjkKnju2h6Ys0e+dZkvW7pVjR2Ittud8PxMwXQ
   Kstf4O4EU/xp0QcRekxzjNxxqohGkVq9fDWdFFWHSwn5zoCG392b8TyK2
   xohurPx72T0XSS76OB82wMFQlrXbdDelP+fEBNjkR3dwdDrInh//GJ1Cs
   d8aEsJRjBHxFYz5Xc9YNPA8I0dD88HbF6nn46xOAOpzEocmwttWLX92yq
   UU3NgspBvoqOxwXeS21m1LLkaiyX1paibkAeTvle4fUveJya+ll2/BEpG
   kogJBeZO2gpgtX3hAoe68MIEVDm/jDJmP9u2SYUkyf1OOAAl5QzyTxzi0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298162701"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="298162701"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 05:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="702190401"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 May 2022 05:38:40 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsONT-0006IU-Fz;
        Sat, 21 May 2022 12:38:39 +0000
Date:   Sat, 21 May 2022 20:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Wang <David_Wang6097@jabil.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, edward_chen@jabil.com,
        David_Wang6097@jabil.com
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Message-ID: <202205212020.z9X7PjMn-lkp@intel.com>
References: <20220520120212.3589911-1-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520120212.3589911-1-David_Wang6097@jabil.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on soc/for-next linus/master v5.18-rc7]
[cannot apply to joel-aspeed/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wang/ARM-dts-aspeed-Adding-Jabil-Rubypass-BMC/20220520-200353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3d7285a335edaf23b699e87c528cf0b0070e3293
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220521/202205212020.z9X7PjMn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c8cda754bc90e31e4f419ddb60cfbedecb9e022d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Wang/ARM-dts-aspeed-Adding-Jabil-Rubypass-BMC/20220520-200353
        git checkout c8cda754bc90e31e4f419ddb60cfbedecb9e022d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts:425.1-5 Label or path gfx not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
