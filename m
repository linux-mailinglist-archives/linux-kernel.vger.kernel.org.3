Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5531F53F3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiFGC3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiFGC3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:29:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BBA8A320
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654568981; x=1686104981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a2ig6AJ7xrCWe12wC2TZ0btPzxGqIr5J1IpCFJC6jnw=;
  b=AetYW42fBqhp7WL/wM0siq/6oe6+UuVXHayRLliTU1FSpv/MQwsJR9a4
   Krtqy+qI/Qt1fSNBKcO+YpWzA69oZNHWxdqzAm83BClC243HmTAJwzX9i
   586mXxOwjdG5wT6AB+gu/miU0zDtv5L3j4twbYSJ5Fta1wgiBZjlHPzq4
   eqFVaDD4i4qzIq/61JvCUcV9FdSg8DHsOumBkkvWG7l9P6ZZYH8YGTefH
   yiXOCQzFX1C9U4ztsT8cRhIPwd37uQEySvVdOaDQ24JiAtwdXjBDJsK5N
   sNIkisDxoiGzcsuPRCIcbBlvbfoyamz5euk13RgiVgqj50r16OWkcSqw2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257147024"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="257147024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 19:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="826142433"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 19:29:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyOyP-000DG1-Jo;
        Tue, 07 Jun 2022 02:29:37 +0000
Date:   Tue, 7 Jun 2022 10:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-attest 5/8] arch/x86/coco/tdx/attest.c:249:6:
 warning: no previous prototype for 'terminate_quote_request'
Message-ID: <202206071034.SxfYlULc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   cf3131ea46807abb401d633e20dd28ef77c0dba8
commit: 976cd8bda2b0e7ea9f415585aaa1b2ea5a2d0075 [5/8] x86/tdx: Add Quote generation support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220607/202206071034.SxfYlULc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/976cd8bda2b0e7ea9f415585aaa1b2ea5a2d0075
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout 976cd8bda2b0e7ea9f415585aaa1b2ea5a2d0075
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/attest.c:249:6: warning: no previous prototype for 'terminate_quote_request' [-Wmissing-prototypes]
     249 | void terminate_quote_request(struct quote_entry *entry)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/terminate_quote_request +249 arch/x86/coco/tdx/attest.c

   247	
   248	/* Handles early termination of GetQuote requests */
 > 249	void terminate_quote_request(struct quote_entry *entry)
   250	{
   251		struct tdx_quote_hdr *quote_hdr;
   252	
   253		/*
   254		 * For early termination, if the request is not yet
   255		 * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
   256		 * still owns the shared buffer, so mark the request
   257		 * invalid to let quote_callback_handler() handle the
   258		 * memory cleanup function. If the request is already
   259		 * processed, then do the cleanup and return.
   260		 */
   261	
   262		mutex_lock(&quote_lock);
   263		quote_hdr = (struct tdx_quote_hdr *)entry->buf.vmaddr;
   264		if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {
   265			entry->valid = false;
   266			mutex_unlock(&quote_lock);
   267			return;
   268		}
   269		_del_quote_entry(entry);
   270		mutex_unlock(&quote_lock);
   271	}
   272	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
