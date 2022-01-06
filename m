Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5635D486860
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbiAFRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiAFRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:23:41 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C4C061245;
        Thu,  6 Jan 2022 09:23:41 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 202so3308043qkg.13;
        Thu, 06 Jan 2022 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gMHauqJnpqaLsimG1DM/FO214zE9c4NKzXE4Gu5k6WI=;
        b=i7g/5QOMXJ3pty4lNl+FKK7d3r8z0Co5KGRvJM9E4HHJUKqTETvTLQWGRmEmbPVJ0C
         SzqmAVc6Sq+YQ3AZAxCbqPixdT+KqD9b4E/wD0JhGsOUOZPCk2HhNXj+W5wSuR6HPNh1
         tfpajMlBQ9dgDHs/zYgTB/3gLHe3oNIE+Pim7Z2me8a6c0BUtbkpwInoGCmwtLSmbZtR
         yTYmE5y3Btn4blmB3/YljWLt3alcyJ+w6uiCwZHGI2xijTLvKZ1/WGVoI33TB4eFyO+0
         wDFOWbKVzHeFDlk89jqlwmZxXAT6rGfL5QGbHpu7EjS+8leGsGtVZh7uzoa00Dcc/eC+
         9ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gMHauqJnpqaLsimG1DM/FO214zE9c4NKzXE4Gu5k6WI=;
        b=f7nRlCAcH0+qbN6InB5i68s7iIKCUoXZKNPSoHkOo6zGFvoH5mId6PTwFgEDyd3val
         UgB9q1K27bwn/4hv+vlYIHeNQOtNRGdmcVWuodvs+ZeUBqeq/jkC3eRMjkW+BJ5mAoj2
         IGBsBXq9NtQHBpTwp9+wtyA5klmMdhK0KTYXaNostctjDuSL9h5y0psbd/qae+IPvp1p
         Z0CPQp8nsyu+dpZ4Y/e5yOq/Xs0aQ7/9Z6kyvBlm2x8Pdv7hXsgEpIHhKzeT5YYY+XFA
         lQ+/C2nhmR7VRmBWRhP1bLbY7SXCW5OVjUqBQTsGUdO9J6hqxRu/xGtTbNlRFBJvgAcq
         zmBA==
X-Gm-Message-State: AOAM533+YbWGX5xqtonpZDHcN0NpJvLRFJkkjZziZGm1zk1W9t+WyUmY
        y8tq91RSHzHFuo9dcUzcpgezQIFkkbY=
X-Google-Smtp-Source: ABdhPJz7GPryGimJVGGLJMBlykpSSFRhuSWOH+YzMifmQgMYwYq7+6dL9F1o7nAVCeHEju6keLjqxA==
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr41755228qke.261.1641489820563;
        Thu, 06 Jan 2022 09:23:40 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id i6sm1917136qkn.26.2022.01.06.09.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 09:23:40 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
References: <20210324223713.1334666-1-frowand.list@gmail.com>
 <20210327174035.GA291160@robh.at.kernel.org>
 <3e6710e7-08ac-7d1b-aa69-bcd36f0d932a@gmail.com>
 <CAMuHMdXpGKMi-xv6hZQmmEw0JO=Q0WuvUzwJ2v0O28Tx5uW+sg@mail.gmail.com>
 <d1aefaae-7b12-b5fb-4b97-7230bd52c1be@gmail.com>
 <20210526061144.yvoaurpz75a3bsjr@vireshk-i7>
 <f651e95b-feef-5c86-edba-d6008bc80b34@gmail.com> <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko>
 <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com>
Date:   Thu, 6 Jan 2022 11:23:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, David,

Patient Geert has pinged again.

If I remember correctly you guys were not thrilled with this idea, but
also did not seem strongly against it.  Are you willing to go along
with .dtso for overlay source files?  If so, I will revive this patch
series.

David, if you are against supporting .dtso in the dtc compiler then
the kernel can still support it through make rules.

-Frank


On 1/6/22 3:00 AM, Geert Uytterhoeven wrote:
> On Tue, Aug 24, 2021 at 11:20 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Jun 22, 2021 at 11:44 AM Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Sat, May 29, 2021 at 12:16 PM Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Sat, May 29, 2021 at 7:16 AM David Gibson
>>>> <david@gibson.dropbear.id.au> wrote:
>>>>> On Thu, May 27, 2021 at 09:21:05AM +0200, Geert Uytterhoeven wrote:
>>>>> 65;6401;1c> On Thu, May 27, 2021 at 3:48 AM David Gibson
>>>>>> <david@gibson.dropbear.id.au> wrote:
>>>>>>> On Wed, May 26, 2021 at 04:21:48PM -0500, Frank Rowand wrote:
>>>>>>>> On 5/26/21 1:11 AM, Viresh Kumar wrote:
>>>>>>>>> On 22-04-21, 13:54, Frank Rowand wrote:
>>>>>>>>>> On 4/22/21 3:44 AM, Geert Uytterhoeven wrote:
>>>>>>>>>>> On Mon, Mar 29, 2021 at 9:23 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>>>>>>> On 3/27/21 12:40 PM, Rob Herring wrote:
>>>>>>>>>>>>> On Wed, Mar 24, 2021 at 05:37:13PM -0500, frowand.list@gmail.com wrote:
>>>>>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Add Makefile rule to build .dtbo.o assembly file from overlay .dtso
>>>>>>>>>>>>>> source file.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Rename unittest .dts overlay source files to use .dtso suffix.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm pretty lukewarm on .dtso...
>>>>>>>>>>>>
>>>>>>>>>>>> I was originally also, but I'm warming up to it.
>>>>>>>>>>>
>>>>>>>>>>> What's the status of this?
>>>>>>>>>>
>>>>>>>>>> I was planning to resend on top of the upcoming -rc1.
>>>>>>>>>
>>>>>>>>> Ping.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks for the prod...
>>>>>>>>
>>>>>>>> The .dtso convention was added to the dtc compiler, then a patch was
>>>>>>>> accepted to revert one mention of .dtso ,though there still remains
>>>>>>>> two location where .dtbo is still recognized (guess_type_by_name() in
>>>>>>>> dtc and the help text of the fdtoverlay program).
>>>>>>>>
>>>>>>>> It seems that the general .dtso and .dtbo were not popular, so I'm
>>>>>>>> going to drop this patch instead of continuing to try to get it
>>>>>>>> accepted.
>>>>>>>
>>>>>>> AFAICT .dtbo is moderately well established, and I think it's a good
>>>>>>> convention, since it matters whether a blob is an overlay or base
>>>>>>> tree, and it's not trivial to tell which is which.
>>>>>>
>>>>>> Indeed.
>>>>>>
>>>>>>> .dtso is much more recent,
>>>>>>
>>>>>> Is it?
>>>>>
>>>>> Well, I wouldn't bet money on it, I just seem to remember encountering
>>>>> .dtbo for some time before .dtso was mentioned.
>>>>>
>>>>>> The oldest reference I could find is from May 2015:
>>>>>> "[PATCH/RFC] kbuild: Create a rule for building device tree overlay objects"
>>>>>> https://lore.kernel.org/linux-devicetree/1431431816-24612-1-git-send-email-geert+renesas@glider.be/
>>>>>
>>>>> Hm, I think .dtbo is even older than that, but again, I wouldn't swear
>>>>> to it.
>>>>
>>>> Sure. My work is based on Pantelis' work for BeagleBoard capes.
>>>> His code (from 2013?) used .dtbo and .dts:
>>>>
>>>>     overlay/v3.10/merge:firmware/Makefile:$(obj)/%.dtbo: $(obj)/%.dts
>>>> | $(objtree)/$(obj)/$$(dir %)
>>>>
>>>> So I might be the one who introduced .dtso...
>>>>
>>>>>> I have always used dtbo/dtso in my published overlays branches,
>>>>>> referred from https://elinux.org/R-Car/DT-Overlays, and used by
>>>>>> various people.
>>>>>>
>>>>>>> and I think there's much less value to it.
>>>>>>
>>>>>> IMHO the same reasoning as for dtb vs. dtbo applies to dts vs. dtso.
>>>>>> It matters if the resulting blob will be an overlay or base tree,
>>>>>> as the blob will have to be called .dtb or .dtbo.
>>>>>> As dtc outputs to stdout by default, the caller has to provide the
>>>>>> output filename, and thus needs to know.
>>>>>> Even if dtc would name the output file based on the presence of
>>>>>> "/plugin/" in the input file, the build system still needs to know
>>>>>> for dependency tracking.
>>>>>
>>>>> Hm, fair point.  I was thinking of the the /plugin/ tag as the
>>>>> distinction, whereas dtb is binary and the distinction isn't even
>>>>> marked in the header.  But you're right that even readable text labels
>>>>> inside the file don't really help make(1).  So, I retract that
>>>>> assertion.
>>>>
>>>> Thanks!
>>>>
>>>>>> We also do have .dts vs. .dtsi.
>>>
>>> In the mean time, we're at rc7 again?
>>
>> That was v5.13-rc7. Now we're at v5.14-rc7...
>>
>> Will we live with the inability to e.g. let make distinguish between
>> DT includes and overlays forever?
> 
> I guess this is not gonna happen, so I'll convert all my overlays
> from .dtso to .dts....
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

