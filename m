Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA53F48C347
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352912AbiALLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352903AbiALLiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641987485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ/OOdpAGgV62HtjD3bMC3/ezB1HxaLvh507CGIQyfE=;
        b=TAbxfQ34m3WVYWhMzXVM+6iXRiVc17q+xmVtrFoLlhAnOGLBvusMCYtuHEX9PZGxSKskiv
        dWhndhIYuaw3OdPPm4yuwsVcao3LZu8fRQh3Zp84V811hoxFmHRHepT9y5FupJHRlL2rIJ
        aUFyIN4S4WIEPpkfR5PD8yxd9TVkywc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-Sb9XDJvCM52PuWAtlMMb6w-1; Wed, 12 Jan 2022 06:38:04 -0500
X-MC-Unique: Sb9XDJvCM52PuWAtlMMb6w-1
Received: by mail-wm1-f71.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso1422730wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZ/OOdpAGgV62HtjD3bMC3/ezB1HxaLvh507CGIQyfE=;
        b=f6Eqo2FSjuqvnGsw02iQqK0j2AqbvZ8lLgnoDx0kATnBg7z0NSA/Qt9vRE64hazTxB
         +9N+jfFdNe38N8GU7VSF20h5TK7dIwmCOHfdaDlwSZYUdEpMdw8HdwqQwwxhTQuBi+8y
         GxKxxUamuEOqWaKtFrpSQz+ug0a2gGwY29pmsEWvFMFEr0XS1yxWeUlhvofF+ckLBEZQ
         o7v/f2lhFxzrAqHvbCDjzJb0GIVGnlj5IfaRf/UQfjlmPl3OIUdfb9SiJ+so5RKe+fe7
         Zy58bGamvaB6e1yGXtWcFCbtrxqmsWuZctTMcsaHKACFUUuh6beadVDTwWjV+k9pzzPH
         lMBQ==
X-Gm-Message-State: AOAM533wjR2xXUFpSF2pBfSaZJLMcdUP8jg0AfibhMqdVofuVrCRj1Oz
        IyphVDPkDHgqZR7SRJEYHpSmphTr7lhU21ySzkcSnz7Xdh18nrPbgRKPWHoY6bwNKgiuYr+Ybk1
        JXxf8q2bCg65PqzYyP5HG7zPs
X-Received: by 2002:a05:600c:3b19:: with SMTP id m25mr6332968wms.100.1641987482741;
        Wed, 12 Jan 2022 03:38:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCMtCBYnaCQK1iXFn85zR/lqJOVMZxN9oUrlR9Ead1HQenjTkkrnQCGumLIh+enmiNou0HhQ==
X-Received: by 2002:a05:600c:3b19:: with SMTP id m25mr6332946wms.100.1641987482542;
        Wed, 12 Jan 2022 03:38:02 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d16sm8380854wrq.27.2022.01.12.03.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:38:02 -0800 (PST)
Message-ID: <2155e11e-beec-f896-0ab5-d48bb860f335@redhat.com>
Date:   Wed, 12 Jan 2022 12:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/2] video: A couple of fixes for the vga16fb driver
Content-Language: en-US
To:     "Kris Karas (Bug reporting)" <bugs-a21@moonlit-rail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220110095625.278836-1-javierm@redhat.com>
 <65a13d92-93fc-25d2-0009-b7e60f3392c4@moonlit-rail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <65a13d92-93fc-25d2-0009-b7e60f3392c4@moonlit-rail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kris,

On 1/12/22 03:19, Kris Karas (Bug reporting) wrote:
> Hi Javier, Geert, et al,
> 
> Javier Martinez Canillas wrote:
>> Changes in v2:
>> - Make the change only for x86 (Geert Uytterhoeven)
>> - Only check the suppported video mode for x86 (Geert Uytterhoeven).
> 
> I just updated Bug 215001 to reflect that I have tested this new, V2 
> patch against 4 systems, one more than last time - 2 BIOS/VGAC and 2 
> UEFI - and it works perfectly on all four.
> 
> Thanks, Javier, for the excellent work!
> I didn't test with non-X86, but the code appears to bypass the patch on 
> non-X86, so should work fine for Geert.
> 
> Kris
> 
> Tested-By: Kris Karas <bugs-a21@moonlit-rail.com>
>

Thanks a lot for testing again!

I've applied patch #1 to drm-misc-next and #2 to drm-misc-fixes.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

