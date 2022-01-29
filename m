Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F64A2D76
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiA2Jp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:45:27 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43336 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbiA2JpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:45:25 -0500
Received: from g550jk.localnet (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 90B00CACAF;
        Sat, 29 Jan 2022 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1643449523; bh=zQkC1QYsOvP0xeltftJt85NawEUy23u3cA/wx9Ewofw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IpJMuvhOdripEPz6XDpw6ktN29te+2YyoYuCmvISHCt8R9pbBCPUZcFXrMdIeISF6
         WrEBHFhW4D73kscbB4WezUNy30zlZeJkRaUt0TbuuyI2BF9HURmmMU+vFtwy/MakZ4
         xe/UGOsBg97pr0k6GelkyPsA9m/xqJHURBcM1Usc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Petr Vorel <petr.vorel@gmail.com>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean THOMAS <virgule@jeanthomas.me>
Subject: Re: [PATCH 6/8] dt-bindings: vendor-prefixes: add LG Electronics
Date:   Sat, 29 Jan 2022 10:45:23 +0100
Message-ID: <3398674.ElGaqSPkdT@g550jk>
In-Reply-To: <64ee2334-aa99-7226-8946-84c95676041a@canonical.com>
References: <YfHlV13Zi4KV+bNT@pevik> <5883435.31r3eYUQgx@g550jk> <64ee2334-aa99-7226-8946-84c95676041a@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Freitag, 28. J=E4nner 2022 10:57:15 CET Krzysztof Kozlowski wrote:
> On 27/01/2022 21:51, Luca Weiss wrote:
> > Hi all,
> >=20
> > On Donnerstag, 27. J=E4nner 2022 08:45:33 CET Krzysztof Kozlowski wrote:
> >> On 27/01/2022 01:20, Petr Vorel wrote:
> >>> Hi all,
> >>>=20
> >>>>> Hi Krzysztof,
> >>>>>=20
> >>>>> On Montag, 13. September 2021 10:49:43 CEST Krzysztof Kozlowski wro=
te:
> >>>>>> On 12/09/2021 01:27, Luca Weiss wrote:
> >>>>>>> LG Electronics is a part of the LG Corporation and produces, amon=
gst
> >>>>>>> other things, consumer electronics such as phones and smartwatche=
s.
> >>>>>>=20
> >>>>>> Hi,
> >>>>>>=20
> >>>>>> Thanks for the patches.
> >>>>>>=20
> >>>>>> I think "lge" it's the same prefix as "lg". There is no sense in
> >>>>>> having
> >>>>>> multiple vendor prefixes just because company splits inside busine=
ss
> >>>>>> units or subsidiaries. The same as with other conglomerates, e.g.
> >>>>>> Samsung - if we wanted to be specific, there will be 4-5 Samsung
> >>>>>> vendors... Not mentioning that company organisation is not always
> >>>>>> disclosed and can change.
> >>>>>=20
> >>>>> I was mostly following qcom-msm8974-lge-nexus5-hammerhead as it's t=
he
> >>>>> other LG device tree I am aware of so I've picked lge instead of lg.
> >>>>> Also worth noting that Google uses "LGE" in the Android device tree=
[1]
> >>>>> or in the model name in the LG G Watch R kernel sources ("LGE APQ
> >>>>> 8026v2 LENOK rev-1.0")
> >>>>=20
> >>>> [1] Does not point to kernel tree. Downstream user could be a good
> >>>> argument to switch to lge, but then I would expect correcting other
> >>>> "lg"
> >>>> devices which are in fact made by LGE.
> >>>>=20
> >>>>> I don't have a strong opinion either way so I'm fine with either.
> >>>>>=20
> >>>>> If we decide to go with "lg" do we want to change the Nexus 5
> >>>>> devicetree
> >>>>> (hammerhead) also, that one has the lge name in at least compatible
> >>>>> and
> >>>>> filename (I don't know how much of a breaking change that would be
> >>>>> considered as).
> >>>>=20
> >>>> We would have to add a new one and mark the old compatible as
> >>>> deprecated.
> >>>=20
> >>> Have we sorted this lg- vs. lge- ?
> >>>=20
> >>> There are both:
> >>> arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> >>> vs
> >>> arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> >>=20
> >> Probably renaming/unifying/correcting prefix in existing compatibles is
> >> not worth the effort. This would make a mess and affect other DTS user=
s.
> >=20
> > If wanted I can send a patch renaming the Nexus 5 to just LG, this would
> > adjust both compatible in the file (which shouldn't really affect
> > anything) and the filename (which probably will affect various scripts
> > and whatnot used by existing users of the dtb).
> > Is this something that can be done in mainline or should we rather just
> > let it be? I'm not sure what the policies there are.
>=20
> The "lge" compatible is already in the bindings, so it should not be
> changed without valid reason. Imagine there is an user-space code
> parsing compatibles to adjust some power-management settings to
> different models. It would be broken now.
>=20
> What could be done is to mark it as deprecated and a add new one:
> compatible =3D "lg,hammerhead", "lge,hammerhead", "qcom,msm8974";
> This should be safe for user-space and allow transition to common "lg".

What can or should be done about the filename then?
=46or compatible in the file it's now clear from my side.

Regards
Luca

>=20
> Best regards,
> Krzysztof




