Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38674577693
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiGQOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGQOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:06:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F72113E2F;
        Sun, 17 Jul 2022 07:06:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b2so6955706plx.7;
        Sun, 17 Jul 2022 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdbURAzaMtVKAm64U+lquu3tOi67fTVfwC/Ylbpg1cc=;
        b=ICV9hw4EtODKZGQv3rQMabyMNI88qatQoPnBFoz3hXBRGPb5h+t6FJmb83wHfYCx/F
         SQyaaArLuXR8ClHqfk0nFBTF+ThgI1G2PqM097KhhdvNTAAbmfGmE9XCsK9wFPPNYBfU
         O94dGiu9pW7XWSKWKHiTGiFByaJL9BxImdtcSSzwRVweasBXif+yw1rMpf9SAtcY6POC
         /Ow44OdOJzFZMsacPGE3T53UlutIXEF7a/NM36SEurCvz3ZGx7Abi9m0HV9gs+e32hEa
         bvMS7sLFSb9Y7XaCbzzFLMhTQyVGjimMmJh9qWILeFM29lF/d7mXfayd8H41HtfZlE/+
         gS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdbURAzaMtVKAm64U+lquu3tOi67fTVfwC/Ylbpg1cc=;
        b=68PY/l70mpLvZ1EAz+x/QDoFlgDbyhR8Cor/6xV6TqIKfAYcxuvuykKZmgr0DAmfPP
         gOf9bJCBZ9pDqGminzPmZaNh4xVDTZuch08ws7YKHesSmqmCfHVnWU83RM/yynTeNHCl
         kP4oZ/n2i0qzWdPLoKdVtRjchckyq9Sdm4pX3i0qShQ0dY7FBjQJcpOj7k0fr0WZvtJ5
         3EjKkDECf+sLZxhQc0XquPt5keSc9FbV6cuapsSWGQmWRlXwRelwvWCl/0ChVNhBlyba
         uWFwecQKoMjXMrQrq0x3x57UwrLlY9J5WK0AN5VI7e5FH6jQ8EHwifjD56HXf39mNLzE
         Nq5w==
X-Gm-Message-State: AJIora+u8pozTeTA0sn3EnBhzLyqi84AzJXyyAOBCjPG3duC/sfoHww8
        QcwL8ba7QjdhRHFPlz/kQOPGdQgbHVbBpj2dcPo=
X-Google-Smtp-Source: AGRyM1t17yxrUlssmp+E4vMnncQfhmMUXO1Ek8ekp/27kHZbCuwzkR1qoKrvES0/x9uWPZoyBZKwMIYDojiwt5K/U2s=
X-Received: by 2002:a17:90a:bc04:b0:1f0:506d:78b9 with SMTP id
 w4-20020a17090abc0400b001f0506d78b9mr27489758pjr.4.1658066762846; Sun, 17 Jul
 2022 07:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
 <20220705210143.315151-5-emil.renner.berthing@canonical.com> <20220717105754.GE14285@duo.ucw.cz>
In-Reply-To: <20220717105754.GE14285@duo.ucw.cz>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Sun, 17 Jul 2022 16:05:51 +0200
Message-ID: <CANBLGcw=jM4r5+UY5RZsf9zHdG7ga83hN2DnCvCcpdQGnWaY8g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] riscv: dts: sifive unmatched: Add PWM controlled LEDs
To:     Pavel Machek <pavel@ucw.cz>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 at 12:59, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2022-07-05 23:01:43, Emil Renner Berthing wrote:
> > This adds the two PWM controlled LEDs to the HiFive Unmatched device
> > tree. D12 is just a regular green diode, but D2 is an RGB diode with 3
> > PWM inputs controlling the three different colours.
> >
> > Signed-off-by: Emil Renner Berthing
> <emil.renner.berthing@canonical.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> (This is dts change, I'd rather not take it through the LED tree).

Makes sense. Palmer, will you consider this?

/Emil
> Best regards,
>                                                         Pavel
>
> --
> People of Russia, stop Putin before his war on Ukraine escalates.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
