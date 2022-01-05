Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93730485C6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245516AbiAEXuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:50:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:54390 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245498AbiAEXuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641426600; x=1672962600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZMDnCkj4r/mhUxsI1H4KLlj/KcYTTwL9dt+tnOjyKQ=;
  b=Gv2HoF62+W1cJ9KWIzr3p4Hn2xosONZGRrc4o+qz4Pg81Xmjwe8uoEEf
   DMTg1EVIIyY5Qdka1AGCj+CuQrBuRXGlv1kV3miR8GXmci0WILh50Fczr
   CAiYW3xoz1sXiteKVB7p12VWiaZCocaGgmtG5j+/RdBy8ntFdb66+ogYU
   9M2B4q+dyWWspWxh0DV3SV4+zVkLSg+JQ+TxwKpI/5bGn4chSZ30irU9A
   qN/dak2JSLen0EUF+jxoiNMxcLqPzZIhWdXV2H8VkllgXOGyZjGtXJwH/
   QAjdzdAb4XWnilNg1kZpLchBVHlTSVqoqmK405ezPz+qxUUTBNVF9pU6N
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266840603"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266840603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 15:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513192079"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 15:49:56 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5G2W-000H8d-7e; Wed, 05 Jan 2022 23:49:56 +0000
Date:   Thu, 6 Jan 2022 07:49:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chevron Li <chevron.li@bayhubtech.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shaper.liu@bayhubtech.com, bruce.yang@bayhubtech.com
Subject: Re: [PATCH V2 1/1] mmc:sdhci-bayhub:fix Qualcomm sd host 7180 SD
 card compatibility issue
Message-ID: <202201060751.sKVVMT8D-lkp@intel.com>
References: <20220105122926.472-1-chevron.li@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105122926.472-1-chevron.li@bayhubtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chevron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master linus/master v5.16-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chevron-Li/mmc-sdhci-bayhub-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220105-203109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220106/202201060751.sKVVMT8D-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/26adf9f047e13b3b5a025c2a4c7eccb1db2af050
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chevron-Li/mmc-sdhci-bayhub-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220105-203109
        git checkout 26adf9f047e13b3b5a025c2a4c7eccb1db2af050
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

   ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>> ERROR: modpost: "mmc_attach_mmc" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_attach_sdio" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_send_if_cond_pcie" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "sdio_reset" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_pwrseq_reset" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_power_up" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_add_card" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_spi_read_ocr" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_go_idle" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
>> ERROR: modpost: "mmc_select_voltage" [drivers/mmc/host/sdhci-bayhub.ko] undefined!
   WARNING: modpost: suppressed 34 unresolved symbol warnings because there were too many)
--
>> drivers/mmc/host/sdhci-bayhub.c:2265:5: warning: no previous prototype for 'mmc_app_set_clr_card_detect' [-Wmissing-prototypes]
    2265 | int mmc_app_set_clr_card_detect(struct mmc_card *card)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:3291:6: warning: no previous prototype for 'mmc_rescan_bayhub' [-Wmissing-prototypes]
    3291 | void mmc_rescan_bayhub(struct work_struct *work)
         |      ^~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c: In function 'dump_array':
>> drivers/mmc/host/sdhci-bayhub.c:4154:12: warning: variable 'str' set but not used [-Wunused-but-set-variable]
    4154 |         u8 str[12] = { 0 };
         |            ^~~
   drivers/mmc/host/sdhci-bayhub.c: At top level:
>> drivers/mmc/host/sdhci-bayhub.c:4232:6: warning: no previous prototype for 'no_fail_p' [-Wmissing-prototypes]
    4232 | void no_fail_p(u8 *tuning_win, u8 *mid_val, u8 *max_pass_win, u8 *first_val)
         |      ^~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4254:6: warning: no previous prototype for 'tx_selb_calculate_valid_phase_range' [-Wmissing-prototypes]
    4254 | void tx_selb_calculate_valid_phase_range(u32 val, int *start,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4270:6: warning: no previous prototype for 'ggc_update_default_selb_phase_tuning_cnt' [-Wmissing-prototypes]
    4270 | bool ggc_update_default_selb_phase_tuning_cnt(struct sdhci_host *host, int selb,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4310:5: warning: no previous prototype for 'sdhci_bht_sdr50_execute_tuning' [-Wmissing-prototypes]
    4310 | int sdhci_bht_sdr50_execute_tuning(struct sdhci_host *host, u32 opcode)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4371:5: warning: no previous prototype for 'get_config_sela_setting' [-Wmissing-prototypes]
    4371 | int get_config_sela_setting(struct sdhci_host *host)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4382:5: warning: no previous prototype for 'get_config_selb_setting' [-Wmissing-prototypes]
    4382 | int get_config_selb_setting(struct sdhci_host *host)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4393:5: warning: no previous prototype for 'get_all_sela_status' [-Wmissing-prototypes]
    4393 | u32 get_all_sela_status(struct sdhci_host *host, u32 target_selb)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4407:5: warning: no previous prototype for 'get_pass_window_weight' [-Wmissing-prototypes]
    4407 | int get_pass_window_weight(u32 val)
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4419:5: warning: no previous prototype for 'get_sela_nearby_pass_window' [-Wmissing-prototypes]
    4419 | int get_sela_nearby_pass_window(u32 sela, u32 base)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4457:5: warning: no previous prototype for 'get_left_one_sel' [-Wmissing-prototypes]
    4457 | int get_left_one_sel(int base)
         |     ^~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4465:5: warning: no previous prototype for 'get_right_one_sel' [-Wmissing-prototypes]
    4465 | int get_right_one_sel(int base)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4473:5: warning: no previous prototype for 'get_dif' [-Wmissing-prototypes]
    4473 | int get_dif(int x, int y)
         |     ^~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4667:6: warning: no previous prototype for 'tx_selb_inject_policy' [-Wmissing-prototypes]
    4667 | void tx_selb_inject_policy(struct sdhci_host *host, int tx_selb)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4686:5: warning: no previous prototype for 'get_selb_failure_point' [-Wmissing-prototypes]
    4686 | int get_selb_failure_point(int start, u64 raw_tx_selb, int tuning_cnt)
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4726:6: warning: no previous prototype for 'selx_failure_point_exist' [-Wmissing-prototypes]
    4726 | bool selx_failure_point_exist(u32 val)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4736:5: warning: no previous prototype for '_get_best_window_phase' [-Wmissing-prototypes]
    4736 | int _get_best_window_phase(u32 vct, int *pmax_pass_win, int shif_left_flg)
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-bayhub.c:4802:5: warning: no previous prototype for 'get_best_window_phase' [-Wmissing-prototypes]
    4802 | int get_best_window_phase(u32 vct, int *pmax_pass_win)
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c:4845:6: warning: no previous prototype for 'ggc_hw_inject_ext' [-Wmissing-prototypes]
    4845 | bool ggc_hw_inject_ext(struct sdhci_host *host, bool *card_status,
         |      ^~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c:4881:6: warning: no previous prototype for '_ggc_hw_inject_may_recursive' [-Wmissing-prototypes]
    4881 | bool _ggc_hw_inject_may_recursive(struct sdhci_host *host, u32 sel200,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c:4914:6: warning: no previous prototype for 'ggc_hw_inject_may_recursive' [-Wmissing-prototypes]
    4914 | bool ggc_hw_inject_may_recursive(struct sdhci_host *host, u32 sel200,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c:4920:6: warning: no previous prototype for 'get_next_dll_voltage' [-Wmissing-prototypes]
    4920 | bool get_next_dll_voltage(int cur, int *next, u32 *dll_voltage_unlock_cnt,
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c:4963:6: warning: no previous prototype for 'ggc_sw_calc_tuning_result' [-Wmissing-prototypes]
    4963 | bool ggc_sw_calc_tuning_result(struct sdhci_host *host, bool *card_status,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-bayhub.c:5038:6: warning: no previous prototype for '_ggc_calc_cur_sela_tuning_result' [-Wmissing-prototypes]
    5038 | bool _ggc_calc_cur_sela_tuning_result(struct sdhci_host *host, int cur_sela, int start_selb)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
