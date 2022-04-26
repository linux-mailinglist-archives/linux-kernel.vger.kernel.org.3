Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E043510288
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352804AbiDZQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352785AbiDZQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:07:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A943AEC;
        Tue, 26 Apr 2022 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650989069; x=1682525069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqAl6GT0VmvVsoiieDZ39Jw7aD8/OaezIaNnGD3XhX0=;
  b=GMO1UOVeRGcWOBPOqi9WE+zgHoHJ00CpBAOhk9YQz6058jmtQFgSYMGZ
   dmj1n46ybuG9MpzY8CjVdad1VCHzU25GIK1E33D3Iq9/AIpOMMTfMdTXd
   vOzmqWaAoMnYBwc9cLkli97tTmUZFH/fGljD3CVvzzIX2nQtuy7iiF2Z7
   O9WReeaP38e8j1UGMfcD7BTfqiqmfqMMnFdWp2qEDVdY37A/9adRTTX3s
   ekVDNAl/0E/87t8JtxcXjJhgr0/eqvynJm9qW1hHIQC7qu8yx8dy6HAiI
   fjUaHPGHxmH9DnKr3x2DrSbNLj1snwtSbTcHyZ+fSnPf2Lz30GyQELa95
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328566878"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="328566878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="874822226"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Apr 2022 09:03:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njNfC-0003mk-5b;
        Tue, 26 Apr 2022 16:03:42 +0000
Date:   Wed, 27 Apr 2022 00:02:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/5] usb: host: export symbols for xhci-exynos to use
 xhci hooks
Message-ID: <202204262306.mzMIKFKO-lkp@intel.com>
References: <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on krzk/for-next char-misc/char-misc-testing v5.18-rc4 next-20220426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-exynos-to-use-xhci-hooks/20220426-181936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220426/202204262306.mzMIKFKO-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/05a4937860cedb97b77200b7312a6f009aca2fc6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-exynos-to-use-xhci-hooks/20220426-181936
        git checkout 05a4937860cedb97b77200b7312a6f009aca2fc6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/usb/host/

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
