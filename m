Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E04D2AD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiCIIqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCIIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:46:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC591617EC;
        Wed,  9 Mar 2022 00:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646815503; x=1678351503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwdrdtIz1xZUJ3NnrUm2mtAL8wyUtGdo/sQn/e6jGLw=;
  b=BgCd8HJbxykinzx7MuWUiWlMHd3WIx8eiFfsSOcUeB5yRyM77YA9kQSH
   3SdbXtumQLfaGxJob2q8Ptwt0AGr/xjSSj11gy9TkjTApuQmJGopFERqG
   iSsGPvh+00Jqj6MKIVlI5nk3sYRMBWtcHzNiv9Ox7Anofx+fSSK117xxq
   LrIprzFKlrzKzrdAp3SvWvxvYuf1FGknP2COxNNCAtIEQCtr+okZtW3Hd
   Afvwd/ciDJIBtWlER14li2pFyIJ4W+2iBHuPv/MDzIohPdI5FMRL596cB
   fniE7eD4XcOo7c/ADDTHjYeTexpmgm8vzrYnYAYxfznwTgwhtP6hO8ja8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242367230"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="242367230"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:45:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="495767951"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2022 00:45:00 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRrwJ-0002wq-Iz; Wed, 09 Mar 2022 08:44:59 +0000
Date:   Wed, 9 Mar 2022 16:44:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     kbuild-all@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] pata_parport: add core driver (PARIDE replacement)
Message-ID: <202203091613.dsoQnVk9-lkp@intel.com>
References: <20220305201411.501-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305201411.501-2-linux@zary.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hch-configfs/for-next]
[also build test ERROR on linux/master linus/master v5.17-rc7 next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ondrej-Zary/pata_parport-add-core-driver-PARIDE-replacement/20220307-142912
base:   git://git.infradead.org/users/hch/configfs.git for-next
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203091613.dsoQnVk9-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/05539e2a04721c2710e7d1f6ae49926474bdf918
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ondrej-Zary/pata_parport-add-core-driver-PARIDE-replacement/20220307-142912
        git checkout 05539e2a04721c2710e7d1f6ae49926474bdf918
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/block/paride/paride.o: in function `pi_release':
>> (.text+0x600): multiple definition of `pi_release'; drivers/ata/pata_parport/pata_parport.o:(.text+0x36c0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
