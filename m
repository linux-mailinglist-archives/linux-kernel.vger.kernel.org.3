Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32574C6F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiB1O0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiB1O0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:26:31 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E76AA71;
        Mon, 28 Feb 2022 06:25:52 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id p15so25117161ejc.7;
        Mon, 28 Feb 2022 06:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lAuE/qWfK53nr/4CQntZKh4zmnsfMTK0BgEe79BZdgg=;
        b=jwjQ90dS3pg1eqsPtQnsfpqGCpAo23rMAh7ls5TWo48Rl/Xx36rdF8116v+3EFCtSI
         R84SJTQyqRJc0qMnD/hO1HLzr9jMfWgYRASQHl0mqJ78wVLkPz8Ka+EZzqdfrYwKPL3I
         jMYbE6c/PR9HazhCJLXVwgrVxMI19Aa+V0VyMMVqe/B5Bkv4Oax45Rv4jbWpECamHEg3
         cP01/QYq/jS+f4Ez5Ilg22Hb521BPzbEoFR1LqDTn7TJlVDrlm2DNr0S+uI+/oQ8siQd
         G7cvOAhP3vJcxBaBRE4D5dNOZbfA2A7VMoNdg39OVrz27h10Pnl7/7j9VCZeCxyZs+s0
         nu7w==
X-Gm-Message-State: AOAM5305I+uop1gbgHrXTFoQVrsG4+IzH7Ko86XbTPw/qM3Cd3oJoTCi
        QM2kljXVeO+Fs/ub7ONmRDiv5aeJL/s=
X-Google-Smtp-Source: ABdhPJySZ0lqLr7LKuNxlomzEKr6mkyIZMYR0oEQIrGjIlkgFoKRqnxSJJTPoXL0XXQx408yZqErPw==
X-Received: by 2002:a17:906:2b58:b0:6d0:938:887e with SMTP id b24-20020a1709062b5800b006d00938887emr14624518ejg.644.1646058350913;
        Mon, 28 Feb 2022 06:25:50 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm6213540edj.49.2022.02.28.06.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:25:49 -0800 (PST)
Message-ID: <062ad1fb-269f-2a43-0f47-46894bca426c@kernel.org>
Date:   Mon, 28 Feb 2022 15:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220228103716.10774-1-potin.lai@quantatw.com>
 <20220228103716.10774-3-potin.lai@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220228103716.10774-3-potin.lai@quantatw.com>
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

On 28/02/2022 11:37, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> 
> doc

You have weirdly formatted commit msg.

> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index 223393d7cafd..bc4206b257a8 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -37,6 +37,43 @@ properties:
>      description:
>        Shunt resistor value in micro-Ohm.
>  
> +  adi,volt-curr-sample-average:
> +    description: |
> +      Number of samples to be used to report voltage and current values.
> +      If the configured value is not a power of 2, sample averaging number
> +      will be configured with smaller and closest power of 2.
> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 128
> +    default: 1
> +
> +  adi,power-sample-average:
> +    description: |
> +      Number of samples to be used to report power values.
> +      If the configured value is not a power of 2, sample averaging number
> +      will be configured with smaller and closest power of 2.
> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 128
> +    default: 1
> +
> +if:

This should be in allOf.

> +  not:

Remove negation and list devices where it is not allowed.

> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +          - adi,adm1272
> +          - adi,adm1278
> +          - adi,adm1293
> +          - adi,adm1294
> +then:
> +  properties:
> +    adi,power-sample-average:
> +      description: This property is not allowed.

This does not work. Please test it - add not allowed property to such
devices and look for error. I gave you the example how it should be
done. Why doing it in a different way which does not work?



> +
>  required:
>    - compatible
>    - reg
> @@ -53,5 +90,7 @@ examples:
>              compatible = "adi,adm1272";
>              reg = <0x10>;
>              shunt-resistor-micro-ohms = <500>;
> +            adi,volt-curr-sample-average = <128>;
> +            adi,power-sample-average = <128>;
>          };
>      };


Best regards,
Krzysztof
