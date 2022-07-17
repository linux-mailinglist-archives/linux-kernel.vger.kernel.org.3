Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78C557775A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiGQQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:54:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342A13F9B;
        Sun, 17 Jul 2022 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658076898; x=1689612898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uhB0GA9ESzIKU1S9MryS5ARAASOFFo6mC6Zn+QAlZUA=;
  b=OPKC8DNYOEco+m1+Eij00/iWyeXfVQEUUCZuW6ZWzwLqSBaIXNlMQTWu
   tSNGWpGvtQHDHJH7lX/fhH9IK+Gy2IF/VzcKag8dO2NWqwQsYdQdz7Oa6
   sCW2j6f9MSS9DGu7C4SLkJp4wZ8TCFbaWvHVVeKQ6V/idDg8/u+VH+3q0
   7HNE4TjG9tclEgxsokLcrM7iB2GArREx4e9qtnGMyX2Z2jRWfrJjlqeUX
   A4QNNH/939/VFEU0D1Jib+Xi87z+v/r/5bMeUIcENxjQusJiOVF/KoY+U
   YGCcIwFI36M7x9BHeooSndIJzZxpKzaKLc435RzwnU69icvp7mM8XCc6n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266482300"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="266482300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 09:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="686494943"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2022 09:54:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD7Xk-0003Ui-1O;
        Sun, 17 Jul 2022 16:54:56 +0000
Date:   Mon, 18 Jul 2022 00:54:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 66/93]
 drivers/platform/x86/intel/vsec.c:429:38: sparse: sparse: incorrect type in
 initializer (different base types)
Message-ID: <202207180002.aO1yUtRE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   7a4a04f4e90d746928501a6d551de87d02c28323
commit: 936874b77dd0a86aafc1f03c11cb97ec938c16f1 [66/93] platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220718/202207180002.aO1yUtRE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=936874b77dd0a86aafc1f03c11cb97ec938c16f1
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 936874b77dd0a86aafc1f03c11cb97ec938c16f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/lkdtm/ drivers/platform/x86/intel/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/intel/vsec.c:429:38: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted pci_channel_state_t [usertype] status @@     got restricted pci_ers_result_t @@
   drivers/platform/x86/intel/vsec.c:429:38: sparse:     expected restricted pci_channel_state_t [usertype] status
   drivers/platform/x86/intel/vsec.c:429:38: sparse:     got restricted pci_ers_result_t
>> drivers/platform/x86/intel/vsec.c:434:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_channel_state_t [usertype] status @@     got restricted pci_ers_result_t @@
   drivers/platform/x86/intel/vsec.c:434:24: sparse:     expected restricted pci_channel_state_t [usertype] status
   drivers/platform/x86/intel/vsec.c:434:24: sparse:     got restricted pci_ers_result_t
>> drivers/platform/x86/intel/vsec.c:438:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted pci_ers_result_t @@     got restricted pci_channel_state_t [usertype] status @@
   drivers/platform/x86/intel/vsec.c:438:16: sparse:     expected restricted pci_ers_result_t
   drivers/platform/x86/intel/vsec.c:438:16: sparse:     got restricted pci_channel_state_t [usertype] status
   drivers/platform/x86/intel/vsec.c:444:38: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted pci_channel_state_t [usertype] status @@     got restricted pci_ers_result_t @@
   drivers/platform/x86/intel/vsec.c:444:38: sparse:     expected restricted pci_channel_state_t [usertype] status
   drivers/platform/x86/intel/vsec.c:444:38: sparse:     got restricted pci_ers_result_t
   drivers/platform/x86/intel/vsec.c:457:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_channel_state_t [usertype] status @@     got restricted pci_ers_result_t @@
   drivers/platform/x86/intel/vsec.c:457:16: sparse:     expected restricted pci_channel_state_t [usertype] status
   drivers/platform/x86/intel/vsec.c:457:16: sparse:     got restricted pci_ers_result_t
   drivers/platform/x86/intel/vsec.c:472:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted pci_ers_result_t @@     got restricted pci_channel_state_t [usertype] status @@
   drivers/platform/x86/intel/vsec.c:472:16: sparse:     expected restricted pci_ers_result_t
   drivers/platform/x86/intel/vsec.c:472:16: sparse:     got restricted pci_channel_state_t [usertype] status
>> drivers/platform/x86/intel/vsec.c:480:33: sparse: sparse: symbol 'intel_vsec_pci_err_handlers' was not declared. Should it be static?


vim +429 drivers/platform/x86/intel/vsec.c

   425	
   426	static pci_ers_result_t intel_vsec_pci_error_detected(struct pci_dev *pdev,
   427							      pci_channel_state_t state)
   428	{
 > 429		pci_channel_state_t status = PCI_ERS_RESULT_NEED_RESET;
   430	
   431		dev_info(&pdev->dev, "PCI error detected, state %d", state);
   432	
   433		if (state == pci_channel_io_perm_failure)
 > 434			status = PCI_ERS_RESULT_DISCONNECT;
   435		else
   436			pci_disable_device(pdev);
   437	
 > 438		return status;
   439	}
   440	
   441	static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
   442	{
   443		struct intel_vsec_device *intel_vsec_dev;
 > 444		pci_channel_state_t status = PCI_ERS_RESULT_DISCONNECT;
   445		const struct pci_device_id *pci_dev_id;
   446		unsigned long index;
   447	
   448		dev_info(&pdev->dev, "Resetting PCI slot\n");
   449	
   450		msleep(2000);
   451		if (pci_enable_device(pdev)) {
   452			dev_info(&pdev->dev,
   453				 "Failed to re-enable PCI device after reset.\n");
   454			goto out;
   455		}
   456	
   457		status =  PCI_ERS_RESULT_RECOVERED;
   458	
   459		xa_for_each(&auxdev_array, index, intel_vsec_dev) {
   460			/* check if pdev doesn't match */
   461			if (pdev != intel_vsec_dev->pcidev)
   462				continue;
   463			devm_release_action(&pdev->dev, intel_vsec_remove_aux,
   464					    &intel_vsec_dev->auxdev);
   465		}
   466		pci_disable_device(pdev);
   467		pci_restore_state(pdev);
   468		pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
   469		intel_vsec_pci_probe(pdev, pci_dev_id);
   470	
   471	out:
   472		return status;
   473	}
   474	
   475	static void intel_vsec_pci_resume(struct pci_dev *pdev)
   476	{
   477		dev_info(&pdev->dev, "Done resuming PCI device\n");
   478	}
   479	
 > 480	const struct pci_error_handlers intel_vsec_pci_err_handlers = {
   481		.error_detected = intel_vsec_pci_error_detected,
   482		.slot_reset = intel_vsec_pci_slot_reset,
   483		.resume = intel_vsec_pci_resume,
   484	};
   485	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
