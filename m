Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ABC530B67
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiEWITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiEWITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:19:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645DC6448
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:18:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so16834948pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4J0ESP/V8Vnwz/yuHg3Z4IrDVJhBwYlkrbCGVndRBM=;
        b=bO7z+R1t9wUhLnnnWDfhz6Zk6h2YBjLIxo/j4Y1MwDtpeUwI3PjDO9YQ56IeGCrnJ2
         NcI5ekA6n2uks0MZqmmN3YR/0KlfnZDYlxt9So3GHsCdp4v4wRNBUWuHTgjXRxkmkZMe
         I4r59ygYODe9ZgZTrQeb35X67mNcZ1baihrC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4J0ESP/V8Vnwz/yuHg3Z4IrDVJhBwYlkrbCGVndRBM=;
        b=0n+L0eXGYOFYUUJRhbSYAsbG3mmuuk+hRWUjN6vEiOE7RQyRfm7g2/1F6nCeic6eXU
         2kRh/YyIE9D3PmxG6atZzmFaEWSVHyrXLkilAKKYVzZutbXiSuHeBB3ibSSorHdsg5c+
         zOnHhhE2z1fas54bnTDFaPc9//4dHKxj3BnoOG2DqopBMa2XANpX5QDoUbEY0xCvKBt4
         WJWPMJye/f45XKhNkcejrQiIr4qRrvLmlYCXpM+KhLBCwo9m+3HnPUC7GAJNaI5PKtz6
         kCXLQhUx2l54mWyie+F87ER/HQVyo9mGHLv/mQTI6QasExcw1DmRxsL0Pfj6OCsbN/RG
         lRJw==
X-Gm-Message-State: AOAM532Guok1a0P0dejWGsRzrA8/qFL8woEVZKUH9gc6mgTZwzPYIHE4
        utV8CuFaqdOFFMKPlG8fuZARtbxb/EDq8FIaIP/yW9tBye8cVd6B
X-Google-Smtp-Source: ABdhPJyz7VKSjCLQcQvZEV0siVQk9omWx/CGAhMugNLkeDy42Ha1soXO862Gh9FBtycwWIni79O56+SGwz+by46Kqd8=
X-Received: by 2002:a17:90b:4c47:b0:1df:ad5b:e32e with SMTP id
 np7-20020a17090b4c4700b001dfad5be32emr24827089pjb.59.1653293936890; Mon, 23
 May 2022 01:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com> <20220519075117.1003520-4-tommaso.merciai@amarulasolutions.com>
In-Reply-To: <20220519075117.1003520-4-tommaso.merciai@amarulasolutions.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 23 May 2022 10:18:46 +0200
Message-ID: <CAOf5uwkHm1Az+WOCy4bgoqJje2hVqfqVAQFBkZ==OEgXAhLJ+g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: px30: add mux for mipi-pdn pad
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
> Add right mux for mipi-pdn. Mux this pad as gpio2 14
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/rockchip/px30-evb.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> index 53930e28eadf..0d05a1b098bc 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> @@ -450,8 +450,8 @@ ov5695: ov5695@36 {
>                 dvdd-supply = <&vcc1v5_dvp>;
>                 dovdd-supply = <&vcc1v8_dvp>;
>                 pinctrl-names = "default";
> -               pinctrl-0 = <&cif_clkout_m0>;
>                 reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +               pinctrl-0 = <&cif_clkout_m0 &mipi_pdn>;
>
>                 port {
>                         ucam_out: endpoint {
> @@ -544,6 +544,12 @@ cif_clkout_m0: cif-clkout-m0 {
>                                 <2 RK_PB3 1 &pcfg_pull_none_12ma>;
>                 };
>         };
> +
> +       mipi {
> +               mipi_pdn: mipi-pdn {
> +                       rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
>  };
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Michael
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
