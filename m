Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C22599B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348663AbiHSLrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348309AbiHSLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:47:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE57E8683;
        Fri, 19 Aug 2022 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660909619; x=1692445619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sxJIM+BHWY9O0qQyEAm4kfuYvS3K5+yYTeL3uKnO6Q=;
  b=k5M3SEEz0s/Te3I8Av9Mq2ao51Gz6uwkOz4BaKSL6xzfm5jWe9p80Rp8
   xCA8/Beby0Li/LK3J3JsjlOinDb84AkwhJjDQaPjgQsuWgUyP+mrYkH5L
   NCva4A69MqGKM9xQsf0FShtc1H1fvF/qAz4hNof5MO7Hb0+8AXpYNtL7W
   O7tU9C0HY3uPWzBvA6hZi0Dwen1xFODXvfDCHujtjc6X43b67HoYlScey
   lRGqU9dCiFhE8CtaI1UQdMD6d8hvCv8l8LKC5DnD/usHa0U9gZmeSq063
   4y2n5YYsl3XWnwaD+yAvgp163yIL6NP+M9YBruzEKTbhltnJ+JnBKtUws
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="273388836"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="273388836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 04:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="750501984"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2022 04:46:54 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP0Sj-0001PS-1n;
        Fri, 19 Aug 2022 11:46:53 +0000
Date:   Fri, 19 Aug 2022 19:45:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 2/3] driver: input: matric-keypad: add reduced matrix
 support
Message-ID: <202208191937.Y6z0Gjrt-lkp@intel.com>
References: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819065946.9572-2-Gireesh.Hiremath@in.bosch.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gireesh-Hiremath-in-bosch-com/driver-input-matric-keypad-switch-to-gpiod/20220819-151155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: s390-randconfig-r044-20220819 (https://download.01.org/0day-ci/archive/20220819/202208191937.Y6z0Gjrt-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a0b420e08e3b8775a3dbc4857f6ef4831db1c2b3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gireesh-Hiremath-in-bosch-com/driver-input-matric-keypad-switch-to-gpiod/20220819-151155
        git checkout a0b420e08e3b8775a3dbc4857f6ef4831db1c2b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/input/keyboard/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/input/keyboard/matrix_keypad.c:14:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/input/keyboard/matrix_keypad.c:14:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/input/keyboard/matrix_keypad.c:14:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/input/keyboard/matrix_keypad.c:857:3: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!keypad->button_array) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/matrix_keypad.c:932:9: note: uninitialized use occurs here
           return err;
                  ^~~
   drivers/input/keyboard/matrix_keypad.c:857:3: note: remove the 'if' if its condition is always false
                   if (!keypad->button_array) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/input/keyboard/matrix_keypad.c:828:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
>> drivers/input/keyboard/matrix_keypad.c:65:33: warning: unused variable 'keypad_infos' [-Wunused-const-variable]
   static const struct keypad_info keypad_infos[] = {
                                   ^
   14 warnings generated.


vim +857 drivers/input/keyboard/matrix_keypad.c

   822	
   823	static int matrix_keypad_probe(struct platform_device *pdev)
   824	{
   825		const struct matrix_keypad_platform_data *pdata;
   826		struct matrix_keypad *keypad;
   827		struct input_dev *input_dev;
 > 828		int err;
   829	
   830		pdata = dev_get_platdata(&pdev->dev);
   831		if (!pdata) {
   832			pdata = matrix_keypad_parse_dt(&pdev->dev);
   833			if (IS_ERR(pdata))
   834				return PTR_ERR(pdata);
   835		} else if (!pdata->keymap_data) {
   836			dev_err(&pdev->dev, "no keymap data defined\n");
   837			return -EINVAL;
   838		}
   839	
   840		keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
   841		input_dev = input_allocate_device();
   842		if (!keypad || !input_dev) {
   843			err = -ENOMEM;
   844			goto err_free_mem;
   845		}
   846	
   847		keypad->input_dev = input_dev;
   848		keypad->pdata = pdata;
   849		keypad->row_shift = get_count_order(pdata->num_col_gpios);
   850		keypad->stopped = true;
   851	
   852		if (pdata->mode == REDUCED) {
   853			keypad->button_array = devm_kzalloc(
   854				&pdev->dev,
   855				sizeof(struct button) * (pdata->num_of_buttons),
   856				GFP_KERNEL);
 > 857			if (!keypad->button_array) {
   858				dev_err(&pdev->dev,
   859					"could not allocate memory for button array\n");
   860				goto err_free_mem;
   861				;
   862			}
   863	
   864			poll_prepare(keypad);
   865	
   866			err = input_setup_polling(input_dev, matrix_keypad_poll);
   867			if (err) {
   868				dev_err(&pdev->dev,
   869					"unable to set up polling, err=%d\n", err);
   870				return err;
   871			}
   872	
   873			input_set_poll_interval(input_dev, pdata->poll_interval_ms);
   874		} else {
   875			INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
   876		}
   877		spin_lock_init(&keypad->lock);
   878	
   879		input_dev->name = pdev->name;
   880		input_dev->id.bustype = BUS_HOST;
   881		input_dev->dev.parent = &pdev->dev;
   882		input_dev->open = matrix_keypad_start;
   883		input_dev->close = matrix_keypad_stop;
   884	
   885		if (pdata->mode == REDUCED) {
   886			err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
   887							 pdata->num_line_gpios,
   888							 pdata->num_line_gpios, NULL,
   889							 input_dev);
   890			if (err) {
   891				dev_err(&pdev->dev, "failed to build keymap for reduced mode\n");
   892				goto err_free_mem;
   893			}
   894		} else {
   895			err = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
   896							 pdata->num_row_gpios,
   897							 pdata->num_col_gpios, NULL,
   898							 input_dev);
   899			if (err) {
   900				dev_err(&pdev->dev, "failed to build keymap for generic mode\n");
   901				goto err_free_mem;
   902			}
   903		}
   904	
   905		if (!pdata->no_autorepeat)
   906			__set_bit(EV_REP, input_dev->evbit);
   907		input_set_capability(input_dev, EV_MSC, MSC_SCAN);
   908		input_set_drvdata(input_dev, keypad);
   909	
   910		if (pdata->mode == REDUCED) {
   911			button_hdl_init(keypad);
   912		} else {
   913			err = matrix_keypad_init_gpio(pdev, keypad);
   914			if (err)
   915				goto err_free_mem;
   916		}
   917	
   918		err = input_register_device(keypad->input_dev);
   919		if (err)
   920			goto err_free_gpio;
   921	
   922		device_init_wakeup(&pdev->dev, pdata->wakeup);
   923		platform_set_drvdata(pdev, keypad);
   924	
   925		return 0;
   926	
   927	err_free_gpio:
   928		matrix_keypad_free_gpio(keypad);
   929	err_free_mem:
   930		input_free_device(input_dev);
   931		kfree(keypad);
   932		return err;
   933	}
   934	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
