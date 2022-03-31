Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490654ED6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiCaJcz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiCaJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:32:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E1462119;
        Thu, 31 Mar 2022 02:30:57 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRT6b-1nLC0R17ob-00NOzE; Thu, 31 Mar 2022 11:30:46 +0200
Received: by mail-wr1-f41.google.com with SMTP id w21so28295765wra.2;
        Thu, 31 Mar 2022 02:30:46 -0700 (PDT)
X-Gm-Message-State: AOAM531+p9JRxXWPCupNmjuADuaWohp1e12ArJ8fnMSS4FhA4lA1beKk
        vw4alRW5T1123ik/lSskb7cXH7ZuJWv8as9h9Os=
X-Google-Smtp-Source: ABdhPJxWd3RtjDSXkoA7ngdrzuRWb2WjuY33jCnVXB+A1AAH0qJlJE8UE/skE144ENFuB/dx3i4kfZu3MJkNdoi2xmg=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr3364174wrw.12.1648719041888; Thu, 31
 Mar 2022 02:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 11:30:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
Message-ID: <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gyI13vHiir4qvS+gHbaOuk1V7upswNbgvg4akROxuDFv4rlu2CD
 Tf/TBLjJnvOrv/FgpBF8QmJj3v4fBk/oOAswQOczVkA2dEQlCFk9i9hp0Bwow9G6RPEW7yO
 eLut5PvuBccWeLviFvpGGCG0C9I/hCMpctmWPZ3MEcHQjQPOBljZQL2f6eo1gFxs/KTAxjk
 YQmE6//1LbbmziWTyQQDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XJ0tSoddKgQ=:4u3TZgp1G4wkofKNDaiD5K
 QPORxCLAqlWP6hpLjLt+iotfOU6I0iAbHBdzgYC2mu/BdL3aSgnGqozjIYLS3wfURgs+TiA+D
 iPOhm21BvBfqcdibpLVPL6zc6gYDsd8PZZSdMefq/5Vp3yrBvCL/Jty3yJ4z9I4VmqgBWtjPk
 76Lz3VK0Ig+/mIKz1CNcgXco/g5aeMkhc97uSQuVwD1DyUohneJuMGK4HVoReoqTQxt1ktKxo
 2T0hSiU66O2CNVfAYn197hVdeZ9q7sNi/2aSciMKE0cD6gPJ2FEQX4jZ6VOX5+UF4mlmO6wFg
 9lAj1MCzWbdayVEVX6KugGmR/kRweyEiWSVDiZT1HS0AaGdIi8kR5sd0b18DBt0+tVRS0c5Lv
 zIxSxToUSN2f7qwe2cCzi346P+BBkVhFkOuTIVZpLb2QYHQVV7Nbxb86pMDZ9VLzkL4ziqkV/
 gp52U0e/4LiEeHn+9t20h2yQ8OM7ixQze6UKCwXJxAFyz5nzwfYCLPtSvl9wm1N08UzeIzAf0
 stMMXKn+rX0/WOOQiXO/dhFuly9Ecj9RsOgG9PbtE/tyyZqjBO8H6ITDec3NZNPi6+1WxorXt
 qVZPbO4vm6sYeGGHfspIwQZuntZar7FFw3qYRu5W40uyWAxOvedp27EPbV3MGAb26LEekkIYd
 aWi6AWQYDitWGQzmMGS9RyLNrxmbmgVpadTolENuuqtG8vVkHDHsnnX4j4Eu5M0D8CoyKVKV+
 Nr3k1/FQ72nL/A8hoaV0hDGHVbrjNsoIRqfp9ZYDQUHAmDUGRR8Um7AhN+eGUtGYSB4HCZ4jG
 NA6Jfjnn3jn3TihoKb1XHjgxolM/VH+Ot+cilSuixRX1lf7bKd26Sbn2F4XBj0HHR4o1x72
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:27 AM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> On Tue, Mar 29, 2022 at 9:38 PM Hawkins, Nick <nick.hawkins@hpe.com>> wrote:
>
> >> I am in the process of rewriting the timer driver for Linux but have hit a dilemma and I am looking for some direction. The registers that represent the watchdog timer, and timer all lay in the same register region and they are spread out to the point where there are other controls  in the same area.
> >
> >> For instance with our watchdog controls we have:
> >
> >> @90 the countdown value
> >> @96 the configuration
> >
> >> And for our timer we have:
> >> @80 the countdown value
> >> @94 the configuration
> >> @88 this is actually our timestamp register but is being included in with the timer driver currently to call clocksource_mmio_init.
> >
> >> What would be your recommendation for this? I was considering creating a gxp-clock that specifically points at the timestamp register but I still have the issue with gxp-timer and gxp-wdt being spread across the same area of registers.
>
> > I think this is most commonly done using a 'syscon' node, have a look at the files listed by
>
> I found an example and copied it although I have a couple questions when it comes to actually coding it. Can that be here or should I post these questions in the patch that actually concern the file?
>
> st: timer@80 {
>         compatible = "hpe,gxp-timer","syscon","simple-mfd";
>         reg = <0x80 0x16>;
>         interrupts = <0>;
>         interrupt-parent = <&vic0>;
>         clocks = <&ppuclk>;
>         clock-names = "ppuclk";
>         clock-frequency = <400000000>;
>
>         watchdog {
>                 compatible = "hpe,gxp-wdt";
>         };
>  };

I'd have to study the other examples myself to see what is most common.

My feeling would be that it's better to either have a "hpe,gxp-timer" parent
device with a watchdog child but no syscon, or to have a syscon/simple-mfd
parent with both the timer and the watchdog as children.

       Arnd
