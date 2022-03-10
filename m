Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAF4D43B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbiCJJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbiCJJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:47:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92C13AA08;
        Thu, 10 Mar 2022 01:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646905613; x=1678441613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b3/fS2yHAqNHl1jboCRu52MjsVGWP5Iqz5RL18JPJbw=;
  b=dV/ul8ePl3mPbMP4AUCHHtL98ECFK95d3xsrsBC5u2MC+4A8DGTcil/c
   rn1V/HBHyqUl7/tLJzRfQZxZKieUB+o/NDQH4Owlvb4LO11gHr23Qi3gE
   UDq96dWT2esoqvTVUHaMfgOesZYKp/eIEICNnR9YuYcM1vxZuR0OmBpDc
   HSTGzUbHZqDolg45lIX/DjM+rXr9aLWaiHhI11VNtsUSkSIm5XsTiXbIw
   wenDieCDJwFvrDcLqCE9IgjR+oBRW/mmkzNMaRTfMy3XFW9wCXhcgpLgp
   1JeStvssveRXBkjNpJgU/1fyKKPddi73VKO78WSLvVBGCn8Ey0hf13nhc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255153144"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="255153144"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 01:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="781400231"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2022 01:46:49 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSFNh-0004ks-66; Thu, 10 Mar 2022 09:46:49 +0000
Date:   Thu, 10 Mar 2022 17:46:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 10/18] ARM: dts: qcom: add saw for l2 cache and
 kraitcc for ipq8064
Message-ID: <202203101733.hkbTGp6Y-lkp@intel.com>
References: <20220309190152.7998-11-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309190152.7998-11-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ansuel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master linus/master v5.17-rc7 next-20220309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ansuel-Smith/Multiple-addition-to-ipq8064-dtsi/20220310-031750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220310/202203101733.hkbTGp6Y-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/52c3b4af226c7a50772c40012b3789b5348e49b5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ansuel-Smith/Multiple-addition-to-ipq8064-dtsi/20220310-031750
        git checkout 52c3b4af226c7a50772c40012b3789b5348e49b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
