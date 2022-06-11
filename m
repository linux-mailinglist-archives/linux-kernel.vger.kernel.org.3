Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40DA5475F7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiFKPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFKPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:11:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF226112
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654960280; x=1686496280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uhmHKhnd2WsuYDLf8qApzgrMBOeqKqBmpsgLn6/86NE=;
  b=Y8loQdfd99BaIUQcuOp7r8MqLaGpe34B+k+dcy6sL1bW/iaHDe/3ptO5
   z2H9u3C+M1Xxy1Rgh5MnUFdJqvkodUukFD1o/7mDY3G9oX55Rzlw2rwcy
   LRVQB/nU1iC027s7vwNSGbJ0dGum7C6HHnP/tylqERJJQkh/VgPbVpfeP
   bFvnO0KCscD3mKpS+a2o10O7aOathY8Zdz8U30ay5PEO00WQN92fZ0p37
   /PEef5UqKQsaFgCHDsiZA89HOc23t8Mn714rgpp1DIaKmfVwslJL36QpG
   SBS+RFKv96m3J0Xu9Ka80+QGKknGhJ3B+Qlx2P3w5d+OQk+/PSFYdNo0q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258331170"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="258331170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 08:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="725449989"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2022 08:11:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o02lh-000J0B-V3;
        Sat, 11 Jun 2022 15:11:17 +0000
Date:   Sat, 11 Jun 2022 23:10:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: drivers/thunderbolt/test.c:851 tb_test_path_not_bonded_lane0()
 error: potential null dereference 'path'.  (tb_path_alloc returns null)
Message-ID: <202206112309.YeRx54qU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0885eacdc81f920c3e0554d5615e69a66504a28d
commit: 7aadf84333572fa011ada2dbf469295b84587739 thunderbolt: test: use NULL macros
date:   10 weeks ago
config: parisc-randconfig-m031-20220608 (https://download.01.org/0day-ci/archive/20220611/202206112309.YeRx54qU-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/thunderbolt/test.c:851 tb_test_path_not_bonded_lane0() error: potential null dereference 'path'.  (tb_path_alloc returns null)
drivers/thunderbolt/test.c:913 tb_test_path_not_bonded_lane1() error: potential null dereference 'path'.  (tb_path_alloc returns null)
drivers/thunderbolt/test.c:993 tb_test_path_not_bonded_lane1_chain() error: potential null dereference 'path'.  (tb_path_alloc returns null)
drivers/thunderbolt/test.c:1073 tb_test_path_not_bonded_lane1_chain_reverse() error: potential null dereference 'path'.  (tb_path_alloc returns null)
drivers/thunderbolt/test.c:1165 tb_test_path_mixed_chain() error: potential null dereference 'path'.  (tb_path_alloc returns null)
drivers/thunderbolt/test.c:1257 tb_test_path_mixed_chain_reverse() error: potential null dereference 'path'.  (tb_path_alloc returns null)

vim +/path +851 drivers/thunderbolt/test.c

54509f5005cacc Mika Westerberg 2020-04-29   811  
54509f5005cacc Mika Westerberg 2020-04-29   812  static void tb_test_path_not_bonded_lane0(struct kunit *test)
54509f5005cacc Mika Westerberg 2020-04-29   813  {
54509f5005cacc Mika Westerberg 2020-04-29   814  	/*
54509f5005cacc Mika Westerberg 2020-04-29   815  	 * PCIe path from host to device using lane 0.
54509f5005cacc Mika Westerberg 2020-04-29   816  	 *
54509f5005cacc Mika Westerberg 2020-04-29   817  	 *   [Host]
54509f5005cacc Mika Westerberg 2020-04-29   818  	 *   3 |: 4
54509f5005cacc Mika Westerberg 2020-04-29   819  	 *   1 |: 2
54509f5005cacc Mika Westerberg 2020-04-29   820  	 *  [Device]
54509f5005cacc Mika Westerberg 2020-04-29   821  	 */
54509f5005cacc Mika Westerberg 2020-04-29   822  	static const struct hop_expectation test_data[] = {
54509f5005cacc Mika Westerberg 2020-04-29   823  		{
54509f5005cacc Mika Westerberg 2020-04-29   824  			.route = 0x0,
54509f5005cacc Mika Westerberg 2020-04-29   825  			.in_port = 9,
54509f5005cacc Mika Westerberg 2020-04-29   826  			.in_type = TB_TYPE_PCIE_DOWN,
54509f5005cacc Mika Westerberg 2020-04-29   827  			.out_port = 3,
54509f5005cacc Mika Westerberg 2020-04-29   828  			.out_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   829  		},
54509f5005cacc Mika Westerberg 2020-04-29   830  		{
54509f5005cacc Mika Westerberg 2020-04-29   831  			.route = 0x3,
54509f5005cacc Mika Westerberg 2020-04-29   832  			.in_port = 1,
54509f5005cacc Mika Westerberg 2020-04-29   833  			.in_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   834  			.out_port = 9,
54509f5005cacc Mika Westerberg 2020-04-29   835  			.out_type = TB_TYPE_PCIE_UP,
54509f5005cacc Mika Westerberg 2020-04-29   836  		},
54509f5005cacc Mika Westerberg 2020-04-29   837  	};
54509f5005cacc Mika Westerberg 2020-04-29   838  	struct tb_switch *host, *dev;
54509f5005cacc Mika Westerberg 2020-04-29   839  	struct tb_port *down, *up;
54509f5005cacc Mika Westerberg 2020-04-29   840  	struct tb_path *path;
54509f5005cacc Mika Westerberg 2020-04-29   841  	int i;
54509f5005cacc Mika Westerberg 2020-04-29   842  
54509f5005cacc Mika Westerberg 2020-04-29   843  	host = alloc_host(test);
54509f5005cacc Mika Westerberg 2020-04-29   844  	dev = alloc_dev_default(test, host, 0x3, false);
54509f5005cacc Mika Westerberg 2020-04-29   845  
54509f5005cacc Mika Westerberg 2020-04-29   846  	down = &host->ports[9];
54509f5005cacc Mika Westerberg 2020-04-29   847  	up = &dev->ports[9];
54509f5005cacc Mika Westerberg 2020-04-29   848  
54509f5005cacc Mika Westerberg 2020-04-29   849  	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
7aadf84333572f Ricardo Ribalda 2022-02-11   850  	KUNIT_ASSERT_NOT_NULL(test, path);
8f0877c26e4b69 David Gow       2021-05-13  @851  	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
54509f5005cacc Mika Westerberg 2020-04-29   852  	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
54509f5005cacc Mika Westerberg 2020-04-29   853  		const struct tb_port *in_port, *out_port;
54509f5005cacc Mika Westerberg 2020-04-29   854  
54509f5005cacc Mika Westerberg 2020-04-29   855  		in_port = path->hops[i].in_port;
54509f5005cacc Mika Westerberg 2020-04-29   856  		out_port = path->hops[i].out_port;
54509f5005cacc Mika Westerberg 2020-04-29   857  
54509f5005cacc Mika Westerberg 2020-04-29   858  		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
54509f5005cacc Mika Westerberg 2020-04-29   859  		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
824945a5b0ff82 David Gow       2021-06-24   860  		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
824945a5b0ff82 David Gow       2021-06-24   861  				test_data[i].in_type);
54509f5005cacc Mika Westerberg 2020-04-29   862  		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
54509f5005cacc Mika Westerberg 2020-04-29   863  		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
824945a5b0ff82 David Gow       2021-06-24   864  		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
824945a5b0ff82 David Gow       2021-06-24   865  				test_data[i].out_type);
54509f5005cacc Mika Westerberg 2020-04-29   866  	}
54509f5005cacc Mika Westerberg 2020-04-29   867  	tb_path_free(path);
54509f5005cacc Mika Westerberg 2020-04-29   868  }
54509f5005cacc Mika Westerberg 2020-04-29   869  
54509f5005cacc Mika Westerberg 2020-04-29   870  static void tb_test_path_not_bonded_lane1(struct kunit *test)
54509f5005cacc Mika Westerberg 2020-04-29   871  {
54509f5005cacc Mika Westerberg 2020-04-29   872  	/*
54509f5005cacc Mika Westerberg 2020-04-29   873  	 * DP Video path from host to device using lane 1. Paths like
54509f5005cacc Mika Westerberg 2020-04-29   874  	 * these are only used with Thunderbolt 1 devices where lane
54509f5005cacc Mika Westerberg 2020-04-29   875  	 * bonding is not possible. USB4 specifically does not allow
54509f5005cacc Mika Westerberg 2020-04-29   876  	 * paths like this (you either use lane 0 where lane 1 is
54509f5005cacc Mika Westerberg 2020-04-29   877  	 * disabled or both lanes are bonded).
54509f5005cacc Mika Westerberg 2020-04-29   878  	 *
54509f5005cacc Mika Westerberg 2020-04-29   879  	 *   [Host]
54509f5005cacc Mika Westerberg 2020-04-29   880  	 *   1 :| 2
54509f5005cacc Mika Westerberg 2020-04-29   881  	 *   1 :| 2
54509f5005cacc Mika Westerberg 2020-04-29   882  	 *  [Device]
54509f5005cacc Mika Westerberg 2020-04-29   883  	 */
54509f5005cacc Mika Westerberg 2020-04-29   884  	static const struct hop_expectation test_data[] = {
54509f5005cacc Mika Westerberg 2020-04-29   885  		{
54509f5005cacc Mika Westerberg 2020-04-29   886  			.route = 0x0,
54509f5005cacc Mika Westerberg 2020-04-29   887  			.in_port = 5,
54509f5005cacc Mika Westerberg 2020-04-29   888  			.in_type = TB_TYPE_DP_HDMI_IN,
54509f5005cacc Mika Westerberg 2020-04-29   889  			.out_port = 2,
54509f5005cacc Mika Westerberg 2020-04-29   890  			.out_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   891  		},
54509f5005cacc Mika Westerberg 2020-04-29   892  		{
54509f5005cacc Mika Westerberg 2020-04-29   893  			.route = 0x1,
54509f5005cacc Mika Westerberg 2020-04-29   894  			.in_port = 2,
54509f5005cacc Mika Westerberg 2020-04-29   895  			.in_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   896  			.out_port = 13,
54509f5005cacc Mika Westerberg 2020-04-29   897  			.out_type = TB_TYPE_DP_HDMI_OUT,
54509f5005cacc Mika Westerberg 2020-04-29   898  		},
54509f5005cacc Mika Westerberg 2020-04-29   899  	};
54509f5005cacc Mika Westerberg 2020-04-29   900  	struct tb_switch *host, *dev;
54509f5005cacc Mika Westerberg 2020-04-29   901  	struct tb_port *in, *out;
54509f5005cacc Mika Westerberg 2020-04-29   902  	struct tb_path *path;
54509f5005cacc Mika Westerberg 2020-04-29   903  	int i;
54509f5005cacc Mika Westerberg 2020-04-29   904  
54509f5005cacc Mika Westerberg 2020-04-29   905  	host = alloc_host(test);
54509f5005cacc Mika Westerberg 2020-04-29   906  	dev = alloc_dev_default(test, host, 0x1, false);
54509f5005cacc Mika Westerberg 2020-04-29   907  
54509f5005cacc Mika Westerberg 2020-04-29   908  	in = &host->ports[5];
54509f5005cacc Mika Westerberg 2020-04-29   909  	out = &dev->ports[13];
54509f5005cacc Mika Westerberg 2020-04-29   910  
54509f5005cacc Mika Westerberg 2020-04-29   911  	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
7aadf84333572f Ricardo Ribalda 2022-02-11   912  	KUNIT_ASSERT_NOT_NULL(test, path);
8f0877c26e4b69 David Gow       2021-05-13  @913  	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
54509f5005cacc Mika Westerberg 2020-04-29   914  	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
54509f5005cacc Mika Westerberg 2020-04-29   915  		const struct tb_port *in_port, *out_port;
54509f5005cacc Mika Westerberg 2020-04-29   916  
54509f5005cacc Mika Westerberg 2020-04-29   917  		in_port = path->hops[i].in_port;
54509f5005cacc Mika Westerberg 2020-04-29   918  		out_port = path->hops[i].out_port;
54509f5005cacc Mika Westerberg 2020-04-29   919  
54509f5005cacc Mika Westerberg 2020-04-29   920  		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
54509f5005cacc Mika Westerberg 2020-04-29   921  		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
824945a5b0ff82 David Gow       2021-06-24   922  		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
824945a5b0ff82 David Gow       2021-06-24   923  				test_data[i].in_type);
54509f5005cacc Mika Westerberg 2020-04-29   924  		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
54509f5005cacc Mika Westerberg 2020-04-29   925  		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
824945a5b0ff82 David Gow       2021-06-24   926  		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
824945a5b0ff82 David Gow       2021-06-24   927  				test_data[i].out_type);
54509f5005cacc Mika Westerberg 2020-04-29   928  	}
54509f5005cacc Mika Westerberg 2020-04-29   929  	tb_path_free(path);
54509f5005cacc Mika Westerberg 2020-04-29   930  }
54509f5005cacc Mika Westerberg 2020-04-29   931  
54509f5005cacc Mika Westerberg 2020-04-29   932  static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
54509f5005cacc Mika Westerberg 2020-04-29   933  {
54509f5005cacc Mika Westerberg 2020-04-29   934  	/*
54509f5005cacc Mika Westerberg 2020-04-29   935  	 * DP Video path from host to device 3 using lane 1.
54509f5005cacc Mika Westerberg 2020-04-29   936  	 *
54509f5005cacc Mika Westerberg 2020-04-29   937  	 *    [Host]
54509f5005cacc Mika Westerberg 2020-04-29   938  	 *    1 :| 2
54509f5005cacc Mika Westerberg 2020-04-29   939  	 *    1 :| 2
54509f5005cacc Mika Westerberg 2020-04-29   940  	 *  [Device #1]
54509f5005cacc Mika Westerberg 2020-04-29   941  	 *    7 :| 8
54509f5005cacc Mika Westerberg 2020-04-29   942  	 *    1 :| 2
54509f5005cacc Mika Westerberg 2020-04-29   943  	 *  [Device #2]
54509f5005cacc Mika Westerberg 2020-04-29   944  	 *    5 :| 6
54509f5005cacc Mika Westerberg 2020-04-29   945  	 *    1 :| 2
54509f5005cacc Mika Westerberg 2020-04-29   946  	 *  [Device #3]
54509f5005cacc Mika Westerberg 2020-04-29   947  	 */
54509f5005cacc Mika Westerberg 2020-04-29   948  	static const struct hop_expectation test_data[] = {
54509f5005cacc Mika Westerberg 2020-04-29   949  		{
54509f5005cacc Mika Westerberg 2020-04-29   950  			.route = 0x0,
54509f5005cacc Mika Westerberg 2020-04-29   951  			.in_port = 5,
54509f5005cacc Mika Westerberg 2020-04-29   952  			.in_type = TB_TYPE_DP_HDMI_IN,
54509f5005cacc Mika Westerberg 2020-04-29   953  			.out_port = 2,
54509f5005cacc Mika Westerberg 2020-04-29   954  			.out_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   955  		},
54509f5005cacc Mika Westerberg 2020-04-29   956  		{
54509f5005cacc Mika Westerberg 2020-04-29   957  			.route = 0x1,
54509f5005cacc Mika Westerberg 2020-04-29   958  			.in_port = 2,
54509f5005cacc Mika Westerberg 2020-04-29   959  			.in_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   960  			.out_port = 8,
54509f5005cacc Mika Westerberg 2020-04-29   961  			.out_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   962  		},
54509f5005cacc Mika Westerberg 2020-04-29   963  		{
54509f5005cacc Mika Westerberg 2020-04-29   964  			.route = 0x701,
54509f5005cacc Mika Westerberg 2020-04-29   965  			.in_port = 2,
54509f5005cacc Mika Westerberg 2020-04-29   966  			.in_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   967  			.out_port = 6,
54509f5005cacc Mika Westerberg 2020-04-29   968  			.out_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   969  		},
54509f5005cacc Mika Westerberg 2020-04-29   970  		{
54509f5005cacc Mika Westerberg 2020-04-29   971  			.route = 0x50701,
54509f5005cacc Mika Westerberg 2020-04-29   972  			.in_port = 2,
54509f5005cacc Mika Westerberg 2020-04-29   973  			.in_type = TB_TYPE_PORT,
54509f5005cacc Mika Westerberg 2020-04-29   974  			.out_port = 13,
54509f5005cacc Mika Westerberg 2020-04-29   975  			.out_type = TB_TYPE_DP_HDMI_OUT,
54509f5005cacc Mika Westerberg 2020-04-29   976  		},
54509f5005cacc Mika Westerberg 2020-04-29   977  	};
54509f5005cacc Mika Westerberg 2020-04-29   978  	struct tb_switch *host, *dev1, *dev2, *dev3;
54509f5005cacc Mika Westerberg 2020-04-29   979  	struct tb_port *in, *out;
54509f5005cacc Mika Westerberg 2020-04-29   980  	struct tb_path *path;
54509f5005cacc Mika Westerberg 2020-04-29   981  	int i;
54509f5005cacc Mika Westerberg 2020-04-29   982  
54509f5005cacc Mika Westerberg 2020-04-29   983  	host = alloc_host(test);
54509f5005cacc Mika Westerberg 2020-04-29   984  	dev1 = alloc_dev_default(test, host, 0x1, false);
54509f5005cacc Mika Westerberg 2020-04-29   985  	dev2 = alloc_dev_default(test, dev1, 0x701, false);
54509f5005cacc Mika Westerberg 2020-04-29   986  	dev3 = alloc_dev_default(test, dev2, 0x50701, false);
54509f5005cacc Mika Westerberg 2020-04-29   987  
54509f5005cacc Mika Westerberg 2020-04-29   988  	in = &host->ports[5];
54509f5005cacc Mika Westerberg 2020-04-29   989  	out = &dev3->ports[13];
54509f5005cacc Mika Westerberg 2020-04-29   990  
54509f5005cacc Mika Westerberg 2020-04-29   991  	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
7aadf84333572f Ricardo Ribalda 2022-02-11   992  	KUNIT_ASSERT_NOT_NULL(test, path);
8f0877c26e4b69 David Gow       2021-05-13  @993  	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
54509f5005cacc Mika Westerberg 2020-04-29   994  	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
54509f5005cacc Mika Westerberg 2020-04-29   995  		const struct tb_port *in_port, *out_port;
54509f5005cacc Mika Westerberg 2020-04-29   996  
54509f5005cacc Mika Westerberg 2020-04-29   997  		in_port = path->hops[i].in_port;
54509f5005cacc Mika Westerberg 2020-04-29   998  		out_port = path->hops[i].out_port;
54509f5005cacc Mika Westerberg 2020-04-29   999  
54509f5005cacc Mika Westerberg 2020-04-29  1000  		KUNIT_EXPECT_EQ(test, tb_route(in_port->sw), test_data[i].route);
54509f5005cacc Mika Westerberg 2020-04-29  1001  		KUNIT_EXPECT_EQ(test, in_port->port, test_data[i].in_port);
824945a5b0ff82 David Gow       2021-06-24  1002  		KUNIT_EXPECT_EQ(test, (enum tb_port_type)in_port->config.type,
824945a5b0ff82 David Gow       2021-06-24  1003  				test_data[i].in_type);
54509f5005cacc Mika Westerberg 2020-04-29  1004  		KUNIT_EXPECT_EQ(test, tb_route(out_port->sw), test_data[i].route);
54509f5005cacc Mika Westerberg 2020-04-29  1005  		KUNIT_EXPECT_EQ(test, out_port->port, test_data[i].out_port);
824945a5b0ff82 David Gow       2021-06-24  1006  		KUNIT_EXPECT_EQ(test, (enum tb_port_type)out_port->config.type,
824945a5b0ff82 David Gow       2021-06-24  1007  				test_data[i].out_type);
54509f5005cacc Mika Westerberg 2020-04-29  1008  	}
54509f5005cacc Mika Westerberg 2020-04-29  1009  	tb_path_free(path);
54509f5005cacc Mika Westerberg 2020-04-29  1010  }
54509f5005cacc Mika Westerberg 2020-04-29  1011  

:::::: The code at line 851 was first introduced by commit
:::::: 8f0877c26e4b695f824c5dbcc4b964ce238328aa thunderbolt: test: Remove some casts which are no longer required

:::::: TO: David Gow <davidgow@google.com>
:::::: CC: Shuah Khan <skhan@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
