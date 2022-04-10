Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60764FACAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiDJIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiDJIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:20:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA773152A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:18:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v4so1200772edl.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OOscUjkmUIhgRzXyPdDTYNrAB2N5CAonkcdxEozYleA=;
        b=PXYWs7Gm8xzntcJmAfclsmxb08EgjzzqwqkrnO7Sj1S9HCXXjTwo3WSxINKzT2qk3q
         E1OTdRtUPCWso7pT1lTrvbb9VM7TSqkFHrcxkuvs+IRchWJwRaCkt7kPtAFwz8ubKuv8
         LawYbyCpNPYa7y81B592lM4Rm0T7F3bCdqp0uIsJyOMzxiSFZ9NHlDlgdeNFY/899d4T
         +qFfSBGeYDW+4DTC5+Ey0ry1AXFT3nZu//HoqXO0hdUtD/4cT3YEFq6qQt6BWVqt1Kr8
         Ia6+t9mTrZPj2347vmV/Qy2EphnJyKk9wzAMVrPvDi6i2Zzh/bPZ2jG/lYWW831VWI3i
         uo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OOscUjkmUIhgRzXyPdDTYNrAB2N5CAonkcdxEozYleA=;
        b=SL4yTzuHWkQV2RPVzG1nM/9YKCi25PTlj2nY3W7HpRP1exIoBqrWaTlLJArCA+KmqM
         Mi+U+i7PYOLQifLGAsvM2NMHd8pdOydTPVjw+lVpKn11c5eO7jz0xC15NY43ShMqW+zq
         cyg3q9fx8ZIMqkiTWE9bIhu21GUGxjSdOvFH1K3q462vk0eJ0jNjrwvI09YBZB/FYfjc
         JpQaWaNX+7elXqIcNYNsax7ZSps3PtpGqiFQQqgOEoV9+Lr4YEanjf112kHpQprptswc
         Sg9B+r84V/j94YwRGQqJw2C9qU6kXFqpNCv6+NsxwDiOzu8nP+nlCNMAnC06o6IWRSka
         +FlA==
X-Gm-Message-State: AOAM530KTrF5ttVUPVUugV3fQtWDEV9p3YzhZ6nrM/E7ix4CmKPDV/Nf
        tKj7YA8jI025NJOBxs9bDCjpnCZhNGqaDzu/
X-Google-Smtp-Source: ABdhPJyVcZ6hRp09mS9Z2u4w3HRyzlPJiv4rtZbZATSV70c+hXqWqM3As9jQbyUgIKctjg4XYV5gCA==
X-Received: by 2002:a05:6402:42c6:b0:41c:defd:24d1 with SMTP id i6-20020a05640242c600b0041cdefd24d1mr28141892edc.326.1649578686025;
        Sun, 10 Apr 2022 01:18:06 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709066c8200b006e4e1b1f875sm9955032ejr.199.2022.04.10.01.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 01:18:05 -0700 (PDT)
Message-ID: <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
Date:   Sun, 10 Apr 2022 10:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
 <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
 <bd533827-b575-caad-c230-af060851b231@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bd533827-b575-caad-c230-af060851b231@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 20:17, Mikhail Zhilkin wrote:
> 
> On 4/9/2022 9:04 PM, Mikhail Zhilkin wrote:
>>>>>> +required:
>>>>>> +  - compatible
>>>>> Missing reg.
>>>> reg isn't required. Parser can read partition offsets and sizes from
>>>> SC PART MAP table. Or do you mean something else?  All is ok
>>>> without reg definition in "Example" (except the warns that reg property
>>>> is missing).
>>> reg might not be required for current implementation but it is required
>>> by devicetree for every node with unit address. Do you expect here nodes
>>> without unit addresses?
>> Only "partitions" node has no unit address. All subnodes  have unit
>> addresses and therefore have to have reg property. I've just realized
>> that "fixed-partitions.yaml" is almost my case. It looks like I can
>> copy'n'paste  "required" and "*properties".
>> Do you mind if I don't reinvent the wheel and reuse this good
>> practice?
>>
>> Here's what I got (no any warnings appears):
> 
> 
> I'm sorry, Krzysztof & All. Here is the final one.

I am sorry, but you changed now a lot in the bindings and it looks
entirely different. Things previously being correct now are wrong, so
rather start from your old bindings...

> 
> ---
>  .../mtd/partitions/sercomm,sc-partitions.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
> b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
> new file mode 100644
> index 000000000000..33172f0be92a
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id:
> http://devicetree.org/schemas/mtd/partitions/sercomm,sc-partitions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sercomm Partitions
> +
> +description: |
> +  Sercomm is one of hardware manufacturers providing SoCs used in home
> routers.
> +  The Sercomm partition map table contains information about non-standard
> +  partition offsets and sizes (depending on the bad blocks presence and
> their
> +  locations). Partition map is used by many Sercomm-based Ralink
> devices (e.g.
> +  Beeline, Netgear).
> +
> +  The partition table should be a node named "partitions". Partitions
> are then
> +  defined as subnodes.
> +
> +maintainers:
> +  - Mikhail Zhilkin <csharper2005@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sercomm,sc-partitions
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    $ref: "partition.yaml#"
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"

Still missing reg.

> +
> +additionalProperties: true

This is wrong, why it became true?


Best regards,
Krzysztof
