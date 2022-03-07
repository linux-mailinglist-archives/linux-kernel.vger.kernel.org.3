Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA94CFC53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiCGLJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiCGLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:09:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835C73069;
        Mon,  7 Mar 2022 02:31:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z26so11502484lji.8;
        Mon, 07 Mar 2022 02:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:references:from
         :in-reply-to:content-transfer-encoding;
        bh=2nv1iXhepFFIDDtB8qcqMhOJPOHWwdUEN5oCGM6Jfco=;
        b=P+qgQtT2g5DRJU98tJo+fR3FQkLaSVdZRrllCfYJRhQ7HyekEWFKKJIU76/kqU6i/r
         6mKW84L9ZGUlb77m+tYbib91dNdmTYbJikjdeqlPrKLTIY0cO/5pB30DrKUZgJ2jes81
         bl9TC+UsSbpXFTTmibX7MmBRp7hD8gZwQE3qaAVMLF/5rtdv1lZW+jt7sLfeS9p3sc5L
         uEgoW2EjHdSEta7abOd2VV51Ffm0pZSfKN/SjLupm+13Yy6dlgmAuXn/+X9Z2FWLDNwN
         zM1b3Hj0SFKP8SOKBzWglAZk+T1l9d6AJUVpInfvicoFshQGYZIvaZfRIW4rEBa2Fhrc
         n7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=2nv1iXhepFFIDDtB8qcqMhOJPOHWwdUEN5oCGM6Jfco=;
        b=uKv0sea7hsB8OlxH6V4J0V7xUxufYmlwg3SYWJV6WqoF0vaV1LqMjmWpqGIsDyO9Mm
         aI+8jD1BSmhvmdAlyAc0X9kW+TcwyBVOBmISxuvWreUtjWgfNON8Un9CAhfuZ8s2xNkg
         YETZL0WpNAvH4pjcosqGMHrNYG/GHcWQPoOC86hzUu2vQZn4e8jmUHbgDBehPBPlJ9tN
         M30FeGxhXB6TMeWZYKNgphgtI1k9K5P8v1j0ecNonkal6wBl4CCFl282wClV8Hagj5eg
         nNbshF1/0wzP7Dptafpw46/UDdc9cIHyR09V/XpVSgId3WcUa/l43KIkyPZOwXUjh2OG
         HCew==
X-Gm-Message-State: AOAM532S8+pRO9a1fHFeuBmBzeQ1DBCRdN6JoDkXZK7MQoOS5XOZRzlk
        wpSFdVdzXqhYdz2gxnye8n4=
X-Google-Smtp-Source: ABdhPJwMwea0Gg9ZDQJ9Cg+UHGuu9HkIpFH2+kI2LpDNW+vSQsbke0JK8lt1exWBOkP0bEYFf+6t2A==
X-Received: by 2002:a2e:9847:0:b0:244:bbdf:8f72 with SMTP id e7-20020a2e9847000000b00244bbdf8f72mr7291471ljj.69.1646649086397;
        Mon, 07 Mar 2022 02:31:26 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id t10-20020a19ad0a000000b00443d203833csm2780374lfc.122.2022.03.07.02.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:31:26 -0800 (PST)
Message-ID: <d605473d-35b1-6c6d-3f13-988a04b48c32@gmail.com>
Date:   Mon, 7 Mar 2022 11:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V2] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
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
 <96f5a8d3-83db-fa1f-a27c-5c27d7c143e1@gmail.com>
 <YiXdRiM3ZREngl0N@ada-deb-carambola.ifak-system.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YiXdRiM3ZREngl0N@ada-deb-carambola.ifak-system.com>
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

On 7.03.2022 11:24, Alexander Dahl wrote:
> Hei hei,
> 
> just want to give a little more background here from embedded non
> openwrt point of view.  See below.
> 
> Am Mon, Feb 28, 2022 at 12:32:11PM +0100 schrieb Rafał Miłecki:
>> On 25.02.2022 17:42, Rob Herring wrote:
>>> On Thu, Feb 17, 2022 at 02:02:35PM +0100, Rafał Miłecki wrote:
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> U-Boot uses environment variables for storing device setup data. It
>>>> usually needs to be accessed by a bootloader, kernel and often
>>>> user-space.
>>>
>>> How much of this is already in use vs. proposed? I know I've seen
>>> something, but that may have been a u-boot env string in 'label' and
>>> that's it.
>>
>> [bootloader]
>> Right now U-Boot doesn't use any binding for describing env variables.
>> It's location is usually hardcoded, see (in U-Boot):
>> * CONFIG_ENV_ADDR
>> * CONFIG_ENV_SECT_SIZE
>> * CONFIG_ENV_ADDR_REDUND
> 
> And more … U-Boot has a variety of options to store the U-Boot env,
> from the top of my head:
> 
> - at some offset in raw flash / mtd partition on NAND, NOR, serial dataflash, etc.
> - at some offset on a block device, e.g. on eMMC
> - as a file in a FAT partition
> - in a UBI volume
> - …
> 
> And yes, it's determined by some build option and hardcoded at compile
> time.
> 
>> [kernel]
>> There is no support for accessing U-Boot env data. This patch is the
>> first step for adding such a support.
>>
>> [user-space]
>> OpenWrt uses bash script to store a list of devices and their U-Boot env
>> variables location. In a long term I'd like to replace it and use DT
>> info + possibly a kernel exposed NVMEM data.
> 
> U-Boot source itself has userspace tools fw_setenv and fw_printenv
> and those look into /etc/fw_env.config on how that env should be
> accessed.

I wasn't 100% clear on that but OpenWrt actually uses those U-Boot tools

OpenWrt scripts I mentioned can be found there:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=tree;f=package/boot/uboot-envtools/files;h=687c89806f72756053457a7ab7245bff1c4dcfe8;hb=HEAD

Random example:

linksys,wrt1900ac-v1)
	ubootenv_add_uci_config "/dev/mtd1" "0x0" "0x40000" "0x20000"
	;;
linksys,wrt3200acm|\
linksys,wrt32x)
	ubootenv_add_uci_config "/dev/mtd1" "0x0" "0x20000" "0x20000"
	;;

So those scripts simply generate /etc/fw_env.config required by
fw_printenv / fw_setenv. They have to match what's used by U-Boot at
compilation time.

My long term plan is to move that info to DTS and share it across
projects.
