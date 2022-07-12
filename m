Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA80571820
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiGLLK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiGLLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:10:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04CBB186E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:10:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y11so6812798lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwaWTlB9XyYSCbsGwzEE8BVlrGpHkrwxw1TbvJ4Org4=;
        b=DZx1pmciZROwc48L94adQPdjnNrHIsmIDfTxOKjK16+njO+4fyxaxlfXdN3waf3a0b
         iM5mPh1KW6XDNtqJ5QAy5OO0FvJxeAr8GKZ6B10T7DxKG8mzOirP0a/YeYev9YrUP8Go
         EM+SizTVel+y1raK1kbUZEwmfSD12pnlfo5JjYYQO6uzVckxQqgfpa0i5Am1uxsmX4xN
         iBX32lKu6C3qjvzBGmJG7BNnfMG3ZTa9XelXo5bv/y+hJv2m28qCCC0SUYvJ5OENLuHE
         O/7banmuGTWx6F4R2jJhe3T5FbLDe9eZdTERHLTzM798W8RBUvKoY7oUZwazBiMlgvS+
         9llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwaWTlB9XyYSCbsGwzEE8BVlrGpHkrwxw1TbvJ4Org4=;
        b=4/nsVoTbkynQdnb4aS1Uf+d8U1i35NTuEgWxy/cqc/2a6fL2TjmM/zqKz/OH0YZ+WB
         M8fndOWyYWfbD+dn8K5bt0NLYpl0xnyySKo4MAiz4UQxvWrvZJ8jI9i7ObhWTLm+Z6KD
         ZY26FcFtTLz5g8oAgj/DvGo1hqrUPSW926fpsyB85J9EhBtdA6rCHxQzAhocKRefVNbQ
         IPnT7mi40KJv9YcTPgeCTqClhE+3n12fIQKqToyZsSz7f2cf0coiCt7lz2NnKv2sJCSG
         d+5nWXBFuZrXykwx3r0Qq5p3Ex32eI5L2X6fBEcngODXSTcWy9jF8m8tMdQgfrYcHKlp
         W0AQ==
X-Gm-Message-State: AJIora/GJcRRe+vfxlgV9TbSL/NJ9e7BvptRO3Jo1OVCDkL7ivkfksTj
        isXS1/yVw4dsNngFJXzwo2+ltpdGhJ9zA2psqmrTqw==
X-Google-Smtp-Source: AGRyM1ve5l8iOOqjKIRpIrGFxxBTNnh3DERnaKcFR3f0PFlcws/EjMxWxw8lvTV7HgWGqRd6EEPzTV4VMLjMOFwbt28=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr2187021lfb.184.1657624210224; Tue, 12
 Jul 2022 04:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220704143554.1180927-1-robimarko@gmail.com>
In-Reply-To: <20220704143554.1180927-1-robimarko@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:33 +0200
Message-ID: <CAPDyKFro0BkQdRJ1q44ED95CqQHbujBshAtFJm_PVPUD+rKE=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: document resets
To:     Robert Marko <robimarko@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, bhupesh.sharma@linaro.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

On Mon, 4 Jul 2022 at 16:35, Robert Marko <robimarko@gmail.com> wrote:
>
> Commit "mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC" added
> support for utilizing a hardware reset and parsing it from DT, however
> the bindings were not updated along with it.
>
> So, document the usage of "resets" property with the limit of only one
> item.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 31a3ce208e1a..ca8814a80443 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -116,6 +116,9 @@ properties:
>      description:
>        Should specify pin control groups used for this controller.
>
> +  resets:
> +    maxItems: 1
> +
>    qcom,ddr-config:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: platform specific settings for DDR_CONFIG reg.
> --
> 2.36.1
>
