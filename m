Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9F5657BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiGDNrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiGDNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:46:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C163F3;
        Mon,  4 Jul 2022 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656942405; x=1688478405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5tXZmggYEePFhIf7UV7H6qVUVP8OBHoDYwvDGmmtBVU=;
  b=XK7o0Lc1QIuBqy2eWk+iRKVYJJP78oPoyz0grFMrFgY+T//YtoDe6KHs
   k6HZuFbHrAkKk2SO6xx+GL/wJNJLFpBnmei7P7+zrVXsnKxzXXdw3ZvYf
   7oFwtmhKyQhMPbFONsS6IWFIB8yo02qmP1lyazqNHhI5a/K2+DDhWIBtN
   gquEB5VXUaYULDcJGgregjMKPtlN6Cp2b3sJOVbS2WUxVuJKRZ37vckFk
   Xk3eC9Pk5cxLGY25XJGnNVAFiprSr824TrLQT8UzlGmAhz9/CGLuhNqfT
   p/cmZgrhoR6JuWaDg3iG0dYHWODX7dLndxeKeixXpe0QfI7E2KY1lzo4S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="284242193"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="284242193"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 06:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660216163"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2022 06:46:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8MPI-000Hv9-VH;
        Mon, 04 Jul 2022 13:46:32 +0000
Date:   Mon, 4 Jul 2022 21:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 164/267] htmldocs:
 Documentation/x86/tdx.rst:69: WARNING: Unexpected indentation.
Message-ID: <202207042107.YqVvxdJz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   7af4efe32638544aecb58ed7365d0ef2ea6f85ea
commit: f05f595045dfc7805ec8dedfe8c61a4b880b6d05 [164/267] Documentation/x86: Add documentation for TDX host support
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/x86/tdx.rst:69: WARNING: Unexpected indentation.
>> Documentation/x86/tdx.rst:70: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +69 Documentation/x86/tdx.rst

    66	
    67	        ret = tdx_init();
    68	        if (ret)
  > 69	                goto no_tdx;
  > 70	        // TDX is ready to use
    71	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
