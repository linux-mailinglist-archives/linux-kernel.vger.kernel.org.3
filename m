Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE34A5329
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiAaXZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbiAaXZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643671502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOB8RYRPIuXt9XuC1duDz579Ebb678cvofpXB4sR8RI=;
        b=Rn23NxkCQunRrrSeTd7hGJhkH7SXnGY7iwt7V0xNmey1Kv1ixB9n6z7ALW1ifSMQkz2dYB
        +P35ftGTE1L2Uu9bO7Yq9Z5QyCgAxlsZhrbavxod2JOyclu64ZvhSB5stg8exvLYCc/EjT
        UM4MKZW64+wja7opxherNr8cI1p5p9k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-joV4nOaaPWKZpLyNl3g8Hw-1; Mon, 31 Jan 2022 18:25:00 -0500
X-MC-Unique: joV4nOaaPWKZpLyNl3g8Hw-1
Received: by mail-wr1-f70.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so5310846wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sOB8RYRPIuXt9XuC1duDz579Ebb678cvofpXB4sR8RI=;
        b=LkbOiiUaPZFAEi+I61MHz9bCYW1KhtBXhY6UYdMp43KticQ76NXprF8k2OYVR6tKkJ
         fg5AjUFB/SYGJnPDS7mfGm1Dv3SOsEDX3QOYHp1PrbkigfGY7S6prg3g4Mm3kBi1xpsg
         HDyglRvV6mAbvp4Ra+xyVOaFFsjYOKpd+SDV7at7gS69zxC/FWBA4W4QR29CJ/efYqY8
         t7JaVMoN3sSwJVfRVTIyZI70xjxerYOUkGOO2nL8dYcu3SmYiiSAr8NeIWCfK60L6KrB
         DUoQ0M56fTOsV8qmClnqRdJi8y1pPG68eoY7MDUHz7HIkUWsi7Zw9F+ezYZq5PTUf+bx
         Zb6A==
X-Gm-Message-State: AOAM531+ISFzIvYxDAzCg3emzUgPrGc/HQkwXDAqb1ieuYCZwF0hJDLo
        apEzXCYS8YLVof5leT+rRf2S5X9OJRSLXB1mu5KYO9rROurmS1RMDAV5CS5TaTbPzTfCvNNu6xO
        6uTjn0NBMdukHj4Y1s1k93xz7
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr20585925wmh.169.1643671499288;
        Mon, 31 Jan 2022 15:24:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXct5Vi006IAsnWX7pGg6l9TgY49Hkt7Zu/EEEoWSUyfvrEDOXAziQ+K8kEvGmrE5W4zQmHQ==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr20585920wmh.169.1643671499121;
        Mon, 31 Jan 2022 15:24:59 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13sm577284wmq.29.2022.01.31.15.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:24:58 -0800 (PST)
Message-ID: <9e9808c0-5a92-b2c3-c1c5-158608f49e6b@redhat.com>
Date:   Tue, 1 Feb 2022 00:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED
 displays DRM driver
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201537.2325487-1-javierm@redhat.com>
 <YfhKrznFzRmDcZa6@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfhKrznFzRmDcZa6@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

Thanks a lot for your feedback.

On 1/31/22 21:46, Sam Ravnborg wrote:
> Hi Javier,
> 
> On Mon, Jan 31, 2022 at 09:15:37PM +0100, Javier Martinez Canillas wrote:
>> To make sure that tools like the get_maintainer.pl script will suggest
>> to Cc me if patches are posted for this driver.
>>
>> Also include the Device Tree binding for the old ssd1307fb fbdev driver
>> since the new DRM driver was made compatible with the existing binding.
> 
> To avoid any confusion add yourself as Maintainer in the
> solomon,ssd1307fb.yaml file too.
>

Agreed. You mentioned in another email though to diverge from the existing
DT binding for ssd1307fb. If we decide to keep the backward compatibility
then I'll add another patch to the set to list myself as a co-maintainer.
 
> With that done:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>

Thanks!
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

