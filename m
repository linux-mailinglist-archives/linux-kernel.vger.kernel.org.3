Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38A4E2C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350360AbiCUPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350350AbiCUPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:37:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FBF66CBA;
        Mon, 21 Mar 2022 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647876966; x=1679412966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lSDashDNH9eIHMNCJgAgiFFxMUd2Ab7RBOmLmw1UzaA=;
  b=PgaayNVlRWACd+OP8l+19f7kJfBGUY9sv7uci66Jxdpd9JpvfzlCHox2
   xtCrPhx9hRUTBf2X65gojHQH/5Lkv1QSZQhN2etx5l/JnPJ7V5CpRGMy5
   miP9YX8gpOjO6n0RK2MmbNxFuWqtYNZjH9vJgnmhs+hbc9AxkE9dnsJo/
   D3jXo7uctkYGrAJTv97ovvKWvLp0F3PSEIZKTTRfOzKnnArmUvyubfAu2
   fb9xclsIxTA5iwFcRJlbtcw8hspsbDW81dlpSkVcEVge+oLQpbWbsHK0d
   MEN9FIEZ6D8DvEDGr5Ry0D1+2CJMfpdoeGozHu6rIFGfrFpSrN57LWfT/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="282407403"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="282407403"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="636684757"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2022 08:36:03 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWK4g-000HwT-L1; Mon, 21 Mar 2022 15:36:02 +0000
Date:   Mon, 21 Mar 2022 23:35:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 1/4] usb: host: export symbols for xhci hooks usage
Message-ID: <202203212326.t8A838in-lkp@intel.com>
References: <1647853194-62147-2-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647853194-62147-2-git-send-email-dh10.jung@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220318]
[also build test WARNING on v5.17]
[cannot apply to usb/usb-testing krzk/for-next char-misc/char-misc-testing v5.17 v5.17-rc8 v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220321-180046
base:    6d72dda014a4753974eb08950089ddf71fec4f60
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220321/202203212326.t8A838in-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0577f386af5e7bc6400e76dc23c22fbcf45d715f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220321-180046
        git checkout 0577f386af5e7bc6400e76dc23c22fbcf45d715f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-mem.c:68:6: warning: no previous prototype for 'xhci_segment_free' [-Wmissing-prototypes]
      68 | void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
         |      ^~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-mem.c:100:6: warning: no previous prototype for 'xhci_link_segments' [-Wmissing-prototypes]
     100 | void xhci_link_segments(struct xhci_segment *prev,
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-mem.c:261:6: warning: no previous prototype for 'xhci_remove_stream_mapping' [-Wmissing-prototypes]
     261 | void xhci_remove_stream_mapping(struct xhci_ring *ring)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-mem.c:1974:5: warning: no previous prototype for 'xhci_check_trb_in_td_math' [-Wmissing-prototypes]
    1974 | int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xhci_remove_stream_mapping +261 drivers/usb/host/xhci-mem.c

   260	
 > 261	void xhci_remove_stream_mapping(struct xhci_ring *ring)
   262	{
   263		struct xhci_segment *seg;
   264	
   265		if (WARN_ON_ONCE(ring->trb_address_map == NULL))
   266			return;
   267	
   268		seg = ring->first_seg;
   269		do {
   270			xhci_remove_segment_mapping(ring->trb_address_map, seg);
   271			seg = seg->next;
   272		} while (seg != ring->first_seg);
   273	}
   274	EXPORT_SYMBOL_GPL(xhci_remove_stream_mapping);
   275	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
