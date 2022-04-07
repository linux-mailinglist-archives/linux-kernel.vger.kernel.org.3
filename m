Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB04F8776
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbiDGSym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347015AbiDGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:54:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506A198531
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:52:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f18so7505142edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LSrB5ZSufgqlnK9gL9ZTZVASbmrEu9CqOwd5kSfzetw=;
        b=QwSL3qZenEAdVWiG1sko9Mb/zJvDcltL7tVrGmYdyNBzY4zmOiDF5pCRBQxAiFNgY/
         I2wF+7U1k3CadYD6N2m6hNjG3YXLKkLrJVReGJ4pZqJHSVDbf87lCIdE8w5Mq+ssVVWc
         Ab/AXwFf1W3oUYR4auM85S38gtywj97sf4TYNbt/jorXwXpfgUe82neOjQDruWPZZ61M
         zN/VlQbreHEbmqqoepv5PUEir92DMJ5UptgIBNfQi2+7lmPooscyL2lvvmTX98BTvrHw
         BTEmpomwoFPbC8vqb6ZWbBXIJhv0QFYb+dFQlOVIXLtCeuzHeVsc45nw4z4zQkfYlcAw
         EDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LSrB5ZSufgqlnK9gL9ZTZVASbmrEu9CqOwd5kSfzetw=;
        b=YjhR9uSkoURObOCkkDNR5LGoiOtb3KU66r76Wv2//dfx4HsI76kxRtSi7hwo45c96u
         NNX8WWgEEqijIp2LPHMeKRuXdZ2WCROqZsWdwv3OBkt0vChPw5R8ZatMGsfw8LBXW7BH
         a2kMaVos1SSf+WkSgLQESTPfoA1tFJ6+RHqFdCmvENoVizR+SsiTD9rcaZpEWrDMK73B
         txupUWRvX2qY0J1Vc+pgQD2CxoB+R/Q3Qec/AaMYcigwI5hp14ldA3wburJ8yat+Kde0
         Y5ByAGhNzAezrjxCh+n5bSePtEofK7Mi4vYjrrchIKwG9S4qPb0kOIPItxZcPIw8zid+
         Zp1Q==
X-Gm-Message-State: AOAM533z5COCgZvKNWiCg1ocE5kQwBdA9U25PKisjlKAf6H1QJrV5cZQ
        tEHyf84wqn1mdQr71FCxAj/uFw==
X-Google-Smtp-Source: ABdhPJyjWS/xkSQpxE1xsWATTzEmh3/25DFKD05Tap4C5ZGjW/efdjvUqFCLVeqq72XdhY644iBIFg==
X-Received: by 2002:a05:6402:218:b0:419:d804:9483 with SMTP id t24-20020a056402021800b00419d8049483mr16004209edv.396.1649357555980;
        Thu, 07 Apr 2022 11:52:35 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id kk13-20020a170907766d00b006e1442fcff8sm7961379ejc.175.2022.04.07.11.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:52:35 -0700 (PDT)
Message-ID: <6769ea2d-9e6a-03b1-0e05-cb5b7379cb5e@linaro.org>
Date:   Thu, 7 Apr 2022 20:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/11] dt-bindings: spi: dw: Add Pensando Elba SoC SPI
 Controller bindings
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-6-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-6-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> The Pensando Elba SoC has integrated the DW APB SPI Controller
> and requires the property pensando,syscon-spics for access
> to the spics control register.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Add required property pensando,syscon-spics to go with
>   pensando,elba-spi

Thank you for your patch. There is something to discuss/improve.


>  .../bindings/spi/snps,dw-apb-ssi.yaml           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d7e08b03e204..41c3bbf5a55c 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,21 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - pensando,elba-spi
> +    then:
> +      properties:
> +        pensando,syscon-spics:
> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description:
> +            Phandle to the system control device node which provides access to
> +            the spics control register

It looks you only need to poke one register from spics, so it could be
something like:

    items:
      - items:
          - description: Phandle to the system control device node
          - description: spics control register offset


Best regards,
Krzysztof
