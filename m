Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1904764E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhLOVuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhLOVup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639605044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGR9lVOCYBcFzYHb4uDLfPBm6adD4t2ujSbcqbcS7Vg=;
        b=fWuH3PNhTBrJ+McEHha1jHZ7xgaD49NWlk6XmRHc7xp9BnVzdKUVauqfn0gVwnWuv0QUHY
        ol4bk9sXI+Y3WnpU0h1dPEcA/oBLiGtR1pchrXCGm0hr9hptSJP0x78cHtEUZIwiyt214A
        jmNPpmSRxDJTDBQRytG8m5v5L2Q8nYY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-Tl3q560IN-iAyOdghPTbsQ-1; Wed, 15 Dec 2021 16:50:43 -0500
X-MC-Unique: Tl3q560IN-iAyOdghPTbsQ-1
Received: by mail-wm1-f70.google.com with SMTP id v23-20020a05600c215700b0034566adb612so1490407wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wGR9lVOCYBcFzYHb4uDLfPBm6adD4t2ujSbcqbcS7Vg=;
        b=Ge9U99//hbLXyX462hnGUqryti2K626wSy6eHcdS+IHI306BU26KRLjn306668lnv2
         S2ewjg3mLjaGeJqWsesFhCasd7bhlw6jUFIU2WJ+gGkGihLylhYsULDw8p2u4dAVkV/Y
         uM2kIpq5Be+IpAEwVP3RO76XT/21/acE9r2cmmO2h3sJNWMVLRhhRTT8Jgj6+kDc14fI
         vb/D/d0t2Qx2yT/4gXvTUdFO+nJo3qStaf6jBYJNtgJYVSJbQQWLYmAMgOQlpMfxyxKJ
         JBaxUFSBcQCb0Gwz3/skpJMiyAzJkRi2OaheHQZh+oHXh8rjt5sFvSXmPDCRxOdANDhp
         ClgA==
X-Gm-Message-State: AOAM533WTeF8kk+ciMAzugERINnZ0axSvVZUm65UVl4jK/CSjRtiONno
        qO3qbXAVNCgno4xQaPy+jPNhan5ZFwIn6rqtMjR/e1+umZQz+Upt7YEHV/k8Pd6VpGBTYF9SZND
        xJOxlPHzF+SWPXMIQ+EJzQeku
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr6450769wrn.82.1639605041880;
        Wed, 15 Dec 2021 13:50:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztn757VovvfR4KWm4Z3CccDgWA1jc8DERSH/B4nyn/TmIpahQdg4Sb1c3A9FuWw9em2KDNzA==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr6450754wrn.82.1639605041636;
        Wed, 15 Dec 2021 13:50:41 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c12sm3557301wrr.108.2021.12.15.13.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 13:50:41 -0800 (PST)
Message-ID: <55881b86-6130-7737-b6f8-44e1853e419a@redhat.com>
Date:   Wed, 15 Dec 2021 22:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 11/60] drm/gud: Add support for the nomodeset kernel
 parameter
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20211215010008.2545520-1-javierm@redhat.com>
 <20211215010008.2545520-12-javierm@redhat.com>
 <5b1d9578-1f74-a808-c4d4-6e8c38dd57fc@tronnes.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <5b1d9578-1f74-a808-c4d4-6e8c38dd57fc@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Noralf,

On 12/15/21 22:37, Noralf Trønnes wrote:
> 
> 
> Den 15.12.2021 01.59, skrev Javier Martinez Canillas:
>> According to disable Documentation/admin-guide/kernel-parameters.txt, this
>> parameter can be used to disable kernel modesetting.
>>
>> DRM drivers will not perform display-mode changes or accelerated rendering
>> and only the systewm system framebuffer will be available if it was set-up.
>>
>> But only a few DRM drivers currently check for nomodeset, make this driver
>> to also support the command line parameter.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
> 
> I don't understand why this is applicable to USB drivers, there's no way
> the firmware can setup a framebuffer and continue pushing pixels over
> USB when Linux has been given control over the USB bus?
> 
> The same argument goes for the SPI drivers in drm/tiny/ as well.
> 

That's a very good point. I included these mostly for consistency but if it's
OK for the KMS drivers to just ignore the "nomodeset" parameter, I could drop
all that are not for devices in the PCI or platform buses.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

