Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F54C9106
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiCARBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiCARBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:01:04 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155C811A2E;
        Tue,  1 Mar 2022 09:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646154023; x=1677690023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VhC8QHxpiYe2QNMS+J1jnkfhl2jLLg1QePMyLDV5kI=;
  b=GrKCJ3DLy+1bQN6QeQupAUj004X+H8QYin4dGF2f29kwQOEmSU12ViQC
   vKKz7idbhD8jif5NZUdxXe9sug8QQgnWLYIG9IQxaSIRbds+iw/w4WMoB
   tx07AG+jpqpOZDxqxNXZgTPwRuiY9BUwL5C2m9SzXSTW6ZtaGLTPB8dwX
   8rcCmoB4BNI4Q5v27TOi7iC/6zC8FxTeXCD5lPBhRLZosoMefGrUVcoS2
   WdCHpZZGtKRzabZBvzauhmLhQwnFdLAQ8fun1q468abh0d3/3oHU7N/KD
   gb+OEq62Nh4t0Ty4Yz10EBVj4nkmwIBQXhpSDA3gn6Du+Pp6+sTL6tYdj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="313901076"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="313901076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="593661381"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2022 08:58:45 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP5pk-0000lx-Pu; Tue, 01 Mar 2022 16:58:44 +0000
Date:   Wed, 2 Mar 2022 00:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: add TUSB320xA driver
Message-ID: <202203020056.igXsHYzi-lkp@intel.com>
References: <20220301132010.115258-4-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301132010.115258-4-alvin@pqrs.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Alvin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.17-rc6 next-20220301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alvin-ipraga/usb-typec-add-drivers-for-TUSB320xA-and-TS5USBA224/20220301-212251
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220302/202203020056.igXsHYzi-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c60eb902fdeaef99cf2c10e84e0369ee6787753a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alvin-ipraga/usb-typec-add-drivers-for-TUSB320xA-and-TS5USBA224/20220301-212251
        git checkout c60eb902fdeaef99cf2c10e84e0369ee6787753a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/usb/typec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/tusb320xa.c:407:6: warning: no previous prototype for 'tusb320xa_action_role_sw_put' [-Wmissing-prototypes]
     407 | void tusb320xa_action_role_sw_put(void *data)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/typec/tusb320xa.c:414:6: warning: no previous prototype for 'tusb320xa_action_unregister_port' [-Wmissing-prototypes]
     414 | void tusb320xa_action_unregister_port(void *data)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tusb320xa_action_role_sw_put +407 drivers/usb/typec/tusb320xa.c

   406	
 > 407	void tusb320xa_action_role_sw_put(void *data)
   408	{
   409		struct usb_role_switch *role_sw = data;
   410	
   411		usb_role_switch_put(role_sw);
   412	}
   413	
 > 414	void tusb320xa_action_unregister_port(void *data)
   415	{
   416		struct typec_port *port = data;
   417	
   418		typec_unregister_port(port);
   419	}
   420	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
