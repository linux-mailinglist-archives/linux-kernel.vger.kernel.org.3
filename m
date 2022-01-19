Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDC493E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356146AbiASQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:37:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:15865 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239093AbiASQhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642610266; x=1674146266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qsg5yYZeqEXKNTcPd+VbPYg9nPFZfX5hlmIWtJ9zrsA=;
  b=lM0HQunp4/8X1qkK7yfVoox9h9pny0aiD/FQV21JgrhXw0TgcdpHRXhl
   ow9k96ZykQDMYVZOu2QBDii2a1s4ETnD5fHN7CGw6MEUNaH1gVclD6EVq
   IaPD0ubCE68bN8IbA2ay00lhxvZVNts8JOI1QfvjLO6ETMPsw2u6UySXx
   elt6NdK4N6aiqTkeHzFoBjewmOkdJCIQ3ZHzSXdpb4jU8vMHhptCaKfiv
   SNH6ilQCRQOgmUhgJS3LDMQwOrSO3IT8d6EfbUaHONHCNLJPNmMAiDS+d
   wNjLqHx0vvTPIGO/Gx5kBNuR5kJoANSl2iWK9vZDf2oPuuWHoa9sh1e+v
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305838540"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="305838540"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="493084022"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2022 08:37:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nADxm-000De3-Tf; Wed, 19 Jan 2022 16:37:34 +0000
Date:   Thu, 20 Jan 2022 00:37:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <202201200042.BIqTHWGV-lkp@intel.com>
References: <20220119110141.1020452-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119110141.1020452-2-xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next peter-chen-usb/for-usb-next v5.16 next-20220118]
[cannot apply to balbi-usb/testing/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xin-Ji/dt-bindings-usb-Add-analogix-anx7411-PD-binding/20220119-190352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220120/202201200042.BIqTHWGV-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/760b0d28447fcaef7a39a20ebce9a4fb96cc0c7d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xin-Ji/dt-bindings-usb-Add-analogix-anx7411-PD-binding/20220119-190352
        git checkout 760b0d28447fcaef7a39a20ebce9a4fb96cc0c7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/typec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/anx7411.c:835:6: warning: no previous prototype for function 'anx7411_port_unregister_altmodes' [-Wmissing-prototypes]
   void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
        ^
   drivers/usb/typec/anx7411.c:835:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
   ^
   static 
   1 warning generated.


vim +/anx7411_port_unregister_altmodes +835 drivers/usb/typec/anx7411.c

   834	
 > 835	void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
   836	{
   837		int i;
   838	
   839		for (i = 0; i < MAX_ALTMODE; i++)
   840			if (adev[i]) {
   841				typec_unregister_altmode(adev[i]);
   842				adev[i] = NULL;
   843			}
   844	}
   845	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
