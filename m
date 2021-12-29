Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3272D481413
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhL2OZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbhL2OZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:25:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 06:25:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i22so44722352wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=pjYlN3fQUyrH1Y9l7SaP7OpdaDMi9fBO087bmleGSU4=;
        b=GSevx4zkS/+CEXR2sk7lq4+NtIdwxyoKz9q3GYUNVIVl3l8gbxqoytPK22pk48b6mg
         AIpyTkdwFB0yYaIP/Q8TtWjRHRVZrjipQxTKmXV5+PypzaROMykKjfQ/IOvZiIkpiyU3
         q96AgIQuXqMrhbOF/bdUrJ7H+iyh1ZoGdFfn4XMg14YveEMckhjcF3jrGTagYezvcR30
         VEMss+0o+ZBg7BUF3fGr/GA8AqrLy42P09fpBaxLWKDMsIW+d2dQq7UmtZoCt4XWU5pz
         l7nhPCccebnqFZNUuWUOYiNJYnSEzFNt8vWouIaDAsDkRlzUkjFSdqRcMA6+MmrJu3JE
         DJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=pjYlN3fQUyrH1Y9l7SaP7OpdaDMi9fBO087bmleGSU4=;
        b=3SucBQvruzni7GLklta2bzUuOguOWJ+3b4V0VzMffuWIL0dHKu4iFQObna8xBSkXFN
         7lcLCb98cu2YBmdmkPKXMj+zKOZFYYhwYLFVrlP9QfLJxRBBifX7SGg6Ng97rCVOnJhg
         KitGKfQFUYQIPrXbyXfmi1HCtUdiajBdVXI1K4AYhFnct0aNxrUYReM1SVt+mSuL5YD2
         xCYj2q++EOjDv3LxmETFUsY6O9ecgiPG983GI6QYuDGBDatOyXwPEXDObVv97bt7QPlo
         NDjwhyPmoTA3EsnXRjjoqNph7wGYfZ0gRt48oaxNXvtmJ6MNaakCKbl+WPNU6b5B0Qlz
         SJ+w==
X-Gm-Message-State: AOAM5324VKQYW2uw55X8G8d0wKCTO8VHcPgGI0q4LLyuffxGxkisgNlf
        4fG1qwMeBaOMf/8ZxSKT0OI=
X-Google-Smtp-Source: ABdhPJzRBdhVxtUXyHCJ8VRyq/aXdrpUZj7KVHcKANKeZLNwqwpB+e7BrOt6XxS6LvatplTbKaNPBA==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr20891999wry.84.1640787927628;
        Wed, 29 Dec 2021 06:25:27 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id l2sm21664851wrs.43.2021.12.29.06.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 06:25:27 -0800 (PST)
Message-ID: <363ed3cd-2a08-26a0-31e3-2ee4d01f71c3@gmail.com>
Date:   Wed, 29 Dec 2021 15:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     miles.chen@mediatek.com
Cc:     airlied@linux.ie, chunkuang.hu@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de
References: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
 <20211229030405.4338-1-miles.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix unused-but-set variable warning
In-Reply-To: <20211229030405.4338-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/12/2021 04:04, miles.chen@mediatek.com wrote:
> Hi,
> 
> On 28/12/2021 10:25, Miles Chen wrote:
>> Fix unused-but-set variable warning:
>>> drivers/gpu/drm/mediatek/mtk_cec.c:85:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
>>>
>>
>> Actually we ignore the value passed to mtk_cec_mask. In case of
>> mtk_cec_mask(cec, CEC_CKGEN, 0 | CEC_32K_PDN, PDN | CEC_32K_PDN);
>>
>>
>> We are not setting CEC_32K_PDN. I wonder which side effect will it have to set
>> that bit.
> 
> I am confused about "not setting CEC_32K_PDN" part,
> in case mtk_cec_mask(cec, CEC_CKGEN, 0 | CEC_32K_PDN, PDN | CEC_32K_PDN);
> CEC_32K_PDN (BIT(19)) is set.
> 
> for exmaple:
> CEC_32K_PDN is BIT(19)
> PDN is BIT(16)
> say tmp = 0xffffffff;

You mean reading the register returns 0xffffffff, correct?

> 
> mask = PDN | CEC_32K_PDN;

mask = 0x48000

> val = 0 | CEC_32K_PDN;

val = 0x40000

> 
> tmp = fff6ffff, mask = 90000
> val = 80000, tmp = fffeffff
> 
> u32 tmp = readl(cec->regs + offset) & ~mask; // tmp = fff6ffff

tmp = 0xffffffff & ~(0x48000) // tmp = 0xffb7ffff

> tmp |= val & mask; // tmp = fffeffff

tmp |= 0x40000 & 0x48000 // tmp = 0xff7fffff

> writel(val, cec->regs + offset); // val = 80000, tmp = fffeffff

val = 0x40000, tmp = 0xff7fffff

> 
> in both val and tmp case, CEC_32K_PDN is set.
> 

You are right, in both cases the bit is set, but the funciton does not do what 
it is supposed to do.

With you fix:
With the mask we define bits that
a) are set to zero if not present in val
b) set to one, when part of val, independent of what the value was in the 
register read.

mtk_cec_mask(cec, CEC_CKGEN, 0 | CEC_32K_PDN, PDN | CEC_32K_PDN);


Will set CEC_32K_PDN to one and clear PDN in the register.

mtk_cec_mask(cec, RX_GEN_WD, 0, HDMI_PORD_INT_32K_CLR | RX_INT_32K_CLR |
  HDMI_HTPLG_INT_32K_CLR | HDMI_PORD_INT_32K_EN |
  RX_INT_32K_EN | HDMI_HTPLG_INT_32K_EN);

Will just clear all bits of the mask.

Without your patch, we will just write the val to the register and don't care 
what the register value was before that.

We should somehow mention that in the commit message, as it's not only about a 
not used variable, it actually has an influence on the value we write(-back) to 
the register.

Regards,
Matthias

>> Anyway, if it's the right thing to do, we should add:
>>
>> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> 
> I will add the Fixes tag, thanks.
> 
