Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60616472208
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhLMIAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLMIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:00:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF470C06173F;
        Mon, 13 Dec 2021 00:00:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r25so48700687edq.7;
        Mon, 13 Dec 2021 00:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6FKk19wLg5/5DanNVy/BnJQBLp86OcclKvVLtQ50Cg=;
        b=WuJro8kofehX89Gb5M3Dh7ue6WjBYH9KUzFFWSMHP6V02Lh0bcQN+0utDoA1tAgG9T
         om/TU37/M9erhiuC5C1hLymKoIj4pP2qbtwi6ku8ujJBu/rlEhnPUPmtqRuYsqS230Qe
         Mp87IN/ni1Flmkw6ErLxYTcanG0/gvVma5IaEeiXOcjxnAnqQA3mXJv/TGciUOR7b+cE
         8hGCJMZQyEMU4HLab1d45eerHsoU62jPS/882nfAc9FDT0GgkKd052EAlgu2IioHMcSU
         TnHAY9XVhZUsf2zG6tiKRXHTHkmHEh+z/dPBpbSDcxJSwMqzhSWl0eqRs1d9z4sDnA9O
         H8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6FKk19wLg5/5DanNVy/BnJQBLp86OcclKvVLtQ50Cg=;
        b=BNgw1HqusPnkTSgwHD7YRuFzZ2L37GJKam58FooUmohUEWyhjnmsSlnsZv0dKLofk1
         VHBh+N9xcB3fjYs4YFffiKCZmSDTXoFLcrba+g4FuTwilcGXjomytjR8Lu4+pBwL486P
         BGJZucLbo7oEKNU78gRd2r1HYnv8/f/IIWZDNVi6uMl0EcHqoNIqME95nzeB36468KDA
         ojDkKwVGOv8yt3vYfhhDnb4AlnePoqL2JurAi+iz+SIdpxYH/hfwu+o87uB3RNpAyTo2
         okmoalm+qKoHuSMn1975qOASf3wTp2z3giDhL2quC6wc71uaZjixqnOq3Uw6ClZbyN6u
         Bzhg==
X-Gm-Message-State: AOAM531F3HUSt95J+KKOgLeKFAiXP7fK3r53bka+T58ByZ50izM4gYy7
        j/0Jl/l1jxAcLdmLKEOm3hMd3ALFKN7aDDj7wps=
X-Google-Smtp-Source: ABdhPJzyAV6hcirGTfopAi5t2oKVXclfJJBFKcRP9UOMftdSaUhg/5nzA/QIbd585iWLWgHLkbqFFf05XXoGq67+v3s=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr61063698edt.195.1639382427393;
 Mon, 13 Dec 2021 00:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20211213070330.3351505-1-rong.chen@amlogic.com>
In-Reply-To: <20211213070330.3351505-1-rong.chen@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 13 Dec 2021 09:00:16 +0100
Message-ID: <CAFBinCCr9RQReHOJbb=spcVRxM0aRo=Z3YMz_zxA_qiFBDzwWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson: initial ocr available by default value
To:     Rong Chen <rong.chen@amlogic.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, --to=1131046452@qq.com,
        45581586@qq.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 13, 2021 at 8:03 AM Rong Chen <rong.chen@amlogic.com> wrote:
>
> The patch will add a value of ocr supported by the controller,
> to specify some of voltage values are supported.
Can you please share some details on this topic?

We already have many boards upstreamed which work fine without
manually setting ocr_avail in the driver.
In general there's two types of boards:
1) boards where the regulator can switch between different voltages.
One example is the Odroid-C2, see meson-gxbb-odroidc2.dts [0]
Here we specify:
  vmmc-supply = <&tflash_vdd>;
  vqmmc-supply = <&tf_io>;
&tflash_vdd is either turned off or at 3.3V when turned on.
&tf_io can be either turned off, 1.8V or 3.3V.

2) boards where the voltages are fixed.
One example is Radxa Zero, see meson-g12a-radxa-zero.dts [1]
For the SD card the board uses:
  vmmc-supply = <&vddao_3v3>;
  vqmmc-supply = <&vddao_3v3>;
(meaning fixed 3.3V always-on power source for both VMMC and VQMMC)
and for eMMC the board uses:
  vmmc-supply = <&vcc_3v3>;
  vqmmc-supply = <&vcc_1v8>;
(meaning: 3.3V always-on power source for vmmc and 1.8V always-on
power source for VQMMC)

With the information from the regulators the MMC core will
automatically detect ocr_avail in Linux.
Or in other words: your .dts may be missing the link between regulator
and MMC controller vmmc/vqmmc.
Can you please double-check this?


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts?id=2585cf9dfaaddf00b069673f27bb3f8530e2039c#n354
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts?id=2585cf9dfaaddf00b069673f27bb3f8530e2039c#n333
