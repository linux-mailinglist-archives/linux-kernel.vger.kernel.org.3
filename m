Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AF5ADD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiIFBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIFBqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:46:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318357E2B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662428767; x=1693964767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YodHDRDOBgMRijcvZRR1raq5O85utTYgLLNsrFmAScs=;
  b=G+aFmXwquWeZ6Z5khksLMvFx1nyy1ONYw2Ttf0V24LLGwPWG9IE6YMq0
   wdiUqZTAb+qBeaJDmRuySeyvRe3hL0ILnhlpLuLqJeVXqY5JmcCqvEVJ3
   Wu4eEGNV9TRPBWibjJ3Anvcx39eiXxkeJ4+w0hRruqf4oVhE0BgMO8fCM
   tRns03g6zvReA08Dojkkf07KfuSYT9EDOC97d66fhOP8C21jWjEqGwi6L
   pQmL/dIsLN2cdS07nM29Hn8+QqhglWOzVCQm1DuJj8SB34eG7VkJgpEbM
   7eyxMFp3jM+nHzZ2XC2qZsGCXG/qHld0Pr/SG2edZVG/nLQ4spe+AmtVC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276216380"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="276216380"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="643973597"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 18:46:06 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVNfB-0004jB-1O;
        Tue, 06 Sep 2022 01:46:05 +0000
Date:   Tue, 6 Sep 2022 09:45:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool:
 vmw_port_hb_in+0xe2: stack state mismatch: cfa1=5+16 cfa2=4+8
Message-ID: <202209060939.Aa20lxSi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: c25e1c55822f9b3b53ccbf88b85644317a525752 kbuild: do not create *.prelink.o for Clang LTO or IBT
date:   3 months ago
config: x86_64-buildonly-randconfig-r001-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060939.Aa20lxSi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c25e1c55822f9b3b53ccbf88b85644317a525752
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c25e1c55822f9b3b53ccbf88b85644317a525752
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/vmwgfx/ drivers/spmi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_in+0xe2: stack state mismatch: cfa1=5+16 cfa2=4+8
>> drivers/gpu/drm/vmwgfx/vmwgfx.o: warning: objtool: vmw_port_hb_out+0xe5: stack state mismatch: cfa1=5+16 cfa2=4+8

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
