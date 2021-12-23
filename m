Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4147E793
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349815AbhLWSSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbhLWSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:18:35 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE4C061401;
        Thu, 23 Dec 2021 10:18:35 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id r15so11606513uao.3;
        Thu, 23 Dec 2021 10:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NmeJ67pdFJJuFTydiDcuzKxhQ/kTg7RGAFCoGfwnnPY=;
        b=GA7RPJuOwrMLDuLABEAn1P9Iuz4C8iTV3/DkmisuF6nWgWzi4siqog+UeRN6qCO9//
         KF101w8xqZhCbWCdiyvAG6ougU6dKptJFKBvsTuavk18GEP2nBbSOrWksnR9k4bldjEM
         tGDWRf68p8qZMIOKCa9O30L/sDM5/1y8Wo/g0+O74T4de5dhfgm8d8vQML1YKzpNRH2T
         Uxc/G6tZ5+Adlj/afRLRwRCJdIErzDvjHTCviulfDssXa0+HLCE7Ro7h1WZQnQ3ntp+U
         IB19kqnAq0jy+++yRRQ1GxryNX3LAvoS54dDpJv6trdy/eMi1jHTkQdKJJt/liBREDSm
         3Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NmeJ67pdFJJuFTydiDcuzKxhQ/kTg7RGAFCoGfwnnPY=;
        b=gZF+Ln+3/aS8v5pbrz3twuxs0/1+MAvYXPD75dIPbfq6mq0XkSPTtaPlFDtnUgtR0Q
         kiVectUmMnXOrUxjE1ANa64Du0M52I1e96/GlWtCDyfKTsSzkk8TdS3ClK6K0ZMeI7oK
         DAzH+8ePggtO53ZLBOGgkFasF2efiYbxSANJ+h3MHU+YWsUx8i5A3BR4+74boNRoYtno
         ogalfViQczHW/LPehlTqRFN8Z0Q54H5/uEW9daFPmigyqREnEr98RQ1sasjK1F1zI005
         xSqBG5UY49XTIJIYs1EkAJbiO2J7kXIa2TR3eXelbwGklH92KhEUFsfZI/SdzIOCVMiA
         G+Xw==
X-Gm-Message-State: AOAM5306/VEIGjCFxxvmynDXJ4zEk8/wl8Wf0Y0PxS7IYBm13aQ60pHT
        NJZ7gVuFb6CQ027BTyhaQ1A=
X-Google-Smtp-Source: ABdhPJxVz2GubnCEUR0CBNvNp3uJCME9FVi8+Mv1mIbvYXIP0Q5klHH0NBupIB9HFM0aUwCYoHGfbA==
X-Received: by 2002:a67:2683:: with SMTP id m125mr1086777vsm.80.1640283514812;
        Thu, 23 Dec 2021 10:18:34 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id s12sm1192696vsj.26.2021.12.23.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 10:18:34 -0800 (PST)
Message-ID: <684e3940-0884-4139-dd4e-a16375ec9cf6@gmail.com>
Date:   Thu, 23 Dec 2021 10:18:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: build warning after merge of the arm-soc tree
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211223085944.0095eaf5@canb.auug.org.au>
 <CAK8P3a3WxP1x60fj7oPzY2=gTUEgA68x1vc17tRHEJ-O19-UTQ@mail.gmail.com>
 <6a830fc3-2186-0335-a600-8410abc24ea2@gmail.com>
 <00324e0f-7825-4ddc-a823-40a698715442@arinc9.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <00324e0f-7825-4ddc-a823-40a698715442@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2021 12:50 AM, Arınç ÜNAL wrote:
> Hey Florian.
> 
> I'm not sure I understand what's going wrong here. I did everything 
> according to the documentation here:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt#L158 

The problem is that there is a 'reg' property for the 'ports' node when 
this node is just a "container" for additional sub-node. This is because 
the example you rightfully followed to the letter was wrong to begin 
with. Should be fixed with:

https://lore.kernel.org/netdev/20211223181741.3999-1-f.fainelli@gmail.com/

And you would need to make a matching change to 
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts.

Thanks!
-- 
Florian
