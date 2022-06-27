Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663055E022
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiF0MIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiF0MHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC83DFFD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656331667; x=1687867667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bqipAzGR3DzyIrIbiJ2hoRkEQA/LftRCoI+1meETpL4=;
  b=BqOqwoNXBC8P/yiu/UiyehuLfFh80W8e16HXqm+awBv1IoBvnW3xLtDA
   Q78wjJ9YPE6fZsqOHPj7ZuUPIZqbLUiXI7CuKBYmO4cb98+OP/VRjAkyw
   z/5fQVIs0nASwh6PrZiy0Eaik+kX+oJX18ngvGdxfiT2EaIwUIhb5p0S6
   FtD56ZgaUhSBJLCi88LvwfaS2r5JJqhidYS5dC6MRhXxAdi9JeV5FQ8g9
   HnQr1kOtOPMFT7ZKsoHEx0jsQWeRzRhUoDbIRjoYGtDJbo1bIzgv1A9Gk
   09eBfP2ctBDBuHRfIqftYIt+SmuI5Jmb1TaeGJDtqjXRK6nsxNEF5NQNE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280194097"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="280194097"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 05:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="679559252"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2022 05:07:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5nWq-0008Vv-Rr;
        Mon, 27 Jun 2022 12:07:44 +0000
Date:   Mon, 27 Jun 2022 20:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 18/48] /bin/bash: line 1: -r: command not found
Message-ID: <202206272055.jF8UUVJK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   b5ee1c28376713353cb5355716949d9c6d9b416b
commit: 6357dd11e3450635e52cd27b0edbdb257906a01f [18/48] Kbuild, lto: Add Link Time Optimization support
config: hexagon-randconfig-r041-20220627 (https://download.01.org/0day-ci/archive/20220627/202206272055.jF8UUVJK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=6357dd11e3450635e52cd27b0edbdb257906a01f
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout 6357dd11e3450635e52cd27b0edbdb257906a01f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> /bin/bash: line 1: -r: command not found

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
