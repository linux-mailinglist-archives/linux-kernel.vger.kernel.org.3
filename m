Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8B539016
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbiEaLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiEaLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:52:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B32229E
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:52:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x62so5323981ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pgwp2VdYx+Vpnhun4TNi+eC2topHBL0Uwk1ptGJfZcE=;
        b=iS5jhowOcF/lfXAMYJ1n2lLpF7hUtwsQikH8pir763iCnTkaHoMbpuD2JWonqpofGu
         qjyArBVFBAgZQ9fQpr/S/sNnTQgp1XR5p/rqsj3MhdJ+R24/EaY9Jbv7/STxX0BhfOae
         vvpJfMMcFbUtqlhICqYrW8DyeWTZfTB31dRM0WNqVaDsLbFsSSYIr3kJMkl8EIu8eyG0
         IjQQuD7laFKec1PktUnxtrsiM3a+rYcN+wihWCwjJw7hyQww5pG4m0uXI4PcjIotDFcu
         f+NP9XC8R9LGUd3NPhygDtKFvwynWln1GjMt/3m1CHmsTLxPB1Nv/M1Gb8i3wsWht7ok
         zmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pgwp2VdYx+Vpnhun4TNi+eC2topHBL0Uwk1ptGJfZcE=;
        b=qw4jnnMkDpcYtSJWCsm/t7y1HFDggxOm3jlA+NELqnSNxaea5UFFDhYF/aaRuGZBsC
         eM7VWHsWIGFO2CCZnrncHL4Cg0x+/RPzRyR06gX69/aGKNH9S1c6rOSE6moQx33IlHgx
         StfMhJZ3dPu+4GtCpOx7ClP1vUVldr1QH/Pc1sbgI+PNJqHpnMaF3J0aFtk/woCdT4ep
         3xPQL7vWTxhSuq7UJ9KAcvI6rre4wPnYUD0ia7QJxpJVvtH+W8UdVMpgjYU6J8MFx3E0
         soSqqgtb+/lMazRyhm1dxWvgVORmzoyXoR0NQd0iiDFWmH4cxY/B7r4ALhSbQK9pVNX3
         qXKA==
X-Gm-Message-State: AOAM530HJLfFxFMBIHxoTtlF5BDE/dmy1TRepZh6+Ph1q93wnxOmoqBA
        SSfUM/M9rgmjci4h9B63143S8Q==
X-Google-Smtp-Source: ABdhPJzLoz1xLJgBhIhIcXu/CVKt7lUZqurHOJkAtVo1mU8l+2AAQXVVLJ65/yyrjl+Cx6OqWRo0rg==
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id g18-20020aa7c852000000b0042d70d82864mr19815609edt.379.1653997936660;
        Tue, 31 May 2022 04:52:16 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c13-20020a50d64d000000b0042617ba63cfsm8278497edj.89.2022.05.31.04.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 04:52:16 -0700 (PDT)
Message-ID: <15eef004-74c7-0eb5-3f87-86e164ef70ff@linaro.org>
Date:   Tue, 31 May 2022 13:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 23:00, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> new file mode 100644
> index 00000000..ab5765c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific IOMMU for virtualized devices (e.g. virtio)
> +
> +maintainers:
> +  - Stefano Stabellini <sstabellini@kernel.org>
> +
> +description:
> +  The reference to Xen specific IOMMU node using "iommus" property indicates
> +  that Xen grant mappings need to be enabled for the device, and it specifies
> +  the ID of the domain where the corresponding backend resides.
> +  The binding is required to restrict memory access using Xen grant mappings.
> +
> +properties:
> +  compatible:
> +    const: xen,grant-dma
> +
> +  '#iommu-cells':
> +    const: 1
> +    description:
> +      Xen specific IOMMU is multiple-master IOMMU device.
> +      The single cell describes the domid (domain ID) of the domain where
> +      the backend is running.
> +
> +required:
> +  - compatible
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xen_iommu {

No underscores in node names, generic node names, so this looks like
"iommu".

> +        compatible = "xen,grant-dma";
> +        #iommu-cells = <1>;
> +    };
> +
> +    virtio@3000 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3000 0x100>;
> +        interrupts = <41>;
> +
> +        /* The backend is located in Xen domain with ID 1 */
> +        iommus = <&xen_iommu 1>;

There is no need usually to give consumer examples in provider binding.
If there is nothing specific here (looks exactly like every IOMMU
consumer in Linux kernel), drop the consumer.

> +    };


Best regards,
Krzysztof
