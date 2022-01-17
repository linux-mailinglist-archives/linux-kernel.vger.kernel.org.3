Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF33490AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiAQOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiAQOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:53:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F3C061574;
        Mon, 17 Jan 2022 06:53:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o15so58480906lfo.11;
        Mon, 17 Jan 2022 06:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=onWdt0fyeqqEsMifvTUGSb7FG4MeJVVCrnl4WB/xhwg=;
        b=HlBqFcVJUgeG+7AzJjGBH0RvzQNnFMma5/bY22sKBRoLna4EicyPr5dp5uy+m/kif7
         sw4UvpGlY1XCqoek48qGhJoVrK1PV41rEYtzYJ1FhoQGb0vb1z2eaSTlWDTkBRjsPFgA
         iJmJcExF29aZEVSsKjpMHdBDdar/ZYhsYQEhQ9dT2CdgZHoDZ5eA4leKvMVLYiwJE1Nr
         k37RKbl6BCJ41ZStGYk/h33vS9OpAHi9av8S/VOCGIfa1QL5jSuqwN97WCV+GIGF3Cy3
         Sk4XDGZly2uPs1+RLDGjolamZ91PIuGkTrBy2bzKdoNMIM1hEBbY30rcf5Bd/k8fdYu1
         wUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=onWdt0fyeqqEsMifvTUGSb7FG4MeJVVCrnl4WB/xhwg=;
        b=GiTWchsnh/k2l40D+LFFqZWx6ddIl4CTo8uX+Z4d5Nc+gvWGm6SMnA6LByAZJ94/7A
         XrFaXg8YuWbDPW+9DE/OBmNVpNkM8tqN+okwXZJzhQlKnCOmDsh+lQvQ2XbIWpC0WcNI
         YCfTgktusT5BLH8YnQzIS4I2Q9yflL9fncpnecSMcrTjWaeHlsKqHGVShfCEeIkdnmEL
         EsDkdhk+ruiakF6kCL/Cu80QYnvtvX+j6/14iSJMCNiYrS70GLFNtbash/lKfEWB4gWb
         ZkADBKlGhUTwVsdDpfDWXNxPImDxTBx7iZmRvqePxeSKMf6ebZjWSWXXkYTDx85tGHRF
         DgIA==
X-Gm-Message-State: AOAM5308StXjC7weVIEb9yhYQ6+OpEU0ZxR/g3jKzMhdLnAdnNTbioID
        gp67YNzB3EwaAn3uesnlUdQ=
X-Google-Smtp-Source: ABdhPJzCgLZE2f1V4ZTHHLY0+82A8Z0lem/5f4KqeZD0C75yveNJ5NrqaZPCkP/ybtda2xUf2KLx8g==
X-Received: by 2002:a05:6512:2606:: with SMTP id bt6mr16873651lfb.202.1642431185384;
        Mon, 17 Jan 2022 06:53:05 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id p13sm1418432lfa.42.2022.01.17.06.53.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:53:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 5/9] arm64: dts: rockchip: add rk3568 tsadc nodes
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAMdYzYqsPgAbLBt+xwDL2s7ViLDJw5mnzDnupimRVESt0xFksQ@mail.gmail.com>
Date:   Mon, 17 Jan 2022 15:53:03 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6AF0F12-FB41-4C60-96AA-660C1E8B379C@gmail.com>
References: <20210728135534.703028-1-pgwipeout@gmail.com>
 <20210728135534.703028-6-pgwipeout@gmail.com>
 <C3AE0A81-A829-4241-A65E-EB28825E3C33@gmail.com>
 <CAMdYzYo2gkNvNYjU9_kc4cTwNBFU+kg3bRwaS3yCCAsMdo-Tow@mail.gmail.com>
 <E3AA167E-1E40-45CD-8CBB-3EB280856604@gmail.com>
 <CAMdYzYqsPgAbLBt+xwDL2s7ViLDJw5mnzDnupimRVESt0xFksQ@mail.gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w =
dniu 17.01.2022, o godz. 15:38:
>=20
>=20
>=20
> Your issue is in your dts.
> You have retained the quartz64-a &cpu_thermal active thermal node
> without tying in an active thermal control device (a fan).
> By default the rk356x dtsi passive thermal trips are hooked up and
> will throttle the device in case of overtemp.
> If your device has no active thermal control, you don't need to add
> the &cpu_thermal node at all to your dts.
>=20
>>=20
>> btw2: for rk3566 i'm using majority of your patches!
>> Great work of you!

Peter,

Many thx!

Now it works nicely:

cpu_thermal-virtual-0
Adapter: Virtual device
temp1:        +33.8=C2=B0C  (crit =3D +95.0=C2=B0C)

gpu_thermal-virtual-0
Adapter: Virtual device
temp1:        +34.4=C2=B0C  (crit =3D +95.0=C2=B0C)

again: many thx!



forgive me unrelated q:
may hint me for script you are using in your gitlab ci for building =
quartz64 u-boot in ci pipeline?
I'm using yours binaries - but want to add building from sources in my =
project....=20


