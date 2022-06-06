Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0402153E858
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiFFNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiFFNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:01:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69404527EE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:01:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q1so28815984ejz.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h1m3RQgl4XOArgt66k3NUS75Xxdt0168uvwBuanYOsA=;
        b=E5H1VvUpCKh6EY97ERLISONJ4bt1XDT4xrpgdLOUS+fM5kqjjAr+Xk8msa5eZYYd6Q
         9K9TVTkCKd4stBAPxvFaJKWB11AVgpvutQ3t7MHBzTV3JNXcECnYFXGLEyAGazGEw2Ke
         n0+yNf4gDGDuuk7yrNY31O3hdDKR3SRXAO+OLB2m9wgg8gC9TuUPZNhc6Aq1Hy+cpv9d
         gAx1BC7ju4s21/+9Tf4h2cmVlGUJBV/wKVk8GTmACbBtnbtzm63lcwToO2N/IslQY+jp
         9OEHiyU2sSObzY51gNWmQ9bn65LjzIzEdq8faRn3piuit/BNe02+tIL770/gFS46ypw0
         2CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h1m3RQgl4XOArgt66k3NUS75Xxdt0168uvwBuanYOsA=;
        b=CzxJ81YtvJUxSMOYHyaPwjPeYJeLfgvo8W4Aag4ihBJeD2QcND/ekhz9Krh4OK0NGZ
         l3A2boPwwS3Xzx2Ifa+LthAgCp+jES/G2hVGQivlTBpbbtlr6fLNNto+gfrcc6npY6tL
         IbzX+PcxUe8ABh6rZSTz5MLbHcFX2b3+WjotjgVEkwrfGvd/Nz2iFx6qNziqOgzIJ3O5
         HpilHIJBCqD5JnG8E5i2wBBRNR92ZTF8LlyPiEn4lXTnqCxFeR4iWNOI60hSKBb4bGMs
         V0EufudYWw40hD2yj5u5i25QCKE9WRNFHXYlTqhzYfJjAN7UvQFxD5ixdA95H78z2xzU
         vmng==
X-Gm-Message-State: AOAM530Ohe5SxTaYN2JPSGnKcgAd9zYrQnt0H3rKo4WT2keRZwxXmELX
        nkEQanxVtvQ7T55DcIr3EO+uRQ==
X-Google-Smtp-Source: ABdhPJws0YTuXlPG7rD3iB4yGZAKH7ihRhnQrcSFYkPV14mM09aTsOcUCFRHvzhpIa709UCZYR3Whg==
X-Received: by 2002:a17:907:3e8d:b0:6fe:d99b:90a with SMTP id hs13-20020a1709073e8d00b006fed99b090amr21447213ejc.416.1654520476858;
        Mon, 06 Jun 2022 06:01:16 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yz17-20020a170906dc5100b0070b1ecdc12bsm5117954ejb.112.2022.06.06.06.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:01:14 -0700 (PDT)
Message-ID: <ba24037d-8c31-ea35-6fc9-ed8a61118848@linaro.org>
Date:   Mon, 6 Jun 2022 15:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603121802.30320-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 14:18, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 97 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ------------
>  2 files changed, 97 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> new file mode 100644
> index 000000000000..221bd840b49e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)

There was a v2 of the same patch to which already commented. Now you
send the same patch, without comments applied as v1. This does not make
any sense.

Please version your patches correctly and do not ignore received feedback.


Best regards,
Krzysztof
