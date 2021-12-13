Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6978147375C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhLMWUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:20:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:44247 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234248AbhLMWUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639434001; x=1670970001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=25LnXLFBNAzdIdsGaedgO/MOemGjMewOSPDf95WXR4k=;
  b=lZKEvfFv20f1xL/utAFVzakMoNXmwFcBlbkWRgFj4/zXbGIc7/lj+sGO
   r8ULeJz/7+SM9+YFxKpYIj5So2YoWAj0C9FqdWt7S2g4pKQYUt0SSo5T8
   hErzAOn5RDZBhHibVzBx5+Eh3GMzAJbM/SCCq4B3FJGV76snK+e1HgmZk
   gflPBuNSy8caRCmd1n9FbN4hqWWd5gvwsiGJRe2oiia2owho7CaO2dJlW
   8pJfZU1jDrP7WzKBGAnkrw+WDCw7p8IeV5w5wPOM8BdpmLGwHsrNrLsOR
   cGewocJOpW8E1PlLDGv+EPnhOww9AMUF96wv5VYVMGdOiEbEB/3FyAgBz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226120379"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="226120379"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:20:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505099393"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 14:19:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwtfp-00077d-Ix; Mon, 13 Dec 2021 22:19:57 +0000
Date:   Tue, 14 Dec 2021 06:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/imx_rproc.c:413:17: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202112140608.W1hmJ3JS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2585cf9dfaaddf00b069673f27bb3f8530e2039c
commit: 5e4c1243071d29ed5511121d044116b942ba6a7b remoteproc: imx_rproc: support remote cores booted before Linux Kernel
date:   8 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211214/202112140608.W1hmJ3JS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5e4c1243071d29ed5511121d044116b942ba6a7b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5e4c1243071d29ed5511121d044116b942ba6a7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/tegra/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/imx_rproc.c:299:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/imx_rproc.c:299:12: sparse:     expected void *va
   drivers/remoteproc/imx_rproc.c:299:12: sparse:     got void [noderef] __iomem *
   drivers/remoteproc/imx_rproc.c:316:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *va @@
   drivers/remoteproc/imx_rproc.c:316:20: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/remoteproc/imx_rproc.c:316:20: sparse:     got void *va
>> drivers/remoteproc/imx_rproc.c:413:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +413 drivers/remoteproc/imx_rproc.c

   403	
   404	static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
   405	{
   406		struct imx_rproc *priv = rproc->priv;
   407	
   408		/* The resource table has already been mapped in imx_rproc_addr_init */
   409		if (!priv->rsc_table)
   410			return NULL;
   411	
   412		*table_sz = SZ_1K;
 > 413		return (struct resource_table *)priv->rsc_table;
   414	}
   415	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
