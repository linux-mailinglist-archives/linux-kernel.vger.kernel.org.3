Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870BD48B770
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiAKTiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiAKTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:38:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E0CC06173F;
        Tue, 11 Jan 2022 11:38:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g11so391536lfu.2;
        Tue, 11 Jan 2022 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=gCA03Y8txjZiDgmmkgC6vSFKPvusDQ96DqTHZL4jtHk=;
        b=FZMSntPkSIzKrqITY9rAON0lmZYT/THkwcu2kSIZzsmU84vXUvnzLa2SFJA72IfETY
         MTgCbXLIbwaNrhSG2AKYlDzxlQ1n4zobcbJ/M1Ju05R5ScvkiQnOhkxcd4boBc1JHypt
         cgRIOJse4I07nEnsaZxBonFSnjCj6D3oe2E31JXK2a7X9oKvhUuqMkvqIrf+xqY1MbgD
         Ie9x520HIONwTpEKJUAzBvsd+HOu2KaGJ4FQHcaSnEA0/t2pIi/Ds4UMu6Mu9+wZ1X6w
         jNixV38ZnCM0PTyhuh5TFuZurIdJI4RJIsgzvL0qBkbQY+rtTS05a8UTgZ5cqe/GBLzv
         liwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=gCA03Y8txjZiDgmmkgC6vSFKPvusDQ96DqTHZL4jtHk=;
        b=ulR0Ehpowy+Fgxj61QxPmOkMIdnsAf9ud0YrpN0Ncfs0ADP+T8CK2M340FeUs6cR4T
         egnmRjT4h/UVQ50VJEFbVHAkqc8EcN2GYC5x+dCnND7aPGFer8YwetAjB29uXB6c8Re5
         xRjzMmaiBjLJrIzTpZpH03r2GsNRPokPYDUV7r4RSeNWh7AEjm2dGhrjjQRqO2ItRyv9
         iHGsSxCHWxPSEBYSN6zm0S+0+zzYKFiPjr7zYQh8eFMoGzuQ+LXt4yUx4gVkSdFFCT01
         jXdHcMJ8AcbT1Dbnt4R+/6GmTPcDVAO+JS6bDnthuRQycS/hu1JzMJC3ICFTTSy/LfkT
         j8nw==
X-Gm-Message-State: AOAM530SHf/qs6weLau1NGts9x7sMffVxGus+voR7d2PomFxf8sGPBXb
        m0kxzZ/7WLXRDOA1MhBw1Sg=
X-Google-Smtp-Source: ABdhPJxuTBO7wEiTLvI+W/Xa1On/i+omE0wFswDUMxG8C6QIYgu8MpzMsLxU+w7zBoxbOx2/u4wQSA==
X-Received: by 2002:a2e:9ec7:: with SMTP id h7mr292524ljk.394.1641929899202;
        Tue, 11 Jan 2022 11:38:19 -0800 (PST)
Received: from [10.0.0.42] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id i16sm1427429lfe.273.2022.01.11.11.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:38:18 -0800 (PST)
Message-ID: <83c51ee4-ac10-0e44-d1cc-f69cebcbf0b8@gmail.com>
Date:   Tue, 11 Jan 2022 21:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220103074427.4233-1-j-choudhary@ti.com>
 <2cf3c89c-169f-3421-25d4-c80a6c9737ae@gmail.com>
In-Reply-To: <2cf3c89c-169f-3421-25d4-c80a6c9737ae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/22 21:21, Péter Ujfalusi wrote:
> Hi Javesh,
> 
> On 03/01/2022 09:44, Jayesh Choudhary wrote:
>> Convert the bindings for McASP controllers for TI SOCs from txt
>> to YAML schema.
>>
>> Adds additional properties 'clocks', 'clock-names', 'power-domains',
>> '#sound-dai-cells' and 'port' which were missing from the txt file.
>> Removes properties 'sram-size-playback' and 'sram-size-capture'
>> since they are not used.
>> Adds 'dmas' and 'dma-names' in the example which were missing from
>> the txt file.
>> Changes 'interrupts' and 'interrupt-names' from optional to
>> required properties.
>> Changes 'op-modes', 'serial-dir' to optional properties as they are
>> not needed if the McASP is used only as GPIO.
>> Changes 'tdm-slots' to required property only for I2S operation mode.
>>
>> Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
>> INSTRUMENTS ASoC DRIVERS'
> 
> I would have added description for the GPIO support as it is not obvious
> that 2 is going to be for AXR2 or 29 is for ACLKR pin.
> But I don't think this functionality is going to be used apart from the
> one dra7 evm.
> 
> Thank you for the updates and the nice work!
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> 
...

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,dm646x-mcasp-audio
>> +      - ti,da830-mcasp-audio
>> +      - ti,am33xx-mcasp-audio
>> +      - ti,dra7-mcasp-audio
>> +      - ti,omap4-mcasp-audio

This is the only thing which bugs me: the pointless '-audio' postfix for
the compatible string...

-- 
Péter
