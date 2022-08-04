Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493B058A2BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiHDV2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHDV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:28:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E771CFCE
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659648518; x=1691184518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0PRz8CgMDTd6BzebQ6ZgJRTli7eKvfZCRZokUDPm+ws=;
  b=NK96NO67YJ9G4HkQNigsDFcDI1E56S0T/AeZB9tWO74mrAGILpMoBaov
   uEltymVgDkWivHiD1KXObizxNmLBYrfDuwzIgWpecT3npqOWQAOIR8Q1l
   7aYlqFRKdko2+GtHVQPIcPRpf0Xt8gwlOp8gpZRgqXUw0TMpA1A3YItJU
   EWKCmqIBPCJheL0AZrrvAvjd4aPxmtK9UyooWCExHRBoAtrGccJP8JD5C
   aIBiIZKfIWy2k68CtoRUOwjy2MZTLKKqJCGq09Z2J7clY3GTDVnItm8JM
   P2OWNbUEwESVhDpL3654ydBJjZBLrLACsYsxbj5wUStzM8hie074sFyq2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287611864"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287611864"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553871646"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 14:28:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiOR-000Irz-1i;
        Thu, 04 Aug 2022 21:28:35 +0000
Date:   Fri, 5 Aug 2022 05:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Jander <david@protonic.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi.c:117:16: sparse: sparse: incorrect type in return
 expression (different address spaces)
Message-ID: <202208050542.7h1Y0Fj3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1c76700a0d6e6090ccfe1209527f14c21b6681b
commit: 6598b91b5ac32bc756d7c3000a31f775d4ead1c4 spi: spi.c: Convert statistics to per-cpu u64_stats_t
date:   8 weeks ago
config: arc-randconfig-s053-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050542.7h1Y0Fj3-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6598b91b5ac32bc756d7c3000a31f775d4ead1c4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6598b91b5ac32bc756d7c3000a31f775d4ead1c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi.c:117:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct spi_statistics * @@     got struct spi_statistics [noderef] __percpu *[assigned] pcpu_stats @@
   drivers/spi/spi.c:117:16: sparse:     expected struct spi_statistics *
   drivers/spi/spi.c:117:16: sparse:     got struct spi_statistics [noderef] __percpu *[assigned] pcpu_stats
>> drivers/spi/spi.c:180:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:180:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:180:1: sparse:     got struct spi_statistics *
>> drivers/spi/spi.c:180:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:180:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:180:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
>> drivers/spi/spi.c:180:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:180:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:180:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:181:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:181:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:181:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:181:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:181:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:181:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:181:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:181:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:181:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:182:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:182:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:182:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:182:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:182:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:182:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:182:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:182:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:182:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:183:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:183:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:183:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:183:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:183:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:183:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:183:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:183:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:183:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:185:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:185:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:185:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:185:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:185:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:185:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:185:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:185:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:185:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:186:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:186:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:186:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:186:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:186:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:186:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:186:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:186:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:186:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:187:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:187:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:187:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:187:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:187:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:187:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:187:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:187:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:187:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:189:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:189:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:189:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:189:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:189:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:189:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:189:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:189:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:189:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:190:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:190:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:190:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:190:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:190:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:190:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:190:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:190:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:190:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:191:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:191:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:191:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:191:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:191:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:191:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:191:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:191:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:191:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:197:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:197:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:197:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:197:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:197:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:197:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:197:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:197:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:197:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:198:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:198:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:198:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:198:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:198:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:198:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:198:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:198:1: sparse:     expected struct spi_statistics *stat
--
   drivers/spi/spi.c:204:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:204:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:204:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:204:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:204:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:204:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:204:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:205:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:205:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:205:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:205:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:205:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:205:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:205:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:205:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:205:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:206:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:206:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:206:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:206:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:206:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:206:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:206:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:206:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:206:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:207:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:207:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:207:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:207:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:207:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:207:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:207:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:207:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:207:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:208:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:208:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:208:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:208:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:208:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:208:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:208:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:208:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:208:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:209:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:209:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:209:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:209:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:209:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:209:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:209:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:209:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:209:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:210:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:210:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:210:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:210:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:210:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:210:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:210:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:210:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:210:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:211:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:211:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:211:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:211:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:211:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:211:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:211:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:211:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:211:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:212:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:212:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:212:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:212:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:212:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:212:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:212:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:212:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:212:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:213:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:213:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:213:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:213:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:213:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:213:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:213:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:213:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:213:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:215:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:215:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:215:1: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:215:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:215:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:215:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:215:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spi_statistics *stat @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:215:1: sparse:     expected struct spi_statistics *stat
   drivers/spi/spi.c:215:1: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:317:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:317:40: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:317:40: sparse:     got struct spi_statistics *
>> drivers/spi/spi.c:564:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct spi_statistics [noderef] __percpu *pcpu_statistics @@     got struct spi_statistics * @@
   drivers/spi/spi.c:564:30: sparse:     expected struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:564:30: sparse:     got struct spi_statistics *
>> drivers/spi/spi.c:1275:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spi_statistics *statm @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:1275:44: sparse:     expected struct spi_statistics *statm
   drivers/spi/spi.c:1275:44: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
>> drivers/spi/spi.c:1276:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spi_statistics *stats @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:1276:48: sparse:     expected struct spi_statistics *stats
   drivers/spi/spi.c:1276:48: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:1310:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:1310:25: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:1310:25: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:1311:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:1311:25: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:1311:25: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:1432:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spi_statistics *statm @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:1432:44: sparse:     expected struct spi_statistics *statm
   drivers/spi/spi.c:1432:44: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:1433:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spi_statistics *stats @@     got struct spi_statistics [noderef] __percpu *pcpu_statistics @@
   drivers/spi/spi.c:1433:48: sparse:     expected struct spi_statistics *stats
   drivers/spi/spi.c:1433:48: sparse:     got struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:1437:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:1437:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:1437:9: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:1438:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:1438:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:1438:9: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:1465:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:1465:33: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:1465:33: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:1467:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct spi_statistics * @@
   drivers/spi/spi.c:1467:33: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/spi/spi.c:1467:33: sparse:     got struct spi_statistics *
   drivers/spi/spi.c:3079:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct spi_statistics [noderef] __percpu *pcpu_statistics @@     got struct spi_statistics * @@
   drivers/spi/spi.c:3079:31: sparse:     expected struct spi_statistics [noderef] __percpu *pcpu_statistics
   drivers/spi/spi.c:3079:31: sparse:     got struct spi_statistics *

vim +117 drivers/spi/spi.c

    97	
    98	static struct spi_statistics *spi_alloc_pcpu_stats(struct device *dev)
    99	{
   100		struct spi_statistics __percpu *pcpu_stats;
   101	
   102		if (dev)
   103			pcpu_stats = devm_alloc_percpu(dev, struct spi_statistics);
   104		else
   105			pcpu_stats = alloc_percpu_gfp(struct spi_statistics, GFP_KERNEL);
   106	
   107		if (pcpu_stats) {
   108			int cpu;
   109	
   110			for_each_possible_cpu(cpu) {
   111				struct spi_statistics *stat;
   112	
   113				stat = per_cpu_ptr(pcpu_stats, cpu);
   114				u64_stats_init(&stat->syncp);
   115			}
   116		}
 > 117		return pcpu_stats;
   118	}
   119	
   120	#define spi_pcpu_stats_totalize(ret, in, field)				\
   121	do {									\
   122		int i;								\
   123		ret = 0;							\
   124		for_each_possible_cpu(i) {					\
   125			const struct spi_statistics *pcpu_stats;		\
   126			u64 inc;						\
   127			unsigned int start;					\
   128			pcpu_stats = per_cpu_ptr(in, i);			\
   129			do {							\
   130				start = u64_stats_fetch_begin_irq(		\
   131						&pcpu_stats->syncp);		\
   132				inc = u64_stats_read(&pcpu_stats->field);	\
   133			} while (u64_stats_fetch_retry_irq(			\
   134						&pcpu_stats->syncp, start));	\
   135			ret += inc;						\
   136		}								\
   137	} while (0)
   138	
   139	#define SPI_STATISTICS_ATTRS(field, file)				\
   140	static ssize_t spi_controller_##field##_show(struct device *dev,	\
   141						     struct device_attribute *attr, \
   142						     char *buf)			\
   143	{									\
   144		struct spi_controller *ctlr = container_of(dev,			\
   145						 struct spi_controller, dev);	\
   146		return spi_statistics_##field##_show(ctlr->pcpu_statistics, buf); \
   147	}									\
   148	static struct device_attribute dev_attr_spi_controller_##field = {	\
   149		.attr = { .name = file, .mode = 0444 },				\
   150		.show = spi_controller_##field##_show,				\
   151	};									\
   152	static ssize_t spi_device_##field##_show(struct device *dev,		\
   153						 struct device_attribute *attr,	\
   154						char *buf)			\
   155	{									\
   156		struct spi_device *spi = to_spi_device(dev);			\
   157		return spi_statistics_##field##_show(spi->pcpu_statistics, buf); \
   158	}									\
   159	static struct device_attribute dev_attr_spi_device_##field = {		\
   160		.attr = { .name = file, .mode = 0444 },				\
   161		.show = spi_device_##field##_show,				\
   162	}
   163	
   164	#define SPI_STATISTICS_SHOW_NAME(name, file, field)			\
   165	static ssize_t spi_statistics_##name##_show(struct spi_statistics *stat, \
   166						    char *buf)			\
   167	{									\
   168		ssize_t len;							\
   169		u64 val;							\
   170		spi_pcpu_stats_totalize(val, stat, field);			\
   171		len = sysfs_emit(buf, "%llu\n", val);				\
   172		return len;							\
   173	}									\
   174	SPI_STATISTICS_ATTRS(name, file)
   175	
   176	#define SPI_STATISTICS_SHOW(field)					\
   177		SPI_STATISTICS_SHOW_NAME(field, __stringify(field),		\
   178					 field)
   179	
 > 180	SPI_STATISTICS_SHOW(messages);
   181	SPI_STATISTICS_SHOW(transfers);
   182	SPI_STATISTICS_SHOW(errors);
   183	SPI_STATISTICS_SHOW(timedout);
   184	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
