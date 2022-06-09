Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACA545612
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiFIU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiFIU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:59:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE080247076
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654808339; x=1686344339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SIIrenfbdVYvsmeA88bEpmXD3GGdFN0sjDFRgWiUWlg=;
  b=LN1cU5nPGINTf7l/Cvs4V/pYjRn2jQSqqN5AugqSQmzqCr/abprTUeyA
   nTVuG3Xg28AKSPixlxZkiZ+G7bs34sw3FAoLudSj6prvCnXqxGnM6vT3I
   Z3RvaktRfiaHG/78R1NqixOQH3k94oDEepqNiT1duet6JjDCYlTuskhKt
   7E0oRCRJofv+3lKyOIeFBAa8ridTGUhpEQfNWRCiCZ/Fslr2csZv++ZHQ
   1sSRH1Z4CEmc9tgzmwLq4B2pCjZuprRZbMaIcVW2JLkyMQ9ICQlfRl40h
   NSvK49/tj6cvDenzvppHuwrL+cy02GjYx2hQjrh8TdZ05Y5Sw5Feq1yRR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302789147"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="302789147"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 13:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637733488"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2022 13:58:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzPEu-000GNh-LA;
        Thu, 09 Jun 2022 20:58:48 +0000
Date:   Fri, 10 Jun 2022 04:58:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/test/ctl-xarray 8/8] ld.lld: error:
 undefined symbol: xa_store_range
Message-ID: <202206100457.ZFP279WB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/test/ctl-xarray
head:   2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
commit: 2abf12b6cfb00c1904dc99425ad19a6c03a1fef3 [8/8] ALSA: control: Use xarray for faster lookups
config: hexagon-randconfig-r045-20220609 (https://download.01.org/0day-ci/archive/20220610/202206100457.ZFP279WB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/test/ctl-xarray
        git checkout 2abf12b6cfb00c1904dc99425ad19a6c03a1fef3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: xa_store_range
   >>> referenced by control.c
   >>>               core/control.o:(add_hash_entries) in archive sound/built-in.a
   >>> referenced by control.c
   >>>               core/control.o:(add_hash_entries) in archive sound/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
