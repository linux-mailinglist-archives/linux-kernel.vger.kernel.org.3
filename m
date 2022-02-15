Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622294B7328
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiBOO5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:57:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiBOO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:57:34 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F62219F;
        Tue, 15 Feb 2022 06:57:24 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o10so17533913qkg.0;
        Tue, 15 Feb 2022 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILxQXpZqsggfKJaiYiLNWzsJbf5uuRiUnJhFjTkzdCU=;
        b=pJTVL1qzV00sFBQUaZ4saWQPAhtgoSCor4B9npSlZdcflJbLOJNm+L5kxCTtJnbEwv
         ZCIAno3655klV1ESvrTuJEKHunty3txaPoX68zHNr9EI5ESo7+HrlTZzrzvX5PRZMslZ
         kz1JEmbArrF+cK35CwF1Bjk+5OHAfprxgkxdEaNiuNrt3w4qOz/4tGVhOVyKe27RMSEV
         mZRw49qbQhbJFd2yHgLLiBQzDbkcTLty3/pz29mQFng/wEYPFCiS6F9O/Y8FnNDsMiTR
         /kYTabRZIplP83LE5xWs11JDasl5G63Nc8tHQuCqxyQaT4BpZct+QZHwCTgavm4Bttkw
         Sr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILxQXpZqsggfKJaiYiLNWzsJbf5uuRiUnJhFjTkzdCU=;
        b=CU7JGgmaZQRGtgS1cWV1cL9wuCieBPZUXRsVOqC3bPvkeRCT6h8D4cWvCvBHu5PK63
         XxE5ehmn1yM8/9lywiaxvEZ0bABp1fKKJCKmn4zABdGCXokVllgpC10q/X552KvPREDd
         sSw3cgMhoOq3vyAQKEK4OCAiOHe9m7rBcixACjYpVTZ3OClI8BV7aj6Sh9CrsK9iTsk5
         pGKqUG0TS3YKTuitx3ApXQwG5B27BSb8b3ZkrmiktkoP3G4Sc1CzPfYusLdoOOqS5g8W
         PSk7sgcVgzxzyACa7y0X7IHgs773TI9YKO4f9HKQoGXI8ejq7UNn+UUdMr51YiRUND+T
         Co5A==
X-Gm-Message-State: AOAM531cuH8Qrap/iESIusxGK5ihr2lTxkhJpVb10NvEyZm/VxA8Fwoo
        3L6A264aD0NUdFlyZ7HP8CY=
X-Google-Smtp-Source: ABdhPJyX0XaNh9X82hlKG6Z3hPeGVNEXEZmUm3I1lD0m/SK84oMvbZxPw9rNHIkkb6iPIiqXyIvknA==
X-Received: by 2002:a05:620a:4455:: with SMTP id w21mr2123698qkp.20.1644937043143;
        Tue, 15 Feb 2022 06:57:23 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.googlemail.com with ESMTPSA id 22sm20609317qtw.75.2022.02.15.06.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:57:22 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
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
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <6679b98e-f5f0-8608-a36c-c0c41fb5ea6f@gmail.com>
Date:   Tue, 15 Feb 2022 09:57:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <193f9354-5e1d-def8-c8ab-fbe88d8d9b8f@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 9:02 AM, Michal Simek wrote:
>=20
>=20
> On 2/15/22 14:49, Rafa=C5=82 Mi=C5=82ecki wrote:
>> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>>
>> U-Boot uses environment variables for storing device setup data on
>> flash. That data usually needs to be accessed by a bootloader, kernel
>> and often user-space.
>>
>> This binding allows describing environment data location and its forma=
t
>> clearly. In some/many cases it should be cleaner than hardcoding &
>> duplicating that info in multiple places. Bootloader & kernel can shar=
e
>> DTS and user-space can try reading it too or just have correct data
>> exposed by a kernel.
>>
>> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>> ---
>> =C2=A0 .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 ++++++++++++=
+++++++
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 ++
>> =C2=A0 2 files changed, 63 insertions(+)
>> =C2=A0 create mode 100644 Documentation/devicetree/bindings/nvmem/u-bo=
ot,env.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b=
/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
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
>> +=C2=A0 U-Boot uses environment variables to store device parameters a=
nd
>> +=C2=A0 configuration. They may be used for booting process, setup or =
keeping end user
>> +=C2=A0 info.
>> +
>> +=C2=A0 Data is stored on flash in a U-Boot specific format (header an=
d NUL separated
>> +=C2=A0 key-value pairs).
>> +
>> +=C2=A0 This binding allows specifying data location and used format.
>> +
>> +maintainers:
>> +=C2=A0 - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>> +
>> +allOf:
>> +=C2=A0 - $ref: nvmem.yaml#
>> +
>> +properties:
>> +=C2=A0 compatible:
>> +=C2=A0=C2=A0=C2=A0 oneOf:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: A standalone env data b=
lock
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: u-boot,env
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Two redundant blocks wi=
th active one flagged
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: u-boot,env-redundan=
t-bool
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Two redundant blocks wi=
th active having higher counter
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: u-boot,env-redundan=
t-count
>=20
> I am not convinced that this is the best way how to do it. Because in u=
-boot implementation you would have to enable MTD partitions to get there=
=2E
> And the whole parsing will take a lot of time.
>=20
> I think the way how I think this can be handled is.
>=20
> # I don't think that discussion with Simon was finished.
> But for example (chosen or firmware node)
> chosen {
>  =C2=A0=C2=A0=C2=A0=C2=A0u-boot {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,env =3D <&qspi &part=
0>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,env-redundant =3D <&=
qspi &part1>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #or
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,env =3D <&qspi 0 400=
00>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,env-redundant =3D <&=
qspi 40000 40000>;

What about when the environment is on top of UBI?

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #or
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,env =3D <&mmc 0 0 10=
000>; #device/start/size - raw mode
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot,env =3D <&mmc 0 1>; =
# device/partition - as file to FS

For emmc at least you will need another cell for the hardware partition.
And of course, you can name the environment file whatever you want, so
that needs to be recorded as well.

IMO to do this properly you'd need to have a property corresponding to
each of the major configs in the env menu.

--Sean

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #etc.
>  =C2=A0=C2=A0=C2=A0=C2=A0};
> };
>=20
>=20
> &qspi {
>  =C2=A0=C2=A0=C2=A0=C2=A0flash {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partitions {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "fixed-partitions";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #ad=
dress-cells =3D <1>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #si=
ze-cells =3D <1>;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 par=
t0: partition@0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 label =3D "u-boot-env";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0x0 0x40000>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 par=
t1: partition@40000 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 label =3D "u-boot-env-redundant";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0x40000 0x10000>;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>  =C2=A0=C2=A0=C2=A0=C2=A0};
> };
>=20
> Thanks,
> Michal
>=20


