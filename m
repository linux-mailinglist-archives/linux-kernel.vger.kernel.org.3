Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7598752C7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiERXsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiERXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:48:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCADF5A0;
        Wed, 18 May 2022 16:48:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h29so6285133lfj.2;
        Wed, 18 May 2022 16:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1UX9tyiY5Mk4r18rRaJBtwzhf1ZkmkQKY6AoHo3gkeU=;
        b=EOyUOmigcDiFSJvJvzr7SPnBBZOwM/2TtEwTD7jMMFA5XBQ/9fKlvqJpOV7W2t8GbK
         B8/80L59bPmxdfqwuyULyEbfFosEabN28Arqc/CGnHTIyHRWiujQceUHclJvVfjgVYQE
         lokfslEw8Tlser1eUC0JYMR5PPVVJ66H2uLntTHLTSKGDfRzDozIrZEVxY0wHtbsuiSL
         w835ogeyqZnJtEHC22eLFPj298OPdDLzS0I2dBzRyEHdWjzjYo5AQPhBrPsryyU3qyDc
         FgR/E/y5U41uYg8J4mT74V4NTW17TC7cHmZbDghtyW0LTdgdlc5AuS0pbYMOpYZikfZO
         Yo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1UX9tyiY5Mk4r18rRaJBtwzhf1ZkmkQKY6AoHo3gkeU=;
        b=PWX/C94a6/2nmEANcUPhYlKdk8HRJh0Q3do7d0tbXJEMT96cMMDMRibrvv7cM5jkjw
         bzmGMTnSDboWujKy2EFtEiw7hGwvrd5HcDaqsmOE1+wTkNkaZ8gyb2mkal5aG9g+WKLn
         im78WYiCKILfuZvYE4eHMQNZonnTYt/4IARg+2NxfWUjD7gZXLRZyturyyok413Whhth
         cThAMr2eNPVYWanS/p42ABCWa8l8yfQXeirA46UpfU3RAcRJGq2t84T8qiKpbG0bnCLz
         EFOctIs1iDQgHxogWaxwnE3Gx5IZzTLOuuQFEzjsRQJlHsT76wwLSz+LSRfl+XKACvD0
         5Wag==
X-Gm-Message-State: AOAM533M515XbZJR5QF/TJdU+9YWV3Z296q6Qssoqm67vT9GC/oB0sGR
        XR1f2SbvRGoCFlccX5RiB0c=
X-Google-Smtp-Source: ABdhPJzSuJPZWc7BEOcp2vhD63R+kj8rGQqC2ji1faQfxLn5GP6aKbG88ceT3bgy+m/z5SjBgVVpFA==
X-Received: by 2002:a05:6512:169a:b0:44a:fea7:50a5 with SMTP id bu26-20020a056512169a00b0044afea750a5mr1314227lfb.498.1652917712865;
        Wed, 18 May 2022 16:48:32 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25107000000b0047255d211e3sm83430lfb.274.2022.05.18.16.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 16:48:32 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <20220518185904.GA3685644-robh@kernel.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <40758f3b-cab3-2096-1711-18837bc2f73b@gmail.com>
Date:   Thu, 19 May 2022 02:48:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220518185904.GA3685644-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.05.22 21:59, Rob Herring wrote:

Hello Rob, Arnd

> On Wed, May 18, 2022 at 03:32:27PM +0100, Arnd Bergmann wrote:
>> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>>> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
>>> index 10c22b5..29a0932 100644
>>> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
>>> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
>>> @@ -13,6 +13,9 @@ description:
>>>     See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
>>>     more details.
>>>
>>> +allOf:
>>> +  - $ref: /schemas/arm/xen,dev-domid.yaml#
>>> +
>>>   properties:
>>>     compatible:
>>>       const: virtio,mmio
>>> @@ -33,6 +36,10 @@ properties:
>>>       description: Required for devices making accesses thru an IOMMU.
>>>       maxItems: 1
>>>
>>> +  xen,dev-domid:
>>> +    description: Required when Xen grant mappings need to be enabled for device.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>> Sorry for joining the discussion late. Have you considered using the
>> generic iommu
>> binding here instead of a custom property? This would mean having a device
>> node for the grant-table mechanism that can be referred to using the 'iommus'
>> phandle property, with the domid as an additional argument.
>>
>> It does not quite fit the model that Linux currently uses for iommus,
>> as that has an allocator for dma_addr_t space, but it would think it's
>> conceptually close enough that it makes sense for the binding.
> Something common is almost always better.

agree


>
> That may also have the issue that fw_devlink will make the 'iommu'
> driver a dependency to probe.

Looks like I ran into it while experimenting. I generated the following 
nodes in guest DT using Xen toolstack:

[snip]

         xen_dummy_iommu {
                 compatible = "xen,dummy-iommu";
                 #iommu-cells = <0x01>;
                 phandle = <0xfde9>;
         };
         virtio@2000000 {
                 compatible = "virtio,mmio";
                 reg = <0x00 0x2000000 0x00 0x200>;
                 interrupts = <0x00 0x01 0xf01>;
                 interrupt-parent = <0xfde8>;
                 dma-coherent;
                 iommus = <0xfde9 0x01>;
         };

[snip]


And got:

virtio-mmio 2000000.virtio: deferred probe timeout, ignoring dependency


>
> Rob

-- 
Regards,

Oleksandr Tyshchenko

