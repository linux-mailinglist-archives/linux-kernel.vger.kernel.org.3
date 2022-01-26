Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536DF49CC10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiAZOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235463AbiAZOP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643206557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBufRetUEaFHPWc7iYpkpHHqiA9eXNXD6Bgulr6vvjA=;
        b=Bnfdfd0+g2Ypa4KEwpzoA5r+nw3mLByfFSMattg/ZqQgKJVPZL2GuFGv9w1rwjxH68dUnD
        mZWcF8LEYxHQahb/GAd6GDvhJaL19QDvV80OBRM1CbPkAR20DPEdwqHiWiM+xv+MdXtcFe
        tp/lJdrCdaKVqukh/VHKhmpo4W/otEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-Q8cQx6rrN5y_m2hGegxCVA-1; Wed, 26 Jan 2022 09:15:55 -0500
X-MC-Unique: Q8cQx6rrN5y_m2hGegxCVA-1
Received: by mail-wr1-f71.google.com with SMTP id g8-20020adfa488000000b001d8e6467fe8so4347517wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TBufRetUEaFHPWc7iYpkpHHqiA9eXNXD6Bgulr6vvjA=;
        b=yLmg2HgY4TvtYNadN9M1uPaUMIL+dgoQPo9x1WSqGEFHCqRaSp+rLPqpRIZGEpo/6A
         Hez1R9XB8Xk9/tjBVmBxO6Iq0YHfjYSxa2yQ+wsiKcaqe00hqnBpvxvd8HpKxgi5lxzs
         qmHMBj9/z/YJDyyxJwpW+69aDdK86+TeRO/DguQg5ZLyK7Rv475E8WBaG0eqGMQKnodS
         GbZZPiqTSV/aMqYt7DyaHRBJq67UGBi2mi65in2wdxtDo122bgFTncBvGrTaSJrRwwcO
         yxn+XAE0/5upQjAflTj49YNXmxtLmF3QAkRqLCGIYTrAKcUWFH4ykY9WoFzSzdFZr2EZ
         dzDg==
X-Gm-Message-State: AOAM533ZiIQUhQU8puFJCj9chlCkGYr97MqCfdz/wqAL6ejBzwaHCtjK
        gflDtwht1IOeIMygvDvHSwyU2oU9msEM29ewOsiqhmsDRBRqtZk4Drd0YYp5qJvs1d4lli9V27l
        0pOwzqs76uxYDGv/UMiL974UM
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr21723792wrp.419.1643206554174;
        Wed, 26 Jan 2022 06:15:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+mct3ymMu2U64GGPDGP0AtbI/8Ig4CtqRTRDC/RwNHy3hYZxdpTXJYSMFcmQfPRXBYMePRg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr21723776wrp.419.1643206553991;
        Wed, 26 Jan 2022 06:15:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 1sm11923387wry.52.2022.01.26.06.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:15:53 -0800 (PST)
Message-ID: <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com>
Date:   Wed, 26 Jan 2022 15:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFWPmG2D093gz4N@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 15:10, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 04:08:32PM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 26, 2022 at 02:46:08PM +0100, Javier Martinez Canillas wrote:
>>> On 1/26/22 14:12, Andy Shevchenko wrote:
> 
> ...
> 
>>> I've just bought a SSD1306 (I2C) based one and will attempt to write a DRM
>>> driver using drivers/staging/fbtft/fb_ssd1306.c as a reference.
>>
>> You should take ssd1307fb.c instead. And basically create a MIPI based driver
>> for I2C. Then we won't go same road again for other similar devices.
> 
> For the record it supports your device:
> 
> static const struct i2c_device_id ssd1307fb_i2c_id[] = {
> { "ssd1305fb", 0 },
> { "ssd1306fb", 0 },
> { "ssd1307fb", 0 },
> { "ssd1309fb", 0 },
> 
> 

Thanks a lot for the pointer. I was only looking at drivers/staging
and didn't check drivers/video. I'll try to convert that one then
once I get the display.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

