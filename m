Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1224860C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiAFG6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:58:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:47966 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234429AbiAFG6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641452290; x=1672988290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AEHqqomjTQV/lGD9AxgBebMhzXCcvVwq670GsykmiXY=;
  b=OjoJOu9SsTshSsxcgop5AD1EF9cgBpDPOKZ4OhzkDHpcrdC7DNp+jS0i
   B9MsaHRecQhV1LCNQh5W9RDnTbSsMpPYQSB+S8Q6UpyCuzNIkbT684pxS
   ZH27BRmGfmikNi1hQkrqy8h6XCWTYGtuZM1hgKEHMluUlEaU+2Eqe9z72
   QoxsuvZXH7IJ71gDvuPoxyxppaK6xDJhTySE0WKiDVLvxj6OvNjdk506k
   QjMgghFzs0jISVAwwBjSeIMbDvv2RDT+ns8wg2I9KA40d5dWq2oh5Lg1T
   ODpK5kt++4H1JK4Z3qOPbdKiiNOcH6xXpYls9ig63x2NLO3bj+3IGwJFl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229418986"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="229418986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 22:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="526864268"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 22:58:08 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5Miu-000HQr-3M; Thu, 06 Jan 2022 06:58:08 +0000
Date:   Thu, 6 Jan 2022 14:57:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.10/sata 5/6]
 drivers/ata/sata_ox810se.c:667:9: warning: ISO C90 forbids mixed
 declarations and code
Message-ID: <202201061417.nHB4vUHX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git oxnas/v5.10/sata
head:   d695ac5686438a814b4bb4231a62f5d5155a1ee1
commit: ebe3f0291c0a549cde22525457385054b77afc91 [5/6] fixup! ata: Add Oxford Semiconductor OX810SE SATA Controller Support
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220106/202201061417.nHB4vUHX-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=ebe3f0291c0a549cde22525457385054b77afc91
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.10/sata
        git checkout ebe3f0291c0a549cde22525457385054b77afc91
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/sata_ox810se.c: In function 'ox810sata_check_status':
>> drivers/ata/sata_ox810se.c:667:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     667 |         u32 reg = ox810sata_check_link(priv, ap);
         |         ^~~
   drivers/ata/sata_ox810se.c: At top level:
   drivers/ata/sata_ox810se.c:1599:22: warning: initialized field overwritten [-Woverride-init]
    1599 |         .can_queue = SATA_OXNAS_QUEUE_DEPTH,
         |                      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:1599:22: note: (near initialization for 'ox810sata_sht.can_queue')


vim +667 drivers/ata/sata_ox810se.c

   651	
   652	/*
   653	 * Reads the Status ATA shadow register from hardware. Due to a fault with PIO
   654	 * transfers, it sometimes necessary to mask out the DRQ bit
   655	 * @param ap hardware with the registers in
   656	 * @return The status register
   657	 */
   658	static u8 ox810sata_check_status(struct ata_port *ap)
   659	{
   660		struct ox810sata_port_priv *pd = (struct ox810sata_port_priv *)ap->private_data;
   661		struct ox810sata_host_priv *priv = pd->priv;
   662		u8 status;
   663	
   664		status = ox810sata_ioportraid_read(priv, ap, ORB2) >> 24;
   665	
   666		// check for the drive going missing indicated by SCR status bits 0-3 = 0
 > 667		u32 reg = ox810sata_check_link(priv, ap);
   668	
   669		if (priv->hw_raid_active)
   670			reg |= ox810sata_check_link(priv, ox810sata_other_ap(priv, ap));
   671	
   672		if (!reg)
   673			status |= ATA_DF | ATA_ERR;
   674	
   675		return status;
   676	}
   677	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
