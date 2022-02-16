Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE564B8854
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiBPM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:59:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:59:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD7B2A7940;
        Wed, 16 Feb 2022 04:59:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j7so3689279lfu.6;
        Wed, 16 Feb 2022 04:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=3I6rsvqr0mlrvYnDazu42tE4XkXO5iPbi6btp+uNzl0=;
        b=fhz7EFKqwWE+SszFc9jnDdwcNo2k56EUS6+p4FLbx4gmMUIENXrNd+ZMEaD2ad3Rbh
         P9KdWCuLD+eAIfrPhV8rqVA6vZsHrYUP7Y6neoBt8x07cBj2ZamBtEhEzCuniTqcq4w5
         tMH3KpEbgnpsqOFhsWH+BMnaoepqxsoZ872heKCxi4gE83yDCW4G9O13yhoXcLeNjNEK
         EB6wzlDrNjvXJoEyj+jKVWZVF7SOMe2UhvhOmDnJIEnLE2N7NQjRABkKz8SjCm3vYRhp
         pK0Sjujy+s6dM3JCUWF7+aIk5IlJrLcPaKPKtRWUYrgucZdMGkly40Oju7Q84DCrHTfU
         q0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3I6rsvqr0mlrvYnDazu42tE4XkXO5iPbi6btp+uNzl0=;
        b=xQf6MvKa3l95Oalm0I3U1DuNbcu0Fpua1UYaForgflYlLYn0K13sADBey1oh1TXK/v
         wOrHnIvblEnQLVb6duYQ/XO5ze1u5BSih4oSocTt/7NByUj6a570hSqx7vTSPNL6GFHL
         xIUIWiitpZXNe9vG5lVBwQ+5Zp0jnm/1Fq1ZAbEF/edX7xd43xOvlQKlqYfSwVa02iUw
         hr1y21KIKhnHYXyPkcQl1m9Yx+UPIxpsLGQE3EU0AG6OGlqV2aplNhIl5iHCgjjVrR1N
         gcEGbyuUjtFrut2dqRV2tfQUA8emVR8e7GNigxL79g+eGsN8Rhfc+9o+FOJfOJaw3gDd
         Pnsg==
X-Gm-Message-State: AOAM531dUWvt45tqTsZqpROjseoua7lzEeWn6spQ6K4NvDYUW73ujaO4
        Q7gRiRiROOaYMzHU6Et2tTU=
X-Google-Smtp-Source: ABdhPJzlhIpb3lxXUy5xYKGbLavdySMDPGcCaWy3IRxd4rNchi0eyaGzIsT5drnULjD4pY8pMwNcKA==
X-Received: by 2002:a05:6512:3e13:b0:443:3055:97d3 with SMTP id i19-20020a0565123e1300b00443305597d3mr1971138lfv.658.1645016378831;
        Wed, 16 Feb 2022 04:59:38 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id w35sm4809237lfu.273.2022.02.16.04.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 04:59:38 -0800 (PST)
Message-ID: <3c690660-7e23-e11b-17b8-496882f3a34e@gmail.com>
Date:   Wed, 16 Feb 2022 13:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Sean Anderson <seanga2@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        devicetree@vger.kernel.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220215134925.32691-1-zajec5@gmail.com>
 <193f9354-5e1d-def8-c8ab-fbe88d8d9b8f@xilinx.com>
 <6679b98e-f5f0-8608-a36c-c0c41fb5ea6f@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <6679b98e-f5f0-8608-a36c-c0c41fb5ea6f@gmail.com>
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

On 15.02.2022 15:57, Sean Anderson wrote:
> On 2/15/22 9:02 AM, Michal Simek wrote:
>>
>>
>> On 2/15/22 14:49, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> U-Boot uses environment variables for storing device setup data on
>>> flash. That data usually needs to be accessed by a bootloader, kernel
>>> and often user-space.
>>>
>>> This binding allows describing environment data location and its format
>>> clearly. In some/many cases it should be cleaner than hardcoding &
>>> duplicating that info in multiple places. Bootloader & kernel can share
>>> DTS and user-space can try reading it too or just have correct data
>>> exposed by a kernel.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 +++++++++++++++++++
>>>   MAINTAINERS                                   |  5 ++
>>>   2 files changed, 63 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> new file mode 100644
>>> index 000000000000..a2b3a9b88eb8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> @@ -0,0 +1,58 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: U-Boot environment variables
>>> +
>>> +description: |
>>> +  U-Boot uses environment variables to store device parameters and
>>> +  configuration. They may be used for booting process, setup or keeping end user
>>> +  info.
>>> +
>>> +  Data is stored on flash in a U-Boot specific format (header and NUL separated
>>> +  key-value pairs).
>>> +
>>> +  This binding allows specifying data location and used format.
>>> +
>>> +maintainers:
>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>> +
>>> +allOf:
>>> +  - $ref: nvmem.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: A standalone env data block
>>> +        const: u-boot,env
>>> +      - description: Two redundant blocks with active one flagged
>>> +        const: u-boot,env-redundant-bool
>>> +      - description: Two redundant blocks with active having higher counter
>>> +        const: u-boot,env-redundant-count
>>
>> I am not convinced that this is the best way how to do it. Because in u-boot implementation you would have to enable MTD partitions to get there.
>> And the whole parsing will take a lot of time.
>>
>> I think the way how I think this can be handled is.
>>
>> # I don't think that discussion with Simon was finished.
>> But for example (chosen or firmware node)
>> chosen {
>>      u-boot {
>>          u-boot,env = <&qspi &part0>;
>>          u-boot,env-redundant = <&qspi &part1>;
>>          #or
>>          u-boot,env = <&qspi 0 40000>;
>>          u-boot,env-redundant = <&qspi 40000 40000>;
> 
> What about when the environment is on top of UBI?

We can always add support for binding UBI volumes in DT. Somethig
more-or-less like:

partitions {
	compatible = "fixed-partitions";
	#address-cells = <1>;
	#size-cells = <1>;

	partition@0 {
		compatible = "ubi";
		label = "ubi";
		reg = <0x0 0x1000000>;

		env0: partition-0 {
			volume-name = "env";
		};

		env1: partition-1 {
			volume-id = <10>;
		};
	};
};
