Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64574467AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381917AbhLCQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhLCQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:01:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C1C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:58:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o13so6603052wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=ws1r6luiKcFLGmHQC5MDCjqpZbp9tkgkP1274bUaIqI=;
        b=mFH6sAT74XBZpwpRsrazCgeKuR+w0HKUbHU339AyglhpjbFAtrr2MpWPRW3o4vYTgE
         5NNR8yknW97iI+ayHGDRva6uFly5IwNUbh2+UBtB/Bc/aG7F2plZdb77b/9iSargagRD
         Pvmh5qAEN6OEdnGCiWmMd8qc6o3eySTNgN0i4zxrpCBUpF4MXQkxXgVBpxUVtAfpbzQJ
         ZxyvKh1jokMepLFzRzOSUhmJsKV9MVqy3IbPs89ff4PrJxHxuSLOdom/7P5nwT5yVylX
         GwZBYAZ4nVsxArMh0zBnzhzrp9isgnKGCmdBZqBLGwLC22EG6/ACgocu3pVt+hoJJmNv
         OeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=ws1r6luiKcFLGmHQC5MDCjqpZbp9tkgkP1274bUaIqI=;
        b=2YK4j1g61DOLYZc3AIgatyN2N+jrr1JnWRFxiP4lZPvd9r0lfdnXh5IomnLpSt1aqO
         IolygasAew7jjwfTWfs7KOQ8h5nIPe7GCqSOcENNfMqIR/P0zIcp0hgsV4lGMuamiDlP
         hiS+BOWt3F1lwzpekQsUf9cYYRefUdf4fGYR3tXZQi20ZaJ11pfM2OLldAVfj/74ZtJX
         GvCOqy71r1dW/kooJgniTWEyElyQFYgnyFmWHZpkmGvaUL3TqGRzUv38ryvx93qS5oFg
         hdOonQzcUL3i6hMrHwGFxJGKjRDUyh7p6TUwEodORfSHTnf+vJ//wzHOlgsyMuzDg1yX
         Szng==
X-Gm-Message-State: AOAM5329u+0M/padgKmewFeH3io7HFGiKW3AB9zKdMrs1mniYm0ykaEP
        BlCbkXwGd8hIsPKjHMXRpzc=
X-Google-Smtp-Source: ABdhPJx9c2tj3IZsUkjwbdvjCpvJizQK/Uv5qccGFVRnfb5Xwoc0YO5mQChU8gdeUwfda+nlsE8QbA==
X-Received: by 2002:a5d:40c8:: with SMTP id b8mr22407962wrq.610.1638547092871;
        Fri, 03 Dec 2021 07:58:12 -0800 (PST)
Received: from [192.168.0.23] (static-66-219-86-188.ipcom.comunitel.net. [188.86.219.66])
        by smtp.gmail.com with ESMTPSA id s24sm2770012wmj.26.2021.12.03.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 07:58:12 -0800 (PST)
Message-ID: <392a239a-14da-c544-a1f9-09d8b25d3e07@gmail.com>
Date:   Fri, 3 Dec 2021 16:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Mark Yacoub <markyacoub@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     seanpaul@chromium.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, jason-jh.lin@mediatek.com,
        tzungbi@google.com, Mark Yacoub <markyacoub@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20211202151200.3125685-1-markyacoub@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm: send vblank event with the attached sequence rather
 than current
In-Reply-To: <20211202151200.3125685-1-markyacoub@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 02/12/2021 16:11, Mark Yacoub wrote:
> From: Mark Yacoub <markyacoub@google.com>
> 

please make sure to add the linux-mediatek mailinglist in any follow-up 
communication.

Regards,
Matthias

> [Why]
> drm_handle_vblank_events loops over vblank_event_list to send any event
> that is current or has passed.
> More than 1 event could be pending with past sequence time that need to
> be send. This can be a side effect of drivers without hardware vblank
> counter and they depend on the difference in the timestamps and the
> frame/field duration calculated in drm_update_vblank_count. This can
> lead to 1 vblirq being ignored due to very small diff, resulting in a
> subsequent vblank with 2 pending vblank events to be sent, each with a
> unique sequence expected by user space.
> 
> [How]
> Send each pending vblank event with the sequence it's waiting on instead
> of assigning the current sequence to all of them.
> 
> Fixes igt@kms_flip "Unexpected frame sequence"
> Tested on Jacuzzi (MT8183)
> 
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>   drivers/gpu/drm/drm_vblank.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 3417e1ac79185..47da8056abc14 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1902,7 +1902,7 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
>   
>   		list_del(&e->base.link);
>   		drm_vblank_put(dev, pipe);
> -		send_vblank_event(dev, e, seq, now);
> +		send_vblank_event(dev, e, e->sequence, now);
>   	}
>   
>   	if (crtc && crtc->funcs->get_vblank_timestamp)
> 
