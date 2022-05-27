Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D89253676B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354297AbiE0TUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiE0TUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:20:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CA106A44
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653679215; x=1685215215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JRflB2s+LLo8bgcAQ/cDQrmE4V7NCQmXgL1uFLxJDsI=;
  b=kmibq/xx4kvgzWmLTvXlsKLs0RjRh4eCokfXfrs5TYEXc23Du25Skx4N
   F4tqwZeG/RZnhvlVnWySm7/3tc7fLJt4ppCW33/hY7l4fgmx2021mIXMA
   4eRNdUhjJLfaXm7LQ4owFhCgJkTHrEjPrdrjW7P+9xskAWG3HwzkLNxnK
   aFW6EOpqKMQ2Sby19RCr/xMg30uQ9pboSpUwilBcu8MV7OyxGKiVwXzVe
   9ig7FCPkOe7RkfNGH5qLhnJxKGFqblwUWyRyxaAUIJKudut1fMitjVZ3V
   XMp7HUONbfuge620XDCX1SuG84yNE1K8DMGZjv0z4wCyfdeuu91tWohMk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274565897"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274565897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 12:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="705263600"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 12:20:12 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nufVL-000541-F2;
        Fri, 27 May 2022 19:20:11 +0000
Date:   Sat, 28 May 2022 03:20:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Miccio <lucmiccio@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: drivers/xen/xenbus/xenbus_probe.c:755:37: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202205280304.kVBBNk9M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 5b3353949e89d48b4faf54a9cc241ee5d70df615 xen: add support for initializing xenstore later as HVM domain
date:   8 days ago
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220528/202205280304.kVBBNk9M-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5b3353949e89d48b4faf54a9cc241ee5d70df615
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5b3353949e89d48b4faf54a9cc241ee5d70df615
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/xen/xenbus/ kernel/ lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/xen/xenbus/xenbus_probe.c:755:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xenstore_domain_interface *extern [addressable] [toplevel] xen_store_interface @@     got void [noderef] __iomem * @@
   drivers/xen/xenbus/xenbus_probe.c:755:37: sparse:     expected struct xenstore_domain_interface *extern [addressable] [toplevel] xen_store_interface
   drivers/xen/xenbus/xenbus_probe.c:755:37: sparse:     got void [noderef] __iomem *
   drivers/xen/xenbus/xenbus_probe.c:1011:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xenstore_domain_interface *extern [addressable] [assigned] [toplevel] xen_store_interface @@     got void [noderef] __iomem * @@
   drivers/xen/xenbus/xenbus_probe.c:1011:45: sparse:     expected struct xenstore_domain_interface *extern [addressable] [assigned] [toplevel] xen_store_interface
   drivers/xen/xenbus/xenbus_probe.c:1011:45: sparse:     got void [noderef] __iomem *

vim +755 drivers/xen/xenbus/xenbus_probe.c

   749	
   750	static void xenbus_probe(void)
   751	{
   752		xenstored_ready = 1;
   753	
   754		if (!xen_store_interface) {
 > 755			xen_store_interface = xen_remap(xen_store_gfn << XEN_PAGE_SHIFT,
   756							XEN_PAGE_SIZE);
   757			/*
   758			 * Now it is safe to free the IRQ used for xenstore late
   759			 * initialization. No need to unbind: it is about to be
   760			 * bound again from xb_init_comms. Note that calling
   761			 * unbind_from_irqhandler now would result in xen_evtchn_close()
   762			 * being called and the event channel not being enabled again
   763			 * afterwards, resulting in missed event notifications.
   764			 */
   765			free_irq(xs_init_irq, &xb_waitq);
   766		}
   767	
   768		/*
   769		 * In the HVM case, xenbus_init() deferred its call to
   770		 * xs_init() in case callbacks were not operational yet.
   771		 * So do it now.
   772		 */
   773		if (xen_store_domain_type == XS_HVM)
   774			xs_init();
   775	
   776		/* Notify others that xenstore is up */
   777		blocking_notifier_call_chain(&xenstore_chain, 0, NULL);
   778	}
   779	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
