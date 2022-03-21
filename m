Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C64E2F40
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbiCURmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345607AbiCURml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:42:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540B51595
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:41:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q5so20872309ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvDP/aC4k2MIgLQCzM4tXzCki/AhzE/DRELx6D6TcvQ=;
        b=LCiQ2cBeGHtozeXWAJvmRWwSIzciVtKWGB8pQ78lb5TjP5X+NgKn+rLgOWRq24XaeK
         DTNFFZpR+k3YjUjF9zPc65gJ3uf7BKFTAvH3NVZHBFjJ/VZk6a5ivjm3Mfxpao9gvvcw
         4DT7pcwi+m7tjMt7OpjXBs9QtMSlGHIt+rwu4eTg93rv27aDIE07WU9KWBeCCMGcImBn
         YlWs4EQHe9A9pkK7DbJ8VXa1sOwxHS27xRoLlWWuLfv4cPPk6TsH3V3lPgA+b0THxn65
         k8aitxmEIG3KeprGwDXtbPyaZnh4Gluqo+Ubvbu5MXkex5SDhMZbrVOhE/yqj099Leyr
         qzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvDP/aC4k2MIgLQCzM4tXzCki/AhzE/DRELx6D6TcvQ=;
        b=Vo0MYfguMLFGIPzCYmBQC0BopqF/IUoabajhHWKw/ABpgU084lJjhMtjU2c1ysm0xx
         sMsTY1wCc8RamzO+RlvXLzknC22PzitfXBbzMfwGu16eFxvIvKnJW8RBdIDPqB+r25N7
         sgKZ06TeH2YyWWRkteho55uf+C4rGUfU77v57EWEte/i2rRuSVNj5QLrfXlAJtbqmpkx
         RCgeaib5aURmRNeWdGdWDAytF0r3qrM8DazCEMyjRgu/6sanBzlf1iauWuXm5T4pTgZT
         utyHdp27hhBs5cFIgHtju9JVR/4FvEAmGQiky/wLHWNMPMJC+s9AQImH40eMiGkmdncB
         kgFA==
X-Gm-Message-State: AOAM532JV/Ueb/76PCsz6duMi83FENxqQ9Mn2bF/1T3Vhc82yW6xiYB0
        RrSqiF5JtcXslm9tkOvoUXEj49T1AvqbWIJL5v1Pt5irZYBB5s02
X-Google-Smtp-Source: ABdhPJzbEpirlUxNiDc0Pp6FcUiq9WvkQhNk8nak3G1dOD4WBSldy75o+lwnjBnpM+YiU6CE7/fcbaaUZBHsyMqJarc=
X-Received: by 2002:a2e:a0c9:0:b0:249:171b:1b06 with SMTP id
 f9-20020a2ea0c9000000b00249171b1b06mr16403679ljm.420.1647884472740; Mon, 21
 Mar 2022 10:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <202203211432.Fx74gYS9-lkp@intel.com>
In-Reply-To: <202203211432.Fx74gYS9-lkp@intel.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 21 Mar 2022 10:41:01 -0700
Message-ID: <CAJnrk1bqXmtSjvevnuBBqYWsZeQsMPYJhZRCXVrQnwqowBZ00Q@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:bpf/bpf-next/master 244/254]
 kernel/bpf/verifier.c:13499:47: sparse: sparse: cast from restricted gfp_t
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 11:58 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/master
> head:   7ada3787e91c89b0aa7abf47682e8e587b855c13
> commit: b00fa38a9c1cba044a32a601b49a55a18ed719d1 [244/254] bpf: Enable non-atomic allocations in local storage
> config: csky-randconfig-s032-20220320 (https://download.01.org/0day-ci/archive/20220321/202203211432.Fx74gYS9-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/ammarfaizi2/linux-block/commit/b00fa38a9c1cba044a32a601b49a55a18ed719d1
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block bpf/bpf-next/master
>         git checkout b00fa38a9c1cba044a32a601b49a55a18ed719d1
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash kernel/bpf/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
> >> kernel/bpf/verifier.c:13499:47: sparse: sparse: cast from restricted gfp_t
>    kernel/bpf/verifier.c:13501:47: sparse: sparse: cast from restricted gfp_t
>    kernel/bpf/verifier.c:13746:38: sparse: sparse: subtraction of functions? Share your drugs
>    kernel/bpf/verifier.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
>    arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: cast removes address space '__user' of expression
>    arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: asm output is not an lvalue
>    arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: cast removes address space '__user' of expression
>    arch/csky/include/asm/uaccess.h:121:17: sparse: sparse: generating address of non-lvalue (11)
>    kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
>    include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
>
> vim +13499 kernel/bpf/verifier.c
>
>  13236
[...]
>  13485                          new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  13486                          if (!new_prog)
>  13487                                  return -ENOMEM;
>  13488
>  13489                          delta    += cnt - 1;
>  13490                          env->prog = prog = new_prog;
>  13491                          insn      = new_prog->insnsi + i + delta;
>  13492                          goto patch_call_imm;
>  13493                  }
>  13494
>  13495                  if (insn->imm == BPF_FUNC_task_storage_get ||
>  13496                      insn->imm == BPF_FUNC_sk_storage_get ||
>  13497                      insn->imm == BPF_FUNC_inode_storage_get) {
>  13498                          if (env->prog->aux->sleepable)
>  13499                                  insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_KERNEL);
>  13500                          else
>  13501                                  insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_ATOMIC);

Sorry for causing this, I will submit a fix.

>  13502                          insn_buf[1] = *insn;
>  13503                          cnt = 2;
>  13504
>  13505                          new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  13506                          if (!new_prog)
>  13507                                  return -ENOMEM;
>  13508
[...]
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
