Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08550B9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448633AbiDVOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448601AbiDVOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:22:40 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508E5B3C5;
        Fri, 22 Apr 2022 07:19:47 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e68392d626so3680834fac.4;
        Fri, 22 Apr 2022 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X7u3kglhM0VkTW03FStsvrOnIn+Xj3SEcCEn4rSVb2M=;
        b=doxXGTkzNgr961Vtac0I8Zhl1wa8l2EJNGL/EiZdctp1nfqY1r9tiLc66rTrOW3sEi
         RM00KIuonmmVfjOozzjwUSfYjHAUfJ7amPN0xWq/HHhvULB5GFvMHxpxNEbuhAlEYCL0
         6Nf8JzIoaCqKa+yuJ6fWuhCX5BK68o+amMSrl/s+9arho0DStmzkxahga3IuG+Ocn4BR
         PoOR2jNDY8NCUcyc/VPL7BFtTkGadWnHZhkOTxupp2+jsz2C+D+htRUAK66VY8lCl0TZ
         BYTnBGEsVFMl4EEb4TVVqEkULyAgxKx3JIT2srrQxoXOaRNhusHjeY9oh7fKTUj8Qw0Q
         gPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X7u3kglhM0VkTW03FStsvrOnIn+Xj3SEcCEn4rSVb2M=;
        b=s2kEAt3+bzufjJM1jyFkvkZd+LNJI1bdFIciJODMSAbue1Qqk0OZvnbIlHM8A5WQW0
         c0WHgGkpLrFs/oobnhq//DehpvSAxCv7oPB9+djJ7sQrQCgWSS7lSGRWge+nVqHs3tpy
         WYKtrGXUzU3huF1oanulhYJFySdft9PvnsN4fPxFJOJinps0+OgzlGrQbaL1xFix/v2C
         BSpSRieuEANAeHv31HJT6+DM90ttFTPPCx97AscSuJnxdnPKcsLiufz7nb3sipWl6lTB
         rgEAKABphLGgbcTmV8zYqdh/9NNzP2MSTmG2KQk01/9McSBDVOFtZMx+i3PXA+bFqy/0
         AaHA==
X-Gm-Message-State: AOAM531JavnePIbMOZaajtsjeaxFiVLKilwY6yJYpHXrloD1yrmb2czD
        XnBLtG0RELPLEV3DhheYSN8=
X-Google-Smtp-Source: ABdhPJyRUn+Uq4kLyzdsgMmHE5kkqjywZFQ2SL5fSRXPWW5Su/ofYv0nnbjSTPRCJnLsPK5NNqvn4A==
X-Received: by 2002:a05:6870:589d:b0:d6:dc7f:6b10 with SMTP id be29-20020a056870589d00b000d6dc7f6b10mr1955692oab.175.1650637181912;
        Fri, 22 Apr 2022 07:19:41 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c14-20020a4ad20e000000b0033a371fa815sm806446oos.37.2022.04.22.07.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:19:41 -0700 (PDT)
Message-ID: <4373b922-bd07-c02d-e43f-0426690cf47d@gmail.com>
Date:   Fri, 22 Apr 2022 16:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 2/3] arm64: dts: mt8183: Update disp_aal node
 compatible
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        yongqiang.niu@mediatek.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, allen-kh.cheng@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220411035843.19847-1-rex-bc.chen@mediatek.com>
 <20220411035843.19847-3-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220411035843.19847-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2022 05:58, Rex-BC Chen wrote:
> The driver data of MT8183 and MT8173 are different.
> The value of has_gamma for MT8173 is true while the value of MT8183 is
> false. Therefore, the compatible of disp_aal for MT8183 is not suitable
> for the compatible for MT8173.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 4b08691ed39e..a3616005d65c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1466,8 +1466,7 @@
>   		};
>   
>   		aal0: aal@14010000 {
> -			compatible = "mediatek,mt8183-disp-aal",
> -				     "mediatek,mt8173-disp-aal";
> +			compatible = "mediatek,mt8183-disp-aal";
>   			reg = <0 0x14010000 0 0x1000>;
>   			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_LOW>;
>   			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
