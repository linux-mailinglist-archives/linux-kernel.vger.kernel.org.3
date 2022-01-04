Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B848396B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiADAOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:14:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:36992 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbiADAOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641255260; x=1672791260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f5QAmW5KNuY8vCRSecKlyp1tAb1Il+qrWzEZd+yuW7s=;
  b=DDe8Hd6cqImPmYIKJaJYwiIn4vtmH4M0y2gm0IF83YsMOzZnickVW+/w
   yhOFUFmT1sm5E4mgIOfVsSAt4FixA6Z3i4uMMoyKynDTi+sgFFqhApuJC
   Tp/MqHdlgSppGktgA0aM9WrymnzPO74qMNdpPJYpmaaejEZf6s00jl7O9
   CF2WWyFjObEZyXLoeOExXBZGCCFJPzmZn7bmNb+/V5nwGQtYKddYLdYrI
   qiTL7fJP7hrAIJS8XB+evmvNZ+fd04m1l32SJC4/lC+At0VIKtC+lqcyR
   oO6f9oeuYVjI6jDhGgy33ZELE3M96McTxXNMcKtGT/a66yyLRqYNA+E0M
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222125030"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222125030"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 16:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="512250461"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2022 16:14:18 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4XSz-000EVz-U7; Tue, 04 Jan 2022 00:14:17 +0000
Date:   Tue, 4 Jan 2022 08:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.10/sata 1/3]
 drivers/ata/sata_ox810se.c:1588:73: warning: suggest braces around empty
 body in an 'else' statement
Message-ID: <202201040839.msnlcRzd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git oxnas/v5.10/sata
head:   acba9b2498a048f1a89fdac6f661ec263e369e76
commit: 8d1ea2ee9ebf1304bd9c7bc60eb5b04295a89f54 [1/3] ata: Add Oxford Semiconductor OX810SE SATA Controller Support
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220104/202201040839.msnlcRzd-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=8d1ea2ee9ebf1304bd9c7bc60eb5b04295a89f54
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.10/sata
        git checkout 8d1ea2ee9ebf1304bd9c7bc60eb5b04295a89f54
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/sata_ox810se.c:293:6: warning: no previous prototype for 'sata_oxnas_link_write' [-Wmissing-prototypes]
     293 | void sata_oxnas_link_write(struct ata_port *ap, unsigned int link_reg, u32 val)
         |      ^~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:331:5: warning: no previous prototype for 'sata_oxnas_link_read' [-Wmissing-prototypes]
     331 | u32 sata_oxnas_link_read(struct ata_port *ap, unsigned int link_reg)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c: In function 'sata_oxnas_link_read':
   drivers/ata/sata_ox810se.c:351:74: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     351 |                 DPRINTK("link read timed out for port %d\n", ap->port_no);
         |                                                                          ^
   drivers/ata/sata_ox810se.c: At top level:
   drivers/ata/sata_ox810se.c:467:6: warning: no previous prototype for 'sata_oxnas_checkforhotplug' [-Wmissing-prototypes]
     467 | void sata_oxnas_checkforhotplug(struct ata_port *ap)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:704:5: warning: no previous prototype for 'sata_core_has_fast_waiters' [-Wmissing-prototypes]
     704 | int sata_core_has_fast_waiters(struct ata_host *ah)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c: In function 'sata_core_has_fast_waiters':
   drivers/ata/sata_ox810se.c:711:55: error: 'wait_queue_head_t' {aka 'struct wait_queue_head'} has no member named 'task_list'
     711 |         has_waiters = !list_empty(&hd->fast_wait_queue.task_list);
         |                                                       ^
   drivers/ata/sata_ox810se.c: At top level:
   drivers/ata/sata_ox810se.c:718:5: warning: no previous prototype for 'sata_core_has_scsi_waiters' [-Wmissing-prototypes]
     718 | int sata_core_has_scsi_waiters(struct ata_host *ah)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c: In function 'sata_core_has_scsi_waiters':
   drivers/ata/sata_ox810se.c:726:55: error: 'wait_queue_head_t' {aka 'struct wait_queue_head'} has no member named 'task_list'
     726 |                       !list_empty(&hd->scsi_wait_queue.task_list);
         |                                                       ^
   drivers/ata/sata_ox810se.c: In function 'sata_oxnas_clear_reg_access_error':
   drivers/ata/sata_ox810se.c:1043:64: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1043 |                 DPRINTK("register access error didn't clear\n");
         |                                                                ^
   drivers/ata/sata_ox810se.c: At top level:
   drivers/ata/sata_ox810se.c:1136:6: warning: no previous prototype for 'sata_oxnas_freeze_host' [-Wmissing-prototypes]
    1136 | void sata_oxnas_freeze_host(struct ata_port *ap)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1145:6: warning: no previous prototype for 'sata_oxnas_thaw_host' [-Wmissing-prototypes]
    1145 | void sata_oxnas_thaw_host(struct ata_port *ap)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1185:5: warning: no previous prototype for 'sata_oxnas_check_link' [-Wmissing-prototypes]
    1185 | int sata_oxnas_check_link(struct ata_port *ap)
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1315:6: warning: no previous prototype for 'sata_oxnas_qc_finish' [-Wmissing-prototypes]
    1315 | void sata_oxnas_qc_finish(void *dma_async_param)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1545:9: warning: no previous prototype for 'sata_oxnas_init_controller' [-Wmissing-prototypes]
    1545 | int     sata_oxnas_init_controller(struct ata_host *host)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c: In function 'sata_oxnas_port_irq':
   drivers/ata/sata_ox810se.c:1559:32: warning: left shift count >= width of type [-Wshift-count-overflow]
    1559 |         if (ap->qc_active & (1 << ATA_TAG_INTERNAL)) {
         |                                ^~
>> drivers/ata/sata_ox810se.c:1588:73: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    1588 |                         "%d %08x\n", ap->link.active_tag, ap->qc_active);
         |                                                                         ^
   drivers/ata/sata_ox810se.c: At top level:
   drivers/ata/sata_ox810se.c:1648:22: warning: initialized field overwritten [-Woverride-init]
    1648 |         .can_queue = SATA_OXNAS_QUEUE_DEPTH,
         |                      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1648:22: note: (near initialization for 'sata_oxnas_sht.can_queue')
   drivers/ata/sata_ox810se.c:1657:20: error: initialization of 'enum ata_completion_errors (*)(struct ata_queued_cmd *)' from incompatible pointer type 'void (*)(struct ata_queued_cmd *)' [-Werror=incompatible-pointer-types]
    1657 |         .qc_prep = sata_oxnas_qc_prep,
         |                    ^~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1657:20: note: (near initialization for 'sata_oxnas_ops.qc_prep')
   cc1: some warnings being treated as errors


vim +/else +1588 drivers/ata/sata_ox810se.c

  1549	
  1550	/* This port done an interrupt */
  1551	static void sata_oxnas_port_irq(struct ata_port *ap, u32 int_status)
  1552	{
  1553		struct ata_queued_cmd *qc;
  1554		unsigned long flags = 0;
  1555	
  1556		DPRINTK("ENTER port %d irqstatus %x\n", ap->port_no,
  1557			int_status);
  1558	
  1559		if (ap->qc_active & (1 << ATA_TAG_INTERNAL)) {
  1560				qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
  1561				DPRINTK("completing non-ncq cmd\n");
  1562	
  1563				if (qc)
  1564					ata_qc_complete(qc);
  1565	
  1566				return;
  1567		}
  1568	
  1569		qc = ata_qc_from_tag(ap, ap->link.active_tag);
  1570	
  1571	
  1572		/* If there's no command associated with this IRQ, ignore it. We may get
  1573		 * spurious interrupts when cleaning-up after a failed command, ignore
  1574		 * these too.
  1575		 * DMA commands will terminate with DMA callback
  1576		 */
  1577		if (likely(qc) &&
  1578		    !(ata_is_dma(qc->tf.protocol) || ata_is_pio(qc->tf.protocol))) {
  1579			/* get the status before any error cleanup */
  1580			qc->err_mask = ac_err_mask(sata_oxnas_check_status(ap));
  1581			/* tell libata we're done */
  1582			local_irq_save(flags);
  1583			sata_oxnas_irq_clear(ap);
  1584			local_irq_restore(flags);
  1585			ata_qc_complete(qc);
  1586		} else
  1587			VPRINTK("Ignoring interrupt, can't find the command tag="
> 1588				"%d %08x\n", ap->link.active_tag, ap->qc_active);
  1589	
  1590		/* maybe a hotplug event */
  1591		if (unlikely(int_status & INT_LINK_SERROR)) {
  1592			u32 serror;
  1593	
  1594			sata_oxnas_scr_read_port(ap, SCR_ERROR, &serror);
  1595			if (serror & (SERR_DEV_XCHG | SERR_PHYRDY_CHG)) {
  1596				ata_ehi_hotplugged(&ap->link.eh_info);
  1597				ata_port_freeze(ap);
  1598			}
  1599		}
  1600	}
  1601	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
