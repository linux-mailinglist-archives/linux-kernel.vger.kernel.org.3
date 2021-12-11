Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6684714AB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhLKQNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:13:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:31870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhLKQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639239227; x=1670775227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KqWvZNOBnx+uP7/9dtWYCK8LN/2Q2B6be9bDofgNsLQ=;
  b=ZI9B2Fr164QOigSowUVE4rK5CamvqKlP9WYbgBX7wpw2y3pCz4wsv8ga
   +hbzBqDb9GOzEEEbcNtANIrLJ1NlpDURIOKLVdhuzhlnuE2i6sq+dlFnC
   LgMJKLlw+NpF3/g9mCcOab1BWG0DOh9p6rKyWuAsEfc/VwxWk5qpGGoiB
   JRYxKClSb8m224U9EHGbCyrr/HdigV4bnXwOdpuv0nN2fzUXihbxEMtge
   ueG7A2Vbhe6WnFWqPdxa4mEFfzqHUlcyUFtrzBgLQDPIrVVIWouPGzJ9S
   tVNUB/1eVJz/SIgtbjW3M6Y3XAYpr96WdO6bRfItFsG0PdIPgJW79cB2/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="219229795"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="219229795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 08:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="464097264"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2021 08:13:45 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw50K-0004nY-JU; Sat, 11 Dec 2021 16:13:44 +0000
Date:   Sun, 12 Dec 2021 00:13:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:ata-trace.v4 26/68]
 drivers/ata/pata_octeon_cf.c:602:30: error: passing argument 1 of
 'trace_ata_bmdma_stop' from incompatible pointer type
Message-ID: <202112120054.E4wkKfKu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git ata-trace.v4
head:   543d0f43ed9c7b04ab463b52f2e59fd406b4bde8
commit: 8ed76dafadec5839199e8defee70cb3f92502818 [26/68] pata_octeon_cf: Drop pointless VPRINTK() calls and convert the remaining one
config: mips-cavium_octeon_defconfig (https://download.01.org/0day-ci/archive/20211212/202112120054.E4wkKfKu-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=8ed76dafadec5839199e8defee70cb3f92502818
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel ata-trace.v4
        git checkout 8ed76dafadec5839199e8defee70cb3f92502818
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ata/pata_octeon_cf.c: In function 'octeon_cf_dma_finished':
>> drivers/ata/pata_octeon_cf.c:602:30: error: passing argument 1 of 'trace_ata_bmdma_stop' from incompatible pointer type [-Werror=incompatible-pointer-types]
     602 |         trace_ata_bmdma_stop(qc, &qc->tf, qc->tag);
         |                              ^~
         |                              |
         |                              struct ata_queued_cmd *
   In file included from include/trace/events/libata.h:10,
                    from drivers/ata/pata_octeon_cf.c:22:
   include/trace/events/libata.h:414:40: note: expected 'struct ata_port *' but argument is of type 'struct ata_queued_cmd *'
     414 |              TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
         |                       ~~~~~~~~~~~~~~~~~^~
   include/linux/tracepoint.h:342:41: note: in definition of macro '__DECLARE_TRACE'
     342 |         static inline void trace_##name(proto)                          \
         |                                         ^~~~~
   include/linux/tracepoint.h:419:31: note: in expansion of macro 'PARAMS'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |                               ^~~~~~
   include/linux/tracepoint.h:542:9: note: in expansion of macro 'DECLARE_TRACE'
     542 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/linux/tracepoint.h:542:29: note: in expansion of macro 'PARAMS'
     542 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                             ^~~~~~
   include/trace/events/libata.h:413:1: note: in expansion of macro 'DEFINE_EVENT'
     413 | DEFINE_EVENT(ata_exec_command_template, ata_bmdma_stop,
         | ^~~~~~~~~~~~
   include/trace/events/libata.h:414:14: note: in expansion of macro 'TP_PROTO'
     414 |              TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
         |              ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/trace_ata_bmdma_stop +602 drivers/ata/pata_octeon_cf.c

   586	
   587	/**
   588	 *
   589	 *	LOCKING:
   590	 *	spin_lock_irqsave(host lock)
   591	 *
   592	 */
   593	static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
   594						struct ata_queued_cmd *qc)
   595	{
   596		struct ata_eh_info *ehi = &ap->link.eh_info;
   597		struct octeon_cf_port *cf_port = ap->private_data;
   598		union cvmx_mio_boot_dma_cfgx dma_cfg;
   599		union cvmx_mio_boot_dma_intx dma_int;
   600		u8 status;
   601	
 > 602		trace_ata_bmdma_stop(qc, &qc->tf, qc->tag);
   603	
   604		if (ap->hsm_task_state != HSM_ST_LAST)
   605			return 0;
   606	
   607		dma_cfg.u64 = cvmx_read_csr(cf_port->dma_base + DMA_CFG);
   608		if (dma_cfg.s.size != 0xfffff) {
   609			/* Error, the transfer was not complete.  */
   610			qc->err_mask |= AC_ERR_HOST_BUS;
   611			ap->hsm_task_state = HSM_ST_ERR;
   612		}
   613	
   614		/* Stop and clear the dma engine.  */
   615		dma_cfg.u64 = 0;
   616		dma_cfg.s.size = -1;
   617		cvmx_write_csr(cf_port->dma_base + DMA_CFG, dma_cfg.u64);
   618	
   619		/* Disable the interrupt.  */
   620		dma_int.u64 = 0;
   621		cvmx_write_csr(cf_port->dma_base + DMA_INT_EN, dma_int.u64);
   622	
   623		/* Clear the DMA complete status */
   624		dma_int.s.done = 1;
   625		cvmx_write_csr(cf_port->dma_base + DMA_INT, dma_int.u64);
   626	
   627		status = ap->ops->sff_check_status(ap);
   628	
   629		ata_sff_hsm_move(ap, qc, status, 0);
   630	
   631		if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA))
   632			ata_ehi_push_desc(ehi, "DMA stat 0x%x", status);
   633	
   634		return 1;
   635	}
   636	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
