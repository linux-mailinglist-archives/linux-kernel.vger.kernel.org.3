Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBB480299
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhL0RIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhL0RId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:08:33 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5045C06173E;
        Mon, 27 Dec 2021 09:08:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o6so64008082edc.4;
        Mon, 27 Dec 2021 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CP3XLT+70/9TbwzYF+eOW8bBY3OtuRCt28EaG1yMPjI=;
        b=ZnWgZ0/0+2JOJyXbSy/uJJqVU9N3F81fLwani2ZdxqnjQ6ee+RKGAnTIPGF3VTsQrv
         cGkJvJlXYxfFRcESX6Pep4WvIMU+U37QjIhQcz5I+XGEZD41vGYKR/lsod8ChOEXq0C3
         FWPM+c6olxDPS4EQOmijx/UDUr2z/aOQ3jOzwm1hYnW9+sh6pm+DgaRPFojfC74wJ2c8
         GI25ZBCRQc+WVcoslQOmdszG+hppBi2CMx5b+JBy+o2QGToU8BXiJWZGWxGlt3/FiklY
         KABhbwkW7OWX7FrWeDr1J5qUIgX6fM53zrs8wMnuV+nQOzmKxfbIv/DWK2iXaq5k2dMU
         r13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CP3XLT+70/9TbwzYF+eOW8bBY3OtuRCt28EaG1yMPjI=;
        b=HZNPMahL5J6Psp99tCv5R7XwBx6qTvdVB0Dn/K8CKRc5MP6NQywEq4z8qgskAwMtH2
         NKZ+Cyfa8c16i52Tkl0L3CrXvNzAk2TheQjXaRVA+gxSid1nqJ68NK2KXwm6ZYtIeVO+
         mYTCNunAXArnBoLdQytD5zV7nwLbe+VFkiKr/AQVPBQMiTS98ZCqzAgO8jXaH1w8DweS
         aSboiHfYljdxT6DrubKe9xUMFBGifDZralb1lyChviKo8xOUVijONuuTHfp5LSHD5LQz
         VXUKrisnWe222ive2fpiz/u95YzXUf+ygkhuntG5nuMzg+hQ8aP5egfBUFxs4NMZ+4RS
         +u+w==
X-Gm-Message-State: AOAM531zJF1j63H8Bg8QUxLCUwhokUL90xreGZd/pvQVZ5YzfS44BKuI
        yGJNz+CLJ2xAKWOcBxCPer37u/jVZl6TnV5QAYU=
X-Google-Smtp-Source: ABdhPJwpCEJ3+l77fWb2qzfj5ZSxrhjxVBVPcL+FNzq7vm4rd82I+aiVNvv5fk2DIsZzjCAxljBFKp/Di6bSsbjLSo8=
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr17033688edb.32.1640624911401;
 Mon, 27 Dec 2021 09:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20211227054529.30586-1-xianwei.zhao@amlogic.com> <1640619206.696540.519387.nullmailer@robh.at.kernel.org>
In-Reply-To: <1640619206.696540.519387.nullmailer@robh.at.kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Dec 2021 18:08:20 +0100
Message-ID: <CAFBinCAhbJUevamYqmzrFsVcXoK8Wcntem9VmYUpBL8ktEsVAA@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: serial: amlogic, meson-uart: support S4
To:     Rob Herring <robh@kernel.org>
Cc:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kelvin.zhang@amlogic.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-serial@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 4:33 PM Rob Herring <robh@kernel.org> wrote:
[...]
> serial@84dc: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/meson6-atv1200.dt.yaml
>         arch/arm/boot/dts/meson8b-ec100.dt.yaml
>         arch/arm/boot/dts/meson8b-mxq.dt.yaml
>         arch/arm/boot/dts/meson8b-odroidc1.dt.yaml
>         arch/arm/boot/dts/meson8m2-mxiii-plus.dt.yaml
>         arch/arm/boot/dts/meson8-minix-neo-x8.dt.yaml
The warnings from this section (affecting arch/arm/boot/dts/meson*)
have been there before this patch already.
I am going to send a patch to clean them up so it doesn't cause
further confusion in the future.


Best regards,
Martin
