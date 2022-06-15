Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11E54BF63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbiFOBqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFOBqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:46:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF053139B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655257559; x=1686793559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0xKjN/5gZiGAcLXFN6X+sok33cvNFf8IGgqCdZkuFH8=;
  b=JIDHN3vcjSdmnAy9oKUaJfFtpcA9hEt5W5xosBfOvTCrSCkvhB7zQZz0
   p49zULku/x0rY8NOwPuDzenARA0f8ub9K1OVPIfI0xOHwH/AevQeY/SlQ
   QVfcPYsIY/IXSIKqtmq8dN/IiPtZfZEiTs8A5NBG0yTMSqlw8MoruQE4H
   sTNZv4Gv+xGXa5Em+LRIgVQwrXugJ9/wYe4r6S0aYiTLF7gwPl6otie1N
   RWlPupKQkUnK946R/Qm99zKWmfs3rAs1lAMO0vPKftyKcGzhFfmNVce5R
   kHHAAArv4DC2rPIMr/f16Z3z532Yobgxae3Y2fEyTyKhInFSle5LgLjf9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365144563"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="365144563"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 18:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588812098"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 18:45:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1I6X-000MTT-5t;
        Wed, 15 Jun 2022 01:45:57 +0000
Date:   Wed, 15 Jun 2022 09:45:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:clearfog 8/9] drivers/pci/pcie/aspm.c:589
 pcie_aspm_cap_init() warn: inconsistent indenting
Message-ID: <202206150955.DiuhWInt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   906ef161f18ff8013de7386bcc9801a77c560b1f
commit: e7aeb8cfe111a18dc5494f84d703f6df88218d69 [8/9] mvebu/clearfog pcie updates
config: x86_64-randconfig-m001-20220613 (https://download.01.org/0day-ci/archive/20220615/202206150955.DiuhWInt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
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
