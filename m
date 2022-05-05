Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106851BCE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355001AbiEEKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355113AbiEEKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:16:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05B51E46;
        Thu,  5 May 2022 03:12:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e24so5427361wrc.9;
        Thu, 05 May 2022 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eb2ZcFrJLchDQJ3uoZwQrPbJ1hCXeW171xzslTdT/U4=;
        b=G89l6j5DRWAvV3zCYyVoZKkWWBGnZmD3gVlBJDJs1rBbWZGMduvsJXgjawnSyEvdry
         wK8X2CVN4x+NPbTCSj/Hhf99L/9GOZ1OJbxwihCOn/RX0Kl5nqvbEsQh3FNzrbb1gixQ
         UCiBZhzKSWWfPKfAk9noqtj32u52IDzcaLqLzCgHlvFdrC+eqqa6vTfXWDUFbgRqFBqB
         6sLFoZLkvMkYbyxOtL/JwMxWfZNOPan9v832XXd/QrVzjHj+WBf2G+buT/KWnTlMphbF
         UxWVKrDxlAdR/Thq9GPIpuJJU5fg+AoBHmdU1+Fi9uoVPjtOmPBSchUkefm3TRpzF2/C
         pz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eb2ZcFrJLchDQJ3uoZwQrPbJ1hCXeW171xzslTdT/U4=;
        b=nQjeR7qQRGbhEfOfENsRle0WrwiGYUyn54kt5Tm3P+68SG5bwUyaoPTGBCGJQZtKui
         +s1chc/gHbOX8VlDwPvgv3/9LUVlnk9DQCypVPfDWOwIodk7OnLYrw0FU12hFn8rRmH+
         AL8s/kPmQXLscMT8xz1Jh5LEAxcWL/xYbsYXVjrzA6gUgFCGYTSaS5+DipszSu71gUtD
         tRYskPIYupQopDmvitwQXZ7klKAeY/A24RRYKyl7JWvr0TVsyHDbiUHWOnf9YfygDiEc
         mwTj/WN8A4ESiPeSsfkGjTD+7S6J/HOhdFLCfkcThTAWRV6bz3jL8cfgXVGL+N4u1if6
         XchQ==
X-Gm-Message-State: AOAM531EhkN2WSrQWFHwfbNNHfVyeoaCpiZXCrikE5gGHkK6aIanKhw7
        GDwCaIOVZMIZKsLi86e42zE=
X-Google-Smtp-Source: ABdhPJw7Wbi8fb/wzTczoS25ioRejgwcD7Tq0/bwbcNAYzBrRJZFfWNBH1Dc95FX1erDQ/IFeDBlUg==
X-Received: by 2002:a05:6000:144d:b0:20c:7829:2a44 with SMTP id v13-20020a056000144d00b0020c78292a44mr8970101wrx.663.1651745539758;
        Thu, 05 May 2022 03:12:19 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id bj20-20020a0560001e1400b0020c5253d8edsm908950wrb.57.2022.05.05.03.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 03:12:18 -0700 (PDT)
Subject: Re: [PATCH V1 4/6] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Rob Herring <robh@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
 <YnBUUclJqkvKsV2o@robh.at.kernel.org>
 <accbc6be-82c1-dfd2-586f-816141415d7c@gmail.com>
 <YnHCgBsQ90cJ58+0@robh.at.kernel.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <87009e86-8999-eac9-a5c9-feef196f69fc@gmail.com>
Date:   Thu, 5 May 2022 13:12:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnHCgBsQ90cJ58+0@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.05.22 03:02, Rob Herring wrote:

Hello Rob

> On Tue, May 03, 2022 at 08:09:32PM +0300, Oleksandr wrote:
>> On 03.05.22 00:59, Rob Herring wrote:
>>
>> Hello Rob
>>
>>
>>> On Fri, Apr 22, 2022 at 07:51:01PM +0300, Oleksandr Tyshchenko wrote:
>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>
>>>> Introduce Xen specific binding for the virtualized device (e.g. virtio)
>>>> to be used by Xen grant DMA-mapping layer in the subsequent commit.
>>>>
>>>> This binding indicates that Xen grant mappings scheme needs to be
>>>> enabled for the device which DT node contains that property and specifies
>>>> the ID of Xen domain where the corresponding backend resides. The ID
>>>> (domid) is used as an argument to the grant mapping APIs.
>>>>
>>>> This is needed for the option to restrict memory access using Xen grant
>>>> mappings to work which primary goal is to enable using virtio devices
>>>> in Xen guests.
>>>>
>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>> ---
>>>> Changes RFC -> V1:
>>>>      - update commit subject/description and text in description
>>>>      - move to devicetree/bindings/arm/
>>>> ---
>>>>    .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>>>> new file mode 100644
>>>> index 00000000..ef0f747
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>>>> @@ -0,0 +1,37 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Xen specific binding for the virtualized device (e.g. virtio)
>>>> +
>>>> +maintainers:
>>>> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>> +
>>>> +select: true
>>> Do we really need to support this property everywhere?
>>  From my understanding - yes.
>>
>> As, I think, any device node describing virtulized device in the guest
>> device tree can have this property.  Initially (in the RFC series) the
>> "solution to restrict memory access using Xen grant mappings" was
>> virtio-specific.
>>
>> Although the support of virtio is a primary target of this series, we
>> decided to generalize this work and expand it to any device [1]. So the Xen
>> grant mappings scheme (this property to be used for) can be theoretically
>> used for any device emulated by the Xen backend.
>>
>>
>>>> +
>>>> +description:
>>>> +  This binding indicates that Xen grant mappings scheme needs to be enabled
>>>> +  for that device and specifies the ID of Xen domain where the corresponding
>>>> +  device (backend) resides. This is needed for the option to restrict memory
>>>> +  access using Xen grant mappings to work.
>>>> +
>>>> +properties:
>>>> +  xen,dev-domid:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      The domid (domain ID) of the domain where the device (backend) is running.
>>>> +
>>>> +additionalProperties: true
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    virtio_block@3000 {
>>> virtio@3000
>> ok, will change
>>
>>
>>>> +            compatible = "virtio,mmio";
>>>> +            reg = <0x3000 0x100>;
>>>> +            interrupts = <41>;
>>>> +
>>>> +            /* The device is located in Xen domain with ID 1 */
>>>> +            xen,dev-domid = <1>;
>>> This fails validation:
>>>
>>> Documentation/devicetree/bindings/arm/xen,dev-domid.example.dtb: virtio_block@3000: xen,dev-domid: [[1]] is not of type 'object'
>>>           From schema: /home/rob/proj/git/linux-dt/Documentation/devicetree/bindings/virtio/mmio.yaml
>> Thank you for pointing this out, my fault, I haven't "properly" checked this
>> before. I think, we need to remove "compatible = "virtio,mmio"; here
> Uhh, no. That just means the example is incomplete. You need to add this
> property or reference this schema from virtio/mmio.yaml.

ok, I got it


>
>
>> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>> b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>> index 2daa8aa..d2f2140 100644
>> --- a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>> @@ -28,7 +28,7 @@ additionalProperties: true
>>   examples:
>>     - |
>>       virtio_block@3000 {
>> -            compatible = "virtio,mmio";
>> +            /* ... */
>>               reg = <0x3000 0x100>;
>>               interrupts = <41>;
>>
>>
>>
>>> The property has to be added to the virtio/mmio.yaml schema. If it is
>>> not needed elsewhere, then *just* add the property there.
>> As I described above, the property is not virtio specific and can be used
>> for any virtualized device for which Xen grant mappings scheme needs to be
>> enabled (xen-grant DMA-mapping layer).
> But that's a finite list of devices, right?

Right


> In any case, you have to
> list the property anywhere it can be used.

Agree


If I got it right, we need to add to virtio/mmio.yaml something like:


diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml 
b/Documentation/devicetree/bindings/virtio/mmio.yaml
index 10c22b5..29a0932 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -13,6 +13,9 @@ description:
    See 
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
    more details.

+allOf:
+  - $ref: /schemas/arm/xen,dev-domid.yaml#
+
  properties:
    compatible:
      const: virtio,mmio
@@ -33,6 +36,10 @@ properties:
      description: Required for devices making accesses thru an IOMMU.
      maxItems: 1

+  xen,dev-domid:
+    description: Required when Xen grant mappings need to be enabled 
for device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
  required:
    - compatible
    - reg


This passed validation.


Could you please clarify, is my understanding correct?


>
> Rob

-- 
Regards,

Oleksandr Tyshchenko

