Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30150CB48
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiDWOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDWOk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:40:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF54205D8F;
        Sat, 23 Apr 2022 07:37:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p12so13418285lfs.5;
        Sat, 23 Apr 2022 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9Q3pZjqL2YRbxMi3ZEZPC+BgttCsWqeK314Feyp4SQ4=;
        b=O6lRTdmyP9SYSA3U8hfLl6p8PcytluSsbHwEFXxwQ+ubIxxSVZKbp9ABI4a104ybmE
         4B0KpBf9zDgnV1i4oYkJNepeB9/rfyra7k5PI9DZqHke1VwN6482HV8XrLngsjtfpsFr
         6bM8w36eLRa4VwfIxnHVhQfOZg/AaPvpoW8tB1wDHi0T7pELIli9N4UTO8TGcKuvFaKm
         eOZaalv2Z8+00j28i8eI7dMT0V4YIeOFmc8x7xswIRAT1Q9HRGUBVnLTfkM6C5KtYtu2
         I9VW/XbIJHjaJqcC0s3p2b54l8r+mGP1Bv8UyPsSSwS8lK/HSTCCWDhUQlDqrMwBzC0h
         BFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9Q3pZjqL2YRbxMi3ZEZPC+BgttCsWqeK314Feyp4SQ4=;
        b=hITe/9VMMlFUCA4L5rhC7CETwwWr1R38gINgDTJe8GrmYa2QyxQ+jaQLPKcK2P+cO0
         jcgXB+rgPxP6KUE6y70ejcmtp2H5Tl9dns4C52W5de1rTwfu2op0zxyy0mfQA0LOSLV3
         1dyahedLUiyF1+ms0rHgP0K+eWkD22soMiLSkTg5+iT+i5aw2ek5q4+3Q9rww9U04TXU
         8jEsz8dZTX/eFTKa95DI6pENlhiq5yyVGoY+IMSo9uQODWSzWcsFKEXwSVj10o/qdOsi
         yFftzvhu+KCMDGjWKoJJDHgJiwMoQIb4aAURjatdN9P9mqfmWrmIqIekJ1cFR2ckWEnZ
         Y0Nw==
X-Gm-Message-State: AOAM533uDOxbzxAYS+q9wNNgh/ufB1shEhREIDwUePDqxGBjonSc3ya8
        28hBXjK7tfhtw5MJAIyUO9w=
X-Google-Smtp-Source: ABdhPJx8PYPHNf3hIYDk6xxcUZ5Cz4AjHRjZCng72eHk60GDl8rPACcXENIApaJQbCkMeAProiKKeA==
X-Received: by 2002:a05:6512:150f:b0:45d:ccac:c43c with SMTP id bq15-20020a056512150f00b0045dccacc43cmr7231892lfb.604.1650724677772;
        Sat, 23 Apr 2022 07:37:57 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k11-20020a196f0b000000b00471c56b7a3dsm641075lfc.74.2022.04.23.07.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:37:57 -0700 (PDT)
Subject: Re: [PATCH V1 4/6] dt-bindings: Add xen, dev-domid property
 description for xen-grant DMA ops
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204221527500.915916@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <638a5b09-ce9e-ab7e-0a5e-d81afe851cc1@gmail.com>
Date:   Sat, 23 Apr 2022 17:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204221527500.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.04.22 02:00, Stefano Stabellini wrote:

Hello Stefano

> On Fri, 22 Apr 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Introduce Xen specific binding for the virtualized device (e.g. virtio)
>> to be used by Xen grant DMA-mapping layer in the subsequent commit.
>>
>> This binding indicates that Xen grant mappings scheme needs to be
>> enabled for the device which DT node contains that property and specifies
>> the ID of Xen domain where the corresponding backend resides. The ID
>> (domid) is used as an argument to the grant mapping APIs.
>>
>> This is needed for the option to restrict memory access using Xen grant
>> mappings to work which primary goal is to enable using virtio devices
>> in Xen guests.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Looks OK to me. Just a couple of grammar improvements below. Aside from
> those, I have no further comments.

thank you, I agree with proposed comments, will update



>
>
>> ---
>> Changes RFC -> V1:
>>     - update commit subject/description and text in description
>>     - move to devicetree/bindings/arm/
>> ---
>>   .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>> new file mode 100644
>> index 00000000..ef0f747
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xen specific binding for the virtualized device (e.g. virtio)
> NIT: Xen specific binding for virtualized devices (e.g. virtio)
>
>
>> +maintainers:
>> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> +
>> +select: true
>> +
>> +description:
>> +  This binding indicates that Xen grant mappings scheme needs to be enabled
>> +  for that device and specifies the ID of Xen domain where the corresponding
>> +  device (backend) resides. This is needed for the option to restrict memory
>> +  access using Xen grant mappings to work.
> NIT:
>
> This binding indicates that Xen grant mappings need to be enabled for
> the device, and it specifies the ID of the domain where the
> corresponding device (backend) resides. The property is required to
> restrict memory access using Xen grant mappings.
>
>
>> +properties:
>> +  xen,dev-domid:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      The domid (domain ID) of the domain where the device (backend) is running.
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    virtio_block@3000 {
>> +            compatible = "virtio,mmio";
>> +            reg = <0x3000 0x100>;
>> +            interrupts = <41>;
>> +
>> +            /* The device is located in Xen domain with ID 1 */
>> +            xen,dev-domid = <1>;
>> +    };

-- 
Regards,

Oleksandr Tyshchenko

