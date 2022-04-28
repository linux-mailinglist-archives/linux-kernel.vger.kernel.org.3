Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B53513B19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350631AbiD1RvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350582AbiD1RvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:51:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2EBAB92
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651168073; x=1682704073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l3asd7jUMKU9opiuGZOA/STECTct4mXum2WvbhBRH6A=;
  b=FYH+zmqhYc/1C7r6KLuIssax1MGNhhWzmZoYtQrU2wRQzH9AmgKbd4Tr
   4D5wTYLndNdlVlaRvuay76XYuvoIIhxbR9Pks8GzlKB/h8GQmdW3QtgwU
   25KXY5qjr7uHP4zNLt9I4IEqpuzSvLB6V0IYzls1/By2+NWZhG9INkwrD
   XQ6f9bMMVieRb5y1dU4N6bK/kmrEvc4lqO+bIZnxtjqMuTjvVUDo0ynE7
   nxtYE5C8JFMtoKcRX3/Z8vRDMihb2std8IfkmGxEz0ByCNikWUOSLhAFb
   CezZ9bPsKBYVaA0smKUBL/SuRlr76lU1EnBh8O0O+ADafGNamB8+DUNEh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246924372"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="246924372"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="618246322"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2022 10:47:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk8F4-0005aB-M4;
        Thu, 28 Apr 2022 17:47:50 +0000
Date:   Fri, 29 Apr 2022 01:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zong-Zhe Yang <kevin_yang@realtek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 7/57]
 drivers/net/wireless/realtek/rtw89/ser.c:319:2: warning: unannotated
 fall-through between switch labels
Message-ID: <202204290113.w78dhtXk-lkp@intel.com>
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

Hi Zong-Zhe,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   5c6cf64b40b98e4d4247fda11e4b4c859a24585d
commit: 14f9f4790048f684c2b151c899895feae0b5731a [7/57] rtw89: ser: control hci interrupts on/off by state
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220429/202204290113.w78dhtXk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/14f9f4790048f684c2b151c899895feae0b5731a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
        git checkout 14f9f4790048f684c2b151c899895feae0b5731a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/misc/lkdtm/ drivers/net/wireless/realtek/rtw89/

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
