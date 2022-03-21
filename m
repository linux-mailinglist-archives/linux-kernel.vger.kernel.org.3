Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A84E2402
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346214AbiCUKKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbiCUKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:10:14 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B46418;
        Mon, 21 Mar 2022 03:08:48 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id p15so28752323ejc.7;
        Mon, 21 Mar 2022 03:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ohJbf78zjin+5q9ryuarHm9CqYHkiO/NM9/l5+6R9tY=;
        b=R+zbtXvu/mllgN05q8zrcf6eNWS2No+rlIt3XDhCIB0Ob/xqFCb30P1VqRJaWLGfhr
         fGVXPQx7P9c7Lx1rj95yUUcGf77AGEQfarfo8RCZZGnbPKioime4H4bnTXVkTytkxrmo
         Du2WdhCp0IJgtxe2Ono5zdhJZ8ZlaAAKrPGJDHoIJjg4PWjDu1j7toUgrEKzwpl+4Sf1
         M8AkuhPf0W0/TqVz0qHDLYnRc6CwKO6xjexaNoDPMoxe0yBfb+Z5+l7e7R1vC9lMZ4pL
         h9rqWpfVo9/wVNZhMZq8rOHZzyRYVcLy8EtY5zUto3JpwDXr4pNd48BGDITIk7pqNvPB
         48IA==
X-Gm-Message-State: AOAM530F+k0WNNIdWz7HR6omLZcFB8xIkDCW/feZs2Hbb57bvQtYxx/g
        1/VSgArzjFlKr6zN2qUSdJQ=
X-Google-Smtp-Source: ABdhPJwvPvvYGWDQK30yeTZIw1qeHF3chb1y8K+jA8blsriDhstCDWKpikJ8sYoD29847pcsHJDf7A==
X-Received: by 2002:a17:906:8d8:b0:6d2:131d:be51 with SMTP id o24-20020a17090608d800b006d2131dbe51mr20165153eje.564.1647857326974;
        Mon, 21 Mar 2022 03:08:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm6372593ejl.122.2022.03.21.03.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 03:08:46 -0700 (PDT)
Message-ID: <766931c9-6647-19c5-24d8-9b8fb3ab58d6@kernel.org>
Date:   Mon, 21 Mar 2022 11:08:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 7/9] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro MFD driver
Content-Language: en-US
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
 <20220321081355.6802-8-quan@os.amperecomputing.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321081355.6802-8-quan@os.amperecomputing.com>
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

On 21/03/2022 09:13, Quan Nguyen wrote:
> Adds device tree bindings for SMPro MFD driver found on the Mt.Jade
> hardware reference platform with Ampere's Altra Processor family.
> 
> The SMpro co-processor on Ampere Altra processor family is to monitor
> and report various data included hwmon-related info, RAS errors, and
> other miscellaneous information.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v7:
>   + None
> 
> Changes in v6:
>   + None
> 
>  .../devicetree/bindings/mfd/ampere,smpro.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> new file mode 100644
> index 000000000000..c29d975c1bc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ampere,smpro.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ampere Altra SMPro firmware driver
> +
> +maintainers:
> +  - Quan Nguyen <quan@os.amperecomputing.com>
> +
> +description: |
> +  Ampere Altra SMPro firmware may contain different blocks like hardware
> +  monitoring, error monitoring and other miscellaneous features.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ampere,smpro
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Why do you need address/size cells? Is the binding not complete? The
commit description does not mention such case.



Best regards,
Krzysztof
