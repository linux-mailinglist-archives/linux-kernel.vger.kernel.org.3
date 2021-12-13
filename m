Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4247349B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhLMTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbhLMTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:03:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A60C061574;
        Mon, 13 Dec 2021 11:03:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so56356701edv.1;
        Mon, 13 Dec 2021 11:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeN3kbi55XVQRg6vbM+PWPeSllCrgBWLk7uQ5eieCqg=;
        b=APcOG85AMzDYSGEB1dcrV+EUsa5duzreFvCy0d6ooQ8V8oJ9of9hksV0Ws7pj4bkeY
         p9tBGtPU+burvEAicFUYzMErHgKrxF/5fNywrqsUoJEULYcS5YmPtC+c5DcFQGLot1+C
         LZyoXDlA7Ek1q6oATQbBuPb2Qtjo03g/nOVjHi/4+NgmHMIA5S9C7yM2S6h0IonYFgvO
         wMSmbD8hpFbhZc7cRyJE+ck4xmFd8HcDeRgIBrFhofBHv8eTb48ehsROtN1gdRd2Bbx3
         MHIUgBd837+IP56Y+R389tjuObyrUHKm6V2Me+dAmL8ZRV+OY8J72MnOY15VWnNxAI2U
         vL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeN3kbi55XVQRg6vbM+PWPeSllCrgBWLk7uQ5eieCqg=;
        b=vwAM4pMAXpI+LwJRKvmOPwSfJsB5i4Jj2n1vcwX24Qlk/aY4oUdlWIebvy13ajOGtB
         JDlETokJwDD9XWzEr/OtwiIRn6JJBwvdTTxNf95cqGSdxZBfKZeZJxUeB+ivfoCXMQFl
         8Yjbx5byIEFnFTFe8HsO/ixLi1iJUChJuIioL/V+kd3J0Nwvh3xOSDN+C3GZyP4vmQ5o
         MEAFGxXyzyqmexLBNqEKKlVYB16uWjRMD2DE8/GJWQFziI7eYTwSTwYleN9eJuS4XvL1
         aBiWu5O/Kc3Vw+wdZvm5jsSZTaDU6f4HXIgtTJsVtNxIYVHDYO7nFYpQ80fvQRiYiPld
         D96Q==
X-Gm-Message-State: AOAM531zvvWgRsYpxU+S06BigiMG0Mg/l1EEzxJvAR8uaHGQmMA0+mlK
        yNLvfj4V7cKggtjyyYAr/9mQv3tdbPtB1W5xHZw=
X-Google-Smtp-Source: ABdhPJwPfMU/ScF1cDvqpPXDKs7AbSF/i2iWIwCjFaiQeSQYEowfwZ0JqRB1+ZY7awkN+Ma1J7SJj+8/6b0FSOD9Q7Y=
X-Received: by 2002:a50:f189:: with SMTP id x9mr808222edl.95.1639422181187;
 Mon, 13 Dec 2021 11:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20211213070330.3351505-1-rong.chen@amlogic.com>
 <2021121319503910358221@amlogic.com> <1j7dc83acm.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j7dc83acm.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 13 Dec 2021 20:02:50 +0100
Message-ID: <CAFBinCApJoC11S=weDwmVFAQNQHDfiBNSuO21KO=2+rsc4cJJw@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson: initial ocr available by default value
To:     Jerome Brunet <jbrunet@baylibre.com>,
        "rong.chen@amlogic.com" <rong.chen@amlogic.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "--to=1131046452" <--to=1131046452@qq.com>,
        45581586 <45581586@qq.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 2:25 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 13 Dec 2021 at 19:50, "rong.chen@amlogic.com" <rong.chen@amlogic.com> wrote:
>
> > Hello,
> > If 3.3V always-on power source for vmmc is supplied by hardware boards fixed, don't need regulator in software, so  .dts unnecessary the link between regulator
> > and MMC controller vmmc/vqmmc.
>
> Controllable or not, your vmmc/vqmmc regulators should be described in
> DT.
I agree with Jerome. Here are the two reasons why I think that it's
best to describe these regulators in device-tree:
- device-tree is there to describe the hardware. It's especially
useful for non-discoverable information (USB and PCI IDs are
discoverable examples), for example: voltage supply of an MMC
controller, UART IRQ line, ...
- reviewing board.dts would be a lot harder if we rely on defaults
(defaults which cannot be described in a device-tree schema). For
meson-g12a-radxa-zero.dts this means we could omit the vmmc/vqmmc
regulators for the SD card slot but we need them for the eMMC (because
vqmmc is fixed at 1.8V).


Best regards,
Martin
