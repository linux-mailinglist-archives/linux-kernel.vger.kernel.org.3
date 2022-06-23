Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CFC55776A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiFWKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiFWKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:06:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C549F0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655978793; x=1687514793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mvybYqi40HYCHJ9h/gjlh84Ayyf1m4aeyK+wIvr2iXM=;
  b=d18TETY28g07KgCpis1xc+ZxZhi2nmJ+DGSVni2cMYIHL91gLp1PjU/Z
   Eayb4ZDCjKMRNdEdnTYbnzFq6YrTpDflwBXFgC6CSAe/4kSelAt+8WpjQ
   Bamqen90z1GO19a2+5g2jh8f/JO9gRnmSFLhiRP38aCec7qQs4FQB9RYZ
   S186Qfzf3HOq4tgg6iHpxGKUXWk5nTJj60QcgzbWi5nLG0bu7G9jzFI5A
   ABZQF8wxGXyVVQDbMNp48mgvYzlI9wk1+KgOT2RV6mshWd3djTmmcDWVV
   9/ABU28dPzQXY3Gs0jONg0J4JIfCwhXaFCx/QiET+QIgMx763FebuLcKA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344669135"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344669135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644665661"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2022 03:06:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4JjK-00015e-6L;
        Thu, 23 Jun 2022 10:06:30 +0000
Date:   Thu, 23 Jun 2022 18:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 41/49] port.c:undefined reference to
 `dev_attr_create_pmem_region'
Message-ID: <202206231726.IXI7Lpd5-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: 96ec07f789bf8a52f5c00d3310d9b7ec4c701738 [41/49] cxl/region: Allocate host physical address (HPA) capacity to new regions
config: arc-randconfig-r032-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231726.IXI7Lpd5-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=96ec07f789bf8a52f5c00d3310d9b7ec4c701738
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 96ec07f789bf8a52f5c00d3310d9b7ec4c701738
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/cxl/core/port.o: in function `cxl_root_decoder_visible':
>> port.c:(.text+0xd1a): undefined reference to `dev_attr_create_pmem_region'
>> arc-elf-ld: port.c:(.text+0xd1a): undefined reference to `dev_attr_create_pmem_region'
>> arc-elf-ld: port.c:(.text+0xd38): undefined reference to `dev_attr_delete_region'
>> arc-elf-ld: port.c:(.text+0xd38): undefined reference to `dev_attr_delete_region'
>> arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a0): undefined reference to `dev_attr_create_pmem_region'
>> arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a0): undefined reference to `dev_attr_create_pmem_region'
>> arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a4): undefined reference to `dev_attr_delete_region'
>> arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a4): undefined reference to `dev_attr_delete_region'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
