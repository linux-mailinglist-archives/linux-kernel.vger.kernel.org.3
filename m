Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9C15A08C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiHYGUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiHYGUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:20:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A88C453
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:20:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w18so14430662qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VX4Y4+Won0KX8jGaPLr5VW15tCXibPzu3K+PtpUFtUI=;
        b=Y8hRK+2zVt+ZCuO+xvmsgGKy+xZJrwhsvClzDv/VrY9y6ls8wwTZ0LoyO+BVXu0DsI
         PZJOB1E1xIOfVk2FCw6Eb9gt+w8b6/y+TueGi761vbmNUk3UrLqtqrJzwSTVmdhncM3S
         ItWWxsTfkPiD5XUQOVMFVUSY6K7bYxi8SxVJLGUpXGQZ82tP4+tvD16QUpjd+IPsXyB8
         5fAzlxPG4YWY6+t5jH02AB1m2Uxf99gtnyNXNRUA1r89Iv+M9/n+7mD3Cya0DiQ2QXmZ
         2kbcic9pmK+iEQIkIPQo+t7ST2jl4dAUd6XrN6zs3H7iylJ89ZWEoHKGHLOzwknq7QuO
         c90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VX4Y4+Won0KX8jGaPLr5VW15tCXibPzu3K+PtpUFtUI=;
        b=W6gz9ieaAlmnUEdQoYNFfD5SY0pJykUWYLzNji56frCQcaaRGI0oJKEt/d1Lo4hGbo
         trzcVm+EMHPQ3T9yhGe4j8cvdto4oxWcZVgNEfrJoTJG0gltn7mwmN5vQM9L4pgpPI73
         sL0fO6siH3aVDEWssM/lSwdSm2oFntrjg5KQVIWXt3oGpqwiyJdTLTjJ8nNeBbr+NwY0
         PLO7TPI5mz91FBazHKJ2Zu5iAbaWoAcnn8I5eOW2wItCMPBhsF7zXIovV+mM+OebdJkn
         /GxpUQlRGbyKtanKO0cevXkJc1PStyGiwsU8McQolOyr8ftN5BgpMWCnYZRQOQSFjsm4
         EsvQ==
X-Gm-Message-State: ACgBeo3hwPGiM1Rg1eqCSh25cs4E1GCKy1ES15341kmUfzj9P/rAcQFA
        B3xg2H/y0jsSY9qYjd5lRRtqM4QpKAyU88Ru/MM=
X-Google-Smtp-Source: AA6agR7v2o1hAF09FAz3I4m2/9OS9jsniuPwNwIHZwZWDUxur32zYrrIsRsrSTEVX+Y23y7BaVsKG7o7datXiT32ZSU=
X-Received: by 2002:a05:620a:2587:b0:6a7:ee6f:bf2a with SMTP id
 x7-20020a05620a258700b006a7ee6fbf2amr2003059qko.542.1661408440061; Wed, 24
 Aug 2022 23:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <202208251224.teVMa7Yy-lkp@intel.com>
In-Reply-To: <202208251224.teVMa7Yy-lkp@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 25 Aug 2022 08:20:28 +0200
Message-ID: <CAFULd4bgdGosQ3byMW9S+ov0uDO9iK3jCmZ-fkZQbCGOpfUvXQ@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:akpm/mm/mm-nonmm-unstable 50/50]
 kernel/smpboot.c:435:6: warning: variable 'oldstate' is used uninitialized
 whenever 'if' condition is true
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="000000000000e5cf9305e70acba7"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e5cf9305e70acba7
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 25, 2022 at 6:30 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Uros,
>
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

No, the warning is correct, and although my compiler didn't emit the
warning, the variable is indeed uninitialized.

The patched kernel worked for me and I was not careful enough to find
all incoming edges to the label.

Attached is an incremental patch I am testing, will send it later
today as a proper patch.

Uros.

> tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-nonmm-unstable
> head:   2d1e07c7534c14e56ac3818fa24e7c1643a9b1dc
> commit: 2d1e07c7534c14e56ac3818fa24e7c1643a9b1dc [50/50] smpboot: use atomic_try_cmpxchg in cpu_wait_death and cpu_report_death
> config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220825/202208251224.teVMa7Yy-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/2d1e07c7534c14e56ac3818fa24e7c1643a9b1dc
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block akpm/mm/mm-nonmm-unstable
>         git checkout 2d1e07c7534c14e56ac3818fa24e7c1643a9b1dc
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/smpboot.c:435:6: warning: variable 'oldstate' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/smpboot.c:449:6: note: uninitialized use occurs here
>            if (oldstate == CPU_DEAD) {
>                ^~~~~~~~
>    kernel/smpboot.c:435:2: note: remove the 'if' if its condition is always false
>            if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/smpboot.c:428:14: note: initialize the variable 'oldstate' to silence this warning
>            int oldstate;
>                        ^
>                         = 0
>    1 warning generated.
>
>
> vim +435 kernel/smpboot.c
>
> 8038dad7e88858 Paul E. McKenney 2015-02-25  421
> 8038dad7e88858 Paul E. McKenney 2015-02-25  422  /*
> 8038dad7e88858 Paul E. McKenney 2015-02-25  423   * Wait for the specified CPU to exit the idle loop and die.
> 8038dad7e88858 Paul E. McKenney 2015-02-25  424   */
> 8038dad7e88858 Paul E. McKenney 2015-02-25  425  bool cpu_wait_death(unsigned int cpu, int seconds)
> 8038dad7e88858 Paul E. McKenney 2015-02-25  426  {
> 8038dad7e88858 Paul E. McKenney 2015-02-25  427         int jf_left = seconds * HZ;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  428         int oldstate;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  429         bool ret = true;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  430         int sleep_jf = 1;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  431
> 8038dad7e88858 Paul E. McKenney 2015-02-25  432         might_sleep();
> 8038dad7e88858 Paul E. McKenney 2015-02-25  433
> 8038dad7e88858 Paul E. McKenney 2015-02-25  434         /* The outgoing CPU will normally get done quite quickly. */
> 8038dad7e88858 Paul E. McKenney 2015-02-25 @435         if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
> 8038dad7e88858 Paul E. McKenney 2015-02-25  436                 goto update_state;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  437         udelay(5);
> 8038dad7e88858 Paul E. McKenney 2015-02-25  438
> 8038dad7e88858 Paul E. McKenney 2015-02-25  439         /* But if the outgoing CPU dawdles, wait increasingly long times. */
> 8038dad7e88858 Paul E. McKenney 2015-02-25  440         while (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) != CPU_DEAD) {
> 8038dad7e88858 Paul E. McKenney 2015-02-25  441                 schedule_timeout_uninterruptible(sleep_jf);
> 8038dad7e88858 Paul E. McKenney 2015-02-25  442                 jf_left -= sleep_jf;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  443                 if (jf_left <= 0)
> 8038dad7e88858 Paul E. McKenney 2015-02-25  444                         break;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  445                 sleep_jf = DIV_ROUND_UP(sleep_jf * 11, 10);
> 8038dad7e88858 Paul E. McKenney 2015-02-25  446         }
> 8038dad7e88858 Paul E. McKenney 2015-02-25  447         oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
> 2d1e07c7534c14 Uros Bizjak      2022-08-23  448  update_state:
> 8038dad7e88858 Paul E. McKenney 2015-02-25  449         if (oldstate == CPU_DEAD) {
> 8038dad7e88858 Paul E. McKenney 2015-02-25  450                 /* Outgoing CPU died normally, update state. */
> 8038dad7e88858 Paul E. McKenney 2015-02-25  451                 smp_mb(); /* atomic_read() before update. */
> 8038dad7e88858 Paul E. McKenney 2015-02-25  452                 atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_POST_DEAD);
> 8038dad7e88858 Paul E. McKenney 2015-02-25  453         } else {
> 8038dad7e88858 Paul E. McKenney 2015-02-25  454                 /* Outgoing CPU still hasn't died, set state accordingly. */
> 2d1e07c7534c14 Uros Bizjak      2022-08-23  455                 if (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
> 2d1e07c7534c14 Uros Bizjak      2022-08-23  456                                         &oldstate, CPU_BROKEN))
> 8038dad7e88858 Paul E. McKenney 2015-02-25  457                         goto update_state;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  458                 ret = false;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  459         }
> 8038dad7e88858 Paul E. McKenney 2015-02-25  460         return ret;
> 8038dad7e88858 Paul E. McKenney 2015-02-25  461  }
> 8038dad7e88858 Paul E. McKenney 2015-02-25  462
>
> :::::: The code at line 435 was first introduced by commit
> :::::: 8038dad7e888581266c76df15d70ca457a3c5910 smpboot: Add common code for notification from dying CPU
>
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

--000000000000e5cf9305e70acba7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smpboot-Fix-cpu_wait_death-for-early-cpu-death.patch"
Content-Disposition: attachment; 
	filename="0001-smpboot-Fix-cpu_wait_death-for-early-cpu-death.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l78nod9y0>
X-Attachment-Id: f_l78nod9y0

RnJvbSAyOWM0MTlmOWMyNzY3N2E0ODQyZmUyYWVmMzZkY2Y0NGI0MzIxZGZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBVcm9zIEJpemphayA8dWJpempha0BnbWFpbC5jb20+CkRhdGU6
IFRodSwgMjUgQXVnIDIwMjIgMDg6MDk6NDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBzbXBib290
OiBGaXggY3B1X3dhaXRfZGVhdGggZm9yIGVhcmx5IGNwdSBkZWF0aAoKRml4IHVuaW5pdGlhbGl6
ZWQgdmFyaWFibGUgaW4gY2FzZSBjcHUgZGllcyBlYXJseS4KClJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+ClNpZ25lZC1vZmYtYnk6IFVyb3MgQml6amFrIDx1Yml6amFrQGdtYWls
LmNvbT4KLS0tCiBrZXJuZWwvc21wYm9vdC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvc21wYm9vdC5j
IGIva2VybmVsL3NtcGJvb3QuYwppbmRleCBmM2NmMWE5YThiNDQuLjJjNzM5NmRhNDcwYyAxMDA2
NDQKLS0tIGEva2VybmVsL3NtcGJvb3QuYworKysgYi9rZXJuZWwvc21wYm9vdC5jCkBAIC00MzMs
NyArNDMzLDcgQEAgYm9vbCBjcHVfd2FpdF9kZWF0aCh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgc2Vj
b25kcykKIAogCS8qIFRoZSBvdXRnb2luZyBDUFUgd2lsbCBub3JtYWxseSBnZXQgZG9uZSBxdWl0
ZSBxdWlja2x5LiAqLwogCWlmIChhdG9taWNfcmVhZCgmcGVyX2NwdShjcHVfaG90cGx1Z19zdGF0
ZSwgY3B1KSkgPT0gQ1BVX0RFQUQpCi0JCWdvdG8gdXBkYXRlX3N0YXRlOworCQlnb3RvIHVwZGF0
ZV9zdGF0ZV9lYXJseTsKIAl1ZGVsYXkoNSk7CiAKIAkvKiBCdXQgaWYgdGhlIG91dGdvaW5nIENQ
VSBkYXdkbGVzLCB3YWl0IGluY3JlYXNpbmdseSBsb25nIHRpbWVzLiAqLwpAQCAtNDQ0LDYgKzQ0
NCw3IEBAIGJvb2wgY3B1X3dhaXRfZGVhdGgodW5zaWduZWQgaW50IGNwdSwgaW50IHNlY29uZHMp
CiAJCQlicmVhazsKIAkJc2xlZXBfamYgPSBESVZfUk9VTkRfVVAoc2xlZXBfamYgKiAxMSwgMTAp
OwogCX0KK3VwZGF0ZV9zdGF0ZV9lYXJseToKIAlvbGRzdGF0ZSA9IGF0b21pY19yZWFkKCZwZXJf
Y3B1KGNwdV9ob3RwbHVnX3N0YXRlLCBjcHUpKTsKIHVwZGF0ZV9zdGF0ZToKIAlpZiAob2xkc3Rh
dGUgPT0gQ1BVX0RFQUQpIHsKLS0gCjIuMzEuMQoK
--000000000000e5cf9305e70acba7--
