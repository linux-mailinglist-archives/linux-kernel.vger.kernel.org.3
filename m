Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E114EAF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiC2O3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiC2O3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:29:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C2222F3E8;
        Tue, 29 Mar 2022 07:27:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so1624595wme.0;
        Tue, 29 Mar 2022 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UkJOWRMCUbYGorBI9uSjtZM4DcqQkhNQvraKREd6DJc=;
        b=V1fRhBIzg9+s+zRnUxg0fUPZxucXslx9ozftXP1RpkHrH4Ef/J8W7paMsNPEPzNxWp
         /+Ns57oOWvMkb+7cVyvajnyIZ2+yq4WYSY+FWPo89ChQev2ybZaNvp7Hn/qmjA5CdEKM
         73JvpoORSJ1tAfT4h1Yt1/pEtUUwyPm3yFV2bqjzBPkbPARl4U0g1qwDrdxAMHlfF1sJ
         SGrTJ1HowfJ8kmHppGztqy+CtZcl7iQKEd/VgkKew8vlAAVgS5hVKn1w1TmYwmiWcor5
         S42MkiEXSmEGlOXujsai4H4vmK3sMM1+Yx+59rNiHmIwoNyQtdcVWaG4DvPSBIZ6sflS
         5lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UkJOWRMCUbYGorBI9uSjtZM4DcqQkhNQvraKREd6DJc=;
        b=hqIpWqkv+IKYg2hKwke9RsbTTjsdtOavd0F270TM4Mt2ehQVcUm+5RhD7Yx8H/LCg+
         qWtK4/Z6THdKQGlEdd69eHTlXn1bU7DSjMoaHxktUHBQk1pbBG/PPt2INxLx88ds+U6n
         bqMJeavrAWSJFkxPNMya0+0HJzZbtKTuqyAyyi59uGE9BhRFS6FCwsI6Yy2uh6x59y+s
         TC9RCTEKvkOC3rKLvrsRFSo1xvy0sA23jtx8xSIwJQlcJRSkihrWuphAhOj9fmKjuGd+
         GFB8ca2lVcthsSu+gSqEPDai5Z8PjDNplG80sH45svnnkgS4zy0tyjR4wlzhO+mMejRZ
         H4yA==
X-Gm-Message-State: AOAM532w739N/oYE2HnWv3wloRGJpL00LkyNyZ8BD59Ex3UjHNC7uf6j
        Wmta6+xAHGBtMyohBKsVvpY=
X-Google-Smtp-Source: ABdhPJwX2KEy3tkZ1IjhynPidjlbcvxK0tdLnJQsJX0bhkANmcG0wKDngAHg7t+Pw1CwomTxSCE3nA==
X-Received: by 2002:a05:600c:19cf:b0:38c:b1fd:1fc9 with SMTP id u15-20020a05600c19cf00b0038cb1fd1fc9mr7334595wmq.103.1648564065633;
        Tue, 29 Mar 2022 07:27:45 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4348000000b00203dbfa4ff2sm14956641wrr.34.2022.03.29.07.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:27:45 -0700 (PDT)
Message-ID: <32931f81-5615-8156-4c67-bb4260488185@gmail.com>
Date:   Tue, 29 Mar 2022 16:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v12 2/3] dt-bindings: mmc: mtk-sd: increase reg maxItems
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220329114540.17140-3-tinghan.shen@mediatek.com>
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



On 29/03/2022 13:45, Tinghan Shen wrote:
> Add optional host top register base for the reg binding description.
> 

Is this based a on a new version of the IP? Shall we make the second reg 
mandatory for the new HW? If I remember correctly the reg needs to be restored 
after power save event. So I suppose mmc won't work if that's not done. So 
optional wouldn't be the right approach.

Can you please clarify if that's the case.

Thanks,
Matthias

> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 7032f7adf3ca..6d41bcec900f 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -40,7 +40,8 @@ properties:
>             - const: mediatek,mt8183-mmc
>   
>     reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>   
>     clocks:
>       description:
