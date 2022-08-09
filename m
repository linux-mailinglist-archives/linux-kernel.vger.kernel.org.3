Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7458D351
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiHIFoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiHIFoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:44:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9E21F2DB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:44:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y23so11905997ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FI4To5jHqN39miuQQ5GtcgN7QV66DDmgPD6y4XMVAQo=;
        b=euJ2qWDssIx9t21bUsosyWW2rBWJfg1GZDgAuP3pH2TugwNXbTPZnC6kEzfPX8cpNG
         3faVNP+EbRsgKelYIJSiK77ASPCFxEfvPdz7VJjYEPiJjJTjLc3aySFOjQ8R7A68hjTF
         2bZUdSX48Y7QTGXi2a9Yw3AMCAKvYe8zfZJ03tb2UOopBlidLObIs1c4QAi9yhxMmQkO
         Q+8qsAdc/G8QXntNLSqphuVp4XZjg91VZgSn0+mP9kKfgMkE9CyJDLG4JwQkSL/6bY/C
         czaI9v4zznSy0QeM9ajDbBagnhgVvx6gAtbEdqf6zyS1dbyKH0wiSQKQDbp+fsKzFYoM
         2IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FI4To5jHqN39miuQQ5GtcgN7QV66DDmgPD6y4XMVAQo=;
        b=XZ7dIhiz/rJ8+rh/xS5aK/sjqA5j9B1IyDm9nFPI9UVgjZK4IFLR3gZ/iW+TpwjJX1
         PBuPtO1ieFHVE+G9j8/I+Iaqb15TzW6jBr49qgdnB+ptX1h5+SEMOGtFtKIYQqAQL6L5
         mmnfyZMm7dk0JK5fScH13IZ/aL6toWnv4G3uxkWzYaiwbduWxJnVoCTncFHbXpieHDNZ
         L9khW2bOXFiS7RIZs3kSRjDTP2xCLIKqsooF2NS97POxREts4UPhhzZEHDodeWoifBHn
         zVgfSc9dRDlygE7ckEVZBBc0/qZpV3QkYgE3k+lUURV+QodxCloADVjMbgEw+qcKKKPD
         Rbxw==
X-Gm-Message-State: ACgBeo2D4iM4vYK+dSrDwYaRts52PmwFBJhtTdROJUeYNHrNBHujVITx
        2lyljWT3EuifOP1vdiu2Yh5/yA==
X-Google-Smtp-Source: AA6agR4wDGK9Bd2zYgQEapxkPv3dwBhu40WO1DHuINBqElReoxpFMuyYkVUCq7NHklvH00Roa6cUPw==
X-Received: by 2002:a2e:9884:0:b0:25e:4b41:75da with SMTP id b4-20020a2e9884000000b0025e4b4175damr6505032ljj.339.1660023857070;
        Mon, 08 Aug 2022 22:44:17 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id d10-20020a196b0a000000b0048b003c4bf7sm1631645lfa.169.2022.08.08.22.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 22:44:16 -0700 (PDT)
Message-ID: <c97e7080-9d93-ae09-9bb2-106539f9b1ae@linaro.org>
Date:   Tue, 9 Aug 2022 08:44:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 1/6] dt-bindings: crypto: ti,sa2ul: add pka subdevice
Content-Language: en-US
To:     Daniel Parks <danielrparks@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1659985696.git.danielrparks@ti.com>
 <42d04e9ec43d10f978cee1dd974bbfdccf121d85.1659985696.git.danielrparks@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <42d04e9ec43d10f978cee1dd974bbfdccf121d85.1659985696.git.danielrparks@ti.com>
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

On 08/08/2022 22:12, Daniel Parks wrote:
> The PKA (aka eip29t2) is a subdevice of the SA2UL on k3.
> 
> Signed-off-by: Daniel Parks <danielrparks@ti.com>
> ---
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> index 02f47c2e7998..e4adb8192608 100644
> --- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> +++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> @@ -64,8 +64,14 @@ patternProperties:
>      type: object
>      description:
>        Child RNG node for SA2UL
>  
> +patternProperties:
> +  "^pka@[a-f0-9]+$":
> +    type: object
> +    description:
> +      Child PKA node for SA2UL

If PKA is from "Public Key Accelerator", could you include here full
name of the abbreviation?

Anyway you need here reference to schema for your node or describe the
contents.

Best regards,
Krzysztof
