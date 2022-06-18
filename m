Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED84550737
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiFRWCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiFRWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:02:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC32CD;
        Sat, 18 Jun 2022 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655589758; x=1687125758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qtYBGi61sstW4pA7LP1jBpa+MIJmaL/05wNAVmBxe0E=;
  b=NazcHXzOzHBssQKcUFzm2kg+00Jkup+MrJN2At7+gxh/vrab5hdWVGOp
   DDKNgmovJSEA9i5wfO/EhrOn8Y1g6V6OM8fm6VmBhp92VXRUB8nnKvJ3q
   PBT7oZKL4ZRUQVvHTFOZ1lMhxFmjMrWLSjvUdykErP7AqxvLq7KEI8HxE
   g0zE+38WsyrlvDovRixd99DMFtXCt/3h82ziau3x9tuVTl9LU2JTeiMa9
   MsYEObr5jN5A42f9L0GG8Mz7GpA0YjCQ9A2GpYb6VLqJEUvS1seYK/2+d
   vp5N5MHgd3W+fHwfNIRPF/mEYnrJuIRhi8X2mEKQnDKtHeFXanNvmMojY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280414299"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280414299"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 15:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590610945"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2022 15:02:34 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2gWX-000Qcp-Jt;
        Sat, 18 Jun 2022 22:02:33 +0000
Date:   Sun, 19 Jun 2022 06:02:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <202206190533.0uzpvGYN-lkp@intel.com>
References: <20220618195031.10975-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618195031.10975-1-max@enpas.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

I love your patch! Yet something to improve:

[auto build test ERROR on mkl-can-next/testing]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Staudt/can-tty-can327-CAN-ldisc-driver-for-ELM327-based-OBD-II-adapters/20220619-035333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220619/202206190533.0uzpvGYN-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2338446348d90b3793e53238f210299f13bf6ec4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Max-Staudt/can-tty-can327-CAN-ldisc-driver-for-ELM327-based-OBD-II-adapters/20220619-035333
        git checkout 2338446348d90b3793e53238f210299f13bf6ec4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/net/can/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/can/can327.c:1104:27: error: 'N_CAN327' undeclared here (not in a function)
    1104 |         .num            = N_CAN327,
         |                           ^~~~~~~~


vim +/N_CAN327 +1104 drivers/net/can/can327.c

  1100	
  1101	static struct tty_ldisc_ops can327_ldisc = {
  1102		.owner		= THIS_MODULE,
  1103		.name		= "can327",
> 1104		.num		= N_CAN327,
  1105		.receive_buf	= can327_ldisc_rx,
  1106		.write_wakeup	= can327_ldisc_tx_wakeup,
  1107		.open		= can327_ldisc_open,
  1108		.close		= can327_ldisc_close,
  1109		.ioctl		= can327_ldisc_ioctl,
  1110	};
  1111	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
