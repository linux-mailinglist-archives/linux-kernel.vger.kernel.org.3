Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183E34A55B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiBADwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiBADwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:52:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF51C061714;
        Mon, 31 Jan 2022 19:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ZzioqqgLZdVxmKvLRkJFf0foSG1h34D0rS7M26dR5rE=; b=nqdFFjdKrmNfyfxWsDzlL5sLkD
        Qe4jym8NDMKyWBAECaonK3yp1aOfch8o181A5ygatDqNi4ghJHVoCWKG3H+TTfpb+SN+sGiY41JJU
        WlE/g6fHe7lhpim9+IRI/akMfha35KJz8g+Q5ckyHAkZAXYK91JeK3ASoNy7jCnUh2UfWX/vyd6rO
        4zzdPI/5pLBYlCatyM5oQvtkuxxJ4MME6qg/r+oieSLwjRCaFtPO3rCFG05drr6W8F5i0sHR/VURb
        uUykUqo3T/ie8pp/x//lUPL81LJEVkBj/Ja3bh1rJE7rJag0ofmcqDNuGZQHvcTaryZIV4oCSbhe2
        vbgWgoFg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEkDk-005j5N-Cd; Tue, 01 Feb 2022 03:52:44 +0000
Message-ID: <d6bb8733-6e6b-0479-d723-0bbdb65ae994@infradead.org>
Date:   Mon, 31 Jan 2022 19:52:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] gpio/consumer.h: don't use "/**" for non-kernel-doc
 comments
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org
References: <20220130073103.26792-1-rdunlap@infradead.org>
 <CACRpkdYsqXqfxDbovvKOED-wbBOC3Q0OQqN-20LtmLt4SD-Orw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CACRpkdYsqXqfxDbovvKOED-wbBOC3Q0OQqN-20LtmLt4SD-Orw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/22 03:24, Linus Walleij wrote:
> On Sun, Jan 30, 2022 at 8:31 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Use "/*" to begin non-kernel-doc comments instead of "/**",
>> which indicates the beginning of kernel-doc notation.
>>
>> Quietens these kernel-doc warnings:
>>
>> consumer.h:13: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
>> consumer.h:13: warning: missing initial short description on line:
>>  * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
>> consumer.h:22: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  * Opaque descriptor for a structure of GPIO array attributes.  This structure
>> consumer.h:22: warning: missing initial short description on line:
>>  * Opaque descriptor for a structure of GPIO array attributes.  This structure
>> consumer.h:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  * Struct containing an array of descriptors that can be obtained using
>> consumer.h:30: warning: missing initial short description on line:
>>  * Struct containing an array of descriptors that can be obtained using
>> consumer.h:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  * Optional flags that can be passed to one of gpiod_* to configure direction
>> consumer.h:46: warning: missing initial short description on line:
>>  * Optional flags that can be passed to one of gpiod_* to configure direction
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>> Cc: linux-gpio@vger.kernel.org
> 
> In this case the ambition was to provide proper kerneldoc for sure.

Well, the 2 opaque warnings (lines 13 and 22) are just bare "struct gpio_zzz;",
so kernel-doc wouldn't be appropriate there. Those structs are in drivers/gpio/gpiolib.h
(for anyone else who is reading along) -- and not documented there either.

For the other 2 /** warnings, I don't think that I am the right person
to add kernel-doc info for them...

> Is it possible to just fix the documentation?

or just ignore this patch.

-- 
~Randy
