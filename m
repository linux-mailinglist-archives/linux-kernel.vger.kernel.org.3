Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEABF573FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiGMXFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGMXF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:05:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C43E75F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657753526; x=1689289526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KInjmH2Mnl3KyfiMWE+PiVRYHapnSc7B3QmSTQbGqV0=;
  b=YYnCFuPJSu8VeHNmWtYZe6udjrSpvZC67C3KPu0qf0GueuCd5OVDPCSA
   cXklhRCMOeGCP3lodZevi8R1GuTQtoOJDS7mM7asKt8WE3u1GIDPe/YZG
   RxgOQtxXGZfqa7ldQG7Nxsyl1P2y9oKxe7gi3pRpY7DP08fZYFtHgImVQ
   ccbOSZGkDMmQkRnlMso6vbaXW95A6DWH2MkEb7sZWyfxGEY3C7e4K9b2d
   XtDjneRAS7hPMnUmAhQ2O7lP094fvHAuEPSvb2t3gvQqGtfoC1xCElwgS
   XTVgPxvIaNzt8Bq2b1PkJsedEIYfUxJPzkuv4HQV6KLsIw42k8y4G6dvC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="311012414"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="311012414"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 16:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="570823310"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2022 16:05:24 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBlQ3-0003s7-Gd;
        Wed, 13 Jul 2022 23:05:23 +0000
Date:   Thu, 14 Jul 2022 07:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct
 ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order:
 data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering
 the fields or adding explicit paddi...
Message-ID: <202207140603.1fJMMFgV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a57a8400075bc5287c5c877702c68aeae2a033d
commit: 396f7234856956eb29f009da6e5d846f29f87ebd iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
date:   1 year, 2 months ago
config: arm-randconfig-c002-20220702 (https://download.01.org/0day-ci/archive/20220714/202207140603.1fJMMFgV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=396f7234856956eb29f009da6e5d846f29f87ebd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 396f7234856956eb29f009da6e5d846f29f87ebd
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
           ^
   arch/arm/include/asm/uaccess.h:393:3: note: expanded from macro '__put_user_switch'
                   switch (sizeof(*(ptr))) {                               \
                   ^
   drivers/tee/tee_core.c:584:6: note:  Execution continues on line 584
           if (put_user(arg.ret, &uarg->ret) ||
               ^
   arch/arm/include/asm/uaccess.h:406:2: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
           ^
   arch/arm/include/asm/uaccess.h:396:47: note: expanded from macro '__put_user_switch'
                   case 4: __fn(__pu_val, __pu_ptr, __err, 4); break;      \
                                                               ^
   drivers/tee/tee_core.c:584:6: note: Loop condition is false.  Exiting loop
           if (put_user(arg.ret, &uarg->ret) ||
               ^
   arch/arm/include/asm/uaccess.h:406:2: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
           ^
   arch/arm/include/asm/uaccess.h:387:2: note: expanded from macro '__put_user_switch'
           do {                                                            \
           ^
   drivers/tee/tee_core.c:584:6: note: Assuming the condition is false
           if (put_user(arg.ret, &uarg->ret) ||
               ^
   arch/arm/include/asm/uaccess.h:403:31: note: expanded from macro 'put_user'
   #define put_user(x, ptr)                                                \
                                                                           ^
   drivers/tee/tee_core.c:584:6: note: Left side of '||' is false
           if (put_user(arg.ret, &uarg->ret) ||
               ^
   arch/arm/include/asm/uaccess.h:403:31: note: expanded from macro 'put_user'
   #define put_user(x, ptr)                                                \
                                                                           ^
   drivers/tee/tee_core.c:585:6: note: Control jumps to 'case 4:'  at line 585
               put_user(arg.ret_origin, &uarg->ret_origin)) {
               ^
   arch/arm/include/asm/uaccess.h:406:2: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
           ^
   arch/arm/include/asm/uaccess.h:393:3: note: expanded from macro '__put_user_switch'
                   switch (sizeof(*(ptr))) {                               \
                   ^
   drivers/tee/tee_core.c:585:6: note:  Execution continues on line 585
               put_user(arg.ret_origin, &uarg->ret_origin)) {
               ^
   arch/arm/include/asm/uaccess.h:406:2: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
           ^
   arch/arm/include/asm/uaccess.h:396:47: note: expanded from macro '__put_user_switch'
                   case 4: __fn(__pu_val, __pu_ptr, __err, 4); break;      \
                                                               ^
   drivers/tee/tee_core.c:585:6: note: Loop condition is false.  Exiting loop
               put_user(arg.ret_origin, &uarg->ret_origin)) {
               ^
   arch/arm/include/asm/uaccess.h:406:2: note: expanded from macro 'put_user'
           __put_user_switch((x), (ptr), __pu_err, __put_user_check);      \
           ^
   arch/arm/include/asm/uaccess.h:387:2: note: expanded from macro '__put_user_switch'
           do {                                                            \
           ^
   drivers/tee/tee_core.c:585:6: note: Assuming the condition is false
               put_user(arg.ret_origin, &uarg->ret_origin)) {
               ^
   arch/arm/include/asm/uaccess.h:403:31: note: expanded from macro 'put_user'
   #define put_user(x, ptr)                                                \
                                                                           ^
   drivers/tee/tee_core.c:584:2: note: Taking false branch
           if (put_user(arg.ret, &uarg->ret) ||
           ^
   drivers/tee/tee_core.c:589:47: note: Passing null pointer value via 3rd parameter 'params'
           rc = params_to_user(uparams, arg.num_params, params);
                                                        ^~~~~~
   drivers/tee/tee_core.c:589:7: note: Calling 'params_to_user'
           rc = params_to_user(uparams, arg.num_params, params);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tee/tee_core.c:439:14: note: Assuming 'n' is < 'num_params'
           for (n = 0; n < num_params; n++) {
                       ^~~~~~~~~~~~~~
   drivers/tee/tee_core.c:439:2: note: Loop condition is true.  Entering loop body
           for (n = 0; n < num_params; n++) {
           ^
   drivers/tee/tee_core.c:441:3: note: 'p' initialized to a null pointer value
                   struct tee_param *p = params + n;
                   ^~~~~~~~~~~~~~~~~~~
   drivers/tee/tee_core.c:443:11: note: Access to field 'attr' results in a dereference of a null pointer (loaded from variable 'p')
                   switch (p->attr) {
                           ^
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/iio/adc/ad7298.c:40:8: warning: Excessive padding in 'struct ad7298_state' (72 padding bytes, where 8 is optimal). Optimal fields order: rx_buf, spi, reg, ext_ref, ring_msg, scan_single_msg, scan_single_xfer, ring_xfer, tx_buf, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7298_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7298.c:40:8: note: Excessive padding in 'struct ad7298_state' (72 padding bytes, where 8 is optimal). Optimal fields order: rx_buf, spi, reg, ext_ref, ring_msg, scan_single_msg, scan_single_xfer, ring_xfer, tx_buf, consider reordering the fields or adding explicit padding members
   struct ad7298_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7476.c:39:8: note: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   Suppressed 15 warnings (15 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/soundwire/stream.c:848:10: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                           kfree(bus->defer_msg.msg->buf);
                                 ^
   drivers/soundwire/stream.c:1756:6: note: Assuming 'stream' is non-null
           if (!stream) {
               ^~~~~~~
   drivers/soundwire/stream.c:1756:2: note: Taking false branch
           if (!stream) {
           ^
   drivers/soundwire/stream.c:1763:6: note: Assuming field 'state' is equal to SDW_STREAM_ENABLED
           if (stream->state != SDW_STREAM_ENABLED) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/soundwire/stream.c:1763:2: note: Taking false branch
           if (stream->state != SDW_STREAM_ENABLED) {
           ^
   drivers/soundwire/stream.c:1770:8: note: Calling '_sdw_disable_stream'
           ret = _sdw_disable_stream(stream);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/soundwire/stream.c:1701:2: note: Left side of '&&' is false
           list_for_each_entry(m_rt, &stream->master_list, stream_node) {
           ^
   include/linux/list.h:628:13: note: expanded from macro 'list_for_each_entry'
           for (pos = list_first_entry(head, typeof(*pos), member);        \
                      ^
   include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
           list_entry((ptr)->next, type, member)
           ^
   include/linux/list.h:511:2: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ^
   include/linux/kernel.h:704:61: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                                                                      ^
   drivers/soundwire/stream.c:1701:2: note: Taking false branch
           list_for_each_entry(m_rt, &stream->master_list, stream_node) {
           ^
   include/linux/list.h:628:13: note: expanded from macro 'list_for_each_entry'
           for (pos = list_first_entry(head, typeof(*pos), member);        \
                      ^
   include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
           list_entry((ptr)->next, type, member)
           ^
   include/linux/list.h:511:2: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:308:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   drivers/soundwire/stream.c:1701:2: note: Loop condition is false.  Exiting loop
           list_for_each_entry(m_rt, &stream->master_list, stream_node) {
           ^
   include/linux/list.h:628:13: note: expanded from macro 'list_for_each_entry'
           for (pos = list_first_entry(head, typeof(*pos), member);        \
                      ^
   include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
           list_entry((ptr)->next, type, member)
           ^
   include/linux/list.h:511:2: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:306:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   drivers/soundwire/stream.c:1701:2: note: Loop condition is false. Execution continues on line 1711
           list_for_each_entry(m_rt, &stream->master_list, stream_node) {
           ^
   include/linux/list.h:628:2: note: expanded from macro 'list_for_each_entry'
           for (pos = list_first_entry(head, typeof(*pos), member);        \
           ^
--
                   ^
   drivers/crypto/inside-secure/safexcel.c:651:3: note: Taking false branch
                   if (priv->flags & SAFEXCEL_HW_EIP197)
                   ^
   drivers/crypto/inside-secure/safexcel.c:664:10: note: Assuming the condition is false
                   while ((readl(EIP197_HIA_DSE_THR(priv) + EIP197_HIA_DSE_THR_STAT(pe)) &
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/crypto/inside-secure/safexcel.c:664:3: note: Loop condition is false. Execution continues on line 669
                   while ((readl(EIP197_HIA_DSE_THR(priv) + EIP197_HIA_DSE_THR_STAT(pe)) &
                   ^
   drivers/crypto/inside-secure/safexcel.c:669:7: note: Assuming field 'hwnumpes' is <= 4
                   if (priv->hwconfig.hwnumpes > 4) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/crypto/inside-secure/safexcel.c:669:3: note: Taking false branch
                   if (priv->hwconfig.hwnumpes > 4) {
                   ^
   drivers/crypto/inside-secure/safexcel.c:684:3: note: Taking false branch
                   if (priv->flags & SAFEXCEL_HW_EIP197)
                   ^
   drivers/crypto/inside-secure/safexcel.c:618:15: note: Assuming 'pe' is >= field 'pes'
           for (pe = 0; pe < priv->config.pes; pe++) {
                        ^~~~~~~~~~~~~~~~~~~~~
   drivers/crypto/inside-secure/safexcel.c:618:2: note: Loop condition is false. Execution continues on line 712
           for (pe = 0; pe < priv->config.pes; pe++) {
           ^
   drivers/crypto/inside-secure/safexcel.c:712:14: note: Assuming 'i' is >= field 'rings'
           for (i = 0; i < priv->config.rings; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/crypto/inside-secure/safexcel.c:712:2: note: Loop condition is false. Execution continues on line 738
           for (i = 0; i < priv->config.rings; i++) {
           ^
   drivers/crypto/inside-secure/safexcel.c:738:2: note: Loop condition is false. Execution continues on line 760
           for (i = 0; i < priv->config.rings; i++) {
           ^
   drivers/crypto/inside-secure/safexcel.c:760:2: note: Loop condition is true.  Entering loop body
           for (pe = 0; pe < priv->config.pes; pe++) {
           ^
   drivers/crypto/inside-secure/safexcel.c:762:35: note: The result of the right shift is undefined due to shifting by '32', which is greater or equal to the width of type 'unsigned long'
                   writel(EIP197_DxE_THR_CTRL_EN | GENMASK(priv->config.rings - 1, 0),
                                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   arch/arm/include/asm/io.h:307:51: note: expanded from macro 'writel'
   #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
                                                 ~~~~~~~~~~~~~~~^~~~
   arch/arm/include/asm/io.h:299:68: note: expanded from macro 'writel_relaxed'
   #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
                                                              ~~~~~~~~~~~~^~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   Suppressed 16 warnings (16 in non-user code).
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
   drivers/iio/imu/adis16400.c:179:8: warning: Excessive padding in 'struct adis16400_state' (112 padding bytes, where 48 is optimal). Optimal fields order: adis, variant, filt_int, avail_scan_mask, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adis16400_state {
   ~~~~~~~^~~~~~~~~~~~~~~~~
   drivers/iio/imu/adis16400.c:179:8: note: Excessive padding in 'struct adis16400_state' (112 padding bytes, where 48 is optimal). Optimal fields order: adis, variant, filt_int, avail_scan_mask, consider reordering the fields or adding explicit padding members
   struct adis16400_state {
   ~~~~~~~^~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/iio/imu/adis16475.c:100:8: warning: Excessive padding in 'struct adis16475' (73 padding bytes, where 9 is optimal). Optimal fields order: adis, data, info, clk_freq, lsb_flag, sync_mode, burst32, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct adis16475 {
   ~~~~~~~^~~~~~~~~~~
   drivers/iio/imu/adis16475.c:100:8: note: Excessive padding in 'struct adis16475' (73 padding bytes, where 9 is optimal). Optimal fields order: adis, data, info, clk_freq, lsb_flag, sync_mode, burst32, consider reordering the fields or adding explicit padding members
   struct adis16475 {
   ~~~~~~~^~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/iio/adc/ad7298.c:40:8: warning: Excessive padding in 'struct ad7298_state' (72 padding bytes, where 8 is optimal). Optimal fields order: rx_buf, spi, reg, ext_ref, ring_msg, scan_single_msg, scan_single_xfer, ring_xfer, tx_buf, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7298_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7298.c:40:8: note: Excessive padding in 'struct ad7298_state' (72 padding bytes, where 8 is optimal). Optimal fields order: rx_buf, spi, reg, ext_ref, ring_msg, scan_single_msg, scan_single_xfer, ring_xfer, tx_buf, consider reordering the fields or adding explicit padding members
   struct ad7298_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7476.c:39:8: note: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   32 warnings generated.
   net/9p/client.c:541:3: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
                   err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/9p/client.c:541:3: note: Value stored to 'err' is never read
                   err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/9p/client.c:628:3: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
                   err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/9p/client.c:628:3: note: Value stored to 'err' is never read
                   err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/9p/client.c:1008:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1008:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:1175:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1175:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:1252:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1252:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:1344:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1344:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:1713:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1713:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:1766:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1766:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:1916:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:1916:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:2018:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:2018:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:2095:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:2095:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:2155:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:2155:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:2186:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:2186:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:2216:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:2216:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/9p/client.c:2249:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/9p/client.c:2249:2: note: Value stored to 'err' is never read
           err = 0;

vim +39 drivers/iio/adc/ad7476.c

7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  38  
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10 @39  struct ad7476_state {
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  40  	struct spi_device		*spi;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  41  	const struct ad7476_chip_info	*chip_info;
7bf50a968a1cd0 drivers/iio/adc/ad7476.c         Jonathan Cameron   2021-04-25  42  	struct regulator		*ref_reg;
af37e4703d00ce drivers/iio/adc/ad7476.c         Dragos Bogdan      2020-03-11  43  	struct gpio_desc		*convst_gpio;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  44  	struct spi_transfer		xfer;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  45  	struct spi_message		msg;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  46  	/*
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  47  	 * DMA (thus cache coherency maintenance) requires the
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  48  	 * transfer buffers to live in their own cache lines.
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  49  	 * Make the buffer large enough for one 16 bit sample and one 64 bit
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  50  	 * aligned 64 bit timestamp.
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  51  	 */
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  52  	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)]
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  53  			____cacheline_aligned;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  54  };
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  55  

:::::: The code at line 39 was first introduced by commit
:::::: 7a28fe3c93d6cd920c84678a1bf45af8b4248577 staging:iio:ad7476: Squash driver into a single file.

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
