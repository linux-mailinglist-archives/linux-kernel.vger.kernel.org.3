Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E244FC818
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiDKXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiDKXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:31:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D1B1D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649719778; x=1681255778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pu9bAPi4B2wIQwRZzF5eoZmSX/gR/395RINQ5+ePwVQ=;
  b=hMrG3CW+oF3eejXnw9si+GhzllBQzHLtzbblDyrAWkXyDoRPxhPf5eeu
   NRoasSyi9yMudkTpIuEb5eTZ7oTVAQMoOJ3Es+WwVdtJTpBaqfBnrVg91
   3N6/srEptVLgD3e2ymI8kc8TldhjhWYwLtFZVdLRUEuti+MLipIVqnQjj
   Ezpy2SLPrrPFgnABt5k109xeFuYvAuVYLhEQh5Ci+j1hJN+OJcZdLv5P/
   MaqdOoWwfIawoeHwxzeIoIbIQC2CBbNcZuUZXtjnC0tzWGE6hHSEBbUe+
   1YTDqE6gbO0VqUog39QlBjItszJDGOZF102sVYSNiSlwYfjrszEVJJro0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244121106"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="244121106"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 16:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="644475407"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2022 16:29:37 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne3TU-0002Jt-CB;
        Mon, 11 Apr 2022 23:29:36 +0000
Date:   Tue, 12 Apr 2022 07:28:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/vmwgfx/vmwgfx.prelink.o: warning: objtool:
 vmw_port_hb_out()+0xed: return with modified stack frame
Message-ID: <202204120755.ISBovapC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
commit: d31ed5d767c0452b4f49846d80a0bfeafa3a4ded kbuild: Fixup the IBT kbuild changes
date:   3 weeks ago
config: x86_64-randconfig-c002-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120755.ISBovapC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d31ed5d767c0452b4f49846d80a0bfeafa3a4ded
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d31ed5d767c0452b4f49846d80a0bfeafa3a4ded
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx.prelink.o: warning: objtool: vmw_port_hb_out()+0xed: return with modified stack frame
>> drivers/gpu/drm/vmwgfx/vmwgfx.prelink.o: warning: objtool: vmw_port_hb_in()+0xe5: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
