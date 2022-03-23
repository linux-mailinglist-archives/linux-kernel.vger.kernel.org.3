Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1C4E4E17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbiCWIWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiCWIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:22:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F08A75201;
        Wed, 23 Mar 2022 01:21:09 -0700 (PDT)
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1M4p-1oCHeB1LRL-012mDR; Wed, 23 Mar 2022 09:21:08 +0100
Received: by mail-wm1-f46.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so480665wmp.5;
        Wed, 23 Mar 2022 01:21:08 -0700 (PDT)
X-Gm-Message-State: AOAM533GJ09L3LVWERS8Y48wrgahB+HbdO4fkNbMYx8hFRPs96NdXn8z
        /wqApL5m66evneso+dKoS8dRj2oVZ+gHHo76QUk=
X-Google-Smtp-Source: ABdhPJzZaEXlOkd+esyGRakeaMwED9DToYdSxV9NNtJQVS/LaQNhwvFQWaJyk53MNgkII5DhV1C2fpJBh5AycjwaHOQ=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr7911838wmc.94.1648023667977; Wed, 23
 Mar 2022 01:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647928315.git.qinjian@cqplus1.com> <8372ee2fcf361a3af7233450c4403178052ceee2.1647928316.git.qinjian@cqplus1.com>
 <CAK8P3a1H2xM1PdDwKPWHD0fqZ0q_o-KZTLvSXdm9jjqTWcX-hA@mail.gmail.com> <d79dd7655c964f88a58d8bf403da39be@cqplus1.com>
In-Reply-To: <d79dd7655c964f88a58d8bf403da39be@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Mar 2022 09:20:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a10rsxpzd4eJbSJmRUDEMbOO+=6+=6Eu-7EY86+xw8V6g@mail.gmail.com>
Message-ID: <CAK8P3a10rsxpzd4eJbSJmRUDEMbOO+=6+=6Eu-7EY86+xw8V6g@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:lTtBG+5RV6V1/aOEk688MfNsHWHJcRo+jtzt1jC19bNgxRCv/gr
 MZZYe8oKi6FYe4/rTIRXGsMK2jKafA5gMzeYS1VHuH0tILr7l+1qr5UwkEevDMhAjS4eZjP
 +cVZAP5r1KjtMEhFlJ8B2Ji5lcv9Ha/J4qhDvkaA+kHqzbwmostd4AX9OV9hh6o/xZFegPV
 fOdGWpknF/hs4DfDtRzbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X6MBMGnF+us=:i6xhtLOnMKWlpQYbjimQCB
 s4WDXdizDiUNNO7SpzhDVPSBjRrDkP1tiFR+2z/5t9XF5/84T6A9oW1AkdgmtvxSJHDwzhHX7
 pcfXGWNJEA4CON5Fe2OHx0DnqBDThP5qjmgP3O/P2AKq1dYCaGDLPI+lPBftLZPiHX0NAuhHC
 35JvCHggYdBbkuvNPM7CMwrWOKKhbuwV7Q62o+Ea4lkD+SQgBZ8G6tfotJN/gsUR4HZjxziJD
 Dfh46G8PR1ajCIpCU6zC0mzgs1lFpIH5KslDvaICUPv3omfFN7lbtnQpTe6Vd/PIPVlTRNKLR
 dWKLB3/xp6jSxqP17xN/EAtfunjP8qu6HL0jBml/ySo+ylFGioPNulF8s+sUJN9VB6zaqN+XY
 SoKjgWI8gm60kDIuUZMmgPlb8AbNBTjEOEbBv6A90aWUmy3+Qaj4lO7a7GZxcTuVMuYDpqQ9T
 ZHCRnW05hhMoa5LC5k6zEudNIG9fcGXB3f9P9wdB9vnjLindq/BVhk5/abCem7vYJBi657Q7j
 Fi6wGyTKqfSg13vXMcjCtFxLD/tRcq0f1rKvimdlO2/MIvIV2Y1yWGIuAwPpIfFnihZJLplbJ
 HVrYXPPTbKv3LM38swWqIejEt4VQJ4GugSyxCNcFoogHEvVXLO17fsmt5XSp5x9cHnnXQ0fcD
 elAoM9OpLHgog8HS0gBVgR51Dhru9uLEvVz44a7rtnEZqgUK2DfzMx2pskDG4Izok5Gk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 2:41 AM qinjian[覃健] <qinjian@cqplus1.com> wrote:
> > On Tue, Mar 22, 2022 at 7:17 AM Qin Jian <qinjian@cqplus1.com> wrote:
> >
> > It was a while ago though, so I don't remember the details, if we did
> > conclude the review, can you link to the lore.kernel.org thread in
> > the next version? Please also check the other patches on which
> > you added a 'Reviewed-by' tag from someone to ensure that they
> > actually provided that tag, rather than just providing review comments.
>
> In patch 6, I fixed all your comments.
>
> I got a reply from you: https://lore.kernel.org/all/CAK8P3a1Doh8GY9iFZsvmd6wASHoPqyR+roXx0G5XidnmHNkGaA@mail.gmail.com/
> > This looks all good to me now, it just needs a review for the clk,
> > reset  and irqchip drivers. ...
>
> If these not means you reviewed, I'll remove your review-tag.

You can only add Reviewed-by tags that have been explicitly given,
see the documentation at [1] for details. What I wrote was a less
formal acknowledgement that does not have the specific meaning.

      Arnd

[1] https://www.kernel.org/doc/html/latest/translations/zh_TW/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
