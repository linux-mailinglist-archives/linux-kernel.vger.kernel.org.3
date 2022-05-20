Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC152E4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiETGBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbiETGBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:01:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C579721E06
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653026496; x=1684562496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=suHc8/0ny+Q4Vw1zskz0DDk42VPaYSAqg6vP0nPqLlE=;
  b=b8PtALOKEM4xVn9RFeYXcuCTRyN3znCxmDT4vtpmLwj0hgR9HZMHqc7j
   e0wsVYoy+TPeFkmFLnro9yuWGWvKm5cKo4erJyeaTKjqlLqpe4HNio1EP
   qU7M/AyncWTTSP1HFgPdHRlkny+l29e/yRHvvRkyhuYuoPW5P61l9GKtO
   +72I3ypcxWTkIFccaznqay19OEzbW+Ka8n/IGSyw6eYaUyCcvFAC+ft4p
   X72f00tnOJXbiZDnebEUNOAgvt4M0WvKIkl2MyoKu1LgP5HUPK1Vh60Ui
   cZdeJEBPtKkF9wNZWlan5duz5gOzePBhAd12JrIcE9RL3JX4H5ADwIj9Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="333126571"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="333126571"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="662104912"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2022 23:01:34 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrvhd-0004LP-Rb;
        Fri, 20 May 2022 06:01:33 +0000
Date:   Fri, 20 May 2022 14:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-attest 5/8] arch/x86/coco/tdx/attest.c:259:6:
 warning: no previous prototype for 'terminate_quote_request'
Message-ID: <202205201352.UysTQDWz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   c621127f8c80666ce3d36680bb73c040a5d8b737
commit: a68111d7c58d20706382ec58607ea510b5c2b12c [5/8] x86/tdx: Add Quote generation support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220520/202205201352.UysTQDWz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a68111d7c58d20706382ec58607ea510b5c2b12c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout a68111d7c58d20706382ec58607ea510b5c2b12c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/attest.c:259:6: warning: no previous prototype for 'terminate_quote_request' [-Wmissing-prototypes]
     259 | void terminate_quote_request(struct quote_entry *entry)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/terminate_quote_request +259 arch/x86/coco/tdx/attest.c

   257	
   258	/* Handles early termination of GetQuote requests */
 > 259	void terminate_quote_request(struct quote_entry *entry)
   260	{
   261		struct tdx_quote_hdr *quote_hdr;
   262	
   263		/*
   264		 * For early termination, if the request is not yet
   265		 * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
   266		 * still owns the shared buffer, so mark the request
   267		 * invalid to let quote_callback_handler() handle the
   268		 * memory cleanup function. If the request is already
   269		 * processed, then do the cleanup and return.
   270		 */
   271	
   272		mutex_lock(&quote_lock);
   273		quote_hdr = (struct tdx_quote_hdr *)entry->buf->vmaddr;
   274		if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {
   275			entry->valid = false;
   276			mutex_unlock(&quote_lock);
   277			return;
   278		}
   279		_del_quote_entry(entry);
   280		mutex_unlock(&quote_lock);
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
