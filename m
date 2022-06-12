Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A612D547C01
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiFLUiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:38:14 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB573AA55;
        Sun, 12 Jun 2022 13:38:13 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b13so1830650vko.4;
        Sun, 12 Jun 2022 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaoD+tAduDQz7Ifk7hiTW7VOyucam8owwPCNchlahPs=;
        b=BruPf5GslfaNb5lXngwHL+wmoob2r6M4kQC6wy4NVkURSegJpRDvLFHRTT1Ep0wyk9
         WBosJiYlvugGe575KhJfQugyPrOxVpIAZEOgXhOA2Hd7p0bWlabmfbRxGPstOJj3bbg8
         H9AbCiP4oyX8limUjaJdBxjrLCYifXzyrdv6dnmFOeVjquoe1b+ioFiIGqM8LTf3Sk/7
         D145ZWG2lyr1afiv0gFCbVxLqIrHCuhmQ1fej9JsiLq6YAuoyEi07zge5RAbpZgAyZfN
         Xno1CNIcJrOsGcM76RmlBZqCN3du8W/0Rt20uvMFZLH6pStOSCBd/l7q0zKknrqIqc2s
         xM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaoD+tAduDQz7Ifk7hiTW7VOyucam8owwPCNchlahPs=;
        b=4040jIRRW40KzN5fKr8YhL5rfwIIDrCIyosAQHPjLMcGfNA4JN3onnQVInpxU9LpHn
         +9Ku+xFfvC4Xfk24S/CFxCKlaWqGgjxh+++C6prd2VT9Kl5ySucK/bDAXZRVuR8kAPDi
         dn1x1gq/+BrQSewqU6yPjclBUqB3AMYfgIrEHlgSMdonia7gHaYupbAIrQD/DkcnGr+M
         H17t9f++k7LCga61s58wRtV507YaYvUuJyf5irqBhBX+10Y9DEHpdaRzKqGjRVpinS/Q
         Xenbe5ZSeNvZCX+z7cTHiKcCqLpD+uL/pCdDoDEwVxaSz6DTV0YPvkql8Fm1AaLWvIJ5
         XB+w==
X-Gm-Message-State: AOAM5338V+qUKlUTEAISmNluevGfaAtIiF6AevinZ1LL/ULjFSNpH4kF
        UoYywb342zmCffGJRst6kj5uRAOy1l5G1oaF5TI=
X-Google-Smtp-Source: ABdhPJy9D5IweQbHJAywJP55Qx/MaUuc/s/biyGeLjfX/VGq9FGLWyQM23uR61YyF2iN32N0bQaK038sM8rPgBElojI=
X-Received: by 2002:a05:6122:4f4:b0:365:242d:411b with SMTP id
 s20-20020a05612204f400b00365242d411bmr5756375vkf.32.1655066292799; Sun, 12
 Jun 2022 13:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220608123233.13439-1-ariel.dalessandro@collabora.com>
In-Reply-To: <20220608123233.13439-1-ariel.dalessandro@collabora.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sun, 12 Jun 2022 21:38:02 +0100
Message-ID: <CALeDE9PR80qS63wwAKB-hENWbEj1xNHj+k81tyWkPPfZ0TS8Pw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Use aliases to set custom MMC
 device index
To:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        gbcm-kernel-feedback-list@broadcom.com,
        gkrzysztof.kozlowski+dt@linaro.org, gnsaenz@kernel.org,
        grobh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 1:35 PM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:
>
> Add MMC aliases to ensure that the /dev/mmcblk ID for SD card won't
> change depending on the probe order of the MMC drivers.

Is  the bcm2711-rpi.dtsi a better place for it given there's other
aliases there and it will be consistent across variations?

> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 4432412044de..780812542bad 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -14,6 +14,10 @@ chosen {
>                 stdout-path = "serial1:115200n8";
>         };
>
> +       aliases {
> +               mmc0 = &emmc2;  /* mmcblk0 for SD */
> +       };
> +
>         leds {
>                 led-act {
>                         gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
