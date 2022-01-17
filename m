Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E75490F07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiAQROL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiAQRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:10:47 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4062C061342;
        Mon, 17 Jan 2022 09:06:38 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso7976705otl.3;
        Mon, 17 Jan 2022 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tUhw/y9cZXgqGz/p/76i9xXoBkiXwqUAFGmdf6IDvoM=;
        b=GCtZdCtolPb+Z3CiCF5Eqji9SMjeidwEOCV3iarm5Mi0nitLtq8isRWE6rMhIXe/L+
         ubbvMRnMpdgehm7urlVQieaTAzPrwprKMH/nMDojm/eDRLLxeFiRDYsm4ig5zuVKUotB
         Pn66DczcGpAeU7uE1LjIA+BFbEr1SoePM/xJSCeNtA3cVVU8bKjRuW9ApVlW9B++gwW4
         lQf5B5exSqi5I4EMzDkB3A3CKAI73wWV7TQb/BBo6p1oUPI43o0h03wnkwOzUdwDa86E
         ea90YOiOHNFPn2dcOjgHaC0/ef0PEarhQDf6PIdOF4GXx/0AJQpW5IbV9HdaaMd+ZcJS
         BHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tUhw/y9cZXgqGz/p/76i9xXoBkiXwqUAFGmdf6IDvoM=;
        b=q+wNtR1uzy3UMWrwY5Keks4UAsI/pM1bnKvf7HZyfDhwxGbGxsHD2502kUMC98lWnD
         TamoDG/BOws9qVnUBn2csyID/3fSqqW98utpW8nCVJQkXedMwMl4kA9wPM3UIAHhAeFB
         lqtoVOzqwgStmgdsyPdAb1ebSJg9cHMIknpIY32GpnofWBnffUIsmpFcdSW+66FT202d
         9NYD+TDfto/J6Ug2Xv1drS3jlZwP00vC991Cv3IQrXth2avP0Mln1+oONDtczxwh17gG
         /dUs+L784owJL0U9fzkOslC1Q2C+DPUIxdMM3+1dwyI26U3uQ/8qkiwh2OCwNOAQRbYF
         7bNw==
X-Gm-Message-State: AOAM531iflgwrfIskANwBq+JasFD/OziimJN+1rNVPzPIcylJcAojtNY
        z0WnrUM1fWCwOiD444O3TKf+h/UYLRg=
X-Google-Smtp-Source: ABdhPJytJTLfP4k/pRT8QJ3PlRapfIbnUhnUlxgMu42sN7AAmRgePdon66eY7UHO3OmJ96LnGO6/Hw==
X-Received: by 2002:a05:6830:22c8:: with SMTP id q8mr16951562otc.54.1642439197830;
        Mon, 17 Jan 2022 09:06:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6sm6583224oif.16.2022.01.17.09.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:06:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: hwmon/pmbus: Add vicor,bcm6123 Bus
 Converter
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1642434222.git.sylv@sylv.io>
 <ba6346942dfed14440e0243a6da510581389fbdd.1642434222.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e5ddd3f1-61c9-862d-8973-484c91b7718e@roeck-us.net>
Date:   Mon, 17 Jan 2022 09:06:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ba6346942dfed14440e0243a6da510581389fbdd.1642434222.git.sylv@sylv.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 8:12 AM, Marcello Sylvester Bauer wrote:
> Add bindings for BCM6123 Bus Converter from Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Can this be added to trivial devices instead ?

Guenter

> ---
>   .../bindings/hwmon/pmbus/vicor,bcm6123.yaml   | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> new file mode 100644
> index 000000000000..5559d22e00f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/vicor,bcm6123.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Vicor Corporation BCM6123 Bus Converter
> +
> +description: |
> +  The BCM6123 is an isolated Fixed-Ratio DC-DC Converter,
> +  operating from a 260V to 410V primary bus to deliver an unregulated
> +  ratiometric secondary voltage.
> +
> +  Datasheet: https://www.vicorpower.com/documents/datasheets/ds_BCM6123xD1E5135yzz.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vicor,bcm6123
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bcm6123@5f {
> +            compatible = "vicor,bcm6123";
> +            reg = <0x5f>;
> +        };
> +    };
> 

