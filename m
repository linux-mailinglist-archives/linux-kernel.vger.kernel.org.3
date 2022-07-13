Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4696B572FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiGMH4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiGMH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:56:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E295ADEAE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657698960; x=1689234960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wTTNkSqRCfMZ5aflS3du4+DJ8blKNU3HNcavD/5S8Ao=;
  b=fyY9HZfI8iKClGMB0zSCoqeC1XXvrU/pjvOzFPJrEn0ylYitbJ+a05mo
   iEoj+vXrvgN2Ibcla7hJ2DPy/ONj67yict+0ImSF9pJayxZDOqle9pmKV
   T3mK3p8wWbf8mZWfeUKk7dkBXMPq8vvnOqxPwsDGWF7eqU2QeFiTOlKpU
   7YNVBFtNBE+W0fSUhQAHvOBhqAbwxua5IJ5+P+2dt6LkqZmFImZ7gppku
   D2gPBF2aauLKR3d0rUB3kgoc6M+/vzQQ72+z4RmVuANKVadagIi7feTi+
   lG4Bix7OeFKuAvGaOULjq5A6zhCogVN3Fa713y+CLhZgxrieZfMVihndn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="349115453"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="349115453"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 00:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570522549"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2022 00:55:52 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBXDr-0003HL-Rz;
        Wed, 13 Jul 2022 07:55:51 +0000
Date:   Wed, 13 Jul 2022 15:55:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in
 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal
 fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr,
 consider reordering the fields or adding explicit...
Message-ID: <202207131504.oHGQ85fm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: ec679bda639fe84b78d473526ae27c74dea383fb spi: bcm2835: Allow arbitrary number of slaves
date:   1 year, 1 month ago
config: arm-randconfig-c002-20220702 (https://download.01.org/0day-ci/archive/20220713/202207131504.oHGQ85fm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec679bda639fe84b78d473526ae27c74dea383fb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ec679bda639fe84b78d473526ae27c74dea383fb
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
   fs/select.c:999:4: note:  Execution continues on line 1010
                           break;
                           ^
   fs/select.c:1011:12: note: Calling 'do_poll'
           fdcount = do_poll(head, &table, end_time);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/select.c:888:23: note: Assuming the condition is false
           __poll_t busy_flag = net_busy_loop_on() ? POLL_BUSY_LOOP : 0;
                                ^~~~~~~~~~~~~~~~~~
   fs/select.c:888:23: note: '?' condition is false
   fs/select.c:892:6: note: 'end_time' is null
           if (end_time && !end_time->tv_sec && !end_time->tv_nsec) {
               ^~~~~~~~
   fs/select.c:892:15: note: Left side of '&&' is false
           if (end_time && !end_time->tv_sec && !end_time->tv_nsec) {
                        ^
   fs/select.c:897:6: note: 'end_time' is null
           if (end_time && !timed_out)
               ^~~~~~~~
   fs/select.c:897:15: note: Left side of '&&' is false
           if (end_time && !timed_out)
                        ^
   fs/select.c:900:2: note: Loop condition is true.  Entering loop body
           for (;;) {
           ^
   fs/select.c:904:3: note: Loop condition is true.  Entering loop body
                   for (walk = list; walk != NULL; walk = walk->next) {
                   ^
   fs/select.c:909:11: note: 'pfd' is not equal to 'pfd_end'
                           for (; pfd != pfd_end; pfd++) {
                                  ^~~
   fs/select.c:909:4: note: Loop condition is true.  Entering loop body
                           for (; pfd != pfd_end; pfd++) {
                           ^
   fs/select.c:917:9: note: Calling 'do_pollfd'
                                   if (do_pollfd(pfd, pt, &can_busy_loop,
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/select.c:855:2: note: Assigned value is garbage or undefined
           int fd = pollfd->fd;
           ^        ~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/mfd/qcom-pm8xxx.c:557:2: warning: Value stored to 'rev' is never read [clang-analyzer-deadcode.DeadStores]
           rev |= val << BITS_PER_BYTE;
           ^      ~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/qcom-pm8xxx.c:557:2: note: Value stored to 'rev' is never read
           rev |= val << BITS_PER_BYTE;
           ^      ~~~~~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (15 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   drivers/i2c/algos/i2c-algo-pcf.c:322:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                   ret = pcf_doAddress(adap, pmsg);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/algos/i2c-algo-pcf.c:322:3: note: Value stored to 'ret' is never read
                   ret = pcf_doAddress(adap, pmsg);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:153:8: note: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1164:20: warning: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx') [clang-analyzer-core.NullDereference]
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Calling 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:675:2: note: Returning without writing to 'ctlr->dma_rx'
           return dev_get_drvdata(&ctlr->dev);
           ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Returning from 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1219:6: note: Assuming 'slv' is non-null
           if (!slv) {
               ^~~~
   drivers/spi/spi-bcm2835.c:1219:2: note: Taking false branch
           if (!slv) {
           ^
   drivers/spi/spi-bcm2835.c:1239:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPOL)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1239:2: note: Taking false branch
           if (spi->mode & SPI_CPOL)
           ^
   drivers/spi/spi-bcm2835.c:1241:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPHA)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1241:2: note: Taking false branch
           if (spi->mode & SPI_CPHA)
           ^
   drivers/spi/spi-bcm2835.c:1249:6: note: Assuming field 'dma_rx' is null
           if (ctlr->dma_rx) {
               ^~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1249:2: note: Taking false branch
           if (ctlr->dma_rx) {
           ^
   drivers/spi/spi-bcm2835.c:1262:6: note: Assuming the condition is false
           if (spi->mode & SPI_NO_CS)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1262:2: note: Taking false branch
           if (spi->mode & SPI_NO_CS)
           ^
   drivers/spi/spi-bcm2835.c:1268:6: note: Assuming field 'cs_gpiod' is null
           if (spi->cs_gpiod)
               ^~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1268:2: note: Taking false branch
           if (spi->cs_gpiod)
           ^
   drivers/spi/spi-bcm2835.c:1270:6: note: Assuming field 'chip_select' is <= 1
           if (spi->chip_select > 1) {
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1270:2: note: Taking false branch
           if (spi->chip_select > 1) {
           ^
   drivers/spi/spi-bcm2835.c:1292:6: note: Assuming 'chip' is non-null
           if (!chip)
               ^~~~~
   drivers/spi/spi-bcm2835.c:1292:2: note: Taking false branch
           if (!chip)
           ^
   drivers/spi/spi-bcm2835.c:1299:2: note: Taking true branch
           if (IS_ERR(spi->cs_gpiod)) {
           ^
   drivers/spi/spi-bcm2835.c:1301:3: note: Control jumps to line 1311
                   goto err_cleanup;
                   ^
   drivers/spi/spi-bcm2835.c:1311:2: note: Calling 'bcm2835_spi_cleanup'
           bcm2835_spi_cleanup(spi);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:6: note: Assuming field 'clear_rx_desc' is null
           if (slv->clear_rx_desc)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:2: note: Taking false branch
           if (slv->clear_rx_desc)
           ^
   drivers/spi/spi-bcm2835.c:1163:6: note: Assuming field 'clear_rx_addr' is not equal to 0
           if (slv->clear_rx_addr)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1163:2: note: Taking true branch
           if (slv->clear_rx_addr)
           ^
   drivers/spi/spi-bcm2835.c:1164:20: note: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx')
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   include/linux/dma-mapping.h:427:61: note: expanded from macro 'dma_unmap_single'
   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
                                                               ^
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
--
                           ^~~~~~
   kernel/trace/trace_events_hist.c:2495:3: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcat(cmd, key_field->field->name);
                   ^~~~~~
   kernel/trace/trace_events_hist.c:2495:3: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
                   strcat(cmd, key_field->field->name);
                   ^~~~~~
   kernel/trace/trace_events_hist.c:2500:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(cmd, ":synthetic_");
           ^~~~~~
   kernel/trace/trace_events_hist.c:2500:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(cmd, ":synthetic_");
           ^~~~~~
   kernel/trace/trace_events_hist.c:2501:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(cmd, field_name);
           ^~~~~~
   kernel/trace/trace_events_hist.c:2501:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(cmd, field_name);
           ^~~~~~
   kernel/trace/trace_events_hist.c:2502:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(cmd, "=");
           ^~~~~~
   kernel/trace/trace_events_hist.c:2502:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(cmd, "=");
           ^~~~~~
   kernel/trace/trace_events_hist.c:2503:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(cmd, field_name);
           ^~~~~~
   kernel/trace/trace_events_hist.c:2503:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(cmd, field_name);
           ^~~~~~
   kernel/trace/trace_events_hist.c:2508:3: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcat(cmd, " if ");
                   ^~~~~~
   kernel/trace/trace_events_hist.c:2508:3: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
                   strcat(cmd, " if ");
                   ^~~~~~
   kernel/trace/trace_events_hist.c:2509:3: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcat(cmd, saved_filter);
                   ^~~~~~
   kernel/trace/trace_events_hist.c:2509:3: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
                   strcat(cmd, saved_filter);
                   ^~~~~~
   kernel/trace/trace_events_hist.c:5233:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                   ret = event_hist_trigger_func(&trigger_hist_cmd, file,
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_hist.c:5233:3: note: Value stored to 'ret' is never read
                   ret = event_hist_trigger_func(&trigger_hist_cmd, file,
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_hist.c:5674:6: warning: Array access (from variable 'glob') results in a null pointer dereference [clang-analyzer-core.NullDereference]
           if (glob[0] == '!')
               ^~~~
   kernel/trace/trace_events_hist.c:5664:2: note: Assuming 'debug_locks' is 0
           lockdep_assert_held(&event_mutex);
           ^
   include/linux/lockdep.h:310:11: note: expanded from macro 'lockdep_assert_held'
                   WARN_ON(debug_locks &&                                  \
                           ^~~~~~~~~~~
   include/asm-generic/bug.h:119:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   kernel/trace/trace_events_hist.c:5664:2: note: Left side of '&&' is false
           lockdep_assert_held(&event_mutex);
           ^
   include/linux/lockdep.h:310:23: note: expanded from macro 'lockdep_assert_held'
                   WARN_ON(debug_locks &&                                  \
                                       ^
   kernel/trace/trace_events_hist.c:5664:2: note: Taking false branch
           lockdep_assert_held(&event_mutex);
           ^
   include/linux/lockdep.h:310:3: note: expanded from macro 'lockdep_assert_held'
                   WARN_ON(debug_locks &&                                  \
                   ^
   include/asm-generic/bug.h:120:2: note: expanded from macro 'WARN_ON'
           if (unlikely(__ret_warn_on))                                    \
           ^
   kernel/trace/trace_events_hist.c:5664:2: note: Loop condition is false.  Exiting loop
           lockdep_assert_held(&event_mutex);
           ^
   include/linux/lockdep.h:309:32: note: expanded from macro 'lockdep_assert_held'
   #define lockdep_assert_held(l)  do {                                    \
                                   ^
   kernel/trace/trace_events_hist.c:5666:6: note: Assuming 'glob' is null
           if (glob && strlen(glob)) {
               ^~~~
   kernel/trace/trace_events_hist.c:5666:11: note: Left side of '&&' is false
           if (glob && strlen(glob)) {
                    ^
   kernel/trace/trace_events_hist.c:5671:6: note: Assuming 'param' is non-null
           if (!param)
               ^~~~~~
   kernel/trace/trace_events_hist.c:5671:2: note: Taking false branch
           if (!param)
           ^
   kernel/trace/trace_events_hist.c:5674:6: note: Array access (from variable 'glob') results in a null pointer dereference
           if (glob[0] == '!')
               ^~~~
   Suppressed 17 warnings (16 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/spi/spi-bcm2835.c:153:8: warning: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:153:8: note: Excessive padding in 'struct bcm2835_spidev' (112 padding bytes, where 48 is optimal). Optimal fields order: clear_rx_cs, prepare_cs, clear_rx_desc, clear_rx_addr, consider reordering the fields or adding explicit padding members
   struct bcm2835_spidev {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1164:20: warning: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx') [clang-analyzer-core.NullDereference]
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Calling 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:675:2: note: Returning without writing to 'ctlr->dma_rx'
           return dev_get_drvdata(&ctlr->dev);
           ^
   drivers/spi/spi-bcm2835.c:1213:27: note: Returning from 'spi_controller_get_devdata'
           struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1219:6: note: Assuming 'slv' is non-null
           if (!slv) {
               ^~~~
   drivers/spi/spi-bcm2835.c:1219:2: note: Taking false branch
           if (!slv) {
           ^
   drivers/spi/spi-bcm2835.c:1239:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPOL)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1239:2: note: Taking false branch
           if (spi->mode & SPI_CPOL)
           ^
   drivers/spi/spi-bcm2835.c:1241:6: note: Assuming the condition is false
           if (spi->mode & SPI_CPHA)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1241:2: note: Taking false branch
           if (spi->mode & SPI_CPHA)
           ^
   drivers/spi/spi-bcm2835.c:1249:6: note: Assuming field 'dma_rx' is null
           if (ctlr->dma_rx) {
               ^~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1249:2: note: Taking false branch
           if (ctlr->dma_rx) {
           ^
   drivers/spi/spi-bcm2835.c:1262:6: note: Assuming the condition is false
           if (spi->mode & SPI_NO_CS)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1262:2: note: Taking false branch
           if (spi->mode & SPI_NO_CS)
           ^
   drivers/spi/spi-bcm2835.c:1268:6: note: Assuming field 'cs_gpiod' is null
           if (spi->cs_gpiod)
               ^~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1268:2: note: Taking false branch
           if (spi->cs_gpiod)
           ^
   drivers/spi/spi-bcm2835.c:1270:6: note: Assuming field 'chip_select' is <= 1
           if (spi->chip_select > 1) {
               ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1270:2: note: Taking false branch
           if (spi->chip_select > 1) {
           ^
   drivers/spi/spi-bcm2835.c:1292:6: note: Assuming 'chip' is non-null
           if (!chip)
               ^~~~~
   drivers/spi/spi-bcm2835.c:1292:2: note: Taking false branch
           if (!chip)
           ^
   drivers/spi/spi-bcm2835.c:1299:2: note: Taking true branch
           if (IS_ERR(spi->cs_gpiod)) {
           ^
   drivers/spi/spi-bcm2835.c:1301:3: note: Control jumps to line 1311
                   goto err_cleanup;
                   ^
   drivers/spi/spi-bcm2835.c:1311:2: note: Calling 'bcm2835_spi_cleanup'
           bcm2835_spi_cleanup(spi);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:6: note: Assuming field 'clear_rx_desc' is null
           if (slv->clear_rx_desc)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1160:2: note: Taking false branch
           if (slv->clear_rx_desc)
           ^
   drivers/spi/spi-bcm2835.c:1163:6: note: Assuming field 'clear_rx_addr' is not equal to 0
           if (slv->clear_rx_addr)
               ^~~~~~~~~~~~~~~~~~
   drivers/spi/spi-bcm2835.c:1163:2: note: Taking true branch
           if (slv->clear_rx_addr)
           ^
   drivers/spi/spi-bcm2835.c:1164:20: note: Access to field 'device' results in a dereference of a null pointer (loaded from field 'dma_rx')
                   dma_unmap_single(ctlr->dma_rx->device->dev,
                                    ^
   include/linux/dma-mapping.h:427:61: note: expanded from macro 'dma_unmap_single'
   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
                                                               ^
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.

vim +153 drivers/spi/spi-bcm2835.c

   142	
   143	/**
   144	 * struct bcm2835_spidev - BCM2835 SPI slave
   145	 * @prepare_cs: precalculated CS register value for ->prepare_message()
   146	 *	(uses slave-specific clock polarity and phase settings)
   147	 * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
   148	 *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
   149	 * @clear_rx_addr: bus address of @clear_rx_cs
   150	 * @clear_rx_cs: precalculated CS register value to clear RX FIFO
   151	 *	(uses slave-specific clock polarity and phase settings)
   152	 */
 > 153	struct bcm2835_spidev {
   154		u32 prepare_cs;
   155		struct dma_async_tx_descriptor *clear_rx_desc;
   156		dma_addr_t clear_rx_addr;
   157		u32 clear_rx_cs ____cacheline_aligned;
   158	};
   159	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
