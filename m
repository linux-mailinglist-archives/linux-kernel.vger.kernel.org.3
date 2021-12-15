Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D20475421
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhLOIOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235661AbhLOIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639556087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEAsI75enqLwhDhbjlYFhGRisu3oyU/HOhdF+s9OEjo=;
        b=BqtG0KQr6ess2GDJJF75rV1anNF9iVMOyiY3Upq9S6q5agLTI7Kx6lIU0YbR7U1JvVsV6a
        GhzpVLeLJADB0D/DWTexUVGjsF8gZ/lzJECjG7zEZw2PNyN1GmfMv+O89/dyBxXUJdGo+P
        WPR7BaDVrfkkvwlk1OEEwgNPfTig5ag=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-bEn4zoj_Mnem3YsxjIJB3g-1; Wed, 15 Dec 2021 03:14:46 -0500
X-MC-Unique: bEn4zoj_Mnem3YsxjIJB3g-1
Received: by mail-wm1-f72.google.com with SMTP id z199-20020a1c7ed0000000b003456affcffaso204622wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JEAsI75enqLwhDhbjlYFhGRisu3oyU/HOhdF+s9OEjo=;
        b=7wHIJZ/O7dtv5CCB/Ktn3Pq/0j+dasYeDtSRoQJoAEfvVpROfTP9ZTsCmjSYJ5RhED
         7iwRFNqzd5SHAsNFOEV3yNzVDlhD3KEM6duyZWr7fewOqF4kkQmEVb3YzNpnAepjUSTC
         v/w1fxpx/VYwtjmSVbsjTHcZb0tUm7mRfJPe6zUQ2gYXRg57MO1oivG5gVv18Wx1w6Nw
         swyu/44dbslvTiB7e/ytnj81A4C08Rgde6TFwySzv2n2Cn2VSjEoLz0fNIqLAEhq8SeB
         VaEgfd2w/HvcWky7W2yY80RZxL6fb8jYOTerbr3xQETPOt/OLTBG//mq6MeQDCZQ2rgw
         wn1g==
X-Gm-Message-State: AOAM531sPyNsJ1OgNnDhss/G8T8lZwjPBGAUzucuRDHs+DQObo0327+z
        FEza2IzL0SH5GyTfN1HFX3Sn06LKpC1PGnWVZg1L8oTuMGYU/1MsLKLEoetekIgMua64SYYa2rF
        wN5VUmibGjlmqfJPGyNPCZZfs
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr3437791wmc.186.1639556084736;
        Wed, 15 Dec 2021 00:14:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrlpcSf3TqSPYZqkCKxKSZcCNrQVNV34HIxCojMhmFMNV5KT+N5l7F3ybbnUjVuBan8yXg7w==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr3437778wmc.186.1639556084498;
        Wed, 15 Dec 2021 00:14:44 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1sm1288434wrh.116.2021.12.15.00.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 00:14:44 -0800 (PST)
Message-ID: <99d6cd9f-3693-03ef-ae8f-07339515f5e5@redhat.com>
Date:   Wed, 15 Dec 2021 09:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 59/60] drm/xen: Add support for the nomodeset kernel
 parameter
Content-Language: en-US
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <20211215010008.2545520-60-javierm@redhat.com>
 <c417c35e-fbff-cb88-6684-7757f218bdf3@epam.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c417c35e-fbff-cb88-6684-7757f218bdf3@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksandr,

On 12/15/21 06:58, Oleksandr Andrushchenko wrote:
> Hi, Javier!
> 
> On 15.12.21 03:00, Javier Martinez Canillas wrote:
>> According to disable Documentation/admin-guide/kernel-parameters.txt, this
>> parameter can be used to disable kernel modesetting.
>>
>> DRM drivers will not perform display-mode changes or accelerated rendering
>> and only the systewm system framebuffer will be available if it was set-up.
> s/systewm system/system
>>

Thanks a lot for spotting this! I rewrote the commit message a couple of times
and didn't notice that ended with a sentence that was mangled.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

