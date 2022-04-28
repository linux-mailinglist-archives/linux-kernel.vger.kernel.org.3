Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7B512B64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiD1GWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiD1GWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:22:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307C05C664
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:19:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e23so4305185eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qSpiYuDH29eq2g8MAudhgN4YqWzQeYaIFMD6ATb4h18=;
        b=OM3VffNjCxysYwo4R7Q6uBuKO17OSvvPYFQg4VmIbXoowd0WttgYslgXD+DKWYQupL
         JitWDv1gYHfzp8voXmzlDY/Eu+++rk/DfHQ0sOlH/2zjf6Ytf7Poo1UGW0+cjCMOC/wN
         OxDKmIGwS7HA0PGBV7yDmE6esBfuIjOcx+VS0HuomlZ+Ki2JT6AM3lrKvmHtv06y2dzc
         xXkeb7J3CTbhiz14b+YYnICmvWtJTspq6tPrTkZK//3HEqbTB+SNmY7jHbihBlNFTVNI
         EX8PiUzJEneSH1SBo7nufFomnAz5UQWDrGIjLRHeoHduyr0XRABDk9pqJF/YJweG3ie/
         WL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qSpiYuDH29eq2g8MAudhgN4YqWzQeYaIFMD6ATb4h18=;
        b=d1HQmYis7PFRsHV9APCB4rPt/S9IIB1UZHu8fZpV1T6xujjI1VAzMzelbUZWasX4na
         +JvzDo3uMhJ+CC7+NBh95Gn/20jvcAK70z570H4Jd2nmzFEfqpBgJr51cniVi01EXQmJ
         Z3I2DTnETOmuniODabKYYZuzDHmu2Ps8rhJE56Bfv0Mgz/Hr4q0OfiWjQrnGLezIJMRD
         m4DcYUBlt+SHX4zHnvld22z9v8874yPSgFS0+mrXEc28Dur3KmsC7a5kYuyYVYTtTosU
         XWroOlezVKKwUIUwS1snHxoRF2dFM+OMBk9PRgUKX4dEoPudB7zU2N9UDKUMfDmaINeu
         qb5Q==
X-Gm-Message-State: AOAM531AVMIxoRtsWFWVnCd4MXshxDNVsiEB1oIlmMhD8TeW69U0ayS3
        kGSyllY4hYbzCD+Sy6RyZO3uxg==
X-Google-Smtp-Source: ABdhPJyyM8aMU6P6frP+mimqEckiRyuCxWNXYcVA4bj5P/YxhAJ8OnhqYajmpyq/FRyxXt9ij5XG5A==
X-Received: by 2002:a05:6402:3719:b0:425:aa90:f174 with SMTP id ek25-20020a056402371900b00425aa90f174mr34323272edb.305.1651126738795;
        Wed, 27 Apr 2022 23:18:58 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id wh24-20020a170906fd1800b006f3a0a8efd0sm4678602ejb.110.2022.04.27.23.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:18:58 -0700 (PDT)
Message-ID: <53212a3b-d02c-ab5e-6b5c-e19d359c7c2b@linaro.org>
Date:   Thu, 28 Apr 2022 08:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Update bindings for K3
 AM62x SoCs
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220427072703.4898-1-kishon@ti.com>
 <20220427072703.4898-2-kishon@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427072703.4898-2-kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 09:27, Kishon Vijay Abraham I wrote:
> Update the PRUSS bindings for the PRUSSM instance present in
> AM625 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index 64461d432004..cf13e5179657 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -69,6 +69,7 @@ properties:
>        - ti,am654-icssg   # for K3 AM65x SoC family
>        - ti,j721e-icssg   # for K3 J721E SoC family
>        - ti,am642-icssg   # for K3 AM64x SoC family
> +      - ti,am625-pruss   # for K3 AM62x SoC family
>  

Looks like out of order (although for some reason before it was also
misordered...).


Best regards,
Krzysztof
