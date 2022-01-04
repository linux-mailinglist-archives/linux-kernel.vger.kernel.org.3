Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34312483B71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiADFIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:08:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:65043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbiADFI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641272906; x=1672808906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VaYRldoJ+WAcFyrTltzKdsBb03lBvDiuu1Tis0KSL5A=;
  b=f2CeC/M322vMLb+hGbWSycfRaMhr6qyk5pEfkDjpUgQwD8nia6DiH11w
   P3nVYe/dE053sMESS6dy1tkmkzmLid8KxbpYXrAJcNXprm++YK4d0/w+O
   DpFt0GkTL7CyCpovnNjh3ZH4PGi9QmHw0keQoJP/CyuJcG7VfqU2S2Qi8
   sge2RaXzOBo/YBnddd1A3LTbqZLC4BRRZcq936EiGNL2rdPouF5xnMzmb
   S8VH4Yze7CzLaUPzePHDUXfTISSfArD13IRd3EW51i9TbU/tDEhOW+zd+
   G/K+YsJMnxTS8Goh4EuuB96Gyf2FwW9Q0+LoznWGs9s6r22+qRwW0ivTT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="228978256"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="228978256"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 21:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="760275740"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2022 21:08:24 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4c3b-000EiZ-Da; Tue, 04 Jan 2022 05:08:23 +0000
Date:   Tue, 4 Jan 2022 13:07:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [willy-pagecache:for-next 6/49]
 drivers/net/ethernet/sfc/ef10.c:50:9: warning: shift count is negative
Message-ID: <202201041341.IWW7EqP0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   c45f479798001734025928cbbce2e42f6cedea1c
commit: 442f739136ee2d6bff8f07524447d4e40217de62 [6/49] iov_iter: Add copy_folio_to_iter()
config: x86_64-randconfig-a011-20220103 (https://download.01.org/0day-ci/archive/20220104/202201041341.IWW7EqP0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b50fea47b6c454581fce89af359f3afe5154986c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 442f739136ee2d6bff8f07524447d4e40217de62
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/sfc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/sfc/ef10.c:7:
   In file included from drivers/net/ethernet/sfc/net_driver.h:13:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:15:
   In file included from include/net/flow.h:11:
   In file included from include/linux/socket.h:8:
   include/linux/uio.h:153:33: error: incomplete definition of type 'struct folio'
           return copy_page_to_iter(&folio->page, offset, bytes, i);
                                     ~~~~~^
   include/linux/uio.h:13:8: note: forward declaration of 'struct folio'
   struct folio;
          ^
>> drivers/net/ethernet/sfc/ef10.c:50:9: warning: shift count is negative [-Wshift-count-negative]
           return EFX_DWORD_FIELD(reg, EFX_WORD_1) == 0xb007 ?
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:165:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
           (EFX_EXTRACT32((dword).u32[0], 0, 31, low, high) &      \
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:141:2: note: expanded from macro 'EFX_EXTRACT32'
           EFX_EXTRACT_NATIVE(le32_to_cpu(element), min, max, low, high)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:127:20: note: expanded from macro 'EFX_EXTRACT_NATIVE'
            (native_element) << ((min) - (low)))
                             ^  ~~~~~~~~~~~~~~~
>> drivers/net/ethernet/sfc/ef10.c:102:23: warning: shift count >= width of type [-Wshift-count-overflow]
           nic_data->vf_index = MCDI_DWORD(outbuf, GET_FUNCTION_INFO_OUT_VF);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:127:3: warning: shift count >= width of type [-Wshift-count-overflow]
                   MCDI_DWORD(outbuf, GET_CAPABILITIES_OUT_FLAGS1);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:130:30: warning: shift count >= width of type [-Wshift-count-overflow]
                   nic_data->datapath_caps2 = MCDI_DWORD(outbuf,
                                              ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:198:32: warning: shift count >= width of type [-Wshift-count-overflow]
           nic_data->licensed_features = MCDI_QWORD(outbuf,
                                         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:281:3: note: expanded from macro 'MCDI_QWORD'
           (EFX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[0], EFX_DWORD_0) |   \
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:198:32: warning: shift count >= width of type [-Wshift-count-overflow]
           nic_data->licensed_features = MCDI_QWORD(outbuf,
                                         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:282:7: note: expanded from macro 'MCDI_QWORD'
           (u64)EFX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[1], EFX_DWORD_0) << 32)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:211:7: warning: shift count >= width of type [-Wshift-count-overflow]
           rc = MCDI_DWORD(outbuf, GET_CLOCK_OUT_SYS_FREQ);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:71:16: note: expanded from macro 'EFX_MASK32'
            (((((u32) 1) << (width))) - 1))
                         ^  ~~~~~~~
   drivers/net/ethernet/sfc/ef10.c:267:27: warning: shift count >= width of type [-Wshift-count-overflow]
                   efx->timer_quantum_ns = MCDI_DWORD(data,
                                           ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/mcdi.h:218:2: note: expanded from macro 'MCDI_DWORD'
           EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:185:2: note: expanded from macro 'EFX_DWORD_FIELD'
           EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:166:3: note: expanded from macro 'EFX_EXTRACT_DWORD'
            EFX_MASK32((high) + 1 - (low)))
--
   In file included from drivers/net/ethernet/sfc/mcdi.c:10:
   In file included from drivers/net/ethernet/sfc/net_driver.h:13:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:15:
   In file included from include/net/flow.h:11:
   In file included from include/linux/socket.h:8:
   include/linux/uio.h:153:33: error: incomplete definition of type 'struct folio'
           return copy_page_to_iter(&folio->page, offset, bytes, i);
                                     ~~~~~^
   include/linux/uio.h:13:8: note: forward declaration of 'struct folio'
   struct folio;
          ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> drivers/net/ethernet/sfc/mcdi.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/mcdi.c:187:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/mcdi.c:187:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:257:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:252:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/mcdi.c:187:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:256:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:246:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:33:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/mcdi.c:187:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_DWORD_7(hdr[0],
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:471:2: note: expanded from macro 'EFX_POPULATE_DWORD_7'
           EFX_POPULATE_DWORD_8(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:469:2: note: expanded from macro 'EFX_POPULATE_DWORD_8'
           EFX_POPULATE_DWORD_9(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:467:2: note: expanded from macro 'EFX_POPULATE_DWORD_9'
           EFX_POPULATE_DWORD_10(dword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 14 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
..


vim +50 drivers/net/ethernet/sfc/ef10.c

8127d661e77f5e Ben Hutchings  2013-08-29   44  
8127d661e77f5e Ben Hutchings  2013-08-29   45  static int efx_ef10_get_warm_boot_count(struct efx_nic *efx)
8127d661e77f5e Ben Hutchings  2013-08-29   46  {
8127d661e77f5e Ben Hutchings  2013-08-29   47  	efx_dword_t reg;
8127d661e77f5e Ben Hutchings  2013-08-29   48  
8127d661e77f5e Ben Hutchings  2013-08-29   49  	efx_readd(efx, &reg, ER_DZ_BIU_MC_SFT_STATUS);
8127d661e77f5e Ben Hutchings  2013-08-29  @50  	return EFX_DWORD_FIELD(reg, EFX_WORD_1) == 0xb007 ?
8127d661e77f5e Ben Hutchings  2013-08-29   51  		EFX_DWORD_FIELD(reg, EFX_WORD_0) : -EIO;
8127d661e77f5e Ben Hutchings  2013-08-29   52  }
8127d661e77f5e Ben Hutchings  2013-08-29   53  
03714bbb22ebe0 Edward Cree    2017-12-18   54  /* On all EF10s up to and including SFC9220 (Medford1), all PFs use BAR 0 for
03714bbb22ebe0 Edward Cree    2017-12-18   55   * I/O space and BAR 2(&3) for memory.  On SFC9250 (Medford2), there is no I/O
03714bbb22ebe0 Edward Cree    2017-12-18   56   * bar; PFs use BAR 0/1 for memory.
03714bbb22ebe0 Edward Cree    2017-12-18   57   */
03714bbb22ebe0 Edward Cree    2017-12-18   58  static unsigned int efx_ef10_pf_mem_bar(struct efx_nic *efx)
03714bbb22ebe0 Edward Cree    2017-12-18   59  {
03714bbb22ebe0 Edward Cree    2017-12-18   60  	switch (efx->pci_dev->device) {
03714bbb22ebe0 Edward Cree    2017-12-18   61  	case 0x0b03: /* SFC9250 PF */
03714bbb22ebe0 Edward Cree    2017-12-18   62  		return 0;
03714bbb22ebe0 Edward Cree    2017-12-18   63  	default:
03714bbb22ebe0 Edward Cree    2017-12-18   64  		return 2;
03714bbb22ebe0 Edward Cree    2017-12-18   65  	}
03714bbb22ebe0 Edward Cree    2017-12-18   66  }
03714bbb22ebe0 Edward Cree    2017-12-18   67  
03714bbb22ebe0 Edward Cree    2017-12-18   68  /* All VFs use BAR 0/1 for memory */
03714bbb22ebe0 Edward Cree    2017-12-18   69  static unsigned int efx_ef10_vf_mem_bar(struct efx_nic *efx)
03714bbb22ebe0 Edward Cree    2017-12-18   70  {
03714bbb22ebe0 Edward Cree    2017-12-18   71  	return 0;
03714bbb22ebe0 Edward Cree    2017-12-18   72  }
03714bbb22ebe0 Edward Cree    2017-12-18   73  
8127d661e77f5e Ben Hutchings  2013-08-29   74  static unsigned int efx_ef10_mem_map_size(struct efx_nic *efx)
8127d661e77f5e Ben Hutchings  2013-08-29   75  {
02246a7f966c2e Shradha Shah   2015-05-06   76  	int bar;
02246a7f966c2e Shradha Shah   2015-05-06   77  
03714bbb22ebe0 Edward Cree    2017-12-18   78  	bar = efx->type->mem_bar(efx);
02246a7f966c2e Shradha Shah   2015-05-06   79  	return resource_size(&efx->pci_dev->resource[bar]);
8127d661e77f5e Ben Hutchings  2013-08-29   80  }
8127d661e77f5e Ben Hutchings  2013-08-29   81  
7a186f4703de6f Daniel Pieczko 2015-07-07   82  static bool efx_ef10_is_vf(struct efx_nic *efx)
7a186f4703de6f Daniel Pieczko 2015-07-07   83  {
7a186f4703de6f Daniel Pieczko 2015-07-07   84  	return efx->type->is_vf;
7a186f4703de6f Daniel Pieczko 2015-07-07   85  }
7a186f4703de6f Daniel Pieczko 2015-07-07   86  
88a37de674f8a7 Shradha Shah   2015-05-20   87  #ifdef CONFIG_SFC_SRIOV
88a37de674f8a7 Shradha Shah   2015-05-20   88  static int efx_ef10_get_vf_index(struct efx_nic *efx)
88a37de674f8a7 Shradha Shah   2015-05-20   89  {
88a37de674f8a7 Shradha Shah   2015-05-20   90  	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_FUNCTION_INFO_OUT_LEN);
88a37de674f8a7 Shradha Shah   2015-05-20   91  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
88a37de674f8a7 Shradha Shah   2015-05-20   92  	size_t outlen;
88a37de674f8a7 Shradha Shah   2015-05-20   93  	int rc;
88a37de674f8a7 Shradha Shah   2015-05-20   94  
88a37de674f8a7 Shradha Shah   2015-05-20   95  	rc = efx_mcdi_rpc(efx, MC_CMD_GET_FUNCTION_INFO, NULL, 0, outbuf,
88a37de674f8a7 Shradha Shah   2015-05-20   96  			  sizeof(outbuf), &outlen);
88a37de674f8a7 Shradha Shah   2015-05-20   97  	if (rc)
88a37de674f8a7 Shradha Shah   2015-05-20   98  		return rc;
88a37de674f8a7 Shradha Shah   2015-05-20   99  	if (outlen < sizeof(outbuf))
88a37de674f8a7 Shradha Shah   2015-05-20  100  		return -EIO;
88a37de674f8a7 Shradha Shah   2015-05-20  101  
88a37de674f8a7 Shradha Shah   2015-05-20 @102  	nic_data->vf_index = MCDI_DWORD(outbuf, GET_FUNCTION_INFO_OUT_VF);
88a37de674f8a7 Shradha Shah   2015-05-20  103  	return 0;
88a37de674f8a7 Shradha Shah   2015-05-20  104  }
88a37de674f8a7 Shradha Shah   2015-05-20  105  #endif
88a37de674f8a7 Shradha Shah   2015-05-20  106  

:::::: The code at line 50 was first introduced by commit
:::::: 8127d661e77f5ec410093bce411f540afa34593f sfc: Add support for Solarflare SFC9100 family

:::::: TO: Ben Hutchings <bhutchings@solarflare.com>
:::::: CC: Ben Hutchings <bhutchings@solarflare.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
