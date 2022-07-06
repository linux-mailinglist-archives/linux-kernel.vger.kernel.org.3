Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B25681C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiGFIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiGFIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:39:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC192497F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:39:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z16so10531235qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cte21FGVGz+3OFHE9IJwOUROUkNZTbX6x2xJ3Pr6mhU=;
        b=RKilUeXRoSufJI8plDWM5OmnyfpJmhOxuBkf08udr/q8okmw0cVnapub8lH0+kLemz
         RPIvJefZQ/6NPQYdimM6sShojXC36HIyM9PLTzOcCu5h/TSq0VoZNnpAu/1niPCy0jVn
         x2JGhGHG30yxpzJ9IcUmdQ1d4Db4Xgx9uC6R9mBoC5i/YzSt2QQvwhAMDm17oxuzQ7fI
         13OQHMq4h8Amsy0AjzjMvHvU78I9pPcrZKUEtG9smfDnZShzyCm7zezqVDKNrQFDct96
         qZgHchDEcSR2kDlY3o2pbgH9jVVCunXRt+BJj3zlV7zCRABr6591XeLKD3zYezMNNAM/
         3RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cte21FGVGz+3OFHE9IJwOUROUkNZTbX6x2xJ3Pr6mhU=;
        b=S0tyQocw/EcMQl9CFacOdrqTHu7joBisb09749SLBuHTi8hjwiSllv5PIXZ4ASlavR
         GZKoorGyOiayMMxafPyRFDgHQ4X1ZTsWQMQXUt+lsJwBqlQtirj3CB8dCRguNvQkLFWC
         cxLfUHLxOlMPDI1JzLD3wZmEjEp/RT21yTwcOFl977vEY+eflNuH8OZEZtErQJnJ7IMA
         RXZqBypmzzpa/ktG5t5mkzbfqtr7+vCs/SzXkXsJCm5M7QjZK0/lcIiGAyob8rwJ5w6H
         h3cZZxzUqN9B8Fx3duOlwUrAXTpjd5M7ZfxB0/45frYgxdl1iR4E7Ia/DeyEZ1JzQfHH
         791Q==
X-Gm-Message-State: AJIora8UiubWqTmL5g/JMzcUhk5U9LlYG9maSTVP8z7kmzNE6ZG0rE3s
        9e5pP4L4UtkqZTUXTjI7tne9SRtAlH+LIp+dke9ZzQ==
X-Google-Smtp-Source: AGRyM1vCDjVG175RQYAskwCrvqM18Y0TICSQidMeiuH92aNhPySMssw/ghuF6mSzdest7lBwZGAFwIFRWNXSCCtX55g=
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id
 j12-20020a05620a288c00b006b309d1dbf1mr9509735qkp.593.1657096795225; Wed, 06
 Jul 2022 01:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220705191327.1684277-1-robimarko@gmail.com> <20220705191327.1684277-3-robimarko@gmail.com>
In-Reply-To: <20220705191327.1684277-3-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 11:39:44 +0300
Message-ID: <CAA8EJpqLy71fzr9Rn-quTzZXsc20PbcOp56djeHY-cApBJ4Xeg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: ipq8074: add APCS node
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Tue, 5 Jul 2022 at 22:13, Robert Marko <robimarko@gmail.com> wrote:
>
> APCS now has support for providing the APSS clocks as the child device
> for IPQ8074.
>
> So, add the required DT node for it as it will later be used as the CPU
> clocksource.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> Changes in v3:
> * Node does not currently exist in the upstream kernel, so add it instead
> of modifying.
> ---
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index b4ae13f16398..76707b9f9845 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -886,5 +886,13 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>                                       "axi_m_sticky";
>                         status = "disabled";
>                 };
> +
> +               apcs_glb: mailbox@b111000 {
> +                       compatible = "qcom,ipq8074-apcs-apps-global";
> +                       reg = <0x0b111000 0x6000>;
> +
> +                       #clock-cells = <1>;
> +                       #mbox-cells = <1>;
> +               };
>         };
>  };
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
