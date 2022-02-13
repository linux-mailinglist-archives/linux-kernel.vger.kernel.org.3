Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FE94B3D81
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiBMUpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:45:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBMUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:45:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B953707
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644785103;
        bh=nNVsdkRaRQk42S3MEEZn/Qt8j2Vug4bsyjpjjf4oufM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DbGHdza9Ml/kD5ycjTkK3hH5d3OJ1l5XyFZC43BxpedfPhYG5HYQR/MXOY4/k7Qo6
         +3vl+HctuQ5OqWXGBo6OjfSJdK+K1OPLLM23phi6Yzau7dc6to2To3yKjjr5VES1PJ
         WT0f1e9ugnuFg3VBKjEblSrDzYcuBxf5JASD4raY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.238]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1oDnJQ38ed-00zUqW; Sun, 13
 Feb 2022 21:45:03 +0100
Message-ID: <1c419d0f-9f37-9a7b-7353-44b6f2f2c11a@gmx.de>
Date:   Sun, 13 Feb 2022 21:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: include/linux/smp.h:34:33: error: requested alignment '20' is not
 a positive power of 2
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202131741.c6BPpfzd-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202202131741.c6BPpfzd-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3AmTpoBWMKEeL3lPI7Ff20UMIT8m5nm598lLhoagibiHxWa7z8
 F+o4cN8VCqyoEexyRujKyMpHtUTblr3xKG2jv/kMAy+YpfbyFOALwrYk7uR1AizE9ZkER2X
 hkxjRq/9nsae1QuwBKDi9GaBtYAFf2VmypjtAR1XYVhNGmVGp1MpKNZtB1ZZBvtvOWnSiuW
 lbZ1CJLNfLj9bVltocaTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gkf0NvG15rE=:+HvI//oNqPea4n0EoVCRug
 FIRYZpAdT4/ImbpzV9AjB6Oiuppbq0pnDdUQo2zwVbjMgzoZUhU86tcQDTw2P0ZyR3geZDgzZ
 cRuahIEXwDmrpm3PuMsq/jX/vIAKrTHYWu3iX28dTB3Z737s5Wuf4cpC+GdVchy1dyWOyp70l
 ghLQrm4x8Cw74oSqVnXhnycCjOMhZRuax6fnl0140mksnpB0XOhZy8F5W/08hEdLYluqBNm6m
 9tEc76WK6BDqIY0c0AfzFkwGB39MtXvKo9mDqXpbb5qme1XNmbUPjzDEm4ih4iriPwMXY+fB6
 95glBBoA7xu+sFqtAE8/pSLXadxnlwk6QYTqxJYKRoggxSpof/sAjdGFXwi5dfRhbEFCdDRQM
 xu7VvfzdzfEoaZudx0B00sY+dmqY3qhccuoXopit567GApyOJT4ZpFvOEzrS36IjjZjUGvHyp
 ixX2yA2cnwaaH0VcqfDfXGtWRORUbidvilq19oX7ey9qSdIn1PPU3CbY8xfWMiA5Nims82NdV
 /e6oAzrbw/JeAvl6z14IErz6g0f11DW/HTrQTuVlGQy6XdIEH1MCZdgeo0jtddLHZRYRPCfhs
 LIvmSaZXFHB2FRq/ght2yQUkIAl6VEUPWzymemswO0D17gFx7b6wH4v9ruvEPQnr3nwwdw5+x
 JCtznl/Kwsnd/B1vNasNxrNMEC81Npeq50fse0xKek7qc0ayzvFDlIL3e77AS6LaVnGgt1Gea
 STA8rQjrjPEe9mSFlXUpS0xDaPKxb/q+RYj0ZTG8n4NZZ7ltRafJX0qXpD7k4JiqahFW3RUph
 DdrB3rZmy4aGkvItWXfAbroqyhsObtAYpCtVjRd9d/Mrok6lZ7Pxb5N7zJKpZixiJkNhvQgQJ
 nPy3ON47Kbt37FdQuLSjUZFZdNnAYHFKIRspc+HC4bceUDfyhzxBVdlL5ZhM9CM6wV4u/gqqE
 wSpXxN+Lb9jbLr9dKle9PnVJAlCbv/8RiByfwE6pM3HQMa8OBghalB7ZVYUzp8pAra+4DabyS
 YVlEQkF0psjERlBE164BuFpHMyV2RPdV8OT1xHlydWnulPskNZlK1qv1jhIPMqmF7uiQC9+VG
 qzX7ruLlJsXnoM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/22 10:59, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile fai=
lure when building 64-bit kernel natively
> date:   6 months ago
> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci=
/archive/20220213/202202131741.c6BPpfzd-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3D5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/parisc/include/asm/bitops.h:203,
>                     from include/linux/bitops.h:32,
>                     from include/linux/kernel.h:12,
>                     from arch/parisc/include/asm/bug.h:5,
>                     from include/linux/bug.h:5,
>                     from include/linux/page-flags.h:10,
>                     from kernel/bounds.c:10:
>    include/asm-generic/bitops/__fls.h: In function '__fls':
>>> include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       18 |         if (!(word & (~0ul << 32))) {


This kind of build error usually happens if you use the 64-bit compiler
(hppa64-linux-gcc) to compile a kernel config for a 32-bit kernel.

Looking at the config:
> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci=
/archive/20220213/202202131741.c6BPpfzd-lkp@intel.com/config)
CONFIG_64BIT is set to Y, so that's correct here.

But this is how you call the compiler:
> COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross O=3D=
build_dir ARCH=3Dparisc prepare

The "ARCH=3Dparisc" is wrong in this case.
You need:
"ARCH=3Dparisc64".
This is starting with Linux kernel 5.14.
Before "ARCH=3Dparisc" worked for 32- and 64-bit kernels.

Can you adjust the call command?

Helge



>          |                            ^~
>    include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       20 |                 word <<=3D 32;
>          |                      ^~~
>    include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
>          |                            ^~
>    In file included from arch/parisc/include/asm/bitops.h:203,
>                     from include/linux/bitops.h:32,
>                     from include/linux/kernel.h:12,
>                     from arch/parisc/include/asm/bug.h:5,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/current.h:5,
>                     from ./arch/parisc/include/generated/asm/current.h:1=
,
>                     from include/linux/sched.h:12,
>                     from arch/parisc/kernel/asm-offsets.c:18:
>    include/asm-generic/bitops/__fls.h: In function '__fls':
>>> include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       18 |         if (!(word & (~0ul << 32))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       20 |                 word <<=3D 32;
>          |                      ^~~
>    include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>          |                            ^~
>    include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>       39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
>          |                            ^~
>    In file included from arch/parisc/include/asm/processor.h:17,
>                     from arch/parisc/include/asm/thread_info.h:8,
>                     from include/linux/thread_info.h:60,
>                     from include/asm-generic/current.h:5,
>                     from ./arch/parisc/include/generated/asm/current.h:1=
,
>                     from include/linux/sched.h:12,
>                     from arch/parisc/kernel/asm-offsets.c:18:
>    arch/parisc/include/asm/pdc.h: At top level:
>>> arch/parisc/include/asm/pdc.h:75:24: warning: 'struct pdc_memory_table=
' declared inside parameter list will not be visible outside of this defin=
ition or declaration
>       75 |                 struct pdc_memory_table *tbl, unsigned long e=
ntries);
>          |                        ^~~~~~~~~~~~~~~~
>>> arch/parisc/include/asm/pdc.h:74:30: warning: 'struct pdc_memory_table=
_raddr' declared inside parameter list will not be visible outside of this=
 definition or declaration
>       74 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *r_addr,
>          |                              ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/compiler_types.h:65,
>                     from <command-line>:
>>> include/linux/smp.h:34:33: error: requested alignment '20' is not a po=
sitive power of 2
>       34 |         __aligned(sizeof(struct __call_single_data));
>          |                                 ^~~~~~~~~~~~~~~~~~
>    include/linux/compiler_attributes.h:53:68: note: in definition of mac=
ro '__aligned'
>       53 | #define __aligned(x)                    __attribute__((__alig=
ned__(x)))
>          |                                                              =
      ^
>    In file included from include/linux/mm.h:33,
>                     from include/linux/pid_namespace.h:7,
>                     from include/linux/ptrace.h:10,
>                     from arch/parisc/kernel/asm-offsets.c:20:
>    include/linux/pgtable.h: In function 'pud_index':
>>> include/linux/pgtable.h:77:25: warning: right shift count >=3D width o=
f type [-Wshift-count-overflow]
>       77 |         return (address >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
>          |                         ^~
>    include/linux/pgtable.h: In function 'pgd_offset_pgd':
>    include/linux/pgtable.h:84:29: warning: right shift count >=3D width =
of type [-Wshift-count-overflow]
>       84 | #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD -=
 1))
>          |                             ^~
>    include/linux/pgtable.h:124:23: note: in expansion of macro 'pgd_inde=
x'
>      124 |         return (pgd + pgd_index(address));
>          |                       ^~~~~~~~~
>    In file included from include/linux/stringhash.h:7,
>                     from include/linux/dcache.h:15,
>                     from include/linux/fs.h:8,
>                     from include/linux/huge_mm.h:8,
>                     from include/linux/mm.h:728,
>                     from include/linux/pid_namespace.h:7,
>                     from include/linux/ptrace.h:10,
>                     from arch/parisc/kernel/asm-offsets.c:20:
>    include/linux/hash.h: In function 'hash32_ptr':
>>> include/linux/hash.h:99:21: warning: right shift count >=3D width of t=
ype [-Wshift-count-overflow]
>       99 |         val ^=3D (val >> 32);
>          |                     ^~
>    In file included from arch/parisc/kernel/asm-offsets.c:22:
>    arch/parisc/kernel/asm-offsets.c: In function 'main':
>>> arch/parisc/kernel/asm-offsets.c:271:43: warning: right shift count >=
=3D width of type [-Wshift-count-overflow]
>      271 |         DEFINE(ASM_PGD_ENTRY, PAGE_OFFSET >> PGDIR_SHIFT);
>          |                                           ^~
>    include/linux/kbuild.h:6:69: note: in definition of macro 'DEFINE'
>        6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : =
: "i" (val))
>          |                                                              =
       ^~~
>    make[2]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offs=
ets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1217: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:220: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
>
> vim +/20 +34 include/linux/smp.h
>
> 3d4422332711ef Jens Axboe     2008-06-26  28
> 545b8c8df41f9e Peter Zijlstra 2020-06-15  29  #define CSD_INIT(_func, _i=
nfo) \
> 545b8c8df41f9e Peter Zijlstra 2020-06-15  30  	(struct __call_single_dat=
a){ .func =3D (_func), .info =3D (_info), }
> 545b8c8df41f9e Peter Zijlstra 2020-06-15  31
> 966a967116e699 Ying Huang     2017-08-08  32  /* Use __aligned() to avoi=
d to use 2 cache lines for 1 csd */
> 966a967116e699 Ying Huang     2017-08-08  33  typedef struct __call_sing=
le_data call_single_data_t
> 966a967116e699 Ying Huang     2017-08-08 @34  	__aligned(sizeof(struct _=
_call_single_data));
> 966a967116e699 Ying Huang     2017-08-08  35
>
> :::::: The code at line 34 was first introduced by commit
> :::::: 966a967116e699762dbf4af7f9e0d1955c25aa37 smp: Avoid using two cac=
he lines for struct call_single_data
>
> :::::: TO: Ying Huang <ying.huang@intel.com>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

