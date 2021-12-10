Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14DB470169
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhLJNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:21:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:46709 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232766AbhLJNVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639142287; x=1670678287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qXHvPl8EYFw0cPEWr70eCPt4Cnru/82z4dlUye24+6c=;
  b=Gvlzbq2bjkXaqi2+6oSw68jDGCvNhnLPThUgZDZIgTgeWep/r2daE1nT
   mYFWn0vE+Mcamkk8ZVm7H7Y0s9GT2og3jjAB8c3jxZOpo68uNYoyBq1On
   plpAhyM1YYvkvVgUWx0zpS4k9tKPbnUV/rWeezsFDF0DryZBHn+GgAdXf
   uRFgdSGdGfXZNZggQ2LSqDUQHkTuqtqPk8jAR1wrQEawR10kLWSf6Ov74
   DhzxFQi2b7D89ESb5mF/4wdI2QlWBfopkdtM4iV33vXFqvC9shnDXZQMF
   k3yA32FdQCczXSUyjXvdZ9vJN4PnibXr5qP/nKemxDpOIr1vYosxu28kj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238567132"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238567132"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 05:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="612926658"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2021 05:18:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvfmm-0003EK-H2; Fri, 10 Dec 2021 13:18:04 +0000
Date:   Fri, 10 Dec 2021 21:17:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:ata-trace.v4 16/68] drivers/ata/sata_mv.c:1276:30:
 warning: 'dw' is used uninitialized
Message-ID: <202112102158.vl74bmsi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git ata-trace.v4
head:   543d0f43ed9c7b04ab463b52f2e59fd406b4bde8
commit: f3e85aba1ba67f2efcc34413ed9546be69229179 [16/68] sata_mv: replace DPRINTK with dynamic debugging
config: m68k-randconfig-r006-20211210 (https://download.01.org/0day-ci/archive/20211210/202112102158.vl74bmsi-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=f3e85aba1ba67f2efcc34413ed9546be69229179
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel ata-trace.v4
        git checkout f3e85aba1ba67f2efcc34413ed9546be69229179
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/sata_mv.c:790:35: warning: 'mv_pci_tbl' defined but not used [-Wunused-const-variable=]
     790 | static const struct pci_device_id mv_pci_tbl[] = {
         |                                   ^~~~~~~~~~
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
