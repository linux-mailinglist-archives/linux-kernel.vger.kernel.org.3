Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367164A01BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiA1UNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiA1UNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:13:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85704C061714;
        Fri, 28 Jan 2022 12:13:37 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z7so10611521ljj.4;
        Fri, 28 Jan 2022 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=oyubvIRPcf+wBpgIYExVWJ5YZhIrxzImt8AH+1iC93g=;
        b=D6NcriFnSEXRpif13YgafQO4ysVvmzYWAjmcnbkbVuchgEfLRzQ7Zx4HulzSVWb0uW
         pENSBuQnNaHqioOntSjh0R+DdszzzVVyqlWht0A6t8n+XKlbR2kqWDhbtQcvW4QjGOHl
         A76gS8uOoUtliXRB2yPDg/mK5LK9bgVrQ+ayY65uJeVAT2UzPm+EI61JzZ3rL2b/DRNq
         EYfsFBUrab/NZX0vZblw9YoTDIzQAQkI0Utz1gAdUPa38F1ndakp6Kdq9oKWkUqbFI/R
         s3O1CF2b2oxn9V7oOHwoJ3lx+ynds8YLDv1J9A5yv5D5IhDBP2Im9KFUueShIwG9uZK4
         ExNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=oyubvIRPcf+wBpgIYExVWJ5YZhIrxzImt8AH+1iC93g=;
        b=dt8ZX7IrCaZSTm72qigxf1L8bsorw2sE5oEE1FaExetAkfJqu9etrMvJWHfIFI3MiL
         sdK3+jkaWID3YOFlPdnLhnCoUCgBHsdqKIrGBKHuF+S+rd/1/JmTm3EmTOIJ8Q4Ekf2d
         5sivo+deaxl8N/gYk2sSWKKiBdPIu2ISYZiwDOFxCG+eklvGgtjQTYkdER8S5S9pipN9
         Loavlk83c2Vg1lRPf6WeKqBpJFE2lSz39nr/W+peVUTMwekaih8uaMVKA69FXVugeStP
         rLmxELDA8pWdzsJO/GDlqkiUgPCR3kfAr85gq3mlSmOquzezyFmzbtWDsiGzhNrqqS3p
         8SoA==
X-Gm-Message-State: AOAM532HdCVv70i9/e7gy3Jx7XubUd0sqaqQad7+78IPOMLHNaa0h2AO
        WvP2yxPgBGDo76bF6nBFSu8=
X-Google-Smtp-Source: ABdhPJzMVe/R5oHvZyV12m3N7NRIsQaaGH2zXBqERJV1ovuYz/yUqPpmy0PXU7hBmMVHmYcu4hIOHA==
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr4995935ljq.429.1643400815747;
        Fri, 28 Jan 2022 12:13:35 -0800 (PST)
Received: from [10.0.0.42] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id d20sm1755606ljl.25.2022.01.28.12.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 12:13:34 -0800 (PST)
Message-ID: <609b03e1-66e0-9bfd-cbe1-810d816df659@gmail.com>
Date:   Fri, 28 Jan 2022 22:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220103074427.4233-1-j-choudhary@ti.com>
 <2cf3c89c-169f-3421-25d4-c80a6c9737ae@gmail.com>
 <83c51ee4-ac10-0e44-d1cc-f69cebcbf0b8@gmail.com>
 <f2bf4959-af15-04ad-78c3-aca883173d65@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
In-Reply-To: <f2bf4959-af15-04ad-78c3-aca883173d65@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/22 12:07, Jayesh Choudhary wrote:

>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,dm646x-mcasp-audio
>>>> +      - ti,da830-mcasp-audio
>>>> +      - ti,am33xx-mcasp-audio
>>>> +      - ti,dra7-mcasp-audio
>>>> +      - ti,omap4-mcasp-audio
>>
>> This is the only thing which bugs me: the pointless '-audio' postfix for
>> the compatible string...
>>
> 
> Removing the postfix would also require a lot of dts changes which might
> be backward incompatible. So it is probably not a good idea.

My plan was to not convert the ti,*-mcasp-audio txt file to yaml in the
first place, but do it right with as ti,*-mcasp

One of the outstanding issue is the multiple serializer support. It
should be in core as things are just working by luck atm when more than
one serializer is in use (via the card node).

> Should we still consider this?

Since we are officially documenting the -mcasp-audio, I don't think it
would be a good idea to introduce different binding for the very same IP
just for the sake of it.

The new (and imho correct) binding would require quite a bit of work in
the driver and in the core level (plus the simple-card family), but I'm
afraid, I will not have time for it.

-- 
Péter
