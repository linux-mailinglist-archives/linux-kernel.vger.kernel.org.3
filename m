Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B2485641
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiAEPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiAEPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:54:04 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243FC061245;
        Wed,  5 Jan 2022 07:54:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h23so1023982wrc.1;
        Wed, 05 Jan 2022 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1hSBC1/w98Pw768lmJjpnN6pQZfQzImMpHnsNTHwes=;
        b=aAiyTBoLIFSGF30KgT0PoBOWB4sG/qXliIZcz23iLomVGGocLLPuR1fElE6eX0aaxk
         AfXUTEyJztGRVD+nYfZHV2NU1uNLuHTAenWQI1N5S4XkcxtOzcqytWp3XskMVruBxFlx
         +nPKlamtrLk0fHpxCzxeYxI/xs6Y0Gl2cqAVTieXr3VQ55JOsIXzoJzXdz+b7aL5GJdx
         /v7204V4P1OuvP2qpR1Fg20Gi0r8w9NSt+gMN5Ewi6HdCEbmCyr97h6EUV6dv3bBwWWD
         3MgTjziPQYPaTlSpqQKNlv6GJG5zPFiBqiHgRk5Fs/QsaVwbgLgcRzv7LFKC16C7IRWr
         /YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1hSBC1/w98Pw768lmJjpnN6pQZfQzImMpHnsNTHwes=;
        b=Ct9ShZTVJciZyuWyn7TepJyxhMGcLsstg79IvHDZyhW/1xb93mf3lQSoOeLJRODeok
         rc7i5spqdCiaxguCf/dQBo9pqagO2+WxmieRRGJbHBaW/DQl3pcW7fvlsQ82Olz7e2wR
         U9XARitDlOrAiElgYcZWlAIEw18Kr3Pd1QKsTrL5DAiN2U41bc8AElhMpYLYTkZhdxZW
         ksFLwrDbVgUZE5Tm1ZYrbACsNS+Fvrep+N42EhMGR/shdiczr/cG2KjZgJQ+V7nLf17p
         SbxmC2+cyeP9uJHSfebHWboDFfif0PuMutBoGJ7Eg1CPS8Nsl9LHCwJd9kisI5hdAaTE
         Ex6g==
X-Gm-Message-State: AOAM532PHhCV7lhG4qL7H9WEBibZP0T1r4PCBBZzA1cjSUZs0SCPjryB
        yC9lD3+qEqq7vmGiRxMFd+cOkRJMBUj2ocSudXU=
X-Google-Smtp-Source: ABdhPJywwb5ns/ANiBJIsaCUkgHG7AuBBdGtP/ATxIr7g1Fxp2Z03sxOoIvq9UzjMTvcJuZA3W7w5GMldnEqkblZNPA=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr47690277wrd.81.1641398042839;
 Wed, 05 Jan 2022 07:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20220103043202.6524-1-yc.hung@mediatek.com>
In-Reply-To: <20220103043202.6524-1-yc.hung@mediatek.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 5 Jan 2022 17:53:51 +0200
Message-ID: <CAEnQRZBH4uwMmyBLY2bCtY9QZooBiK5PqF3T+4K8WAtQV1QN-Q@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: dsp: mediatek: add mt8195 dsp document
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, matthias.bgg@gmail.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>, trevor.wu@mediatek.com,
        allen-kh.cheng@mediatek.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 1:00 PM YC Hung <yc.hung@mediatek.com> wrote:
>
> From: "YC Hung" <yc.hung@mediatek.com>
>
> This patch adds mt8195 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers,  clocks, memory regions,
> and mailbox for dsp.
>
> Signed-off-by: yc.hung <yc.hung@mediatek.com>

The code patch should be created against original source code from
Rob's tree. Here it seems the patch is against v2.

This isn't going to work! Because when Rob will try to apply the patch
it will fail since he doesn't have (and doesnt need to have)
your previous versions.

So, please keep the changes history (that's a good thing!) but always
rebase your patch on maintainer's tree.


> ---
> Changes since v2:
>   Remove useless watchdog interrupt.
>   Add commit message more detail description.
>
> Changes since v1:
>   Rename yaml file name as mediatek,mt8195-dsp.yaml
>   Refine descriptions for mailbox, memory-region and drop unused labels
>   in examples.
> ---
> ---
>  .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> index bde763191d86..779daa786739 100644
> --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> @@ -27,14 +27,6 @@ properties:
>        - const: cfg
>        - const: sram
>
> -  interrupts:
> -    items:
> -      - description: watchdog interrupt
> -
> -  interrupt-names:
> -    items:
> -      - const: wdt
> -
>    clocks:
>      items:
>        - description: mux for audio dsp clock
> @@ -75,8 +67,6 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - interrupts
> -  - interrupt-names
>    - clocks
>    - clock-names
>    - memory-region
> @@ -95,8 +85,6 @@ examples:
>         reg = <0x10803000  0x1000>,
>               <0x10840000  0x40000>;
>         reg-names = "cfg", "sram";
> -       interrupts = <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH 0>;
> -       interrupt-names = "wdt";
>         clocks = <&topckgen 10>, //CLK_TOP_ADSP
>                  <&clk26m>,
>                  <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
> --
> 2.18.0
>
