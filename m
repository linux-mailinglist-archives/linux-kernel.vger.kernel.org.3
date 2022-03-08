Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D994D0F38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbiCHFhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCHFhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:37:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35E30F50;
        Mon,  7 Mar 2022 21:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646717777; x=1678253777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pWZXonTsyEiSwe+PW5QuCWU+vK6d4eB7VuGhemNmhOk=;
  b=i3lkNJJw9w0VV0AuAZgEs25rC9GqoLVmUBl37chcj7kzaoQmvuOB2Slv
   0HjLRACC4juoY7ghtTmJKDUkQ6Ig4lbxPxIZBfoCSF4kBA/pJu9UPFXoR
   8jZCbkMCrfYMqM+X3IzwU4SgUVgB5Qkvst9XFL6hlHrV8C131eFDGskMe
   Z+pmvYgNfTxDtdBzDTrUhcvjopUjsdLSQDe+uoDQzajO92L4X6/PSTWuG
   YNATHry8NWSxxoKPTYGM+HvpjMOxtwO590iVMDliitdTCCzRIl2Es/M+r
   8TBib6fv1H5M+eaXTIf7m0tkX9HqPlt34qbYFnmk6VQE5ocyXirMPoSY+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279309825"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="279309825"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="509982471"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2022 21:36:13 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRSW5-0000z1-3r; Tue, 08 Mar 2022 05:36:13 +0000
Date:   Tue, 8 Mar 2022 13:35:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Message-ID: <202203081332.nZHV3ZBo-lkp@intel.com>
References: <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test WARNING on krzk/for-next]
[also build test WARNING on char-misc/char-misc-testing v5.17-rc7 next-20220307]
[cannot apply to usb/usb-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220304-143406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
config: hexagon-randconfig-r045-20220304 (https://download.01.org/0day-ci/archive/20220308/202203081332.nZHV3ZBo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/66bd02564cf7e666cf4c47f83965148fa5b90829
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220304-143406
        git checkout 66bd02564cf7e666cf4c47f83965148fa5b90829
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-mem.c:68:6: warning: no previous prototype for function 'xhci_segment_free' [-Wmissing-prototypes]
   void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
        ^
   drivers/usb/host/xhci-mem.c:68:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
   ^
   static 
   drivers/usb/host/xhci-mem.c:79:6: warning: no previous prototype for function 'xhci_free_segments_for_ring' [-Wmissing-prototypes]
   void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
        ^
   drivers/usb/host/xhci-mem.c:79:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
   ^
   static 
   drivers/usb/host/xhci-mem.c:100:6: warning: no previous prototype for function 'xhci_link_segments' [-Wmissing-prototypes]
   void xhci_link_segments(struct xhci_segment *prev,
        ^
   drivers/usb/host/xhci-mem.c:100:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xhci_link_segments(struct xhci_segment *prev,
   ^
   static 
>> drivers/usb/host/xhci-mem.c:211:6: warning: no previous prototype for function 'xhci_remove_segment_mapping' [-Wmissing-prototypes]
   void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
        ^
   drivers/usb/host/xhci-mem.c:211:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
   ^
   static 
>> drivers/usb/host/xhci-mem.c:262:6: warning: no previous prototype for function 'xhci_remove_stream_mapping' [-Wmissing-prototypes]
   void xhci_remove_stream_mapping(struct xhci_ring *ring)
        ^
   drivers/usb/host/xhci-mem.c:262:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xhci_remove_stream_mapping(struct xhci_ring *ring)
   ^
   static 
   drivers/usb/host/xhci-mem.c:1984:5: warning: no previous prototype for function 'xhci_check_trb_in_td_math' [-Wmissing-prototypes]
   int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
       ^
   drivers/usb/host/xhci-mem.c:1984:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
   ^
   static 
   6 warnings generated.


vim +/xhci_remove_segment_mapping +211 drivers/usb/host/xhci-mem.c

   210	
 > 211	void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
   212			struct xhci_segment *seg)
   213	{
   214		unsigned long key;
   215	
   216		key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
   217		if (radix_tree_lookup(trb_address_map, key))
   218			radix_tree_delete(trb_address_map, key);
   219	}
   220	EXPORT_SYMBOL_GPL(xhci_remove_segment_mapping);
   221	
   222	static int xhci_update_stream_segment_mapping(
   223			struct radix_tree_root *trb_address_map,
   224			struct xhci_ring *ring,
   225			struct xhci_segment *first_seg,
   226			struct xhci_segment *last_seg,
   227			gfp_t mem_flags)
   228	{
   229		struct xhci_segment *seg;
   230		struct xhci_segment *failed_seg;
   231		int ret;
   232	
   233		if (WARN_ON_ONCE(trb_address_map == NULL))
   234			return 0;
   235	
   236		seg = first_seg;
   237		do {
   238			ret = xhci_insert_segment_mapping(trb_address_map,
   239					ring, seg, mem_flags);
   240			if (ret)
   241				goto remove_streams;
   242			if (seg == last_seg)
   243				return 0;
   244			seg = seg->next;
   245		} while (seg != first_seg);
   246	
   247		return 0;
   248	
   249	remove_streams:
   250		failed_seg = seg;
   251		seg = first_seg;
   252		do {
   253			xhci_remove_segment_mapping(trb_address_map, seg);
   254			if (seg == failed_seg)
   255				return ret;
   256			seg = seg->next;
   257		} while (seg != first_seg);
   258	
   259		return ret;
   260	}
   261	
 > 262	void xhci_remove_stream_mapping(struct xhci_ring *ring)
   263	{
   264		struct xhci_segment *seg;
   265	
   266		if (WARN_ON_ONCE(ring->trb_address_map == NULL))
   267			return;
   268	
   269		seg = ring->first_seg;
   270		do {
   271			xhci_remove_segment_mapping(ring->trb_address_map, seg);
   272			seg = seg->next;
   273		} while (seg != ring->first_seg);
   274	}
   275	EXPORT_SYMBOL_GPL(xhci_remove_stream_mapping);
   276	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
