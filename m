Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C964F9DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiDHTbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiDHTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:31:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069202A704
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649446151; x=1680982151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CswLttxe3NmsY/wVdrCmxeJaoxL7w62dRrR99dUqJSo=;
  b=EYe1lY3wE997CXc5RuSr57I+shrt0Dk5ym7mA+OBGplWrFDpV74BIfOu
   /ZTqHQi2b77chLQRMMLBvF4Zhof0tmxeF2xPBDAYNna922hILOr4/FoMK
   fmDtB3cxZ+X8WOF4YLZikf60zUD9vKe5Lce6AAY8Byf1BWpln1gEnAXv2
   Mpds5+Hc4rufMIxDo5SOTi4ElUlGt7dTcMuv8ZI2IIwpKg07ZtFaiEUtB
   1DxqomxSoJERP7RIycOnXBK6dyAV4cU4B0qDnoAMBreoqtBER6pqAXHUa
   3CdsTTfnd4M9IvZsSUvU3LGB0sGmGbkFIdKEuH7VatmBmGpu9qthn0J+3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="241609221"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241609221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="621750364"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 12:29:05 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncuI4-0000aD-BN;
        Fri, 08 Apr 2022 19:29:04 +0000
Date:   Sat, 9 Apr 2022 03:28:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kari Suvanto <karis79@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Malik Olivier Boussejra <malik@boussejra.com>,
        Paul Zimmerman <paulz@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Michael Zoran <mzoran@crowfest.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Jonathan Bell <jonathan@raspberrypi.org>,
        Hui Wang <hui.wang@canonical.com>,
        Zixuan Wang <wangzixuan@sjtu.edu.cn>
Subject: [l1k:smsc95xx_5.17 56/888]
 drivers/usb/host/dwc_common_port/dwc_common_linux.c:221:9: warning: function
 'DWC_VPRINTF' might be a candidate for 'gnu_printf' format attribute
Message-ID: <202204090348.spIQq0kM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: a8197852bb8f1f6804cff9442d426888e97aaed3 [56/888] Add dwc_otg driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090348.spIQq0kM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/a8197852bb8f1f6804cff9442d426888e97aaed3
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout a8197852bb8f1f6804cff9442d426888e97aaed3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/lib/ drivers/char/ drivers/gpio/ drivers/mmc/host/ drivers/perf/ drivers/usb/host/dwc_common_port/ drivers/usb/host/dwc_otg/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/dwc_common_port/dwc_common_linux.c: In function 'DWC_VPRINTF':
>> drivers/usb/host/dwc_common_port/dwc_common_linux.c:221:9: warning: function 'DWC_VPRINTF' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     221 |         vprintk(format, args);
         |         ^~~~~~~
   drivers/usb/host/dwc_common_port/dwc_common_linux.c: In function 'DWC_VSNPRINTF':
>> drivers/usb/host/dwc_common_port/dwc_common_linux.c:226:9: warning: function 'DWC_VSNPRINTF' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     226 |         return vsnprintf(str, size, format, args);
         |         ^~~~~~
   drivers/usb/host/dwc_common_port/dwc_common_linux.c: At top level:
>> drivers/usb/host/dwc_common_port/dwc_common_linux.c:580:17: warning: no previous prototype for 'DWC_SPINLOCK_ALLOC' [-Wmissing-prototypes]
     580 | dwc_spinlock_t *DWC_SPINLOCK_ALLOC(void)
         |                 ^~~~~~~~~~~~~~~~~~
--
>> drivers/usb/host/dwc_common_port/dwc_crypto.c:80: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Encrypts an array of bytes using the AES encryption engine.
   drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: Function parameter or member 'key' not described in 'dwc_wusb_cmf'
   drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: Function parameter or member 'nonce' not described in 'dwc_wusb_cmf'
   drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: Function parameter or member 'label' not described in 'dwc_wusb_cmf'
   drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: Function parameter or member 'bytes' not described in 'dwc_wusb_cmf'
   drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: Function parameter or member 'len' not described in 'dwc_wusb_cmf'
   drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: Function parameter or member 'result' not described in 'dwc_wusb_cmf'
>> drivers/usb/host/dwc_common_port/dwc_crypto.c:108: warning: expecting prototype for The CCM-MAC(). Prototype was for dwc_wusb_cmf() instead
   drivers/usb/host/dwc_common_port/dwc_crypto.c:187: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * The PRF function described in section 6.5 of the WUSB spec. This function
   drivers/usb/host/dwc_common_port/dwc_crypto.c:208: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Fills in CCM Nonce per the WUSB spec.
   drivers/usb/host/dwc_common_port/dwc_crypto.c:237: warning: Function parameter or member 'addr' not described in 'dwc_wusb_gen_nonce'
   drivers/usb/host/dwc_common_port/dwc_crypto.c:237: warning: Function parameter or member 'nonce' not described in 'dwc_wusb_gen_nonce'
>> drivers/usb/host/dwc_common_port/dwc_crypto.c:237: warning: expecting prototype for Generates a 16-byte cryptographic(). Prototype was for dwc_wusb_gen_nonce() instead
   drivers/usb/host/dwc_common_port/dwc_crypto.c:257: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Generates the Session Key (PTK) and Key Confirmation Key (KCK) per the
   drivers/usb/host/dwc_common_port/dwc_crypto.c:292: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Generates the Message Integrity Code over the Handshake data per the
--
   drivers/usb/host/dwc_otg/dwc_otg_driver.c: In function 'dwc_otg_driver_init':
>> drivers/usb/host/dwc_otg/dwc_otg_driver.c:1087:13: warning: variable 'error' set but not used [-Wunused-but-set-variable]
    1087 |         int error;
         |             ^~~~~
--
   drivers/usb/host/dwc_otg/dwc_otg_attr.c: In function 'dwc_otg_attr_create':
>> drivers/usb/host/dwc_otg/dwc_otg_attr.c:1117:13: warning: variable 'error' set but not used [-Wunused-but-set-variable]
    1117 |         int error;
         |             ^~~~~
--
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:797:5: warning: no previous prototype for 'dwc_otg_save_gintmsk_reg' [-Wmissing-prototypes]
     797 | int dwc_otg_save_gintmsk_reg(dwc_otg_core_if_t * core_if)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil.c: In function 'dwc_otg_core_dev_init':
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:1652:23: warning: variable 'hwcfg3' set but not used [-Wunused-but-set-variable]
    1652 |         hwcfg3_data_t hwcfg3 = {.d32 = 0 };
         |                       ^~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:2680:6: warning: no previous prototype for 'set_pid_isoc' [-Wmissing-prototypes]
    2680 | void set_pid_isoc(dwc_hc_t * hc)
         |      ^~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil.c: In function 'dwc_otg_read_setup_packet':
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:3182:30: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    3182 |         device_grxsts_data_t status;
         |                              ^~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil.c: In function 'write_isoc_tx_fifo':
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:3653:35: warning: variable 'ep_regs' set but not used [-Wunused-but-set-variable]
    3653 |         dwc_otg_dev_in_ep_regs_t *ep_regs;
         |                                   ^~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil.c: In function 'dwc_otg_ep0_continue_transfer':
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:4314:33: warning: variable 'tx_status' set but not used [-Wunused-but-set-variable]
    4314 |                 gnptxsts_data_t tx_status = {.d32 = 0 };
         |                                 ^~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:6274:9: warning: no previous prototype for 'dwc_otg_get_param_thr_ctl' [-Wmissing-prototypes]
    6274 | int32_t dwc_otg_get_param_thr_ctl(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:6320:9: warning: no previous prototype for 'dwc_otg_get_param_tx_thr_length' [-Wmissing-prototypes]
    6320 | int32_t dwc_otg_get_param_tx_thr_length(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:6337:9: warning: no previous prototype for 'dwc_otg_get_param_rx_thr_length' [-Wmissing-prototypes]
    6337 | int32_t dwc_otg_get_param_rx_thr_length(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:7109:10: warning: no previous prototype for 'dwc_otg_get_otg_version' [-Wmissing-prototypes]
    7109 | uint16_t dwc_otg_get_otg_version(dwc_otg_core_if_t * core_if)
         |          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil.c:7120:6: warning: no previous prototype for 'dwc_otg_pcd_start_srp_timer' [-Wmissing-prototypes]
    7120 | void dwc_otg_pcd_start_srp_timer(dwc_otg_core_if_t * core_if)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:64:9: warning: no previous prototype for 'dwc_otg_handle_mode_mismatch_intr' [-Wmissing-prototypes]
      64 | int32_t dwc_otg_handle_mode_mismatch_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:84:9: warning: no previous prototype for 'dwc_otg_handle_otg_intr' [-Wmissing-prototypes]
      84 | int32_t dwc_otg_handle_otg_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:323:9: warning: no previous prototype for 'dwc_otg_handle_conn_id_status_change_intr' [-Wmissing-prototypes]
     323 | int32_t dwc_otg_handle_conn_id_status_change_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:370:9: warning: no previous prototype for 'dwc_otg_handle_session_req_intr' [-Wmissing-prototypes]
     370 | int32_t dwc_otg_handle_session_req_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:438:9: warning: no previous prototype for 'dwc_otg_handle_wakeup_detected_intr' [-Wmissing-prototypes]
     438 | int32_t dwc_otg_handle_wakeup_detected_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:910:9: warning: no previous prototype for 'dwc_otg_handle_restore_done_intr' [-Wmissing-prototypes]
     910 | int32_t dwc_otg_handle_restore_done_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:935:9: warning: no previous prototype for 'dwc_otg_handle_disconnect_intr' [-Wmissing-prototypes]
     935 | int32_t dwc_otg_handle_disconnect_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:1020:9: warning: no previous prototype for 'dwc_otg_handle_usb_suspend_intr' [-Wmissing-prototypes]
    1020 | int32_t dwc_otg_handle_usb_suspend_intr(dwc_otg_core_if_t * core_if)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c: In function 'dwc_otg_handle_usb_suspend_intr':
>> drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c:1022:21: warning: variable 'dsts' set but not used [-Wunused-but-set-variable]
    1022 |         dsts_data_t dsts;
         |                     ^~~~
--
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c: In function 'ep_queue':
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:324:25: warning: variable 'is_isoc_ep' set but not used [-Wunused-but-set-variable]
     324 |         int retval = 0, is_isoc_ep = 0;
         |                         ^~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1021:6: warning: no previous prototype for 'gadget_add_eps' [-Wmissing-prototypes]
    1021 | void gadget_add_eps(struct gadget_wrapper *d)
         |      ^~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1203:5: warning: no previous prototype for 'pcd_init' [-Wmissing-prototypes]
    1203 | int pcd_init(dwc_bus_dev_t *_dev)
         |     ^~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1246:6: warning: no previous prototype for 'pcd_remove' [-Wmissing-prototypes]
    1246 | void pcd_remove(dwc_bus_dev_t *_dev)
         |      ^~~~~~~~~~
--
>> drivers/usb/host/dwc_otg/dwc_otg_pcd.c:240:25: warning: no previous prototype for 'dwc_otg_ep_alloc_desc_chain' [-Wmissing-prototypes]
     240 | dwc_otg_dev_dma_desc_t *dwc_otg_ep_alloc_desc_chain(struct device *dev,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd.c:251:6: warning: no previous prototype for 'dwc_otg_ep_free_desc_chain' [-Wmissing-prototypes]
     251 | void dwc_otg_ep_free_desc_chain(struct device *dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd.c: In function 'start_xfer_tasklet_func':
>> drivers/usb/host/dwc_otg/dwc_otg_pcd.c:1092:31: warning: variable 'diepctl' set but not used [-Wunused-but-set-variable]
    1092 |                 depctl_data_t diepctl;
         |                               ^~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd.c:1079:23: warning: variable 'diepctl' set but not used [-Wunused-but-set-variable]
    1079 |         depctl_data_t diepctl;
         |                       ^~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_pcd.c:2501:6: warning: no previous prototype for 'dwc_otg_pcd_rem_wkup_from_suspend' [-Wmissing-prototypes]
    2501 | void dwc_otg_pcd_rem_wkup_from_suspend(dwc_otg_pcd_t * pcd, int set)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:200:19: warning: no previous prototype for 'get_ep_by_addr' [-Wmissing-prototypes]
     200 | dwc_otg_pcd_ep_t *get_ep_by_addr(dwc_otg_pcd_t * pcd, u16 wIndex)
         |                   ^~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:220:6: warning: no previous prototype for 'start_next_request' [-Wmissing-prototypes]
     220 | void start_next_request(dwc_otg_pcd_ep_t * ep)
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:298:9: warning: no previous prototype for 'dwc_otg_pcd_handle_sof_intr' [-Wmissing-prototypes]
     298 | int32_t dwc_otg_pcd_handle_sof_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:331:9: warning: no previous prototype for 'dwc_otg_pcd_handle_rx_status_q_level_intr' [-Wmissing-prototypes]
     331 | int32_t dwc_otg_pcd_handle_rx_status_q_level_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:497:9: warning: no previous prototype for 'dwc_otg_pcd_handle_np_tx_fifo_empty_intr' [-Wmissing-prototypes]
     497 | int32_t dwc_otg_pcd_handle_np_tx_fifo_empty_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: In function 'dwc_otg_pcd_handle_np_tx_fifo_empty_intr':
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:501:35: warning: variable 'ep_regs' set but not used [-Wunused-but-set-variable]
     501 |         dwc_otg_dev_in_ep_regs_t *ep_regs;
         |                                   ^~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: In function 'write_empty_tx_fifo':
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:565:35: warning: variable 'ep_regs' set but not used [-Wunused-but-set-variable]
     565 |         dwc_otg_dev_in_ep_regs_t *ep_regs;
         |                                   ^~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:619:6: warning: no previous prototype for 'dwc_otg_pcd_stop' [-Wmissing-prototypes]
     619 | void dwc_otg_pcd_stop(dwc_otg_pcd_t * pcd)
         |      ^~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:679:9: warning: no previous prototype for 'dwc_otg_pcd_handle_i2c_intr' [-Wmissing-prototypes]
     679 | int32_t dwc_otg_pcd_handle_i2c_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:700:9: warning: no previous prototype for 'dwc_otg_pcd_handle_early_suspend_intr' [-Wmissing-prototypes]
     700 | int32_t dwc_otg_pcd_handle_early_suspend_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:836:9: warning: no previous prototype for 'dwc_otg_pcd_handle_usb_reset_intr' [-Wmissing-prototypes]
     836 | int32_t dwc_otg_pcd_handle_usb_reset_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:1057:9: warning: no previous prototype for 'dwc_otg_pcd_handle_enum_done_intr' [-Wmissing-prototypes]
    1057 | int32_t dwc_otg_pcd_handle_enum_done_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:1155:9: warning: no previous prototype for 'dwc_otg_pcd_handle_isoc_out_packet_dropped_intr' [-Wmissing-prototypes]
    1155 | int32_t dwc_otg_pcd_handle_isoc_out_packet_dropped_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:1181:9: warning: no previous prototype for 'dwc_otg_pcd_handle_end_periodic_frame_intr' [-Wmissing-prototypes]
    1181 | int32_t dwc_otg_pcd_handle_end_periodic_frame_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:1209:9: warning: no previous prototype for 'dwc_otg_pcd_handle_ep_mismatch_intr' [-Wmissing-prototypes]
    1209 | int32_t dwc_otg_pcd_handle_ep_mismatch_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:1257:9: warning: no previous prototype for 'dwc_otg_pcd_handle_ep_fetsusp_intr' [-Wmissing-prototypes]
    1257 | int32_t dwc_otg_pcd_handle_ep_fetsusp_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:3370:6: warning: no previous prototype for 'predict_nextep_seq' [-Wmissing-prototypes]
    3370 | void predict_nextep_seq( dwc_otg_core_if_t * core_if)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: In function 'dwc_otg_pcd_handle_in_ep_intr':
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:3886:34: warning: variable 'empty_msk' set but not used [-Wunused-but-set-variable]
    3886 |                         uint32_t empty_msk;
         |                                  ^~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: In function 'dwc_otg_pcd_handle_out_ep_intr':
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4534:56: warning: variable 'intr_mask' set but not used [-Wunused-but-set-variable]
    4534 |                                         gintmsk_data_t intr_mask = {.d32 = 0};
         |                                                        ^~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4680:9: warning: no previous prototype for 'dwc_otg_pcd_handle_incomplete_isoc_in_intr' [-Wmissing-prototypes]
    4680 | int32_t dwc_otg_pcd_handle_incomplete_isoc_in_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4790:9: warning: no previous prototype for 'dwc_otg_pcd_handle_incomplete_isoc_out_intr' [-Wmissing-prototypes]
    4790 | int32_t dwc_otg_pcd_handle_incomplete_isoc_out_intr(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: In function 'dwc_otg_pcd_handle_incomplete_isoc_out_intr':
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4851:24: warning: variable 'deptsiz' set but not used [-Wunused-but-set-variable]
    4851 |         deptsiz_data_t deptsiz = {.d32 = 0 };
         |                        ^~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: At top level:
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4908:9: warning: no previous prototype for 'dwc_otg_pcd_handle_in_nak_effective' [-Wmissing-prototypes]
    4908 | int32_t dwc_otg_pcd_handle_in_nak_effective(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4950:9: warning: no previous prototype for 'dwc_otg_pcd_handle_out_nak_effective' [-Wmissing-prototypes]
    4950 | int32_t dwc_otg_pcd_handle_out_nak_effective(dwc_otg_pcd_t * pcd)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c: In function 'dwc_otg_pcd_handle_out_nak_effective':
   drivers/usb/host/dwc_otg/dwc_otg_pcd_intr.c:4995:32: warning: variable 'doepint' set but not used [-Wunused-but-set-variable]
    4995 |                 doepint_data_t doepint;
         |                                ^~~~~~~
--
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:71:6: warning: no previous prototype for 'dwc_otg_hcd_connect_timeout' [-Wmissing-prototypes]
      71 | void dwc_otg_hcd_connect_timeout(void *ptr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:818:6: warning: no previous prototype for 'dwc_otg_hcd_power_up' [-Wmissing-prototypes]
     818 | void dwc_otg_hcd_power_up(void *ptr)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:1557:5: warning: no previous prototype for 'fiq_fsm_setup_periodic_dma' [-Wmissing-prototypes]
    1557 | int fiq_fsm_setup_periodic_dma(dwc_otg_hcd_t *hcd, struct fiq_channel_state *st, dwc_otg_qh_t *qh)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:1663:5: warning: no previous prototype for 'fiq_fsm_np_tt_contended' [-Wmissing-prototypes]
    1663 | int fiq_fsm_np_tt_contended(dwc_otg_hcd_t *hcd, dwc_otg_qh_t *qh)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:1701:5: warning: no previous prototype for 'fiq_fsm_queue_isoc_transaction' [-Wmissing-prototypes]
    1701 | int fiq_fsm_queue_isoc_transaction(dwc_otg_hcd_t *hcd, dwc_otg_qh_t *qh)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/dwc_otg/dwc_otg_hcd.c: In function 'fiq_fsm_queue_isoc_transaction':
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:1709:22: warning: variable 'hcdma' set but not used [-Wunused-but-set-variable]
    1709 |         hcdma_data_t hcdma;
         |                      ^~~~~
   drivers/usb/host/dwc_otg/dwc_otg_hcd.c: At top level:
>> drivers/usb/host/dwc_otg/dwc_otg_hcd.c:1825:5: warning: no previous prototype for 'fiq_fsm_queue_split_transaction' [-Wmissing-prototypes]
    1825 | int fiq_fsm_queue_split_transaction(dwc_otg_hcd_t *hcd, dwc_otg_qh_t *qh)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:83: warning: Function parameter or member 'pcd' not described in 'ep_from_handle'
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:83: warning: Function parameter or member 'handle' not described in 'ep_from_handle'
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:83: warning: expecting prototype for Get the dwc_otg_pcd_ep_t* from usb_ep* pointer(). Prototype was for ep_from_handle() instead
>> drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:117: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function is called by the Gadget Driver for each EP to be
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:172: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function is called when an EP is disabled due to disconnect or
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:199: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function allocates a request object to use with the specified
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:226: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function frees a request object.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:246: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function allocates an I/O buffer to be used for a transfer
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:285: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function frees an I/O buffer that was allocated by alloc_buffer.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:306: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function is used to submit an I/O Request to an EP.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:403: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function cancels an I/O request from an EP.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:426: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * usb_ep_set_halt stalls an endpoint.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:500: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function is used to submit an ISOC Transfer Request to an EP.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:543: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function stops ISO EP Periodic Data Transfer.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:666: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * The following gadget operations will be implemented in the DWC_otg
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:681: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    *Gets the USB Frame number of the last SOF.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:709: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Initiates Session Request Protocol (SRP) to wakeup the host if no
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:801: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Copy the contents of the extended request to the Linux usb_request's
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:946: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function updates the otg values in the gadget structure.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1001: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function is the top level PCD interrupt handler.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1016: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function initialized the usb_ep structures to there default
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1133: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function releases the Gadget device.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1200: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function initialized the PCD portion of the driver.
   drivers/usb/host/dwc_otg/dwc_otg_pcd_linux.c:1244: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Cleanup the PCD.
..


vim +221 drivers/usb/host/dwc_common_port/dwc_common_linux.c

   218	
   219	void DWC_VPRINTF(char *format, va_list args)
   220	{
 > 221		vprintk(format, args);
   222	}
   223	
   224	int DWC_VSNPRINTF(char *str, int size, char *format, va_list args)
   225	{
 > 226		return vsnprintf(str, size, format, args);
   227	}
   228	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
