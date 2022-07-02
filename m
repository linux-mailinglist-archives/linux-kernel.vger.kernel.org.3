Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53CA563DC5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 04:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGBCda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 22:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBCd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:33:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE91A387
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 19:33:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x1so2187375qtv.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mr2Gqlt6pfnxt0OELN4sRGwA6Wkbb4EP0OeR8zCnv9o=;
        b=gctRiAbt9mYlpqBpiAF9+Jt0Tb04w+Az2v2AfLGbVxgN1SFpw6bcJiZsjWDrNkg6G+
         HQm2dKy1uVDpdILNi0gUh1rfLdEG06ApFxUqK7NfG0zuLSvDikGlMiDtdmdm1Pnvg84A
         z6kZO8qtcCezTXOUR30lH9tuXXYaQUrbGM/OMZE34dzNB/qY+/fxdbI41MmMZwCvrcoX
         PC+U+ihZc7asBvkC3zsEqTeuu6Ippn5qpFF9hpcpFFo3tQuT3AZ7981SVVYYuT+5HrJJ
         ODcCo4bdJN8U+XJKMJsZkWsRFaLbEJlOILh1q/EgIxbLc1XxcvSUNZAl5xAYqFFzsL+b
         1PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mr2Gqlt6pfnxt0OELN4sRGwA6Wkbb4EP0OeR8zCnv9o=;
        b=0zcJx6ryY91rp79i/FWn12Jl7hG4GwiWYWxMcstYPjsyPBJU+WimVTGi9zAyB43UwN
         a8iy0yqDquuEKR9F8DPYMLgu9UDx9DEUinbIEE0JQS32Iq8YiruPITSkl9JXVrZJtI2T
         LWkJ8815PCND4q9FsPsJuOZ4IsnZyeMaHZPFpgbpA6U5LGX64KizxjdYkt2ezu4tdcwA
         ybW+c3gmoJWp9l7Mv0xjxr5yM2lf9Vrz8W5apPUBX+DQc/9chMQvhIZ3JMwnKljO5Wgx
         WYX9BKKUASGE7tVEjHHwtKPpCs6wrg9bxiCnmJKu/O5p8jymaW8hvNqCGc5WUYYq1s0q
         l2mg==
X-Gm-Message-State: AJIora81yqLS4R+nexGaq8OUar1f5zP8FzhwPXwvcGTKB/cVi+wphn4p
        TYzgIg7QQIVTqbqIxY62e6NRKvta0qI=
X-Google-Smtp-Source: AGRyM1trG6CgRrg4wcBCxucj/ywYWn8TQF9FPclr0vPnG8s8h/0J02TuItRILJgzvSGlU8+V628WGQ==
X-Received: by 2002:ad4:420a:0:b0:470:315f:c41b with SMTP id k10-20020ad4420a000000b00470315fc41bmr19040704qvp.79.1656729206889;
        Fri, 01 Jul 2022 19:33:26 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id az8-20020a05620a170800b006b14b303b37sm6334590qkb.102.2022.07.01.19.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 19:33:26 -0700 (PDT)
Date:   Fri, 1 Jul 2022 19:33:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     yury.norov@gmail.com, linux-kernel@vger.kernel.org
Subject: [lkp@intel.com: [norov:fns 9/23] include/asm-generic/percpu.h:21:44:
 warning: array subscript 4 is above array bounds of 'long unsigned int[4]']
Message-ID: <Yr+udMjfCFZP7FAs@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

I'm working on top of your recent cons bitmap series, and again
received a bug report from LKP regarding one of you patches. Can
you please look at this report?

I tried reproduce it myself, but the build is failed for me:
arch/arc/kernel/entry.S: Assembler messages:
arch/arc/kernel/entry.S:280: Error: operand out of range (260 is not between -256 and 255)
make[2]: *** [scripts/Makefile.build:322: arch/arc/kernel/entry-compact.o] Error 1
make[2]: *** Waiting for unfinished jobs....

If you think it's mis-attributed, we should let LKP people know that
something is wrong on their side.

Thanks,
Yury

----- Forwarded message from kernel test robot <lkp@intel.com> -----

Date: Sat, 2 Jul 2022 08:42:59 +0800
From: kernel test robot <lkp@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: kbuild-all@lists.01.org
Subject: [norov:fns 9/23] include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of
	'long unsigned int[4]'

tree:   https://github.com/norov/linux fns
head:   1df9509fd92a58cb37e9a419235823bbb13367de
commit: 3e7e5baaaba78075a7f3a57432609e363bf2a486 [9/23] bitmap: don't assume compiler evaluates small mem*() builtins calls
config: arc-randconfig-r035-20220629 (https://download.01.org/0day-ci/archive/20220702/202207020812.oTFxIVue-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/3e7e5baaaba78075a7f3a57432609e363bf2a486
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout 3e7e5baaaba78075a7f3a57432609e363bf2a486
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:93,
                    from <command-line>:
   kernel/sched/topology.c: In function 'build_sched_domains':
>> include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of 'long unsigned int[4]' [-Warray-bounds]
      21 | #define per_cpu_offset(x) (__per_cpu_offset[x])
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                                 ^~~
   include/linux/percpu-defs.h:236:9: note: in expansion of macro 'SHIFT_PERCPU_PTR'
     236 |         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
         |         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:236:33: note: in expansion of macro 'per_cpu_offset'
     236 |         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
         |                                 ^~~~~~~~~~~~~~
   kernel/sched/topology.c:969:20: note: in expansion of macro 'per_cpu_ptr'
     969 |         sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
         |                    ^~~~~~~~~~~
   In file included from ./arch/arc/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from include/linux/sched/cputime.h:5,
                    from kernel/sched/build_utility.c:13:
   include/asm-generic/percpu.h:19:22: note: while referencing '__per_cpu_offset'
      19 | extern unsigned long __per_cpu_offset[NR_CPUS];
         |                      ^~~~~~~~~~~~~~~~


vim +21 include/asm-generic/percpu.h

^1da177e4c3f415 Linus Torvalds 2005-04-16  20  
a875a69f8b00a38 Ingo Molnar    2006-07-03 @21  #define per_cpu_offset(x) (__per_cpu_offset[x])
acdac87202a4081 travis@sgi.com 2008-01-30  22  #endif
acdac87202a4081 travis@sgi.com 2008-01-30  23  

:::::: The code at line 21 was first introduced by commit
:::::: a875a69f8b00a38b4f40d9632a4fc71a159f0e0d [PATCH] lockdep: add per_cpu_offset()

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

----- End forwarded message -----
