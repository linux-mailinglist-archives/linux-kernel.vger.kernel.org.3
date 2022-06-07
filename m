Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CD53F450
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiFGDJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiFGDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:09:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C17B0D26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654571381; x=1686107381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FSkqDh/dYhtKRhHt1UkQB4kxJx8dH+7TInuQbpxIIpY=;
  b=ba8rqIMlBF+cwjVvx/b3IM51y1CImqsruESHYYW0zS8BSeDAe4CnPkBV
   IfaQzMg6Ycdknk5/yn7SgB6Rg5YTA9HBhKzdWgYy5cSrKgSLzDVF7R6Bq
   RxONaiu/RgwUEjy9TM3rCV8t06HJ+zVHQUnJ9v2j7fC+jy7m8SpKdC78f
   RKp/niAO/A8rjeSJOClD5Di+CDvH+cD8RLO6MlXqjCNQAvV3bT9P0g5n8
   8SmSi15X0rzUUJ1FDr2F2U5WDzZWvtZ9NJomHP/YJVha939qD303GXDsU
   T5IOsZCEyCA5EI5ADPvSeSCVBiSI92zMneyLGVNSAlLRDl7HUl9J4cJSM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275480050"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="275480050"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="614700148"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Jun 2022 20:09:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyPb8-000DHh-DS;
        Tue, 07 Jun 2022 03:09:38 +0000
Date:   Tue, 7 Jun 2022 11:09:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Jander <david@protonic.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:fileixI84n 9/10] drivers/spi/spi.c:117:16: sparse:
 sparse: incorrect type in return expression (different address spaces)
Message-ID: <202206071106.ruA69gMb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git fileixI84n
head:   8d0b512844fdee83b6299647aa178828a4ebfc3b
commit: 6598b91b5ac32bc756d7c3000a31f775d4ead1c4 [9/10] spi: spi.c: Convert statistics to per-cpu u64_stats_t
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220607/202206071106.ruA69gMb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=6598b91b5ac32bc756d7c3000a31f775d4ead1c4
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci fileixI84n
        git checkout 6598b91b5ac32bc756d7c3000a31f775d4ead1c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/spi/

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
