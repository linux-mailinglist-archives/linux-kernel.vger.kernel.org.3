Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9D523B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbiEKRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbiEKRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:17:43 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038B68FBC;
        Wed, 11 May 2022 10:17:34 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso3622896fac.1;
        Wed, 11 May 2022 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=6KyyMkeo+AlJ0nOsy4nLJ1EEoBetcYQI533KSovi9IQ=;
        b=dqHlKdpugl+Lt+eshvhbrTej6F20MWqj4mrStBx72ebHKnocMaiudq80COa4hILLwu
         w/d+K0syWHZgajRyt7DlYED6M1B1nw37ql3s2sRPfJ64eDweK7OGG9uk4TgqWazhKWQK
         IG27Aee4rt/8VZpRSd/EhpQhTwpWJg1wd3Y9vjkVccsf1PBM8o+NWcKoosMT1UrmVhtm
         wx7ZAW212rJ6tl84HSUcrFCbtwqIPe0q4duIKxagafA8pQnfUcqXtiR9gws8g+4hJ5w+
         MctGYYbiI+Y+7DLR32NWAdj0ywJ4RtDuuZ0vh9OBHRl3YPfmAMhnsNuCCv0xoHrPY1G7
         pGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=6KyyMkeo+AlJ0nOsy4nLJ1EEoBetcYQI533KSovi9IQ=;
        b=NPXkvDrYVxs6R+dkSEMWBl3mS2JPWYOsKOwqVlLYv0cPgh0z90agDxvhMuDt4CUpwB
         4EEmqFHTrAoX0KqtGcv5uXg3h9q947nip0qX3eU6pzufreW6+VnfCylEX8/AQUR+3w4O
         rtTkm4QhEsyzvVEkL+zQ2jAhm+QmnwzPm6Va3hu8R0/ho3qVa7Zk20EK+xb3l93RBlkL
         vQQxlXE3uhz82yKfpdnJzZSYUxvPWyGQz1XFCmit+2bJ8J9spNQ7+x1Ti8n5MxNCdsz0
         ztm9K8+i7BB0XADrVyIcZq8/tSYGh3YfjOjqXUVfcGD2AxdPXp+5kYV/lFcHsHHqeGdY
         3dlQ==
X-Gm-Message-State: AOAM5339sS7HHejGl0972fIFwSZUR6pTl7A8x6rIKNCQ13dUtwRQPXTA
        gLdqk7k/COHzLExIE7KifOg=
X-Google-Smtp-Source: ABdhPJxR6N0xVPBDvw47sZ2LDM5btOtf+0ie7Vjo27VUnR+DXIE9tDW6vaoMtPS6MoeLN7FLvAa+8w==
X-Received: by 2002:a05:6870:1781:b0:e2:f30d:3a6c with SMTP id r1-20020a056870178100b000e2f30d3a6cmr3288738oae.142.1652289454084;
        Wed, 11 May 2022 10:17:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p132-20020aca5b8a000000b00325cda1ff9fsm946219oib.30.2022.05.11.10.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:17:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8c84428c-2740-4046-74c9-298b854944d0@roeck-us.net>
Date:   Wed, 11 May 2022 10:17:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113230.1252910-1-javierm@redhat.com> <YnvrxICnisXU6I1y@ravnborg.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 7/7] fbdev: Make registered_fb[] private to fbmem.c
In-Reply-To: <YnvrxICnisXU6I1y@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 10:00, Sam Ravnborg wrote:
> Hi Javier.
> 
> On Wed, May 11, 2022 at 01:32:30PM +0200, Javier Martinez Canillas wrote:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Well except when the olpc dcon fbdev driver is enabled, that thing
>> digs around in there in rather unfixable ways.
>>
>> Cc oldc_dcon maintainers as fyi.
> 
> Another way to fix this is to mark FB_OLPC_DCON and add a TODO entry to
> fix this. We are really not supposed to carry such special code around
> to keep staging working.
> 
> I know this may not be a popular viewpoint, but just look at the ugly
> workarounds required here.
> 
> 	Sam
> 
> 
>>
>> v2: I typoed the config name (0day)
>>
>> Cc: kernel test robot <lkp@intel.com>
>> Cc: Jens Frederich <jfrederich@gmail.com>
>> Cc: Jon Nettleton <jon.nettleton@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-staging@lists.linux.dev
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Cc: Zhen Lei <thunder.leizhen@huawei.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: Zheyu Ma <zheyuma97@gmail.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/video/fbdev/core/fbmem.c | 8 ++++++--
>>   include/linux/fb.h               | 7 +++----
>>   2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index 265efa189bcc..6cab5f4c1fb3 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -50,10 +50,14 @@
>>   static DEFINE_MUTEX(registration_lock);
>>   
>>   struct fb_info *registered_fb[FB_MAX] __read_mostly;
>> -EXPORT_SYMBOL(registered_fb);
>> -
>>   int num_registered_fb __read_mostly;
>> +#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
>> +EXPORT_SYMBOL(registered_fb);
>>   EXPORT_SYMBOL(num_registered_fb);
>> +#endif
> 
> It is stuff like this I refer to as "ugly" in the comment above.
> 

My "solution" for that kind of thing is to use a namespace,
such as

EXPORT_SYMBOL_NS(registered_fb, FB_OLPC_DCON);
EXPORT_SYMBOL_NS(num_registered_fb, FB_OLPC_DCON);

and import it from the offending code. That avoids ifdefs
while at the same time limiting the use of the symbols
to the expected scope. Of course that could be abused but
that abuse would be obvious.

Guenter
