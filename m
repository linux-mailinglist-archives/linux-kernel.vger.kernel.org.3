Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130F15A14F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbiHYO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbiHYO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:57:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2CB5A44;
        Thu, 25 Aug 2022 07:57:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h1so10385334wmd.3;
        Thu, 25 Aug 2022 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bKqxJIBDaoN4leoGC948rXDy4btWZwIIKEVGbDwuJbM=;
        b=niwLkKWApxiZ9LaQP6x2ZLxlpmxSFUjIjBrJm4WXIOlbAS6k3JphAY/ug4U7/qDzZr
         1BCAnDAPUB96BFamev8xVvVo/rtd5+HhoGPBKJEGXhjkrtGtZlGbICR7qdNqqbOCL9V/
         PdJhXg+5FI0mnSBK+yS8l6n8Qb5RD8hMP6yHXJu2Bbk09B91YpjiIbOIra7NK8F9+uXS
         Ghdppms8BAgMaJkmk4oH05DX9DaJWvlh51FshpMIZBf5iM7eTvpGzNGa6nDdjtHWvBZz
         99iLZjHEgqQp8O4vLf6oqCXffSuB+c0pV4PsiV1WOXQK4GSy8w3ypP447AXKQZWWP+s3
         HjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bKqxJIBDaoN4leoGC948rXDy4btWZwIIKEVGbDwuJbM=;
        b=Z6qOJNlj+YH1xyRO2H+QpXxN2cEO39gZLU9hw+Qg8dfE/27A2u54ytFHVKGfko7Ldi
         FIRg6h0IdJX2nuQc4FNhtw/6VtIalQM3qlKq8pX4zn6m3qC9QxWlz5nN5nLWZtW2oALn
         NDo6bxEwcGhORpFA293lzJ2RN2xdI5rjqo/Y6kKguuwRIcLVQuTNQkmODyrMJyJ5/XaE
         scRFXWjyNZfIaIkGlHFMOupPGBbfLSLhyC+b3GzWvZEJz+7Tg9Yr1xAF89eDfJpTq2L6
         aArB6Fh/bqK8KoAveRqvJ0KjULllaA5bgv1aNpAWL0/lRBaetL6S/QayDKHOCppMrPuK
         j/tA==
X-Gm-Message-State: ACgBeo3UNxR2KpmnqS79LvsD3Wgxki/O3qhczhCXbUTJR4ekwQ+TxEI7
        XFm8XQHQDTBk/FEoz1jhhOo=
X-Google-Smtp-Source: AA6agR7DjigTUF9DSPLsJPn+n8QozB6Xr2ap0MfMSl098vyNmB/BNSxC6kMjQVy++uy2E6Cq9djLOQ==
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id p23-20020a05600c065700b003a5e4e6ee24mr8225959wmm.68.1661439474250;
        Thu, 25 Aug 2022 07:57:54 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s1-20020a7bc381000000b003a35ec4bf4fsm5403928wmj.20.2022.08.25.07.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:57:53 -0700 (PDT)
Message-ID: <3ed3d73a-1671-708e-7c42-498cca6aaf1d@gmail.com>
Date:   Thu, 25 Aug 2022 16:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     jason-jh.lin@mediatek.com, nancy.lin@mediatek.com,
        ck.hu@mediatek.com, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, hsinyi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220825091448.14008-1-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220825091448.14008-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 11:14, Bo-Chen Chen wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.
> 
> To summarize0:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.
> 
> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
> Changes for v2:
> 1. Add hardware difference for VDOSYS0 and VDOSYS1 in commit message.
> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml       | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..bfbdd30d2092 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -31,7 +31,8 @@ properties:
>                 - mediatek,mt8183-mmsys
>                 - mediatek,mt8186-mmsys
>                 - mediatek,mt8192-mmsys
> -              - mediatek,mt8195-mmsys
> +              - mediatek,mt8195-vdosys0

Thanks for you patch. As I mentioned on v1, I propose to set 
mediatek,mt8195-mmsys as fallback for mediatek,mt8195-vdosys0 to not break 
backwards compatibility.

Apart from that, the binding change will need some changes to support the new 
binding. Please provide these together with this patch.

Regards,
Matthias

> +              - mediatek,mt8195-vdosys >                 - mediatek,mt8365-mmsys
>             - const: syscon
>         - items:
