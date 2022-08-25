Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D85A126D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiHYNg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiHYNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:36:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F16AB04A;
        Thu, 25 Aug 2022 06:36:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bs25so24681317wrb.2;
        Thu, 25 Aug 2022 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=o1UpxoiRuNt3oUSMcF8VYdjioVIlJJnIPZzUkRCOFOs=;
        b=BAPDeOCpMKXOQRMSoIMiS+mUnKLVXfABtBKM/70xGPTvsTNCwiOL8aeiF6qIitDeKf
         2ps6ylszW3YeCgmYj/rF/rrQo5dqhFryE0AHN/LYZEZub/FFrtyHX/hf+Oj1DkCZg7rp
         4Tu3cAcrILV64LGxaFkYK0r3POMb6MgrYmqbBZlZ0S3oLpV3LE1wJt0FhNUuwLZ66LVG
         NNECmr2MIWVXOnYMalYzU6czysgigZayP3xMrNN8WOMSrrGTQTiFqp4MAjOAynmzszr0
         N6YD6gjJKCDUAmq46OuRK+WI4e8V8LNNTNixMWXVHmBDvzA1EdKyJPjiw+7INrmhgV15
         kWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o1UpxoiRuNt3oUSMcF8VYdjioVIlJJnIPZzUkRCOFOs=;
        b=bIJ1HRnywpH8n7MNtWd2tidRnpgnjjekATb5fGD/tq1NBw7Ff7EEAr5ElT4btDoZBs
         83TMY11azaAtK2d012SLtyWkb4PaFvRr/wAJH2aXDXB+rPmZ4M26yFPnKtzeSbPbKJZu
         JaryMbllGjAYSLC/4rKQ52N4AidLIH95Zd021rS5mSTz/O8btxWdSkr2t5sSBaYLpBIF
         0gO7BCWTNJn2/KV/8gGBVgxUZjaBfOXq2bcEH2UsVxclEBOQVVJo9YF0gHBodOYu2vOj
         V0K/XufC5F3rqIxhkDS0vkIpZfei8/PCsX11VRkFgNS4JQTLKoAxkaAlQPs36Frq0BX8
         yM2Q==
X-Gm-Message-State: ACgBeo2hE9gV+Ky0s5uChi2vqQQEDNnP2hHpgvoEu0RzeYvdTFPzM3Xc
        u2M4sKF4EtasC2Z2QhBSAIo=
X-Google-Smtp-Source: AA6agR51DTr6LrwquXxqYW/bTahA+91PGJ3st7kartiD0AdFt0Nd5Iv4F33QY1hXXicmBdatc+1D0w==
X-Received: by 2002:adf:f881:0:b0:225:4f49:55dc with SMTP id u1-20020adff881000000b002254f4955dcmr2437885wrp.414.1661434581558;
        Thu, 25 Aug 2022 06:36:21 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b0021f73c66198sm19385965wrs.1.2022.08.25.06.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:36:20 -0700 (PDT)
Message-ID: <b96810d6-df43-1599-b3cc-83e97b9faf2c@gmail.com>
Date:   Thu, 25 Aug 2022 15:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 05/20] dt-bindings: power: mediatek: Update maintainer
 list
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-6-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220729063208.16799-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2022 08:31, Tinghan Shen wrote:
> Update the maintainer list of power controller binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks

> ---
>   .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 2d6afc0909473..03b7f6aa591d4 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Mediatek Power Domains Controller
>   
>   maintainers:
> -  - Weiyi Lu <weiyi.lu@mediatek.com>
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
>     - Matthias Brugger <mbrugger@suse.com>
>   
>   description: |
