Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E94F7558
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 07:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiDGFc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 01:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDGFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:32:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F6188
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649309423; x=1680845423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TLY9VbrLN3iYNKEihGEU85+7l5qc8Uss+xhSOCkTAw4=;
  b=QfrUw7GaMTxOZNj6vWkUndoM6buBFSPnuFtSYqr2A7M4BV8g+zKWsCnu
   ydi1M0yUbUZ5aQT/IJrBnbX7HbpFlFFN7PJ9R6fkuYFze2/boMWHLlTyg
   6734RNdFB3OSNVvqKKktZaVfCQ4TEN952ke8r5dLU/rHNqx2m+AQ2pyKY
   MfXbCmXr0ZZ7xuCYq9MQWgjt4s/18In4rph8/0D54H+umBASVAnE67nJa
   UAQ4V5myWf3i4phJxazQln1eV5aiIn/bccDFImAZajMGPWZaXTUXPd8j/
   RkAtk7Lhw448vGbbhB/0a7nIHNiu+zD2bg3gP/tTR5htB5fcxy+WV+swJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260069071"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="260069071"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 22:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="524780904"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 22:30:21 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncKiq-00056Y-T2;
        Thu, 07 Apr 2022 05:30:20 +0000
Date:   Thu, 7 Apr 2022 13:29:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zong-Zhe Yang <kevin_yang@realtek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 9/45]
 drivers/net/wireless/realtek/rtw89/ser.c:319:2: warning: unannotated
 fall-through between switch labels
Message-ID: <202204071343.R89skHKl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   e1bd1e32fab0c91cf7a87e96fee9270e98e79351
commit: 14f9f4790048f684c2b151c899895feae0b5731a [9/45] rtw89: ser: control hci interrupts on/off by state
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220407/202204071343.R89skHKl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/14f9f4790048f684c2b151c899895feae0b5731a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
        git checkout 14f9f4790048f684c2b151c899895feae0b5731a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/wireless/realtek/rtw89/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/ser.c:319:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/net/wireless/realtek/rtw89/ser.c:319:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +319 drivers/net/wireless/realtek/rtw89/ser.c

e3ec7017f6a20d Ping-Ke Shih  2021-10-11  301  
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  302  /* state handler */
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  303  static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  304  {
14f9f4790048f6 Zong-Zhe Yang 2022-03-14  305  	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
14f9f4790048f6 Zong-Zhe Yang 2022-03-14  306  
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  307  	switch (evt) {
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  308  	case SER_EV_STATE_IN:
14f9f4790048f6 Zong-Zhe Yang 2022-03-14  309  		rtw89_hci_recovery_complete(rtwdev);
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  310  		break;
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  311  	case SER_EV_L1_RESET:
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  312  		ser_state_goto(ser, SER_RESET_TRX_ST);
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  313  		break;
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  314  	case SER_EV_L2_RESET:
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  315  		ser_state_goto(ser, SER_L2_RESET_ST);
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  316  		break;
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  317  	case SER_EV_STATE_OUT:
14f9f4790048f6 Zong-Zhe Yang 2022-03-14  318  		rtw89_hci_recovery_start(rtwdev);
e3ec7017f6a20d Ping-Ke Shih  2021-10-11 @319  	default:
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  320  		break;
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  321  	}
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  322  }
e3ec7017f6a20d Ping-Ke Shih  2021-10-11  323  

:::::: The code at line 319 was first introduced by commit
:::::: e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd rtw89: add Realtek 802.11ax driver

:::::: TO: Ping-Ke Shih <pkshih@realtek.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
