Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1124F8C47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiDHBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDHBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:34:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768EEBC1F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649381546; x=1680917546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/PaDX15BGTB1KpJv83PJyQEoA2fq7VhbcOP2yCuMoc0=;
  b=N9Q7n/b3YRShgL2UI4kg9CCkA14bocsj69eXiHoGldzCJG7jUQdGYwaH
   LnAxXUXiope2cL/l7uxp/drZxJn63XJ59iYf0+c7O23P2xMEZxSXuAGdD
   K1aPx7i8HH83d/25ZpYkhgH2vER4j58RDh7UeOlzXAKy5JBqV6CMEQYJ0
   JeFMceb3LhFu73EspKT2sX+SWswsq/3cw55l/ta9w1J2Us0dljzWl2xKt
   gcETNhG+nYicRvKgZcYzNgfqsn3b8eLHdKwfyTB28ttZQF9cV1YCd+MzQ
   t2G05SRJZsTMzMsfBWzhZv6N33Su7dQsXKZA7BaKuIKuQQbn0lMEyUv1r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261659536"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="261659536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 18:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="851896286"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2022 18:32:24 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncdU8-0005w1-7g;
        Fri, 08 Apr 2022 01:32:24 +0000
Date:   Fri, 8 Apr 2022 09:31:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:clearfog 9/10] drivers/pci/pcie/aspm.c:589
 pcie_aspm_cap_init() warn: inconsistent indenting
Message-ID: <202204080940.N5oFOBAB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   ab730a7012721dd1671494558c3312537d02045d
commit: 43b5a9d78483d573d9ab328a778d0ab5c789ef16 [9/10] mvebu/clearfog pcie updates
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220408/202204080940.N5oFOBAB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/pci/pcie/aspm.c:589 pcie_aspm_cap_init() warn: inconsistent indenting

vim +589 drivers/pci/pcie/aspm.c

   550	
   551	static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
   552	{
   553		struct pci_dev *child = link->downstream, *parent = link->pdev;
   554		u32 parent_lnkcap, child_lnkcap;
   555		u16 parent_lnkctl, child_lnkctl;
   556		u32 parent_l1ss_cap, child_l1ss_cap;
   557		u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
   558		struct pci_bus *linkbus = parent->subordinate;
   559	
   560		if (blacklist) {
   561			/* Set enabled/disable so that we will disable ASPM later */
   562			link->aspm_enabled = ASPM_STATE_ALL;
   563			link->aspm_disable = ASPM_STATE_ALL;
   564			return;
   565		}
   566	
   567		/*
   568		 * If ASPM not supported, don't mess with the clocks and link,
   569		 * bail out now.
   570		 */
   571		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
   572		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
   573		if (!(parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPMS))
   574			return;
   575	
   576		/* Configure common clock before checking latencies */
   577		pcie_aspm_configure_common_clock(link);
   578	
   579		/*
   580		 * Re-read upstream/downstream components' register state after
   581		 * clock configuration.  L0s & L1 exit latencies in the otherwise
   582		 * read-only Link Capabilities may change depending on common clock
   583		 * configuration (PCIe r5.0, sec 7.5.3.6).
   584		 */
   585		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
   586		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
   587		pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
   588		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 > 589	dev_info(&parent->dev, "up support %x enabled %x\n",
   590		 (parent_lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10,
   591		 !!(parent_lnkctl & PCI_EXP_LNKCTL_ASPMC));
   592	dev_info(&parent->dev, "dn support %x enabled %x\n",
   593		 (child_lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10,
   594		 !!(child_lnkctl & PCI_EXP_LNKCTL_ASPMC));
   595	
   596		/*
   597		 * Setup L0s state
   598		 *
   599		 * Note that we must not enable L0s in either direction on a
   600		 * given link unless components on both sides of the link each
   601		 * support L0s.
   602		 */
   603		if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
   604			link->aspm_support |= ASPM_STATE_L0S;
   605	
   606		if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
   607			link->aspm_enabled |= ASPM_STATE_L0S_UP;
   608		if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
   609			link->aspm_enabled |= ASPM_STATE_L0S_DW;
   610	
   611		/* Setup L1 state */
   612		if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
   613			link->aspm_support |= ASPM_STATE_L1;
   614	
   615		if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
   616			link->aspm_enabled |= ASPM_STATE_L1;
   617	
   618		/* Setup L1 substate */
   619		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
   620				      &parent_l1ss_cap);
   621		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
   622				      &child_l1ss_cap);
   623	
   624		if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
   625			parent_l1ss_cap = 0;
   626		if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
   627			child_l1ss_cap = 0;
   628	
   629		/*
   630		 * If we don't have LTR for the entire path from the Root Complex
   631		 * to this device, we can't use ASPM L1.2 because it relies on the
   632		 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
   633		 */
   634		if (!child->ltr_path)
   635			child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
   636	
   637		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
   638			link->aspm_support |= ASPM_STATE_L1_1;
   639		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
   640			link->aspm_support |= ASPM_STATE_L1_2;
   641		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
   642			link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
   643		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
   644			link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
   645	
   646		if (parent_l1ss_cap)
   647			pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
   648					      &parent_l1ss_ctl1);
   649		if (child_l1ss_cap)
   650			pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
   651					      &child_l1ss_ctl1);
   652	
   653		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
   654			link->aspm_enabled |= ASPM_STATE_L1_1;
   655		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
   656			link->aspm_enabled |= ASPM_STATE_L1_2;
   657		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
   658			link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
   659		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
   660			link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
   661	
   662		if (link->aspm_support & ASPM_STATE_L1SS)
   663			aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
   664	
   665		/* Save default state */
   666		link->aspm_default = link->aspm_enabled;
   667	
   668		/* Setup initial capable state. Will be updated later */
   669		link->aspm_capable = link->aspm_support;
   670	
   671		/* Get and check endpoint acceptable latencies */
   672		list_for_each_entry(child, &linkbus->devices, bus_list) {
   673			if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
   674			    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
   675				continue;
   676	
   677			pcie_aspm_check_latency(child);
   678		}
   679	}
   680	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
