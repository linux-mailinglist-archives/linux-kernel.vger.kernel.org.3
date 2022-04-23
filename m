Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5631D50CE07
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiDWXWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 19:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiDWXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 19:22:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEB1393BB;
        Sat, 23 Apr 2022 16:19:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so2192246ejj.10;
        Sat, 23 Apr 2022 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CXyaROkFgwGaHhoYdzTnLTG6Cf1Eawl7h8AqxGcacrg=;
        b=q1jmksvM0ZOU5/688dFFC388xTEd87P8b7x4dkBganSP+SvZLoxMj/XzsMC+raGOV8
         Dy1EZruUcRc9gEbq6WYTdhReCBD+zKeyG4BlV0L6xzBxTbeVdspIN+Cw/Afmw4Uxlymq
         w26wayLJAI5pySZERiED44YjZefBWeiZ5oEspE+cGJioZpys8cE4Lubkgt9/oVw5kVqj
         U9JQAQT1YKbc213IJDxM6HQW1nNKNwiQnYlyzDgF8jHNnnmxOzuS0Qk5OCkKRCtUP2m9
         7WZo2PDGhTgEPRcJHTAab9xbeUsZ0FVj9rfkt8NsnYwaUnA41ulZp7CAZKS97Kw1ZuSX
         eTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CXyaROkFgwGaHhoYdzTnLTG6Cf1Eawl7h8AqxGcacrg=;
        b=iXgF1JDfhLw6/QSvdmAuXQRs8aNpBck7dvyZgYt/DuO7rL/Lo1Kc5A/paOvyqx05EA
         YS3O8NdbFfRnnugkg4pqytlVr/6AxWM0I4gXEioj0pF5nmHEc+I4el3Ww6kdPhneuMzU
         Ee4o3iFQtGgWo9CQW9KeyH1CV4pZ3bvYhfIZhIBZ6BXPlwbR6LmV8jX0y8ZdhGprRjBc
         3YkEvkhAphDlzA27St+getO9GSW8llS0gxAF1SnSjhFpqPsHg/UQo3uDjOUPOEcj7svJ
         8lv2WqoR0gpyJ24dcxYXQIt6qRGPVDOv6bvIloGuUvkEFYUbtEvZTFOGlp5Kvs9LXlUC
         +VZA==
X-Gm-Message-State: AOAM531SJRp7nUTzCcYDfHLRdfimj3UOBPmh1ho3VzRxTAQeE8Cg1y3C
        bQ1TzFmo0m+JnIS5JWRX83A=
X-Google-Smtp-Source: ABdhPJzh3uUGCegkAUG2E9h74LWdwHrwuTe8j2hsrp7IcY5suww5ACt4eijiOz10KMUAbPV1BP9OdQ==
X-Received: by 2002:a17:907:7f08:b0:6f3:8c69:1779 with SMTP id qf8-20020a1709077f0800b006f38c691779mr167712ejc.414.1650755972044;
        Sat, 23 Apr 2022 16:19:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d40:29d:ba85:78f8:3d80:548? ([2a02:810d:6d40:29d:ba85:78f8:3d80:548])
        by smtp.gmail.com with ESMTPSA id l2-20020a50c102000000b0042423e1328fsm2649134edf.26.2022.04.23.16.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 16:19:31 -0700 (PDT)
Message-ID: <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
Date:   Sun, 24 Apr 2022 01:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Status on hid xppen patch
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <20220423172330.32585-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hello everynyan!
>>
>> A while ago I sent in a patch to add support for newer Xp-pen tablets 
>> that even made it into patchwork:
>>
>> https://patchwork.kernel.org/project/linux-input/patch/b401e453-9c66-15e3-1a1d-21f33b7a64e8@gmail.com/
>>
>> I have never actually gotten any feedback on it though and am wondering 
>> if everything is to your liking. Anyway it doesn't build against the 
>> current tree anymore. Assuming there is any value it, should I rewrite 
>> it against hid master or hid uclogic?
>>
>> Many thanks
>>
>> Stefan Berzl
> 
> Hi Stefan,
> 
> I just saw your email in the mailing list.
> 
> Your patch doesn't apply against the current tree because of the changes
> from Nikolai/the DIGImend project I'm sending upstream. For reference,
> here is the latest batch of patches, with links to the previous ones:
> 
> https://lore.kernel.org/linux-input/20220421175052.911446-1-jose.exposito89@gmail.com/T/
> 
> Please note that I'm not the maintainer of the driver, I'm just a web
> developer who does free software as a hobby, i.e., this is not my area
> of expertise, so take my words as suggestions, not as the path to
> follow ;)
> 
> The development of the uclogic driver takes place on the DIGImend
> project (inactive right now):
> https://github.com/DIGImend/digimend-kernel-drivers
> 
> Like you, I wanted to add support for my tablet/improve my kernel
> dev skills, but I noticed that I needed some patches from DIGImend, so,
> instead of taking what I needed, I decided to upstream all the patches.
> 
> At the moment of writing this email, 24 patches from DIGImend have been
> merged, 5 are under review and 7 more need to be sent. We are close to
> the end.
> 
> My tablet (Parblo A610 PLUS V2) also needs some magic data to be enabled.
> Actually, the data is pretty similar to the one in your patch.
> You can see my implementation here:
> https://github.com/JoseExposito/linux/commit/f1f24e57fab45a2bcf4e0af5ba9d8f5a2245670b
> 
> I just refactored my patch and extracted the code to send the magic data
> to its own function (uclogic_probe_interface), so we can share it.
> 
> I'd suggest rebasing your code on top of DIGImend's code + my patch
> so we can share some code and once all patches are upstream, you can
> send it with minor or without conflicts.
> 
> What do you think?
> 
> José Expósito
> 

Hello José,

nice hearing from you. I was actually thinking of just asking if you
want to take my patch under your wing, since you seem to be doing a lot
of uclogic related work. But your idea is even better, just submitting  
my patch once everything has settled down seems to be the way to go.

You are actually the first person to ever contact me about this. I was  
pretty worried that the patch is no good, but then I saw that there is  
quite a backlog in the maintainers patchwork and some of your patches
haven't been reviewed either. Originally I tried showing it to Nikolai,
but he said he was rather busy too and then some guys in the Digimend
project tried to get me interested in some userspace driver that works  
around all the issues of like init-packets and stuff. I always imagined
the kernel as this highly organzied, well-structured endeavor where
things would be quickly scrutinized and suggestions offered to assure 
the highest quality. Yet here we have two web developers working on the
graphics tablet driver. Let me say that it's really great you take the
time and effort to mainline these patches and help everyone enjoy their
tablets on linux!

On the technical side, the magic bytes really are very similar, the only
difference being the two additional trailing 0x00 for mine. Also my
tablet sends a response after activating this new interface which can 
get interpreted as a button press if it's not discarded. Is there a nice
way to work around this, with subreports or anything?

Lastly, do you have an idea in which kernel version the bulk of your
patches will have been merged, just so I know when to start looking at
this again? I don't mean to belittle the kernel maintainers of course,  
for I am sure they have more pressing and difficult issues on their
plate, like eBPF and such.   

Lets fixie wixie this fucksy uppsy!

Bye


Stefan Berzl
