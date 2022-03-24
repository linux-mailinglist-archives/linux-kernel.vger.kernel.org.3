Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2C4E6806
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiCXRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346885AbiCXRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:47:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C00B2471;
        Thu, 24 Mar 2022 10:45:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so7702960wmj.0;
        Thu, 24 Mar 2022 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xkcd8cqeeklF/h/FFb9fiP6tou2pDeaGtCw9wrYVoYo=;
        b=cCrnhNDLmJdqRxvJY4yUMQkpnGQzjVbih+/LxojN8EXx7UXNGwPEU1gU9fdWpdSh+Q
         tWWE3zVixulfIxSx/7WBAeeAw3NTTUBHhRRIBVLEweuldDpPnULDAjJS0cz2YQmGehi/
         FZsTVmkZvx5YvZTAoqHSDVdRbL+ysNjwHA9nj/Sa9MuUPacHyANfewyMDySb2NfPlQpD
         E6U06DKsK2zjGzgL6fffkkliIyXuGwv2Pi/TLmUPMKhGZphlssATB9PfjLhitElx0Hc5
         l9HmSc6PTAd9XdXphmMF1181ahdSObqYz71BNF2rp6iDwSQD6gKNiJ/5aUuo2w1ibSIz
         VxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xkcd8cqeeklF/h/FFb9fiP6tou2pDeaGtCw9wrYVoYo=;
        b=YT4L2A2gCMgpP1J9jkObfV8ih/2iS6qevpYnQMi5PNiLuLeKQa9ABE2AihOeMK/7NE
         yTNQOWI6Eit2g73NHlWSSIm+FfFzXqhpGgbFDTh1URIQxUZ4pqY9lK1liiTFE4BaTBT3
         S/gxvdfy9bxeMuy4sOHt8V2vPPCFmpI/M1QGxLPqyRGjBmRDHtDc9OXtV3nrmS2CG/jD
         1JCEKeIKv/1vXs+z2n13T9Bgn6SqaR6s2GC5h51MGjGvCh6o23A/1xMplTDJLjyDi2MM
         qyUdyfpLcQnF0rIdwMyUgYjohBCf2pwzKKhyBHESnniL5DKV7F3594koWInW1RU1zei0
         cTdg==
X-Gm-Message-State: AOAM533ROtUAbEi5Z7X1gRULSHBqgDAGdHprg4JYX/+ESrv1fyMrdiSL
        JEmd951FK8MpVO5HRS+/pgmItYOIFHIK0Q==
X-Google-Smtp-Source: ABdhPJwSoOM3Bkd++UOmpy7a+gbxRrT67AW4Qn+lS+78WGImo3CY8Dx7pEzPxToCJb4cUVix9FSxpA==
X-Received: by 2002:a05:600c:4611:b0:350:564b:d55e with SMTP id m17-20020a05600c461100b00350564bd55emr2962505wmo.124.1648143943465;
        Thu, 24 Mar 2022 10:45:43 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id f7-20020a1cc907000000b0038c756fe683sm6514666wmb.43.2022.03.24.10.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:45:43 -0700 (PDT)
Message-ID: <4f1c609f-f578-5b1a-39c1-44d59b6cfd2a@gmail.com>
Date:   Thu, 24 Mar 2022 18:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 10/22] arm64: dts: mt8192: Fix nor_flash status disable
 typo
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-11-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-11-allen-kh.cheng@mediatek.com>
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



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Correct nor_flash status disable typo of mt8192 SoC.
> 
> Fixes: d0a197a0d064a ("arm64: dts: mt8192: add nor_flash device node")
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 3a7f93d8eeaa..75c21edccf85 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -934,7 +934,7 @@
>   			assigned-clock-parents = <&clk26m>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>   		};
>   
>   		i2c3: i2c@11cb0000 {
