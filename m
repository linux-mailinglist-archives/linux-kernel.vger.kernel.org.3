Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046EF5874C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiHBAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHBAX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:23:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2283F27
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659399838; x=1690935838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8siIZYIvJgQacjUBU8FoE+u5AO0D3uOwTzZGvH99QHY=;
  b=VtZR9vrCTYLNg9wZ9cd5j9knbZSGW1S78DxXxx/ptcqEjnzTWkJ9B1kX
   kNuXB3XSXNWpHz/O7JFwFOMpSY6E1wDuq6r1lTDOXQBIqD1uVjl+Dzenn
   J1Zj3l8lFSjen444oG+4pu9u0kTrQHbd2pTaI/24YRUZigW8/goI2rmY9
   JlAidRg4CGKXz1wCjbwbSgpZRwCR7W7S0ZP/3+DyQSeE2rr6/fZfjmC0V
   VhAegIDOEV+hGjr3xpJCwaz9U/1jLUMMxYspv2eBix/UNjwHm4v6AbCJL
   Tw6eA3T5YpT4167QrWQiyaZfoX+qh2wsmZXwllyxOo9i6y8Gyq05bgxzg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315118015"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="315118015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 17:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="577991448"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2022 17:23:56 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIfhU-000FVn-0W;
        Tue, 02 Aug 2022 00:23:56 +0000
Date:   Tue, 2 Aug 2022 08:23:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongson-eiointc.c:305:42: error: invalid use of
 undefined type 'struct acpi_madt_bio_pic'
Message-ID: <202208020817.G8vpKIfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9de1f9c8ca5100a02a2e271bdbde36202e251b4b
commit: dd281e1a1a937ee2f13bd0db5be78e5f5b811ca7 irqchip: Add Loongson Extended I/O interrupt controller support
date:   13 days ago
config: loongarch-randconfig-r032-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020817.G8vpKIfp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd281e1a1a937ee2f13bd0db5be78e5f5b811ca7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd281e1a1a937ee2f13bd0db5be78e5f5b811ca7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-loongson-eiointc.c:289:20: warning: no previous prototype for 'acpi_get_vec_parent' [-Wmissing-prototypes]
     289 | struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
         |                    ^~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c:301:26: warning: 'union acpi_subtable_headers' declared inside parameter list will not be visible outside of this definition or declaration
     301 | pch_pic_parse_madt(union acpi_subtable_headers *header,
         |                          ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c: In function 'pch_pic_parse_madt':
>> drivers/irqchip/irq-loongson-eiointc.c:305:42: error: invalid use of undefined type 'struct acpi_madt_bio_pic'
     305 |         unsigned int node = (pchpic_entry->address >> 44) & 0xf;
         |                                          ^~
   drivers/irqchip/irq-loongson-eiointc.c: At top level:
   drivers/irqchip/irq-loongson-eiointc.c:315:26: warning: 'union acpi_subtable_headers' declared inside parameter list will not be visible outside of this definition or declaration
     315 | pch_msi_parse_madt(union acpi_subtable_headers *header,
         |                          ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c: In function 'acpi_cascade_irqdomain_init':
>> drivers/irqchip/irq-loongson-eiointc.c:329:9: error: implicit declaration of function 'acpi_table_parse_madt'; did you mean 'acpi_table_parse'? [-Werror=implicit-function-declaration]
     329 |         acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         acpi_table_parse
>> drivers/irqchip/irq-loongson-eiointc.c:329:31: error: 'ACPI_MADT_TYPE_BIO_PIC' undeclared (first use in this function); did you mean 'ACPI_MADT_TYPE_IO_APIC'?
     329 |         acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
         |                               ^~~~~~~~~~~~~~~~~~~~~~
         |                               ACPI_MADT_TYPE_IO_APIC
   drivers/irqchip/irq-loongson-eiointc.c:329:31: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/irqchip/irq-loongson-eiointc.c:331:31: error: 'ACPI_MADT_TYPE_MSI_PIC' undeclared (first use in this function); did you mean 'ACPI_MADT_TYPE_IO_APIC'?
     331 |         acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
         |                               ^~~~~~~~~~~~~~~~~~~~~~
         |                               ACPI_MADT_TYPE_IO_APIC
   drivers/irqchip/irq-loongson-eiointc.c: In function 'eiointc_acpi_init':
>> drivers/irqchip/irq-loongson-eiointc.c:353:34: error: invalid use of undefined type 'struct acpi_madt_eio_pic'
     353 |         priv->node = acpi_eiointc->node;
         |                                  ^~
   drivers/irqchip/irq-loongson-eiointc.c:354:32: error: invalid use of undefined type 'struct acpi_madt_eio_pic'
     354 |         node_map = acpi_eiointc->node_map ? : -1ULL;
         |                                ^~
   drivers/irqchip/irq-loongson-eiointc.c:375:61: error: invalid use of undefined type 'struct acpi_madt_eio_pic'
     375 |         parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
         |                                                             ^~
   drivers/irqchip/irq-loongson-eiointc.c:382:41: error: invalid use of undefined type 'struct acpi_madt_eio_pic'
     382 |         acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
         |                                         ^~
   drivers/irqchip/irq-loongson-eiointc.c:383:41: error: invalid use of undefined type 'struct acpi_madt_eio_pic'
     383 |         acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
         |                                         ^~
   cc1: some warnings being treated as errors


vim +305 drivers/irqchip/irq-loongson-eiointc.c

   288	
 > 289	struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
   290	{
   291		int i;
   292	
   293		for (i = 0; i < MAX_IO_PICS; i++) {
   294			if (node == vec_group[i].node)
   295				return vec_group[i].parent;
   296		}
   297		return NULL;
   298	}
   299	
   300	static int __init
   301	pch_pic_parse_madt(union acpi_subtable_headers *header,
   302			       const unsigned long end)
   303	{
   304		struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
 > 305		unsigned int node = (pchpic_entry->address >> 44) & 0xf;
   306		struct irq_domain *parent = acpi_get_vec_parent(node, pch_group);
   307	
   308		if (parent)
   309			return pch_pic_acpi_init(parent, pchpic_entry);
   310	
   311		return -EINVAL;
   312	}
   313	
   314	static int __init
 > 315	pch_msi_parse_madt(union acpi_subtable_headers *header,
   316			       const unsigned long end)
   317	{
   318		struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
   319		struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
   320	
   321		if (parent)
   322			return pch_msi_acpi_init(parent, pchmsi_entry);
   323	
   324		return -EINVAL;
   325	}
   326	
   327	static int __init acpi_cascade_irqdomain_init(void)
   328	{
 > 329		acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
   330				      pch_pic_parse_madt, 0);
 > 331		acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
   332				      pch_msi_parse_madt, 1);
   333		return 0;
   334	}
   335	
   336	int __init eiointc_acpi_init(struct irq_domain *parent,
   337					     struct acpi_madt_eio_pic *acpi_eiointc)
   338	{
   339		int i, parent_irq;
   340		unsigned long node_map;
   341		struct eiointc_priv *priv;
   342	
   343		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
   344		if (!priv)
   345			return -ENOMEM;
   346	
   347		priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_eiointc);
   348		if (!priv->domain_handle) {
   349			pr_err("Unable to allocate domain handle\n");
   350			goto out_free_priv;
   351		}
   352	
 > 353		priv->node = acpi_eiointc->node;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
