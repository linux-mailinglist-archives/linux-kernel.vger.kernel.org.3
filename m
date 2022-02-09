Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA44AEE6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiBIJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiBIJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:49:56 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656FE0CD5D5;
        Wed,  9 Feb 2022 01:49:48 -0800 (PST)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MUGqT-1nhPAW2hRz-00RKGp; Wed, 09 Feb 2022 10:39:55 +0100
Received: by mail-wr1-f52.google.com with SMTP id s10so2979127wra.5;
        Wed, 09 Feb 2022 01:39:55 -0800 (PST)
X-Gm-Message-State: AOAM532Wr5KJwgBx8HT5EiBbGvnyB0FGpzru6qwmYev0Hvot8e2v/Yxk
        7HGBDorwFvs+/gZO2zznfAizcxPmVd2aIY/sr0A=
X-Google-Smtp-Source: ABdhPJz3KHEWzLUGUXQRVUVhG7tdvGJxnqkmHAQWCi8BoxyHdHPDE5k/78Mr9En5Xk713UBFNQeWBwjQLBOzv8A4Rqg=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr1335451wrt.219.1644399595263;
 Wed, 09 Feb 2022 01:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20220113080017.30155-1-kavyasree.kotagiri@microchip.com>
 <f8b83cf0-7ebf-1ecd-b544-f0d0079d9dde@microchip.com> <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
 <CO1PR11MB48651C0D73189AF010407F9B922E9@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB48651C0D73189AF010407F9B922E9@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Feb 2022 10:39:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1swyDBvSTg9a6tUnd2V2Zi=ANpJWhJpWwfvp7ArZpwVg@mail.gmail.com>
Message-ID: <CAK8P3a1swyDBvSTg9a6tUnd2V2Zi=ANpJWhJpWwfvp7ArZpwVg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board pcb8291
To:     Kavyasree.Kotagiri@microchip.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jTCo3beyZTovebwApM1BZXCSjJx3bvezVv35gCf/vhCDsdz41Fm
 xxWDAmsE/dBT2kkDxXcx3aqqgIUyTJFhBjWZXcRYpF08Gujn5S4Y0Y61zOpq/3HWi9HntWk
 ymNAss107ppOZRBg74VA2Dv+3AJ/+FcLqk2FaclKuHLkP+V01WRdNiZhMiY4fNOqoYfVfo5
 axoHCJ/ktX4EkBAVIahWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6sfh7BBii0=:htF3Eju/VJMOYgJPPzo4/i
 BKcOVDkyvVTYdufBuE6c99Hv87gqq5JMQdA8rasIVFzcugEJPYbqFfPWC9tl3lZp8ROWLZWmi
 DJomJDGfo13k1fJSq0yHmz0hqAjarBps1F3kaDu/7jk7g03YT7eQex4FEjcy2ugkI0G7xJgND
 sCOJjEnBlVIx1xT9aMTUuj+WlC10KwOseYwSWQQIR2ZMATdu0C5uXDRDsLoze8mKBjvhrpwLz
 bQ3pzF0QMdEzR02zSutvWpPSzFbxka+JkFIoNdkVzwUGIybllbXNuz2UZR8CJVMmp5W2/pN9l
 2eUde44iGu9F4R0/axTUc1xY8sfkv5adaMGaJO0SXc02j8i8nsrZiXj/8p/NpNUCKSuFRBcqr
 hUEpFvCPwKN52yREwFMPi8Z9ROuwK7Vp/Kmpm8//RkVJNn9agvbokgIL2pFo9hlUloj90NTdF
 IVJiluRvzOVI+tDE12juFUTwpj8lRYj1YvCO6DyWZyT5hh4VQMj15ETuOHioJ8ZXvdDvL2PGI
 5EFiS7+t3vTDYhTrzGzKfNPM7JzItYKNQLxHawrzURUJgVmsgnM58Clu49b3TvOXCUdeHA/4q
 x9JGE5s1KkfU6LtH8NWRBZ43a/QZoACXZt6nmHDsodo2Pz1orxdgImBFnQio7ymwZptTVQrzM
 rRYVbav/Jh3j/VU6/z0nUgpFMEHaiRLLR3hvbRWBPQxFbGqZHIGbwmhwMzABIuNrICMM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 10:02 AM <Kavyasree.Kotagiri@microchip.com> wrote:
> > > On 13/01/2022 at 09:00, Kavyasree Kotagiri wrote:

> > > > +&gpio {
> > > > +     fc_shrd7_pins: fc_shrd7-pins {
> > > > +             pins = "GPIO_49";
> > > > +             function = "fc_shrd7";
> > > > +     };
> >
> > These properties don't look like most pinctrl nodes, has the binding
> > been reviewed?
> > I don't see it in Documentation/devicetree/bindings/pinctrl/
> >
> This is similar to the ones used in Microchip Ocelot and Sparx5 pinctrl.
> For example, see usart_pins of gpio nodes in below links:
> https://sbexr.rabexc.org/latest/sources//84/d39b543790ff25.jhtml
> https://searchcode.com/file/333750634/arch/mips/boot/dts/mscc/ocelot.dtsi/

Ok, I see, so this was reviewed by both Rob and LinusW, I assume it's fine
then, though the use of strings with capital letters, with all pins
named "GPIO_*"
still looks odd.

For my understanding, would you describe the lan966x family as
a follow-up to Ocelot, with the CPU cores replaced and flexcom added,
or should I think of it as a SAMA7 based SoC design that incorporates
the Vitesse switch IP?

        Arnd
