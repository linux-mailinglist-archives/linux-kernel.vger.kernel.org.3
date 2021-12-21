Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347EE47BA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhLUG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:59:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:47726 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233417AbhLUG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640069990; x=1671605990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q6RYnL7IrkHxTSon8eUfbE36kDzDE90zysiK8gdO0rA=;
  b=CsCPeJAFmGWyalqI+JELkMHnACemCBb5eDzJgF3E03AH6X191F+TD+Ek
   51jNTmcJG1/0Hnk0BJNXlm1a/D7FrB8WD97mKEKUGaXqvt8nhzKiF6UL1
   5PutDyYVCN5QbiEfGMgj32jbnTHEyyndjWiSetph9IKOYRBMh7krlByMg
   0SvqhzxavkGMGUsYB2AfrWDE509VPsbg5WrtTR8AWSpfqkHDAm8oW0vxN
   jzR//w+Z0YUhFoFWBNIz2358KzZLRnu2eLVDNNkixBrc+fD7egl6WNpzV
   itaFrrWN4SKmnZyUBcUwPXOxHL1HdQrJYdzqqAqMeBaSt8hyLoFqbY+Lr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303710159"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="303710159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 22:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="570121422"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2021 22:59:48 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzZ7j-0008nL-Cw; Tue, 21 Dec 2021 06:59:47 +0000
Date:   Tue, 21 Dec 2021 14:59:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [sudeep-holla:for-next/scmi 19/27]
 drivers/firmware/arm_scmi/driver.c:869:6: warning: variable 'i_' is
 uninitialized when used within its own initialization
Message-ID: <202112211457.TlWRYcoq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for-next/scmi
head:   b18b2e9bcbdfbec337f88267758b60450ba4f652
commit: e1f2ef036d0fd69a1c6482f80ca8a827d3dfc5a8 [19/27] firmware: arm_scmi: Add sync_cmds_completed_on_ret transport flag
config: arm-randconfig-r031-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211457.TlWRYcoq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?id=e1f2ef036d0fd69a1c6482f80ca8a827d3dfc5a8
        git remote add sudeep-holla https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
        git fetch --no-tags sudeep-holla for-next/scmi
        git checkout e1f2ef036d0fd69a1c6482f80ca8a827d3dfc5a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/firmware/arm_scmi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/arm_scmi/driver.c:869:6: warning: variable 'i_' is uninitialized when used within its own initialization [-Wuninitialized]
           if (IS_POLLING_ENABLED(cinfo, info))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/arm_scmi/driver.c:59:33: note: expanded from macro 'IS_POLLING_ENABLED'
                           IS_TRANSPORT_POLLING_CAPABLE(i_));              \
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/firmware/arm_scmi/driver.c:45:19: note: expanded from macro 'IS_TRANSPORT_POLLING_CAPABLE'
           typeof(__i) i_ = __i;                                           \
                       ~~   ^~~
   1 warning generated.


vim +/i_ +869 drivers/firmware/arm_scmi/driver.c

5a731aebd31bf8 Cristian Marussi 2021-11-29  837  
aa4f886f3893f8 Sudeep Holla     2017-03-28  838  /**
a4a20b0975dc7b Cristian Marussi 2021-03-16  839   * do_xfer() - Do one transfer
aa4f886f3893f8 Sudeep Holla     2017-03-28  840   *
a4a20b0975dc7b Cristian Marussi 2021-03-16  841   * @ph: Pointer to SCMI protocol handle
aa4f886f3893f8 Sudeep Holla     2017-03-28  842   * @xfer: Transfer to initiate and wait for response
aa4f886f3893f8 Sudeep Holla     2017-03-28  843   *
aa4f886f3893f8 Sudeep Holla     2017-03-28  844   * Return: -ETIMEDOUT in case of no response, if transmit error,
aa4f886f3893f8 Sudeep Holla     2017-03-28  845   *	return corresponding error, else if all goes well,
aa4f886f3893f8 Sudeep Holla     2017-03-28  846   *	return 0.
aa4f886f3893f8 Sudeep Holla     2017-03-28  847   */
a4a20b0975dc7b Cristian Marussi 2021-03-16  848  static int do_xfer(const struct scmi_protocol_handle *ph,
a4a20b0975dc7b Cristian Marussi 2021-03-16  849  		   struct scmi_xfer *xfer)
aa4f886f3893f8 Sudeep Holla     2017-03-28  850  {
aa4f886f3893f8 Sudeep Holla     2017-03-28  851  	int ret;
a4a20b0975dc7b Cristian Marussi 2021-03-16  852  	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
a4a20b0975dc7b Cristian Marussi 2021-03-16  853  	struct scmi_info *info = handle_to_scmi_info(pi->handle);
aa4f886f3893f8 Sudeep Holla     2017-03-28  854  	struct device *dev = info->dev;
907b6d14911db0 Sudeep Holla     2017-07-31  855  	struct scmi_chan_info *cinfo;
907b6d14911db0 Sudeep Holla     2017-07-31  856  
a287126c31ab68 Cristian Marussi 2021-12-20  857  	/* Check for polling request on custom command xfers at first */
e1f2ef036d0fd6 Cristian Marussi 2021-12-20  858  	if (xfer->hdr.poll_completion && !IS_TRANSPORT_POLLING_CAPABLE(info)) {
2930abcffd9f0b Cristian Marussi 2021-08-03  859  		dev_warn_once(dev,
2930abcffd9f0b Cristian Marussi 2021-08-03  860  			      "Polling mode is not supported by transport.\n");
2930abcffd9f0b Cristian Marussi 2021-08-03  861  		return -EINVAL;
2930abcffd9f0b Cristian Marussi 2021-08-03  862  	}
2930abcffd9f0b Cristian Marussi 2021-08-03  863  
d211ddeb511af5 Cristian Marussi 2021-11-29  864  	cinfo = idr_find(&info->tx_idr, pi->proto->id);
d211ddeb511af5 Cristian Marussi 2021-11-29  865  	if (unlikely(!cinfo))
d211ddeb511af5 Cristian Marussi 2021-11-29  866  		return -EINVAL;
d211ddeb511af5 Cristian Marussi 2021-11-29  867  
a287126c31ab68 Cristian Marussi 2021-12-20  868  	/* True ONLY if also supported by transport. */
a287126c31ab68 Cristian Marussi 2021-12-20 @869  	if (IS_POLLING_ENABLED(cinfo, info))
a287126c31ab68 Cristian Marussi 2021-12-20  870  		xfer->hdr.poll_completion = true;
a287126c31ab68 Cristian Marussi 2021-12-20  871  
a4a20b0975dc7b Cristian Marussi 2021-03-16  872  	/*
61832b35b4d953 Sudeep Holla     2021-06-08  873  	 * Initialise protocol id now from protocol handle to avoid it being
a4a20b0975dc7b Cristian Marussi 2021-03-16  874  	 * overridden by mistake (or malice) by the protocol code mangling with
61832b35b4d953 Sudeep Holla     2021-06-08  875  	 * the scmi_xfer structure prior to this.
a4a20b0975dc7b Cristian Marussi 2021-03-16  876  	 */
a4a20b0975dc7b Cristian Marussi 2021-03-16  877  	xfer->hdr.protocol_id = pi->proto->id;
e30d91d4ffda0b Cristian Marussi 2021-06-06  878  	reinit_completion(&xfer->done);
a4a20b0975dc7b Cristian Marussi 2021-03-16  879  
729d3530a50417 Lukasz Luba      2019-12-17  880  	trace_scmi_xfer_begin(xfer->transfer_id, xfer->hdr.id,
729d3530a50417 Lukasz Luba      2019-12-17  881  			      xfer->hdr.protocol_id, xfer->hdr.seq,
729d3530a50417 Lukasz Luba      2019-12-17  882  			      xfer->hdr.poll_completion);
729d3530a50417 Lukasz Luba      2019-12-17  883  
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  884  	xfer->state = SCMI_XFER_SENT_OK;
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  885  	/*
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  886  	 * Even though spinlocking is not needed here since no race is possible
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  887  	 * on xfer->state due to the monotonically increasing tokens allocation,
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  888  	 * we must anyway ensure xfer->state initialization is not re-ordered
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  889  	 * after the .send_message() to be sure that on the RX path an early
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  890  	 * ISR calling scmi_rx_callback() cannot see an old stale xfer->state.
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  891  	 */
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  892  	smp_mb();
ed7c04c1fea3b0 Cristian Marussi 2021-08-03  893  
5c8a47a5a91d4d Viresh Kumar     2020-01-31  894  	ret = info->desc->ops->send_message(cinfo, xfer);
aa4f886f3893f8 Sudeep Holla     2017-03-28  895  	if (ret < 0) {
5c8a47a5a91d4d Viresh Kumar     2020-01-31  896  		dev_dbg(dev, "Failed to send message %d\n", ret);
aa4f886f3893f8 Sudeep Holla     2017-03-28  897  		return ret;
aa4f886f3893f8 Sudeep Holla     2017-03-28  898  	}
aa4f886f3893f8 Sudeep Holla     2017-03-28  899  
5a731aebd31bf8 Cristian Marussi 2021-11-29  900  	ret = scmi_wait_for_message_response(cinfo, xfer);
d4c3751a8de2de Sudeep Holla     2017-07-20  901  	if (!ret && xfer->hdr.status)
d4c3751a8de2de Sudeep Holla     2017-07-20  902  		ret = scmi_to_linux_errno(xfer->hdr.status);
d4c3751a8de2de Sudeep Holla     2017-07-20  903  
5c8a47a5a91d4d Viresh Kumar     2020-01-31  904  	if (info->desc->ops->mark_txdone)
5c8a47a5a91d4d Viresh Kumar     2020-01-31  905  		info->desc->ops->mark_txdone(cinfo, ret);
aa4f886f3893f8 Sudeep Holla     2017-03-28  906  
729d3530a50417 Lukasz Luba      2019-12-17  907  	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
bad0d73b657412 Sudeep Holla     2020-06-09  908  			    xfer->hdr.protocol_id, xfer->hdr.seq, ret);
729d3530a50417 Lukasz Luba      2019-12-17  909  
aa4f886f3893f8 Sudeep Holla     2017-03-28  910  	return ret;
aa4f886f3893f8 Sudeep Holla     2017-03-28  911  }
aa4f886f3893f8 Sudeep Holla     2017-03-28  912  

:::::: The code at line 869 was first introduced by commit
:::::: a287126c31ab68315ff9e785cc70ed7880b53a77 firmware: arm_scmi: Add configurable polling mode for transports

:::::: TO: Cristian Marussi <cristian.marussi@arm.com>
:::::: CC: Sudeep Holla <sudeep.holla@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
