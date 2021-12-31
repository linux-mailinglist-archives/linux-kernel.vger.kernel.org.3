Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169B5482170
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 03:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbhLaCSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 21:18:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:48391 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhLaCSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640917122; x=1672453122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NR+X/lDxU9ClDHwe9FHHtHQ8Eqv0Pb4+isH42TXyTf8=;
  b=Z8cBkdoTQzLypYGMA8IH0wcn1bNravvP0Gs5CSL9X9R+UUeTirR6Prnt
   lPzz3OEg2+0hXdFtYHSR8bAs3FoWrsawIFukHuUSvYkUQyEXt+Jrmy+yk
   GiBSei108GDCq1nD9RZ2Z8+Qif4sV+AsiNP8ztghCZwamVPNAPsNZI1DG
   WVW6dsGjP4A0UHuowMkGZ3+yvNiqCYrNvxRjvynszNGUVZfaxoWnwcXTC
   pnK1O+QPbC07DCZKIgTf6DS76F3Za9sQ+yRoIBHDkyxn1pe/lrrdkITpE
   r2+DwVCJ0KoM/T1srD6NwnwXGVfBCDsXH6hS4cUhuXkSJdtqemQ+DZjJ3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328095067"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="328095067"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 18:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="468963952"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Dec 2021 18:18:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n37V9-000ArQ-7j; Fri, 31 Dec 2021 02:18:39 +0000
Date:   Fri, 31 Dec 2021 10:17:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [dlemoal-libata:for-5.17-logging 28/79]
 drivers/ata/sata_mv.c:1276:30: warning: 'dw' is used uninitialized
Message-ID: <202112311057.WDs1psTQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git for-5.17-logging
head:   7830f5151b3b153a04daec48653458c9a2db7b16
commit: 8e1aff057cd5a2d00d19754fabf7095ba54a7e91 [28/79] sata_mv: replace DPRINTK with dynamic debugging
config: sparc64-randconfig-r005-20211230 (https://download.01.org/0day-ci/archive/20211231/202112311057.WDs1psTQ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?id=8e1aff057cd5a2d00d19754fabf7095ba54a7e91
        git remote add dlemoal-libata git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
        git fetch --no-tags dlemoal-libata for-5.17-logging
        git checkout 8e1aff057cd5a2d00d19754fabf7095ba54a7e91
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/sata_mv.c: In function 'mv_pci_error':
>> drivers/ata/sata_mv.c:1276:30: warning: 'dw' is used uninitialized [-Wuninitialized]
    1276 |                         o += snprintf(linebuf + o, 38 - o,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1277 |                                       "%08x ", dw);
         |                                       ~~~~~~~~~~~~
   drivers/ata/sata_mv.c:1270:13: note: 'dw' was declared here
    1270 |         u32 dw;
         |             ^~


vim +/dw +1276 drivers/ata/sata_mv.c

  1266	
  1267	static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
  1268	{
  1269		int b, w, o;
  1270		u32 dw;
  1271		unsigned char linebuf[38];
  1272	
  1273		for (b = 0; b < bytes; ) {
  1274			for (w = 0, o = 0; b < bytes && w < 4; w++) {
  1275				(void) pci_read_config_dword(pdev, b, &dw);
> 1276				o += snprintf(linebuf + o, 38 - o,
  1277					      "%08x ", dw);
  1278				b += sizeof(u32);
  1279			}
  1280			dev_dbg(&pdev->dev, "%s: %02x: %s\n",
  1281				__func__, b, linebuf);
  1282		}
  1283	}
  1284	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
