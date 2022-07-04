Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB5565670
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiGDNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGDNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:05:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49116BE3C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656939934; x=1688475934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tzoXKgoASV1qyTDzaebodMd9Iqm4dRBfJjknhaLDGXM=;
  b=ZzDsfttk5LSEJGapWXTIONbL7LmHThsJ7CcDQniZEr+VUhZeASy5s6rR
   N65LO0KbBIGcCcWwjON0aH6CXvItHgCuII+iFzhqthQ3sNK7P40Y3OB39
   cKdBzIpKbb2klv8/L0nb/mOj7jC1KzWCElevrsdJC0WQ4X1jxLDTDM05w
   /X/58tc+UCxDK0yeZsxvyJ3XGOOJwYD1x9JmXvU9g/WrAYeE9yBy+H0AF
   nPveq5D3LmskdJ3eD9bbJghB5Yb6hjeSieZE7AkQLyPaTFvhIzl9VGy26
   gDjBGsBX/SAmmWEcEoGd9Eybw/GYxYHOOqHsND5sSPvJ4N04WBcuGR+nE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="266150179"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266150179"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 06:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919356156"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 06:05:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Lla-000Htl-3H;
        Mon, 04 Jul 2022 13:05:30 +0000
Date:   Mon, 4 Jul 2022 21:05:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.15.y 7024/8135] sound/soc/codecs/tscs454.o: warning:
 objtool: tscs454_set_dai_fmt()+0xca: unreachable instruction
Message-ID: <202207042131.22v4hR0k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   545aecd229613138d6db54fb2b5221faca10137f
commit: 2200453e8910b3d5f0d6f10935008eae53dcbe8b [7024/8135] ASoC: tscs454: Add endianness flag in snd_soc_component_driver
config: x86_64-randconfig-a004-20220704 (https://download.01.org/0day-ci/archive/20220704/202207042131.22v4hR0k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=2200453e8910b3d5f0d6f10935008eae53dcbe8b
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout 2200453e8910b3d5f0d6f10935008eae53dcbe8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tscs454.o: warning: objtool: tscs454_set_dai_fmt()+0xca: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
