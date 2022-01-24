Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BE49A7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315645AbiAYCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374233AbiAYAQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:16:34 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A674C038AF4;
        Mon, 24 Jan 2022 14:02:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t9so2153981lji.12;
        Mon, 24 Jan 2022 14:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:references:from
         :in-reply-to:content-transfer-encoding;
        bh=LA2Dp3HJ+xwYPvctInS9E+uCracwEfra/4AQRc/q/i0=;
        b=BQOMDC29L23HCp50plS0yQ/NcRC/zrbZlKyPEP7hOhInoYBVaeZUH24Z7ujpjPSKCU
         4d5+qyxQ4LX6diCvvQces0kuZXo6fg6qQu3yt0NTGH5DDu43/fuNDgAlvVsOXYzLXdMz
         vCSGclw87g/DJtyWWcd36nAyxixpmm5bnG47Pd51uQUDkTJAcNmoz4Ih9/JgpuGBbKpQ
         bFbgHBVgTYJAwrFnAAhhi25ez03beYnFLteivm/JrW3hVnn0bumg7OsK9xtb1QN7wuEw
         GyY1qY4Ykg8cKArvTqWuwpZfEEFVHUuatG7sJOlp39E74OlqYrFS1yflC+tz1X+usu85
         kPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=LA2Dp3HJ+xwYPvctInS9E+uCracwEfra/4AQRc/q/i0=;
        b=nGczH3isvQChteDchdxjSnoKQFbi5rCDaAFMKXjoRTRfuwV0NQ3Y5KF6LBQKpJs6Kz
         Ay+WaeRbRQXPJ1n2bQ5Nc8bWfY7BqXFrhnpJoUWN92MXzjp7CWoCoO4u7gRhzh4igo3B
         IN2MG8EJTAL5SGMLOR8rUBhB3NRWntnI1AKwhDFaSQs5qwB688JXPiLhswOB5GzQ8IXI
         Hto4dYQ8y9seNjM8lFjppDuZ5DRXC1+efqBtQjlkSmEZ+HLe21lPTcnZxBfA4KOju3UO
         RKTjh9ZBPige4e7K/btzZ9HNu7uPeMoHtz5ggluaD18Z8vvWF9OG0OheMZ0qdTq1027C
         tl+g==
X-Gm-Message-State: AOAM530eIXzcYqz06ola3AEQ+aDfDVE+iK7nBPXxVfUFtlUWYZjNUcHT
        rxDABgjaGdEGLdfS3Qr03S4=
X-Google-Smtp-Source: ABdhPJz7SiTWwM1H+y+TuRStbc/VlWAwhfC2TW8BWRBWGehkS9emEkYvDVPTtYW7cM/ER4AfOJWU/Q==
X-Received: by 2002:a2e:a4c6:: with SMTP id p6mr6750783ljm.20.1643061746303;
        Mon, 24 Jan 2022 14:02:26 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id m21sm101912ljh.137.2022.01.24.14.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 14:02:25 -0800 (PST)
Message-ID: <a823e730-853d-901b-1b9f-937e1ec76444@gmail.com>
Date:   Mon, 24 Jan 2022 23:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partitions node
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
 <20220120202615.28076-2-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220120202615.28076-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.2022 21:26, Ansuel Smith wrote:
> Document new dynamic-partitions node used to provide an of node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
>   1 file changed, 59 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> new file mode 100644
> index 000000000000..7528e49f2d7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynamic partitions
> +
> +description: |
> +  This binding can be used on platforms which have partitions registered at
> +  runtime by parsers or partition table present on the flash. Example are
> +  partitions declared from smem parser or cmdlinepart. This will create an
> +  of node for these dynamic partition where systems like Nvmem can get a
> +  reference to register nvmem-cells.
> +
> +  The partition table should be a node named "dynamic-partitions".
> +  Partitions are then defined as subnodes. Only the label is required
> +  as any other data will be taken from the parser.
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: dynamic-partitions
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    $ref: "partition.yaml#"
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "qcom,smem";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +    };
> +
> +    dynamic-partitions {
> +      compatible = "dynamic-partitions";
> +
> +      art: art {
> +        label = "0:art";
> +        read-only;
> +        compatible = "nvmem-cells";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        macaddr_art_0: macaddr@0 {
> +          reg = <0x0 0x6>;
> +        };
> +
> +        macaddr_art_6: macaddr@6 {
> +          reg = <0x6 0x6>;
> +        };
> +      };
> +    };

First of all: I fully support such a feature. I need it for Broadom
platforms that use "brcm,bcm947xx-cfe-partitions" dynamic partitions.
In my case bootloader partition is created dynamically (it doesn't have
const offset and size). It contains NVMEM data however that needs to be
described in DT.

This binding however looks loose and confusing to me.

First of all did you really mean to use "qcom,smem"? My first guess is
you meant "qcom,smem-part".

Secondly can't we have partitions defined just as subnodes of the
partitions { ... }; node?


I think sth like below would make more sense:

partitions {
     compatible = "qcom,smem-part";

     art {
         label = "0:art";
         read-only;
         compatible = "nvmem-cells";
         #address-cells = <1>;
         #size-cells = <1>;

         macaddr_art_0: macaddr@0 {
             reg = <0x0 0x6>;
         };

         macaddr_art_6: macaddr@6 {
             reg = <0x6 0x6>;
         };
     };
};


Then I could also reuse that for something like:

partitions {
     compatible = "brcm,bcm947xx-cfe-partitions";

     partition-0 {
         compatible = "nvmem-cells";
         label = "boot";

         #address-cells = <1>;
         #size-cells = <1>;

         mac: macaddr@0 {
             reg = <0x100 0x6>;
         };
     }
};
