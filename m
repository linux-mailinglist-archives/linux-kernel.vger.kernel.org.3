Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AEA589972
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiHDIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiHDIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:44:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269567C86;
        Thu,  4 Aug 2022 01:43:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j15so16308009wrr.2;
        Thu, 04 Aug 2022 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gq6/HNhAQ3BSIj0Ba+RrM6ince6+tYXHxLdu6U01oYA=;
        b=Bz4WTRlH4WuC24dGsS4v9wUmu3j89xaxP+rFpcK9gzNyf2u7WsaEbVSkqPKTaRhp1K
         rCtoYXRr7DMDHo0p2wuEyRK5ESAigQlLRsQK048vHx+ZN3MlEJU6NjbligKTJhlDIyCa
         v6op2mKcqOaJnMtUnL+3EFmjIEyd8NFLRpjI+6Ajx4sstc6mkHuuGC33qfST+QgqVLe0
         6OxL3SquzsqrtYtHJAICTDBBbSRXx+RqJU98kzovk5vUrn6uhY8GFef0H6u3EW9BCcxA
         uVmSMsG/ujV2dJnRrdvdW8ZfxWPUNnNXim6cPFWvzprMZqohemyuebKpfnc3SWdroqHK
         Miag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gq6/HNhAQ3BSIj0Ba+RrM6ince6+tYXHxLdu6U01oYA=;
        b=wItwudil7fTvLB8tr1d2wV/0xhX9pC1yANdva35bXA/Zr0Y/MOVYSZduUUV7Gq1oRm
         9aR2CCS19yG4SFN8HrqgqVFKMEMso9yG5FwNj37nHmi9TXyZXJ9QuRBi+/2mY71t5iS0
         F1dXkzf6M9VmFj+usCtNPvN13U/UkbFrB2O3zRy2ObCpheAmQvIhpE2y0CwX3BnRfoW8
         KFoympG4eTGgSgiHdH9DGl48TRlNH/atTAw+NtOc13q1dRFzYjkguHeUZ3XZ4LwxDvf/
         sMcDrUWSCzQCQn++ldrw8CItg7S7udpponxXsdAg77Ja+C7pMYotDqpbo44T2hmHF2WB
         HWwg==
X-Gm-Message-State: ACgBeo2Ah2hdy7hxSChLdo/fYmq1u49Y5m4sLuKd3zjqqmquxKiboZSC
        Gf20uGHyisVQqYiSFxAkWH0=
X-Google-Smtp-Source: AA6agR7JMuieExtxMItJInX7x5ROJ6BsC9WvMHLa0/yaf92L6oTFOHBtIasKgc7TcO8y2gvcevC/6A==
X-Received: by 2002:adf:f407:0:b0:21f:a7b:b81c with SMTP id g7-20020adff407000000b0021f0a7bb81cmr661641wro.42.1659602593746;
        Thu, 04 Aug 2022 01:43:13 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b0022063e5228bsm422563wrw.93.2022.08.04.01.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:43:12 -0700 (PDT)
Message-ID: <11c7b04e-9837-440c-fa5b-3074a706e0ba@gmail.com>
Date:   Thu, 4 Aug 2022 10:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weiyi Lu,

On 29/07/2022 08:31, Tinghan Shen wrote:
> Update the maintainer list of power controller binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
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

Are you ok with this change. Can you provide a Acked-by tag for that?

Regards,
Matthias

>     - Matthias Brugger <mbrugger@suse.com>
>   
>   description: |
