Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635D6496B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiAVIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:53:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:24299 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbiAVIxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642841610; x=1674377610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvnk/x/WTDcjZ8a7QWLw+S3Fy/cMiGNI0U5gn7a9HyA=;
  b=ZwHp/oc1yFM1UzLx2nYdNV5+UgUnu6qqGC7WtREaJu5psPanmAmDxoEr
   DvO9SVJz4V2VwGO31ODR1r1vIL9XOJpeBQYacd5+xwmsV+DiLT8J8IR9N
   0m1MqRDasiJ6cK4HvQV6PpgvlamoVNgHcdGeVzDN/urW3ZoOan1KW0PnI
   /XoRY3EHhGwUI6WmfqsTImdsOdbboKrsudiYsc8xyxViEW4Gdp1oRLNKs
   3WPGolY3LZhR4UA1rJV7/H5zdN7G/Wdrzl25oZqtXTN6DTr1fZY97+Xev
   TVeZ3rFeSHaPf+qypOjEkMvU+rQ/x12VpDLWQIoUB9AhtqoKOytIS/aOL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="309133211"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="309133211"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 00:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="531624385"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2022 00:53:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBC9H-000GEZ-BN; Sat, 22 Jan 2022 08:53:27 +0000
Date:   Sat, 22 Jan 2022 16:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Add ufs power-domain entries
Message-ID: <202201221606.gzXiP4VV-lkp@intel.com>
References: <20220120082803.15535-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120082803.15535-1-bhupesh.sharma@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bhupesh-Sharma/arm64-dts-qcom-sm8150-Add-ufs-power-domain-entries/20220120-162925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-s032-20220117 (https://download.01.org/0day-ci/archive/20220122/202201221606.gzXiP4VV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e9cea3a4d3c4706f9cef18f55b07d3bc389a051a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bhupesh-Sharma/arm64-dts-qcom-sm8150-Add-ufs-power-domain-entries/20220120-162925
        git checkout e9cea3a4d3c4706f9cef18f55b07d3bc389a051a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sm8150.dtsi:1641.26-27 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
