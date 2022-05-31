Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05F6539542
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiEaRJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiEaRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:09:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465A6B036;
        Tue, 31 May 2022 10:09:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s6so6526300lfo.13;
        Tue, 31 May 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oXC+omMyhQE+yQOLbS6KJe5K78bZY03LjtAozxlOWS4=;
        b=TAyjZkyHiTXmbmHCSrE2qWJwfpy2mK18RqayHB9KPwF3D5Pg+bZ6eGYNeN34jbspjz
         XKAIAKaqLBFgTkjxxqEqqjzKoQ4toUSB64OhXxsfMMRXeKBxTuUTXvyIQGUiGfioo7kC
         oMkYvmT4C0UXva0czCxfN3JpmbeZVhWBsYi1qGOpj0WhxatmjVmbr0Qp0zNQmGicVbqD
         XOkcjG3W1KKt5f0akOma0UDAHja0EIq/KJOrVyQ2kluOg8ugvRzH57Wsp2EqTBQKNt5m
         4tqMtwtv+jysyfjiBaAa2EYLry0bXPvGexMdU0w2FewQWJm/hZYWq2QWm7FRLYNLGMi4
         npkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oXC+omMyhQE+yQOLbS6KJe5K78bZY03LjtAozxlOWS4=;
        b=PtSFlzs/ZV6s2lB045ns/cNkFL0Qj4KFrIkWpZ2KrlQ1dUN8S1QVOuAgxnVDi9Zug5
         5anLRvBfgYNGvoTJIrai+cQwo4f2kvmyWJuYE/Tc2sJo31gLiT6XRWxGqIRxPH2dj8qa
         PnSDjGI9TTzfaURHJSGaVTQD60QS8wmQ7cy3AfDnfYwxWReFjMWu5xcaTvOn6nE7BLHh
         Bb3tCw1wZcJcf9R4mAbR+E35OcJC8SoWYFawRxaleI5dsBshNAEdA9xE9PMILQCbUu/k
         S1mb5hS5FaoQbj44hn6VjvK1U+vIn/VYuWWhMW6MMRX556BbvXc2sh33Bjk66aIVIPZJ
         8Kaw==
X-Gm-Message-State: AOAM5310fwHwklb2R2goWSWJUEMp1XPsvJ3KDzOqioSbHdTLPJYvhbc4
        6whBHQPALodaYmZJQJmPr0O/fZogUOw=
X-Google-Smtp-Source: ABdhPJwx9hqwCt9lTBlhLuxF3159ZiuKQMGeaQRRGSerHfQCM1lHwBJOFfe0u0PJDGwPNceRQMYbag==
X-Received: by 2002:ac2:4f09:0:b0:478:6c80:64fc with SMTP id k9-20020ac24f09000000b004786c8064fcmr26696653lfr.34.1654016961692;
        Tue, 31 May 2022 10:09:21 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id i6-20020a196d06000000b00477cab33759sm3072432lfc.256.2022.05.31.10.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 10:09:21 -0700 (PDT)
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <15eef004-74c7-0eb5-3f87-86e164ef70ff@linaro.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <f5aa3337-e1fc-752e-5337-120599ed508b@gmail.com>
Date:   Tue, 31 May 2022 20:09:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15eef004-74c7-0eb5-3f87-86e164ef70ff@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31.05.22 14:52, Krzysztof Kozlowski wrote:

Hello Krzysztof

> On 30/05/2022 23:00, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Thank you for your patch. There is something to discuss/improve.
>
>> diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
>> new file mode 100644
>> index 00000000..ab5765c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xen specific IOMMU for virtualized devices (e.g. virtio)
>> +
>> +maintainers:
>> +  - Stefano Stabellini <sstabellini@kernel.org>
>> +
>> +description:
>> +  The reference to Xen specific IOMMU node using "iommus" property indicates
>> +  that Xen grant mappings need to be enabled for the device, and it specifies
>> +  the ID of the domain where the corresponding backend resides.
>> +  The binding is required to restrict memory access using Xen grant mappings.
>> +
>> +properties:
>> +  compatible:
>> +    const: xen,grant-dma
>> +
>> +  '#iommu-cells':
>> +    const: 1
>> +    description:
>> +      Xen specific IOMMU is multiple-master IOMMU device.
>> +      The single cell describes the domid (domain ID) of the domain where
>> +      the backend is running.
>> +
>> +required:
>> +  - compatible
>> +  - "#iommu-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    xen_iommu {
> No underscores in node names, generic node names, so this looks like
> "iommu".


ok, will change


>
>> +        compatible = "xen,grant-dma";
>> +        #iommu-cells = <1>;
>> +    };
>> +
>> +    virtio@3000 {
>> +        compatible = "virtio,mmio";
>> +        reg = <0x3000 0x100>;
>> +        interrupts = <41>;
>> +
>> +        /* The backend is located in Xen domain with ID 1 */
>> +        iommus = <&xen_iommu 1>;
> There is no need usually to give consumer examples in provider binding.
> If there is nothing specific here (looks exactly like every IOMMU
> consumer in Linux kernel), drop the consumer.


I got it.  There is nothing specific from the device tree's perspective, 
I was thinking to draw attention to the IOMMU specifier (in our case, 
the master device's ID == backend's domain ID). But  '#iommu-cells' 
description above already clarifies that. Will drop.


>
>> +    };
>
> Best regards,
> Krzysztof

-- 
Regards,

Oleksandr Tyshchenko

