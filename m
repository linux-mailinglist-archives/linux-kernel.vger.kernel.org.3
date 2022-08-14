Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967EC591DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 05:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiHND6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 23:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHND6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 23:58:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC941DA6B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 20:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660449523; x=1691985523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SgOvEmM8xnxE9R7gKwGW3WNhVfQ3SStZ/PwIC+M3cTQ=;
  b=Tr1uFLn5l6LwNIssN4W/KGaSwvxyhhakNOtSOIvf5HRtjAIXgMeDxi8h
   muHzWt7clNE06NxUjrM45rhF7j1OeNKalIRsPG0XscpwUj3mkAdjwCuks
   /TaYzyOixd9cdp+sk0gwhhkhjmqDjOOL+Vbv/rGyIUdN5HDe09yjjIhCR
   iPfmaw448TFFHENB+JofHoAlDt9Yb3vL67h1LduwDelpQAtovdXxhpgDP
   6A4t9p2QZoqiifciI9RCeKcGWS6QEooqcBcjM3JME2RBRf6dYCwbaJwIy
   owY7TsIVbdfVq8MLa7cankB9L+IEuBQ5UlyEzFYejlvzdRp7s+5Xo9gpr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353537261"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="353537261"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 20:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="635095566"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2022 20:58:41 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN4lt-0002T5-0i;
        Sun, 14 Aug 2022 03:58:41 +0000
Date:   Sun, 14 Aug 2022 11:57:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: arch/s390/kvm/pci.c:58:68: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202208141105.tF57XnDg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 98b1d33dac5fd09060486762c02fd1a78baeb1e0 KVM: s390: pci: do initial setup for AEN interpretation
date:   5 weeks ago
config: s390-randconfig-s053-20220814 (https://download.01.org/0day-ci/archive/20220814/202208141105.tF57XnDg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=98b1d33dac5fd09060486762c02fd1a78baeb1e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 98b1d33dac5fd09060486762c02fd1a78baeb1e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/s390/kvm/pci.c:58:68: sparse: sparse: Using plain integer as NULL pointer

vim +58 arch/s390/kvm/pci.c

    48	
    49	static int zpci_setup_aipb(u8 nisc)
    50	{
    51		struct page *page;
    52		int size, rc;
    53	
    54		zpci_aipb = kzalloc(sizeof(union zpci_sic_iib), GFP_KERNEL);
    55		if (!zpci_aipb)
    56			return -ENOMEM;
    57	
  > 58		aift->sbv = airq_iv_create(ZPCI_NR_DEVICES, AIRQ_IV_ALLOC, 0);
    59		if (!aift->sbv) {
    60			rc = -ENOMEM;
    61			goto free_aipb;
    62		}
    63		zpci_aif_sbv = aift->sbv;
    64		size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
    65							sizeof(struct zpci_gaite)));
    66		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, size);
    67		if (!page) {
    68			rc = -ENOMEM;
    69			goto free_sbv;
    70		}
    71		aift->gait = (struct zpci_gaite *)page_to_phys(page);
    72	
    73		zpci_aipb->aipb.faisb = virt_to_phys(aift->sbv->vector);
    74		zpci_aipb->aipb.gait = virt_to_phys(aift->gait);
    75		zpci_aipb->aipb.afi = nisc;
    76		zpci_aipb->aipb.faal = ZPCI_NR_DEVICES;
    77	
    78		/* Setup Adapter Event Notification Interpretation */
    79		if (zpci_set_irq_ctrl(SIC_SET_AENI_CONTROLS, 0, zpci_aipb)) {
    80			rc = -EIO;
    81			goto free_gait;
    82		}
    83	
    84		return 0;
    85	
    86	free_gait:
    87		free_pages((unsigned long)aift->gait, size);
    88	free_sbv:
    89		airq_iv_release(aift->sbv);
    90		zpci_aif_sbv = NULL;
    91	free_aipb:
    92		kfree(zpci_aipb);
    93		zpci_aipb = NULL;
    94	
    95		return rc;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
