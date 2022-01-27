Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0073D49E317
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbiA0NIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241485AbiA0NIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643288923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQyYdiBdtNH1VNsfeubJWuB78VJ2++qYCFEjN1L+z1o=;
        b=REsqJ/sDmKCFT+pO4C3sOOJgNC1DEmOBRb1YtPXgyvcv734ubQnrjV++p2KY2+AHGbvB0M
        uKjYi0/dT57yCtKkJ/TaWn4qP4uv0eNN+b9LIgSz9L5QKVmtibauzlIRNz9WezdUctSqEv
        B7zoZo5t5my5zohTDfmnwnk39hoDUSk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-uY06vfEoMf22pv-FM5_umw-1; Thu, 27 Jan 2022 08:08:42 -0500
X-MC-Unique: uY06vfEoMf22pv-FM5_umw-1
Received: by mail-wr1-f71.google.com with SMTP id x4-20020adfbb44000000b001d83e815683so1060440wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UQyYdiBdtNH1VNsfeubJWuB78VJ2++qYCFEjN1L+z1o=;
        b=GXO1PIRZbGyAy+/wVKkRR5DjXDeskD6tYUgfibUFDtwgJeX66Tler/BET8BADvPctu
         JEnJc2M36syB33o+TV8lwuhCsaLRTjua7dy8GMeDf4aRu4eq6/wtzssjab34qHVS4cCi
         DWnmlx6z9dGZ080VjOFaxINmMaIERdElLFmC7Zdo4WHGK33V0h0bbW5EqzY6W1PUUHGL
         /np+HGb6qO6zROQSoEzWh7TpwzEN/f/6LeeVwulIjQ0xXAyZqZx+xxmzhQOE+5bfsiQN
         cJbBASmD2py6t69KxNj+mIn5JIVOcVE8biu2xMOKyDZco4DXalL36pnptvLTER8KUK8l
         cIBA==
X-Gm-Message-State: AOAM532RRC+vGu/9aqjJAv4NR5MGV/TpbbREHBv9IDio4VxGXlcAInyv
        K3Mtwka9d8WNYFJzskfHwltG+3F/BaUVS0m7ovEVtWWOXZo8JSCXoL1/v5FMIP5d/mjOZzbdus2
        zzJoh0FS72hUvTy5ekHaN55bR
X-Received: by 2002:a5d:4943:: with SMTP id r3mr3001473wrs.130.1643288921379;
        Thu, 27 Jan 2022 05:08:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8QfFcL0XfIO8hOXFedQuXUsgq2JTBDc2xnb6vs395KWwqaCiCCi/yJzVGlZa/jOkdHUHQ0Q==
X-Received: by 2002:a5d:4943:: with SMTP id r3mr3001421wrs.130.1643288920603;
        Thu, 27 Jan 2022 05:08:40 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s9sm2100610wrr.84.2022.01.27.05.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:08:40 -0800 (PST)
Message-ID: <b54d8092-c7bc-93b3-c306-b77dd57db6ce@redhat.com>
Date:   Thu, 27 Jan 2022 14:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/doc: Add section in the introduction page about
 learning material
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pekka Paalanen <pekka.paalanen@collabora.co.uk>
References: <20220127082058.434421-1-javierm@redhat.com>
 <c99a7784-7ac4-e305-1a06-dfb514a409ff@suse.de>
 <b305cb36-1a09-c990-a3e6-98d420c62e3a@redhat.com>
 <YfKCoOk2sxDzHVXv@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfKCoOk2sxDzHVXv@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 12:31, Daniel Vetter wrote:
> On Thu, Jan 27, 2022 at 11:50:30AM +0100, Javier Martinez Canillas wrote:

[snip]

>> Indeed. And we can add such section as a follow-up. Maybe referring to some
>> of the drivers in drivers/gpu/drm/tiny.
> 
> Do we have a talk anywhere for tiny?
>

I couldn't find one for tiny.
 
> Otherwise I think it'd be good to just add a paragraph about "hey tiny
> exists" and maybe link to fbdev helpers and simple pipe helpers to get
> people started with the right entry points for simple drivers.
>

Ok. I can add some sentences about drm/tiny and point out that the DRM
drivers there could be used as a good references for simple drivers.
 
> And make it clear that the above pile of links is more for general
> overview and if you don't yet know what exactly it is you need.
> 

Sure, I'll add that too.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

