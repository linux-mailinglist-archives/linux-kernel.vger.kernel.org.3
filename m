Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1F4A6DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245449AbiBBJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiBBJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:24:29 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB27C061714;
        Wed,  2 Feb 2022 01:24:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t9so27924423lji.12;
        Wed, 02 Feb 2022 01:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k7rKG9vK8KAeckLEPJ3xDWbNcURPWfZL8ylGLwhBET4=;
        b=c61SCeWHdR4QIvDSi9hI9zd0gXzT4pY/4ivMXBib+r+2LbNMWmk1ahE2KAXI3uZjuG
         Xli6xPBTF9HogWNEKb+aHgOZhADHUjOKv9dc2ZPVABEU401Z5eJiN8I5Blhk7mjutx3O
         uxEtnrM4mIpGxf+vKoSQ+ThCT0BbqTidm+/oIyqMawcjq2jTJ/r806kKZRyGxl9VFGfA
         obWB+heoMYvfZUwwffuqJhvEEDOgjBW5tG1bfeofccq3++M1R0u95DebosvNA6UJ9Bqh
         hYWRTlwDxcKEkL3MQQKr2ODhdTEomo7pgHHH+xs3ZPzFkOJQ/lzCOKh3XbuxDV2Dc7h3
         dEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k7rKG9vK8KAeckLEPJ3xDWbNcURPWfZL8ylGLwhBET4=;
        b=cXdp0daq+8HIvfFn0lh7aqX0RMb+zTwSsWdmG7yD0pARX7piWH8v0J+me7wxp6TMnT
         FZdYxhOyvcBMwWxfz2syLkmnKO8f6umhBoidjmnMmhEqEgz0OW+ENOImFtbi+ysLTaMw
         4R+30TWlm4ohHmgMjieN+26Qjgf0+RgWXRJWCCEJJgFhcJ6QYQp1ryoeBHMITwezNfro
         9B822ZQGGwKJDh44NXEXMYbhBn2B6dFsrooSBJhSPNRciiqpgXOlK4ASDUjjJc3+7tWQ
         gnhd8DMHlC1Gs3/js8zKttjwFGGsBRRM/1JqeeqiP5bZBBx1GVZGhnYOugMYbeOEmmxQ
         XVWA==
X-Gm-Message-State: AOAM532ylguP6X2JclxsmPLkPDJlVRwg9CfnQ/SLzC/WzffRiwjjYmEv
        3sueQxvMMhaBAwVDJq9YYp7oLI79oRw=
X-Google-Smtp-Source: ABdhPJzOEn6nF9mbFXLIjyrz5p5pQGIfuN2KJkvLL07omtZP0xzY/qGMmjItUuPscJrKnQydwmWtng==
X-Received: by 2002:a2e:b988:: with SMTP id p8mr9001583ljp.435.1643793866661;
        Wed, 02 Feb 2022 01:24:26 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.208])
        by smtp.gmail.com with ESMTPSA id f19sm2424170lfa.52.2022.02.02.01.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 01:24:26 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220129204004.1009571-1-clabbe@baylibre.com>
 <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
 <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
 <bc80cd49-c95e-6b9a-1210-7d3832766b02@gmail.com>
 <5a1d66d3-d3c2-ab77-f874-c3d6b10a0d2b@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <d16a1be7-d856-f6b7-5a1a-9f09f42195ee@gmail.com>
Date:   Wed, 2 Feb 2022 12:24:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5a1d66d3-d3c2-ab77-f874-c3d6b10a0d2b@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 1:56 AM, Damien Le Moal wrote:

>>>> Thanks for doing this Corentin!
>>>>
>>>> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>>>>
>>>>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>>>>
>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
>>>> this patch when he feels it looks good.
>>>
>>> What do you mean ? I am doing my best here to maintain ata !
>>> But I definitely do not have all the hardware supported for testing :)
>>
>>    I can probably help reviewing the PATA drivers if you want, just like Bart Z. did.
>> But I don't have much of the PATA hardware (what I have is in my old PCs I haven't
>> booted in a long while)...
> 
> More reviews are always welcome ! Thanks !

   How about me submitting an "official" PATA reviewer entry in MAINTAINERS?

[...]

MBR, Sergey
