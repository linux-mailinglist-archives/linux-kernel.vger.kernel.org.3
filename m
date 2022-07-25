Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A357FF62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiGYM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiGYM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:56:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB14E10555
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:56:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h16so5634674ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=K1ITrs/3nl+xE/Yfbk4CyeI9gLu4fBlugQ+Op18RwEo=;
        b=Viks4IIRJYdGaRdNNhZJSS4QCZuro1vO5jXzwN1XMWCzk1AhqLIHLomoCiKA3REMQ3
         7Y3RUhcK0DcpGy8C9t0AwgJ5DPii3RP7ZKCBbp9bwJGbuBoC93nYqDdI9KmkucZel15H
         tomJCRRcJd+f93KkHYrlArxcw3p+xT+wOAXHIxlNm6/G8MQH0aY53XIv12kisSjKQvjg
         +zSkL28kOhwo/5mQNmOPDrmOnf4dUCoGsdtWNIJPjAisx2JSk2vaB5MC9+3wZFQrcRTx
         2BIAW0DcAmfL2As8NYMPBsGkqX4xuvNdUXoBt/D+A37peS9DDUdXV+X0LNh0++NCW+wd
         F0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=K1ITrs/3nl+xE/Yfbk4CyeI9gLu4fBlugQ+Op18RwEo=;
        b=hGXfTTtflNI453spWmhB+j9pei1ntkhY4nMPVrokEIDaxHB7Hs9PmPb7mvvMnvHg/m
         giOsewi/dDCHdYyiXCSyayUda8Eh2dRBGwZbONDUeEAaKtjIK1jptltQtRHQX1NWarSZ
         r0EenBFiM0hdU6hUbRCEB+5XePRjA/lxxreW9fBkWXLmWtmt3FePTpk1pL7hMY30dfU4
         blzlKBprKcG4kGiwn+K+VSHiND9vfnYrW268pTTe2S1X7OtE+dnMp/iajNEDoHLpqO+o
         FGcffhTpPtQnWO+ldBBCEBopzBgLSskWqPOePteFPJAbymdinVZx8u3vfe+EE6v6tBoZ
         KSXQ==
X-Gm-Message-State: AJIora9IrqKRYDQwCaoIg5J5IZwuiTvSVEzvrgH6AIWrGw48HBTu5QB/
        pu3dIJzpkYR4p5ZYVcXYXE1SlHMOGyDpfqsDXDKJQaubWHQ=
X-Google-Smtp-Source: AGRyM1vBocogFaFMH9Nn76ZCf7M9CDbj/72EYSch43BB45BGaZcEKULKqnXG3r3yDb+RaNFjwOZAoES1GtbgPZijIno=
X-Received: by 2002:a05:6e02:1e04:b0:2dd:46f6:87ae with SMTP id
 g4-20020a056e021e0400b002dd46f687aemr2398727ila.36.1658753772107; Mon, 25 Jul
 2022 05:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-2-huangjie.albert@bytedance.com> <Yt6GPsWcG9iWHBUg@zx2c4.com>
In-Reply-To: <Yt6GPsWcG9iWHBUg@zx2c4.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 20:56:00 +0800
Message-ID: <CABKxMyMAaVzCZRmqFR_S9o4n0aeonxXZZGAn9ef27NcwWeC=6g@mail.gmail.com>
Subject: Fwd: [External] Re: [PATCH 1/4] kexec: reuse crash kernel reserved
 memory for normal kexec
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Jason A. Donenfeld <Jason@zx2c4.com>
Date: 2022=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 20:02
Subject: [External] Re: [PATCH 1/4] kexec: reuse crash kernel reserved
memory for normal kexec
To: Albert Huang <huangjie.albert@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
<dave.hansen@linux.intel.com>, <x86@kernel.org>, H. Peter Anvin
<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Masahiro
Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
Nick Desaulniers <ndesaulniers@google.com>, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com>, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>, Michael Roth
<michael.roth@amd.com>, Nathan Chancellor <nathan@kernel.org>, Ard
Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>, Mark
Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
Sean Christopherson <seanjc@google.com>, Kees Cook
<keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
<kexec@lists.infradead.org>, <linux-kbuild@vger.kernel.org>


Hi Albert,

On Mon, Jul 25, 2022 at 04:38:53PM +0800, Albert Huang wrote:
> The kexec userspace tool also needs to add parameter options(-r) that
> support the use of reserved memory (see another patch for kexec)
>
> [...]
>
> -     if (kexec_on_panic) {
> +     if (kexec_on_panic && kexec_on_reserved) {

Two small questions related to this:

- Why does kexec-tools need an option, or more specifically, why does
  userspace need to communicate about this at all? Can't the kernel just
  automatically use the available reserved memory in the case that's not
  already being used by the panic handler kernel? I'm curious about
  whether there are caveats that would make this occasionally
  undesirable, hence suggesting an option.

- I don't totally understand how this works, so I might be a bit off
  here, but is there any chance that this could be made to co-exist with
  kexec_on_panic? Can a larger region just be reserved, specifically for
  this, rather than piggy backing on the panic handler region?

> +static struct page *kimage_alloc_reserverd_control_pages(struct kimage *=
image,
> +     case KEXEC_TYPE_RESERVED_MEM:
> +             pages =3D kimage_alloc_reserverd_control_pages(image, order=
);

Nit:
  reserverd -> reserved

Jason
