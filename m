Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AF4A5B59
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiBALlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233560AbiBALlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643715660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7n48rOVqWezIHqWx+2qepywQmYqWs41wlRyqhhm8ye8=;
        b=FOMXSp36NRAkjC4bAljQYIZl0j1AkpcxoXIeTDkWn5hQ8tMueoWZiX6HmnQzJHrVSvgyuU
        dkbn9WoDJ6OZpKCjRS3kwAx8gvFQ/JP/OYy0tqJ83CcqySmYPQ1IZbiAjKMu9A7+0NMdQb
        uqu/3sXzsHAtblDeBlakVHpRXfKh9Z0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-D2576zIXM3mY6l-dUfMqLQ-1; Tue, 01 Feb 2022 06:40:59 -0500
X-MC-Unique: D2576zIXM3mY6l-dUfMqLQ-1
Received: by mail-wr1-f71.google.com with SMTP id t14-20020adfa2ce000000b001e1ad2deb3dso772328wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7n48rOVqWezIHqWx+2qepywQmYqWs41wlRyqhhm8ye8=;
        b=wc7GE7cWGbDgZfinnDU70Vgi232rB5H5lcZjIBTQ0UI4XuK6IlFUVQ6+6VA18ES/zf
         KZ9ciS1pWW5KbmFT8ecnfXXdwzQ33UKKhKpR+ZE8IHQxHYqdxSuEHFjEGFMDC4oPoFbN
         4yRwjvre+xBl+TXj/5LPJH/k8vojy8XNvZvp991DtPYGoIXC3pJtYpLIlC1e88/nyqGS
         QFUn9bdGQAC2HLFICYf7bgxEVdpyzsHzSLlOUbYt50MDUGq8BwRGeU7/LEdu026JY2+5
         6nwF8s3HgidVqvKhRXM+r4SbdqssiB/tjdjjq9rDdcm2ps6SUk1LV9pcaIDkGgCLbwsx
         394w==
X-Gm-Message-State: AOAM532CF6YUz0n0RWnYadY5vB+wFxXzkH9aPWCIEJmQ1b5mC+cdRf3h
        3imR2A2+WoH0DfO7jnHcoAq8O0syUwlk8YhRSDoJstRkzobELM+Y1AzJagz1ZBm3RDsXYc41IiU
        t3em7/YIHh6ez+r2JCqaO+5iW
X-Received: by 2002:a05:600c:2948:: with SMTP id n8mr1423321wmd.61.1643715657861;
        Tue, 01 Feb 2022 03:40:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytv6sGg27WWm9E+KaEvFVIzBmnh6PhhKvD74OMrypWaCif9Pxmpddbk3kfATQH4MU5jJX8rw==
X-Received: by 2002:a05:600c:2948:: with SMTP id n8mr1423309wmd.61.1643715657640;
        Tue, 01 Feb 2022 03:40:57 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c13sm14555734wrv.24.2022.02.01.03.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:40:57 -0800 (PST)
Message-ID: <7f4569d5-2b67-fd98-9a0e-03a2025ddcce@redhat.com>
Date:   Tue, 1 Feb 2022 12:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <YfhVBtv1UIA7bJja@ravnborg.org> <YfkAOiSlIMZrKXyl@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfkAOiSlIMZrKXyl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 10:41, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 10:30:46PM +0100, Sam Ravnborg wrote:
>> On Mon, Jan 31, 2022 at 09:29:16PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> +config TINYDRM_SSD1307
>>> +	tristate "DRM support for Solomon SSD1307 OLED displays"
>> Use SSD130X here - so SSD1306 users can find it.
> 
> It's better to list them all in the "help". How user would grep this?
> 
> `git grep -n -i ssd1306` ==> no match.
>

That's already the case :)

$ git grep -n -i ssd1306 drivers/gpu/drm/
drivers/gpu/drm/tiny/Kconfig:167:         DRM driver for the SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
drivers/gpu/drm/tiny/ssd1307.c:922:static struct ssd1307_deviceinfo ssd1307_ssd1306_deviceinfo = {
drivers/gpu/drm/tiny/ssd1307.c:948:             .compatible = "solomon,ssd1306fb-i2c",
drivers/gpu/drm/tiny/ssd1307.c:949:             .data = (void *)&ssd1307_ssd1306_deviceinfo,
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

