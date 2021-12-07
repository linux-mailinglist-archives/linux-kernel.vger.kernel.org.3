Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09146C3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhLGTny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhLGTnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:43:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B41BC061574;
        Tue,  7 Dec 2021 11:40:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z7so702610lfi.11;
        Tue, 07 Dec 2021 11:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=lJUPRmvzGBYlX226TjBuiYmtUf9jUn5G93+KA16LjAg=;
        b=N6dpjqjSGXJte521IlFBV3JwwBDYSI3jUNgG7vtsLv2egTWEUMbr6ffb6gexw+xZgO
         MJw07re/mwKoJsjygSKKeTnXfWMN1H0c4Ywt1Ums0+LkmTRdvqoqWsnpAADjZyQ4jf66
         omAWJ3HlFasrghRBVxCq33dqszE2xRUfWFXzmTGXlrE6jiI8Rv9qt5GeR2vLr/Y4CgCm
         C1Uk36jREfGSnQAO1Ua+bJ2wztS8eJ/wr0ezCvK82B8V+rmwc2cAJd6fEgFt999UYXPh
         Ujz4ngGsWTEsoI635i1clIuyfdidjm2dilIIplYQZsrApMn1FdTDQGMoiCRwRTWW5rqR
         oZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=lJUPRmvzGBYlX226TjBuiYmtUf9jUn5G93+KA16LjAg=;
        b=NcTx8jo+bk1bx1+j0iwiK6YSTpkyUKXFauljiKlvAsSW0viKQfyc5gelWzW5n5REQr
         4tWcOu4HEZm+X1FzWRP8wKbKS7VUTVq7oHqcY27uYumRJQgpPmveodXIrhT7cOS2TZVS
         jFrW50c3Q0RgXw0Vy/90xNtRJHWkCjtxkESco43t3QgYrM7vsg3jO5eSV0+dAmp1Cg0b
         qYuPqPKhnk81drj+R7jnUO2gFYnhbFKWF0afwrVlQYsJHAZSIA1Vdn8zxvnAsjGQiyeI
         RpyOwhwoB0kober8/WPzLrVVUQmzZcyu3GEJ9lRguFZdEfhmvFubcmi9QriQhYFED4ft
         ekYQ==
X-Gm-Message-State: AOAM532r+FOK44sWc8xFm5vqv/Aalx/tTDoi+IjBFNwgmsSmXHNDjPP1
        XD4X1zcJF6L5vtGjuEnCCMg=
X-Google-Smtp-Source: ABdhPJyr4zizRPTfcscSDF65TlfDwku/yypVsSmIKZoDc7b4l/BC9epnqQcHVd81tlPlhrwQ26x3pg==
X-Received: by 2002:a05:6512:ac5:: with SMTP id n5mr41852984lfu.246.1638906020361;
        Tue, 07 Dec 2021 11:40:20 -0800 (PST)
Received: from [10.0.0.42] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id p10sm51919lja.0.2021.12.07.11.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 11:40:19 -0800 (PST)
Message-ID: <b6af56f1-7e6b-81ca-7bae-8f2a2dfaf0eb@gmail.com>
Date:   Tue, 7 Dec 2021 21:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211203120243.24173-1-j-choudhary@ti.com>
 <ed6c9be9-32d3-719a-ee0d-608b228f36b3@gmail.com>
 <20449d7b-0524-a8df-7852-a4c495157682@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
In-Reply-To: <20449d7b-0524-a8df-7852-a4c495157682@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/21 07:03, Jayesh Choudhary wrote:
>>> +  tdm-slots:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: number of channels over one serializer
>>> +    maxItems: 1
>>
>> and it has to be between 2 and 32, ignored in DIT mode (384 slots)
>>
> 
> Will add minimum and maximum. Should this be added as a conditional
> property when op-mode is 0 (I2S mode) and mark it as required?

That would make it much nicer, yes, thank you!

>>> +  port:
>>> +    description: connection for when McASP is used via graph card
>>> +    type: object
>>
>> I understand that it can be present under the mcasp node as it is part
>> of the graph card binding (or a card binding using graph).
>> I mean if a new card binding comes around then we need to document it
>> here as well?
>>
> 
> Specific properties are not marked for the port. So it should not be an
> issue. Other alternative is to mark the additional properties as true
> but that is not preferred.

If the McASP is used with simple-sound-card (as it is the case most of
the time) then the port is not present under the node for this device as
the card is not using graph.
I consider the port (and the #sound-dai-cells if we are here) not part
of the McASP hardware description as they are part of the graph or
simple-card binding.

I'm fine if the port remains here

> Peter,
> Any other changes I should make?

Not much, this already looking good.
I would fix the dts files which generates warning/error with this yaml
as they are incorrect.

-- 
Péter
