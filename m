Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F048EE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiANQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiANQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:25:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F97C061574;
        Fri, 14 Jan 2022 08:25:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o15so31807233lfo.11;
        Fri, 14 Jan 2022 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QwE6AvJ6TOilf5yaAEqCv7rrahQ353A7bMEMih1/r24=;
        b=XeV5CDiNpJvjEs3AJNu/gGrbbC24PdhwUSqDz0k50thtLMscmQvcTEXh+jZvItQd8J
         lKjW0G3oubKR21qu0ig+JY4t1uFcNqgL2JpxvmOynmNzED6sfB1LkFuEHwTQa8VUjvad
         0/K/BDltJoeEQ3b4HNnm6h5uGBNCiXwFbnCdlb/ry7wjMf7n8V+2fdb6Xh2SfOPvAKya
         SAbD1zWJ7uMjodV+upvNzY7KUEuZTtGIyKviJOsTlKdv9Q7tNkAdr6pHujoQJPT+UM6v
         /CVVoWyADdOA3evsQTvLhdNkxKV6x75LK4K1KdkgjgkxHxwBjhxyp2icerjBUBIwqqne
         ZL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QwE6AvJ6TOilf5yaAEqCv7rrahQ353A7bMEMih1/r24=;
        b=3lWMKRBet0Ar7IF9mvuav1j+Ns8k24g7fZ9RP1pFmXWQKET0NlLRCyOpcaZr54if+g
         qqTFwEWKWFebV7wNz5jFyVk8AXd9af29Ah31bqYmIYrzsu9IInj5hYbhX2bR9uLCPwdv
         WaYTej4LqftHCXuynBS7VNA12gYwHnC52wWif3SnfaeMhZs8oPUxDtpAsBOG8eUSZjdO
         AVWHGN1vTxy2EfKqlUMxtD0KLAY8Zgr9Q016araIlZi/dQKFwbAgzoAJxp1a5EHKdcP/
         znrrv43mu/owE73kVQ3d1gtHgJXsE2R+5cphVmvq1i36+Pc3Lts5BERoaZG+EpishENT
         MJ9A==
X-Gm-Message-State: AOAM530KQn8zdjqozSii9NetuaTb5EryQSu7qLAQaQVyvNhgPL6t7mKs
        eAOFtsXAVM43xIAmYnbFyPU=
X-Google-Smtp-Source: ABdhPJzAtX8W5nnGJkY9MsLkTDjaWEi4MR8t/UfTWxyPXJPk1n/X48n1WzmZr0wBUxhuuI0fqrnJLQ==
X-Received: by 2002:a05:6512:308c:: with SMTP id z12mr1671336lfd.35.1642177539071;
        Fri, 14 Jan 2022 08:25:39 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id p17sm625405lfu.233.2022.01.14.08.25.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 08:25:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Enable the GPU on Quartz64
 Model A
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20211126151729.1026566-5-knaerzche@gmail.com>
Date:   Fri, 14 Jan 2022 17:25:35 +0100
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB2E04F1-BACA-4A4F-97F9-0257F29D57B5@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
 <20211126151729.1026566-5-knaerzche@gmail.com>
To:     Alex Bee <knaerzche@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Alex Bee <knaerzche@gmail.com> w =
dniu 26.11.2021, o godz. 16:17:
>=20
> From: Ezequiel Garcia <ezequiel@collabora.com>
>=20
> Enable the GPU core on the Pine64 Quartz64 Model A.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts =
b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index 4d4b2a301b1a..625489c60622 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -205,6 +205,11 @@ &gmac1m0_clkinout
> 	status =3D "okay";
> };
>=20
> +&gpu {
> +	mali-supply =3D <&vdd_gpu>;
> +	status =3D "okay";
> +};
> +
> &i2c0 {
> 	status =3D "okay";
>=20
> --=20
>=20

Alex, Ezequiel

I'm playing with 5.16 mainline on rk3566 based tvbox (x96-x6)

Box boots and I have working SD card, Eth, HDMI.

I applied this series as I want to get GPU working but I'm getting:

[    3.169144] panfrost fde60000.gpu: get clock failed -517
[    3.169646] panfrost fde60000.gpu: clk init failed -517
[    3.213653] panfrost fde60000.gpu: get clock failed -517
[    3.214156] panfrost fde60000.gpu: clk init failed -517
[    3.230505] panfrost fde60000.gpu: get clock failed -517
[    3.231006] panfrost fde60000.gpu: clk init failed -517
[    3.258072] panfrost fde60000.gpu: get clock failed -517
[    3.258575] panfrost fde60000.gpu: clk init failed -517

Maybe you have some hints here?


