Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABFE54F3F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380497AbiFQJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:10:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7C55499
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655457038; x=1686993038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=txu5nXwfugBdPMptUG1ObaO/2vppNf8XOQ7TcUxCbgw=;
  b=LvX2RCynwgnmB6DkV35XXEnHtGQZOPnXrS9SX46ziKOceSnEAT9XTTEG
   9vvJ/5EbX8Mw4OX2zZEA0K3AFVhqkGZOkoRoPFznb69f/90rdt3OwqTnl
   +rQVaV1uGAGWueK5dFEIpCfobYwWznoFqb5E6r3ML8CQ3Go/EJxOz67fc
   o4CSTA1yCIgOtLnTULPV71a3WULBWMr+xB/ZVWgOco/45ZPoL9ondydXu
   BikE5Qq0zSFcmTc127gLHG+YZy45YCcXf7VOXxEuEmLX2sUjmH7plbKZz
   SjAFs6Eqe/JDOVYqNUN4xbhU0P9dTsTJOwOozy9xjRhrLN/BRJwCNrF6j
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277035244"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277035244"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536766552"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 02:10:36 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o27zv-000PHr-Iu;
        Fri, 17 Jun 2022 09:10:35 +0000
Date:   Fri, 17 Jun 2022 17:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mordechay Goodstein <mordechay.goodstein@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/fw/api/rx.h:442:2: warning: field
  within 'struct iwl_rx_mpdu_desc_v1' is less aligned than 'union
 iwl_rx_mpdu_desc_v1::(anonymous at
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h:442:2)' and is usually due to
 'struct i...
Message-ID: <202206171648.tLa7qWNK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mordechay,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47700948a4abb4a5ae13ef943ff682a7f327547a
commit: 9cd243f24ec1960403de5f24f45155af24d94b13 iwlwifi: move iwl_configure_rxq to be used by other op_modes
date:   1 year, 2 months ago
config: arm-randconfig-r014-20220617 (https://download.01.org/0day-ci/archive/20220617/202206171648.tLa7qWNK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cd243f24ec1960403de5f24f45155af24d94b13
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9cd243f24ec1960403de5f24f45155af24d94b13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/fw/init.c:13:
>> drivers/net/wireless/intel/iwlwifi/fw/api/rx.h:442:2: warning: field  within 'struct iwl_rx_mpdu_desc_v1' is less aligned than 'union iwl_rx_mpdu_desc_v1::(anonymous at drivers/net/wireless/intel/iwlwifi/fw/api/rx.h:442:2)' and is usually due to 'struct iwl_rx_mpdu_desc_v1' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   1 warning generated.


vim +442 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h

8a6171a7b601e3 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Luca Coelho    2018-06-26  383  
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  384  /**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  385   * struct iwl_rx_mpdu_desc_v1 - RX MPDU descriptor
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  386   */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  387  struct iwl_rx_mpdu_desc_v1 {
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  388  	/* DW7 - carries rss_hash only when rpa_en == 1 */
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  389  	union {
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  390  		/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  391  		 * @rss_hash: RSS hash value
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  392  		 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  393  		__le32 rss_hash;
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  394  
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  395  		/**
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  396  		 * @phy_data2: depends on info type (see @phy_data1)
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  397  		 */
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  398  		__le32 phy_data2;
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  399  	};
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  400  
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  401  	/* DW8 - carries filter_match only when rpa_en == 1 */
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  402  	union {
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  403  		/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  404  		 * @filter_match: filter match value
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  405  		 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  406  		__le32 filter_match;
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  407  
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  408  		/**
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  409  		 * @phy_data3: depends on info type (see @phy_data1)
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  410  		 */
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  411  		__le32 phy_data3;
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  412  	};
dabf9844385885 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Johannes Berg  2018-04-26  413  
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  414  	/* DW9 */
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  415  	/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  416  	 * @rate_n_flags: RX rate/flags encoding
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  417  	 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  418  	__le32 rate_n_flags;
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  419  	/* DW10 */
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  420  	/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  421  	 * @energy_a: energy chain A
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  422  	 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  423  	u8 energy_a;
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  424  	/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  425  	 * @energy_b: energy chain B
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  426  	 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  427  	u8 energy_b;
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  428  	/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  429  	 * @channel: channel number
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  430  	 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  431  	u8 channel;
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  432  	/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  433  	 * @mac_context: MAC context mask
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  434  	 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  435  	u8 mac_context;
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  436  	/* DW11 */
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  437  	/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  438  	 * @gp2_on_air_rise: GP2 timer value on air rise (INA)
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  439  	 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  440  	__le32 gp2_on_air_rise;
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  441  	/* DW12 & DW13 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05 @442  	union {
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  443  		/**
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  444  		 * @tsf_on_air_rise:
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  445  		 * TSF value on air rise (INA), only valid if
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  446  		 * %IWL_RX_MPDU_PHY_TSF_OVERLOAD isn't set
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  447  		 */
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  448  		__le64 tsf_on_air_rise;
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  449  
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  450  		struct {
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  451  			/**
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  452  			 * @phy_data0: depends on info_type, see @phy_data1
6857df8c10e698 drivers/net/wireless/intel/iwlwifi/mvm/fw-api-rx.h Johannes Berg  2017-03-15  453  			 */
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  454  			__le32 phy_data0;
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  455  			/**
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  456  			 * @phy_data1: valid only if
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  457  			 * %IWL_RX_MPDU_PHY_TSF_OVERLOAD is set,
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  458  			 * see &enum iwl_rx_phy_data1.
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  459  			 */
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  460  			__le32 phy_data1;
bdf180c8d375ee drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Shaul Triebitz 2018-07-02  461  		};
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  462  	};
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  463  } __packed;
18ead597daa17a drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     Golan Ben Ami  2018-02-05  464  

:::::: The code at line 442 was first introduced by commit
:::::: 18ead597daa17a557249cf4b2f494361d836ed52 iwlwifi: support new rx_mpdu_desc api

:::::: TO: Golan Ben Ami <golan.ben.ami@intel.com>
:::::: CC: Luca Coelho <luciano.coelho@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
