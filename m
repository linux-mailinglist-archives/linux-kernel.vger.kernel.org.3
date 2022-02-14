Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67C4B4236
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiBNG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiBNG5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:57:37 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F0575F4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:57:29 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v63so16123307ybv.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/c7eW+jp5n/u8fBKOifBe+KsFh5ubV24/pYgdvLharI=;
        b=iLBOrWP23AaiZ6szz/4afr0kvAjeA8ArJQwY5E0wu6tI6yM6f6qBJ25zGq2UkpO/gA
         IyttSAehmsyj8QBZDI08vux3L1eIunYHav/MWmtLg/VRbGE7J5EEkfc30CMlkXrmTBXD
         ATIllqKM7XIxQXjpyBiKH2sbLaK4MwKV56NLj4gSRPIQhYmrkDWF8wma2piTi3bEXhZQ
         d7Gs/Atg75USEMBNjbve+2w76KhLhXWJTDJrxBwOfIJoQFXP50+UNUeCs8BvKT7H2Ypz
         G/NusOLq7IndpArNcOL+1DwWarBZpkYcJdb0ozJVho2kkhd/0QqNWLlRIbIf1qcIsQiE
         QRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/c7eW+jp5n/u8fBKOifBe+KsFh5ubV24/pYgdvLharI=;
        b=uOGOhB3oKvTy2JT8JbwxRCwjEUc5E8Qa7PBOfRvOBtmpP+AW6cHxLAWzuurL4el8cM
         nQycSMKeqAFs7GnWX+tPUn0f3+kFNMxr6AMj+SyIFdHr05kg9r8k3VbcBw/zuT4mj4aB
         FohyVo0fo4u/zzJsxuN5WrjdGtS4H3AyhOnaw1RVjJLia5s8I8Uj6D/u6jCo36swbL+5
         i8DtS/vUZl1sMZQxfXMznjGo0Ev+DUoGTDenKADkneVsiBfu6AXYLL+UP3fzTzG8sige
         +Urge+1T8aUC0N3vYfOHi3cznZejyR7YMkTQHUYwO3HH314B9AQ+TG+0AMgSiyLFOZIk
         tEnw==
X-Gm-Message-State: AOAM531eGCIbk1k6y4xhAZeCUuE1UGi8AGvbNPHQItMysC7a6PD2WykL
        OrHsdU9dEsqF/YI53I/eHRG8x4UQvmgXa0Vt2ViFUmvrk8PkXg==
X-Google-Smtp-Source: ABdhPJz9byRxxGRGC9v9WTDoYHdOcy8LfGvH2M73frhaCqdcAJmP97YDGEDp0kF6hv8WYq6wNwylJDopbtd4sKq+Ipc=
X-Received: by 2002:a25:bc81:: with SMTP id e1mr11232234ybk.553.1644821848330;
 Sun, 13 Feb 2022 22:57:28 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Feb 2022 12:27:17 +0530
Message-ID: <CA+G9fYtR+E52X-ucmvXYG5-9v0q2UEXQsML=nkQRnSf7TwXYqw@mail.gmail.com>
Subject: arm64: clang-nightly: net/ipv4/tcp_input.c: clang: error: clang
 frontend command failed with exit code 139
To:     open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux mainline master branch with arm64 clang-nightly build failed
due to following errors and warnings.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current LLVM=1 LLVM_IAS=1
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- HOSTCC=clang CC=clang
PLEASE submit a bug report to
https://github.com/llvm/llvm-project/issues/ and include the crash
backtrace, preprocessed source, and associated run script.
Stack dump:
0. Program arguments: clang -Wp,-MMD,net/ipv4/.tcp_input.o.d -nostdinc
-I/builds/linux/arch/arm64/include -I./arch/arm64/include/generated
-I/builds/linux/include -I./include
-I/builds/linux/arch/arm64/include/uapi
-I./arch/arm64/include/generated/uapi -I/builds/linux/include/uapi
-I./include/generated/uapi -include
/builds/linux/include/linux/compiler-version.h -include
/builds/linux/include/linux/kconfig.h -include
/builds/linux/include/linux/compiler_types.h -D__KERNEL__
-mlittle-endian -DCC_USING_PATCHABLE_FUNCTION_ENTRY
-DKASAN_SHADOW_SCALE_SHIFT= -Qunused-arguments
-fmacro-prefix-map=/builds/linux/= -Wall -Wundef
-Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-PIE
-Werror=implicit-function-declaration -Werror=implicit-int
-Werror=return-type -Wno-format-security -std=gnu89
--target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=1 -Wno-psabi
-fno-asynchronous-unwind-tables -fno-unwind-tables
-mbranch-protection=pac-ret+leaf+bti -Wa,-march=armv8.5-a
-DARM64_ASM_ARCH=\"armv8.5-a\" -DKASAN_SHADOW_SCALE_SHIFT=
-fno-delete-null-pointer-checks -Wno-frame-address
-Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
-fstack-protector-strong -Wimplicit-fallthrough -Wno-gnu
-mno-global-merge -Wno-unused-but-set-variable
-Wno-unused-const-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -ftrivial-auto-var-init=zero
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
-fno-stack-clash-protection -fpatchable-function-entry=2
-Wdeclaration-after-statement -Wvla -Wno-pointer-sign
-Wcast-function-type -Wno-array-bounds -fno-strict-overflow
-fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types
-Wno-initializer-overrides -Wno-format -Wno-sign-compare
-Wno-format-zero-length -Wno-pointer-to-enum-cast
-Wno-tautological-constant-out-of-range-compare -Wno-unaligned-access
-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0
-mstack-protector-guard-offset=1408 -I /builds/linux/net/ipv4 -I
./net/ipv4 -DKBUILD_MODFILE=\"net/ipv4/tcp_input\"
-DKBUILD_BASENAME=\"tcp_input\" -DKBUILD_MODNAME=\"tcp_input\"
-D__KBUILD_MODNAME=kmod_tcp_input -c -o net/ipv4/tcp_input.o
/builds/linux/net/ipv4/tcp_input.c
1. <eof> parser at end of file
2. Code generation
3. Running pass 'Function Pass Manager' on module
'/builds/linux/net/ipv4/tcp_input.c'.
4. Running pass 'Live Interval Analysis' on function '@tcp_ack'
 #0 0x00007fcc9438ce91 llvm::sys::PrintStackTrace(llvm::raw_ostream&,
int) (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xe93e91)
 #1 0x00007fcc9438abee llvm::sys::RunSignalHandlers()
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xe91bee)
 #2 0x00007fcc9438c260 llvm::sys::CleanupOnSignal(unsigned long)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xe93260)
 #3 0x00007fcc942b4e0f (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xdbbe0f)
 #4 0x00007fcc9d729140 __restore_rt
(/lib/x86_64-linux-gnu/libpthread.so.0+0x14140)
 #5 0x00007fcc9467bebb (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x1182ebb)
 #6 0x00007fcc9467b274
llvm::ConnectedVNInfoEqClasses::Distribute(llvm::LiveInterval&,
llvm::LiveInterval**, llvm::MachineRegisterInfo&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x1182274)
 #7 0x00007fcc9466ef85
llvm::LiveIntervals::splitSeparateComponents(llvm::LiveInterval&,
llvm::SmallVectorImpl<llvm::LiveInterval*>&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x1175f85)
 #8 0x00007fcc9466d914 llvm::LiveIntervals::computeVirtRegs()
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x1174914)
 #9 0x00007fcc9466d4f2
llvm::LiveIntervals::runOnMachineFunction(llvm::MachineFunction&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x11744f2)
#10 0x00007fcc9471247d
llvm::MachineFunctionPass::runOnFunction(llvm::Function&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x121947d)
#11 0x00007fcc944c749f
llvm::FPPassManager::runOnFunction(llvm::Function&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xfce49f)
#12 0x00007fcc944ce9a3 llvm::FPPassManager::runOnModule(llvm::Module&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xfd59a3)
#13 0x00007fcc944c8026
llvm::legacy::PassManagerImpl::run(llvm::Module&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xfcf026)
#14 0x00007fcc9b71896b
clang::EmitBackendOutput(clang::DiagnosticsEngine&,
clang::HeaderSearchOptions const&, clang::CodeGenOptions const&,
clang::TargetOptions const&, clang::LangOptions const&,
llvm::StringRef, llvm::Module*, clang::BackendAction,
std::unique_ptr<llvm::raw_pwrite_stream,
std::default_delete<llvm::raw_pwrite_stream> >)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x18a296b)
#15 0x00007fcc9ba5ecb1 (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x1be8cb1)
#16 0x00007fcc9a8af994 clang::ParseAST(clang::Sema&, bool, bool)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0xa39994)
#17 0x00007fcc9ba5b001 clang::CodeGenAction::ExecuteAction()
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x1be5001)
#18 0x00007fcc9c3fc1b7 clang::FrontendAction::Execute()
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x25861b7)
#19 0x00007fcc9c3541d6
clang::CompilerInstance::ExecuteAction(clang::FrontendAction&)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x24de1d6)
#20 0x00007fcc9c475c3a
clang::ExecuteCompilerInvocation(clang::CompilerInstance*)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x25ffc3a)
#21 0x0000000000413e1e cc1_main(llvm::ArrayRef<char const*>, char
const*, void*) (/usr/lib/llvm-15/bin/clang+0x413e1e)
#22 0x000000000041209b (/usr/lib/llvm-15/bin/clang+0x41209b)
#23 0x00007fcc9bfd65a2 (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x21605a2)
#24 0x00007fcc942b4b7d
llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xdbbb7d)
#25 0x00007fcc9bfd6090
clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef>
>, std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*, bool*) const
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2160090)
#26 0x00007fcc9bf9dac3
clang::driver::Compilation::ExecuteCommand(clang::driver::Command
const&, clang::driver::Command const*&) const
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2127ac3)
#27 0x00007fcc9bf9dd4a
clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
>&) const (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2127d4a)
#28 0x00007fcc9bfb7917
clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
>&) (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2141917)
#29 0x0000000000411b06 main (/usr/lib/llvm-15/bin/clang+0x411b06)
#30 0x00007fcc9302dd0a __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x26d0a)
#31 0x000000000040ef9a _start (/usr/lib/llvm-15/bin/clang+0x40ef9a)
clang: error: clang frontend command failed with exit code 139 (use -v
to see invocation)
Debian clang version
15.0.0-++20220212071827+2e57156fead3-1~exp1~20220212071918.154
Target: aarch64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin
clang: note: diagnostic msg:
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/tcp_input-24e82f.c
clang: note: diagnostic msg: /tmp/tcp_input-24e82f.sh
clang: note: diagnostic msg:

********************
make[3]: *** [/builds/linux/scripts/Makefile.build:288:
net/ipv4/tcp_input.o] Error 139
PLEASE submit a bug report to
https://github.com/llvm/llvm-project/issues/ and include the crash
backtrace, preprocessed source, and associated run script.
Stack dump:
0. Program arguments: clang -Wp,-MMD,net/ipv4/.tcp_minisocks.o.d
-nostdinc -I/builds/linux/arch/arm64/include
-I./arch/arm64/include/generated -I/builds/linux/include -I./include
-I/builds/linux/arch/arm64/include/uapi
-I./arch/arm64/include/generated/uapi -I/builds/linux/include/uapi
-I./include/generated/uapi -include
/builds/linux/include/linux/compiler-version.h -include
/builds/linux/include/linux/kconfig.h -include
/builds/linux/include/linux/compiler_types.h -D__KERNEL__
-mlittle-endian -DCC_USING_PATCHABLE_FUNCTION_ENTRY
-DKASAN_SHADOW_SCALE_SHIFT= -Qunused-arguments
-fmacro-prefix-map=/builds/linux/= -Wall -Wundef
-Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-PIE
-Werror=implicit-function-declaration -Werror=implicit-int
-Werror=return-type -Wno-format-security -std=gnu89
--target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=1 -Wno-psabi
-fno-asynchronous-unwind-tables -fno-unwind-tables
-mbranch-protection=pac-ret+leaf+bti -Wa,-march=armv8.5-a
-DARM64_ASM_ARCH=\"armv8.5-a\" -DKASAN_SHADOW_SCALE_SHIFT=
-fno-delete-null-pointer-checks -Wno-frame-address
-Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
-fstack-protector-strong -Wimplicit-fallthrough -Wno-gnu
-mno-global-merge -Wno-unused-but-set-variable
-Wno-unused-const-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -ftrivial-auto-var-init=zero
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
-fno-stack-clash-protection -fpatchable-function-entry=2
-Wdeclaration-after-statement -Wvla -Wno-pointer-sign
-Wcast-function-type -Wno-array-bounds -fno-strict-overflow
-fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types
-Wno-initializer-overrides -Wno-format -Wno-sign-compare
-Wno-format-zero-length -Wno-pointer-to-enum-cast
-Wno-tautological-constant-out-of-range-compare -Wno-unaligned-access
-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0
-mstack-protector-guard-offset=1408 -I /builds/linux/net/ipv4 -I
./net/ipv4 -DKBUILD_MODFILE=\"net/ipv4/tcp_minisocks\"
-DKBUILD_BASENAME=\"tcp_minisocks\" -DKBUILD_MODNAME=\"tcp_minisocks\"
-D__KBUILD_MODNAME=kmod_tcp_minisocks -c -o net/ipv4/tcp_minisocks.o
/builds/linux/net/ipv4/tcp_minisocks.c
1. <eof> parser at end of file
2. Code generation
3. Running pass 'Function Pass Manager' on module
'/builds/linux/net/ipv4/tcp_minisocks.c'.
4. Running pass 'Simple Register Coalescing' on function
'@tcp_timewait_state_process'
 #0 0x00007f394a236e91 llvm::sys::PrintStackTrace(llvm::raw_ostream&,
int) (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xe93e91)
 #1 0x00007f394a234bee llvm::sys::RunSignalHandlers()
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xe91bee)
 #2 0x00007f394a236260 llvm::sys::CleanupOnSignal(unsigned long)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xe93260)
 #3 0x00007f394a15ee0f (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xdbbe0f)
 #4 0x00007f39535d3140 __restore_rt
(/lib/x86_64-linux-gnu/libpthread.so.0+0x14140)
 #5 0x00007f394a5220b5 llvm::LiveRange::join(llvm::LiveRange&, int
const*, int const*, llvm::SmallVectorImpl<llvm::VNInfo*>&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x117f0b5)
 #6 0x00007f394a74a8db (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x13a78db)
 #7 0x00007f394a7467ed (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x13a37ed)
 #8 0x00007f394a7441dd (/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x13a11dd)
 #9 0x00007f394a5bc47d
llvm::MachineFunctionPass::runOnFunction(llvm::Function&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0x121947d)
#10 0x00007f394a37149f
llvm::FPPassManager::runOnFunction(llvm::Function&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xfce49f)
#11 0x00007f394a3789a3 llvm::FPPassManager::runOnModule(llvm::Module&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xfd59a3)
#12 0x00007f394a372026
llvm::legacy::PassManagerImpl::run(llvm::Module&)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xfcf026)
#13 0x00007f39515c296b
clang::EmitBackendOutput(clang::DiagnosticsEngine&,
clang::HeaderSearchOptions const&, clang::CodeGenOptions const&,
clang::TargetOptions const&, clang::LangOptions const&,
llvm::StringRef, llvm::Module*, clang::BackendAction,
std::unique_ptr<llvm::raw_pwrite_stream,
std::default_delete<llvm::raw_pwrite_stream> >)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x18a296b)
#14 0x00007f3951908cb1 (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x1be8cb1)
#15 0x00007f3950759994 clang::ParseAST(clang::Sema&, bool, bool)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0xa39994)
#16 0x00007f3951905001 clang::CodeGenAction::ExecuteAction()
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x1be5001)
#17 0x00007f39522a61b7 clang::FrontendAction::Execute()
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x25861b7)
#18 0x00007f39521fe1d6
clang::CompilerInstance::ExecuteAction(clang::FrontendAction&)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x24de1d6)
#19 0x00007f395231fc3a
clang::ExecuteCompilerInvocation(clang::CompilerInstance*)
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x25ffc3a)
#20 0x0000000000413e1e cc1_main(llvm::ArrayRef<char const*>, char
const*, void*) (/usr/lib/llvm-15/bin/clang+0x413e1e)
#21 0x000000000041209b (/usr/lib/llvm-15/bin/clang+0x41209b)
#22 0x00007f3951e805a2 (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x21605a2)
#23 0x00007f394a15eb7d
llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>)
(/usr/lib/x86_64-linux-gnu/libLLVM-15.so.1+0xdbbb7d)
#24 0x00007f3951e80090
clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef>
>, std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >*, bool*) const
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2160090)
#25 0x00007f3951e47ac3
clang::driver::Compilation::ExecuteCommand(clang::driver::Command
const&, clang::driver::Command const*&) const
(/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2127ac3)
#26 0x00007f3951e47d4a
clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
>&) const (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2127d4a)
#27 0x00007f3951e61917
clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&,
llvm::SmallVectorImpl<std::pair<int, clang::driver::Command const*>
>&) (/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15+0x2141917)
#28 0x0000000000411b06 main (/usr/lib/llvm-15/bin/clang+0x411b06)
#29 0x00007f3948ed7d0a __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x26d0a)
#30 0x000000000040ef9a _start (/usr/lib/llvm-15/bin/clang+0x40ef9a)
clang: error: clang frontend command failed with exit code 139 (use -v
to see invocation)
Debian clang version
15.0.0-++20220212071827+2e57156fead3-1~exp1~20220212071918.154
Target: aarch64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin
clang: note: diagnostic msg:
********************

build log link:
https://builds.tuxbuild.com/254TFZPxjU105HfmOmS9Rac9sEO/
Kconfig: https://builds.tuxbuild.com/254TFZPxjU105HfmOmS9Rac9sEO/config
toolchain: clang-nightly

I have reported this a new issues on github,
https://github.com/llvm/llvm-project/issues/53811

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
