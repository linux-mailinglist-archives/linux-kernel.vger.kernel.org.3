Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07F47B654
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhLTXyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhLTXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:54:08 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EBBC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:54:08 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id de30so11040885qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICTB8V4n+9cmca6+x37Ql0fa5KJvA8Kd4xGMSs77tp4=;
        b=GOa3Py2rvoHFE1zmqG4g4VsKavd6FCbMcxB66Q0UHthvWMGSZ4qkosE2WTkfXY5jLj
         GJEsJls1Q8hoJJe0Hz8joPOiyGiwn/He61O6Dpe3Y2sQ6iVAEfduAgGVtDQ3aKJHE+Cf
         CNf42oqdHuyZxsnhBOfuuJuEy0uOszNUBOUyIrrH612CftS0o0hXP8a1a35t3HoCwHAK
         55EDgjLU7QWhMfPUQ3lxpDHgZqZIXdT/wc+PVWVZOt2vshCjWC9xUCTJ6B7WFwZ0dwS9
         TlLRGrJ22LePnO+EgLB9+yPEVV/ZwtWz52I92Hh881azKDNEYhSvkBO35edcz4Ii6Hvs
         dOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICTB8V4n+9cmca6+x37Ql0fa5KJvA8Kd4xGMSs77tp4=;
        b=iwKCLOG0CB4e9XcIVr+ESn5UpiJM1LD5tZjv1fq7H7gg+YXyp8b6NNqSLet81NsmGy
         6/kJeIEb+ArUkOUhTMKjg0zAooEokgziuytN3gYC6wLLwAk4/bj+nt6ZeWaXFT6I3F73
         IWR0CH5lzuAiERS7TOi+YfRkya/jPiLREteW6jlSc6kq1/HYk498Y7Jepj47XbrC/17K
         Gev+NOKvS0TmXpDD25nD8ypTdYKy9t4Z/CnVefvAVGq8LDIK4766N9BwfQfb46NUTeTi
         Sb3tW4XxYr0r46sq8vB/1HxPDo6Z5P+OtOEr/0LVB7Fc7OHQF+wkMmaQZWxLa2YFu9sh
         U+4w==
X-Gm-Message-State: AOAM532RcPS5rN0xeGxzgZF1tiNGl5AOWgLpVhbGnCn60xMoPf60NbxU
        9YR78pL18WVN3WJJVjVsWTK7HbBPj6f7BIFQ+b8TKw==
X-Google-Smtp-Source: ABdhPJzCxuuI7T69jGLo8Z9p5gSwkmCeAciC0CgBmGa3lxd+isswddNujRi13+rwrqy40MTb27glmY8K2mKYuRI17Ng=
X-Received: by 2002:ae9:e641:: with SMTP id x1mr432352qkl.59.1640044447562;
 Mon, 20 Dec 2021 15:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20211220184220.86328-1-david@ixit.cz>
In-Reply-To: <20211220184220.86328-1-david@ixit.cz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Dec 2021 02:53:56 +0300
Message-ID: <CAA8EJprqBELsZUCVqppAsNVBzsW3FxQbUCQ=zy_tAVY0SeTPwQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: msm: disp: remove bus from dpu bindings
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 21:42, David Heidelberg <david@ixit.cz> wrote:
>
> Driver and dts has been already adjusted and bus moved out of dpu, let's
> update also dt-bindings.
>
> Fixes warnings as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: mdss
> @ae00000: clock-names: ['iface', 'core'] is too short
>         From schema: Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
>
> Ref: https://lore.kernel.org/all/20210803101657.1072358-1-dmitry.baryshkov@linaro.org/
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  .../devicetree/bindings/display/msm/dpu-sdm845.yaml          | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
> index b4ea7c92fb3d..0dca4b3d66e4 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
> @@ -31,13 +31,11 @@ properties:
>    clocks:
>      items:
>        - description: Display AHB clock from gcc
> -      - description: Display AXI clock
>        - description: Display core clock
>
>    clock-names:
>      items:
>        - const: iface
> -      - const: bus
>        - const: core
>
>    interrupts:
> @@ -160,9 +158,8 @@ examples:
>            power-domains = <&dispcc MDSS_GDSC>;
>
>            clocks = <&gcc GCC_DISP_AHB_CLK>,
> -                   <&gcc GCC_DISP_AXI_CLK>,
>                     <&dispcc DISP_CC_MDSS_MDP_CLK>;
> -          clock-names = "iface", "bus", "core";
> +          clock-names = "iface", "core";
>
>            interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>            interrupt-controller;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
