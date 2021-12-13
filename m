Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC15472D34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhLMNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbhLMNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:25:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0392AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:25:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so26998519wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=RGPKFGhr5F/E/uf8UwQ+T3hkhLoaT6Ka+qKxD0TAy+M=;
        b=JRkDFvB8MdbonLD5orH08ZpszbX+Hsq3f2nwGXw96fpGnPaqFoDrqvRETDKF5sU6KK
         xv3lQs9hvrmLFrUwoek0ZdOCHIuojptCQ1yWZHykSwAgLE/SK6SBW8pbq4FqAu6g9nWv
         924DpmYSw9ztdMDswaJf/WeLEqNSOOnxXB79SMBeaPNt8+ZkHgAD3h7s6ihu2/KyXDHx
         vg3QHBv5UPPh3eocemTtBBTTBzaqVjFJQV3N5wg3P+YsDm+0LqQNe1yuhHyH/jGmUPsq
         Z9s8l5gopJr2ohzjBHONWx2A7IsPSOM+b/Ws8sScQj3jhDNEsgf+fPLbKBmk1rPPAI0D
         0Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=RGPKFGhr5F/E/uf8UwQ+T3hkhLoaT6Ka+qKxD0TAy+M=;
        b=HtlQourgPS4rhJJkiO9RBBP8LcJoU8KTUXxiNH+UCa0F9a+x6Nz5WtEyDineeVY58i
         FnN/3yXiHZTJ9B0kj4e6asUaJlrrNF3psB6NGXNZQA0qLzioR3jZGpxLJUhyFiki26e/
         CP3DyJ/pfpRuk489r7kWD5VlhbJAIUbCYsS3txqzbZAWrfZaZpuXRNP85c76vHpFNHKj
         seqi1IaYk1eh5k0gg1HClPhQCfrOjnVo6TrdJrTfJNDELilNNr7VHmoIMdi/pQwrXTC4
         p02OBStcRHCDZArMuhGlQtVStC4zJtISSAC6oYtCYrC4MhvRZzka3zlhk3C4WpQKK9/4
         qCFg==
X-Gm-Message-State: AOAM533CNfvwFs/GNrqlza6Vl1xh63SRXhxjfw9hqdcuTdrwWB0b1rEE
        KYnxNvSMvgMT//7qWoS6E6cT8w==
X-Google-Smtp-Source: ABdhPJxzzui67Mz+e62UPdxoEnqUeAe7pmkET3SPW+dmE86hGQS6DQJSsCelC6Y5tYdI7kls55z4kg==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr15577018wrn.690.1639401946598;
        Mon, 13 Dec 2021 05:25:46 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g198sm8086757wme.23.2021.12.13.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:25:46 -0800 (PST)
References: <20211213070330.3351505-1-rong.chen@amlogic.com>
 <2021121319503910358221@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "rong.chen@amlogic.com" <rong.chen@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        --to=1131046452 <--to=1131046452@qq.com>,
        45581586 <45581586@qq.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: meson: initial ocr available by default value
Date:   Mon, 13 Dec 2021 14:22:25 +0100
In-reply-to: <2021121319503910358221@amlogic.com>
Message-ID: <1j7dc83acm.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 13 Dec 2021 at 19:50, "rong.chen@amlogic.com" <rong.chen@amlogic.com> wrote:

> Hello,
> If 3.3V always-on power source for vmmc is supplied by hardware boards fixed, don't need regulator in software, so  .dts unnecessary the link between regulator
> and MMC controller vmmc/vqmmc. 

Controllable or not, your vmmc/vqmmc regulators should be described in
DT.

There are several examples of this in arch/arm64/boot/dts/amlogic/*.dts


>
> ------------------------------------------------------------------------------------------------------------------------------------------------------
> rong.chen@amlogic.com
>
>   
>  From: Martin Blumenstingl
>  Date: 2021-12-13 16:00
>  To: Rong Chen
>  CC: Ulf Hansson; Neil Armstrong; Kevin Hilman; Jerome Brunet; --to=1131046452; 45581586; linux-mmc; linux-arm-kernel; linux-amlogic; linux-kernel
>  Subject: Re: [PATCH] mmc: meson: initial ocr available by default value
>  [ EXTERNAL EMAIL ]
>   
>  Hello,
>   
>  On Mon, Dec 13, 2021 at 8:03 AM Rong Chen <rong.chen@amlogic.com> wrote:
>  >
>  > The patch will add a value of ocr supported by the controller,
>  > to specify some of voltage values are supported.
>  Can you please share some details on this topic?
>   
>  We already have many boards upstreamed which work fine without
>  manually setting ocr_avail in the driver.
>  In general there's two types of boards:
>  1) boards where the regulator can switch between different voltages.
>  One example is the Odroid-C2, see meson-gxbb-odroidc2.dts [0]
>  Here we specify:
>    vmmc-supply = <&tflash_vdd>;
>    vqmmc-supply = <&tf_io>;
>  &tflash_vdd is either turned off or at 3.3V when turned on.
>  &tf_io can be either turned off, 1.8V or 3.3V.
>   
>  2) boards where the voltages are fixed.
>  One example is Radxa Zero, see meson-g12a-radxa-zero.dts [1]
>  For the SD card the board uses:
>    vmmc-supply = <&vddao_3v3>;
>    vqmmc-supply = <&vddao_3v3>;
>  (meaning fixed 3.3V always-on power source for both VMMC and VQMMC)
>  and for eMMC the board uses:
>    vmmc-supply = <&vcc_3v3>;
>    vqmmc-supply = <&vcc_1v8>;
>  (meaning: 3.3V always-on power source for vmmc and 1.8V always-on
>  power source for VQMMC)
>   
>  With the information from the regulators the MMC core will
>  automatically detect ocr_avail in Linux.
>  Or in other words: your .dts may be missing the link between regulator
>  and MMC controller vmmc/vqmmc.
>  Can you please double-check this?
>   
>   
>  Best regards,
>  Martin
>   
>   
>  [0]
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts?id=2585cf9dfaaddf00b069673f27bb3f8530e2039c#n354
>  
>  [1]
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts?id=2585cf9dfaaddf00b069673f27bb3f8530e2039c#n333

