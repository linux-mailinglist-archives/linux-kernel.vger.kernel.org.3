Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FE514110
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiD2DOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiD2DOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:14:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA05AEEC;
        Thu, 28 Apr 2022 20:11:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y21so7599985edo.2;
        Thu, 28 Apr 2022 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5yWxeiyZ6vHx0drNR9JwHfUkwjBMQSY8QqadvukEfwo=;
        b=jeQ3TCZ0/gj2lnmdW2fhqoGTawDk3i4GCN3vXTiT+0iSfV8yZdnI26cWcoSlq3kwnF
         BL+gG4+ZMdbtd6Io7j6m8BiV/kcc9Z77ki8RmMBLTjyFBdQlvKUMTmaI9Yer7tMvLYh0
         GFr2/N1T5l0RZBBeAzlDue8SnQHfyvYy4XTiIVrN34gt4cfqhV/nYPSzvjC9ROfEeUyM
         ZWeNAoun0YBiSNoA1iv1wNtgzg5oJsQmEZF4OivfTBJ1x01blC2EEGx1C3PyUw0rr5EM
         o8HHCk0LWsWR812DGo3HzkGl2U7hJ9kK+ELFCcefERK4xsZmO/EPOK2myQYyvEDoW3q3
         BDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5yWxeiyZ6vHx0drNR9JwHfUkwjBMQSY8QqadvukEfwo=;
        b=AX4l03wp9u3jzA3ZbGDf69ZT1+5z672vJN8AB1wgpo+TUnMNKaAUarL1XGvcLCfv7S
         IQFm6Mck6d05DdVxl5aTsoPpunj0ekpqIciBL4Y9YfbbrXnSzh2ef9wP6ix8GgQX/e/t
         9IQbc2aI4eBD+7zxV98EqPq2yq+wQ9awxRe4hvcl/ZDSOv7Z9XFMzLdga3l+MOMbX5ny
         gQBg9XCSse3cMcOY29WA61UzT1Fx9zeHbiJvs6hzQKUzZZ0/eqFZv/IxRAiwjMnUVdnH
         RoQanvB+5X81Gw3dvYBGfjOPOTCZQOvzs+eQTn+5lF4Umh1vxJRRsN1V6ntJJO31SrCg
         v3mg==
X-Gm-Message-State: AOAM5332OwCx0K3BKC0inFYA9AkDtY5SFgcsKbMvGTYYzEQ8gV/v3msf
        5fMCel5KAebmRNTB+0ag3IlQ7g6TO9apHbQMgPS6x+AvSb0=
X-Google-Smtp-Source: ABdhPJzH6EEzbaWRN8GzVwz7rn/mesI6PKlonYuijCERccP1Kmoyd7e/MHif4gpALhNeHBqFD2Hh5nt83WTDnSGhx8M=
X-Received: by 2002:a50:954b:0:b0:41a:c9cb:8778 with SMTP id
 v11-20020a50954b000000b0041ac9cb8778mr39073565eda.165.1651201861778; Thu, 28
 Apr 2022 20:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220426083259.526685-1-starzhangzsd@gmail.com>
 <alpine.DEB.2.21.2204270130210.9383@angie.orcam.me.uk> <CANubcdWwHXqC4gUztNseoConYHp+G4nUSYFaO-Te3jFVqT=1sw@mail.gmail.com>
 <alpine.DEB.2.21.2204271156190.9383@angie.orcam.me.uk> <CANubcdUPQJcJ=dryJGsnQLhjcTouLUARD-GwCd7UjurUm+-GXg@mail.gmail.com>
 <alpine.DEB.2.21.2204280951510.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204280951510.9383@angie.orcam.me.uk>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Fri, 29 Apr 2022 11:10:25 +0800
Message-ID: <CANubcdXSHpV8xOBidXksMt+kLQ=jgNer4uisKbV5z9zxHp8dMw@mail.gmail.com>
Subject: Re: [PATCH] arch/mips/kernel/traps: add CONFIG_MIPS_FP_SUPPORT when
 using handle_fpe
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Joshua Kinard <kumba@gentoo.org>, liam.howlett@oracle.com,
        ebiederm@xmission.com, dbueso@suse.de, alobakin@pm.me,
        f.fainelli@gmail.com, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2022=E5=B9=B44=E6=9C=8828=E6=
=97=A5=E5=91=A8=E5=9B=9B 17:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 28 Apr 2022, Stephen Zhang wrote:
>  Thanks.
>
>  The bug is in arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h,
> which has:
>
> #define cpu_has_fpu                     1
>
> (and similarly arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h).
> This is not supported, as noted in arch/mips/include/asm/cpu-features.h:
>
> /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  *=
/
>
> Perhaps we should explicitly undefine `cpu_has_fpu' if set to 1?
>
>   Maciej

Thanks for your detailed explanation and suggestion. I will make a v2 patch=
.
