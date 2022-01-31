Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9903C4A3DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiAaG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiAaG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:29:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF0C061714;
        Sun, 30 Jan 2022 22:29:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h8so4623149qtk.13;
        Sun, 30 Jan 2022 22:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8xVVlTXCH5dzzfG9cCSQy47QYWU3pZiA5VxSxCNN/iE=;
        b=HV5VHgSWYz99VYy96+UH45wW+9Uy5noFrXqiFf70PkSLMC3fyx4v2gS8tDQEile/Bj
         RHgkSOtRxR0rNd1cpc9Wee2Syj1bgqD2SRgS9ANdEPo1/aLvWD+MCl5tFLk7Rq+Mxcsz
         WjKBnjsM2kaPVaE3N+LctKOJyDos3WOfpS+bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8xVVlTXCH5dzzfG9cCSQy47QYWU3pZiA5VxSxCNN/iE=;
        b=TIDXxCptxEhharFByAo2LxfUB1iNgc1Z7Avm8ah7xJ4umUZog1Z0BYZ6h4Vz4rpq+e
         GoFgMZYsgeMhVDbD7oWnqcGP8/nRfuu4AnjIbuJj0VYm+rXaXITQeU4G128LooAQgA1b
         xWmJPohQJpVnJiyRraHIu78bIjX8EUYVM93qUx7wfbaD8qHr5MICqKbrzqY5dHddTusf
         5FowdJ5JoP90Gf2ea9CzmSVcY3py2XSN+L8VBeGDCUpC2vC/1upKT62kmq8Sdskn7Gul
         9BpExujikxXFKMVODu/bqb55MKers/Gtt1GSAkXw+E9plcCrRk+oOwcoRywekMVV/U3l
         z7gw==
X-Gm-Message-State: AOAM532QWhif3hmuM/5T4pcfXSyk8Rvh7c7A9W57KHw4VyK/Ym784Q1i
        TV9za0J+SFCFURLhhOplhOpUdJH9xUe9LDJdVAw=
X-Google-Smtp-Source: ABdhPJx/zGloFa7YAI6lleFOSE5SaNeGSjSF5aHLos6yTuSHD0OXY+2KHx+dL5ubhRMTMsH+pl9NuEiuUHP9ctxPDiU=
X-Received: by 2002:ac8:7e91:: with SMTP id w17mr13681193qtj.678.1643610594671;
 Sun, 30 Jan 2022 22:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20220129092957.2189769-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220129092957.2189769-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 31 Jan 2022 06:29:42 +0000
Message-ID: <CACPK8Xfa8dYaAqg=8MA7zm82ve-K+t_sCfwXF82-9EV97rUYNg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: nuvoton, npcm7xx: remove bogus unit addresses
 from fixed-partition nodes
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 at 09:32, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> The unit addresses do not correspond to the nodes' reg properties,
> because they don't have any.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Do you want to add a Fixes: line?

> ---
>  arch/arm/boot/dts/nuvoton-npcm730-gbs.dts            | 2 +-
>  arch/arm/boot/dts/nuvoton-npcm730-gsj.dts            | 2 +-
>  arch/arm/boot/dts/nuvoton-npcm730-kudo.dts           | 6 +++---
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts            | 4 ++--
>  arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts | 6 +++---
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dt=
s/nuvoton-npcm730-gbs.dts
> index eb6eb21cb2a44..33c8d5b3d679a 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
> @@ -366,7 +366,7 @@ spi-nor@0 {
>                 spi-max-frequency =3D <20000000>;
>                 spi-rx-bus-width =3D <2>;
>                 label =3D "bmc";
> -               partitions@80000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dt=
s/nuvoton-npcm730-gsj.dts
> index d4ff49939a3d9..bbe18618f5c56 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
> @@ -142,7 +142,7 @@ spi-nor@0 {
>                 reg =3D <0>;
>                 spi-rx-bus-width =3D <2>;
>
> -               partitions@80000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> diff --git a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts b/arch/arm/boot/d=
ts/nuvoton-npcm730-kudo.dts
> index 82a104b2a65f1..8e3425cb8e8b9 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
> @@ -388,7 +388,7 @@ spi-nor@0 {
>                 spi-max-frequency =3D <5000000>;
>                 spi-rx-bus-width =3D <2>;
>                 label =3D "bmc";
> -               partitions@80000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> @@ -422,7 +422,7 @@ spi-nor@1 {
>                 reg =3D <1>;
>                 spi-max-frequency =3D <5000000>;
>                 spi-rx-bus-width =3D <2>;
> -               partitions@88000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> @@ -447,7 +447,7 @@ spi-nor@0 {
>                 reg =3D <0>;
>                 spi-max-frequency =3D <5000000>;
>                 spi-rx-bus-width =3D <2>;
> -               partitions@A0000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dt=
s/nuvoton-npcm750-evb.dts
> index 0334641f88292..cf274c926711a 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> @@ -74,7 +74,7 @@ spi-nor@0 {
>                 spi-rx-bus-width =3D <2>;
>                 reg =3D <0>;
>                 spi-max-frequency =3D <5000000>;
> -               partitions@80000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> @@ -135,7 +135,7 @@ spi-nor@0 {
>                 spi-rx-bus-width =3D <2>;
>                 reg =3D <0>;
>                 spi-max-frequency =3D <5000000>;
> -               partitions@A0000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts b/arch/=
arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
> index 767e0ac0df7c5..7fe7efee28acb 100644
> --- a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
> @@ -107,7 +107,7 @@ spi-nor@0 {
>                 reg =3D <0>;
>                 spi-rx-bus-width =3D <2>;
>
> -               partitions@80000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> @@ -146,7 +146,7 @@ spi-nor@1 {
>                 reg =3D <1>;
>                 npcm,fiu-rx-bus-width =3D <2>;
>
> -               partitions@88000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> @@ -173,7 +173,7 @@ spi-nor@0 {
>                 reg =3D <0>;
>                 spi-rx-bus-width =3D <2>;
>
> -               partitions@A0000000 {
> +               partitions {
>                         compatible =3D "fixed-partitions";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> --
> 2.34.1
>
