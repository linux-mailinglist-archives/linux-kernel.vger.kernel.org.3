Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCCF4F96AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiDHNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiDHNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:31:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4CB1FA5D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649424567; x=1680960567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r+Y4yo0fhOPVDHnETehVvG2Q7wiOkr4Na3uhKyK78Qw=;
  b=Gzqe0Ui/67iDnYQpU72Gxh+KkDLun07yFfSUsHY2yOs+pfJd1ipsVkme
   JtOPJy3XOOKeFbxdMsj7PYOheDvuBshzUGMWM27d/uLgl1gLFZKhj2ccV
   KABfMPEaVHESnQAjxjy8DKvFuogwzfm1CGB70tgkBSAKz2JCHbxug7Yor
   3VHJ0TxAn4Ok2tQi+C+WL6t/3cinihnqH8kA+V/aDtRGeJIsgcSwlyykP
   nk4RMbk4rbPhjRnZYwxvE58DDp93oc5YzP5Jy+vhHdCWzZTG/z6FcSMyz
   LR1a12AtoOvdgUk+h3iYveAzjTP9YxTRbDBYR1fMwWkMkNfgRDCxFzUUe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="242185755"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="242185755"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="524774971"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2022 06:29:26 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncog1-0000IB-Cm;
        Fri, 08 Apr 2022 13:29:25 +0000
Date:   Fri, 8 Apr 2022 21:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 49/887] drivers/tty/serial/amba-pl011.c:1683:15:
 warning: no previous prototype for 'pl011_clk_round'
Message-ID: <202204082132.LLpePoZa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 6772a88f41ecca42cf47b805ddf28483377792fd [49/887] amba_pl011: Round input clock up
config: arm-randconfig-c002-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082132.LLpePoZa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/6772a88f41ecca42cf47b805ddf28483377792fd
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 6772a88f41ecca42cf47b805ddf28483377792fd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/amba-pl011.c:1683:15: warning: no previous prototype for 'pl011_clk_round' [-Wmissing-prototypes]
    1683 | unsigned long pl011_clk_round(unsigned long clk)
         |               ^~~~~~~~~~~~~~~


vim +/pl011_clk_round +1683 drivers/tty/serial/amba-pl011.c

  1682	
> 1683	unsigned long pl011_clk_round(unsigned long clk)
  1684	{
  1685		unsigned long scaler;
  1686	
  1687		/*
  1688		 * If increasing a clock by less than 0.1% changes it
  1689		 * from ..999.. to ..000.., round up.
  1690		 */
  1691		scaler = 1;
  1692		while (scaler * 100000 < clk)
  1693			scaler *= 10;
  1694		if ((clk + scaler - 1)/scaler % 1000 == 0)
  1695			clk = (clk/scaler + 1) * scaler;
  1696	
  1697		return clk;
  1698	}
  1699	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
