Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6A4A7EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiBCFNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:13:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:58252 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234620AbiBCFNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643865230; x=1675401230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ckYQ5pS6pni4+zg+tlCsXumnjmCvuQPKT8aK/Hw7JPc=;
  b=cHCZoS47h0SUjn2bVEL5d9GA+UCu9kRo61pzGCtxI8qd42O4l50uYdlk
   6u0McbxsjqQhSYIbWugyvuiKu5ErXqu6F+amsGdiR93+V/vi5KddIiITB
   S3BTdNaspf/sMJOBIIXDmHelmIfRIvpUxmeHAZNn7Pw/kZ3IcE8PX7o1N
   yN/4vyoOK8CgvU8L883kBdZTDGKOdtIF4QC7R4bu+MVdfddqt99JCykxL
   tB09Gg2Bk6JeE4hCwGORIWJ5aKbfGDTNhrv6MZfl8nK0XV6mJwBzcTLza
   mDSp1HIjWeT9r5MfG4XCXfDgCMsCHY0OfFcQMrN0zQ2umAM4jvLTG2/9Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228045584"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="228045584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 21:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="480372205"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2022 21:13:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFURH-000Vcn-0U; Thu, 03 Feb 2022 05:13:47 +0000
Date:   Thu, 3 Feb 2022 13:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: Re: [PATCH 1/3] usb: host: export symbols for xhci hooks usage
Message-ID: <202202031306.bIBPQVIv-lkp@intel.com>
References: <1643857054-112415-2-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643857054-112415-2-git-send-email-dh10.jung@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on char-misc/char-misc-testing v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220203-115745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202031306.bIBPQVIv-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7bbb0fd19fb35f4629e27fd5ad0e4c787a4410b7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220203-115745
        git checkout 7bbb0fd19fb35f4629e27fd5ad0e4c787a4410b7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-mem.c:68:6: warning: no previous prototype for 'xhci_segment_free' [-Wmissing-prototypes]
      68 | void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
         |      ^~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-mem.c:79:6: warning: no previous prototype for 'xhci_free_segments_for_ring' [-Wmissing-prototypes]
      79 | void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-mem.c:100:6: warning: no previous prototype for 'xhci_link_segments' [-Wmissing-prototypes]
     100 | void xhci_link_segments(struct xhci_segment *prev,
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-mem.c:211:6: warning: no previous prototype for 'xhci_remove_segment_mapping' [-Wmissing-prototypes]
     211 | void xhci_remove_segment_mapping(struct radix_tree_root *trb_address_map,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-mem.c:262:6: warning: no previous prototype for 'xhci_remove_stream_mapping' [-Wmissing-prototypes]
     262 | void xhci_remove_stream_mapping(struct xhci_ring *ring)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-mem.c:1984:5: warning: no previous prototype for 'xhci_check_trb_in_td_math' [-Wmissing-prototypes]
    1984 | int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xhci_remove_segment_mapping +211 drivers/usb/host/xhci-mem.c

    67	
  > 68	void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
    69	{
    70		if (seg->trbs) {
    71			dma_pool_free(xhci->segment_pool, seg->trbs, seg->dma);
    72			seg->trbs = NULL;
    73		}
    74		kfree(seg->bounce_buf);
    75		kfree(seg);
    76	}
    77	EXPORT_SYMBOL_GPL(xhci_segment_free);
    78	
  > 79	void xhci_free_segments_for_ring(struct xhci_hcd *xhci,
    80					struct xhci_segment *first)
    81	{
    82		struct xhci_segment *seg;
    83	
    84		seg = first->next;
    85		while (seg != first) {
    86			struct xhci_segment *next = seg->next;
    87			xhci_segment_free(xhci, seg);
    88			seg = next;
    89		}
    90		xhci_segment_free(xhci, first);
    91	}
    92	
    93	/*
    94	 * Make the prev segment point to the next segment.
    95	 *
    96	 * Change the last TRB in the prev segment to be a Link TRB which points to the
    97	 * DMA address of the next segment.  The caller needs to set any Link TRB
    98	 * related flags, such as End TRB, Toggle Cycle, and no snoop.
    99	 */
   100	void xhci_link_segments(struct xhci_segment *prev,
   101				struct xhci_segment *next,
   102				enum xhci_ring_type type, bool chain_links)
   103	{
   104		u32 val;
   105	
   106		if (!prev || !next)
   107			return;
   108		prev->next = next;
   109		if (type != TYPE_EVENT) {
   110			prev->trbs[TRBS_PER_SEGMENT-1].link.segment_ptr =
   111				cpu_to_le64(next->dma);
   112	
   113			/* Set the last TRB in the segment to have a TRB type ID of Link TRB */
   114			val = le32_to_cpu(prev->trbs[TRBS_PER_SEGMENT-1].link.control);
   115			val &= ~TRB_TYPE_BITMASK;
   116			val |= TRB_TYPE(TRB_LINK);
   117			if (chain_links)
   118				val |= TRB_CHAIN;
   119			prev->trbs[TRBS_PER_SEGMENT-1].link.control = cpu_to_le32(val);
   120		}
   121	}
   122	EXPORT_SYMBOL_GPL(xhci_link_segments);
   123	
   124	/*
   125	 * Link the ring to the new segments.
   126	 * Set Toggle Cycle for the new ring if needed.
   127	 */
   128	static void xhci_link_rings(struct xhci_hcd *xhci, struct xhci_ring *ring,
   129			struct xhci_segment *first, struct xhci_segment *last,
   130			unsigned int num_segs)
   131	{
   132		struct xhci_segment *next;
   133		bool chain_links;
   134	
   135		if (!ring || !first || !last)
   136			return;
   137	
   138		/* Set chain bit for 0.95 hosts, and for isoc rings on AMD 0.96 host */
   139		chain_links = !!(xhci_link_trb_quirk(xhci) ||
   140				 (ring->type == TYPE_ISOC &&
   141				  (xhci->quirks & XHCI_AMD_0x96_HOST)));
   142	
   143		next = ring->enq_seg->next;
   144		xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
   145		xhci_link_segments(last, next, ring->type, chain_links);
   146		ring->num_segs += num_segs;
   147		ring->num_trbs_free += (TRBS_PER_SEGMENT - 1) * num_segs;
   148	
   149		if (ring->type != TYPE_EVENT && ring->enq_seg == ring->last_seg) {
   150			ring->last_seg->trbs[TRBS_PER_SEGMENT-1].link.control
   151				&= ~cpu_to_le32(LINK_TOGGLE);
   152			last->trbs[TRBS_PER_SEGMENT-1].link.control
   153				|= cpu_to_le32(LINK_TOGGLE);
   154			ring->last_seg = last;
   155		}
   156	}
   157	
   158	/*
   159	 * We need a radix tree for mapping physical addresses of TRBs to which stream
   160	 * ID they belong to.  We need to do this because the host controller won't tell
   161	 * us which stream ring the TRB came from.  We could store the stream ID in an
   162	 * event data TRB, but that doesn't help us for the cancellation case, since the
   163	 * endpoint may stop before it reaches that event data TRB.
   164	 *
   165	 * The radix tree maps the upper portion of the TRB DMA address to a ring
   166	 * segment that has the same upper portion of DMA addresses.  For example, say I
   167	 * have segments of size 1KB, that are always 1KB aligned.  A segment may
   168	 * start at 0x10c91000 and end at 0x10c913f0.  If I use the upper 10 bits, the
   169	 * key to the stream ID is 0x43244.  I can use the DMA address of the TRB to
   170	 * pass the radix tree a key to get the right stream ID:
   171	 *
   172	 *	0x10c90fff >> 10 = 0x43243
   173	 *	0x10c912c0 >> 10 = 0x43244
   174	 *	0x10c91400 >> 10 = 0x43245
   175	 *
   176	 * Obviously, only those TRBs with DMA addresses that are within the segment
   177	 * will make the radix tree return the stream ID for that ring.
   178	 *
   179	 * Caveats for the radix tree:
   180	 *
   181	 * The radix tree uses an unsigned long as a key pair.  On 32-bit systems, an
   182	 * unsigned long will be 32-bits; on a 64-bit system an unsigned long will be
   183	 * 64-bits.  Since we only request 32-bit DMA addresses, we can use that as the
   184	 * key on 32-bit or 64-bit systems (it would also be fine if we asked for 64-bit
   185	 * PCI DMA addresses on a 64-bit system).  There might be a problem on 32-bit
   186	 * extended systems (where the DMA address can be bigger than 32-bits),
   187	 * if we allow the PCI dma mask to be bigger than 32-bits.  So don't do that.
   188	 */
   189	static int xhci_insert_segment_mapping(struct radix_tree_root *trb_address_map,
   190			struct xhci_ring *ring,
   191			struct xhci_segment *seg,
   192			gfp_t mem_flags)
   193	{
   194		unsigned long key;
   195		int ret;
   196	
   197		key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
   198		/* Skip any segments that were already added. */
   199		if (radix_tree_lookup(trb_address_map, key))
   200			return 0;
   201	
   202		ret = radix_tree_maybe_preload(mem_flags);
   203		if (ret)
   204			return ret;
   205		ret = radix_tree_insert(trb_address_map,
   206				key, ring);
   207		radix_tree_preload_end();
   208		return ret;
   209	}
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
