Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57249CC23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiAZOSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235570AbiAZOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643206698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ezLTX17xe1yXWdb0ZwpAiPVrESUBhrTwQn5+FJRhKI=;
        b=e0Ko7ad6ynjwjazCTGEvXe2qgp0s+qm+4HJHQi3P+uQ5mYsZ8cOHwY+vsebbAvCOlne5Tg
        3p7uDKB/x8/l5AuS7rLb8jpQ3F0HtOezrIuO+LS5j16cn3srYIjW64Lc6UCCkzULQsnyrs
        CqFFsCaTr+8/Yx6g/zDstmI1anYQWW8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-v3NLrGG_PdqizwPYaZgtjA-1; Wed, 26 Jan 2022 09:18:17 -0500
X-MC-Unique: v3NLrGG_PdqizwPYaZgtjA-1
Received: by mail-wr1-f70.google.com with SMTP id k12-20020adfe3cc000000b001d6806dfde1so4348519wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ezLTX17xe1yXWdb0ZwpAiPVrESUBhrTwQn5+FJRhKI=;
        b=LwUp+3ZxhFppqCRwNoJozc22lF40K8+wDql25+ytIGFwhmUZYnJEAhOoZniUY6Oz2U
         81cuD08fDJAdJ4WZOyHwvoAuir3vdNvCZqbJT1L0V3XGrHShWszQ07h5yTJQ8JwykpMB
         aP8s9mY+eV4dEwtB6VTh4CpEt8SZua6NzISS9TdQly01W1TxZ+IxQ6rYlUhHbesCNgqf
         z/BsBZQn0AzgPaf4X+aMBNLh1OBksGFNA/8yvHUjjSm8ACAuDWvqszksyCADToWdI7wo
         KGo0jGCiUXhS8GRNeDcEES9TLfqcSE8UHO7F94EZ/Oo6agXiZpzbIjGmOdLesdsfqdXE
         bKRw==
X-Gm-Message-State: AOAM530vR302rptEbZGtvSOrJDcoyigKkMYGd1P6bDbNL40xUIus8t3y
        FVhYI6a6/3PGCyNXltC4w5ydn+4ZDjmcsy3jMM+p4N60llNRKcxH7rTurmLUCxhWVg2ueBzrkZ5
        6Rvjx9hIJZrmGE+4qgUOJuWRJ
X-Received: by 2002:a5d:6f10:: with SMTP id ay16mr14738841wrb.183.1643206696018;
        Wed, 26 Jan 2022 06:18:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxksbfhCZ7SXr+6tjwoPU4RHnla2jY/kkMOPccD237O672NRHo7t0lUaWXxaaOjf6TiGCJImw==
X-Received: by 2002:a5d:6f10:: with SMTP id ay16mr14738822wrb.183.1643206695782;
        Wed, 26 Jan 2022 06:18:15 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm9828896wry.104.2022.01.26.06.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:18:15 -0800 (PST)
Message-ID: <3430838d-1c63-da49-b774-c5a883e7085f@redhat.com>
Date:   Wed, 26 Jan 2022 15:18:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
 <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <YfFMSkhbvHaR0YNE@smile.fi.intel.com>
 <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
 <YfFWmmJFtEB93jUi@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFWmmJFtEB93jUi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 15:11, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 02:47:33PM +0100, Javier Martinez Canillas wrote:
>> On 1/26/22 14:27, Andy Shevchenko wrote:
>>> On Wed, Jan 26, 2022 at 12:18:30PM +0100, Javier Martinez Canillas wrote:
>>>> On 1/26/22 11:59, Helge Deller wrote:
>>>>> On 1/26/22 11:02, Andy Shevchenko wrote:
> 
> ...
> 
>>>>>> P.S. For the record, I will personally NAK any attempts to remove that
>>>>>> driver from the kernel. And this is another point why it's better not
>>>>>> to be under the staging.
>>>>>
>>>>> I agree. Same as for me to NAK the disabling of fbcon's acceleration
>>>>> features or even attempting to remove fbdev altogether (unless all
>>>>> relevant drivers are ported to DRM).
>>>>
>>>> But that will never happen if we keep moving the goal post.
>>>>
>>>> At some point new fbdev drivers should not be added anymore, otherwise
>>>> the number of existing drivers that need conversion will keep growing.
>>>
>>> This thread is not about adding a new driver.
>>
>> It was about adding a new drivers to drivers/video/ (taken from staging).
> 
> Does it mean gates are open to take any new fbdev drivers to the staging?
> If not, I do not see a point here.
> 

Good question. I don't know really.

But staging has always been more flexible in what's accepted there and
that's why some distros avoid to enable CONFIG_STAGING=y in the kernel.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

