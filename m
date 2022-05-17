Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028CD5296DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiEQBmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiEQBmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:42:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFF4348E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652751720; x=1684287720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eXwV4cFGAnyeNZKj6jmdsuDrJ9zLLeNisq4qOYqbpMI=;
  b=mSOdkEky+31IXD8JNFOemUd+NduwoAMN2rpWdj6ZsrliLM5p2iQ99hfk
   I4KFHF/plE4jr7nvlzccXvHFN/wEL45/rFUDBA/FXtZRtfzhqbCW6pmJB
   OHYxrWZikHjhuRZSYti+KGo+1BSlValnnlk9F9tyjDYNThUcKCLCP/epM
   4SZCeMmwzrLzfSb2u1YwX96xWz2dCIY+3hKpxN44HqhaE2MFdUamvc4Wp
   ZeF7FCA7dBbvceXBQxL6SJqhsytI2PzrkOniuHtZ7Am5uXFaY7hjDftmp
   ZKoU4jn8RmUxI+25dZ22tnfCKULLAIxmq4o+NG05atGHgInqOU1LJ+Jum
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="357429478"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="357429478"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 18:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="638515736"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2022 18:41:59 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqmDm-0000Th-K8;
        Tue, 17 May 2022 01:41:58 +0000
Date:   Tue, 17 May 2022 09:41:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 1421/2373] net/sunrpc/clnt.o: warning:
 objtool: call_status()+0xef: unreachable instruction
Message-ID: <202205170933.F5SZTeOZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   e1382731ef4e5e1634896596ebe74e48b9ed2b73
commit: 474acfab325817d190709a03db7df6abfe7972f8 [1421/2373] SUNRPC: Handle ENOMEM in call_transmit_status()
config: x86_64-randconfig-r011-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170933.F5SZTeOZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=474acfab325817d190709a03db7df6abfe7972f8
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 474acfab325817d190709a03db7df6abfe7972f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sunrpc/clnt.o: warning: objtool: call_status()+0xef: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
