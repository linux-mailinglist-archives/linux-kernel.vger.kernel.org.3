Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27106535556
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbiEZVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiEZVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:05:46 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80100E7323;
        Thu, 26 May 2022 14:05:44 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id l82so2552702qke.3;
        Thu, 26 May 2022 14:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGFq6ss7N+k24WC+NtUaZFpHQf1enSNC4oSA/gUz+kA=;
        b=Lovw6lQzCqltoZ6t9wJ9Z42XoSrLyeQTIvzt3813bHlGo4gXysMZeTIuzd98vl/z1r
         laWKrJn3jt1cw3WVgovmaeEbpnRb1OTHxBymxRhjfgtcZNaf9ZeciZB+04iSlCNZAQEN
         9LciDRTa7VkqVZitNuYIubgRjlppyPSKMiMLOeid4b7oSEJJKnsTxe4JgQU7z31XUpyl
         5tLu+h3jaV6vB5Rv0dhCsE3COA14msFZLTn32cKoLLcv0VM9iQdq5FSdcH9H0tYPhK4q
         v1H4hK+5L2mdIakihgZOmDJayq45Hfaqmz6WGdmYv1PnzdsYbaQUf3OhOmOWIk++ZVVS
         /8/w==
X-Gm-Message-State: AOAM532elUMp6CRV3at54Odxh/HMuuGqqFN8S+n4M8fsKTnoguzVCgAA
        3yq4XfGbp9CIAdNgvM5vOXysxQ4YWS3f2Q==
X-Google-Smtp-Source: ABdhPJwm0ByPyj1n1kNaqmju4tiG42KoFk8oIjp3b7iCEM4He6FnNYGCCtX2JHmJw8ce47a3oL37wQ==
X-Received: by 2002:a37:848:0:b0:6a3:25ea:3cd1 with SMTP id 69-20020a370848000000b006a325ea3cd1mr26250661qki.686.1653599143304;
        Thu, 26 May 2022 14:05:43 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id r14-20020ac87eee000000b002f938f5bb78sm1484176qtc.15.2022.05.26.14.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 14:05:43 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f83983782fso28478237b3.6;
        Thu, 26 May 2022 14:05:42 -0700 (PDT)
X-Received: by 2002:a0d:d493:0:b0:300:43da:57f0 with SMTP id
 w141-20020a0dd493000000b0030043da57f0mr12769712ywd.502.1653599142564; Thu, 26
 May 2022 14:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220526204231.832090-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204231.832090-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 May 2022 23:05:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvfbbB3578aFAx6twdKNCkB1T-Uihf3OzGLHmcZG047g@mail.gmail.com>
Message-ID: <CAMuHMdWvfbbB3578aFAx6twdKNCkB1T-Uihf3OzGLHmcZG047g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: adjust whitespace around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, arm-soc <soc@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, May 26, 2022 at 10:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/draak.dtsi
> +++ b/arch/arm64/boot/dts/renesas/draak.dtsi
> @@ -630,7 +630,7 @@ rsnd_for_ak4613: endpoint {
>                                 bitclock-master = <&rsnd_for_ak4613>;
>                                 frame-master = <&rsnd_for_ak4613>;
>                                 playback = <&ssi3>, <&src5>, <&dvc0>;
> -                               capture  = <&ssi4>, <&src6>, <&dvc1>;
> +                               capture = <&ssi4>, <&src6>, <&dvc1>;

I think the idea was to align the playback and capture properties,
for easier comparison.
Hence I'm a bit undecided if this needs to be fixed or not...

>                         };
>                 };
>         };

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -206,12 +206,12 @@ pcm3168a: audio-codec@44 {
>                                 clocks = <&clksndsel>;
>                                 clock-names = "scki";
>
> -                               VDD1-supply     = <&snd_3p3v>;
> -                               VDD2-supply     = <&snd_3p3v>;
> -                               VCCAD1-supply   = <&snd_vcc5v>;
> -                               VCCAD2-supply   = <&snd_vcc5v>;
> -                               VCCDA1-supply   = <&snd_vcc5v>;
> -                               VCCDA2-supply   = <&snd_vcc5v>;
> +                               VDD1-supply = <&snd_3p3v>;
> +                               VDD2-supply = <&snd_3p3v>;
> +                               VCCAD1-supply = <&snd_vcc5v>;
> +                               VCCAD2-supply = <&snd_vcc5v>;
> +                               VCCDA1-supply = <&snd_vcc5v>;
> +                               VCCDA2-supply = <&snd_vcc5v>;

Same for the various supplies.

>
>                                 ports {
>                                         #address-cells = <1>;
> @@ -438,7 +438,7 @@ rsnd_for_pcm3168a_capture: endpoint {
>                                 bitclock-master;
>                                 frame-master;
>                                 dai-tdm-slot-num = <6>;
> -                               capture  = <&ssi4>;
> +                               capture = <&ssi4>;

Right, there's nothing to align here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
