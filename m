Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643394AD126
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiBHFkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiBHFkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:40:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631DC03FEC1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644298818; x=1675834818;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p7wGE0HhuG34EzELTglILtSKY9i/XaqQsSZ4NDo5Owg=;
  b=SM/gmotNDot8qyHY0KJanU+kl2/ahhUkyrb79cmviN6jspOkp60SJAwU
   97qzzbICL3ZhsNnHEqmp4SfVNHBeLfH+xvBRczMsfe3kq6k4rfljDNWTQ
   dy9EZw1OuIfrdfJRT0QXUDBg/D2wnNcwlSeNj/nip6BOFDEO+WA9mB1bn
   U7awVGO1prhvsKT1MzfidekRZoWd289BuvvzsHO0Z8775CF6aMYbIPjgP
   qjfB1Hj2wY/gt2m1kke2x2TXIizZOEIy1dKMMW19rHMz/HbHKn6NOrRdc
   7mETtDnC41r/8bf4e7EFpgrNL9UZFPRvKXbpMYYC4kuzBGcbWJ2La3yz/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229525658"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229525658"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 21:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="567735845"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 21:40:16 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHJEd-0001PW-Mr; Tue, 08 Feb 2022 05:40:15 +0000
Date:   Tue, 8 Feb 2022 13:39:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: drivers/ata/sata_fsl.c:335:6: warning: %d in format string (no. 1)
 requires 'int *' but the argument type is 'unsigned int *'.
 [invalidScanfArgType_int]
Message-ID: <202202081300.g4MmMWrY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   555f3d7be91a873114c9656069f1a9fa476ec41a
commit: 87924c5b4094f195507bebcab96e141e48c947d7 ata: sata_fsl: add compile test support
date:   5 weeks ago
compiler: powerpc-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/ata/sata_fsl.c:335:6: warning: %d in format string (no. 1) requires 'int *' but the argument type is 'unsigned int *'. [invalidScanfArgType_int]
    if (sscanf(buf, "%d%d",
        ^
   drivers/ata/sata_fsl.c:335:6: warning: %d in format string (no. 2) requires 'int *' but the argument type is 'unsigned int *'. [invalidScanfArgType_int]
    if (sscanf(buf, "%d%d",
        ^
   drivers/ata/sata_fsl.c:376:6: warning: %d in format string (no. 1) requires 'int *' but the argument type is 'unsigned int *'. [invalidScanfArgType_int]
    if (sscanf(buf, "%d", &rx_watermark) != 1) {
        ^

vim +335 drivers/ata/sata_fsl.c

6b4b8fc87dc5cbf Qiang Liu 2012-02-15  328  
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  329  static ssize_t fsl_sata_intr_coalescing_store(struct device *dev,
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  330  		struct device_attribute *attr,
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  331  		const char *buf, size_t count)
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  332  {
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  333  	unsigned int coalescing_count,	coalescing_ticks;
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  334  
6b4b8fc87dc5cbf Qiang Liu 2012-02-15 @335  	if (sscanf(buf, "%d%d",
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  336  				&coalescing_count,
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  337  				&coalescing_ticks) != 2) {
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  338  		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  339  		return -EINVAL;
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  340  	}
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  341  
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  342  	fsl_sata_set_irq_coalescing(dev_get_drvdata(dev),
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  343  			coalescing_count, coalescing_ticks);
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  344  
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  345  	return strlen(buf);
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  346  }
6b4b8fc87dc5cbf Qiang Liu 2012-02-15  347  

:::::: The code at line 335 was first introduced by commit
:::::: 6b4b8fc87dc5cbfcfb5c749dc200906471fb854c sata_fsl: add support for interrupt coalsecing feature

:::::: TO: Qiang Liu <qiang.liu@freescale.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
