Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D457714F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiGPUFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:05:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D01D32E;
        Sat, 16 Jul 2022 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658001937; x=1689537937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZeEetixp7iw8oXEnSiJwgiBu95tm6QYtJZygYDm5Vps=;
  b=ioVqsrc7VxkcBfXlH3sEpzCmzsthI9Atkt1vs6k+Mzb63nagzlBlhHre
   cJDDgQdY8Ee7RxBUZ1r97bSyg+1VDPQo4YnrqCbzUd2hYjr4S3/GUl5X6
   AZIce87EX4hlDWbUuEwoq50GEBWX5wvNvh7WbcelYW90FGKoHgxM17BO0
   mqIJLGdwpPp5Fjz6qYAjXPtcSmzkf3SOSKY5sKmXMGMvBWVRrZ4iyTIJq
   a3vMIV3Q+xwtEngLyiekfTc728d6oKa3z0ZfUfwMT+hKiZI+ZAqRmBK8u
   p4dR4dnj9PtTzDeWcdeC8wobOt7MwTjXQkaGlXROYaZKlDyFgZ0zpf3Yn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="283568015"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="283568015"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 13:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="686313842"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2022 13:05:35 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCo2g-00025K-Fm;
        Sat, 16 Jul 2022 20:05:34 +0000
Date:   Sun, 17 Jul 2022 04:05:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: arch/mips/pci/msi-octeon.c:215: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202207170450.i5OUq4GL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5fe7a97f20c7f3070ac870144515c0fabc6b999
commit: 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf scripts: kernel-doc: add warning for comment not following kernel-doc syntax
date:   1 year, 4 months ago
config: mips-randconfig-r015-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170450.i5OUq4GL-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3e58e839150db0857dfcb3a0bb3d4af4c6ac1abf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/cavium-octeon/executive/ arch/mips/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/pci/msi-octeon.c:61: warning: expecting prototype for Called when a driver request MSI interrupts instead of the(). Prototype was for arch_setup_msi_irq() instead
>> arch/mips/pci/msi-octeon.c:215: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Called when a device no longer needs its MSI interrupts. All
--
   arch/mips/cavium-octeon/executive/octeon-model.c:40: warning: expecting prototype for Read a byte of fuse data(). Prototype was for cvmx_fuse_read_byte() instead
>> arch/mips/cavium-octeon/executive/octeon-model.c:495: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Given the chip processor ID from COP0, this function returns a
--
>> arch/mips/cavium-octeon/executive/cvmx-helper.c:53: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return the number of interfaces the chip has. Each interface
   arch/mips/cavium-octeon/executive/cvmx-helper.c:74: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return the number of ports on an interface. Depending on the
   arch/mips/cavium-octeon/executive/cvmx-helper.c:89: warning: Cannot understand  * @INTERNAL
    on line 89 - I thought it was a doc line
   arch/mips/cavium-octeon/executive/cvmx-helper.c:141: warning: Cannot understand  * @INTERNAL
    on line 141 - I thought it was a doc line
   arch/mips/cavium-octeon/executive/cvmx-helper.c:241: warning: Cannot understand  * @INTERNAL
    on line 241 - I thought it was a doc line
   arch/mips/cavium-octeon/executive/cvmx-helper.c:277: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get the operating mode of an interface. Depending on the Octeon
   arch/mips/cavium-octeon/executive/cvmx-helper.c:359: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Configure the IPD/PIP tagging and QoS options for a specific
   arch/mips/cavium-octeon/executive/cvmx-helper.c:408: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function sets the interface_port_count[interface] correctly,
   arch/mips/cavium-octeon/executive/cvmx-helper.c:493: warning: expecting prototype for This function probes an interface to determine the actual(). Prototype was for cvmx_helper_interface_probe() instead
   arch/mips/cavium-octeon/executive/cvmx-helper.c:550: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Setup the IPD/PIP for the ports on an interface. Packet
   arch/mips/cavium-octeon/executive/cvmx-helper.c:572: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Setup global setting for IPD/PIP not related to a specific
   arch/mips/cavium-octeon/executive/cvmx-helper.c:594: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Setup the PKO for the ports on an interface. The number of
   arch/mips/cavium-octeon/executive/cvmx-helper.c:644: warning: expecting prototype for Setup global setting for PKO not related to a specific(). Prototype was for __cvmx_helper_global_setup_pko() instead
   arch/mips/cavium-octeon/executive/cvmx-helper.c:673: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Setup global backpressure setting.
   arch/mips/cavium-octeon/executive/cvmx-helper.c:707: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Enable packet input/output from the hardware. This function is
   arch/mips/cavium-octeon/executive/cvmx-helper.c:775: warning: expecting prototype for Function to adjust internal IPD pointer alignments(). Prototype was for __cvmx_helper_errata_fix_ipd_ptr_alignment() instead
   arch/mips/cavium-octeon/executive/cvmx-helper.c:963: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Called after all internal packet IO paths are setup. This
   arch/mips/cavium-octeon/executive/cvmx-helper.c:999: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Initialize the PIP, IPD, and PKO hardware to support
   arch/mips/cavium-octeon/executive/cvmx-helper.c:1064: warning: expecting prototype for Does core local initialization for packet io(). Prototype was for cvmx_helper_initialize_packet_io_local() instead
   arch/mips/cavium-octeon/executive/cvmx-helper.c:1069: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return the link state of an IPD/PKO port as returned by
   arch/mips/cavium-octeon/executive/cvmx-helper.c:1129: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Configure an IPD/PKO port for the specified link state. This


vim +215 arch/mips/pci/msi-octeon.c

e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   47  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   48  /**
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   49   * Called when a driver request MSI interrupts instead of the
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   50   * legacy INT A-D. This routine will allocate multiple interrupts
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   51   * for MSI devices that support them. A device can override this by
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   52   * programming the MSI control bits [6:4] before calling
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   53   * pci_enable_msi().
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   54   *
01a6221a6a51ec arch/mips/pci/msi-octeon.c    David Daney        2009-06-29   55   * @dev:    Device requesting MSI interrupts
01a6221a6a51ec arch/mips/pci/msi-octeon.c    David Daney        2009-06-29   56   * @desc:   MSI descriptor
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   57   *
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   58   * Returns 0 on success.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   59   */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   60  int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  @61  {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   62  	struct msi_msg msg;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26   63  	u16 control;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   64  	int configured_private_bits;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   65  	int request_private_bits;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26   66  	int irq = 0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   67  	int irq_step;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26   68  	u64 search_mask;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26   69  	int index;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   70  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   71  	/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   72  	 * Read the MSI config to figure out how many IRQs this device
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   73  	 * wants.  Most devices only want 1, which will give
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   74  	 * configured_private_bits and request_private_bits equal 0.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   75  	 */
48c3c38f003c25 arch/mips/pci/msi-octeon.c    Yijing Wang        2014-09-23   76  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   77  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   78  	/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   79  	 * If the number of private bits has been configured then use
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   80  	 * that value instead of the requested number. This gives the
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   81  	 * driver the chance to override the number of interrupts
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   82  	 * before calling pci_enable_msi().
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   83  	 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   84  	configured_private_bits = (control & PCI_MSI_FLAGS_QSIZE) >> 4;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   85  	if (configured_private_bits == 0) {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   86  		/* Nothing is configured, so use the hardware requested size */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   87  		request_private_bits = (control & PCI_MSI_FLAGS_QMASK) >> 1;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   88  	} else {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   89  		/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   90  		 * Use the number of configured bits, assuming the
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   91  		 * driver wanted to override the hardware request
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   92  		 * value.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   93  		 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   94  		request_private_bits = configured_private_bits;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   95  	}
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   96  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   97  	/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   98  	 * The PCI 2.3 spec mandates that there are at most 32
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23   99  	 * interrupts. If this device asks for more, only give it one.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  100  	 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  101  	if (request_private_bits > 5)
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  102  		request_private_bits = 0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  103  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  104  try_only_one:
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  105  	/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  106  	 * The IRQs have to be aligned on a power of two based on the
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  107  	 * number being requested.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  108  	 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  109  	irq_step = 1 << request_private_bits;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  110  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  111  	/* Mask with one bit for each IRQ */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  112  	search_mask = (1 << irq_step) - 1;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  113  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  114  	/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  115  	 * We're going to search msi_free_irq_bitmask_lock for zero
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  116  	 * bits. This represents an MSI interrupt number that isn't in
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  117  	 * use.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  118  	 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  119  	spin_lock(&msi_free_irq_bitmask_lock);
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  120  	for (index = 0; index < msi_irq_size/64; index++) {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  121  		for (irq = 0; irq < 64; irq += irq_step) {
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  122  			if ((msi_free_irq_bitmask[index] & (search_mask << irq)) == 0) {
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  123  				msi_free_irq_bitmask[index] |= search_mask << irq;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  124  				msi_multiple_irq_bitmask[index] |= (search_mask >> 1) << irq;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  125  				goto msi_irq_allocated;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  126  			}
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  127  		}
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  128  	}
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  129  msi_irq_allocated:
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  130  	spin_unlock(&msi_free_irq_bitmask_lock);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  131  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  132  	/* Make sure the search for available interrupts didn't fail */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  133  	if (irq >= 64) {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  134  		if (request_private_bits) {
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  135  			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying just one",
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  136  			       1 << request_private_bits);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  137  			request_private_bits = 0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  138  			goto try_only_one;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  139  		} else
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  140  			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  141  	}
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  142  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  143  	/* MSI interrupts start at logical IRQ OCTEON_IRQ_MSI_BIT0 */
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  144  	irq += index*64;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  145  	irq += OCTEON_IRQ_MSI_BIT0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  146  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  147  	switch (octeon_dma_bar_type) {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  148  	case OCTEON_DMA_BAR_TYPE_SMALL:
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  149  		/* When not using big bar, Bar 0 is based at 128MB */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  150  		msg.address_lo =
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  151  			((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  152  		msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV) >> 32;
7f02c463057fc5 arch/mips/pci/msi-octeon.c    Colin Ian King     2014-02-10  153  		break;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  154  	case OCTEON_DMA_BAR_TYPE_BIG:
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  155  		/* When using big bar, Bar 0 is based at 0 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  156  		msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  157  		msg.address_hi = (0 + CVMX_PCI_MSI_RCV) >> 32;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  158  		break;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  159  	case OCTEON_DMA_BAR_TYPE_PCIE:
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  160  		/* When using PCIe, Bar 0 is based at 0 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  161  		/* FIXME CVMX_NPEI_MSI_RCV* other than 0? */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  162  		msg.address_lo = (0 + CVMX_NPEI_PCIE_MSI_RCV) & 0xffffffff;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  163  		msg.address_hi = (0 + CVMX_NPEI_PCIE_MSI_RCV) >> 32;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  164  		break;
d19648d7f3b047 arch/mips/pci/msi-octeon.c    Eunbong Song       2014-04-11  165  	case OCTEON_DMA_BAR_TYPE_PCIE2:
d19648d7f3b047 arch/mips/pci/msi-octeon.c    Eunbong Song       2014-04-11  166  		/* When using PCIe2, Bar 0 is based at 0 */
d19648d7f3b047 arch/mips/pci/msi-octeon.c    Eunbong Song       2014-04-11  167  		msg.address_lo = (0 + CVMX_SLI_PCIE_MSI_RCV) & 0xffffffff;
d19648d7f3b047 arch/mips/pci/msi-octeon.c    Eunbong Song       2014-04-11  168  		msg.address_hi = (0 + CVMX_SLI_PCIE_MSI_RCV) >> 32;
d19648d7f3b047 arch/mips/pci/msi-octeon.c    Eunbong Song       2014-04-11  169  		break;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  170  	default:
ab75dc02c151c9 arch/mips/pci/msi-octeon.c    Ralf Baechle       2011-11-17  171  		panic("arch_setup_msi_irq: Invalid octeon_dma_bar_type");
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  172  	}
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  173  	msg.data = irq - OCTEON_IRQ_MSI_BIT0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  174  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  175  	/* Update the number of IRQs the device has available to it */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  176  	control &= ~PCI_MSI_FLAGS_QSIZE;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  177  	control |= request_private_bits << 4;
48c3c38f003c25 arch/mips/pci/msi-octeon.c    Yijing Wang        2014-09-23  178  	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  179  
e4ec7989b4e55d arch/mips/pci/msi-octeon.c    Thomas Gleixner    2011-03-27  180  	irq_set_msi_desc(irq, desc);
83a18912b0e8d2 arch/mips/pci/msi-octeon.c    Jiang Liu          2014-11-09  181  	pci_write_msi_msg(irq, &msg);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  182  	return 0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  183  }
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  184  
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  185  int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  186  {
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  187  	struct msi_desc *entry;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  188  	int ret;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  189  
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  190  	/*
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  191  	 * MSI-X is not supported.
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  192  	 */
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  193  	if (type == PCI_CAP_ID_MSIX)
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  194  		return -EINVAL;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  195  
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  196  	/*
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  197  	 * If an architecture wants to support multiple MSI, it needs to
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  198  	 * override arch_setup_msi_irqs()
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  199  	 */
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  200  	if (type == PCI_CAP_ID_MSI && nvec > 1)
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  201  		return 1;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  202  
bbcffac3a8b60f arch/mips/pci/msi-octeon.c    Jiang Liu          2015-07-09  203  	for_each_pci_msi_entry(entry, dev) {
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  204  		ret = arch_setup_msi_irq(dev, entry);
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  205  		if (ret < 0)
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  206  			return ret;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  207  		if (ret > 0)
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  208  			return -ENOSPC;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  209  	}
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  210  
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  211  	return 0;
52a0f00b50ea36 arch/mips/pci/msi-octeon.c    Chandrakala Chavva 2010-07-26  212  }
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  213  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  214  /**
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23 @215   * Called when a device no longer needs its MSI interrupts. All
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  216   * MSI interrupts for the device are freed.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  217   *
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  218   * @irq:    The devices first irq number. There may be multple in sequence.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  219   */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  220  void arch_teardown_msi_irq(unsigned int irq)
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  221  {
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  222  	int number_irqs;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  223  	u64 bitmask;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  224  	int index = 0;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  225  	int irq0;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  226  
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  227  	if ((irq < OCTEON_IRQ_MSI_BIT0)
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  228  		|| (irq > msi_irq_size + OCTEON_IRQ_MSI_BIT0))
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  229  		panic("arch_teardown_msi_irq: Attempted to teardown illegal "
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  230  		      "MSI interrupt (%d)", irq);
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  231  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  232  	irq -= OCTEON_IRQ_MSI_BIT0;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  233  	index = irq / 64;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  234  	irq0 = irq % 64;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  235  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  236  	/*
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  237  	 * Count the number of IRQs we need to free by looking at the
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  238  	 * msi_multiple_irq_bitmask. Each bit set means that the next
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  239  	 * IRQ is also owned by this device.
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  240  	 */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  241  	number_irqs = 0;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  242  	while ((irq0 + number_irqs < 64) &&
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  243  	       (msi_multiple_irq_bitmask[index]
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  244  		& (1ull << (irq0 + number_irqs))))
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  245  		number_irqs++;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  246  	number_irqs++;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  247  	/* Mask with one bit for each IRQ */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  248  	bitmask = (1 << number_irqs) - 1;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  249  	/* Shift the mask to the correct bit location */
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  250  	bitmask <<= irq0;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  251  	if ((msi_free_irq_bitmask[index] & bitmask) != bitmask)
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  252  		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  253  		      "interrupt (%d) not in use", irq);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  254  
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  255  	/* Checks are done, update the in use bitmask */
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  256  	spin_lock(&msi_free_irq_bitmask_lock);
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  257  	msi_free_irq_bitmask[index] &= ~bitmask;
1aa2b2782a056b arch/mips/pci/msi-octeon.c    David Daney        2010-07-26  258  	msi_multiple_irq_bitmask[index] &= ~bitmask;
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  259  	spin_unlock(&msi_free_irq_bitmask_lock);
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  260  }
e8635b484f644c arch/mips/cavium-octeon/msi.c David Daney        2009-04-23  261  

:::::: The code at line 215 was first introduced by commit
:::::: e8635b484f644c7873e6091f15330c49396f2cbc MIPS: Add Cavium OCTEON PCI support.

:::::: TO: David Daney <ddaney@caviumnetworks.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
