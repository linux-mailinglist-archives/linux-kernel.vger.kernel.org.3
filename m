Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A64DD48D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiCRGAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCRGAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:00:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263D2ED2E1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647583171; x=1679119171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2inKC5XC+8wTQ/dAtlKptncESI8JecL0hchzmp989kc=;
  b=Emha6e9YPpw5NaRXLonoPnOV5Zv5bSJjeVRmiXRSPqZ/DT0+1FzlPkeH
   BjcE0GF1LLdP9PEOQUDaHOaCl/QzQxp/PMmq1itTuY4Xaayuqxr1EP82+
   Ell4/IWAyaS29HFVyDGk9uv00uuZDuhPtfYzGSfAO6xlyh46T/+FkUwFu
   amRhqYX909StbYWcciVZrTz81qdPVpOtWUGcQHCPSDvnk54BtjWeCt3jZ
   7T+6iQYOJ0ftHjjWhxjQACI2Em6Tr8Fd9ol1MAFQrSs/LN/U5NIaazGMd
   UsLoWtn58bAbMcIJgDSepgLp+VIK2WgFnADBeSc+FVdR6ZmYza13XqHd6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="244514366"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="244514366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 22:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="499111280"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 22:59:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV5e3-000ESe-EC; Fri, 18 Mar 2022 05:59:27 +0000
Date:   Fri, 18 Mar 2022 13:58:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangrui Song <maskray@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [linux-stable-rc:linux-4.19.y 2710/9999] mm/slab_common.c:1438:37:
 warning: unused variable 'proc_slabinfo_operations'
Message-ID: <202203181306.hfAlK7cq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangrui,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   57e593a4ee92b5fddbab3367340e9cb0300cc241
commit: 69c122751164c3c343eea205fd5c3e1d5132f967 [2710/9999] Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
config: mips-randconfig-r022-20220317 (https://download.01.org/0day-ci/archive/20220318/202203181306.hfAlK7cq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=69c122751164c3c343eea205fd5c3e1d5132f967
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout 69c122751164c3c343eea205fd5c3e1d5132f967
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/slab_common.c:1438:37: warning: unused variable 'proc_slabinfo_operations' [-Wunused-const-variable]
   static const struct file_operations proc_slabinfo_operations = {
                                       ^
   1 warning generated.
--
>> drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array 'sensor->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
           if (sensor && sensor->name)
                      ~~ ~~~~~~~~^~~~
   1 warning generated.
--
   drivers/tty/serial/stm32-usart.c:332:15: warning: variable 'cookie' set but not used [-Wunused-but-set-variable]
           dma_cookie_t cookie;
                        ^
>> drivers/tty/serial/stm32-usart.c:600:14: warning: no previous prototype for function 'stm32_get_databits' [-Wmissing-prototypes]
   unsigned int stm32_get_databits(struct ktermios *termios)
                ^
   drivers/tty/serial/stm32-usart.c:600:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int stm32_get_databits(struct ktermios *termios)
   ^
   static 
   drivers/tty/serial/stm32-usart.c:929:15: warning: variable 'cookie' set but not used [-Wunused-but-set-variable]
           dma_cookie_t cookie;
                        ^
   3 warnings generated.
--
   In file included from drivers/net/wireless/intersil/hostap/hostap_ap.c:30:
   In file included from drivers/net/wireless/intersil/hostap/hostap_wlan.h:11:
   include/net/iw_handler.h:489:9: warning: performing pointer subtraction with a null pointer has undefined behavior [-Wnull-pointer-subtraction]
           return IW_EV_POINT_LEN;
                  ^~~~~~~~~~~~~~~
   include/uapi/linux/wireless.h:1096:5: note: expanded from macro 'IW_EV_POINT_LEN'
                            IW_EV_POINT_OFF)
                            ^~~~~~~~~~~~~~~
   include/uapi/linux/wireless.h:1093:75: note: expanded from macro 'IW_EV_POINT_OFF'
   #define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
                                                                             ^
   drivers/net/wireless/intersil/hostap/hostap_ap.c:1507:8: warning: variable 'txt' set but not used [-Wunused-but-set-variable]
           char *txt = "";
                 ^
>> drivers/net/wireless/intersil/hostap/hostap_ap.c:372:36: warning: unused variable 'ap_control_proc_seqops' [-Wunused-const-variable]
   static const struct seq_operations ap_control_proc_seqops = {
                                      ^
>> drivers/net/wireless/intersil/hostap/hostap_ap.c:574:36: warning: unused variable 'prism2_ap_proc_seqops' [-Wunused-const-variable]
   static const struct seq_operations prism2_ap_proc_seqops = {
                                      ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/intersil/hostap/hostap_proc.c:9:
   In file included from drivers/net/wireless/intersil/hostap/hostap_wlan.h:11:
   include/net/iw_handler.h:489:9: warning: performing pointer subtraction with a null pointer has undefined behavior [-Wnull-pointer-subtraction]
           return IW_EV_POINT_LEN;
                  ^~~~~~~~~~~~~~~
   include/uapi/linux/wireless.h:1096:5: note: expanded from macro 'IW_EV_POINT_LEN'
                            IW_EV_POINT_OFF)
                            ^~~~~~~~~~~~~~~
   include/uapi/linux/wireless.h:1093:75: note: expanded from macro 'IW_EV_POINT_OFF'
   #define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
                                                                             ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:117:36: warning: unused variable 'prism2_wds_proc_seqops' [-Wunused-const-variable]
   static const struct seq_operations prism2_wds_proc_seqops = {
                                      ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:170:36: warning: unused variable 'prism2_bss_list_proc_seqops' [-Wunused-const-variable]
   static const struct seq_operations prism2_bss_list_proc_seqops = {
                                      ^
   drivers/net/wireless/intersil/hostap/hostap_proc.c:214:37: warning: unused variable 'prism2_pda_proc_fops' [-Wunused-const-variable]
   static const struct file_operations prism2_pda_proc_fops = {
                                       ^
   drivers/net/wireless/intersil/hostap/hostap_proc.c:226:37: warning: unused variable 'prism2_aux_dump_proc_fops' [-Wunused-const-variable]
   static const struct file_operations prism2_aux_dump_proc_fops = {
                                       ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:348:36: warning: unused variable 'prism2_scan_results_proc_seqops' [-Wunused-const-variable]
   static const struct seq_operations prism2_scan_results_proc_seqops = {
                                      ^
   6 warnings generated.


vim +/proc_slabinfo_operations +1438 mm/slab_common.c

b7454ad3cfc304 Glauber Costa 2012-10-19  1437  
b7454ad3cfc304 Glauber Costa 2012-10-19 @1438  static const struct file_operations proc_slabinfo_operations = {
b7454ad3cfc304 Glauber Costa 2012-10-19  1439  	.open		= slabinfo_open,
b7454ad3cfc304 Glauber Costa 2012-10-19  1440  	.read		= seq_read,
b7454ad3cfc304 Glauber Costa 2012-10-19  1441  	.write          = slabinfo_write,
b7454ad3cfc304 Glauber Costa 2012-10-19  1442  	.llseek		= seq_lseek,
b7454ad3cfc304 Glauber Costa 2012-10-19  1443  	.release	= seq_release,
b7454ad3cfc304 Glauber Costa 2012-10-19  1444  };
b7454ad3cfc304 Glauber Costa 2012-10-19  1445  

:::::: The code at line 1438 was first introduced by commit
:::::: b7454ad3cfc3043c5264729a6204f049fe1f34b1 mm/sl[au]b: Move slabinfo processing to slab_common.c

:::::: TO: Glauber Costa <glommer@parallels.com>
:::::: CC: Pekka Enberg <penberg@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
