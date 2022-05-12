Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEC52509A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355593AbiELOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355202AbiELOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:50:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D26246D9A;
        Thu, 12 May 2022 07:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14551B8289D;
        Thu, 12 May 2022 14:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0948C34116;
        Thu, 12 May 2022 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652367006;
        bh=K2lV3MNXpt7/q8fXRKHox/llU0Ii4IdqDmJyyOWTUys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMUv8rO34mCmy1mXEbNuVxbIXswxQr4ED+eeKJV7INzxcfi4h9ViVqMLx6F6+aliA
         8c9Guw8AaY1GUi/x9aftgbWlJtp37gyHFhBS225fLOAB2r7SldyEd8buGgK1W3pMRf
         Whr8PwtX6/pLWZzE4epmNZDprTZZTe+8NUp3nbgYCdm+rb9F8oe2hlyENcN1U/KBOH
         IQR1JWqb7tDqzUvNSiKtyH1no4a5/SyAvNr7Cp0IeXKM8+pzZWkoA+U2w9EZH4V1jB
         RdrTKbK+hSGqNK9BT479qWO2fbDRII0/nBuYvoaNS+bO5nREF0gYJv/fPP62e0psXc
         t+utEVtVBH29A==
Received: by mail-pf1-f180.google.com with SMTP id p12so5050553pfn.0;
        Thu, 12 May 2022 07:50:06 -0700 (PDT)
X-Gm-Message-State: AOAM530CQ/SJjhmvyolL3336Fsj6qX306TxTel1VYPz5weHAOsy2eSEj
        UhcBky8Z3nzk8LtSQ5AZFqzZOppDOu/y2FrhJw==
X-Google-Smtp-Source: ABdhPJy1pFX4NArhGcrcBvppzFMHq0UIZgL6+L9BIRTAPsM3rPRLzjdTgnsRFwBve6LrlO8Ky1aRYN7QvQEuIzj6Ia8=
X-Received: by 2002:a63:e218:0:b0:3c6:7449:15a2 with SMTP id
 q24-20020a63e218000000b003c6744915a2mr35272pgh.515.1652367006204; Thu, 12 May
 2022 07:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
 <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net> <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
 <501852E6-6934-4BB2-850C-B53A07580568@goldelico.com> <8533f999-f584-ea31-0c44-1ce29c066d88@wanyeetech.com>
 <1B523C47-1F9C-42EE-B242-EF63F89B94F9@goldelico.com> <35c60fea-ac74-9d23-51ac-b877a5b4eb86@wanyeetech.com>
In-Reply-To: <35c60fea-ac74-9d23-51ac-b877a5b4eb86@wanyeetech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 May 2022 09:49:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+vAtfOywCry+6A3cEKaKupyAC1aah6LNk+YdWzxtdVeA@mail.gmail.com>
Message-ID: <CAL_Jsq+vAtfOywCry+6A3cEKaKupyAC1aah6LNk+YdWzxtdVeA@mail.gmail.com>
Subject: Re: Question about SC16IS752 device tree.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Cercueil <paul@crapouillou.net>, jringle@gridpoint.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Paul Boddie <paul@boddie.org.uk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:53 PM Zhou Yanjie <zhouyanjie@wanyeetech.com> wr=
ote:
>
> Hi,
>
> On 2022/5/10 =E4=B8=8B=E5=8D=8811:31, H. Nikolaus Schaller wrote:
> > Hi,
> >
> >> Am 10.05.2022 um 04:29 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.com>=
:
> >>
> >> Hi Nikolaus,
> >>
> >> On 2022/5/10 =E4=B8=8A=E5=8D=884:19, H. Nikolaus Schaller wrote:
> >>> Hi,
> >>>
> >>>> Am 09.05.2022 um 20:41 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.co=
m>:
> >>>>
> >>>> Hi Paul,
> >>>>
> >>>> On 2022/5/10 =E4=B8=8A=E5=8D=882:13, Paul Cercueil wrote:
> >>>>> I can't say for sure that it's your problem, but your bluetooth nod=
es are missing "reg" properties.
> >>>> Unfortunately it doesn't seem to be the problem here, I added "reg" =
and
> >>>> the problem persists, and I've looked at other device trees that con=
tain
> >>>> "brcm,bcm43438-bt", none of them use "reg", and "reg" is not mention=
ed in
> >>>> neither "Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt"=
 nor
> >>>> "Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml".
> >>> what happens if you remove the serdev children from DTS? Does the dri=
ver create two separate /dev/tty ports? And do they work?
> >>
> >> Yes, there will be two separate /dev/tty ports (ttySC0 and ttySC1), an=
d
> >> both ports can work normally, but at this time the two bluetooth modul=
es
> >> are not working.
> >>
> >> I guess it is because the driver does not detect bluetooth module node=
s,
> >> so the inability to operate "reset-gpios" and "device-wakeup-gpios" ca=
uses
> >> the bluetooth module to work incorrectly.
> > I would assume that it is not prepared to handle two serdev subnodes an=
d
> > assign the right gpios.
>
>
> I found something new now, if I follow the practice in
> "fsl-ls1012a-frdm.dts"
> and put the clock node inside the node of SC16IS752:
>
> &ssi0 {
>      status =3D "okay";
>
>      num-cs =3D <2>;
>
>      pinctrl-names =3D "default";
>      pinctrl-0 =3D <&pins_ssi0>;
>
>      sc16is752: expander@0 {
>          compatible =3D "nxp,sc16is752";
>          reg =3D <0>; /* CE0 */
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
>
>          spi-rx-bus-width =3D <1>;
>          spi-tx-bus-width =3D <1>;
>          spi-max-frequency =3D <6000000>;
>
>          clocks =3D <&exclk_sc16is752>;
>
>          interrupt-parent =3D <&gpb>;
>          interrupts =3D <18 IRQ_TYPE_EDGE_FALLING>;
>
>          gpio-controller;
>          #gpio-cells =3D <2>;
>
>          exclk_sc16is752: sc16is752 {
>              compatible =3D "fixed-clock";
>              #clock-cells =3D <0>;
>              clock-frequency =3D <48000000>;
>          };

That doesn't look right. This clock source is not part of or coming
from the sc16is752. This belongs at the top level.

>
>          bluetooth@0 {
>              compatible =3D "brcm,bcm43438-bt";
>              reg =3D <0>;
>              max-speed =3D <1000000>;
>
>              device-wakeup-gpios =3D <&gpc 26 GPIO_ACTIVE_HIGH>;
>              reset-gpios =3D <&gpb 17 GPIO_ACTIVE_LOW>;
>          };
>
>          bluetooth@1 {
>              compatible =3D "brcm,bcm43438-bt";
>              reg =3D <1>;
>              max-speed =3D <1000000>;
>
>              device-wakeup-gpios =3D <&gpc 28 GPIO_ACTIVE_HIGH>;
>              reset-gpios =3D <&gpb 19 GPIO_ACTIVE_LOW>;
>          };
>      };
> };
>
> This will cause all bluetooth modules to not work, and if the clock node
> is moved
> to the end of the child node, the bluetooth module connected to ttySC0
> can work
> normally, which seems to mean that only the first child node can work
> correctly.
>
>
>
> And I found this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/dri=
vers/tty/serdev?h=3Dusb-next&id=3D08fcee289f341786eb3b44e5f2d1dc850943238e
>
> It seems to mean that the SC16IS752 driver does not correctly
> distinguish between
> the two serial ports, which makes the serdev driver think that the child
> nodes are
> on the same serial device bus, which leads to the current problem.
>
>
> >
> >>
> >>> Maybe the sc16is752 driver does not separate them for child nodes, i.=
e. while "reg" should be added it may not be handled?
> >>
> >> I'm not too sure, I'm not very familiar with serial port systems.
> >> If the truth is what you think, how should I improve it?
> > Unfortunately I also don't know how the serdev implementation really wo=
rks.
> >
> > It was my nagging to make it happen by persistently proposing a non-uni=
versal
> > solutionsome years ago until one of the maintainers had mercy to write =
a general
> > solution. So I could switch my driver to simply use the serdev API. It =
was for a GPS
> > client device but not a tty side driver.
> >
> > I think if you look up the first patches for the serdev interface this =
should
> > reveal the original author an he should be able to help.
>
>
> The original author of the serdev driver is Rob Herring, the original
> author of the
> SC16IS752 is Jon Ringle, they are already on the CC list, I also added
> Johan Hovold
> and the two authors Tomasz Mo=C5=84 and Lech Percza who sent patches to t=
he
> sc16is7xx.c
> driver in this year.
>
> Hopefully they can guide us here.

I think what needs to happen is of_serdev_register_devices() needs to
be passed the port index which can then be used to get the child with
a matching address/index.

There's not any DT binding that defines how this looks. It could be
either the slave devices are direct child nodes like you have or each
serial port should have a child node for the port and the grandchild
nodes are the slave device. I'd suppose it is possible to have
multiple devices muxed to a single port (that's what the comment is
about and handling muxed devices would require more work in serdev).
That binding would end up looking just like the former style and the
serdev core could have a hard time figuring out whether it is multiple
ports or multiple mux settings. I suppose we would be able to
distinguish that with the presence of mux-control binding or not. In
any case, all that needs to be considered before we change serdev.

Rob
