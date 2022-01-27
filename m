Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65BF49ECDE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiA0Uvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:51:46 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43334 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233171AbiA0Uvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:51:45 -0500
Received: from g550jk.localnet (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7E8CDCE80B;
        Thu, 27 Jan 2022 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1643316703; bh=DUB792Sm7wrxTDzeKptu+rclVLnte4oN7SWkyfqFheM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A0j9oXiy9vkCDp8MOuI/U5CN6y2sTX5jhHRqrCEZ4HETW245icE3T0KvfXjnheBMx
         0NSnNnaaEamtUNffmAGQ7gNZIUlc8rUNfQRv0VnAkMstnyVsFJZL4gFLSkpJaxJJ3v
         pojXForA/la68Js2XbMop60DCbGxbZbnebDB6mW0=
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
Date:   Thu, 27 Jan 2022 21:51:42 +0100
Message-ID: <5883435.31r3eYUQgx@g550jk>
In-Reply-To: <c69d1daf-45c8-3ac5-a0b0-bb853593c54e@canonical.com>
References: <YfHlV13Zi4KV+bNT@pevik> <c69d1daf-45c8-3ac5-a0b0-bb853593c54e@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Donnerstag, 27. J=E4nner 2022 08:45:33 CET Krzysztof Kozlowski wrote:
> On 27/01/2022 01:20, Petr Vorel wrote:
> > Hi all,
> >=20
> >>> Hi Krzysztof,
> >>>=20
> >>> On Montag, 13. September 2021 10:49:43 CEST Krzysztof Kozlowski wrote:
> >>>> On 12/09/2021 01:27, Luca Weiss wrote:
> >>>>> LG Electronics is a part of the LG Corporation and produces, amongst
> >>>>> other things, consumer electronics such as phones and smartwatches.
> >>>>=20
> >>>> Hi,
> >>>>=20
> >>>> Thanks for the patches.
> >>>>=20
> >>>> I think "lge" it's the same prefix as "lg". There is no sense in hav=
ing
> >>>> multiple vendor prefixes just because company splits inside business
> >>>> units or subsidiaries. The same as with other conglomerates, e.g.
> >>>> Samsung - if we wanted to be specific, there will be 4-5 Samsung
> >>>> vendors... Not mentioning that company organisation is not always
> >>>> disclosed and can change.
> >>>=20
> >>> I was mostly following qcom-msm8974-lge-nexus5-hammerhead as it's the
> >>> other LG device tree I am aware of so I've picked lge instead of lg.
> >>> Also worth noting that Google uses "LGE" in the Android device tree[1]
> >>> or in the model name in the LG G Watch R kernel sources ("LGE APQ
> >>> 8026v2 LENOK rev-1.0")
> >>=20
> >> [1] Does not point to kernel tree. Downstream user could be a good
> >> argument to switch to lge, but then I would expect correcting other "l=
g"
> >> devices which are in fact made by LGE.
> >>=20
> >>> I don't have a strong opinion either way so I'm fine with either.
> >>>=20
> >>> If we decide to go with "lg" do we want to change the Nexus 5 devicet=
ree
> >>> (hammerhead) also, that one has the lge name in at least compatible a=
nd
> >>> filename (I don't know how much of a breaking change that would be
> >>> considered as).
> >>=20
> >> We would have to add a new one and mark the old compatible as deprecat=
ed.
> >=20
> > Have we sorted this lg- vs. lge- ?
> >=20
> > There are both:
> > arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> > vs
> > arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
>=20
> Probably renaming/unifying/correcting prefix in existing compatibles is
> not worth the effort. This would make a mess and affect other DTS users.

If wanted I can send a patch renaming the Nexus 5 to just LG, this would=20
adjust both compatible in the file (which shouldn't really affect anything)=
 and=20
the filename (which probably will affect various scripts and whatnot used b=
y=20
existing users of the dtb).=20
Is this something that can be done in mainline or should we rather just let=
 it=20
be? I'm not sure what the policies there are.

Regards
Luca

> Most of existing usages of "lg" prefix are panels which are coming from
> another subsidiary of LG - LG Display. We all use there "lg" prefix, not
> "lgd".
> Plus mention before Bullhead mobile phone which is coming from LG
> Electronics.
>=20
> If we use generalized "lg" prefix for one subsidiary (LG Display), then
> let's do the same for another subsidiary - LG Electronics. Plus entire
> branding of LG Electronics products is LG: the website, the logo,
> advertisements. Everywhere except legal footer.
>=20
> I vote for using "lg" for both subsidiaries: LG Display and LG Electronic=
s.
>=20
>=20
> Best regards,
> Krzysztof




