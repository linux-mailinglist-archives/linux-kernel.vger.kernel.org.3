Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313E8490A13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiAQONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiAQONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:13:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F67C061574;
        Mon, 17 Jan 2022 06:13:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m1so58135538lfq.4;
        Mon, 17 Jan 2022 06:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NhWmdpO0ww12Y4vGwaeCuxcyowg2Z3CLJR7KOrNG8jk=;
        b=QmoQI9Z8TXMYgST+9tYxQ6hfHkjTRGgRV9hmU/MUre5kRFxbz4VB51FguhUf5PG910
         Gt03+vL27lp+A1Q9dIy+RhFF5pEW4pXkULI4f5OCDNwQj9m7F39JVV8gXaAyEubSQxte
         GqxxZ9nni3WyXzQuKvyziB/6ROMxPZn6FncT7W3LhgVDiSolkq8k5KR4lwPJUghslBW8
         wBqX0Ld1ZAmOsb4zMXohNEhEzhmmiw1TpdV8Jpf8VOIqQekO3Y0JiuzxJVJk285dejA0
         lJUqtIFXClBOmqzkqibUXZQ0mNFB6cJrw6ZA14cD1lQbXQHjoStH9FZxxoGSgMXkZWgX
         WdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NhWmdpO0ww12Y4vGwaeCuxcyowg2Z3CLJR7KOrNG8jk=;
        b=fGBjPsRz9rnu+UrlS7NQrry2mbOeez9KRFfe2GPcHiovxtPE3OwSPBN5mKWoakN9IQ
         GJY30b1dDQ8qUuBnnW2paSNs9axrViyNdsCtSdW22zE8VVkHsJZ3m6XPp6J8BbY0+hOp
         99cMJLe0J84ElRI/6W5hi0MRhNh8YUbLN0l52MQDKOFyW3RTSbA+Nca/7/fqUQMnis4a
         HJcHO0Wm5yTfDGkV7sYml+G5k+lBwu1/lU2lyjQs8DI4+BB78K63LViBgYZ/4Bc0PfMI
         Ufak1CScjn/3xFKvKnNYyoOy8Fxfb3elDzROXS7gXNKRcys2ZtlszelZ/W0hw5x8vNGy
         3+lA==
X-Gm-Message-State: AOAM533EiRIH6bnwtBWVBkJqfucZMPyeRDvZud4PtKWq8CC9sGMp4036
        awIyOT5CHFqSFqUXRSo3nQ8=
X-Google-Smtp-Source: ABdhPJwlvEDpJUX3yDmk/G4z41azN6dgu1AcVgv8oPnyCIDyWNIHaVUS0GSW0lzwe6J1yfDX2JcS2g==
X-Received: by 2002:a05:6512:606:: with SMTP id b6mr16460100lfe.396.1642428795695;
        Mon, 17 Jan 2022 06:13:15 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id r9sm484433lfi.38.2022.01.17.06.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:13:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 5/9] arm64: dts: rockchip: add rk3568 tsadc nodes
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAMdYzYo2gkNvNYjU9_kc4cTwNBFU+kg3bRwaS3yCCAsMdo-Tow@mail.gmail.com>
Date:   Mon, 17 Jan 2022 15:13:14 +0100
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
Message-Id: <E3AA167E-1E40-45CD-8CBB-3EB280856604@gmail.com>
References: <20210728135534.703028-1-pgwipeout@gmail.com>
 <20210728135534.703028-6-pgwipeout@gmail.com>
 <C3AE0A81-A829-4241-A65E-EB28825E3C33@gmail.com>
 <CAMdYzYo2gkNvNYjU9_kc4cTwNBFU+kg3bRwaS3yCCAsMdo-Tow@mail.gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w =
dniu 17.01.2022, o godz. 14:49:
>=20
>>=20
>> Peter,
>>=20
>> I'm trying to use this series to get thermal on rk3566 based tvbox =
(x96-x6).
>> Driver loads but i'm getting following error:
>>=20
>> [  132.873979] rockchip-thermal fe710000.tsadc: failed to register =
sensor 0: -517
>> [  132.874650] rockchip-thermal fe710000.tsadc: failed to register =
sensor[0] : error =3D -517
>>=20
>> Maybe you have some hints here?
>=20
> Error -517 means -EPROBE_DEFER, a device it relies on hasn't probed.
> TSADC doesn't directly rely on anything that shouldn't already be
> enabled. (Pinctrl, clocks, and grf all break a lot more than tsadc if
> disabled)
> Does your kernel config have all of the rockchip elements enabled?
>=20

Peter,
For sure I can't say 'yes' with 100% confidence.
I'm trying do my best for rk3566 (currently have working: =
SD/Eth/HDMI/Sound/USB2port0/BT).

Maybe you may point me pls for good reference of rk356x defconfig?

btw: a bit of  context:
In my application (https://github.com/warpme/minimyth2) i have target to =
have single OS binary for all supported =
Allwinner/Amlogic/Rockchip/Broadcom devices.
By this kernel config i'm using is painfully assembled to have minimal =
working kernel for all targets.
It's a painful road....but still want to go this route for: minimal =
image size; shortest build time & one-for-all binary.
my current config: =
https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-5.16/f=
iles/linux-5.16-arm64-armv8.config

btw2: for rk3566 i'm using majority of your patches!=20
Great work of you!
=20


 =20


=20=
