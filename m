Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A024F6679
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiDFQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiDFQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F59C6F06
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:56:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s13so3581741ljd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjZsIlWat2l9xa0WL8zf0EcIa39YnrACHBR8m9uiowg=;
        b=i0VWJ/CcY+PT4qCa51i9Z/+RQM6wM31bqZg7yGxOdPFdaSyaELt34pNi7DWyXMf3AG
         WXD83h28rJeK4EgMYuCCuD5fe9jF6KH4rWQpVj/3cUs4yrnNKZDAWubfWr75miD376WI
         oBdQRhew6e05nFOa8K00j19JHU8L+Eph8x0o9K43NhkHmp4iaN9mwWstTLsaAKXwDjJK
         kO8xIEUNFf47dleu2O3HEAEFrP9TIsD8IWDfZIt3BO7SioHh5JuZgTLBCczkRk07n8B0
         Vt+ZutQNBKu3fDmi4scBVQIYfWSGcR/chLdoAMMUOWkB1tsw7fFYmkQeojnOWvDJNySk
         TCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjZsIlWat2l9xa0WL8zf0EcIa39YnrACHBR8m9uiowg=;
        b=DKl69F/gGk5Ny1kEZx/fdmTISVAD6jSjfhSLrkQcZ/+2ykOKiCERa+ikgNSdcMlZKj
         wVGJgKE8Rs1ohVEJQ7WYN1Uh84SHHj/1K+A2bgSKfhMI94a9qLlKWrW3/297Fpt9TOmE
         LBdToBNcrkUrFcj7mOwT2zI5MeixnKsV06NCuIupwrhaEknz/PnnbdKN8BeghDy9Uo4r
         iTlYQH56Ch5fiRluP3IK/706ExShqoZ5CNwD2SkuVbfCmMm+1KYLYRRghEErR+RebipV
         IZPmaOGarNJodSZnN4g7dM4nNmQEB/1YrLoaozv7W2yGx1mqLOVE1te+CBX2UcObwoK1
         jAYg==
X-Gm-Message-State: AOAM533YXm3PHH2ecS8v9/EdBq+6/3j3TszmKyCiK5lg7/EohaVmcYnH
        AdMlu3Gi29S2V6waTFjF26hEJE5QqfBmHCdVwAfTAw==
X-Google-Smtp-Source: ABdhPJy47PzYbVHxRygS9k3I7UM424f+F/oaYXHLgaJQLSEiHC0Rd1l8oyZGSl9sentgHmXai/d7/1qGj5x8MjT/lCQ=
X-Received: by 2002:a2e:9048:0:b0:249:78bb:375e with SMTP id
 n8-20020a2e9048000000b0024978bb375emr5601838ljg.229.1649256962784; Wed, 06
 Apr 2022 07:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220330094532.21721-1-tinghan.shen@mediatek.com> <20220330094532.21721-2-tinghan.shen@mediatek.com>
In-Reply-To: <20220330094532.21721-2-tinghan.shen@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:55:25 +0200
Message-ID: <CAPDyKFoVrDMwteeBc-xTzD3HAe4wsG361mXs2fmHZpQSv662bQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: mmc: mtk-sd: increase reg items
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
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

On Wed, 30 Mar 2022 at 11:46, Tinghan Shen <tinghan.shen@mediatek.com> wrote:
>
> MediaTek has a new version of mmc IP since mt8183. Some IO registers
> are moved to top to improve hardware design and named as "host top
> registers".
>
> Add host top register in the reg binding description for mt8183 and
> successors.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 297ada03e3de..2a2e9fa8c188 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -40,7 +40,10 @@ properties:
>            - const: mediatek,mt8183-mmc
>
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: base register (required).
> +      - description: top base register (required for MT8183).
>
>    clocks:
>      description:
> @@ -168,6 +171,16 @@ required:
>    - vmmc-supply
>    - vqmmc-supply
>
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: mediatek,mt8183-mmc
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.18.0
>
