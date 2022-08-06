Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED558B81D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiHFUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiHFUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:09:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9D1EE13
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659816550; x=1691352550;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KEwOTVoG7ZqDsSp59wGjwyZ1q5J+EUIIvPZliqYQesE=;
  b=DIrFFoc94bLEJt3u76akuUVaykaMg6q7jxS+Ycs9BD2J0JqA8b4HbhDT
   9/6LxaUUGj4Eh6Hss85SLpnkR6jaPvOu2dzlobTiw7lhWrapUv0yDyiWa
   d7l8ufeKhDJPieQG/DlbcE8to83SeJJlAc+zePHhhvKzq9MMkvOlU+QAt
   Nb7W/GK5ufJ40cVOhmgIPrxXkE+wwQrD1+xurLY21XDutD1+N11UdD5kv
   1nrHE+GE8kdGEiHhmTc3M4KVpb7jN0uZQ8j7jwsThpfAfzQlez1/n01cO
   8DdgWxDtyucz3sYM6S8b7nEsUH+MzNdYJiRYAH6ZGPQ0TgEjIO9CiP6eU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352113804"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352113804"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 13:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="672044144"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2022 13:09:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKQ6c-000KeD-2z;
        Sat, 06 Aug 2022 20:09:06 +0000
Date:   Sun, 7 Aug 2022 04:08:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 6418/9999]
 drivers/input/keyreset.c:119:5: warning: no previous prototype for function
 'keyreset_remove'
Message-ID: <202208070416.jdFdsESN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 4fae0a1dc645742f2ecd6238813b2d30d4fb31cd [6418/9999] UPSTREAM: kbuild: add some extra warning flags unconditionally
config: mips-randconfig-r012-20220807 (https://download.01.org/0day-ci/archive/20220807/202208070416.jdFdsESN-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/jsarha/linux/commit/4fae0a1dc645742f2ecd6238813b2d30d4fb31cd
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 4fae0a1dc645742f2ecd6238813b2d30d4fb31cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash M=drivers/input

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/input/keyreset.c:23:
   In file included from include/linux/syscalls.h:85:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:7:
   In file included from include/linux/trace_seq.h:5:
   include/linux/seq_buf.h:35:12: warning: assigning to 'char *' from 'unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
           s->buffer = buf;
                     ^ ~~~
>> drivers/input/keyreset.c:119:5: warning: no previous prototype for function 'keyreset_remove' [-Wmissing-prototypes]
   int keyreset_remove(struct platform_device *pdev)
       ^
   drivers/input/keyreset.c:119:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int keyreset_remove(struct platform_device *pdev)
   ^
   static 
   2 warnings generated.
   Assembler messages:
   Fatal error: invalid -march= option: `mips32'
   clang-16: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> drivers/input/keycombo.c:234:5: warning: no previous prototype for function 'keycombo_remove' [-Wmissing-prototypes]
   int keycombo_remove(struct platform_device *pdev)
       ^
   drivers/input/keycombo.c:234:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int keycombo_remove(struct platform_device *pdev)
   ^
   static 
   1 warning generated.
   Assembler messages:
   Fatal error: invalid -march= option: `mips32'
   clang-16: error: assembler command failed with exit code 1 (use -v to see invocation)


vim +/keyreset_remove +119 drivers/input/keyreset.c

fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  @23  #include <linux/syscalls.h>
5f2afc82f504df Daniel Rosenberg 2014-05-07   24  #include <linux/keycombo.h>
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   25  
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   26  struct keyreset_state {
5f2afc82f504df Daniel Rosenberg 2014-05-07   27  	int restart_requested;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   28  	int (*reset_fn)(void);
5f2afc82f504df Daniel Rosenberg 2014-05-07   29  	struct platform_device *pdev_child;
595f7ba388d32f Daniel Rosenberg 2014-06-27   30  	struct work_struct restart_work;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   31  };
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   32  
595f7ba388d32f Daniel Rosenberg 2014-06-27   33  static void do_restart(struct work_struct *unused)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   34  {
9a6baccec822de Eric Ernst       2016-09-02   35  	orderly_reboot();
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   36  }
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   37  
5f2afc82f504df Daniel Rosenberg 2014-05-07   38  static void do_reset_fn(void *priv)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   39  {
5f2afc82f504df Daniel Rosenberg 2014-05-07   40  	struct keyreset_state *state = priv;
5f2afc82f504df Daniel Rosenberg 2014-05-07   41  	if (state->restart_requested)
5f2afc82f504df Daniel Rosenberg 2014-05-07   42  		panic("keyboard reset failed, %d", state->restart_requested);
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   43  	if (state->reset_fn) {
5f2afc82f504df Daniel Rosenberg 2014-05-07   44  		state->restart_requested = state->reset_fn();
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   45  	} else {
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   46  		pr_info("keyboard reset\n");
595f7ba388d32f Daniel Rosenberg 2014-06-27   47  		schedule_work(&state->restart_work);
5f2afc82f504df Daniel Rosenberg 2014-05-07   48  		state->restart_requested = 1;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   49  	}
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   50  }
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   51  
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   52  static int keyreset_probe(struct platform_device *pdev)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   53  {
5f2afc82f504df Daniel Rosenberg 2014-05-07   54  	int ret = -ENOMEM;
5f2afc82f504df Daniel Rosenberg 2014-05-07   55  	struct keycombo_platform_data *pdata_child;
5f2afc82f504df Daniel Rosenberg 2014-05-07   56  	struct keyreset_platform_data *pdata = pdev->dev.platform_data;
5f2afc82f504df Daniel Rosenberg 2014-05-07   57  	int up_size = 0, down_size = 0, size;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   58  	int key, *keyp;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   59  	struct keyreset_state *state;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   60  
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   61  	if (!pdata)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   62  		return -EINVAL;
5f2afc82f504df Daniel Rosenberg 2014-05-07   63  	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   64  	if (!state)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   65  		return -ENOMEM;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   66  
5f2afc82f504df Daniel Rosenberg 2014-05-07   67  	state->pdev_child = platform_device_alloc(KEYCOMBO_NAME,
5f2afc82f504df Daniel Rosenberg 2014-05-07   68  							PLATFORM_DEVID_AUTO);
5f2afc82f504df Daniel Rosenberg 2014-05-07   69  	if (!state->pdev_child)
5f2afc82f504df Daniel Rosenberg 2014-05-07   70  		return -ENOMEM;
5f2afc82f504df Daniel Rosenberg 2014-05-07   71  	state->pdev_child->dev.parent = &pdev->dev;
595f7ba388d32f Daniel Rosenberg 2014-06-27   72  	INIT_WORK(&state->restart_work, do_restart);
5f2afc82f504df Daniel Rosenberg 2014-05-07   73  
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   74  	keyp = pdata->keys_down;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   75  	while ((key = *keyp++)) {
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   76  		if (key >= KEY_MAX)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   77  			continue;
5f2afc82f504df Daniel Rosenberg 2014-05-07   78  		down_size++;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   79  	}
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   80  	if (pdata->keys_up) {
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   81  		keyp = pdata->keys_up;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   82  		while ((key = *keyp++)) {
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   83  			if (key >= KEY_MAX)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21   84  				continue;
5f2afc82f504df Daniel Rosenberg 2014-05-07   85  			up_size++;
5f2afc82f504df Daniel Rosenberg 2014-05-07   86  		}
5f2afc82f504df Daniel Rosenberg 2014-05-07   87  	}
5f2afc82f504df Daniel Rosenberg 2014-05-07   88  	size = sizeof(struct keycombo_platform_data)
5f2afc82f504df Daniel Rosenberg 2014-05-07   89  			+ sizeof(int) * (down_size + 1);
5f2afc82f504df Daniel Rosenberg 2014-05-07   90  	pdata_child = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
5f2afc82f504df Daniel Rosenberg 2014-05-07   91  	if (!pdata_child)
5f2afc82f504df Daniel Rosenberg 2014-05-07   92  		goto error;
5f2afc82f504df Daniel Rosenberg 2014-05-07   93  	memcpy(pdata_child->keys_down, pdata->keys_down,
5f2afc82f504df Daniel Rosenberg 2014-05-07   94  						sizeof(int) * down_size);
5f2afc82f504df Daniel Rosenberg 2014-05-07   95  	if (up_size > 0) {
5f2afc82f504df Daniel Rosenberg 2014-05-07   96  		pdata_child->keys_up = devm_kzalloc(&pdev->dev, up_size + 1,
5f2afc82f504df Daniel Rosenberg 2014-05-07   97  								GFP_KERNEL);
5f2afc82f504df Daniel Rosenberg 2014-05-07   98  		if (!pdata_child->keys_up)
5f2afc82f504df Daniel Rosenberg 2014-05-07   99  			goto error;
5f2afc82f504df Daniel Rosenberg 2014-05-07  100  		memcpy(pdata_child->keys_up, pdata->keys_up,
5f2afc82f504df Daniel Rosenberg 2014-05-07  101  							sizeof(int) * up_size);
5f2afc82f504df Daniel Rosenberg 2014-05-07  102  		if (!pdata_child->keys_up)
5f2afc82f504df Daniel Rosenberg 2014-05-07  103  			goto error;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  104  	}
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  105  	state->reset_fn = pdata->reset_fn;
5f2afc82f504df Daniel Rosenberg 2014-05-07  106  	pdata_child->key_down_fn = do_reset_fn;
5f2afc82f504df Daniel Rosenberg 2014-05-07  107  	pdata_child->priv = state;
5f2afc82f504df Daniel Rosenberg 2014-05-07  108  	pdata_child->key_down_delay = pdata->key_down_delay;
5f2afc82f504df Daniel Rosenberg 2014-05-07  109  	ret = platform_device_add_data(state->pdev_child, pdata_child, size);
5f2afc82f504df Daniel Rosenberg 2014-05-07  110  	if (ret)
5f2afc82f504df Daniel Rosenberg 2014-05-07  111  		goto error;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  112  	platform_set_drvdata(pdev, state);
5f2afc82f504df Daniel Rosenberg 2014-05-07  113  	return platform_device_add(state->pdev_child);
5f2afc82f504df Daniel Rosenberg 2014-05-07  114  error:
5f2afc82f504df Daniel Rosenberg 2014-05-07  115  	platform_device_put(state->pdev_child);
5f2afc82f504df Daniel Rosenberg 2014-05-07  116  	return ret;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  117  }
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  118  
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21 @119  int keyreset_remove(struct platform_device *pdev)
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  120  {
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  121  	struct keyreset_state *state = platform_get_drvdata(pdev);
5f2afc82f504df Daniel Rosenberg 2014-05-07  122  	platform_device_put(state->pdev_child);
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  123  	return 0;
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  124  }
fa50e390aa4e9f Arve Hjønnevåg   2008-11-21  125  

:::::: The code at line 119 was first introduced by commit
:::::: fa50e390aa4e9f5596734b01f927e5dca1f19843 ANDROID: input: keyreset: Add keyreset driver.

:::::: TO: Arve Hjønnevåg <arve@android.com>
:::::: CC: Guenter Roeck <groeck@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
