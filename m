Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DE4C6A90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiB1LdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiB1Lcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:32:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3566E79A;
        Mon, 28 Feb 2022 03:32:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y24so20816972lfg.1;
        Mon, 28 Feb 2022 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=PYAPGjFdDRtBMpUBd7EVDo9ZwVIJEBFOb28FygCS9fQ=;
        b=Y+VLHI33UooLohJWzvFW2IrEo2fkN/MIbcOeua++vsPZKSfkXaW6zsz48aVjTE4BOV
         H1AUG/2b4aj6Pd5qCxtWd/Ln77MaKN7hmjMuRhm2QN4SUNKdFIu6EniQQGgTH5DkmtvE
         rPBuwH8I5yqPqXT8xY28URkvw/bw9/52Jlh+Qc8aPlrBeI6bv73yXler7FIZbzihbgQk
         x8vr0b04dRqYX8NEqLjVfjEhUM6NZCwDbbdH+Vv1C4jrDSJm8VHEHj0tNLn/9gYZoao1
         smJkjE/r2FM77ToGJ5mFZjdLPiUCSUMJTPBMHFhJFyJezCtdhgZht9GUv3evs5WEpaF4
         Y6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PYAPGjFdDRtBMpUBd7EVDo9ZwVIJEBFOb28FygCS9fQ=;
        b=syIZ7RWf23CF6GrkACr5ENH1EBCKqDshYUoQRry4eFmjOuSB7yXuxGFSOFdFLrDU7r
         T1jWljjBMOFC1HMVdKxoNj0WAd9rIALC2Ow1rJjopHEaz538NSNQzBWmqoYLd8WRrvF1
         HgfzmQnDo8/bluZYY8J+UqWv9v39urFbgfdnahL8AQ8NUyE/nCF6Z5aiRjnn+WfblTIe
         TjVR03iRIdesaNmPTBO5WSGoClIHQu57j+9VySbNXLvC1DfIgBQxTXZEM4Pfhvjvu6Fr
         EVw/OVFIx3DAwYMKBIXndRYSrlYS8WgWw/J1y90UqUNsOw4T0tupEZn11zNocG6oABgn
         De1Q==
X-Gm-Message-State: AOAM530dXUc7tT8g/givP+xlW9r1KbLbOG+CYMhVIyIE6NF9rkvsMCwF
        Wn1zBQXxkA4CiWQewrOxRts=
X-Google-Smtp-Source: ABdhPJyzJ9CbFz6X6ObZEi0Fhye2LqzzMA2cVnyuBJolyCz+MGYLc/7dy2iKzYry0+Va3N70UTWbTA==
X-Received: by 2002:a05:6512:a92:b0:444:65e:732a with SMTP id m18-20020a0565120a9200b00444065e732amr9771630lfu.305.1646047932850;
        Mon, 28 Feb 2022 03:32:12 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id 16-20020ac25f10000000b00443890bd84asm916263lfq.114.2022.02.28.03.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:32:12 -0800 (PST)
Message-ID: <96f5a8d3-83db-fa1f-a27c-5c27d7c143e1@gmail.com>
Date:   Mon, 28 Feb 2022 12:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V2] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Tom Rini <trini@konsulko.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220217130235.7450-1-zajec5@gmail.com>
 <YhkHAQclxNHqmBwO@robh.at.kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YhkHAQclxNHqmBwO@robh.at.kernel.org>
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

On 25.02.2022 17:42, Rob Herring wrote:
> On Thu, Feb 17, 2022 at 02:02:35PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot uses environment variables for storing device setup data. It
>> usually needs to be accessed by a bootloader, kernel and often
>> user-space.
> 
> How much of this is already in use vs. proposed? I know I've seen
> something, but that may have been a u-boot env string in 'label' and
> that's it.

[bootloader]
Right now U-Boot doesn't use any binding for describing env variables.
It's location is usually hardcoded, see (in U-Boot):
* CONFIG_ENV_ADDR
* CONFIG_ENV_SECT_SIZE
* CONFIG_ENV_ADDR_REDUND

[kernel]
There is no support for accessing U-Boot env data. This patch is the
first step for adding such a support.

[user-space]
OpenWrt uses bash script to store a list of devices and their U-Boot env
variables location. In a long term I'd like to replace it and use DT
info + possibly a kernel exposed NVMEM data.


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
>>      specific. Mention multiple possible storage ways.
>> ---
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 66 +++++++++++++++++++
>>   MAINTAINERS                                   |  5 ++
>>   2 files changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> new file mode 100644
>> index 000000000000..a53e34152c97
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: U-Boot environment variables
>> +
>> +description: |
>> +  U-Boot uses environment variables to store device parameters and
>> +  configuration. They may be used for booting process, setup or keeping end user
>> +  info.
>> +
>> +  Data is stored using U-Boot specific formats (variant specific header and NUL
>> +  separated key-value pairs).
>> +
>> +  Environment data can be stored on various storage entities, e.g.:
>> +  1. Raw flash partition
>> +  2. UBI volume
>> +
>> +  This binding allows marking storage device (as containing env data) and
>> +  specifying used format.
>> +
>> +  Right now only flash partition case is covered but it may be extended to e.g.
>> +  UBI volumes in the future.
>> +
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +
>> +allOf:
>> +  - $ref: nvmem.yaml#
> 
> What exactly is used from nvmem.yaml? Based on the example, nothing.

Nothing. I thought it's nice for a context. I'll drop it.


>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - description: A standalone env data block
>> +        const: u-boot,env
> 
>> +      - description: Two redundant blocks with active one flagged
>> +        const: u-boot,env-redundant-bool
>> +      - description: Two redundant blocks with active having higher counter
>> +        const: u-boot,env-redundant-count
> 
> Aren't these 2 discoverable based on a flag or count property?

U-Boot discovers that based on a type of flash device(s). In redundant
mode env data can be stored on one or two flash devices.

U-Boot conditions:

/* Check flag scheme compatibility */
if (DEVTYPE(dev_current) == MTD_NORFLASH &&
	DEVTYPE(!dev_current) == MTD_NORFLASH) {
	environment.flag_scheme = FLAG_BOOLEAN;
} else if (DEVTYPE(dev_current) == MTD_NANDFLASH &&
		DEVTYPE(!dev_current) == MTD_NANDFLASH) {
	environment.flag_scheme = FLAG_INCREMENTAL;
} else if (DEVTYPE(dev_current) == MTD_DATAFLASH &&
		DEVTYPE(!dev_current) == MTD_DATAFLASH) {
	environment.flag_scheme = FLAG_BOOLEAN;
} else if (DEVTYPE(dev_current) == MTD_UBIVOLUME &&
		DEVTYPE(!dev_current) == MTD_UBIVOLUME) {
	environment.flag_scheme = FLAG_INCREMENTAL;
} else if (DEVTYPE(dev_current) == MTD_ABSENT &&
		DEVTYPE(!dev_current) == MTD_ABSENT &&
		IS_UBI(dev_current) == IS_UBI(!dev_current)) {
	environment.flag_scheme = FLAG_INCREMENTAL;
} else {
	fprintf(stderr, "Incompatible flash types!\n");
	ret = -EINVAL;
	goto open_cleanup;
}

I thought it's better & more flexible to describe format explicitly in
the DT. That way vendors have more options - they can e.g. start using
incremental setup on NOR flash devices.


>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    partitions {
>> +        compatible = "fixed-partitions";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        partition@0 {
>> +            reg = <0x0 0x40000>;
>> +            label = "u-boot";
>> +            read-only;
>> +        };
>> +
>> +        env: partition@40000 {
>> +            compatible = "u-boot,env";
>> +            reg = <0x40000 0x10000>;
>> +            label = "u-boot-env";
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 66aa3a589f6a..55c56ce82856 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19905,6 +19905,11 @@ W:	http://linuxtv.org
>>   T:	git git://linuxtv.org/media_tree.git
>>   F:	drivers/media/pci/tw686x/
>>   
>> +U-BOOT ENVIRONMENT VARIABLES
>> +M:	Rafał Miłecki <rafal@milecki.pl>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> +
>>   UACCE ACCELERATOR FRAMEWORK
>>   M:	Zhangfei Gao <zhangfei.gao@linaro.org>
>>   M:	Zhou Wang <wangzhou1@hisilicon.com>
>> -- 
>> 2.34.1
>>
>>

