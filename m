Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9421347E72C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbhLWRgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhLWRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:36:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D6C06175A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:36:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9402653pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dPYUZWC+77UBrBLBUUxU9fHb6AxVTt9UdaUWIxpei+o=;
        b=L0sjRUzYInvoF3lTrWwfgbrnXNR7T+eXsaPmPTag7OLNZPysAOAy+7D/eWdc8Y8pWa
         ZYd8pC2fEDwzZy3dX8MHG6cokMq+LvNvhyVHt7n4Ot4zwmRwldtutxXO3oyyhccGcTGj
         6HqoZZOHqzyqhn2YiN2yvj0pdcsduMD2RNXRxGoK6VCf9RFwFffI4Bcz668E4CDGnHCe
         W9InkcEY0CD9FxjiRL4s4xROMFQ19FlU2EzPctV1dHFiCYC2qFsXNDzh4+eMW8ZOMg0i
         GvYkYHgDSayVhkayneoGjmk9tIMU7TKP2/FjiXoGEbnsbQKYI7gPlGu5VC6SGmmrwTQd
         Q6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dPYUZWC+77UBrBLBUUxU9fHb6AxVTt9UdaUWIxpei+o=;
        b=DOx73POf5PiXMulDzScndOK/b6lbZdIsheU8USMHHBgSgdU819I9AmNc7F/7yQsuPI
         gamIhouIDQ2uSF6l5fwYVoEK+3Lu75oqERCaPLgo+YBUervSdTlubUxMiqmMMEC3S5HU
         dK7cbKKB2AU0rXPsgpIUEZ/zcakLWi9ed+5NCmLg2KFr9KcMwcmEoZ/FkAPSbV/XYpgK
         4bdasUV8iVzjuqRzw7CY5fhs9ABurC+poLNeyGUfL96cWvL63atxzSKNDUXvUQjK46Gd
         Ahp9OUJhVgaCvF9hlcGQCAp00TFeeNAoG6PZ2+gn9Jd4dn7D88ufkDFsBnKfFYPrBJa2
         uutA==
X-Gm-Message-State: AOAM53200cEs4tSyvUmME8hg9PkUuEuT1Iy0Obbzgvq124BgGg5Eyeyl
        sbWkPBR2SBa2su49gGkEdPMr1w==
X-Google-Smtp-Source: ABdhPJypoRaM/7mbkBhlfvlUN6kGHVEF9KQ22b8kXscmQCQL7JNkF0LVo3y3phgMBogpBLz4jmYGaw==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr3712671pjb.69.1640280983976;
        Thu, 23 Dec 2021 09:36:23 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id g6sm7407727pfj.156.2021.12.23.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 09:36:23 -0800 (PST)
Date:   Thu, 23 Dec 2021 09:36:23 -0800 (PST)
X-Google-Original-Date: Thu, 23 Dec 2021 09:36:07 PST (-0800)
Subject:     Re: [PATCH v2 17/17] MAINTAINERS: update riscv/microchip entry
In-Reply-To: <05d6a273-19f6-2147-75ba-1fff726a0f70@microchip.com>
CC:     krzysztof.kozlowski@canonical.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        geert@linux-m68k.org, bin.meng@windriver.com, heiko@sntech.de,
        Lewis.Hanly@microchip.com, Daire.McNamara@microchip.com,
        Ivan.Griffin@microchip.com, Atish Patra <atishp@rivosinc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-0e4cde83-cfa1-4bf6-9f2c-611d9a4ddb5f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 06:56:45 PST (-0800), Conor.Dooley@microchip.com wrote:
> On 17/12/2021 15:09, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Update the RISC-V/Microchip entry by adding the microchip dts
>>> directory and myself as maintainer
>>>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>   MAINTAINERS | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7a2345ce8521..3b1d6be7bd56 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -16348,8 +16348,10 @@ K:   riscv
>>>
>>>   RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
>>>   M:   Lewis Hanly <lewis.hanly@microchip.com>
>>> +M:   Conor Dooley <conor.dooley@microchip.com>
>>>   L:   linux-riscv@lists.infradead.org
>>>   S:   Supported
>>> +F:   arch/riscv/boot/dts/microchip/
>>>   F:   drivers/mailbox/mailbox-mpfs.c
>>>   F:   drivers/soc/microchip/
>>>   F:   include/soc/microchip/mpfs.h
>>>
>> 
>> Good to have the DTS covered, so FWIW:
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> 
>> You still should get Lewis' ack (unless he merges it)
> Aye, it'll be an ack. We don't currently have a tree & would rather do 
> this via risc-v than the at91/sam arm soc tree.

WFM.  I'll be awaiting the ack.  I don't see any fundamental issues from 
my end, as long is it's got all the acks/reviews then I'm generally fine 
with this sort of stuff.  I'll take a look before merging it, I'm kind 
of buried right now.  Sorry!

>> 
>> Best regards,
>> Krzysztof
>> 
> 
