Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812B4A3F80
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbiAaJpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:45:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241929AbiAaJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643622349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS/uqP/Od1Nlu6Xgt3P/am5tNhPsIAozU+ROOQPNswY=;
        b=jDkqT5e51+M22iUPbXZrbIvBpMNsAC1etlOuHh3uvJkN+Gh5wjZHPSc9oteYz5C9BP6I9U
        5SxgE4sQ+0UcSxhpW2A18IvA4+IazFO4/+HXpJPiKLdkpYHBGDPeBdmnJvj+77uOx54iby
        IdmJz9+QHeZoMyVCwt8uiQU698UbYc0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-T_ZKkpZ0MVaX-36-NXQAng-1; Mon, 31 Jan 2022 04:45:48 -0500
X-MC-Unique: T_ZKkpZ0MVaX-36-NXQAng-1
Received: by mail-ej1-f72.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso4739404ejc.21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 01:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MS/uqP/Od1Nlu6Xgt3P/am5tNhPsIAozU+ROOQPNswY=;
        b=A20wVzd/TZXgKlB8vSx2c54C3+LZIA57kMzjkcNwnsHDPIN+sCjqnr06/sfFZ56W7t
         sOmrM7AFLEtdS51zf1IaTCtYaOrnrUyNViNDk3qqFF3eGabqAIZxxvJ8w64mOzKaX+fH
         dNUfX2/66XcxD6Vnf5rXGOWFspw4LI3cAg7IEEISR4tyqlJ7UQF3HOOPdL2LyLu1wV5z
         lXJwY1MKw4mV6IW3c/Wwefzewhu+1g4MlwaF3t0cvR5Zil6z2lNJTGi2+milGa+CJMzV
         tiZ3sJ+n4UvlESly8J/KOPdXhtQP1DFtojfg54U/3pUrbSMRCYOkqwxbJu0u6C/FH7Fg
         dn5A==
X-Gm-Message-State: AOAM5326VDAiWCe7Sa76q/MBdvLtBFMg6C1hF+eoPv1q11yIw7F7RChY
        KzusFfCZ2wVVpK+zM1j7afoRlicwGZaFV+0YaqNfuhGGnxRNcNXtlq53lCrmcXGV7QmJyv1Mq9t
        p5xXF1zsm1ZkyODY3LQx6He1y
X-Received: by 2002:a17:906:4789:: with SMTP id cw9mr16417611ejc.250.1643622347054;
        Mon, 31 Jan 2022 01:45:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/EY6ZaH5hwm0kmvPneK0n45X4YN/TXoMl7+aRZg1eI1bhcDIZTx2UL87/mgth0TSdDZhAWw==
X-Received: by 2002:a17:906:4789:: with SMTP id cw9mr16417600ejc.250.1643622346875;
        Mon, 31 Jan 2022 01:45:46 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b16sm13263370eja.211.2022.01.31.01.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:45:46 -0800 (PST)
Message-ID: <f5a96b96-d9e2-2381-3673-632ae85c8b24@redhat.com>
Date:   Mon, 31 Jan 2022 10:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 0/4] hwmon: (sch56xx) Automatically load on
 supported hardware
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220131093756.8075-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220131093756.8075-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 1/31/22 10:37, Armin Wolf wrote:
> The hardware monitoring solutions supported by the sch5627 and
> sch5636 drivers are Fujitsu-specific.
> After some online searching, i found out that the solution used
> with the SCH5627 is called "Antiope" by Fujitsu, just like the
> "Theseus" solution inside the SCH5636.
> I also found out that "Antiope" and "Theseus" are listed as
> DMI onboard devices on supported Fujitsu devices, so the
> sch56xx_common module can be loaded automatically an check
> for the DMI devices. However some devices like the Esprimo C700
> have both devices, so after verifying that at least one onboard
> device is present, sch56xx_common still has to detect which chip
> is present.
> This is safe however if at least one device is present.
> 
> Tested on a Fujitsu Esprimo P720.
> 
> Armin Wolf (4):
>   hwmon: (sch56xx) Autoload modules on platform device creation
>   hwmon: (sch56xx-common) Add automatic module loading on supported
>     devices
>   hwmon: (sch56xx-common) Replace msleep() with usleep_range()
>   hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING

Not sure why you did a resend? I received the original just fine ?

With that said the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

> 
>  drivers/hwmon/sch5627.c        |  9 +++++++
>  drivers/hwmon/sch5636.c        |  9 +++++++
>  drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++++++----
>  3 files changed, 58 insertions(+), 4 deletions(-)
> 
> --
> 2.30.2
> 

