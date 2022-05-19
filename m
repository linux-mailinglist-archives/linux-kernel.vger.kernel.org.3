Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571B552D36A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiESNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiESNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:02:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7562BF7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:02:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d15so9003564lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSu0XTILVshJ9x+raeV7MMtJ9MSB+JWGEzTTcAYgGH8=;
        b=xqED8FRRBUVTJs7yZwduUBlQVzuTT6nBQqS8MK6cY4tL4aSDZSi5uEDOJeQkjNDaPN
         G8YSKiHjSHkGbcos8Waq3CA5OaE7m3AQ8fcvT8MARoiuiJUfjTxrGZpJmIX5Js3HHQdo
         xaT6kf/P4GruZnyXpl+5b/UVlDa14h+BGYixzLR9AmpwXeEY82HH1tn4ZzjhwOSsHOE/
         kujzLJWw5HlwRzqYnhohpDYWZMe9H2ovChf7ZJrWULZD2bzNg0zCMKwbXzY1xJGW+r5G
         E4B6PuJ45TgHO0NE5Tp/TKHh6LCqbIqQDV3P/+kRu2Gjg03dItAs60osg+4Grcx6zX1f
         2w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSu0XTILVshJ9x+raeV7MMtJ9MSB+JWGEzTTcAYgGH8=;
        b=BfpBfUKAD0BDMRpSXg8qhoc7hBZmXbKx4fJwdTInR0W/UxPlh29Vz7LaWL3WUeksmG
         u6QqnKe5cGR4BbWimUDZ7L3oHrzfF6eHopdidl7kzNL/nRRgbOYEkRtVLxgkflm3++BX
         ADKPWlso/X1SnhFWIxdCMqf7CQJpsvSiXIMyiFovauKNy+5XOSMzjtvwa0lkJIMy7ooV
         F0g6lgdUD5B3klfUQXAj3RXUTMulgtY/qkIsIW/lmtMW8LwF0Mw56yUVFWMD2IvQjibE
         IsoDKZF+NgWLiuYuA0noOsdmslkFdUKzFwJ2sdGB4O09fdONObNKw1oALyUauS8kZqJv
         1htg==
X-Gm-Message-State: AOAM532vlpfOtIQcYAGGqC0P4noFWEShYJ+MBg1scfzYbBmtPy/W8Ebz
        gXQlRqGRoUpQfpFYDG3iFUYGBKR+RY17Urr4prP2Mw==
X-Google-Smtp-Source: ABdhPJylwHp+PNUHX0L3veOS1GtM4Mw0E0JPCmgEyCyRHaCw2NGWeTZfPTo+jpC/foRCai/LLqJubn4J1RgwqQDBofA=
X-Received: by 2002:a05:6512:70b:b0:477:a832:7d07 with SMTP id
 b11-20020a056512070b00b00477a8327d07mr3144930lfs.71.1652965323773; Thu, 19
 May 2022 06:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com> <1652275016-13423-2-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1652275016-13423-2-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 May 2022 15:01:27 +0200
Message-ID: <CAPDyKFoDmTMfGNsvv-DJqrV-xX=nLKfR-fjSOB_1JBbHm+nzqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: soc: qcom: Update devicetree binding
 document for rpmh-rsc
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com,
        devicetree@vger.kernel.org
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

On Wed, 11 May 2022 at 15:17, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> The change documents power-domains property for RSC device.
> This optional property points to corresponding PM domain node.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> index f5ecf4a..7683cc9 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> @@ -110,6 +110,9 @@ properties:
>        - const: drv-2
>        - const: drv-3
>
> +  power-domains:
> +    maxItems: 1
> +
>    bcm-voter:
>      $ref: /schemas/interconnect/qcom,bcm-voter.yaml#
>
> @@ -162,6 +165,7 @@ examples:
>                            <SLEEP_TCS   3>,
>                            <WAKE_TCS    3>,
>                            <CONTROL_TCS 1>;
> +        power-domains = <&CLUSTER_PD>;
>        };
>
>    - |
> @@ -208,6 +212,7 @@ examples:
>                            <SLEEP_TCS   3>,
>                            <WAKE_TCS    3>,
>                            <CONTROL_TCS 0>;
> +        power-domains = <&CLUSTER_PD>;
>
>          clock-controller {
>              compatible = "qcom,sm8350-rpmh-clk";
> --
> 2.7.4
>
