Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6054D67A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350775AbiCKRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiCKRap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:30:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6654B180212
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647019781; x=1678555781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vYfkd+DeJvPsBWt5ueO6Fu3G+xZhbCFAdZ7JQ4e/VCs=;
  b=O9rXUy/WAl/Q7LEppJAbiWU36iM4kPSuyDcIV0xvOv4tikLRfx0TfNEU
   THTYfoebOra7yJSaCiREAltchfulgUo5EjkiNRWqm8J53IvPG8QiwdGiq
   w2beYSjFFzZuRSLpYiKCRTBVpo7zetJJzVf6zx5TyXp9zN94wa+cUbuqw
   djosd93fZ7rLUrZMK1qBU+ATrNxtLL0Y3AXSmznHUGkO3IPQ4Qid4zlfa
   2C70B/CjPU/grkug2DdzqxrYy10yUEhpOi0hVMiPxGl8p8P/9/SY/K4ns
   62dxv0zGFE7dfXx81jzMUcUwbxrTmmt0nTkkz5frjJuSc5a25izlGUILT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="318836869"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="318836869"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="579355080"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 09:29:39 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSj58-0006rB-MQ; Fri, 11 Mar 2022 17:29:38 +0000
Date:   Sat, 12 Mar 2022 01:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Howard Yen <howardyen@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr3
 1465/9999] drivers/usb/host/xhci-ring.c:2900:5: warning: no previous
 prototype for 'xhci_handle_event'
Message-ID: <202203120155.TB0VrOL5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr3
head:   bdc732d112f3e2c4160fe03c62c32308529ab0f6
commit: 26afe6712de0fad3a5de2b372286d029f8ff3231 [1465/9999] FROMLIST: usb: host: export symbols for xhci hooks usage
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220312/202203120155.TB0VrOL5-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/26afe6712de0fad3a5de2b372286d029f8ff3231
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr3
        git checkout 26afe6712de0fad3a5de2b372286d029f8ff3231
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/host/xhci-ring.c:2900:5: warning: no previous prototype for 'xhci_handle_event' [-Wmissing-prototypes]
    2900 | int xhci_handle_event(struct xhci_hcd *xhci)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-ring.c:2976:6: warning: no previous prototype for 'xhci_update_erst_dequeue' [-Wmissing-prototypes]
    2976 | void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/xhci_handle_event +2900 drivers/usb/host/xhci-ring.c

  2893	
  2894	/*
  2895	 * This function handles all OS-owned events on the event ring.  It may drop
  2896	 * xhci->lock between event processing (e.g. to pass up port status changes).
  2897	 * Returns >0 for "possibly more events to process" (caller should call again),
  2898	 * otherwise 0 if done.  In future, <0 returns should indicate error code.
  2899	 */
> 2900	int xhci_handle_event(struct xhci_hcd *xhci)
  2901	{
  2902		union xhci_trb *event;
  2903		int update_ptrs = 1;
  2904		u32 trb_type;
  2905		int ret;
  2906	
  2907		/* Event ring hasn't been allocated yet. */
  2908		if (!xhci->event_ring || !xhci->event_ring->dequeue) {
  2909			xhci_err(xhci, "ERROR event ring not ready\n");
  2910			return -ENOMEM;
  2911		}
  2912	
  2913		event = xhci->event_ring->dequeue;
  2914		/* Does the HC or OS own the TRB? */
  2915		if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
  2916		    xhci->event_ring->cycle_state)
  2917			return 0;
  2918	
  2919		trace_xhci_handle_event(xhci->event_ring, &event->generic);
  2920	
  2921		/*
  2922		 * Barrier between reading the TRB_CYCLE (valid) flag above and any
  2923		 * speculative reads of the event's flags/data below.
  2924		 */
  2925		rmb();
  2926		trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
  2927		/* FIXME: Handle more event types. */
  2928	
  2929		switch (trb_type) {
  2930		case TRB_COMPLETION:
  2931			handle_cmd_completion(xhci, &event->event_cmd);
  2932			break;
  2933		case TRB_PORT_STATUS:
  2934			handle_port_status(xhci, event);
  2935			update_ptrs = 0;
  2936			break;
  2937		case TRB_TRANSFER:
  2938			ret = handle_tx_event(xhci, &event->trans_event);
  2939			if (ret >= 0)
  2940				update_ptrs = 0;
  2941			break;
  2942		case TRB_DEV_NOTE:
  2943			handle_device_notification(xhci, event);
  2944			break;
  2945		default:
  2946			if (trb_type >= TRB_VENDOR_DEFINED_LOW)
  2947				handle_vendor_event(xhci, event, trb_type);
  2948			else
  2949				xhci_warn(xhci, "ERROR unknown event type %d\n", trb_type);
  2950		}
  2951		/* Any of the above functions may drop and re-acquire the lock, so check
  2952		 * to make sure a watchdog timer didn't mark the host as non-responsive.
  2953		 */
  2954		if (xhci->xhc_state & XHCI_STATE_DYING) {
  2955			xhci_dbg(xhci, "xHCI host dying, returning from "
  2956					"event handler.\n");
  2957			return 0;
  2958		}
  2959	
  2960		if (update_ptrs)
  2961			/* Update SW event ring dequeue pointer */
  2962			inc_deq(xhci, xhci->event_ring);
  2963	
  2964		/* Are there more items on the event ring?  Caller will call us again to
  2965		 * check.
  2966		 */
  2967		return 1;
  2968	}
  2969	EXPORT_SYMBOL_GPL(xhci_handle_event);
  2970	
  2971	/*
  2972	 * Update Event Ring Dequeue Pointer:
  2973	 * - When all events have finished
  2974	 * - To avoid "Event Ring Full Error" condition
  2975	 */
> 2976	void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
  2977			union xhci_trb *event_ring_deq)
  2978	{
  2979		u64 temp_64;
  2980		dma_addr_t deq;
  2981	
  2982		temp_64 = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
  2983		/* If necessary, update the HW's version of the event ring deq ptr. */
  2984		if (event_ring_deq != xhci->event_ring->dequeue) {
  2985			deq = xhci_trb_virt_to_dma(xhci->event_ring->deq_seg,
  2986					xhci->event_ring->dequeue);
  2987			if (deq == 0)
  2988				xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr\n");
  2989			/*
  2990			 * Per 4.9.4, Software writes to the ERDP register shall
  2991			 * always advance the Event Ring Dequeue Pointer value.
  2992			 */
  2993			if ((temp_64 & (u64) ~ERST_PTR_MASK) ==
  2994					((u64) deq & (u64) ~ERST_PTR_MASK))
  2995				return;
  2996	
  2997			/* Update HC event ring dequeue pointer */
  2998			temp_64 &= ERST_PTR_MASK;
  2999			temp_64 |= ((u64) deq & (u64) ~ERST_PTR_MASK);
  3000		}
  3001	
  3002		/* Clear the event handler busy flag (RW1C) */
  3003		temp_64 |= ERST_EHB;
  3004		xhci_write_64(xhci, temp_64, &xhci->ir_set->erst_dequeue);
  3005	}
  3006	EXPORT_SYMBOL_GPL(xhci_update_erst_dequeue);
  3007	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
