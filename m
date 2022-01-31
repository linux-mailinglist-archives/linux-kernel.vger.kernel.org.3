Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8495B4A3DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347941AbiAaGiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiAaGiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:38:03 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E520C061714;
        Sun, 30 Jan 2022 22:38:03 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i19so11947536qvx.12;
        Sun, 30 Jan 2022 22:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZmJmzbYJdSz7NylPj17Q8RGKEXMSub9wumTNZ+fAg8U=;
        b=Xy2fms+AqaxyVKZTW4zyYJ+aN04U3xviqKmYn35+s3p2unWf9DXdGnXBcb4lxdu8DH
         AtaPGxa8K+opiTflXIZWKZvl3sqaMg6BcftR99n57Xyny3cmZneGpR/jh4q2pP5/+2BB
         9pFtmZbmfXUuWQAhXBfW48I5A4SYS5fIqTL80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZmJmzbYJdSz7NylPj17Q8RGKEXMSub9wumTNZ+fAg8U=;
        b=n8qMnQmC9QQHj39mOSgDdw38tnJLwzcho9dWQcXkeMI7ccnWHPXS4dWQ98VmNDwvn9
         lxhLtnjvWruuhJsR1bQ0KBE1CULvivXis6vFumcxhkVMZeF0STeXudI2Yj/KjtmF4YYY
         KwpIFz1SMbZjTjyzToNwvyk/Bjk61jSlxt1Uf7u/RGZHYXgzA4ohhWEahMEhggocOFjh
         VyDpQALjiCBZw74ILaPzD89RtWs3kdS67q1DO5sKwMrpAb76LDammqdjNrx3Um2er8KD
         uOEMB30UL1LLmnHnEX2Buu5M4xZ56dgQqJWReIHd6rcvEJFxS8kAwx8xSpRXLfaK9wuF
         2ULw==
X-Gm-Message-State: AOAM530HBv2pfDGGRSwfFg0dccCgphwrOI/VRmH++uolefZnIQRmTP0H
        hurnJo0ydGoEllyTZuUY+/cZS1i4S5qI2m5wzjAy5KoC
X-Google-Smtp-Source: ABdhPJx1020Led5CofoA3z+V3gy1g+2fDQqlgS0Xv7rjVb+e3dfv58hq0e7zyqgRD60MdN/0J1KfxNEzSFCbgMZezwk=
X-Received: by 2002:ad4:5f89:: with SMTP id jp9mr16312804qvb.130.1643611082608;
 Sun, 30 Jan 2022 22:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20220128221054.2002911-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220128221054.2002911-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 31 Jan 2022 06:37:51 +0000
Message-ID: <CACPK8XfMm7jJ9QYOBr1HiR_22xPEzx9MZXO_CX7MpQt2QAVSUg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: wpcm450: Enable watchdog by default
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 22:11, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> The watchdog timer is always usable, regardless of board design, so
> there is no point in marking the watchdog device as disabled-by-default
> in nuvoton-wpcm450.dtsi.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

I assume this makes it always available for rebooting the system too?

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts | 4 ----
>  arch/arm/boot/dts/nuvoton-wpcm450.dtsi                      | 1 -
>  2 files changed, 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts =
b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
> index 3ee61251a16d0..1ae7ae4804275 100644
> --- a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
> +++ b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
> @@ -77,7 +77,3 @@ &serial1 {
>         /* "Serial over LAN" port. Connected to ttyS2 of the host system.=
 */
>         status =3D "okay";
>  };
> -
> -&watchdog0 {
> -       status =3D "okay";
> -};
> diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/n=
uvoton-wpcm450.dtsi
> index 93595850a4c3c..b9b669cd632f1 100644
> --- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> @@ -81,7 +81,6 @@ watchdog0: watchdog@b800101c {
>                         interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
>                         reg =3D <0xb800101c 0x4>;
>                         clocks =3D <&clk24m>;
> -                       status =3D "disabled";
>                 };
>
>                 aic: interrupt-controller@b8002000 {
> --
> 2.34.1
>
