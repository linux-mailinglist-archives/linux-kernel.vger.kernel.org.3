Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E757149F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiGLIbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:31:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE245F7B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:31:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp17so4873836lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2Qek6UIHQ+bbCaaLnSaW6r64q6VM+tLrxNDw9LwIzw0=;
        b=q5JieP0nD1nb1WONStATLcRP5Gl7TEysSwqRsbz16Aa1NA0dPPjSljZkAAgT6/tRhG
         6VLQfc5B7FqJF2WtL15C0h/Z8c5syWmEvZ4sFc2rr9Lfe/+uZW+Uy4oI9CB/+RCex592
         IeRL4hDjn42wtoAo0/CsI07N4JDEadx3YRCjHc8R+E4Tvp4EQQw1B3vn2taMHjthwum8
         AyjosCfNoI9A4MM2ln8XfIFNWM6oX94V+NgXFJiJfwLGzHxgM4y2OaUjGEqGOenQ3kuK
         kuoZghny1QSUNlTQ++hfreBwu6Zf8PC1HuPtBKR4dhSfCWbYRHvPUpamjO9wY2TICf4P
         n3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Qek6UIHQ+bbCaaLnSaW6r64q6VM+tLrxNDw9LwIzw0=;
        b=w3PVb80VUO53tNkKx081z3f9bfKNhG0yMOmwLINbWmeSmf42V0XSxSEvbrKrWaX+iF
         TjY+CdHsMIwj0N6LehTpIV9lXi3iemCajyBpr60w8DMC9sMgwnBbi/CTHn+fgOvQqs85
         wKXRs6Og8Yuqm+JQVdFm+nAD28Yq4YlZ97NQBp1kLamEleak1kNgA/hRmtG9oYnPuoBK
         sFFeWBhDT6MAn9KwA+weqbDWL4TgoHHU7dqsSe9LzFXY+0oMMNt+24OvD4LgFDzne5+y
         Aoj015fI4nVo0AbDw5hMj+SUCrGn6CSlI+W2zaUoPW7GG4Cn1BqKLfL3wlFQW0xzLI4i
         ruBA==
X-Gm-Message-State: AJIora+SH1CXHK80FAMf8citOhh/+lzVka7HflO3nKoDwNLtNn194CFR
        0CvY/1Zdybd3l0aU2KFrOawNIQ==
X-Google-Smtp-Source: AGRyM1sErvlK54KDfmiepBO87G/PzDDHBO3xqVuq4WopTZAFMkYpJG4tiwF07DITvORCx+p1AxegEQ==
X-Received: by 2002:a05:6512:12c9:b0:489:fa6e:d371 with SMTP id p9-20020a05651212c900b00489fa6ed371mr374610lfg.37.1657614698997;
        Tue, 12 Jul 2022 01:31:38 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id c19-20020ac25f73000000b0048759bc6c1asm2052737lfc.203.2022.07.12.01.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:31:38 -0700 (PDT)
Message-ID: <68d60eb6-605d-153b-3074-37d1777ea6d8@linaro.org>
Date:   Tue, 12 Jul 2022 10:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: power: mediatek: Document phandle to
 SCPSYS syscon node
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
 <20220711122503.286743-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711122503.286743-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 14:25, AngeloGioacchino Del Regno wrote:
> Add a phandle to the syscon block providing access to SCPSYS registers:
> this allows us to avoid using simple-mfd for the SCPSYS node and
> nesting the System Power Manager node inside.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/power/mediatek,power-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 135c6f722091..848fdff7c9d8 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -39,6 +39,11 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  syscon:

This is not a generic property. You need vendor prefix and property name
(can be followed by -syscon).

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon block providing access to SCPSYS registers
> +
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
>      type: object


Best regards,
Krzysztof
