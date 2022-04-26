Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7A50FA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbiDZKaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbiDZK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:29:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D63931DDB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650967376; x=1682503376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tCFugtzk966ibYFXLfUUK3IU+IcDgw3nmkKxQbQFoyc=;
  b=EIadJfsmO/FP3+e4uNQ1uGdhQYkJDPjSsEEwB8JQXcLinPTKlew6zRdR
   zNkpMmCBcE1i5vOnL+vhJPEdD+kyRyobTRcyrPpd/kNZHBnV0VRfGT1bA
   DnrX/qj55U1hWhEmSa63iL094NL4g9MtYiI/cI3nU0c6U/Cv2ZAj65cNI
   IjDTUkROJ3vpbKNzlWOT25lWeM9UAezzCc0onfji/nA9pYEUZLlZOmGR1
   /RdfaE1H3UOz+HLR8UgW5YGI4CjX7pOhX1jsZR0pD8ZMMW1Zp8kM7eFPn
   nLJZoAbfMQx5WeWKfrqkpLqioBNBxQ0a8gscUhe4USh8BQgi/D9s6vxGC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265050739"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265050739"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 03:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="650130899"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2022 03:02:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njI20-0003PI-Vk;
        Tue, 26 Apr 2022 10:02:52 +0000
Date:   Tue, 26 Apr 2022 18:02:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [cxl:pending 27/33] drivers/cxl/acpi.c:293:2: warning: variable
 '__d' is uninitialized when used within its own initialization
Message-ID: <202204261758.lzXWne7H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
head:   ac33087b90d44498835ff3030e94357204ebaa31
commit: 66261e39a6ee0397eddc86efcaf6cf9ae8c8079b [27/33] cxl/acpi: Add root device lockdep validation
config: i386-randconfig-a002-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261758.lzXWne7H-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=66261e39a6ee0397eddc86efcaf6cf9ae8c8079b
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl pending
        git checkout 66261e39a6ee0397eddc86efcaf6cf9ae8c8079b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/acpi.c:293:2: warning: variable '__d' is uninitialized when used within its own initialization [-Wuninitialized]
           device_lock_set_class(&pdev->dev, &cxl_root_key);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:876:26: note: expanded from macro 'device_lock_set_class'
           __device_lock_set_class(__d, #key, key);                           \
           ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   include/linux/device.h:855:38: note: expanded from macro '__device_lock_set_class'
           struct device *__d __maybe_unused = dev;                       \
                          ~~~                  ^~~
   1 warning generated.


vim +/__d +293 drivers/cxl/acpi.c

   284	
   285	static int cxl_acpi_probe(struct platform_device *pdev)
   286	{
   287		int rc;
   288		struct cxl_port *root_port;
   289		struct device *host = &pdev->dev;
   290		struct acpi_device *adev = ACPI_COMPANION(host);
   291		struct cxl_cfmws_context ctx;
   292	
 > 293		device_lock_set_class(&pdev->dev, &cxl_root_key);
   294		rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
   295					      &pdev->dev);
   296		if (rc)
   297			return rc;
   298	
   299		root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
   300		if (IS_ERR(root_port))
   301			return PTR_ERR(root_port);
   302		dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
   303	
   304		rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
   305				      add_host_bridge_dport);
   306		if (rc < 0)
   307			return rc;
   308	
   309		ctx = (struct cxl_cfmws_context) {
   310			.dev = host,
   311			.root_port = root_port,
   312		};
   313		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
   314	
   315		/*
   316		 * Root level scanned with host-bridge as dports, now scan host-bridges
   317		 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
   318		 */
   319		rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
   320				      add_host_bridge_uport);
   321		if (rc < 0)
   322			return rc;
   323	
   324		if (IS_ENABLED(CONFIG_CXL_PMEM))
   325			rc = device_for_each_child(&root_port->dev, root_port,
   326						   add_root_nvdimm_bridge);
   327		if (rc < 0)
   328			return rc;
   329	
   330		/* In case PCI is scanned before ACPI re-trigger memdev attach */
   331		return cxl_bus_rescan();
   332	}
   333	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
