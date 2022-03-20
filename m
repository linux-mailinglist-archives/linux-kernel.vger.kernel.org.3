Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C84E1C1B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 15:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbiCTOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiCTOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 10:52:21 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857CDCE2C;
        Sun, 20 Mar 2022 07:50:58 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id r13so25424866ejd.5;
        Sun, 20 Mar 2022 07:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6b3xZk36oovOgJRDq9Ftmq5jhE/QMgxCZr7fWROPj7U=;
        b=MX3G2+dChoNZ37xzw12gCOARoM8Ztg0cy4Eh1QyX2MRY5i0daHCxbyZj+1BXIYE7aL
         OjO/pE9FF/AMCO3LjZP56o04HitsXx8R8lVVff3w8w3ValZV2S/MiK2cR2Nwccyai0xG
         3YScpL9Q1ejJtsHccz6Fanpq2yzHPdaK6L5Ke3XkpHs+qdCx7/2Dx/4E48Y7VwnZza7C
         0Hek+QhnWxaBf4/LO9e/9k4mwcAAYoz10/6+L0rIcKdsOS24UvvDIQdXR8Ov0xXsWEST
         GoLaGgL4UeHn/UrpytZtBHV/3FxCOAReEZo30LYhaO8uaAchF+vfROWAsoHTstn+b7be
         aSnw==
X-Gm-Message-State: AOAM532y32Gkbkr/tJZPXb9bc//TQWgAFFo8W7T1rvvDIISJbJnnUKgz
        KFn6T8dwBSvCZTe+BP84XtU=
X-Google-Smtp-Source: ABdhPJw0NndMeCaWdvMKhqk0lKOwChrfpfT5Oett1TIH2B7OM+fMfVwnk70MftDmct5E9Rbd5vNOlw==
X-Received: by 2002:a17:906:7943:b0:6df:e5b3:6553 with SMTP id l3-20020a170906794300b006dfe5b36553mr5093371ejo.398.1647787857194;
        Sun, 20 Mar 2022 07:50:57 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm5854434ejb.194.2022.03.20.07.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 07:50:56 -0700 (PDT)
Message-ID: <6e4f64dc-bb3d-0e05-0380-7e6f3b1a823c@kernel.org>
Date:   Sun, 20 Mar 2022 15:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dtbindings
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220311164628.378849-1-gengcixi@gmail.com>
 <20220311164628.378849-2-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220311164628.378849-2-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 17:46, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
> dtbindings.
> 
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> index caa3ee0b4b8c..331b08fb1761 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> @@ -20,6 +20,7 @@ properties:
>        - sprd,sc2723-adc
>        - sprd,sc2730-adc
>        - sprd,sc2731-adc
> +      - sprd,ump9620-adc
>  
>    reg:
>      maxItems: 1
> @@ -37,9 +38,32 @@ properties:
>      maxItems: 2
>  
>    nvmem-cell-names:
> -    items:
> -      - const: big_scale_calib
> -      - const: small_scale_calib

Please test your changes with dt_binding_check and dtbs_check. Your
change looks not complete - you have still nvmem-cells = 2.


Best regards,
Krzysztof
