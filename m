Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B4548078
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiFMHQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiFMHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:16:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D91A824;
        Mon, 13 Jun 2022 00:16:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a29so7429112lfk.2;
        Mon, 13 Jun 2022 00:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buxqDOApbU3iWiCJpKcyX6L2RFQXu0xedhgWabGDF/Y=;
        b=GAKALYciW0y2QOTLFrqdt7PBg3TAA5HKJHXgZLsLCiOxWXd1xx2sO5wooqJdzGdLxd
         HKLQByqKQf++zSSKLpVSQEHbxACET4DJIhjto+PQrW8MIGNBA1l22fAq8zAu5a0gYI42
         x49q6Nj7VXy4LhTWhE87qw3gqinxJZ6SeTuKwP/cqPdBa3dpFnUp4r81VYTGKOYpPuPg
         a/PybB/saG8GpU7r9IQn/Zod6zYdvwPBsGpMS6DLGdSV6xF6ihlk3w8KtUTvMITMPFUy
         OvmOoDt4OXc2f1Gg1OoBM4Ad+/a/Pxpz3DN2+Jw+NY5Z/MY39gWzafDnmeFs+tOMGzK4
         EZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buxqDOApbU3iWiCJpKcyX6L2RFQXu0xedhgWabGDF/Y=;
        b=a6y+3LnOsT+cNSzT80DC4NYBt9Qgnv9i9Kf0TaqJZ/606WzzKvcQAGpSXuUN+fQkOd
         NfOPmrQEUOZDpIYEdrPp+yB7bpohI1Bo9xtA8CiuXMNZ6VUh0osGv2zEQqZby2IEszk+
         N1e6QnmwtXMefPAMgmKyEBrUI0MOHNi+1FD0KIKt0F47+fBSiPqdFTrs/XD4sjGH4dna
         9ooQRKXE7AxeJOLhhoA2ZPIxketHv7xvmmanpQ0HiJsUmZjv6dteyFkfY3ra2ZwCWAI8
         XhmMjZaug1T26zLY4kpKcgGbOVbN3PtPmoXuB0KLnQQpz68lasOU0LnEJLAjqZSQ5Dda
         p64Q==
X-Gm-Message-State: AOAM531rFL5yycWp6xbcRS6R2e5VOHzCZX3lbD+hDydB+6vXsNx+SIaq
        N67qFo4FaGrOsTu6tL7BVfv67ipIs3jh5jHt5SQ=
X-Google-Smtp-Source: ABdhPJztUvaIJiyyz/qpSniEl7gEI70W2eqQCEj/oJAsctZd0PsOvAXKEMDSh3jw4ZyybkEAkZuB+NDScf1ujTsP6Jc=
X-Received: by 2002:a05:6512:1052:b0:479:1f92:13b4 with SMTP id
 c18-20020a056512105200b004791f9213b4mr27626523lfb.200.1655104604518; Mon, 13
 Jun 2022 00:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-12-tmaimon77@gmail.com>
 <91549b70-08fc-ed6f-c48e-5bcb70ea63d0@linaro.org> <CAP6Zq1j2VZno4w4w0QCYwHnRaVqiM=DnNSmND1vOGDs_wfi2zw@mail.gmail.com>
 <8e02ad54-5dad-aee7-6fa8-70c72f93bf5e@linaro.org>
In-Reply-To: <8e02ad54-5dad-aee7-6fa8-70c72f93bf5e@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 13 Jun 2022 10:16:33 +0300
Message-ID: <CAP6Zq1j2FgMmX9NJRoDMCsRLnF0RTETSTuMv8rEhr3FGLvY7yw@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] reset: npcm: using syscon instead of device data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

I will make sure to add backward compatibility in the reset driver in
the next version.

Thanks,

Tomer


On Fri, 10 Jun 2022 at 12:53, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/06/2022 23:37, Tomer Maimon wrote:
> > Hi Krzysztof
> >
> > Sorry but I didn't ignore your comment.
> >
> > For not breaking exciting boards I add the following patch in V2
> > https://lore.kernel.org/linux-arm-kernel/20220608095623.22327-11-tmaimon77@gmail.com/
>
> No, it does not solve it.
> 1. Patchset goes via separate trees (DTS are always separate), so it is
> not bisectable. One of the branches/trees will have broken DTS.
>
> 2. All out of tree DTSes are broken. This is expressed as ABI and - with
> some reasonable exceptions - you should not break it.
> https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/ABI.rst
>
> You have to keep backwards compatibility, so parse/handle both versions
> of DTS.
>
>
> Best regards,
> Krzysztof
