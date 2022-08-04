Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365B58971C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiHDEjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHDEjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:39:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EBC564DF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659587980; x=1691123980;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QMrI1qUr3prITAFAupxsX3FvttIGbeBtnh1+FjuKvo0=;
  b=IG1E+Rz7LOoKkoJtjCZt2TSjOL+/HD4ip2hFCH0+TiwB+t2/Dseat21K
   qnkHsFV8yv8jmKDHbm5OBHQTZRKh7Bd5sw9bH0QDBIqrKhfCPCa4ow7Gs
   7lqiqRXLX3Gs2nJRNJtMYBREamVKpDbXDzarM34gJeRB2AEnFErxZnGjm
   Bm7pcQxL4F5bzwyVeW8sedcoV6gAN1wYDde0YkhmffmmsrCgH83Sdc6qU
   NK6YtzKGUyjt96urUzo/5t+EUNBieq1rIi+eNveoJqdnsWU4DlD9TKx5a
   oZp2nW2IOMCwAdJOqwPgRFOmWFFvsbhbK4kX3uLwlTw9sp8SDH6WboIWz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="288594415"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="288594415"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 21:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="692488777"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2022 21:39:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJSe2-000I1P-0I;
        Thu, 04 Aug 2022 04:39:38 +0000
Date:   Thu, 4 Aug 2022 12:39:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kenny Ho <Kenny.Ho@amd.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [agd5f:amd-staging-drm-next 986/1023]
 drivers/thunderbolt/test.c:799:9: error: implicit declaration of function
 'KUNIT_ASSERT_NULL'; did you mean 'KUNIT_ASSERT_LE'?
Message-ID: <202208041237.cjPrb4Bv-lkp@intel.com>
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
commit: 53069c3922842db6f01ca9008e6a45d0fd3a083e [986/1023] thunderbolt: test: use NULL macros
config: xtensa-randconfig-c032-20220804 (https://download.01.org/0day-ci/archive/20220804/202208041237.cjPrb4Bv-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f amd-staging-drm-next
        git checkout 53069c3922842db6f01ca9008e6a45d0fd3a083e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/thunderbolt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/thunderbolt/test.c: In function 'tb_test_path_not_connected':
>> drivers/thunderbolt/test.c:799:9: error: implicit declaration of function 'KUNIT_ASSERT_NULL'; did you mean 'KUNIT_ASSERT_LE'? [-Werror=implicit-function-declaration]
     799 |         KUNIT_ASSERT_NULL(test, path);
         |         ^~~~~~~~~~~~~~~~~
         |         KUNIT_ASSERT_LE
   drivers/thunderbolt/test.c: In function 'tb_test_path_not_bonded_lane0':
>> drivers/thunderbolt/test.c:850:9: error: implicit declaration of function 'KUNIT_ASSERT_NOT_NULL'; did you mean 'KUNIT_ASSERT_TRUE'? [-Werror=implicit-function-declaration]
     850 |         KUNIT_ASSERT_NOT_NULL(test, path);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         KUNIT_ASSERT_TRUE
   cc1: some warnings being treated as errors


vim +799 drivers/thunderbolt/test.c

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
