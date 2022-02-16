Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18404B8842
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiBPMzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiBPMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:55:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1CD243A31;
        Wed, 16 Feb 2022 04:55:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g39so3632310lfv.10;
        Wed, 16 Feb 2022 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=04ys93/VF6cqrdqdqsN45PEh53EcKWaDUry2p6DE8g0=;
        b=emhq4CHM1ydqlCCQFlD+mopuV3YAZ2uTPzzpK7cR4+Hme1j6LV05N6ckFI3pJshYW8
         7mE98IncaNwyAkaCaQJw0T9WGrTRHRBp0BjEZj/bbsCH55vB7dPBRG4p1LBkuJYGmu3R
         isZzWUXoANDkU12NQobhAdRwV5PP3SfoCJ9A9S+nNyhPTePyBb7vbWco8qrugP8/bAt8
         auKtvj0SGE+dX/sZ8ANYUcCCuQwZts0wlgOJGYd3Y5e2J7HdhZs3E3IEv+98GEYGryc/
         BTI4vl5Lj2y2w+1n3EKmj8XXIq4oMmKFY2v2G30uj/pVNP5zTwZWFoFZlfAqTwyvQhXv
         5Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=04ys93/VF6cqrdqdqsN45PEh53EcKWaDUry2p6DE8g0=;
        b=YHl0yuKEy+m0fxEocD0i3FZLzujuPqcHSR5Z2Njovu5ZNuSckjsrGdJjtdlBArCFFZ
         Il4YO7ISTcvfVN0SGJGkmMmV15gdBVDTEctfYB5Z3f6RlBl2xVtEGTraVqHnGufcuK8T
         ij/9GJoGS4Cm63UIbSEuoFUdbZ11G7vbWalYq4uBFaAiZ6psWxvv3GxV93Z9OdjNOo1X
         q03P6ZY0eKoqCcuJ3khcGTjv7nKaNgibFOY5yhyWXwkNDAeBtJkBVz9VH9ncYABNDcRD
         8MLtBFgf2jZn2p+ceC1oA22dcDnCgbKIZkkzvYzKHf6cJdJvfeJYILt+iVUTLUsg5zr6
         xVHw==
X-Gm-Message-State: AOAM530JLRsd55On8YzgXFezze0/0KdiQVEREpjl7ofJZeKw3MzzNf72
        psdtd4pcDYlzbAGPSPdj6ffmXlNq52k=
X-Google-Smtp-Source: ABdhPJw17x0/DuzyfZ41dgaqBgPyKJpABTu+sGRAYkwdvDAufCWmJd030sESATkSL6ppOGmuKK1fSw==
X-Received: by 2002:a05:6512:2290:b0:443:1834:eb23 with SMTP id f16-20020a056512229000b004431834eb23mr1780810lfu.537.1645016102755;
        Wed, 16 Feb 2022 04:55:02 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id a17sm1380441ljd.105.2022.02.16.04.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 04:55:02 -0800 (PST)
Message-ID: <a3230dfd-f04d-a6b1-a2cf-87fd3621c295@gmail.com>
Date:   Wed, 16 Feb 2022 13:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Michal Simek <michal.simek@xilinx.com>,
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
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <193f9354-5e1d-def8-c8ab-fbe88d8d9b8f@xilinx.com>
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

On 15.02.2022 15:02, Michal Simek wrote:
> On 2/15/22 14:49, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot uses environment variables for storing device setup data on
>> flash. That data usually needs to be accessed by a bootloader, kernel
>> and often user-space.
>>
>> This binding allows describing environment data location and its format
>> clearly. In some/many cases it should be cleaner than hardcoding &
>> duplicating that info in multiple places. Bootloader & kernel can share
>> DTS and user-space can try reading it too or just have correct data
>> exposed by a kernel.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 +++++++++++++++++++
>>   MAINTAINERS                                   |  5 ++
>>   2 files changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> new file mode 100644
>> index 000000000000..a2b3a9b88eb8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>> @@ -0,0 +1,58 @@
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
>> +  Data is stored on flash in a U-Boot specific format (header and NUL separated
>> +  key-value pairs).
>> +
>> +  This binding allows specifying data location and used format.
>> +
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +
>> +allOf:
>> +  - $ref: nvmem.yaml#
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
> 
> I am not convinced that this is the best way how to do it. Because in u-boot implementation you would have to enable MTD partitions to get there.
> And the whole parsing will take a lot of time.

We'll need to find some consensus considering all points:
1. DT objectives
2. U-Boot needs
3. Linux needs

DT should mainly describe hardware / platform without focusing on a
single implementation details. If U-Boot env data is indeed stored in a
flash block (or blocks) / UBI volume, its binding should be just that.

If U-Boot requires MTD to parse proposed binding and it can't be
afforded at the same time - maybe it can come with different
implementation?


> I think the way how I think this can be handled is.

One minor note: I don't think you can have one "standard" format and one
"redundant" format. If env data is stored in two places - both use the
redundant format.


> # I don't think that discussion with Simon was finished.
> But for example (chosen or firmware node)
> chosen {
>      u-boot {
>          u-boot,env = <&qspi &part0>;
>          u-boot,env-redundant = <&qspi &part1>;

1. Using &qspi seems reundant here, you can get parent flash device by
    walking DT.
2. Using "chosen" seems to be a /shortcut/ for getting env data
    location, I don't see any direct conflict with using "compatible"
    string as proposed in my binding.


>          #or
>          u-boot,env = <&qspi 0 40000>;
>          u-boot,env-redundant = <&qspi 40000 40000>;

Here you moved code describing partition from "partitions" into "chosen"
which seems incorrect to me. We already have bindings for partitions and
they should be children of flash node.


>          #or
>          u-boot,env = <&mmc 0 0 10000>; #device/start/size - raw mode
>          u-boot,env = <&mmc 0 1>; # device/partition - as file to FS
>          #etc.
>      };
> };
> 
> 
> &qspi {
>      flash {
>          partitions {
>              compatible = "fixed-partitions";
>              #address-cells = <1>;
>              #size-cells = <1>;
> 
>              part0: partition@0 {
>                  label = "u-boot-env";
>                  reg = <0x0 0x40000>;
>              };
> 
>              part1: partition@40000 {
>                  label = "u-boot-env-redundant";
>                  reg = <0x40000 0x10000>;
>              };
>      };
> };

So my summary for this would be:
1. Let's use partitions for placing env data partition binding
2. Let's add minimal U-Boot setup into "chosen" if needed

Please consider this:

chosen {
	u-boot {
		u-boot,env = <&env0>, <&env1>;
	};
};

&qspi {
	flash {
	    partitions {
		compatible = "fixed-partitions";
		#address-cells = <1>;
		#size-cells = <1>;

		env0: partition@0 {
		    label = "u-boot-env";
		    reg = <0x0 0x40000>;
		};

		env1: partition@40000 {
		    label = "u-boot-env-redundant";
		    reg = <0x40000 0x10000>;
		};
	};
};

If you still need to access flash content directly, you can pretty
easily calculate offset from &env0 and &env1 nodes.
