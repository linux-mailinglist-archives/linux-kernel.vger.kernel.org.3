Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3614F5047
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841114AbiDFBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457611AbiDEQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:17:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3052193D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:15:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so5503150pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6FUWFiiYF7RQM6AiZGZcmbxOr+8HtS1WpPnaUZsigro=;
        b=BTCrh4EKdaMDmASfvS4ew7BfBRsBgAtjr3IHlo839Gs+uNJL1JaNgY7v+7hWAxfY3l
         JN6DJshYDWPdzucQ0JkmFgrUmhoNFfJi73bCsveF0oWuFRP7ZaRXxVcx2MyGXEHBvcqr
         ezLUNEkIkWuxApp/dOzuZHu9vzWAhReBDPZbNvhL60twYPz0hc25qbW/Cgif/u1Y2Bey
         PFaiizHMBpyTQJeQxq7a9EHoXAw6vbOcXzeuNAH9O6dn555WunwPMGVXih/B0i1WNkF8
         JKObM6m7yVDL2I0mUfdRK16YlqWP6DY4csOafI7oq9eqeQjOy3Cx7zy5zk/TfjfOOHiP
         KGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6FUWFiiYF7RQM6AiZGZcmbxOr+8HtS1WpPnaUZsigro=;
        b=wtKBwd69OhUNwXNCwgGVza798SaPwSZyzeenImbPS/8CYaq5eF7RC27KOtDGV3Kba/
         HaRdmPzNX8WLfeX6JOi46S/+nP+XQWeBGRWq1eik9EAUvv+67AD3JBviEZ6bF1DZVIcX
         g/C9yZBB++JGB9NdQM8E3y7rjx6EgV/fbt4lct6g5guxVWHYoq7hZTJX40aSdWmA/hU+
         kAT2yL95iey0Wky4KispZBEv0aei5W/3vKld/p+lU2cqwrnGi256h2hEnzjGEA0hWnLm
         3r+jHzUpemi1Y7yMpdpbBX5Gy8mktfNp1m2WB/imnhjGiDBOixjcPNKoOJDMhLa6hdSy
         zI0A==
X-Gm-Message-State: AOAM533d9JWZg7uT/EwsSXBq4/OvxVaysFWN3g+xaccmrADptvYMfPvI
        +JigJTyncPU85or8WOatptA0VQ==
X-Google-Smtp-Source: ABdhPJxBsrRDDTM9H+4owE4Y81jBgCK2c5EsTHBBhVbKGNYldNMxrnBlnlMtBkUyZFupsZRuHzSSYg==
X-Received: by 2002:a63:6443:0:b0:399:54fe:5184 with SMTP id y64-20020a636443000000b0039954fe5184mr3478339pgb.511.1649175302141;
        Tue, 05 Apr 2022 09:15:02 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l192-20020a6391c9000000b003861d9431c7sm13808252pge.62.2022.04.05.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:15:01 -0700 (PDT)
Date:   Tue, 05 Apr 2022 09:15:01 -0700 (PDT)
X-Google-Original-Date: Tue, 05 Apr 2022 09:14:59 PDT (-0700)
Subject:     Re: [next] riscv: Linux next-20220404 riscv defconfig builds failed.
In-Reply-To: <CAJF2gTQkGZnwXrXsbx8drL0AicVpOMW=JmOcrieuvyEf91XPhg@mail.gmail.com>
CC:     nathan@kernel.org, naresh.kamboju@linaro.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        guoren@linux.alibaba.com, heiko@sntech.de,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org
Message-ID: <mhng-cfa7bfb9-bab8-423c-85ad-ecd407d6e806@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Apr 2022 22:17:24 PDT (-0700), guoren@kernel.org wrote:
> On Tue, Apr 5, 2022 at 12:57 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Mon, Apr 04, 2022 at 03:28:41PM +0530, Naresh Kamboju wrote:
>> > Linux next-20220404 riscv defconfig builds failed.
>> >
>> > Regressions found on riscv:
>> >    - riscv-riscv-clang-14-defconfig
>> >    - riscv-riscv-gcc-10-defconfig
>> >    - riscv-riscv-clang-13-defconfig
>> >    - riscv-riscv-clang-12-defconfig
>> >    - riscv-riscv-clang-11-defconfig
>> >    - riscv-riscv-gcc-11-defconfig
>> >    - riscv-riscv-gcc-8-defconfig
>> >    - riscv-riscv-gcc-9-defconfig
>> >    - riscv-riscv-clang-nightly-defconfig
>> >
>> >
>> > arch/riscv/kernel/compat_signal.c:7:10: fatal error:
>> > linux/tracehook.h: No such file or directory
>> >   7 | #include <linux/tracehook.h>
>> >     |          ^~~~~~~~~~~~~~~~~~~
>> > compilation terminated.
>> > make[3]: *** [scripts/Makefile.build:289:
>> > arch/riscv/kernel/compat_signal.o] Error 1
>>
>> For what it's worth, I also see:
>>
>> $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- defconfig all
>> arch/riscv/kernel/compat_vdso/compat_vdso.lds.S:3:10: fatal error: ../vdso/vdso.lds.S: No such file or directory
>>     3 | #include <../vdso/vdso.lds.S>
>>       |          ^~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[2]: *** [scripts/Makefile.build:462: arch/riscv/kernel/compat_vdso/compat_vdso.lds] Error 1
>> arch/riscv/kernel/compat_vdso/rt_sigreturn.S:3:10: fatal error: ../vdso/rt_sigreturn.S: No such file or directory
>>     3 | #include <../vdso/rt_sigreturn.S>
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> arch/riscv/kernel/compat_vdso/note.S:3:10: fatal error: ../vdso/note.S: No such file or directory
>>     3 | #include <../vdso/note.S>
>>       |          ^~~~~~~~~~~~~~~~
>> compilation terminated.
>> arch/riscv/kernel/compat_vdso/getcpu.S:3:10: fatal error: ../vdso/getcpu.S: No such file or directory
>>     3 | #include <../vdso/getcpu.S>
>>       |          ^~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/rt_sigreturn.o] Error 1
>> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/note.o] Error 1
>> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/getcpu.o] Error 1
>> arch/riscv/kernel/compat_vdso/flush_icache.S:3:10: fatal error: ../vdso/flush_icache.S: No such file or directory
>>     3 | #include <../vdso/flush_icache.S>
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/flush_icache.o] Error 1
>>
>> I am guessing this code was never tested with $(srctree) == $(objtree).
> Thx for pointing it out:
> I always use:
> make -skj"$(nproc)" ARCH=riscv
> CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g
> O=../build-riscv/ defconfig all
>
> When I change to:
> make -skj"$(nproc)" ARCH=riscv
> CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g defconfig
> all
>
> I got your problem.

Just to be clear: this one wasn't supposed to go in via the csky tree, 
and had other build issues that were being found by the autobuilders 
(which is why it hadn't gone in via the riscv tree).  I do in-tree 
builds somewhat regularly so that probably would have caught it if 
nothing else did, but my guess is that some other autobuilder would have 
found it first (some of the earlier patches 

Guo: please stop pushing things to linux-next that break the builds 
and/or aren't aimed at your tree.  This just makes things unnecessarly 
complicated.  If you don't want to deal with the build issues that's OK, 
just LMK when you send the patch sets out and I'll deal with them, but 
having linux-next's build break causes fallout for a lot of users.
