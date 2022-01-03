Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A344834D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiACQfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiACQfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:35:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF3C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:35:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q16so70942214wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T3i9zgwcayeVl7cWKMRosEJ4OOhKmrBVCf1DuyQd0ZQ=;
        b=RCUaoyJ8tstUuLAgGQdCMqjsBhS4AyDd1/vb1OGi7sZXmNZg0AVF09KzJY55SMrOC8
         BmAsBLhu+de4Kk0F4X/aSuyK16euq/BSzIHaZC69KVLlv7to4DJc5XFMyp0SBgNkmM8S
         tOAGUGP1WeSR+HiF4cZSYlzjCtE5W1UQBHzIxKU+KgWco/ik9v25waLqEiJ+SixDe0Zh
         HUwAqUEhJltFYvSk35b7WFJFpWMAO3fTBFg9n7emkb/ZLmYDBm5AC/MqAB6J5vGtmYUL
         Pyus9RPN1hHm3SVRlRpqlLUovM+UdhLUPq7NYvk9gN9xp/Gsakn5CDDNu9prgw1hqE9c
         OObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T3i9zgwcayeVl7cWKMRosEJ4OOhKmrBVCf1DuyQd0ZQ=;
        b=ELiUr4RHnicpV7ph+v21JXA/d5otIj7JmyNGPuhtZgsHe5Vvs9eIh90TBQNqzMsmkS
         C9rmvPIZU4Mb1WRk+jA9I61n0NhOBDTZ/H6PZJhIhMvm5sYmn7E4W4oZoKKgz2GE8gvG
         2GdeeXmXgKLR4M/6Bl48PjHPXjKh0sEDP1PwdHY1fvDMzvceeDX2FdZPuPMvY5CMScKT
         3b3GOqhMdHBXRcm3mwLlpv6DadYMAaYK5m9ImAQAOQb1X8OIu/dMYZc16vW/Dvtep1tO
         eOLyQkmQh1DM7KI20euhILnclFWD5edZNWc0BDYLnfSOcpyYibFmp/g9IxBak4tLantu
         IIjQ==
X-Gm-Message-State: AOAM533m8C1tXVlnTqzRZizoacfnbjOPIkciyQmscIuzemTRNJ66eeaW
        ++/A/TPx6ABBGzqFhqdE8xbWlw==
X-Google-Smtp-Source: ABdhPJw8ZtseazM51WUqhtiDVXvitp+YDlIfXCPd0LTC+fJ/cPh2CMZqRThBa00IrdH/HQDGzeNZOw==
X-Received: by 2002:a5d:58dc:: with SMTP id o28mr38899290wrf.217.1641227702500;
        Mon, 03 Jan 2022 08:35:02 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id l10sm20389876wmq.7.2022.01.03.08.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 08:35:02 -0800 (PST)
Subject: Re: [PATCH V3 1/6] tty: serial: meson: Drop the legacy compatible
 strings and clock code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-2-yu.tu@amlogic.com>
 <CAFBinCCwjS36ss_4sU+o9m8gEprFsVZbqcxgpQxczTNohZqFdA@mail.gmail.com>
 <a296e666-368b-4cd5-427e-30fc66a15b49@amlogic.com>
 <CAFBinCA2V=sx95Q=+4nLDXFK1Os11XVWtK8KauxixVwYXLUz1Q@mail.gmail.com>
 <3865f01c-83f7-a69d-6835-c26f662629b7@baylibre.com>
 <YdMUEzStFf99EeQ5@kroah.com>
 <df9e472e-ac17-26ed-d820-e80d5b7b0e80@baylibre.com>
 <YdMkc2YQcYjgR7Qk@kroah.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <257d153c-960a-59fc-dfa9-5e160e42b68d@baylibre.com>
Date:   Mon, 3 Jan 2022 17:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdMkc2YQcYjgR7Qk@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 17:29, Greg Kroah-Hartman wrote:
> On Mon, Jan 03, 2022 at 04:29:56PM +0100, Neil Armstrong wrote:
>>>> Would it be possible we also receive the notification when those patches are applied ?
>>>> Maybe a MAINTAINERS entry is missing so we can receive them ?
>>>
>>> That would be good, so that people can review the patches.  Otherwise I
>>> have to just guess :)
>>
>> exact, I naively thought it would be matched in the:
>> N:      meson
>> entry but it seems an proper entry for drivers/tty/serial/meson_uart.c is needed.
> 
> Try it, does that work when running get_maintainer.pl on this patch?

Yes it does work, so no problem here

> 
>>>> It would help me track those TTY and USB patches more easily.
>>>
>>> I recommend MAINTAINERS entries for drivers that are not listed and that
>>> you care about seeing the changes for.
>>
>> This is why we have a regex to match these.
> 
> Great, the submitter should have used that.
> 
>> I can submit a patch to have a proper entry if the regex is not enough/appropriate.
> 
> Whatever makes the tools work is fine with me.
> 
>> BTW can you point us how are selected the recipients of the notification messages you send ?
> 
> For when I apply a patch, everyone on the ack/signed-off-by/reviewed-by
> list gets a response.  I do not hit mailing lists with the notification
> as that's just too much noise.
> 
> Been doing it this way for well over a decade now, nothing new here :)

Ok right, no problem, other maintainers (e.g: net, sound) and default b4 behavior is to
send notification to same recipient as original patch.

It it fits everyone for a decade, no need to change ! We have very low patches for tty & usb anyway

Neil

> 
> thanks,
> 
> greg k-h
> 

