Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1A5364BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353646AbiE0PcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbiE0PcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:32:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6603135C;
        Fri, 27 May 2022 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653665522;
        bh=fN1wYZy3lHxIJiNwWgRP1ApjPFsbIYaTQuKvY28Zwt8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AN6nJ7zzaYBcXaLAQn7DQST8hK/gMUZGb+pwpGVk70Zo+/TX7Dno+ZKZmxsEhsvhN
         pDFZcWzRc80QyCdCuC/tvFGIk2yCoxaMQ00j3OD/Nn3732xcMJCEkodjZ1hLbgWE7Z
         xnrDSaMATKBC+NVI56uCqeGzOE42hnMLom7STQZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.1]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1njNXd46fI-016Nlv; Fri, 27
 May 2022 17:32:02 +0200
Message-ID: <133bcb8b-2321-6acb-ea2d-3ab82af19dcb@gmx.de>
Date:   Fri, 27 May 2022 17:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] parisc: fix the exit status of arch/parisc/nm
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20220527143931.2161635-1-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220527143931.2161635-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FLBQI4ghatwHNirJ8c0Hby2zOE78Lnu4VoJ2Xenyuztgzjr8bxU
 TnDBQBM/CktMZ8AunH+0IrDHra912U6C3a0OUK83i85XquC671hMIz/ccwjgA/E1yZZYH8+
 RNU0nqgEXm2TFcZZ+CRLtTfyT5nn5LIKZqpFGc+InD3lIgkvhZ5Cp2xsX8/LTIVLZs9C+VO
 eHmmEebiLQeu2lDN7XUeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yP2dvxbRDes=:Plb7CwDoc4a6sjHibpw3WF
 BuNtLCHhr3hGmqUd0S7OM+AG859+HtKoXOhSufKyG82Dh57FunU7G8bgMhOY/5q8DmRyYNPtK
 /clbqqkG4xh8waPIkVMHkP5xpnzxj8oWnpyLsOZN3zu0QHDlgNTraEj8/Jy4tvFEkEtFDhlG/
 olbrRorkdB3BWY1maStbcO7LU66E7QP3z9KwFT1d+gF2/JVj8dQuiAN5GQVd36hmCIknaNaIG
 sl5YcjwYb21Unl8AIGHBpiQM1LOBVnpFsqiRbXWgvXFaMWGzJs1ev9v07+S6FAv873socfiMQ
 8vdmmWMGhKe0YcrT3vQ2U1cxQ8mezHppF5Ys3/RJmERq1lbFxaNgOWgHx91rsnFd5ED0+l96j
 R0Sq5cn0qsg9207eHmPC/FdzM8sV6kTf5cH3EiMW9zxH9Xsl2qWthxSZKFAMv9S5cNmY50keF
 SSh0JLf9G6OGkJhuDoblu9epqKet+ikaS/LvIvabOreejgbr0iVCtj9sVvewUy/IuS2n3NtlC
 YWfjJNWc2G6lGyd4B3ewqrDYHw6YpCcWfetZ55J1x66EFButk6ECQiElAU01SucOs7JKUozDc
 KckzQs5xqNV71EcebYKAf6FlxvcUhejCgNmRyQEqBGBpRv6wjNJUY36s0dVKWhmTiIfh56Tvy
 zbe0EO70qXwFK0pmAYm+4rhXABrDNB8+kHIYME/0r9X4Jgvl+lxqt7sLd9mBJ1WAzOS//Swpm
 dbuDn+gOJGkva0NNa3nVtUwMG5OevOionuZpTPBRtz5Q8r44OxsY1UMTVjs+fBMmjK0W7ZVDK
 ypFJA9s6ui7IsUXBRiaxJnDqlTZEtGrQWLwBCSK09GvO2nLFvF8xhLaHeYX1gokZv4cSZ1Mdu
 WP+0dxrH7FkcStBWAFGIedZtM9zMtCrOp/jL9+2c73GDNv6QO9z3f5tl8OwDdJaEYkO7umvFD
 Dbw2yiL8EPUHKcB4F+InRwoHSXKwZmjB6+Gq6RozLrn2x/Juo42wDLsBQMHRW9yAWN6JPJQJF
 Q7AKtLpZOERTPGNptOcSvcF2MfDD1IbJ2dc/HCoUR3OuTg/ZhCWdPluVGpWQc+OYJGbc6rSFl
 dJQ6w8++3H5ifna4h4YmlMrqkYonb5FQWtbvpmSWiSoWT2VEafuX4/YiA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 16:39, Masahiro Yamada wrote:
> Parisc overrides 'nm' with a shell script. I was hit by a false-positive
> error of $(NM) because this script returns the exit code of grep instead
> of ${CROSS_COMPILE}nm. (grep exits with 1 if no lines were selected)
>
> I tried to fix it, but in the code review, Helge suggested to remove it
> entirely. [1]
>
> This script was added in 2003. [2]
>
> Presumably, it was a workaround for old toolchains (but even the parisc
> maintainer does not know the detail any more).
>
> Hopefully recent tools should work fine.
>
> [1]: https://lore.kernel.org/all/1c12cd26-d8aa-4498-f4c0-29478b9578fe@gm=
x.de/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git=
/commit/?id=3D36eaa6e4c0e0b6950136b956b72fd08155b92ca3
>
> Suggested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Thank you!
Helge

> ---
>
> I want to apply this to kbuild tree with Helge's Ack
>
>  arch/parisc/Makefile | 1 -
>  arch/parisc/nm       | 6 ------
>  2 files changed, 7 deletions(-)
>  delete mode 100644 arch/parisc/nm
>
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index aca1710fd658..e38d993d87f2 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -18,7 +18,6 @@
>  boot :=3D arch/parisc/boot
>  KBUILD_IMAGE :=3D $(boot)/bzImage
>
> -NM		=3D sh $(srctree)/arch/parisc/nm
>  CHECKFLAGS	+=3D -D__hppa__=3D1
>
>  ifdef CONFIG_64BIT
> diff --git a/arch/parisc/nm b/arch/parisc/nm
> deleted file mode 100644
> index c788308de33f..000000000000
> --- a/arch/parisc/nm
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#!/bin/sh
> -##
> -# Hack to have an nm which removes the local symbols.  We also rely
> -# on this nm being hidden out of the ordinarily executable path
> -##
> -${CROSS_COMPILE}nm $* | grep -v '.LC*[0-9]*$'

