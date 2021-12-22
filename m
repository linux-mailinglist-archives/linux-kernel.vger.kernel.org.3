Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7934447DB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 00:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbhLVX6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 18:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLVX6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:58:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24968C061574;
        Wed, 22 Dec 2021 15:58:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so7252147pja.1;
        Wed, 22 Dec 2021 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XofzRBE+iv6y6NDSZetvECywZ3qDZCAlP8imEJP0fxo=;
        b=T+SRzr5tpM/IJyMrjcvA4Jy8/zIe5e5bbClozQhwW1c3oxYnLXMXjwp54Q9NUKF9b+
         JJL0ohnFzVpWWVAU0Lz+dllztfpSUBmAdZENzRdo/Afm/cKBxOlPiwW9JR2nrMXoNThi
         EoP1alHdq2mTRVJdFWiWZd5aev/MVWE4aEaO2PvHc1tB2ocN3mbukOEdobxfvy+ZJHHT
         uG+zc2mkYwWmmxumVbzrt7c43xrQBqxeWkcjrQPxyj+DfIne22vke7h4Zc/A+9FF66B5
         Ckngtl1W0+5TnAI5FwWhEKRI7l6/5pVfO2//YDogvDB5B+BbYfWRugvk5hDyHfEKS0lG
         lm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XofzRBE+iv6y6NDSZetvECywZ3qDZCAlP8imEJP0fxo=;
        b=dC1BOREojCyfXIKTFiwbzbzDbzs/6iqqGPaFamRJ6SZTnIkMfOClwtsOWgCwKbd0fI
         SmdmMQrWonJ36+/Nra5vbpuFHxgWqzHmO9QY+PsXr5gP8deoxLGlaYKbmovIrZoIUemw
         6Biw/dO74VIYtgt9EsswQ2VK7pvBcLI9tGdVEki4Dtwsd1F/hRkZTnRAiBCycx/pGXGT
         1/bM/opvVRQqzphLraAIcyM+QcHQvZf7vBKgTe/5nC5Zxgz/HDUBq0cMgT4Nroufx7iF
         JFVyHaeI7uiQKvebVeYn3H5/8Pl1gsff7NTswVOo2N6fH1oEUsrqDWf+hA+81di+6HH+
         lsFQ==
X-Gm-Message-State: AOAM5327U7AgTAC5GmGPEzO9SC4gUUnJlG1YX3cLR4BTSXhY2YyQnklH
        YKO8ld74CdJZSwoyhv6R6HBwJffHRQo=
X-Google-Smtp-Source: ABdhPJxMdQIvmF3YP8RKhDYcN9nk1UpYQKV42h5xFhYLnaw+C4gY/NwjI7dPnP8YfvBzmzPTv/ZG4g==
X-Received: by 2002:a17:902:bd04:b0:148:ea19:556 with SMTP id p4-20020a170902bd0400b00148ea190556mr4843883pls.112.1640217528040;
        Wed, 22 Dec 2021 15:58:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s30sm3502774pfw.31.2021.12.22.15.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 15:58:47 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211223085944.0095eaf5@canb.auug.org.au>
 <CAK8P3a3WxP1x60fj7oPzY2=gTUEgA68x1vc17tRHEJ-O19-UTQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6a830fc3-2186-0335-a600-8410abc24ea2@gmail.com>
Date:   Wed, 22 Dec 2021 15:58:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3WxP1x60fj7oPzY2=gTUEgA68x1vc17tRHEJ-O19-UTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 3:22 PM, Arnd Bergmann wrote:
> On Wed, Dec 22, 2021 at 10:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the arm-soc tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:109.4-14: Warning (reg_format): /switch/ports:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_default_addr_size): /switch/ports: Relying on default #address-cells value
>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_default_addr_size): /switch/ports: Relying on default #size-cells value
>>
>> Maybe introduced by commit
>>
>>   3d2d52a0d183 ("ARM: dts: BCM5301X: define RTL8365MB switch on Asus RT-AC88U")
> 
> Confirmed, and now reverted as I'm already tagging the final pull requests.
> 
> Arınç, Florian: Feel free to resubmit a fixed version for the "late"
> branch that Olof
> may still pick up when I'm out of office, in case this is an important
> change. Otherwise
> I guess we can leave it for 5.18

Will do, thanks and sorry about not catching this earlier, I did not see
it it in the build log somehow.
-- 
Florian
