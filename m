Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF3F52BF76
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiERQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiERQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:06:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1292060ABE;
        Wed, 18 May 2022 09:06:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w14so4406084lfl.13;
        Wed, 18 May 2022 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w+vvhggY5msFSpuIeQjJEqzu6+KRYjG0/Dyaiz+6Ahk=;
        b=o26M6FjVrTvwKRycgzqdUgaD/fMY0jNvZPKMBprN5moxEjbqX217K52BG1UyjTlpW8
         TkElvlCiEr0oFKj64FnK7D0BTaha0N/RKOAbCZp6lj202WvxDG9+npaV38mjznkxchK0
         ca27lzngCapZSKAMZ71QiIF6JaqjhHixL77RF5Bgznjpw5Stn3YUEnJk7Ljy5+7O5rfS
         AeefrWPMFfMpSVc26Nd93nZqazft3eY/qwXCAtgu5VEdGtAYjSOMBZWD5xn/6e4p2iq3
         q6td1dLpMO660K30fnggqk/bf3MfyuwonxtLf5vHC1eQ+bsW7qdtNcAqhVyDZeihDgFS
         iSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w+vvhggY5msFSpuIeQjJEqzu6+KRYjG0/Dyaiz+6Ahk=;
        b=F5u/ZUk/qIsw3hXGS0TpzdWVTDsvikq4/lacom3BZmMY/AOka6MrslXBhY8aQKI0IN
         BkqMQvcLsXufvWS5hJoNcqMrrxr1EJowIBrie8DnnkfhrjA/1fHSZBL2ZmjDTUMXOvgP
         Dr8cIVjy1f9yFwkx8/+Eza5F9naO+DVleQ04SVpEErQcllIXBZ+pN9UnSP9nR7K2WxQS
         RGrOYeUWAjxmq1D+XkHjBSmgPIdwR5uKz7mGnW8ghpaENTTcOdC2aL4qC5oARJH8XWy4
         q+I95vT6zw5Onl0v+iVVgrnCVOB2xBcLw/1xUopGMggsW1J+H5YNF48fKHhTUfJtZ7me
         cfmg==
X-Gm-Message-State: AOAM533omiAHZkXcfsMaFQDXfTXw1EAcqOsNRoOGq5QoFDy4ekrFZJIm
        ZIPxQpFe3mqqlWxZGjy2FQA=
X-Google-Smtp-Source: ABdhPJyldHOvI5HvilGZWlaQciM2lbS6jc6SLzHNeG0x1TWsXIo+H5s/vjAmwMcAu+6qxzl7EalYOQ==
X-Received: by 2002:a19:e203:0:b0:477:c1bc:452 with SMTP id z3-20020a19e203000000b00477c1bc0452mr156732lfg.534.1652889970184;
        Wed, 18 May 2022 09:06:10 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id d25-20020a2e3619000000b0024f812282a4sm251584lja.131.2022.05.18.09.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 09:06:09 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
Date:   Wed, 18 May 2022 19:06:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
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


On 18.05.22 17:32, Arnd Bergmann wrote:


Hello Arnd


> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
>> index 10c22b5..29a0932 100644
>> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
>> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
>> @@ -13,6 +13,9 @@ description:
>>     See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
>>     more details.
>>
>> +allOf:
>> +  - $ref: /schemas/arm/xen,dev-domid.yaml#
>> +
>>   properties:
>>     compatible:
>>       const: virtio,mmio
>> @@ -33,6 +36,10 @@ properties:
>>       description: Required for devices making accesses thru an IOMMU.
>>       maxItems: 1
>>
>> +  xen,dev-domid:
>> +    description: Required when Xen grant mappings need to be enabled for device.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>>   required:
>>     - compatible
>>     - reg
> Sorry for joining the discussion late. Have you considered using the
> generic iommu
> binding here instead of a custom property?

I have to admit - no, I haven't. I was thinking that Xen specific 
feature should be communicated using Xen specific DT property.


>   This would mean having a device
> node for the grant-table mechanism that can be referred to using the 'iommus'
> phandle property, with the domid as an additional argument.

I assume, you are speaking about something like the following?


xen_dummy_iommu {
    compatible = "xen,dummy-iommu";
    #iommu-cells = <1>;
};

virtio@3000 {
    compatible = "virtio,mmio";
    reg = <0x3000 0x100>;
    interrupts = <41>;

    /* The device is located in Xen domain with ID 1 */
    iommus = <&xen_dummy_iommu 1>;
};


>
> It does not quite fit the model that Linux currently uses for iommus,
> as that has an allocator for dma_addr_t space

yes (# 3/7 adds grant-table based allocator)


> , but it would think it's
> conceptually close enough that it makes sense for the binding.

Interesting idea. I am wondering, do we need an extra actions for this 
to work in Linux guest (dummy IOMMU driver, etc)?


>
>           Arnd

-- 
Regards,

Oleksandr Tyshchenko

