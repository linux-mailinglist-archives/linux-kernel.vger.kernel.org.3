Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041EB4F1F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiDDWvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiDDWvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:51:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E368860AB3;
        Mon,  4 Apr 2022 15:04:23 -0700 (PDT)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MD5fd-1njz7M38Cn-009C2u; Tue, 05 Apr 2022 00:04:21 +0200
Received: by mail-wr1-f52.google.com with SMTP id d3so5744377wrb.7;
        Mon, 04 Apr 2022 15:04:21 -0700 (PDT)
X-Gm-Message-State: AOAM533QYF+EyWTSfyR8ZiDNfwEG+BhLFmBlNEZSpZN6IHOzlOEcS2Xz
        7UM4LdInLrK6AQeCHtIxWDqunivIu7cRtSViggE=
X-Google-Smtp-Source: ABdhPJxdB4SXEExhGLOnNOou5PzL8CTbrHl2NxdVHZQrrPYcJQIoUaGDfpVns8hWsOV0sMm8eIe8VQFd/8q9TF2PhCI=
X-Received: by 2002:adf:cd02:0:b0:206:ff2:236 with SMTP id w2-20020adfcd02000000b002060ff20236mr254545wrm.192.1649109861434;
 Mon, 04 Apr 2022 15:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
 <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
 <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com> <PH0PR84MB1718925AA3C8FA998C486D7C88E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB1718925AA3C8FA998C486D7C88E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Apr 2022 00:02:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3RSST6yvv8Oy13RFd6eZ6cS5yX9TOuK6wxXKUO-qdQ=Q@mail.gmail.com>
Message-ID: <CAK8P3a3RSST6yvv8Oy13RFd6eZ6cS5yX9TOuK6wxXKUO-qdQ=Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5mTdGkH/49wqOo83wH+vgQVSb0gA/5UG3vD+/btypz62HoNOEGM
 kx3NCgQlGT5qR0EfyLQUU54zAdqX1dqWIY++F2lw4OXnYvIi3QZtLa3h7FNADk73m54HPr8
 gHsJBnEwWPfhIJj1gKUH9QoaLd5+k1cCDJOrgLwoyFPt8wfRx0GFcSE/iehSEKUxZNnR2uB
 qTat294ukRn9bFlKYWUFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4SWwC7ut8s=:L1ttrIkbRe2fOl4oXOy+YD
 9Jh4orANoVF+dc6ZUffgwzHoi1UoXHzAowT3QvYzu2T+l4YOZdpjcjVLxLYeXdlSmrj5rYZNj
 q6C5nTmFENHhJGZj47TUcTPPKZLlAq+fN581y8XdIxCLDF0RBBsw4PuUZM0PdRLtWPQrYpTTj
 pZyP6D9IZgCMkxAm0EWJryIyg9xX5L/TV0bqzlKviICl9k1CizcaA1tXlhs9Zj6lAKhgcvtoU
 bfQHSkswd2wyMM84EmLIq+ctAYnJ/B2xKMCUniSY3uF2HKj4Ggq7zUxxCX1VoPD4dMyoqh/C3
 4i0XlibTzoko5PI8env/1uk3JVTAypSsa0rK9gtz+UhRyht1IT5AnjSxX0XP36ez9KVyTV08v
 +xIaGzNK9WoYMh/5iyzmcTVs02MKeWLgoZHeVYUghgOGlUbkxsnxppZaIVQxhmgIPcQS8ZpRN
 S3waWSJl9Ig3wM0yz51TVsdX6I6XUpkNY5N9JpsQ+pAqXl2iGiRqngyDk7EnQRDusphtJSRZw
 Vt/CCWxmwhZ1P4FQj6c9MO+Km2WCI8LEidVmTq+jev70JVSQcC0zdcRMr25Hiyb/a/sj27Y/i
 qYbYcrckJBtunXVseQQjpzP/pupsybjiZ/aOC2VabHQIiZoPWmFeaePIgKjOPW8bG4fWpT9K/
 ziumd4ohmDNMduGDYF6IyZB1UVnpxsLo9/stlcS1xPVH/O+o8u4Hx5v8t+Zws1u8L/gw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 10:22 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> > > I would put it into drivers/clocksource/, I don't think drivers/mtd would be any better, but there is a chance that the clocksource maintainers don't want to have the watchdog code in their tree.
>
> While trying to discover how to creating two devices in one driver I ran across an interesting .dtsi and I was wondering if this would be a valid approach for my situation as well. The pertinent files are:
> 1) drivers/clocksource/timer-digicolor.c
> 2) arch/arm/boot/dts/cx92755.dtsi
> 3) drivers/watchdog/digicolor_wdt.c
>
> Here they are just sharing the same register area:
>
> timer@f0000fc0 {
>         compatible = "cnxt,cx92755-timer";
>         reg = <0xf0000fc0 0x40>;
>         interrupts = <19>, <31>, <34>, <35>, <52>, <53>, <54>, <55>;
>         clocks = <&main_clk>;
> };
>
> rtc@f0000c30 {
>         compatible = "cnxt,cx92755-rtc";
>         reg = <0xf0000c30 0x18>;
>         interrupts = <25>;
> };
>
> watchdog@f0000fc0 {
>         compatible = "cnxt,cx92755-wdt";
>         reg = <0xf0000fc0 0x8>;
>         clocks = <&main_clk>;
>         timeout-sec = <15>;
> };

Right, it is possible to make this work, but it's not recommended, and you have
to work around the sanity checks in the code that try to keep you from doing it
wrong, as well as any tooling that tries to check for these in the DT.

         Arnd
