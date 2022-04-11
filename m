Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB404FC2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348627AbiDKQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348701AbiDKQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:53:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B87136B58
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:51:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b16so19440382ioz.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eiAYIK4eB9YpKVQY7uodlLNbKuIMZrkg3r+tUafoF+8=;
        b=KZiBB6oG1FD1CE/9BBJANOo58MujeM4G+RO7m0j+T/VCQTn2cFaXrCMbVSBax+yoN7
         zKDoOVZlUkLaZ3ztKLjDMlm48/fezbrjDjd8FinhGjO/FLRdb2WT+p4RV7ZQF1GSlEoM
         zg/KHadgywEe+78idGiO1rJO41wOAmyIQaqmGm7D0TJo4fBqK0V5vxf7W2kNRvfSqWe/
         n2dc0BeZUdc7FFx0l3CrIv4eLePLZWBHlARH5xY0AFfmWa0edY3kh4EDCa7ynSehK1oI
         zgYYXZ46rdiFi8fAR7Y+nIkHgoyOShglax8UmPcZR49QbLOjlDvBow6HyZjIhs09/T8U
         fh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eiAYIK4eB9YpKVQY7uodlLNbKuIMZrkg3r+tUafoF+8=;
        b=fxHIj1ACFeVlDFgdub4iC2GgM9QsSGu7h1Kd++V+iIi4dKBI+tZEpcewc1Dg5vtwVU
         E6qyN6Gf6DCjT6TMh1ubfhvnes2PX2Zy+WsAM2ZiCuAoSBMh7VcbLIDd1bAKDcEBZW0J
         Dp/DU92bf+VqigpAMUMt1O4A/8vh0BH9+8i1gE34vBhw0FKN6gn2oy2xtT6YG6BWyYn3
         jMOoyNIOgSv7e5PteMT6eVSPwv6RsFz6DJM+sW+zagne8uUinpcefa92hxQA2DmvF6vH
         9zyCAmUgTa0nQt+1ULtNpdLnIq/tJAFo7m/DiICYvsP0Ujb4JwjBQ6Tx9m6/Cqc5FHlp
         583g==
X-Gm-Message-State: AOAM5337vYNPU+oYAACdhd1skTH+CNwEq6K88zUwfMVQvYFwXIep8GMF
        DUdSzaYQn7mh4dKxOrxJymwjLw==
X-Google-Smtp-Source: ABdhPJyrBJiJPWff548IHrGfcWxyvtBO+exqiqx6SfQ/bhIkV++JhY6PT88XFxSZLp9IJ3vkLBwX/Q==
X-Received: by 2002:a05:6638:4984:b0:326:11b5:74fb with SMTP id cv4-20020a056638498400b0032611b574fbmr4965472jab.153.1649695891345;
        Mon, 11 Apr 2022 09:51:31 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s13-20020a6bdc0d000000b006408888551dsm20145509ioc.8.2022.04.11.09.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 09:51:30 -0700 (PDT)
Message-ID: <226c4072-a3ca-a5a4-1b7f-f7104b43af03@kernel.dk>
Date:   Mon, 11 Apr 2022 10:51:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cdrom: do not print info list when there is no cdrom
 device
Content-Language: en-US
To:     Enze Li <lienze@kylinos.cn>, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20220408084221.1681592-1-lienze@kylinos.cn>
 <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
 <20220409122530.60353fcd@asus> <YlFA7USiCtqsFvVD@equinox>
 <f74b6933-5357-6b2c-3127-7a3465dadbdf@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f74b6933-5357-6b2c-3127-7a3465dadbdf@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 2:41 AM, Enze Li wrote:
> 
> On 4/9/22 16:16, Phillip Potter wrote:
>> On Sat, Apr 09, 2022 at 12:25:30PM +0800, Enze Li wrote:
> 
> <snip>
> 
>>> On Fri, 8 Apr 2022 06:34:04 -0600
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>> Will this potentially break applications that parse it?
>>>>
>>> I dunno, is there any way to confirm this thing?  And if this is really
>>> a possibility, does it mean that we cannot make changes?
>>>
>> Sorry, anything that can be parsed from userspace has the potential to
>> break userspace applications. For that reason, I would have to say I
>> don't think this patch is suitable. Sure there are times it's
>> appropriate to change userspace interfaces, but I'd rather err on the
>> side of caution here. Thanks for the patch though.
>>
>> Nacked-by: Phillip Potter <phil@philpotter.co.uk>
>>
>> Regards,
>> Phil
> 
> Hi Phil,
> 
> Thanks for your review.  I got what you said. ?
> 
> In addition, I noticed that in the source file[1], there is a Todo List there.  I'm quite
> interested in it.  It says:
> ================================================
>   17 To Do List:
>   18 ----------------------------------
>   19
>   20  -- Modify sysctl/proc interface. I plan on having one directory per                 
>   21  drive, with entries for outputing general drive information, and sysctl             
>   22  based tunable parameters such as whether the tray should auto-close for             
>   23  that drive. Suggestions (or patches) for this welcome!
> ================================================
> I'd like to know if the relevant patches are still welcome?
> 
> IIUC, the TODO List says that we need to implement a modification of the
> following form:
> ----------------------------------------------------------------------------------------------------------
> $ tree /proc/sys/dev/cdrom
> /proc/sys/dev/cdrom
> |--sr0--autoclose
> |       |-autoeject
> |       |-check_media
> |       |-debug
> |       |-info
> |       |-lock
> |
> |--sr1--autoclose
> |       |-autoeject
> |       |-check_media
> |       |-debug
> |       |-info
> |       |-lock
> |
> |--sr2 ...
> .
> .
> .
> ----------------------------------------------------------------------------------------------------------
> I would appreciate it if you could give me some advice.

Let's not do that, this advice is perhaps 20 years old. /proc isn't to
be used for anything like that these days.

-- 
Jens Axboe

