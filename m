Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A156F56B96B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiGHMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiGHMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:16:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1382F651
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657282571;
        bh=sLmOfEnVNSVJmG8OJ3heD6wggMT/SeCDldQQU4BqbpY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DyhV7FdbUVKU7Ttey7nDmGkD+9TlO6L1Mv7tpQytkaOh1gboOWChF58Z1Fv0nFj+b
         SUIJUELDjlU9g+2s9f+dHvsKd2djsEf793iFNX425K23OFnfY2CE/fVr7gHEzyf83r
         A4rEoZoYB6dVQkiNshc44BvPfRJJKqTQghMle/5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.69] ([157.180.225.69]) by web-mail.gmx.net
 (3c-app-gmx-bs34.server.lan [172.19.170.86]) (via HTTP); Fri, 8 Jul 2022
 14:16:11 +0200
MIME-Version: 1.0
Message-ID: <trinity-05389b8f-a479-47b6-bc3b-5a02b4804627-1657282571466@3c-app-gmx-bs34>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Aw: Re: [BUG] USB broken on rk3568 based R2Pro
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 8 Jul 2022 14:16:11 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <Yse9nz9jjRoiPq6K@matsya>
References: <trinity-54ed588d-4b2c-4177-83b0-4eda8ff16a42-1657210235522@3c-app-gmx-bap68>
 <trinity-ec3b4258-cb12-42c2-9058-362260a275d2-1657216287085@3c-app-gmx-bap68>
 <CAMdYzYrs0oJXVcViOmJk4E7PSTeP5TYs0O_ePHmrcAiKtOAWXQ@mail.gmail.com>
 <Yse9nz9jjRoiPq6K@matsya>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:vgMfP4yrgP6IpedEv6CgTxZAAf8HIDhFKdiUyaeSHdg2tVzwFrS50PzJNDIePsXF7KbF6
 J9K5v57XKgWKAYmgNXjWqx1t0N68O3WYkk1cznqmNUekVop9kGV1Ob//cSMx0eWbITKbussxkMCD
 dlEvBpRPrIUOab5UiCWjJaz+eqA4bz1WmJ645Y3qjbo93khRXmfQFEaOvKzqvz2+IwR53d/drNNF
 RknhomxxLXlzclbVM/uMNZBAbyS+R85IJ27MP3j8fDB6okU2YcyQTiDFzs0PBAaEAoDChtj6jxt2
 yI=
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1BOECItVR8=:ulQ1qSe1hQy0NTW9mWO0kE
 c2a22fNZRvgOYXx6+tObJX3UwhLQgRSedAB8WhQAvHHIHu2OV7pHs3atR5BBZ34FuiBDBLv43
 9AQcBtuMGz8xnX0qvYxX6JPV1xtLOWYi2/Vt3rcmtbeXTQR65EgqxmOhK+cf3PvVAwXcVER8V
 pQ9tkkOnSaz+yai0boxtj4y1sCzO0VPFlQyCx8+D0IYoWw/L9mQ8bJyoswiWYEe0eHOhQXiAM
 HeulOpEuktmuy+exEJjP7mFRO201HN25HHMV+UbnY9q33+o7m1tSUHSw9J7oCwZRAfqYBVVqe
 QTKcJP0Npt3jcw+N0c/Ex6b1bZwsrr7XQ0kg9CPtN+faTa/8UAPR4zrxGL+GBG/NxQ2xj4J83
 56kPfAncml2s/3IomVNxv7Bqdn31RqYzVQNoX2BL0tqIk6RwYq/SdxrbqH5kqKP66gTLZ/dNH
 4FSkg1D2Es1SuGupZGyt8NfU483TNNFDWdshbvfjW55JeCVcGTuZm8x5tOVcfohitog3CEDMj
 ziw2HatpZwPF9/dJEyBkkHSXgZBLP3g8Qh71IBzQbipNqhDlZED/mL7GtMewbY5QpQpm4FZWM
 WAbiksoSaFHszJ5keonTv9gKNUr0yq6/uw8Zmy57mEhf8XOwPN4ZLz4oAXrkl5G13WLFG5PrI
 83gkhY6vx/inIfg6rPCcxFxuDWPrUAaP7Ip12zsIf3FOTjmXQyMHrvw1Js6B9fHk96m364/lZ
 daWdVhHkCCo4nk9qCgu6ZY8oFOg8hOZBlYIW/56bL4yT3+pEXZI88r91F18PfEvMfp3T8+1Qt
 zdvUabr
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Samuels Patch fixes my issue

https://patchwork.kernel.org/project/linux-rockchip/patch/20220708061434.3=
8115-1-samuel@sholland.org/

regards Frank

> Gesendet: Freitag, 08. Juli 2022 um 07:16 Uhr
> Von: "Vinod Koul" <vkoul@kernel.org>
> On 07-07-22, 15:41, Peter Geis wrote:
> > On Thu, Jul 7, 2022 at 1:51 PM Frank Wunderlich <frank-w@public-files.=
de> wrote:
> > >
> > > Hi,
> > >
> > > traced it down with manual reverts to this one:
> > >
> > > commit 6a98df08ccd55e87947d253b19925691763e755c
> > >     phy: rockchip-inno-usb2: Fix muxed interrupt support
> > >
> > > luckily i can revert only this and now upper usb-port works again
> > >
> > > @samuel: have you an idea how to fix your problem without breaking m=
y board? :)
> > >
> > > @greg/Vinod: maybe we can add a revert of this in mainline till issu=
e is resolved?
>
> Lets give it a few days if we can find a fix, if not we can revert
>
> > >
> > > regards Frank
> >
> > I don't know what you're running, but with the standard arm64
> > defconfig w/ all rockchip stuff built in, I have no issues here on
> > 5.19.
>
> Please share the config and other details on what your running so that
> Peter can repro this...
>
> > Note, the following changes are necessary to the 5.19 dts here:
> > Remove the extcon from usb_host0_xhci, as the production model doesn't
> > have automatic switching capabilities. The ID pin was removed in favor
> > of the usb debug function which also doesn't work.
> > Add dr_mode =3D "host" to the same node, for the same reason.
> >
> > >
> > >
> > > > Von: "Frank Wunderlich" <frank-w@public-files.de>
> > > > i noticed that upper usb-Port (otg) is broken on my Bananapi R2Pro=
 with 5.19-rc1, works with 5.18.0
> > > >
> > > > this port is a usb3 (xhci) port which includes an usb2-phy and sho=
uld support otg, but i still want
> > > > to use it in host-only mode (USB-A socket).
> > > >
> > > > already tried setting dr_mode in dts back to "host" as this was ch=
anged in rk356x.dtsi by this commit:
> > > >
> > > > bc405bb3eeee 2022-04-25 arm64: dts: rockchip: enable otg/drd opera=
tion of usb_host0_xhci in rk356x
> > > >
> > > > i see no error in dmesg and usb-controllers seem to be initialized=
 completely (visible in lsusb).
> > > >
> > > > r2pro has ID-Pin not connected, so i tried also peters Patch witho=
ut success :(
> > >
>
> --
> ~Vinod

