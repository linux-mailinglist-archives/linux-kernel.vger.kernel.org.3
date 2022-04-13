Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647DC4FF4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiDMKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiDMKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:43:34 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB7C53713;
        Wed, 13 Apr 2022 03:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649846438; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hTK7F7eh6Xj5J9hP1dIAfil1UZQXRGvObkBRkCHTzuj0q+lftB/3yKqiMTFAIdVBma5pFUK4GvD+9o5kxtw8GPcV0uoSYViNV+3P9tCh13Y8rj6EbKqUXZeG+JIbmcPSmyOo09mjWI0rdks8X/kpwFelWwDS8FUsxvmaDpKqTM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649846438; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8cuduJRz7v/CIkmAbDKACdBfRvx+g1IMGtExWKUFiic=; 
        b=LrHwsyl96YzAPFyMZZpFmRM8ZAsJ7/WEnxyJJT47vRS3WxWnU2BBZFzoeMIHMJsIi/NUO3WoRdmkQnPEU83K6p2T35tvAWhFLlG4l91geiLdcIqHxkwTsURZrQTp1eCLlY/SNH8xoJJfwBFcQHP1JhSguHb/gquV5RSm7IEzzRI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649846438;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=8cuduJRz7v/CIkmAbDKACdBfRvx+g1IMGtExWKUFiic=;
        b=V6098wza0NbqnazK1jLojGrElIUHRSajhlmRUN/clG2dIogHtpfLVNrqY+sw+VCA
        AD3eI/5ydAsd+vuTzj7gvQxsFy/6SRuudVpbpvRuggPtxo+a6v7Y3wWh0EBBKvOYbG/
        XrpN6GHMTC7RG28BeFmvGzv0bAV51k+Ci3sNHQ6g=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 164984643564144.415058780915956; Wed, 13 Apr 2022 03:40:35 -0700 (PDT)
Message-ID: <f5f3b847-eb6d-9978-3040-245e3b1acb23@arinc9.com>
Date:   Wed, 13 Apr 2022 13:40:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 08/14] MAINTAINERS: add Ralink pinctrl driver
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <20220413060729.27639-9-arinc.unal@arinc9.com>
 <d0ed8518dfb93e6f2bbbaf4aac3436dd20369c00.camel@perches.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <d0ed8518dfb93e6f2bbbaf4aac3436dd20369c00.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 11:29, Joe Perches wrote:
> On Wed, 2022-04-13 at 09:07 +0300, Arınç ÜNAL wrote:
>> Add a new section for the Ralink pinctrl driver and add me and Sergio as
>> the maintainers.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> It's unusual for a last name to be completely capitalized.

I was influenced by a law for official correspondence from where I live. 
It sort of stuck with me. Surely that's not a problem?

> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -16502,6 +16502,13 @@ L:	linux-mips@vger.kernel.org
>>   S:	Maintained
>>   F:	arch/mips/boot/dts/ralink/mt7621*
>>   
>> +RALINK PINCTRL DRIVER
>> +M:	Arınç ÜNAL <arinc.unal@arinc9.com>
>> +M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> +L:	linux-mips@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/pinctrl/ralink/*
> 
> Typically this is just the directory.
> 
> F:	drivers/pinctrl/ralink/
> 
> as this covers any file in the directory as well as
> any possible subdirectories and files.
> 
> Using
> 
> F:	drivers/pinctrl/ralink/*
> 
> excludes any possible subdirectories and files within those
> possible subdirectories.

Thanks! I'll change this if I get more stuff to address. I think this is 
too minor of a change for resubmitting the series as there're no 
subdirectories on there yet.

Arınç
