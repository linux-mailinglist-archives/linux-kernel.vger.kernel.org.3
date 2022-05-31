Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCD539960
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348320AbiEaWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiEaWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:09:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD865712D8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:09:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t13so62202ljd.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWlLDjn8/4W4ntBv+o1Od3JuYjF6btG4WNnGzsI36yw=;
        b=IKHI2dejgyftlbdjsFTfFoHITHjSnAOxwD9js1qS/uigKcj4u5cGgok7Ag+LU8zORl
         RaHiVTb+Xwe22KqNgHFGLScZZ3g6ilQ8ixj7JPTr3zWVKEhTJxeCQromJdVWCN+XfgXI
         rmo5eGSG/SYDUrRqN1Z4i+CQEbsmG9AnvLDhan0NfPTfHVug47UBQUpVsGxwL1VIphI/
         QTaGk2e30dGTx7a2vs6E4J6m4ILskPXAps/SlkyyPBuVY9VLNO3kTx9SpNe4tiyRMbmc
         bmJ+KTYruA8wOBE+Em7qoAwYwFuG1HqXMu1R7gbxqBAltkKtQpLA/XIxexKOAMVHT4n2
         9vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWlLDjn8/4W4ntBv+o1Od3JuYjF6btG4WNnGzsI36yw=;
        b=33LdkbQynFYjkwn/ev6uIRyHw0qXfpOw16I9BfIBlGV7sldkwPNAuwuDT55oAHqUen
         UXME3VQUs9JNDPtJg9lQ89ccHeee7CsKkIeV1jz+mdCYwqKKswQuSFSWq/rjQ4VrCX6E
         O9Ca339O8Fq3HjLDqzWwWFog7fOrrs+KIO3EmaSDDMBewMQhSfTkp7uu/IbwFHW1g85o
         kYvFLzXR6t9uWffwqqy5PYr6m7cfcEly0XP4ONujch56uLkxBCB43k0u8x0p2BRB5xDm
         m5WRdsFQ0LRT8TKbeP7E5/owsGeM0mypy9yiwYM0tRmkivHS0Hh17XKyFNqW/8Tv7M7+
         chNw==
X-Gm-Message-State: AOAM5336viQEF24bM3c2EKAaW6GctpuEyEzPnMffV9etsA788sFEEuyy
        TAfcIP+goccPngqlf7TMzozDfOOvI1uk/q92gA5jyg==
X-Google-Smtp-Source: ABdhPJzYLbxMehiXCrUfUjsL0pdvtolkZKiSmTujycK02Fq36HdGiHd6Tm0RRTrJeu6i03Ub5TiaDg6HQSVhigkTExQ=
X-Received: by 2002:a2e:6d12:0:b0:253:e3b9:a56e with SMTP id
 i18-20020a2e6d12000000b00253e3b9a56emr28977673ljc.103.1654034941643; Tue, 31
 May 2022 15:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
 <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X> <CAEQFVGYSV=boBYGHfJLis8ayftzNPJy1UYgeEEQLuNb0hSfhjg@mail.gmail.com>
In-Reply-To: <CAEQFVGYSV=boBYGHfJLis8ayftzNPJy1UYgeEEQLuNb0hSfhjg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 May 2022 15:08:50 -0700
Message-ID: <CAKwvOd=c=9xbzg0CjGxNnHtu3BOatWpe0gYQU7TWw0rkjwCCxA@mail.gmail.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
To:     Mauro Rossi <issor.oruam@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, luto@kernel.org,
        Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 10:52 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
>
>
>
> On Mon, May 9, 2022 at 2:07 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Sat, May 07, 2022 at 02:19:00PM +0200, Mauro Rossi wrote:
>> > > > Alternatively, you could apply the hack that Nick inserted into Android
>> > > > for this issue if upgrading your toolchain or turning off the integrated
>> > > > assembler is not possible:
>> > > >
>> > > > https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae
>> > > >
>> > > > I really do not mean to sound dismissive or rude, I apologize if it
>> > > > comes off that way, but we have worked quite hard to avoid inserting
>> > > > unnecessary workarounds, as they are ultimately technical debt that can
>> > > > be hard to manage over the long term.
>> > > >
>> > > > Cheers,
>> > > > Nathan
>> > >
>> > > Thanks a lot Nathan
>> > >
>> > > It is definitely the clang version 11.0.x which is not updated in aosp
>> > > Android 11 production tags
>> > >
>> > > I will use Nick's workaround which works since only lsl %rax, %rax is
>> > > currently happening
>> > >
>> > > Many thanks, problem solved
>> >
>> > Hello,
>> > I'm back again because I was assuming that Nick's workaround was working ok,
>> > but I have found that ARCH=x86_64 i.e. 64bit built kernel is causing
>> > an immediate hard reboot at initrd execution,
>> > just after hitting [ENTER] at grub/efi menu.
>>
>> It looks like there was a follow up fix for that workaround, maybe that
>> resolves this issue as well?
>>
>> https://android.googlesource.com/kernel/common/+/cc7f7a84191f5defc2ea4633eeea4acb4486b549
>>
>> > ARCh=x86 i.e. 32bit kernel binary is not affected, but is Nick's
>> > workaround targeting 32 bit kernel builds?
>>
>> No, the file that the build error originates from (entry_64.S) is only
>> built on x86_64.
>>
>> > How do aosp android-mailine kernels avoid this instantaneous hard reboot issue?
>>
>> That hack was reverted once the toolchain was upgraded:
>>
>> https://android.googlesource.com/kernel/common/+/ff0216d09fd31802537f2d1702ec2f3e9be73aa3
>> https://android.googlesource.com/kernel/common/+/3c2c8d8f7f2639e319212d10cb8df5bd13098dae
>>
>> Cheers,
>> Nathan
>
>
> Hello,
>
> sorry i still have the issue when building with hack "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL"
> I'd just like to understand why I get instant reboot in 64bit kernel built with LLVM_IAS=1

As Nathan noted, I messed up the commit "ANDROID: x86: entry: work
around LLVM_IAS=1 bug in LSL". Please see:
https://android-review.googlesource.com/c/kernel/common/+/1521061
https://android-review.googlesource.com/c/kernel/common/+/1560152/

If you're using an older toolchain, you'll need just the first. If
you're using a newer toolchain, you'll need BOTH (or none, including
dropping "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL").

>
> I searched for the places where #include "calling.h" is used
>
> utente@utente-3TB:~/r-x86_kernel/kernel$ grep -r \#include\ \"calling
> arch/x86/entry/thunk_64.S:#include "calling.h"
> arch/x86/entry/entry_32.S:#include "calling.h"
> arch/x86/entry/entry_64_compat.S:#include "calling.h"
> arch/x86/entry/entry_64.S:#include "calling.h"
>
> Probably the hardcoding done in the hack is impacting some other asm target built in 64 bit kernel and causes a wrong X86 instruction , is there a way to refine the #if to avoid that problem while still building with LLVM_IAS=1 ?
>
> Thanks for the info
> Mauro
>
>


-- 
Thanks,
~Nick Desaulniers
