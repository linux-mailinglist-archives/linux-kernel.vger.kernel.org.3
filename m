Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3358849E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiHBXCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiHBXCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:02:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6312ED4E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659481359; x=1691017359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2kjK7mo90xJZqmAGmESUzL/G2j/5ibmbz3drDPmRQ4M=;
  b=XR8N/WmZZVAX138idpnIQjiuh7leTnchg9U+Ypk4ahkvEjgfMHmYHC6e
   UBH9vlmz1mWC1wKmcmTN6mkgEQLVKaUCiXfGxCxIT0DcWLc1gotpg55US
   +TSMEpHulV/VVzfmVbpuVMH74Ryc9w+83+8DcWml+iOpk98/FZO9nNnCI
   c7XuKm/bFUrVl80/stfobH6PFn5GomI1cbvywijNu60z+1Orji8BcRnxB
   qiwIiZSrsXQKbRWPVKIeLCplsAxfBBK6AlD3GOViH9yRt8+4G4uJzpRWa
   IbwL6Tq4CS7pNvKEpaBdCHnVs9dXTDFqs4sKIpNjcw3AmeCcGbj5klbJ1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315391314"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315391314"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 16:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="778785365"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2022 16:02:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ0uL-000GXf-14;
        Tue, 02 Aug 2022 23:02:37 +0000
Date:   Wed, 3 Aug 2022 07:02:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongson-eiointc.c:289:20: warning: no previous
 prototype for 'acpi_get_vec_parent'
Message-ID: <202208030600.u3ehRjUE-lkp@intel.com>
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
head:   c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a
commit: dd281e1a1a937ee2f13bd0db5be78e5f5b811ca7 irqchip: Add Loongson Extended I/O interrupt controller support
date:   2 weeks ago
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208030600.u3ehRjUE-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/irqchip/ drivers/platform/surface/aggregator/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-loongson-eiointc.c:289:20: warning: no previous prototype for 'acpi_get_vec_parent' [-Wmissing-prototypes]
     289 | struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
         |                    ^~~~~~~~~~~~~~~~~~~


vim +/acpi_get_vec_parent +289 drivers/irqchip/irq-loongson-eiointc.c

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
