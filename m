Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E80530B76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiEWIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiEWIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:17:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C498F6B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:17:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so16872538pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dy4PRGOoGRp4CN77V+ahn71XloGT7JKOsY/m9WJCOgs=;
        b=AzXaGiokChbNSYAcaNoEb68tNdvAPafice8elKmzBRDkx67VTOkzB0UfvczZtXkNbU
         PPtGg234U0xXDj+rxpktTyxqq2uZ3s4MrO7EDM1P3BTMbxkA+4PzI695hFFTQMF9dt1N
         eP6rOZW+CIaEHzJv/DwyL9KOVWvV7r7cY9yqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dy4PRGOoGRp4CN77V+ahn71XloGT7JKOsY/m9WJCOgs=;
        b=lyzL+daWPFLHWprhOIH0ucvoyLdBt/encRjykNSaxQUYAOmJRFqyrBeP7QYpkERMV3
         Nz8/PIlKayu1XIcgaro1lABp6JiM3JhQk7NDPfFPwAENzlw1txCHCB4Fn1TP8OpqWQZX
         jpM+oHqiaXVHOhlhFcryNovRLbGhHqAdEiO8iaS2BUo4C8MXHJ+QPSvOckAUBNV7mAws
         1shqq/6nR2gM/VWE4PfILczgw6I47y77O36b+kIQV99HC/fApEeJblTD39ZCoqeCFeMC
         fYUjXYe9SdymIF8yTt2DIsrx/XVPR8KppVt0euoysVM6hc5K1TgbpFLWoFO9RWm9qtzR
         uLfg==
X-Gm-Message-State: AOAM530hZk0hbGQQg0xcgLanoaR1+BfQexcok4iNKtYAi4oUFd/PpGTI
        B4L3isJ5wGV9O3pEBafAYpc8zS8++w7+btMRlHuoDA==
X-Google-Smtp-Source: ABdhPJxHY9GMvf0RIC495y4Lpy5llzcH99rikFg9l4mAhhiFP1DtpUB+uoazLXEXCSmo0XrRCTzyP9muVQ5LoOg8CIc=
X-Received: by 2002:a17:902:b10f:b0:161:f196:b4e with SMTP id
 q15-20020a170902b10f00b00161f1960b4emr15830929plr.134.1653293858455; Mon, 23
 May 2022 01:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com> <20220519075117.1003520-3-tommaso.merciai@amarulasolutions.com>
In-Reply-To: <20220519075117.1003520-3-tommaso.merciai@amarulasolutions.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 23 May 2022 10:17:26 +0200
Message-ID: <CAOf5uwmjBgSpQEqCswDt02H4e5jahO92TaQnk-91syskM_PZ_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: px30: max drive-strength for cif_clkout_m0
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, May 19, 2022 at 9:51 AM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
>
> Add max drive-strength for cif_clkout_m0. This fix the issue that
> sometimes camera ov5695 is not probed correctly.
> Tested on PX30_Mini_EVB_V11_20190507
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/rockchip/px30-evb.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> index 848bc39cf86a..53930e28eadf 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> @@ -537,6 +537,13 @@ wifi_enable_h: wifi-enable-h {
>                                 <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
>         };
> +
> +       cif-m0 {
> +               cif_clkout_m0: cif-clkout-m0 {
> +                       rockchip,pins =
> +                               <2 RK_PB3 1 &pcfg_pull_none_12ma>;
> +               };
> +       };
>  };

This is the same now on rockchip bsp

Reviewed-by: Michael Trimarchi <michael@amarulasolutios.com>

>
>  &pmu_io_domains {
> --
> 2.25.1
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
