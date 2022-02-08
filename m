Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340504ADE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352282AbiBHQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBHQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:41:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C47C061576;
        Tue,  8 Feb 2022 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644338514; x=1675874514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5a5FotoyVjq0TaWifYoMNeqBAy4e57dcE6SNhAW5dQ=;
  b=lKvqUYGxS0iYlYQz9za1Y5jsuzi13dI/FP3AnlODKPFLskbuSlGMrK/V
   8gE6F8m6cCE9C3IAiuuyQPC3dh8wWE1oiVI7G/FEcT01lj4WrXKQetgsH
   Jc1FgjmQCK6erP4s9tMt4OakgM/esavvjoikypUinIPD+vgoCvzmY04Ad
   hKdu53lWZyHyLznVbMAGB0lNoop6pGpl8QmLTiB5XrpI+ln+rcGNYr5Mu
   7QFk8nW/BwU4Dl4YQlyaZd85X02LYix3Y1Sh8NHnOqg8/Lq6C9wnoJBvh
   Tcm57kICRQvhoE7T8OSGZfUUdyWlMKadjvs4DBD76ZFtQU6G3fGTfNQAx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232555566"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="232555566"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 08:41:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="499623247"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2022 08:41:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHTYt-0000Rz-4W; Tue, 08 Feb 2022 16:41:51 +0000
Date:   Wed, 9 Feb 2022 00:41:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v2 1/2] usb: typec: tcpm: add interface for passing
 supported_pd_rev from tcpc_dev
Message-ID: <202202090006.YLbevIuT-lkp@intel.com>
References: <20220208112226.9108-2-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208112226.9108-2-potin.lai@quantatw.com>
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

Hi Potin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v5.17-rc3 next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Potin-Lai/usb-typec-tcpm-add-interface-for-passing-supported_pd_rev-from-tcpc_dev/20220208-202246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: hexagon-randconfig-r034-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090006.YLbevIuT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/322696594704fa918e63d1c80fa6d346a02e9a28
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Potin-Lai/usb-typec-tcpm-add-interface-for-passing-supported_pd_rev-from-tcpc_dev/20220208-202246
        git checkout 322696594704fa918e63d1c80fa6d346a02e9a28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/usb/typec/tcpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/tcpm/tcpm.c:581:9: warning: comparison of distinct pointer types ('typeof (rev) *' (aka 'unsigned int *') and 'typeof (2) *' (aka 'int *')) [-Wcompare-distinct-pointer-types]
           return min(rev, PD_MAX_REV);
                  ^~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +581 drivers/usb/typec/tcpm/tcpm.c

   573	
   574	static u32 tcpm_pd_supported_rev(struct tcpm_port *port)
   575	{
   576		u32 rev = PD_MAX_REV;
   577	
   578		if (port->tcpc->supported_pd_rev)
   579			rev = port->tcpc->supported_pd_rev(port->tcpc);
   580	
 > 581		return min(rev, PD_MAX_REV);
   582	}
   583	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
