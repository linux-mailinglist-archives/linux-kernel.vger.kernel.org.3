Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7250D38B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiDXQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiDXQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:40:05 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A222B1A;
        Sun, 24 Apr 2022 09:37:03 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e656032735so12552730fac.0;
        Sun, 24 Apr 2022 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Fp3HdofZJT+o1V6MRR3ocRbEBQWRw3KcjAOJKB2xZA=;
        b=mC13yybzcnF/RGafypXhT9+9YUUFRvE2P705dGgEC+lIEDYPu5yhhe3TFphLN/Z45q
         rAiG4A+KS8Q6rvEALqkGqC0NtkVjAPRuPLxFSFbmXN+4h8yZdS8RRGsHLHtvkqDRmToE
         PQCRK/uCHFP15NqwTVXHLagR14fuUW/eHSdGpxmlVreknDl+hFBaWIoghOUOfQVTaXyY
         3Asfu3F0XVbGFhIQ04BNcpS1OvLE8YC5/s0+hSrCMFeG1BHMr539SbJ5RTM4ZbTW/HF3
         tap/KOvZKK3qjYAHtN//lapheE/SjtrvgglilewB5yMcbO0+4xLwDow6qVfhscWWtGqp
         4LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Fp3HdofZJT+o1V6MRR3ocRbEBQWRw3KcjAOJKB2xZA=;
        b=Xg784UtGWezSmxW/D4uZBp1NNcWE6mo4g8cQa7TAW7e1epsFRR4XMFqsvAByXpLPug
         /Ar2J7ifXO5WBhPEQS3XfrxStkYNe4AHuSSm4ssnaq6jcVVF291qe63u5cUGxOtKDBwK
         JIKScJk/eBqO0b7gPCnkX1b5xXU13swR9omvolJ9QPBom4aF6bP4EkGyzStRGz6VX/zm
         CRe+f7+ukduoGnjWT5kMMuFvw1PU2KF7sDIRoZ4kTIlUpjbpAW1B/kYAVcQVBcmOD39W
         RxYFhaTVeT9v7chtaYeCrUjCqFki7tsICClgO10Oa1Y8SGhxP6pm0UmUqvlCXR9aMD2m
         t4zQ==
X-Gm-Message-State: AOAM532Y10qAKb70cUgjbJrszWuASTed5l2wfcaiFBma/vm1jUwPCyIS
        8mcGNHnLWq7s6K2P5gyar1XbyuE7Pxg=
X-Google-Smtp-Source: ABdhPJy6aseCExIW1K41OsMFQVY720cNY6Zlhp1FypG4mAGAWlQSlpkXr6JyeZymDOS67DmssI+1bw==
X-Received: by 2002:a05:6870:460f:b0:dd:cd0e:d931 with SMTP id z15-20020a056870460f00b000ddcd0ed931mr10220637oao.196.1650818223040;
        Sun, 24 Apr 2022 09:37:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24-20020a4a9b98000000b0033a70525c35sm3288394ooj.30.2022.04.24.09.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 09:37:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d9e41b5-a143-eace-72ff-c8e9e399daba@roeck-us.net>
Date:   Sun, 24 Apr 2022 09:37:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/4] dt-bindings: hwmon: add Microchip LAN966x bindings
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20220401214032.3738095-1-michael@walle.cc>
 <20220401214032.3738095-4-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220401214032.3738095-4-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 14:40, Michael Walle wrote:
> Add a binding for the temperature sensor and the fan controller on the
> Microchip LAN966x family.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Still needs approval by a devicetree maintainer.

Guenter

> ---
>   .../bindings/hwmon/microchip,lan966x.yaml     | 53 +++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml b/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
> new file mode 100644
> index 000000000000..390dd6755ff5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,lan966x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966x Hardware Monitor
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  Microchip LAN966x temperature monitor and fan controller
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,lan9668-hwmon
> +
> +  reg:
> +    items:
> +      - description: PVT registers
> +      - description: FAN registers
> +
> +  reg-names:
> +    items:
> +      - const: pvt
> +      - const: fan
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hwmon: hwmon@e2010180 {
> +        compatible = "microchip,lan9668-hwmon";
> +        reg = <0xe2010180 0xc>,
> +              <0xe20042a8 0xc>;
> +        reg-names = "pvt", "fan";
> +        clocks = <&sys_clk>;
> +        #thermal-sensor-cells = <0>;
> +    };

