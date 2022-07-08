Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560956C3BC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiGHUHJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jul 2022 16:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiGHUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:07:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82B1834D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:07:06 -0700 (PDT)
Received: from mail-yw1-f169.google.com ([209.85.128.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTzrW-1o1l1O2puM-00R3zl for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022
 22:07:04 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c8a1e9e33so155916807b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:07:04 -0700 (PDT)
X-Gm-Message-State: AJIora/kB7/6W2p5hgMwK7dbuVwX4S0lOPQPVkGyCL+0UVvc4Jb/rjFC
        nTi4tzqK8JabFPUVneemlNlupITE2cPJDsfU4go=
X-Google-Smtp-Source: AGRyM1u/OY34ZLqd24Cd7bFbPrMeX+gUQNJgY4utEEdog9FiPcqprCN4MUal9h9VGtW98t7Qp9Y8dgyN45Miasvtu+I=
X-Received: by 2002:a81:1e4d:0:b0:31c:86f1:95b1 with SMTP id
 e74-20020a811e4d000000b0031c86f195b1mr5836069ywe.42.1657310823467; Fri, 08
 Jul 2022 13:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
 <20220704131358.fy3z7tjcmk2m6pfh@pali> <20220708171422.mpbhb4ejarwnce6m@pali>
In-Reply-To: <20220708171422.mpbhb4ejarwnce6m@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Jul 2022 22:06:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qzes1rXJDKF_6j0-KeB5V4M7ZMeHRrNk-KOQwA0vVEw@mail.gmail.com>
Message-ID: <CAK8P3a0qzes1rXJDKF_6j0-KeB5V4M7ZMeHRrNk-KOQwA0vVEw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:H3NOEu+5t9YhSB4kTsIwXt/bg9agYQjgwLuzuEbGK9YHUKuNGkY
 wVkEGSOkN31XJv7gf30UBI98N921xKickq5V0WUOJm920Ps326har9t3ByiDi383NL1kfhL
 Zn7zUC/4ooCy/BQN2uqvH2mDqf1B0YZkZU+tYRMU3hJ+wVeOVguEpmIzKGYJe3wcTv+slwI
 pkY5MuHPqVTWIb8WKHUhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r/Z5kexBaWA=:uBWvnG7EXWfIadohdx34lZ
 63TD+/EPlEqez/FQ6Bq+n56JHPofv4UjTMFgweTJioPPJwvNKVxg0ZN04ol6huYRped9I1frK
 WJsYXUyvRGencx/x0efefJyVI4Z0M/6oxhlgiLkixZaW3htx/0cVkLF2xGwc9UAX6RYEuFrWf
 NaQAEpN9P8F2dkF+2tvslD/qkUfPSbkvgskcU/w61CrKJCOQln+qYdUcBRamLymEuJAKwcKM9
 NM4fMOFTuSiDWUA2hPqUNtBxqnpG/qVcw8O6xpfBIrwfJ3P83Pd5xNiKBc4cyWkCbvgqdf0iU
 XLk3JSYR9VQI1KSjV4r1HSptXypxg1/sFUSS3PBFcgbTk6JpO8MxhNfRG6Jbi1Xmkb3WjKDMY
 ZYGnw6CC8atXhfN8lnQC2Z7/RjzPecWZQxa8Bi2KeQqFTU6agva4p8e4p7Ush2s4DRzeNMubz
 BF1cRiPSZShXZyMtwpVAdT/nvq3++yqw9xFPxeEdc8goSJ/0enh3mASurqH5WnDHLoG+8VI4Y
 KMUa2EOculRNMlna6xTmPEAZxkJdTUTy19AXHcvDElrR0wW552KXYfIoRFj7z9pnavUlk38vQ
 5m6uCaIDn1wP7T1eFStFFjPNODTM/siAtuMaRFS7qpxjA6KP9PqZDMmuqomlAce24P5SX6uF/
 XBrMo56iaG0KubuBTbvPOs/5GTQnNK0UUJO3dgvASorwfdkuOMn5eLrFj0jXlhkLMP6HAuQ8j
 w8aoVrpi/uZDg75b4tVKXSg5pWlQv7lz2A8zA1mPiHJdjNHqyxM2JEDov2ye06Hcb519RIH/H
 EhYWeiI1o++tFK0034XE1OUHbfGKGKjPT98n59VSX92PwMxwb3gaQcBW9EkGQwo4T2oRak+Vw
 fdXWuAguEjL+/AQKYAtw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 7:14 PM Pali Rohár <pali@kernel.org> wrote:
>
> -ifeq ($(HAS_BIARCH),y)
> -ifeq ($(CROSS32_COMPILE),)
> -ifdef CONFIG_PPC32
> -# These options will be overridden by any -mcpu option that the CPU
> -# or platform code sets later on the command line, but they are needed
> -# to set a sane 32-bit cpu target for the 64-bit cross compiler which
> -# may default to the wrong ISA.
> -KBUILD_CFLAGS          += -mcpu=powerpc
> -KBUILD_AFLAGS          += -mcpu=powerpc
> -endif
> -endif

I think to remove these, we first need to ensure that /some/ option is
set for any of
the CPU options.
>
> -ifdef CONFIG_PPC32
> -ifdef CONFIG_PPC_E500MC
> -CFLAGS-y += $(call cc-option,-mcpu=e500mc,-mcpu=powerpc)
> -else
> +CFLAGS-$(CONFIG_PPC_E500MC) += $(call cc-option,-mcpu=e500mc,-mcpu=powerpc)
>  CFLAGS-$(CONFIG_E500) += $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
> -endif
> -endif
>

And this part will not do what you want because CONFIG_PPC_E500MC is only
set when CONFIG_E500 is also set, so the -mcpu=e500mc option always
gets overridden by -mcpu=8540

         Arnd
