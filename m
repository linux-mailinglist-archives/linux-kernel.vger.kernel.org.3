Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06EC4FA80E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiDINNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiDINNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:13:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEE51CFF4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:11:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d10so12996787edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fk14ni3i8G96z4f8pq05wrIS8FpW9xNUO0773O3LHoM=;
        b=vkd5EfGgyPNQzO3KKWJ/tWliiuVyuv+xPQTbNlezmYjpkJVsavZeEjxfSOKxELcpf3
         +a1kHoXPNyYpuk0GFPvVcCIB00/mjZCkNWxHeHE+5j87bvp6p2vtImZwvdYcGmuEn217
         9idt/AAncczmMjByAxpxYuiveenNW6ELv6JKSEDe1u1x7BXWVZ5tdyejR+7Pag/EfXU9
         WAY03mfM7S8nLTi6jmEyIG6+QmNAoZHOwq4m9RT9P8ORG4phXmHceppebS96xMfT5QFI
         9UuB2rNp7GyhaAy8/d7L/sZyH05+GYIG/LAilBUCfN8LNOITdNxDFhKAraa8wE7ThgoZ
         eHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fk14ni3i8G96z4f8pq05wrIS8FpW9xNUO0773O3LHoM=;
        b=2LAmp0l8VEzRAH0QjPa0w1trZ+mEPOtctfQCpCfiXxMiqeFRskoqqtXchhDNbg3Ubp
         6EEc7RQ8pAh4DUQisQzwa8CEpHP94e/y40oq/+0WR7V/9+MvUtKvmkXa0fGKQkZsQHPW
         jdabboKyCtmmYKMUUepKxu2CRNCfdWkLgugMYAs0eRpSwTxim8a+NDDs/NibODGJ6kMh
         Oe3pXdvjNsO77qHIeH0EvdDfEBh70fwCDmxjGtyPoGl3QKXzAZs1AOj1NcKa3gkjESm3
         cMLiPGCLlEE+63OMnco4sE3pLlc6qS6hF+GImtFK/pgq5zQLgk7i6iJTfdJLWrxjYga6
         VmWg==
X-Gm-Message-State: AOAM531jVPYEjmjuPA3aQH1os89kTxOvBlCU6j+0+PRAJcep8VLLp0sy
        5Haoh4tvPNKRyznNpwygp9Xvkw==
X-Google-Smtp-Source: ABdhPJzVLVDzDJNvXUBdqBjrQiDjqAEPnAdXcAJtTtbQFwlKlYU12HMtUyPyNg0Bx2TfYskkPpj4iA==
X-Received: by 2002:a50:cd8d:0:b0:416:63d7:9326 with SMTP id p13-20020a50cd8d000000b0041663d79326mr23966281edi.233.1649509888865;
        Sat, 09 Apr 2022 06:11:28 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b006e846b12596sm1916626ejc.225.2022.04.09.06.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:11:28 -0700 (PDT)
Message-ID: <ef1674e5-2347-fbb4-52c8-5170faa84690@linaro.org>
Date:   Sat, 9 Apr 2022 15:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
 <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
 <A023438A-B8A8-4F91-BA25-7BE9A76C6730@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <A023438A-B8A8-4F91-BA25-7BE9A76C6730@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:03, H. Nikolaus Schaller wrote:
> 
> 
>> Am 09.04.2022 um 13:11 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>> arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible: 'oneOf' conditional failed, one must be fixed:
>>> 	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is too long
>>> 	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu', 'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
>>> 	'simple-mfd' was expected
>>> 	'ingenic,jz4760-tcu' was expected
>>
>> Trim it a bit...
>>
>>> 	From schema: Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>
>> You need to explain this. You're changing the effective compatible of
>> the device and doing so based only on schema warning does not look
>> enough. Please write real reason instead of this fat warning, e.g. that
>> both devices are actually compatible and this has no real effect except
>> schema checks.
> 
> both use jz4740_soc_info / jz4770_soc_info and there is no ingenic,jz4780-tcu...
> So it doesn't change function, just makes it fit to the bindings.
> 
> We could solve it differently add ingenic,jz4780-tcu to bindings and the
> driver compatible table.

Just please use it in commit msg instead of or next to the warning.
Don't focus on the bindings check but focus on actual hardware and its
description.

Best regards,
Krzysztof
