Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904E4C19B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbiBWRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbiBWRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:15:46 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE75C4B;
        Wed, 23 Feb 2022 09:15:18 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so15413724ooq.6;
        Wed, 23 Feb 2022 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e4PkCxDqNZ/QNBws8yJs/gm4z10jVlnTI6wI3moUCvc=;
        b=fx+O8m5n7s2A5JqHGkBhEkDiW04hRd4xBdT5703AH9H5RrUD8+z3k6+/9OKLMZbLpB
         N/+5JTdkXTIAGqhPlxTYdBp7g/a1sArHs3O9dN1+r0igm175tljkAxA06E9Yqpr2ShjQ
         UCnJyuCFuuJMCwg6TgvCRMhSAo3rMLlNwgBlSlBHqCket5RRptbBhWYbnsO312StXQgV
         +td1vgpR3Gi+0MPdn9lGVCgCHA1aEAPgDWokWABMswHW3m2vIxh6Khka+IbltxOUSwCl
         hqY2sr2nExY9D2rygiIQno/9qpem/t87LcpsaJTDlD6hTdl+5PUoIgna+7wUtGqn1Jcs
         PNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e4PkCxDqNZ/QNBws8yJs/gm4z10jVlnTI6wI3moUCvc=;
        b=cvxyC0cxxU7Lq/9xUpKx8QrU6yziJ4eFn97lZ5su0sJfHMWhckcAm3eEU8e33myK+n
         oq/4s8RNlc6PVGu4iv6F+Km+O3SkQOKQ4FiI+SBX5RKWyo5xvrlUF5AkAJi5ib/K2XEI
         HHjcn2R5yqGVsFBbn1ZbcB0ge0dWUOEvWr05ZEdpPbjOsUaOfsvM3sh0Yfq91mAiE6/5
         cJwM/lOPDzfzNgzA23kCVJAujSDoGIgjq0n4Cc/3RAQ21PETyjzb40HrcNDb7/C+4j+C
         8MrqspNYkd7LDpM7YaZENOerxrkngPxDFwU7RtBba9LUx+ksaaq7P5GlxI7cJzX60uP1
         ceJA==
X-Gm-Message-State: AOAM532UcYyhlleSRD+OMPA5KXpV47ZE6fvE6qtjbnzRH0NCUFs6Wj8W
        /Hc6PIbcJ5GBYpEhWreH9hE=
X-Google-Smtp-Source: ABdhPJyIacNAaS70KnNLivW2KllJHtrp3Dos32bi4WqtFbNf55pQYTaG+wQSW4NjbohjRBEbXXX7kQ==
X-Received: by 2002:a05:6870:f29a:b0:b4:4825:58ab with SMTP id u26-20020a056870f29a00b000b4482558abmr286616oap.98.1645636517643;
        Wed, 23 Feb 2022 09:15:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w18sm94303otm.45.2022.02.23.09.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:15:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a4df2b86-528f-1cad-6d35-737ea28cdc79@roeck-us.net>
Date:   Wed, 23 Feb 2022 09:15:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: Add sample averaging property for
 ADM1275
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220223163817.30583-1-potin.lai@quantatw.com>
 <20220223163817.30583-3-potin.lai@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220223163817.30583-3-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 08:38, Potin Lai wrote:
> Add binding information for "pwr-avg" and "vi-avg" properties
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>   .../devicetree/bindings/hwmon/adi,adm1275.yaml         | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index 223393d7cafd..2525a67a880e 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -37,6 +37,14 @@ properties:
>       description:
>         Shunt resistor value in micro-Ohm.
>   
> +  vi-avg:
> +    description:
> +      Sample averaging for current and voltage.
> +
> +  pwr-avg:
> +    description:
> +      Sample averaging for power.
> +

Properties need a better name, prefixed with chip vendor, and the valid range
needs to be provided. Also, the description could be better, eg "Number of samples
to be used to report power values". Also, the chips actually supporting power
sampling need to be listed.

Guenter

>   required:
>     - compatible
>     - reg
> @@ -53,5 +61,7 @@ examples:
>               compatible = "adi,adm1272";
>               reg = <0x10>;
>               shunt-resistor-micro-ohms = <500>;
> +            vi-avg = <128>;
> +            pwr-avg = <128>;
>           };
>       };

