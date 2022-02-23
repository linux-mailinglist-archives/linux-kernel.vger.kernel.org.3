Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF74C2048
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiBWXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiBWXyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:54:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086703B027
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645660434; x=1677196434;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Mf0e2eBXQJHN82IgAISmTACADyQuLrd9vNr/6vogps=;
  b=TrB4p7LZCZHWmonsgGHBtQkg9s+pkqIheMSzkdzoNs4GG9FoDO7WV4/D
   SJ7FUtkccVEfFpUbsJAmoLQZzDPb/0zxdVaiHTPoAQznIW2FwKNQT52IU
   yf4abi0/cGwB1CwbWVySVw7lPITaDUZ3HdwgmjJ80c2qXKfK4CXiZ9wwI
   7n00v0Khr67vIj3dotiS0HXUoqAX+7AxP9MhTLouwzeyxwCnfgSqvC81y
   JBhcSNiW/T5J735IbEDHlyqz+IjkdGsh/tI01mzOKhq9stqNoixfpA/63
   O5EFKBQRKZrh3IkmzT0S4bEMI1Rz8Y5LlzuIrRM3Ht9x/TBiAP9OmfpVd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338547862"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="338547862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="506114190"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 15:53:52 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN1SC-0001z2-5k; Wed, 23 Feb 2022 23:53:52 +0000
Date:   Thu, 24 Feb 2022 07:53:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [miquelraynal:renesas/0-day/uart-dma 15/16] ERROR: modpost:
 "serial8250_rx_dma" [drivers/tty/serial/8250/8250_dw.ko] undefined!
Message-ID: <202202240719.lGPmYS8a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/miquelraynal/linux-0day.git renesas/0-day/uart-dma
head:   cac854e8b055133a489d6aa5ca301cabaf4721a0
commit: 27904fce5a96f06bd80cd303a511ef7c2e9cc11b [15/16] serial: 8250_dw: Add support for RZ/N1 DMA
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220224/202202240719.lGPmYS8a-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/miquelraynal/linux-0day/commit/27904fce5a96f06bd80cd303a511ef7c2e9cc11b
        git remote add miquelraynal https://github.com/miquelraynal/linux-0day.git
        git fetch --no-tags miquelraynal renesas/0-day/uart-dma
        git checkout 27904fce5a96f06bd80cd303a511ef7c2e9cc11b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "serial8250_rx_dma" [drivers/tty/serial/8250/8250_dw.ko] undefined!
>> ERROR: modpost: "serial8250_tx_dma" [drivers/tty/serial/8250/8250_dw.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
