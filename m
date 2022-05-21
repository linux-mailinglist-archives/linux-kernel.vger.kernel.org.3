Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9B52FD62
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355266AbiEUOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiEUOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:40:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D866C83
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:40:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s5so12424944ljd.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j19Sjx0q6UvsLhEfsptOk4fcD1qgJ70N5tv5+7J6N4M=;
        b=alP6nMeEFFKqlxICurlpjOsnDodmbu2wDTZ/WazBNZR51QfPcBwHIOzxh8NzDQAC11
         iSghOXLvvDwXPZXa1Ds4wAWZwGurFAuV8/FXsqJdQrdE8SyT8GKR22Trxm/dOhM9rWzt
         nqwKfoqkdVSgUZQj/jvrUKOnRERmucVST+Zd6Gc1UpS0x3vpV/wybI142eOY6CXg3QVE
         P44CofAAclyPl5l5Co4DN6UwB35wwtgzXRAmk3g6i9BCfuirDW2BXT6qWIPRi2AouOZa
         /Mk64xT3eAnzWa5ADV6dAyEMrcfZNqueCZnCyVKrAnioFz8iyTlmYPGNTo+zitDwggQu
         iaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j19Sjx0q6UvsLhEfsptOk4fcD1qgJ70N5tv5+7J6N4M=;
        b=gRTkEbDwPoSmbA4nLswsRKKsL2XO7nZnD25goSw5VR0WSZ4+bGStV2RQwq6dTT6QAB
         3pOusJLCMIC7/hJAtZ9p5v++bqbuG2r0izhG4cFCI7mQOP+k2DuM4KqPWkaQsUGGUNb8
         8wbMJV6e1XpjAsg9coP85eN0mkYDErMO0hq3hrYF3fF34RgmPrsL+1vYM4LcyZVOBDba
         EP7Fy39m51yhaP6ahbVGm3tXeqRVlSdYqwAb1g5HuLOft+EDx7eiKEAR3gYgPg2NMGMa
         ENiMl8bSiRMgGMSnxh1oBj7i7IKDrESFQzosMYWY79VKaxeOns+CWD7KZaC4Wr+AQfLR
         gGNQ==
X-Gm-Message-State: AOAM531zB0BgkZsrYZveejWLma71r4lNycgLpa1yoUWC4EYawYuHN3EL
        rH9UZcZIFhWoZ1j/QxAQlvklXdoZ9Z5EE8UH
X-Google-Smtp-Source: ABdhPJzgO95+ZPSch9T/8e1MpH4o+NvJ9OqA4NNkB8w8fbIUHjj+4ntJjdXDnYPIbvxY74DW+LcR4g==
X-Received: by 2002:a2e:81c6:0:b0:253:dffc:8093 with SMTP id s6-20020a2e81c6000000b00253dffc8093mr3621977ljg.165.1653144016010;
        Sat, 21 May 2022 07:40:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b0047858fca29bsm539740lfg.42.2022.05.21.07.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:40:15 -0700 (PDT)
Message-ID: <77e013bf-feba-268d-5cea-18008115f478@linaro.org>
Date:   Sat, 21 May 2022 16:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] dt-bindings: regulator: Add bindings for MT6331
 regulator
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520133305.265310-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 15:33, AngeloGioacchino Del Regno wrote:
> Add the bindings for the regulators found in the MT6331 PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/regulator/mt6331-regulator.yaml  | 272 ++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml
> new file mode 100644
> index 000000000000..333c74cdbcbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml

mediatek,mt6331-regulator.yaml

> @@ -0,0 +1,272 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mt6331-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6331 Regulator from MediaTek Integrated
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description: |
> +  List of regulators provided by this controller. 

I don't understand this sentence in the description.

> It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  MT6331 regulators node should be sub node of the MT6397 MFD node.
> +


Best regards,
Krzysztof
