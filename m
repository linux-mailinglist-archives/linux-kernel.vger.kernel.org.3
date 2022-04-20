Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF9508C82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380363AbiDTP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbiDTP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:56:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF60443ED3;
        Wed, 20 Apr 2022 08:53:20 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a10so2491043oif.9;
        Wed, 20 Apr 2022 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fXHqOY2tc5UPrJrBim4iLpq4H2B7qKAz9SeXKaCXnDE=;
        b=IgUPtOFc7Ve6vimxPHxtknn4QbdT9STH4gLJGtJzBlDRojz60IhpsWRNbsJ8JqF3ST
         fJEaNPo2vInoxVmV/wsDpWDVxo5quk/IxTXzKUSlIFQAzKuQCPtja8oR3pt/5WWNvg67
         T/2INzYWFy51vLf1E8Un1B6AwqOahHsWmbkH/579AGmaZjiddNMKZBGgxxF4N/gPcWR8
         pLeXueKuO5PinPvbk3V5H9FQAkhaixmtsEcnDu/7Yxgy/K8wvS4YMOPE4629JxqojCoQ
         qbHV4GGQikr/mz+MEjW2MPlI+S4JwkAEyNt3HCjk2DEY08qSLvoji7DFxs0HIB9youZe
         JdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fXHqOY2tc5UPrJrBim4iLpq4H2B7qKAz9SeXKaCXnDE=;
        b=fsC10mJuvrKIMpWOdYpwDe+ifagoChpozZPNa/bgZcrgr7WFACUDttz0ZoBQEADlD2
         LtShOWja1VFUIzYX9xRFx1iV5lWNdPI/oAOfH24SAkddunRArpMjkDCmmSJXYKWmbGUJ
         RL7bEd8vhUpMfRV8FZzZlrRiKAcfv/s4TTRIJqbEbtNaweQVNer+MBAsdRQDN9tNYt7J
         56g63OfFQfzUULStSXz+dV8qqY8V1DoL72CfcqMrb+EcxH8IiKFWAVbXoKEerEK39dn8
         tIZPbvCZ0MStkI5O25R667m9YMkXKFvRVPHr8YVRULykMMw0PSonpzr3GXcQZJOgd09+
         yRsw==
X-Gm-Message-State: AOAM531qfdZ6jPkY5vBiTxaV34b2syJjq7px2T/U/NFoFcuwssh/TVnA
        67FPHrxor25gklM1sv/ManE=
X-Google-Smtp-Source: ABdhPJxUZqOPHbzSMK0O47Ablgnyjxb//mbrJRAF6StPloqnobFBr1pRz0sNT5lk5HRVPES33bsVXw==
X-Received: by 2002:a05:6808:11c3:b0:2f9:62e0:ebe with SMTP id p3-20020a05680811c300b002f962e00ebemr2064672oiv.22.1650469999877;
        Wed, 20 Apr 2022 08:53:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pv14-20020a0568709d8e00b000e2c2f0dbbesm80651oab.54.2022.04.20.08.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 08:53:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d039d13-8512-29a8-31d1-48284d561bf0@roeck-us.net>
Date:   Wed, 20 Apr 2022 08:53:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick@hpe.com, joel@jms.id.au,
        arnd@arndb.de
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-6-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220420150156.47405-6-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 08:01, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the hpe gxp watchdog timer binding hpe,gxp-wdt.
> This will enable support for the HPE GXP Watchdog
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v2:

v3 and v4 changes are missing.

> *Made watchdog a child of timer because of same register
> area based on review feedback
> *Simplified the watchdog yaml as it will get information
> from parent device
> ---
>   .../bindings/watchdog/hpe,gxp-wdt.yaml        | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> new file mode 100644
> index 000000000000..c20da146352f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/hpe,gxp-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Controlled Watchdog
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-wdt
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog0:  watchdog {
> +      compatible = "hpe,gxp-wdt";
> +    };
> +

