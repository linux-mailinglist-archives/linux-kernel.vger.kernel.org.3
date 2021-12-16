Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C824E4766F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhLPAis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:38:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232369AbhLPAiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639615126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1YMOdn1C6MZPJahwV7t8pHFMry4Mv4FHAgGI/HFscM=;
        b=bVeqNZq7CNC1SpB8TulqpY33Ff3enxUESGZw+SJVVMq5KB69R5SgQhqPBrQGOngl84j4n4
        eyzCtM8ZBXBeipRopSst3rZR0zZirQ3YkgIbcBbD9u4qy6MCdZu8HfryES4NwpPKfhfv+l
        bU1hQqpogbupFzibmOSBcCoNVyIb3sg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-nkAlz7nePzepnUtbqT9dBw-1; Wed, 15 Dec 2021 19:38:44 -0500
X-MC-Unique: nkAlz7nePzepnUtbqT9dBw-1
Received: by mail-wr1-f69.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so6337853wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A1YMOdn1C6MZPJahwV7t8pHFMry4Mv4FHAgGI/HFscM=;
        b=1zFQUuejENTqZIZj294tp99sDPCDnh8CLLpOzEX5VuKP4gtudIgb3o7i1obpU0zBEA
         /lOQj/tlw1Gjwqyb3JZg5N4VHaV6lHum/IktH4j7QlPjENft1cMCMOauYysPQOVbpMoH
         oh58tKswUYGnoBOmAEaMEKWQGxNzthMLSHMYm3/TVbw5Sy9igwikmZgK9ljd0+6eU1YF
         5rRd1/1y91v08FjMTmf3KZLA6cpIZAvuZ2FMeLwtfc43s3sRXopy+w9O/0aQo3mIOXbc
         wyiyqpFjnFGhnFQIMeGudKQC0UfhjEi5ULgThqFNEClLkB0edNrUIGzKkQ8tEsvw7wLz
         hWug==
X-Gm-Message-State: AOAM5314HxlGxgZVCJo8SBHNOXZ1CImedTW1dG9TzCoF8u2++UvxnhO8
        WWJ1UwT9MWGNY+wHF8CndhjiTxzW6uy86kdO5p2kM2uX/uBw9cPBFkIOLshuJhwYIIg6D5geWUg
        IWi45j9xb1BQtoAdHSPI6RTLo
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr2571326wmh.170.1639615123075;
        Wed, 15 Dec 2021 16:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVEcx+ygTN18OiwOcRwaHX/vCxS1ywQrqGl2wbTZaQv+hJ4/etV0jJmZID1eJfR6DK11ZEWg==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr2571294wmh.170.1639615122784;
        Wed, 15 Dec 2021 16:38:42 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y11sm4270129wry.70.2021.12.15.16.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 16:38:42 -0800 (PST)
Message-ID: <98702737-2104-6139-8bd3-2e926260263b@redhat.com>
Date:   Thu, 16 Dec 2021 01:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/60] drm: Make all drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Lechner <david@lechnology.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Emma Anholt <emma@anholt.net>,
        Erico Nunes <nunes.erico@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <Ybp7qDs1p3x5GzNJ@pendragon.ideasonboard.com>
 <91c6b455-62cd-cec7-8445-e93c99230a03@redhat.com>
 <YbqHQAFtwvTvYddZ@pendragon.ideasonboard.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YbqHQAFtwvTvYddZ@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 01:24, Laurent Pinchart wrote:
> Hi Javier,
> 
> On Thu, Dec 16, 2021 at 01:13:56AM +0100, Javier Martinez Canillas wrote:
>> Hello Laurent,
>>
>> On 12/16/21 00:35, Laurent Pinchart wrote:
>>
>> [snip]
>>
>>>>
>>>> I've built tested with 'make allmodconfig && make M=drivers/gpu/drm/', but
>>>> only booted in a few devices with and without nomodeset in the cmdline. So
>>>> testing and reviewing for all the drivers would be highly appreciated.
>>>
>>> The fact that the series is so big makes me think it would be better to
>>> handle this in the DRM core. Is there any way we could do so ? Otherwise
>>> we'll chase this issue forever in new drivers, and will be plagued with
>>> cargo cult problems.
>>>
>>
>> Yes, what Thomas suggested is to add a set of drm_module_{pci,platform}_driver()
>> macros in include/drm/drm_drv.h, that will just check whether the driver should
>> be registered or not and call the {pci,platform}_register_driver() functions.
>>
>> That way the change in the drivers would just be something like the following:
>>
>> -module_platform_driver(malidp_platform_driver);
>> +drm_module_platform_driver(malidp_platform_driver);
>>
>> There are some drivers that still need a custom module init functions for various
>> reasons (e.g: register a set of devices/drivers, need to be a late init call, etc)
>> but at least for most drivers this should be handled transparently as long as they
>> use these drm_*_register_driver() macros.
> 
> Another option could be to return an error from drm_dev_alloc(). That
> may avoid changes in the drivers.
>

That was actually the first approach I proposed but was told that it wouldn't work
for two reasons:

1) Usually that's called in the driver's probe function and the goal was to make it
   fail as early as possible if nomodeset is present, so that means it is desirable
   for this to be in the module init function (and is how most drivers implement).

2) Not all KMS drivers should fail if nomodeset is used. For example the simpledrm
   driver still needs to be registered and probed since is what users would want
   as a fallback / troubleshooting option if their native driver doesn't work.
 
Solving (2) is easy since we could just add a new .driver_features flag to indicate
that the driver should not fail if nomodeset is present. That way only the drivers
that are the exception would need to be modified.

But (1) is more tricky since this may be  DRM driver maintainers preference.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

