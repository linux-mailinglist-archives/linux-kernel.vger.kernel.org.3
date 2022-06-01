Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5036753A5F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353269AbiFANcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbiFANcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:32:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680502018E;
        Wed,  1 Jun 2022 06:32:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s6so2735825lfo.13;
        Wed, 01 Jun 2022 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6AmNd1uoVJElSSIZ5NcicKz1NijvWaHzL3bjyTaCTH4=;
        b=ldSt7vIuRD+IuLgBfjyNqBye32eNJ62ST9orWrrQ7xCyXt5nToDaIro4j7IujIzZIw
         zgZ8vXfHbYGORoIsxAJLQvjkcc6sykEM9L1EyLORHH6oaIcpSY1IUyFUk03VKLCwnPN6
         +6LwGg/O5yk6KhmJNaozXZv2nmZ9jjdhr218OF8Xzfva6FguxwE3Hdd8DrotuQXxODYV
         ocw8FcfH9d/LPrBKVlTYvsTkJqyYatVMDZ+6eGYRZc3e5wOgbRaPB/gd6lX7imnGwALe
         3Zrzu6o06WNYbgVRgdyOI4ykt7Tb46alUg5IEUKgeCqhd4Re1nl50dMdjR8kh7X+CtQR
         trgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6AmNd1uoVJElSSIZ5NcicKz1NijvWaHzL3bjyTaCTH4=;
        b=khSzIF+p2RkSJH3faaZyLi0Ehzh02gQ85m10JzB6ZG29DC0OYsMXTkWUbLasd3+duB
         GY4WZRYohyEJ6C9twjXE5nS1U9uwjhpzcDCS32fPeclW8aiWz5MURB3jwas8SphbJ0ma
         fvEncNN6W6a+DUHpuBp8dnqlJ5+YCIY5iCafJjjO8WF7i4QUDuABMuhkGZnJhmKYND9v
         devyBzJEvCUBUpeRBvQAg87RR9nn9o/s4O6iVr/BlNwiWRb52KD5agscpbPDpWgQ6TX9
         y4tHUg7pTfDOxt92RrVYi6n6QU60Nyd98jNtFqq05er5xfg+fT6q/ZAKVkrikhaw/yaV
         hGVw==
X-Gm-Message-State: AOAM5307QuNk5hi3JHU3m9/AKdNyWjSveQ+jxbCWlSutLBEp6LBZEZn+
        wl4++Se8gIuRjqZW4KOzW1k=
X-Google-Smtp-Source: ABdhPJxB3fNJrJkKRrllMC2ycuvNXzvXlHnLWls/OtCzWnm+TxujSRcM7FqomSJRwMxSqo/CEZZNhg==
X-Received: by 2002:a05:6512:1041:b0:478:afc6:5846 with SMTP id c1-20020a056512104100b00478afc65846mr24643051lfb.132.1654090325618;
        Wed, 01 Jun 2022 06:32:05 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id d20-20020a05651233d400b0047255d2115csm366642lfg.139.2022.06.01.06.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:32:05 -0700 (PDT)
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2205311726000.1905099@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <31c21ef0-3847-a896-a387-c2e1cc0f9467@gmail.com>
Date:   Wed, 1 Jun 2022 16:32:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2205311726000.1905099@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.06.22 03:34, Stefano Stabellini wrote:

Hello Stefano

> On Tue, 31 May 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> The main purpose of this binding is to communicate Xen specific
>> information using generic IOMMU device tree bindings (which is
>> a good fit here) rather than introducing a custom property.
>>
>> Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
>> to be used by Xen grant DMA-mapping layer in the subsequent commit.
>>
>> The reference to Xen specific IOMMU node using "iommus" property
>> indicates that Xen grant mappings need to be enabled for the device,
>> and it specifies the ID of the domain where the corresponding backend
>> resides. The domid (domain ID) is used as an argument to the Xen grant
>> mapping APIs.
>>
>> This is needed for the option to restrict memory access using Xen grant
>> mappings to work which primary goal is to enable using virtio devices
>> in Xen guests.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>> Changes RFC -> V1:
>>     - update commit subject/description and text in description
>>     - move to devicetree/bindings/arm/
>>
>> Changes V1 -> V2:
>>     - update text in description
>>     - change the maintainer of the binding
>>     - fix validation issue
>>     - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
>>
>> Change V2 -> V3:
>>     - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
>>     - use generic IOMMU device tree bindings instead of custom property
>>       "xen,dev-domid"
>>     - change commit subject and description, was
>>       "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
>> ---
>>   .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 49 ++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
>>
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
> I think this is OK and in line with the discussion we had on the list. I
> propose the following wording instead:
>
> """
> The Xen IOMMU represents the Xen grant table interface. Grant mappings
> are to be used with devices connected to the Xen IOMMU using the
> "iommus" property, which also specifies the ID of the backend domain.
> The binding is required to restrict memory access using Xen grant
> mappings.
> """
>
>
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
> Here I would say:
>
> """
> The single cell is the domid (domain ID) of the domain where the backend
> is running.
> """
>
> With the two wording improvements:

I am happy with proposed wording improvements, will update.


>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks!


>
>
>> +required:
>> +  - compatible
>> +  - "#iommu-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    xen_iommu {
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
>> +    };
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
-- 
Regards,

Oleksandr Tyshchenko

