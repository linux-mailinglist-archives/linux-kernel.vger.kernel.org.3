Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343D533808
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiEYIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiEYIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:09:50 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F1814B2;
        Wed, 25 May 2022 01:09:41 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e2so17358133wrc.1;
        Wed, 25 May 2022 01:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CVMOEmGCoID/U7Ok5RtjAgP51rImkcURoHcOEZZPehY=;
        b=pcqN0BwCcGGIJXctw9Ht+kzET8v48ksElV9QSS390nR41p/XDtqqHHFOPqbwQIp5vZ
         i6lvddy5C83XC1qKF+oQW3B7vOZv2wjW4q0qa3uzYK5TAFTEjR6GUZQ/ji/UNkudYdqa
         5T1tI93uFwLjxu48poqHeWokav+ZCAxSYjsU80P6dVjDJEDJU8rrsDqfEmv6lgsKZg5n
         lwnUap6WZrNSGp4kJASX8dVULrSkcPx46iFQAdWTdmkG53Up+xKRjIcXOoypV9zWbtqH
         Ub/5RiDnSWWORkJd+hIMMi5z61K8/xAeWUgyv9l9iP34ljhwPSgpu7k/lnkj5sfMjZn2
         E1MA==
X-Gm-Message-State: AOAM5307YsBwr3H4lqUGNxQDihO17CCxB9ita4hz33h+V/c6ZQWPSL7c
        OhRT10KiFEbfNpY9xXlYf6k=
X-Google-Smtp-Source: ABdhPJy79W5xqYDzU2ooxTjO+0iX0pKT+szGglDG33KejuukZeEQUYrvQTH7cKt/Mv8XXrN5ekYUhA==
X-Received: by 2002:a5d:4d05:0:b0:20e:6457:f2b1 with SMTP id z5-20020a5d4d05000000b0020e6457f2b1mr25224107wrt.653.1653466179973;
        Wed, 25 May 2022 01:09:39 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h1-20020a1ccc01000000b00397342e3830sm4714185wmb.0.2022.05.25.01.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:09:39 -0700 (PDT)
Message-ID: <8093277c-5098-e5e3-f606-486de5b2f67b@kernel.org>
Date:   Wed, 25 May 2022 10:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL for v5.18-rc1] media updates
Content-Language: en-US
To:     Sean Young <sean@mess.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220322101406.459e2950@coco.lan>
 <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
 <Yo3ddVHgBBlvJEdh@gofer.mess.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Yo3ddVHgBBlvJEdh@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 22, 9:40, Sean Young wrote:
> Hi,
> 
> On Wed, May 25, 2022 at 08:42:26AM +0200, Jiri Slaby wrote:
>> On 22. 03. 22, 10:14, Mauro Carvalho Chehab wrote:
>>> Hi Linus,
>>>
>>> Please pull from:
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-1
>> ...
>>> Sean Young (10):
>> ...
>>>         media: lirc: remove unused lirc features
>>
>> Hi,
>>
>> this breaks lirc build:
>>> [   59s] lircd.cpp:489:49: error: 'LIRC_CAN_SET_REC_FILTER' was not declared in this scope; did you mean 'LIRC_CAN_SET_REC_CARRIER'?
>>> [   59s]   489 |                     || (curr_driver->features & LIRC_CAN_SET_REC_FILTER)) {
>>> [   59s]       |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
>>> [   59s]       |                                                 LIRC_CAN_SET_REC_CARRIER
>>> [   59s] lircd.cpp: In function 'void loop()':
>>> [   59s] lircd.cpp:2069:82: error: 'LIRC_CAN_NOTIFY_DECODE' was not declared in this scope; did you mean 'DRVCTL_NOTIFY_DECODE'?
>>> [   59s]  2069 |                         if (curr_driver->drvctl_func && (curr_driver->features & LIRC_CAN_NOTIFY_DECODE))
>>> [   59s]       |                                                                                  ^~~~~~~~~~~~~~~~~~~~~~
>>> [   59s]       |                                                                                  DRVCTL_NOTIFY_DECODE
>>
>> So the uapi header defines should be brought back, IMO.
> 
> The lirc.h uapi defines the lirc chardev uapi. The uapi has not changed in
> any way, for old or new kernels.
> 
> So the lirc header used to have feature flags LIRC_CAN_SET_REC_FILTER and
> LIRC_CAN_NOTIFY_DECODE which were defined the in the lirc.h header, but
> never implemented by any out of tree or in tree driver.
> 
> Neither feature was or will be ever implemented in the kernel;
> LIRC_CAN_NOTIFY_DECODE is handled via the led subsytem, and it is unknown
> what LIRC_CAN_SET_REC_FILTER is even supposed to mean. Again, I have not
> found any implementation anywhere.
> 
> You are trying to build lirc user space daemon which is no longer maintained.
> The last time the lirc daemon git repo had any commits was in 2019. User
> space tooling has been replaced with daemon-less ir-ctl and ir-keytable,
> which uses BPF for IR decoding.
> 
> The right fix is to simply delete the offending lines in lircd.cpp and all
> will be well. Sometimes source code needs a little maintainence.
> 
> These changes in the lirc uapi do not change the uapi in any way, just the
> ability the build some unmaintained software without trivial changes.

Hi,

I don't understand how inability to build software is not an uapi 
breakage -- care to elaborate?

Be it umaintained or not, it's still in distributions (the above is from 
opensuse build system) and it is broken now. Every single distributor 
now would have to go and fix this.

So either you fix it (e.g. re-add only the entries as I suggested) or I 
will post a revert of your patch. Sorry, no excuses.

thanks,
-- 
js
suse labs
