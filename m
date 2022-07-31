Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006B585EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiGaLiW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 31 Jul 2022 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiGaLiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:38:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E2FD35
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:38:17 -0700 (PDT)
Received: from mail-ej1-f43.google.com ([209.85.218.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mk0FS-1ncPex2FEO-00kSfk for <linux-kernel@vger.kernel.org>; Sun, 31 Jul
 2022 13:38:15 +0200
Received: by mail-ej1-f43.google.com with SMTP id kb8so1045265ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:38:15 -0700 (PDT)
X-Gm-Message-State: AJIora9WaM+/Y4zyka4T5zIjF0n+toENMlPo9NvI7zuq/LA2xRec/apt
        JaleL3Pf5DFUOvaoiC7iB1/ZSjq0ldABE/C5Bo4=
X-Google-Smtp-Source: AGRyM1t3/5wqhwFBxAeCzRWtdyPpsj0PRugfkaLqwuDbaTwGFKZ6Ot/jeHrwA5uHlzVI8z6oF4Vwpd6o0N9eTjpKsGI=
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id
 zd7-20020a17090698c700b0072b20fe807dmr9053696ejb.75.1659267495137; Sun, 31
 Jul 2022 04:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220730003846.1730265-1-balsup@cisco.com> <CAK8P3a0Bn9xKRX9z369zVCy6CuguTvNbtXOOPbf_OfS697cDyQ@mail.gmail.com>
 <D7DCF238-0AE9-44A0-86B1-8C731FF8BB59@cisco.com>
In-Reply-To: <D7DCF238-0AE9-44A0-86B1-8C731FF8BB59@cisco.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 31 Jul 2022 13:37:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1QOU+kSJo04zga8S-tHatJ3WNQBCR1Nxa10Ux1qNYb4A@mail.gmail.com>
Message-ID: <CAK8P3a1QOU+kSJo04zga8S-tHatJ3WNQBCR1Nxa10Ux1qNYb4A@mail.gmail.com>
Subject: Re: [PATCH] Allow configuration of ARCH_NR_GPIO
To:     "Billie Alsup (balsup)" <balsup@cisco.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nick.hawkins@hpe.com" <nick.hawkins@hpe.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Ovcc8J40VXun/oA0WjZ6fDGZ1wmc2eqg/MT0wUCvRv1Bx5lGQGh
 j3pZ3lhOECdaJOVnM45/Lh4kW7QgfWMTlDcAHvUAkAYHRLwHEMbg1EFmup59Y1PkkV3Yi+D
 iLQFv/PldI3bnZ9BOEZFbTOjZFsSfBy5mDXT89bzIY91PePnt0/iQ2SfT86JLDjHlTE16zB
 eK/HQU6NEsV0zQPx1DXNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mMQnVveC3K4=:n9EOsEZmj8f57PBI2Z8ZZp
 Fmx/4tGRQiJsA+EmvBpJvwhW7B7YFj+91B3y84tDC1v8mCxSJZJuJOO0uC8SWJrsP9i8yWRwC
 AJZGM6PzjNBoNV6boMmaxFXkaD1qcoL8FZZFLKWZX3m9s5spPgZdOvtWVCZPtXNsIPy814h7T
 U9vjhPb2PHc9aZkaGhTyHg4qfp+ELRYveM67Zi0b0nO115log1eXB4/5oQCwZQbaDsIFqOfA6
 CMEPPIvo9H6J5eF+8wJroaMTQzlqkAdH6M+sTYOtzdP7CVhiCtplWUryR1SFVdkH7Tah/ubU7
 CD/IM+ZH98Q59wmdxUSHBIIKHTillZ5eoNLnkuHAgnf7ytFv5A9TINP5voIPhnz/jFfMK6gg2
 UAqb8X0mMTT1396hQRg1ELZqy3IcsyUrkgXx+XAfDjsTEnl7UMr4cxujM2lLK5D1/QB0mJUiF
 j0A4iF0+x1wV37W+Uu/1YNFs55hs6VI1eZzptYLUaYrMLx7bB8JpOF28PMe+VM3m93Bh/okBn
 aVAUnh1BH4vMcauGtPWpkWm4J5IySgB9yb+3Yyq5NV6BK6t/cGXJgnfZV9Y0dm/XNPdtSSB7O
 wqNpICMIsgpyMhJEfqzinhIYdR85asinlVAykux9DSDUJibxLttKqkEayrPNLvsEfzd+ZHGUD
 0JZHFA1mnO483SCiIMEra7iWrs751BvmkXWumIQ+cbDGXEw5RFE3xegzMVRbtePhwvG8tmnTa
 QvZd1uB7XrRfazj0pk0OJ5FzpMfZDLEStKiBXLhVThVbMhTb01I9jrtuD8pmCUv8NVt2BJKtY
 fkTyPZfXrMk/3Yg7n8RFqOkKZ/obIWZHalAgI2k+y8/itTU33RE9Ff1ByqX8er9hIkYFJnC2a
 7hb/i2FXJaWkAU4Rt09g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 12:33 AM Billie Alsup (balsup) <balsup@cisco.com> wrote:
>   >On 7/30/22, 4:54 AM, "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>   >What is the use case for manually setting this rather than deriving
>   >it from the selected platforms?
>
> A Cisco GPIO IP block supports 1022 pins.  A single FPGA can support
> multiple GPIO IP blocks (although typically 1 or 2).  A system may
> have two or three FPGAs directly accessible through the PCI bus, and
> an additional 8 to 36 FPGAS accessible through alternate means (e.g.,
> SLPC, i2c, or a proprietary point-to-point bus).  Although typically
> the full set of pins is not used, in total, it is very easy to exceed
> the limit.  Previous patches have simply bumped up the number, and I
> thought a more generic approach that would solve the use case for
> customer devices would be more appropriate.  I am also trying to keep
> the ARM and X86 implementations similar, as the devices are
> accessible from both an ARM-based BMC as well as an X86 type CPU.

It would be nice to keep it consistent between the major architectures,
at least arm64, powerpc, mips and riscv in addition to the two you already
have.

One way we could do this is to keep the existing
CONFIG_ARCH_NR_GPIO for on-chip GPIOs, and then add
a new Kconfig option for extra GPIOs on things like PCI cards or
programmable logic.

>  It is desirable to use the same kernel configuration for multiple
> products, even though the number of FPGAS, and therefore the number
> of supported GPIO pins can vary.  Such is also the case for Open NOS
> environments, such as SONiC and FBOSS, which attempt to use a single
> kernel configuration across multiple (multi-vendor) products. A
> platform specific option would not seem to work in such cases.
> Ideally, I would like to see this configuration knob go away
> completely, but that might be a more complicated and controversial
> change.  It is not used in very many places, but the problematic use
> is within the inline function gpio_is_valid.

I think the plan for making the option obsolete is to convert every user
of the legacy GPIO interface to use GPIO descriptors, which don't
have the limitation and don't need gpio_is_valid().

In your use case, can you identify a set of drivers that need access
to old-style GPIO numbers above the hardcoded on-chip numbers?
Maybe we can prioritize fixing those drivers.

>   >Have you tried to use both a platform-specific option for the minimum
>   >number of this setting, and then restictricting the
>   >CONFIG_ARCH_NR_GPIO
>   >setting with a 'range' statement?
>
> I have not tried a platform specific option, as we would need to
> choose the worst case platform for such a configuration (in order to
> share a kernel build across products), but this in turn may conflict
> with the chosen platform for some other “worst-case” setting of
> another variable.  It seems prudent to simply allow the kernel
> builder to choose the options they want.  This is just one example
> where the configuration is not directly available to the kernel
> builder, but must be set indirectly.  We have other configuration
> options that cannot be set directly, and instead require us to enable
> an unrelated (from a product standpoint) configuration item purely
> for the side-effect of enabling such an option.  CONFIG_ARCH_NR_GPIO
> is a similar issue, where you choose a platform to indirectly set the
> value, but that value really needs to be configurable by the builder.
> The last such patch for X86 simply bumped up the number.  I thought
> it better to simply allow configuration.  I have no issue with
> restricting the value to a minimum, if that is a worry.

I have no problem with allowing a kernel build to use larger values
than the default, I'm just worried that allowing smaller values than what
we know is needed for the existing platforms can break distro kernels
that have to work across many machines.

        Arnd
