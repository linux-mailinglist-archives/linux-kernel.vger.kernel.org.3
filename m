Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC550E801
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbiDYSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbiDYSYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:24:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EA79385
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:21:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z99so19461916ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wLhrlS1biKXpq5R4CE1YOn/L6FhykNWvxC4seQ/LW7U=;
        b=Fdw8tEJ7RzBEPPkeLkKiIRIonHGhUX5ZA2Ot4Xn7/Yf6h0e59AOylh6JysSNkqVKKz
         yeVOsu0matmwSl2qhR5pORhklf/+jvhzgB2PvcZyAbBmumv8gfAqge0Ufny3JDw0W9Wh
         fRXYNNTn+1W6VCYwgRbuxg4bQuC+nfFjpA7SgNRay92xwXG8bTDNw5l7E8oUhTFNhq2O
         bN67RgacYBXUua0id/Z0rSQXJNw+oK2jnAbWuWerE6tFYB52XBIBho1mVKC7OrSzlsi+
         DU26J+WDV0VSAUxCbrymNsH5yDPP8207EqHb5qqGGK/ec+v1O40t2OC3ropUGVruR2VX
         or1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wLhrlS1biKXpq5R4CE1YOn/L6FhykNWvxC4seQ/LW7U=;
        b=42ZejlKjOl845SzA829u0y8VJKAuJ9ho+8q3hGoF4vMqFIoYkos6Rpu4sMOKMdMxk0
         SEEiJHruit7HDpeDwfLjGyzJDJUzgNgKUU+E8ve+qdArcP/EDKioFTVy6X5jqzUIMckb
         rkY7A+co+rmY+0heUAfNDbRHIYINSP3Cg11xAInzvygltNlCnOjudOgkeQYF8PmJ/Dfh
         PhOvSJAZP/ZJD9pDV4sJq3MY2NS/uF7b5QzKhX4EJd0BxYua3GjKRluOSF88k4zFtrz1
         tebh4S/V1+yeEl8IYlvsJS+M87hbqfGZFkw6Rjb44i1gqYvatV3gXeBSCbColJdkzTa2
         4yyw==
X-Gm-Message-State: AOAM532Qt9l1bT6Z/wG1EzitlquOj4XbAuqJCBA6lILOE6dWxUkscyDr
        Ssh20IjQ7z5qq0XO3KeoOTuk1A==
X-Google-Smtp-Source: ABdhPJwFoDnOLO0ckjGSwySlRYkY5M6AxkwPge7ifg3C7ch3KjrcUQD9X+CEAmNNCNFRJ3zcSLN5lg==
X-Received: by 2002:a05:6402:1450:b0:425:e43f:7ccd with SMTP id d16-20020a056402145000b00425e43f7ccdmr7717463edx.299.1650910874949;
        Mon, 25 Apr 2022 11:21:14 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kb9-20020a1709070f8900b006e889aad94esm3894075ejc.128.2022.04.25.11.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:21:14 -0700 (PDT)
Message-ID: <edcd5a65-26ef-a8de-be44-56aa63e485c3@linaro.org>
Date:   Mon, 25 Apr 2022 20:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: fsl: convert fsl,layerscape-scfg to
 YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220425140214.32448-1-michael@walle.cc>
 <20220425140214.32448-2-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425140214.32448-2-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 16:02, Michael Walle wrote:
> Convert the fsl,layerscape-scfg binding to the new YAML format.
> 
> In the device trees, the device node always have a "syscon"
> compatible, which wasn't mentioned in the previous binding.
> 
> Also added, compared to the original binding, is the
> interrupt-controller subnode as used in arch/arm/boot/dts/ls1021a.dtsi
> as well as the litte-endian and big-endian properties.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - moved to soc/fsl/fsl,layerscape-scfg.yaml
>  - generic name for node in example
>  - mention added "syscon" compatible in commit message
>  - reference specific interrupt controller


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
