Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9501585899
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiG3EZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiG3EZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:25:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF613D67
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659155140; x=1690691140;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tE4gAhpT+5B9E8BBlS421Ai6+4cwUVd3aJta3K1N360=;
  b=dm5XnjjWGqR87pzevT7g4rejIJvkk+V6eYgiVTOrPGB2Br2ripdX93TN
   QXskSi/oK0xz2D6nvTr7eRB+wNVRSIgSlAcghXYtWuAl8J8XApsl4GMfk
   R7Wd/z+50BstjXsSwYW9vG4KaVXas28ARX4O3+LVOosYcSJUS5k42WH5w
   VKzfieUFPZ/MACz8ZH8sWXE/PjMPWb85zyMnEcVuU+Hvd9HsRV6J0GBYw
   lnsWXwJS9qsPBMLoMjOh+9E3oCYQ2hgrn5LA/YcBCh5x1Fnoz2ORIez/S
   5xvDVOXuns0Ai2pOcvrepgksVdRZHopxyXJC5/QDzrLBSh9SMf20s2SLm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="269273130"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="269273130"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 21:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="669470303"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2022 21:25:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHe2j-000COT-1g;
        Sat, 30 Jul 2022 04:25:37 +0000
Date:   Sat, 30 Jul 2022 12:25:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kenny Ho <Kenny.Ho@amd.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [agd5f:amd-staging-drm-next 1241/1278]
 drivers/thunderbolt/test.c:799:2: error: call to undeclared function
 'KUNIT_ASSERT_NULL'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202207301226.1DMFCdHt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next
head:   2305916dca043ed69bd464f74a886b0216780aa6
commit: 53069c3922842db6f01ca9008e6a45d0fd3a083e [1241/1278] thunderbolt: test: use NULL macros
config: s390-randconfig-r044-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301226.1DMFCdHt-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f amd-staging-drm-next
        git checkout 53069c3922842db6f01ca9008e6a45d0fd3a083e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/thunderbolt/test.c:12:
   In file included from drivers/thunderbolt/tb.h:13:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/thunderbolt/test.c:12:
   In file included from drivers/thunderbolt/tb.h:13:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/thunderbolt/test.c:12:
   In file included from drivers/thunderbolt/tb.h:13:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/thunderbolt/test.c:799:2: error: call to undeclared function 'KUNIT_ASSERT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NULL(test, path);
           ^
>> drivers/thunderbolt/test.c:850:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, path);
           ^
   drivers/thunderbolt/test.c:912:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, path);
           ^
   drivers/thunderbolt/test.c:992:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, path);
           ^
   drivers/thunderbolt/test.c:1072:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, path);
           ^
   drivers/thunderbolt/test.c:1164:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, path);
           ^
   drivers/thunderbolt/test.c:1256:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, path);
           ^
   drivers/thunderbolt/test.c:1300:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel1);
           ^
   drivers/thunderbolt/test.c:1352:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1398:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1448:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1513:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1569:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel1);
           ^
   drivers/thunderbolt/test.c:1631:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
           ^
   drivers/thunderbolt/test.c:1688:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1731:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1768:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1814:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   drivers/thunderbolt/test.c:1860:2: error: call to undeclared function 'KUNIT_ASSERT_NOT_NULL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           KUNIT_ASSERT_NOT_NULL(test, tunnel);
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   12 warnings and 20 errors generated.


vim +/KUNIT_ASSERT_NULL +799 drivers/thunderbolt/test.c

   783	
   784	static void tb_test_path_not_connected(struct kunit *test)
   785	{
   786		struct tb_switch *host, *dev1, *dev2;
   787		struct tb_port *down, *up;
   788		struct tb_path *path;
   789	
   790		host = alloc_host(test);
   791		dev1 = alloc_dev_default(test, host, 0x3, false);
   792		/* Not connected to anything */
   793		dev2 = alloc_dev_default(test, NULL, 0x303, false);
   794	
   795		down = &dev1->ports[10];
   796		up = &dev2->ports[9];
   797	
   798		path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
 > 799		KUNIT_ASSERT_NULL(test, path);
   800		path = tb_path_alloc(NULL, down, 8, up, 8, 1, "PCIe Down");
   801		KUNIT_ASSERT_NULL(test, path);
   802	}
   803	
   804	struct hop_expectation {
   805		u64 route;
   806		u8 in_port;
   807		enum tb_port_type in_type;
   808		u8 out_port;
   809		enum tb_port_type out_type;
   810	};
   811	
   812	static void tb_test_path_not_bonded_lane0(struct kunit *test)
   813	{
   814		/*
   815		 * PCIe path from host to device using lane 0.
   816		 *
   817		 *   [Host]
   818		 *   3 |: 4
   819		 *   1 |: 2
   820		 *  [Device]
   821		 */
   822		static const struct hop_expectation test_data[] = {
   823			{
   824				.route = 0x0,
   825				.in_port = 9,
   826				.in_type = TB_TYPE_PCIE_DOWN,
   827				.out_port = 3,
   828				.out_type = TB_TYPE_PORT,
   829			},
   830			{
   831				.route = 0x3,
   832				.in_port = 1,
   833				.in_type = TB_TYPE_PORT,
   834				.out_port = 9,
   835				.out_type = TB_TYPE_PCIE_UP,
   836			},
   837		};
   838		struct tb_switch *host, *dev;
   839		struct tb_port *down, *up;
   840		struct tb_path *path;
   841		int i;
   842	
   843		host = alloc_host(test);
   844		dev = alloc_dev_default(test, host, 0x3, false);
   845	
   846		down = &host->ports[9];
   847		up = &dev->ports[9];
   848	
   849		path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
 > 850		KUNIT_ASSERT_NOT_NULL(test, path);
   851		KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
   852		for (i = 0; i < ARRAY_SIZE(test_data); i++) {
   853			const struct tb_port *in_port, *out_port;
   854	
   855			in_port = path->hops[i].in_port;
   856			out_port = path->hops[i].out_port;
   857	
   858			KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
   859			KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
   860			KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
   861					test_data[i].in_type);
   862			KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
   863			KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
   864			KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
   865					test_data[i].out_type);
   866		}
   867		tb_path_free(path);
   868	}
   869	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
