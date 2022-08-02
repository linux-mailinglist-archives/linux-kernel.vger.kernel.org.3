Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2982258780B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiHBHmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiHBHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:42:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1EDEB9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659426132; x=1690962132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qxvnqZUJPxU9gKdXMVQy+Fv2y7LtDw3RQ7MYLmUqxY8=;
  b=mnCiKyn4cdA5xQDfejcfZHtI6GqkqzkaLerNQxtKb0jY/0z//Ly8ITyQ
   /b6Clao1Olf+lCHVi/065e6vtPd+v1BSTvFefA1WdZzvTBnbZ2+2ytVk0
   MA1/bR06QTx5J3alRep2FT+YbSagQ61Au68lPxT0ETpxhtHnKTuU8Osle
   w5Wr8aOnU7wFN0wdi2931fbrN2FqhhBzIgkXMwcDKQAnq1ZTu0Yh7K9Y8
   ozqPf8Gk9RvzHllb1n0MM+Mdj9rvYE5LgOev5FYAN0nXWMOvCHuCP3RiL
   j6lvgNzIn6HBCbZnT9pOXvnAlCnJ1JIVmFqz3f0mxqbN7+1pBeicB06Gz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353350908"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="353350908"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="635199616"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 00:42:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oImXZ-000Fpl-12;
        Tue, 02 Aug 2022 07:42:09 +0000
Date:   Tue, 2 Aug 2022 15:41:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongarch-cpu.c:80:9: error: implicit
 declaration of function 'acpi_table_parse_madt'; did you mean
 'acpi_table_parse'?
Message-ID: <202208021521.Z3FSeLUl-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9de1f9c8ca5100a02a2e271bdbde36202e251b4b
commit: b2d3e3354e2a0d0e912308618ea33d0337f405c3 irqchip: Add LoongArch CPU interrupt controller support
date:   13 days ago
config: loongarch-randconfig-r032-20220801 (https://download.01.org/0day-ci/archive/20220802/202208021521.Z3FSeLUl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2d3e3354e2a0d0e912308618ea33d0337f405c3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b2d3e3354e2a0d0e912308618ea33d0337f405c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-loongarch-cpu.c:61:26: warning: 'union acpi_subtable_headers' declared inside parameter list will not be visible outside of this definition or declaration
      61 | liointc_parse_madt(union acpi_subtable_headers *header,
         |                          ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c:70:26: warning: 'union acpi_subtable_headers' declared inside parameter list will not be visible outside of this definition or declaration
      70 | eiointc_parse_madt(union acpi_subtable_headers *header,
         |                          ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c: In function 'acpi_cascade_irqdomain_init':
>> drivers/irqchip/irq-loongarch-cpu.c:80:9: error: implicit declaration of function 'acpi_table_parse_madt'; did you mean 'acpi_table_parse'? [-Werror=implicit-function-declaration]
      80 |         acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         acpi_table_parse
>> drivers/irqchip/irq-loongarch-cpu.c:80:31: error: 'ACPI_MADT_TYPE_LIO_PIC' undeclared (first use in this function); did you mean 'ACPI_MADT_TYPE_IO_APIC'?
      80 |         acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
         |                               ^~~~~~~~~~~~~~~~~~~~~~
         |                               ACPI_MADT_TYPE_IO_APIC
   drivers/irqchip/irq-loongarch-cpu.c:80:31: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/irqchip/irq-loongarch-cpu.c:82:31: error: 'ACPI_MADT_TYPE_EIO_PIC' undeclared (first use in this function); did you mean 'ACPI_MADT_TYPE_IO_APIC'?
      82 |         acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
         |                               ^~~~~~~~~~~~~~~~~~~~~~
         |                               ACPI_MADT_TYPE_IO_APIC
   drivers/irqchip/irq-loongarch-cpu.c: At top level:
   drivers/irqchip/irq-loongarch-cpu.c:87:43: warning: 'union acpi_subtable_headers' declared inside parameter list will not be visible outside of this definition or declaration
      87 | static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/acpi/actbl.h:371,
                    from include/acpi/acpi.h:26,
                    from include/linux/acpi.h:22,
                    from include/linux/irqchip.h:14,
                    from drivers/irqchip/irq-loongarch-cpu.c:10:
>> include/acpi/actbl2.h:33:33: error: expected ')' before string constant
      33 | #define ACPI_SIG_MADT           "APIC"  /* Multiple APIC Description Table */
         |                                 ^~~~~~
   include/linux/irqchip.h:77:43: note: in expansion of macro 'ACPI_SIG_MADT'
      77 |                                           ACPI_SIG_MADT, subtable,      \
         |                                           ^~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c:110:1: note: in expansion of macro 'IRQCHIP_ACPI_DECLARE'
     110 | IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c:87:19: warning: 'cpuintc_acpi_init' defined but not used [-Wunused-function]
      87 | static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
         |                   ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +80 drivers/irqchip/irq-loongarch-cpu.c

    77	
    78	static int __init acpi_cascade_irqdomain_init(void)
    79	{
  > 80		acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
    81				      liointc_parse_madt, 0);
  > 82		acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
    83				      eiointc_parse_madt, 0);
    84		return 0;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
