Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8148416F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiADMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:04:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:44323 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbiADMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641297848; x=1672833848;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RBqcC/Pk3HdipFTHsHjbbFCchxtuIng1a5gXva5O9oQ=;
  b=e5XITTZ9VirdHoXbPL1iyOleRXpY+ykuLTIc4VRt9s7S5657MCuNYS7+
   V5VEVKmEwSVawrjmmgY1LNKd42BC5y/0gjAmYrM5kPoJJ5/1T/BkbEMdx
   GcsHL5DJIFrTl8NQz3e/KcILpuYyXMv5HY3kviiVWfuROFfwXg6OjmOdU
   OlnOJ4ecikN5MaI6NvLeEyjRMnwZzSRF/8u6l/VmJxCLX0J1pXHm5xNm9
   AIUvnRgGy4GvmONpvIO5p/d5OsO9kckuv/CvXR+2Xa7F4yn7EL75qf8HQ
   5OACpMwVkTYbaTJF/K2SZiCg40JU8FMM3MVEjvCJZVo/7qj+H42T8NFdd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242168927"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="242168927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 04:02:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="512484607"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2022 04:02:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4iWd-000FIW-CP; Tue, 04 Jan 2022 12:02:47 +0000
Date:   Tue, 4 Jan 2022 20:02:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 40/86]
 drivers/pinctrl/mstar/pinctrl-msc313.c:1339:4: warning: unannotated
 fall-through between switch labels
Message-ID: <202201041942.O5N2A7qS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   2269f75a5b53b9a05d21d432ad75f5e41b344814
commit: 3eca5b0d192f13a36006eb01a71650d6a8fc6ad9 [40/86] pinctrl: mstar: msc313 pinctrl driver
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220104/202201041942.O5N2A7qS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b50fea47b6c454581fce89af359f3afe5154986c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/linux-chenxing/linux/commit/3eca5b0d192f13a36006eb01a71650d6a8fc6ad9
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 3eca5b0d192f13a36006eb01a71650d6a8fc6ad9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clocksource/ drivers/irqchip/ drivers/pinctrl/mstar/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/mstar/pinctrl-msc313.c:1339:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                           default:
                           ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:1339:4: note: insert 'break;' to avoid fall-through
                           default:
                           ^
                           break; 
>> drivers/pinctrl/mstar/pinctrl-msc313.c:37:27: warning: unused variable 'i2c0_groups' [-Wunused-const-variable]
   static const char * const i2c0_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:40:18: warning: unused variable 'i2c0_values' [-Wunused-const-variable]
   static const u16 i2c0_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:44:27: warning: unused variable 'i2c1_groups' [-Wunused-const-variable]
   static const char * const i2c1_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:47:18: warning: unused variable 'i2c1_values' [-Wunused-const-variable]
   static const u16 i2c1_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:51:27: warning: unused variable 'fuart_groups' [-Wunused-const-variable]
   static const char * const fuart_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:55:18: warning: unused variable 'fuart_values' [-Wunused-const-variable]
   static const u16 fuart_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:60:27: warning: unused variable 'uart0_groups' [-Wunused-const-variable]
   static const char * const uart0_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:64:27: warning: unused variable 'uart1_groups' [-Wunused-const-variable]
   static const char * const uart1_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:68:18: warning: unused variable 'uart1_values' [-Wunused-const-variable]
   static const u16 uart1_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:73:27: warning: unused variable 'usb_groups' [-Wunused-const-variable]
   static const char * const usb_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:76:27: warning: unused variable 'usb1_groups' [-Wunused-const-variable]
   static const char * const usb1_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:80:27: warning: unused variable 'pwm0_groups' [-Wunused-const-variable]
   static const char * const pwm0_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:83:18: warning: unused variable 'pwm0_values' [-Wunused-const-variable]
   static const u16 pwm0_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:87:27: warning: unused variable 'pwm1_groups' [-Wunused-const-variable]
   static const char * const pwm1_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:90:18: warning: unused variable 'pwm1_values' [-Wunused-const-variable]
   static const u16 pwm1_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:94:27: warning: unused variable 'pwm2_groups' [-Wunused-const-variable]
   static const char * const pwm2_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:97:18: warning: unused variable 'pwm2_values' [-Wunused-const-variable]
   static const u16 pwm2_values[] = {
                    ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:101:27: warning: unused variable 'pwm3_groups' [-Wunused-const-variable]
   static const char * const pwm3_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313.c:104:18: warning: unused variable 'pwm3_values' [-Wunused-const-variable]
   static const u16 pwm3_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:108:27: warning: unused variable 'pwm4_groups' [-Wunused-const-variable]
   static const char * const pwm4_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:111:18: warning: unused variable 'pwm4_values' [-Wunused-const-variable]
   static const u16 pwm4_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:115:27: warning: unused variable 'pwm5_groups' [-Wunused-const-variable]
   static const char * const pwm5_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:118:18: warning: unused variable 'pwm5_values' [-Wunused-const-variable]
   static const u16 pwm5_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:122:27: warning: unused variable 'pwm6_groups' [-Wunused-const-variable]
   static const char * const pwm6_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:125:18: warning: unused variable 'pwm6_values' [-Wunused-const-variable]
   static const u16 pwm6_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:129:27: warning: unused variable 'pwm7_groups' [-Wunused-const-variable]
   static const char * const pwm7_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:132:18: warning: unused variable 'pwm7_values' [-Wunused-const-variable]
   static const u16 pwm7_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:136:27: warning: unused variable 'eth_groups' [-Wunused-const-variable]
   static const char * const eth_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:139:18: warning: unused variable 'eth_values' [-Wunused-const-variable]
   static const u16 eth_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:143:27: warning: unused variable 'jtag_groups' [-Wunused-const-variable]
   static const char * const jtag_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:147:27: warning: unused variable 'spi0_groups' [-Wunused-const-variable]
   static const char * const spi0_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:151:18: warning: unused variable 'spi0_values' [-Wunused-const-variable]
   static const u16 spi0_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:155:27: warning: unused variable 'spi1_groups' [-Wunused-const-variable]
   static const char * const spi1_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:158:18: warning: unused variable 'spi1_values' [-Wunused-const-variable]
   static const u16 spi1_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:161:27: warning: unused variable 'sdio_groups' [-Wunused-const-variable]
   static const char * const sdio_groups[] = {
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:164:18: warning: unused variable 'sdio_values' [-Wunused-const-variable]
   static const u16 sdio_values[] = {
                    ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:201:27: warning: unused variable 'sd_drivestrengths' [-Wunused-const-variable]
   static const unsigned int sd_drivestrengths[] = {4, 8};
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:215:27: warning: unused variable 'spi0_drivestrengths' [-Wunused-const-variable]
   static const unsigned int spi0_drivestrengths[] = {4, 8, 12, 16};
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:225:27: warning: unused variable 'i2c_drivestrengths' [-Wunused-const-variable]
   static const unsigned int i2c_drivestrengths[] = {4, 8};
                             ^
   drivers/pinctrl/mstar/pinctrl-msc313.c:233:27: warning: unused variable 'sr_drivestrengths' [-Wunused-const-variable]
   static const unsigned int sr_drivestrengths[] = {4, 8};
                             ^
   41 warnings generated.


vim +1339 drivers/pinctrl/mstar/pinctrl-msc313.c

  1318	
  1319	static int mstar_set_config(struct msc313_pinctrl *pinctrl, int pin, unsigned long config)
  1320	{
  1321		enum pin_config_param param = pinconf_to_config_param(config);
  1322		u32 arg = pinconf_to_config_argument(config);
  1323		int i;
  1324		unsigned int mask;
  1325		const struct msc313_pinctrl_pinconf *confpin;
  1326	
  1327		dev_dbg(pinctrl->dev, "setting %d:%u on pin %d\n", (int)config, (unsigned int)arg, pin);
  1328		for (i = 0; i < pinctrl->info->npinconfs; i++) {
  1329			if (pinctrl->info->pinconfs[i].pin == pin) {
  1330				confpin = &pinctrl->info->pinconfs[i];
  1331				switch (param) {
  1332				case PIN_CONFIG_BIAS_PULL_UP:
  1333					if (confpin->pull_en_reg != -1) {
  1334						dev_dbg(pinctrl->dev, "setting pull up %d on pin %d\n", (int) arg, pin);
  1335						mask = 1 << confpin->pull_en_bit;
  1336						regmap_update_bits(pinctrl->regmap, confpin->pull_en_reg, mask, arg ? mask : 0);
  1337					} else
  1338						dev_info(pinctrl->dev, "pullup reg/bit isn't known for pin %d\n", pin);
> 1339				default:
  1340					break;
  1341				}
  1342				return 0;
  1343			}
  1344		}
  1345		return 0;
  1346	}
  1347	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
