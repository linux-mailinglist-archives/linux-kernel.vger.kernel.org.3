Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6F4CCA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiCCXvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiCCXvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:51:49 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6482166A6E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:51:02 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n185so5253632qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEUDph6pdILfOjFK/V90NsjsmH/ILVmOF+Vdrb+tua8=;
        b=DFpGnpSMnFmOUvMJOYbl261thgAry2SYgtDsyMBZuLiJDYxlUr+vXHe5DRn1OOPG55
         lbAU5uyEJ6BCRngz3QV/NzOlgo9IdG/lUiQi7nmDxqL9XgwJIVmhdSPBnyODd43C5Hq8
         ztcOXHnG5slmbzAFJ9tFDftjvWJnxU4V/Tvk9whBObB1E75KVBul2XY8XdWshFO4Lp7j
         yDZub7Qd094o4eV03t3BQzIwoffa9QfyD1XaIeHpqqnEeqcp15O3d+fZlyCrSYlD8iI5
         l/lRSc3ayN3yttX+4Ndi7Aw6gvAahTmo0Jbul3oLc+yzqhYgXJWoyjtrumJMmlOeVkhY
         LkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEUDph6pdILfOjFK/V90NsjsmH/ILVmOF+Vdrb+tua8=;
        b=b1twvH0UsKtI93rka5i4gh8yQAat7oSrq7utjCKHvn0EfrB3QOfBvmp+SyOcupclzH
         OMHRyiC6+qepWb8zedr61g1ulz28SgCt24cpmcsJPqbtF5c3tHGcYYjOUIAPVwCFzxWl
         Jgc+jrzRZPjDYMGYapueBjrqsmn6tCOv7OQT4n3uAv6tROehm6EkWKmBQWIcjKY7vZgp
         pxN0JyTZZBX/Wlfql0+b4WpQdt67IMMQ1y/4WLTiR3FVktf2m1xVY8/wEdnUVFfzufOF
         3Vn1VtAP2OuLUhMeXLtks5nk9sbL69hRji+JhWC+8jgnF08QXU8S+S8H/GwGiMlqnNm4
         xFsQ==
X-Gm-Message-State: AOAM533xeaHMGEpGtXXl0oClkgrK3RX2g87kPcDPTYEslmc6qqcmjW4e
        eGfUg+ablzcw1LsJ/o+nwvrDV9nYTVjidiE+6tf7MRcsP/o=
X-Google-Smtp-Source: ABdhPJxO/chGuWgVCSeW611qh1w44gEqrV7Xsc4Oh8x15acfkpz3bzzXTGhRfR1YREAZMdmJovlbjCD2iHuTu/of2xE=
X-Received: by 2002:a05:620a:1392:b0:60d:d76a:5073 with SMTP id
 k18-20020a05620a139200b0060dd76a5073mr1036802qki.59.1646351461812; Thu, 03
 Mar 2022 15:51:01 -0800 (PST)
MIME-Version: 1.0
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com> <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 4 Mar 2022 02:50:50 +0300
Message-ID: <CAA8EJpqkK8q7g8q56rfiOO22ykxgycJTpSJKHuhcqGk05nsVzA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64/dts/qcom/sm8250: remove assigned-clock-rate
 property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 12:40, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
>
> Kernel clock driver assumes that initial rate is the
> max rate for that clock and was not allowing it to scale
> beyond the assigned clock value.
>
> Drop the assigned clock rate property and vote on the mdp clock as per
> calculated value during the usecase.
>
> Fixes: 7c1dffd471("arm64: dts: qcom: sm8250.dtsi: add display system nodes")

Please remove the Fixes tags from all commits. Otherwise the patches
might be picked up into earlier kernels, which do not have a patch
adding a vote on the MDP clock.

> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index fdaf303..2105eb7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -3164,9 +3164,6 @@
>                                  <&dispcc DISP_CC_MDSS_MDP_CLK>;
>                         clock-names = "iface", "bus", "nrt_bus", "core";
>
> -                       assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
> -                       assigned-clock-rates = <460000000>;
> -
>                         interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-controller;
>                         #interrupt-cells = <1>;
> @@ -3191,10 +3188,8 @@
>                                          <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>                                 clock-names = "iface", "bus", "core", "vsync";
>
> -                               assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
> -                                                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> -                               assigned-clock-rates = <460000000>,
> -                                                      <19200000>;
> +                               assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +                               assigned-clock-rates = <19200000>;
>
>                                 operating-points-v2 = <&mdp_opp_table>;
>                                 power-domains = <&rpmhpd SM8250_MMCX>;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
