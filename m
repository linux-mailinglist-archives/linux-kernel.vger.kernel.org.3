Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4814497DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiAXL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237337AbiAXL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643023737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iCk2MqV068ik47++TkY622krHol54JciUgHuKaQzhoA=;
        b=K9NaK3jsssWUNBL2Ernpu++vVkSB1jlXtBgBqbqD4R4dMGNCF56VdJWn4TFGc3Zh1lbUui
        t6rTIaZMtbmx8rcAh5/S4e3cueYcybgOrk++DR19+IkJd3Ixf/ocqIKg5yuGDL2pm85jbd
        cEtwcaZxoDDeOQQQ7QQZtGbIhAFK2aU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-KTdxz5YMOL26qVflCzf5Pg-1; Mon, 24 Jan 2022 06:28:56 -0500
X-MC-Unique: KTdxz5YMOL26qVflCzf5Pg-1
Received: by mail-wm1-f70.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso10545518wmb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iCk2MqV068ik47++TkY622krHol54JciUgHuKaQzhoA=;
        b=la43A763Zb1L+PtgQlPtAe8Fx5UFlphU1mh7mBANwssjOItE5MSe1NnCbSYVIVkP6n
         Ayxobnnrda+LrG1xU1cnuMFx508TIyfghanznpxCIapn76MZCEgWjUx+cfuPjA+Qe6m2
         k2nf4DX0aY1NHA+5MasFLCnvl+Dyl1vHnycebOLzl0I94fpFoHEeyHAOCn8bgeANsAsT
         6IJzJ9L6IaKu2aawAxwqtXTt9Z7S8ijzpVoL0B9nsHeZPsbFxsvVhvEpjs4OLH3ZBZsS
         TTO2UhHyBsCpFX/tYTO4v1Oyt4aVTuA29hLzdLbj4uYGmJUEsJnOLHndVBlnYV88u1Ng
         8nHw==
X-Gm-Message-State: AOAM532CSkub0gcF8RNafnT1vOGWwsscPSyNfOKM3SRFq4zc7Zm2OSf1
        X4abmtJbG7oulB7cCtL3bs2fJKBWeP+63OmWjjDnAqa7rQ5Bc2qIaKaOjuVdKEYtJznwlV2tFKm
        HpwstGOjqHrje1kW5RUX4pQ1r
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr13889240wrb.268.1643023734925;
        Mon, 24 Jan 2022 03:28:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0+gCfn6OAv6eptFf7BhcWyYygRydFAGPWQjZmowvpEyj4P+Ozcyhp0AQ6GAk5Vk1kRhCA/w==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr13889227wrb.268.1643023734752;
        Mon, 24 Jan 2022 03:28:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w22sm248487wra.59.2022.01.24.03.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 03:28:54 -0800 (PST)
Message-ID: <66991d85-012c-855d-0799-35d85f92326f@redhat.com>
Date:   Mon, 24 Jan 2022 12:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
 <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> 
> What about this proposal:
> a) adding a Kconfig option like:
>    CONFIG_FB_DRIVERS - enable if you need the fbdev drivers. For DRM-only this should be disabled.
> b) Add to every native fbdev driver a "depends on FB_DRIVERS" in the Kconfig files.
> c) That way we can use "#if defined(CONFIG_FB_DRIVERS).." to exclude code in fbcon which
>    isn't needed by DRM.
>

I proposed something similar in:

https://lore.kernel.org/lkml/20210827100027.1577561-1-javierm@redhat.com/t/

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

