Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A54527E51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbiEPHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbiEPHLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:11:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F7B1D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:11:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so24160452lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A8n5NqBF8eiI63GzxK/IUYJgZos9yERKjGW1rbv7zxg=;
        b=emeGxsdreO/uEDfJ4oREHvWiB12JVp56nF0pafJi3R9OKjRFf2JGCvNtfVjFxlSdpY
         pE232FlSiaJXMlwIjhLHfDgbXNQFXJBDEtt9uEwYdSItjeo2eYQUW6cxmRpo5ifiWnrY
         Knhs9/RWgMbkNqHlNBXD7+TBKVdc/cASl5GCqMlWWB83McSh2XS8JEFgRmPfk4ux1+Zx
         GH47Ouv11aJ0TtJC5sHg7pIqM+92i7U8bvTubpXcFoCQyaU+yY0VypcEmnu3q8z19B57
         zS8Ml7S9/64EwVYJ2Hq880C76u11jin8rKOhlzqct+N8WkpeZsa6d7RfgiecsTag6cmR
         iTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A8n5NqBF8eiI63GzxK/IUYJgZos9yERKjGW1rbv7zxg=;
        b=sT0PwwVwso4p3KtHp3MgB05MgRlkmgKtFGBwe25cWAPp/ggVB24PJdaKCF2wuyPJ+s
         6OwYnNecfkaaqv+IzDSNplMSvLadnLwlZ7vonGUUQ2On/KwYCQP2llnJGpX+YrkQzifz
         cinRsEONFoE5JiHxxgoWEXHwy81dJVrBoZwEdzvFUwafDE0e6XIn6B20HmpRNiIUvOBL
         HxYoIBBLe4UB3RyUhBXo9Q3w6CdoEf/eXpAoP5JUiVWg2neebl2x+C37BtDX2vx2Zave
         PWW7omE9fq6DJ9vBRV9aNTEY0Rz/234kyAy45bWMIXP79vtJy8ST2fR3oBY6vD0r+XLO
         eD4Q==
X-Gm-Message-State: AOAM533JMNL2+TNbHXqvn8qd5dl7RhT982zfeV/Zxw6Fi3FJc3l/9/+X
        9TlcSvWm6r1yck9MXNn1qz4Uzw==
X-Google-Smtp-Source: ABdhPJzGJNyk3ngpENl93DzIF49UfQH5FyPJS9+J6d9kc/q8lHaBvK24mhQHZKq9hsJOS1mW5yonAQ==
X-Received: by 2002:a19:4343:0:b0:474:d7a:634d with SMTP id m3-20020a194343000000b004740d7a634dmr12034699lfj.168.1652685073277;
        Mon, 16 May 2022 00:11:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u26-20020ac248ba000000b0047255d21202sm1216927lfg.305.2022.05.16.00.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:11:12 -0700 (PDT)
Message-ID: <8b47e106-a567-8d8f-ddd9-34b71211002e@linaro.org>
Date:   Mon, 16 May 2022 09:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp: Add compatible for
 SC8280XP USB3 UNI phy
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
 <20220513225348.1671639-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513225348.1671639-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2022 00:53, Bjorn Andersson wrote:
> The SC8280XP platform has a pair of 5nm USB3 UNI phys, add a compatible
> for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 8b850c5ab116..0a9ee5b7600d 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -33,6 +33,7 @@ properties:
>        - qcom,sc8180x-qmp-ufs-phy
>        - qcom,sc8180x-qmp-usb3-phy
>        - qcom,sc8280xp-qmp-ufs-phy
> +      - qcom,sc8280xp-qmp-usb3-uni-phy

What about the clocks/resets/supplies in allOf:if:then?


Best regards,
Krzysztof
