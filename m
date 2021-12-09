Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BE46EA0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhLIOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:36:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:1266 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238649AbhLIOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639060399; x=1670596399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wN2jdpinsPWdNTccrUFAdERDZZr00FhXJguxPhU6BVo=;
  b=kOuERtqV1e1pF14nEVoU+Yp/B6VEO/d6fc9MZFiXshH48qPeN7d263LU
   /d5ZGnoTwux9a3OVJFJkvj7x0JgJMYjCRolEYC8U4rZE5ruk/2bI33YWy
   RqW3xtk5IWbtApXNfAEb0QFMAKs6inQmjvYqZqK90y50OrHsI7DKZQk2s
   SICvGOEwr7dtImVz+k3/u3jGvnfGU84gsbpe2kjilmxCnyzQEtZkjpdH9
   1oGMf9z1HYEblLilB4smbSVNMlRy86M6ggftCYRCmrZHM2NmVkDNnqK6A
   kUJQBzL7NPukMBeG1sKL0pO8bnLCwo5vpGlLZ98TsHV7L7qcYAe6nn1YY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238051018"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238051018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="516318946"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 06:32:29 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvKTE-000222-KT; Thu, 09 Dec 2021 14:32:28 +0000
Date:   Thu, 9 Dec 2021 22:31:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bm-new 13/15] drivers/leds/trigger/ledtrig-cpu.c:42:17:
 error: redefinition of 'num_active_cpus' as different kind of symbol
Message-ID: <202112092257.dQgv78Nx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bm-new
head:   b529d6ec834c582d88d8f1286490bb69ee4bedb2
commit: d9365a115ddda67b4bbe080adf3919f32b9a36c4 [13/15] kernel/cpu: add num_active_cpu counter
config: arm64-randconfig-r005-20211208 (https://download.01.org/0day-ci/archive/20211209/202112092257.dQgv78Nx-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/norov/linux/commit/d9365a115ddda67b4bbe080adf3919f32b9a36c4
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bm-new
        git checkout d9365a115ddda67b4bbe080adf3919f32b9a36c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the norov/bm-new HEAD b529d6ec834c582d88d8f1286490bb69ee4bedb2 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/leds/trigger/ledtrig-cpu.c:42:17: error: redefinition of 'num_active_cpus' as different kind of symbol
   static atomic_t num_active_cpus = ATOMIC_INIT(0);
                   ^
   include/linux/cpumask.h:979:28: note: previous definition is here
   static inline unsigned int num_active_cpus(void)
                              ^
>> drivers/leds/trigger/ledtrig-cpu.c:82:34: error: incompatible pointer types passing 'unsigned int (*)(void)' to parameter of type 'atomic_t *' [-Werror,-Wincompatible-pointer-types]
                   atomic_add(is_active ? 1 : -1, &num_active_cpus);
                                                  ^~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:54:29: note: passing argument to parameter 'v' here
   atomic_add(int i, atomic_t *v)
                               ^
>> drivers/leds/trigger/ledtrig-cpu.c:83:29: error: incompatible pointer types passing 'unsigned int (*)(void)' to parameter of type 'const atomic_t *' [-Werror,-Wincompatible-pointer-types]
                   active_cpus = atomic_read(&num_active_cpus);
                                             ^~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:25:29: note: passing argument to parameter 'v' here
   atomic_read(const atomic_t *v)
                               ^
   3 errors generated.


vim +/num_active_cpus +42 drivers/leds/trigger/ledtrig-cpu.c

8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  40  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  41  static struct led_trigger *trig_cpu_all;
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09 @42  static atomic_t num_active_cpus = ATOMIC_INIT(0);
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  43  
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  44  /**
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  45   * ledtrig_cpu - emit a CPU event as a trigger
c10074a1e5809e drivers/leds/trigger/ledtrig-cpu.c Lee Jones         2021-05-28  46   * @ledevt: CPU event to be emitted
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  47   *
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  48   * Emit a CPU event on a CPU core, which will trigger a
e602fda1a358a0 drivers/leds/trigger/ledtrig-cpu.c Pavel Machek      2016-10-03  49   * bound LED to turn on or turn off.
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  50   */
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  51  void ledtrig_cpu(enum cpu_led_event ledevt)
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  52  {
24c9301ffd2135 drivers/leds/trigger/ledtrig-cpu.c Christoph Lameter 2014-05-05  53  	struct led_trigger_cpu *trig = this_cpu_ptr(&cpu_trig);
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  54  	bool is_active = trig->is_active;
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  55  
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  56  	/* Locate the correct CPU LED */
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  57  	switch (ledevt) {
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  58  	case CPU_LED_IDLE_END:
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  59  	case CPU_LED_START:
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  60  		/* Will turn the LED on, max brightness */
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  61  		is_active = true;
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  62  		break;
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  63  
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  64  	case CPU_LED_IDLE_START:
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  65  	case CPU_LED_STOP:
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  66  	case CPU_LED_HALTED:
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  67  		/* Will turn the LED off */
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  68  		is_active = false;
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  69  		break;
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  70  
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  71  	default:
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  72  		/* Will leave the LED as it is */
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  73  		break;
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  74  	}
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  75  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  76  	if (is_active != trig->is_active) {
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  77  		unsigned int active_cpus;
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  78  		unsigned int total_cpus;
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  79  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  80  		/* Update trigger state */
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  81  		trig->is_active = is_active;
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09 @82  		atomic_add(is_active ? 1 : -1, &num_active_cpus);
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09 @83  		active_cpus = atomic_read(&num_active_cpus);
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  84  		total_cpus = num_present_cpus();
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  85  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  86  		led_trigger_event(trig->_trig,
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  87  			is_active ? LED_FULL : LED_OFF);
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  88  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  89  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  90  		led_trigger_event(trig_cpu_all,
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  91  			DIV_ROUND_UP(LED_FULL * active_cpus, total_cpus));
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  92  
0b88b71c7762a4 drivers/leds/trigger/ledtrig-cpu.c Paulo Costa       2017-02-09  93  	}
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  94  }
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  95  EXPORT_SYMBOL(ledtrig_cpu);
8f88731d052d2b drivers/leds/ledtrig-cpu.c         Bryan Wu          2011-06-25  96  

:::::: The code at line 42 was first introduced by commit
:::::: 0b88b71c7762a406ff99c625935474dc42a25003 leds/trigger/cpu: Add LED trigger for all CPUs aggregated

:::::: TO: Paulo Costa <me@paulo.costa.nom.br>
:::::: CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
