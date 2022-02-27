Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADCE4C59F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 09:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiB0IOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 03:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiB0IOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 03:14:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7413EAE;
        Sun, 27 Feb 2022 00:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645949622;
        bh=CBoV8ODIiZ4otV26RH+UDOxaWaSm2+1iqQDPLbFEFwU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V70pDzMIgOU0tK2UIyi2eQaG0NTXNjLjJCacIzwGD+7rUDKzcf76Zk8CCPRpWPJ64
         ALB5yi6A0ZC3o/8dxOOT8ICH/lsCG1lCeXW0k+2koAlrgXKNm2SbGqksyIaezWc1Ii
         IqbXVLXmzMUrHGpGahcGY7KGbt4TqWp9/JJ1Tt/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.76.205] ([80.245.76.205]) by web-mail.gmx.net
 (3c-app-gmx-bs39.server.lan [172.19.170.91]) (via HTTP); Sun, 27 Feb 2022
 09:13:42 +0100
MIME-Version: 1.0
Message-ID: <trinity-005e10e1-b6fd-4573-956d-3f474c3c9ae2-1645949622469@3c-app-gmx-bs39>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [PATCH v1] arm64: dts: rockchip: Add sata2 node to rk356x
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Feb 2022 09:13:42 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAMdYzYro7r2nELu2O4TuxxtZLxNSv1e3iU5yBzjd7AQgHP+FPw@mail.gmail.com>
References: <20220226135724.61516-1-linux@fw-web.de>
 <2815432.3mA4caTK8C@diego>
 <CAMdYzYro7r2nELu2O4TuxxtZLxNSv1e3iU5yBzjd7AQgHP+FPw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:yI6VQbuHD0V179iz/NvKAtzuqEHuGyBQnL6Qz25j679nLrC9g2CpYQDahzgWxkjkPIYVj
 MKgMgUXtXEgDEC7zjdjU+TcoX51Wdts+fwXqSSyJFipNXYh1COeCAwKMRlAP69AAUkAOOKp8/R/A
 kAwgLCLKzhmU9b+HaXhebNSUJs2RbnZx2DEULv9FoXrdHxtiMm1IGybCPbqnV5fWiJwllcCgXxoI
 t8al0OGjjsQgozRNZz46gGV79LGQ1zaf22vCwDi0PYX43i8a+bCiaolOkn/TtpScELlvnf75lsoj
 9o=
X-UI-Out-Filterresults: notjunk:1;V03:K0:UygpNT5sHHc=:T3eRL5nuQIRyis4orHoxYZ
 aexhmE3dB2/0TZmn7PJMRroLvkI7tfXFVAXhhlBiQ0XKI8YH74WtSTp5JmzoaE3s8i6jXIEdQ
 TdAoejdPSsGqFCkiTAXoHsQhyeFL7DTAfKpmaiUqYaw62KNxuTDvbnvoxk+EKz8ZTHz34L76W
 XHSzjFwPtUI3+0nfFwmlSe73WN6isS+tSRNFNDfwDmWdakIHlfcduVNE2sciCRzTtXYrop4BL
 MCBTvryA2sqUS1NAxiGitFsXs3qQWHAymjkAfERUcHSJ0fxg5OrUn7WHIJRchhyEMKpVdSy45
 etyc98YIKVasiY1CFzDgDXKIl3CVTppwh4y/Bq7We4UnBmR5agOBcWOLXj5YGyia0QHHd54Ol
 YsOpgxlYDTZaGomP02wlgvLitnS4aQbb/foNgwhkRGPdlgaGuRrDBzUzePGbHfT5DC7max75p
 ODfdmhMe6V/Ea+pVhu2X6349eFBm5nYpenaDIkDFkCowqoxFLqA2Fcll3FbyB8wpDOTOU2IEX
 6PFqMVvZa2nPhwkKRcke7wkaXB2csvlRVO2nckd0yCUz56qkxR8GfzFfKQT4AqNZLIz8RxrjR
 IQHMzCWnsdoWnXwfkwA8zFGBqtAi60gRV7ErxvydDFWPGW2Wl/2SrSujNYA0JHNn9TaaMgpQs
 uJ53rlosnLwc0GXoafHBqY51I6iOLvB4+FfUJ4FXCQR8Nk2WgKq2ZM6cPSKxzzcBYZBDNVAfJ
 b5giOUrfaUDruoXvVTISrF+X9Qfj+U5tiut/eKVYkh+AGElEuUL+Tjek2UOgwYUeHok4sfrM0
 lm7SPqp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Samstag, 26=2E Februar 2022 um 19:15 Uhr
> Von: "Peter Geis" <pgwipeout@gmail=2Ecom>
> On Sat, Feb 26, 2022 at 1:08 PM Heiko St=C3=BCbner <heiko@sntech=2Ede> w=
rote:
> >
> > Hi Frank,
> >
> > Am Samstag, 26=2E Februar 2022, 14:57:24 CET schrieb Frank Wunderlich:
> > > From: Frank Wunderlich <frank-w@public-files=2Ede>
> > >
> > > RK356x supports up to 3 sata controllers which were compatible with =
the
> > > existing snps,dwc-ahci binding=2E
> > >
> > > My board has only sata2 connected to combphy2 so only add this one=
=2E
> >
> > how far does the added node diverge from the vendor kernel?
> >
> > If it's pretty much similar between both, we can assume the other node=
s
> > should work pretty well as well and therefore should all of them at on=
ce
> > and hope for the best?
>=20
> There's essentially zero divergence (minus the change due to combophy
> changing), and likely won't be until the ahci-platform=2Etxt is
> converted to yaml=2E
>=20
> I have tested both SATA1 and SATA2 successfully on the rk3566=2E
> I don't have any rk3568 boards that are operational yet to test SATA0=2E

Like Peter says, the sata-node(s) is basicly same as downstream, only comb=
phy-label has changed=2E
Sata1 from Peters tree [1] seems to have only this change=2E
I'll send an followup containing all 3, but had only tested sata2=2E

already sent a bindings-patch for the ahci-platform=2Etxt [2]

regards Frank

[1] https://gitlab=2Ecom/pgwipeout/linux-next/-/blob/main/arch/arm64/boot/=
dts/rockchip/rk356x=2Edtsi#L238
[2] https://lore=2Ekernel=2Eorg/lkml/20220226204404=2E109867-1-linux@fw-we=
b=2Ede/T/
