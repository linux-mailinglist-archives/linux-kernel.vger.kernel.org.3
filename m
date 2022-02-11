Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE94B2C47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352417AbiBKR7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:59:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345366AbiBKR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:59:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2ECFF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602343; x=1676138343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=joe1Dny+qovsdKCZL11blzkpqCFavU1IFmPjdYzKK4I=;
  b=kGGFLdZvP3NFT+ct8nyZAs8IGROmaZjUyh/7dcJ3MEMuaFEwZOkMU0DY
   cZbecoc8errISsUcOeVTOo8G6+Fmvd5IcAdhxSHodhQ3cjtUB87JpBL/9
   t7UruqZV/+YWoaC8GM3pG3VneTsBOTNyZFSSRKd7Gx4IcLbs9ndzy4SQi
   AkvetjE5RTdtGlEcs64cklF7NzowHDt0lF5RsS+wEeZ7U2E9IblEwN0rC
   OP7wEQU+aJ+oV/qOBr63DiBn44A7ut4GboalnXQKX+g+Wk6OjeKdE0Ixs
   h91nW9yh1uBc5+ysXKf44o8k44AS5NinFAvh2Zq+2vt8xgWWucIcMjwuI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="233330856"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="233330856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="537709758"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2022 09:59:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaCC-0004u9-VL; Fri, 11 Feb 2022 17:59:00 +0000
Date:   Sat, 12 Feb 2022 01:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 34/35]
 ia64-linux-ld: flush.c:undefined reference to `xa_store_range'
Message-ID: <202202112214.EBzeF3dl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: e9340673baaf1ff587aed3391aa411cf554bc42e [34/35] netfs: Slice a writeback from a dirty region
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220211/202202112214.EBzeF3dl-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e9340673baaf1ff587aed3391aa411cf554bc42e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e9340673baaf1ff587aed3391aa411cf554bc42e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: fs/netfs/flush.o: in function `netfs_flush_get_pages':
   flush.c:(.text.unlikely+0x2a2): undefined reference to `xa_store_range'
>> ia64-linux-ld: flush.c:(.text.unlikely+0x432): undefined reference to `xa_store_range'
   `adc3xxx_i2c_remove' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
