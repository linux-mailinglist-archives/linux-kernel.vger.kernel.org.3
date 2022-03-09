Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091044D30D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiCIOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiCIOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:08:13 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFBC177D11;
        Wed,  9 Mar 2022 06:07:11 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q5so3238684ljb.11;
        Wed, 09 Mar 2022 06:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=xxfxU0/+N2c7ag5iF0ND2CSoktRFw/36L814u7xJMSM=;
        b=eXzLxN58FhsB8OTDoH92CoaNBlI24Gn3jCMUdxhtfqWnYAfePKPC9Ajke352kewhYQ
         JPrO59ouTXOfzPPk7H10fUG/P8YBNVnMdH+UKqfy3jqyO50/hytulo6Iy4NeSjM7AbKx
         iZTrGXy36LywxOpg9E5YxY67y2e2DoFzstJ+lfRzSgK5Blsp3KvJPtJqeNQd/rTAwBA4
         3GjSBF8ssUVOGFyZPDPZ8/KYzhWPh63Y4+TGJ1RhafGQbWGjgwSQWTqZE5vYQDD1Ng2Z
         /fOqOIZHnVcv2HEmsqdcbOLq4ZEjtFqipPAbWIW8Z+wJFM3M7MJTP/tYJ087GB9XfD7b
         FDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xxfxU0/+N2c7ag5iF0ND2CSoktRFw/36L814u7xJMSM=;
        b=j9fLH1FwBLYSNDOkgOONV0RTJeN+vLevMsUw8Bpx2IKfbUWpJ/nm+nOd9KPbeWhz0t
         f3NTVz6yX/s/vkOub9HEk8cPMzmcNymAYtSVoHMmT06Q6uDwu26GoOplzV2qk9gfDH7Q
         njsQZ05/diCvPf8Mc5TgmbeN3nHYRFsbznq1ge3ij4rQzLcBUTCndNMIlPFhB1durR/P
         MIYk4WOSTOPYv2cKeTlM66DxB3Z0WUARFbFzyFtr14G4F12XaqxxCVNl/2HvmXSJkyIe
         0qCAPHOsX3wt+E6QxRA8Y8otMBbQHmZwvTrQtHUWqBojtqv8vlFzca7OuMb8IZAXSMhE
         HZeg==
X-Gm-Message-State: AOAM530hlYYBqZnVX0tL9cRyInD/tQYt5WLTsFZ8ul2g/RRYR4fKQ9Iv
        bTpdD/KracUNsYwwgOwN5xw=
X-Google-Smtp-Source: ABdhPJw1Pj1zvOkWm3Hacnnf4CF4L5JOnwbEIh46fkJuDpqvc3ifCDFMpj5fAASPelDzl/NZidwoAA==
X-Received: by 2002:a2e:594:0:b0:247:ec86:8b9b with SMTP id 142-20020a2e0594000000b00247ec868b9bmr6136123ljf.310.1646834818443;
        Wed, 09 Mar 2022 06:06:58 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h7-20020a19ca47000000b0044829144111sm415470lfj.26.2022.03.09.06.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 06:06:57 -0800 (PST)
Message-ID: <7f389c1e-cc36-1cce-6be2-27f18b2be7d3@gmail.com>
Date:   Wed, 9 Mar 2022 15:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220228131250.16943-1-zajec5@gmail.com>
 <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.03.2022 14:42, Michal Simek wrote:
> On 2/28/22 14:12, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot uses environment variables for storing device setup data. It
>> usually needs to be accessed by a bootloader, kernel and often
>> user-space.
>>
>> This binding allows describing environment data located in a raw flash
>> partition. It's treated as NVMEM device and can be reused later for
>> other storage devices.
>>
>> Using DT should be cleaner than hardcoding & duplicating such info in
>> multiple places. Bootloader & kernel can share DTS and user-space can
>> try reading it too or just have correct data exposed by a kernel.
>>
>> A custom "compatible" string allows system to automatically load
>> relevant NVMEM driver but phandle can be also used for reading raw
>> location.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> V2: Update descriptions to don't make this binding MTD (flash partition)
>>      specific. Mention multiple possible storage ways.
>> V3: Drop
>>      allOf:
>>        - $ref: nvmem.yaml#
>>      as we don't use anything rom the nvmem.yaml. Thanks Rob.
>> ---
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
>>   MAINTAINERS                                   |  5 ++
>>   2 files changed, 67 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> new file mode 100644
>> index 000000000000..e70b2a60cb9a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: U-Boot environment variables
>> +
>> +description: |
>> +  U-Boot uses environment variables to store device parameters and
>> +  configuration. They may be used for booting process, setup or keeping end user
>> +  info.
>> +
>> +  Data is stored using U-Boot specific formats (variant specific header and NUL
>> +  separated key-value pairs).
>> +
>> +  Environment data can be stored on various storage entities, e.g.:
>> +  1. Raw flash partition
>> +  2. UBI volume
>> +
>> +  This binding allows marking storage device (as containing env data) and
>> +  specifying used format.
>> +
>> +  Right now only flash partition case is covered but it may be extended to e.g.
>> +  UBI volumes in the future.
>> +
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - description: A standalone env data block
>> +        const: u-boot,env
>> +      - description: Two redundant blocks with active one flagged
>> +        const: u-boot,env-redundant-bool
>> +      - description: Two redundant blocks with active having higher counter
>> +        const: u-boot,env-redundant-count
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    partitions {
>> +        compatible = "fixed-partitions";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        partition@0 {
>> +            reg = <0x0 0x40000>;
>> +            label = "u-boot";
>> +            read-only;
>> +        };
>> +
>> +        env: partition@40000 {
>> +            compatible = "u-boot,env";
>> +            reg = <0x40000 0x10000>;
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index db8052bc1d26..24fc181a7e6c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19958,6 +19958,11 @@ W:    http://linuxtv.org
>>   T:    git git://linuxtv.org/media_tree.git
>>   F:    drivers/media/pci/tw686x/
>> +U-BOOT ENVIRONMENT VARIABLES
>> +M:    Rafał Miłecki <rafal@milecki.pl>
>> +S:    Maintained
>> +F:    Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> +
>>   UACCE ACCELERATOR FRAMEWORK
>>   M:    Zhangfei Gao <zhangfei.gao@linaro.org>
>>   M:    Zhou Wang <wangzhou1@hisilicon.com>
> 
> I think that parsing these partitions is quite sw intensive process and I can't still see the value to have compatible string here.
> I would prefer to have just any link from u-boot node to partition instead.
> 
> But up to Simon or Tom to decide.

In the first place DT should describe hardware / platform / device as it
is. Without taking shortcuts. If environment data can be stored in flash
device partition it should be described exactly as that.

Systems like Linux can benefit from that.

If some systems (e.g. a bootloader - U-Boot or any other one) can't
afford parsing / covering whole DT structure due to some limitations -
then we can come with helpers. I've no objections here.

In dt-schema [1] we have place for U-Boot specific options. Please see
0986f729eff0 ("dt-bindings: u-boot: Add an initial binding for config").

We can add support e.g. for
u-boot {
         (...)
         u-boot,env = <&env>;
};

[1] https://github.com/devicetree-org/dt-schema
[2] https://github.com/devicetree-org/dt-schema/commit/0986f729eff0f40a66e85ab9dfb37681bf025ac4
