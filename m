Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2247485B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhLNQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhLNQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:39:27 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E060C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:39:27 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so21373181oto.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1RKIABzLXozSTYS++5X2nHFwuaAyVJUV7kAQnW/Xd0=;
        b=D91xl2OmQ74oHpYWWwhABoBP4k1YJA4auMst9K+kAAgId5wpMHVlK/k7aGk0rsNgTZ
         G6W5k9ZEGoWTTtfM4DNODVuEsJzADZCnPixQ/2Y6abECGOgIg80eHVlue2LxysmfPSah
         GP/w4RvwT9XFOVgYwQgsdXpU+LyjLu7jV4efo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1RKIABzLXozSTYS++5X2nHFwuaAyVJUV7kAQnW/Xd0=;
        b=7p2kO9kZPTz8nA2tJMjc/c9jqGl2KR14IN7GXiF1Ke+kTYIimykL0KYjonPhbB3mf1
         CgBV04DYrljqU5q8Kwx7OayQ+G96QU9rSkZ5P6Jk6Cpleh67FHH6j335+NPCqLrPuW2v
         NBCKZfLAeWMKN5e9doPuimydlzHNzGWH0KhQ9u5aQVkX1C7pgBsbgUm01Ca3BiuwgjDK
         o7NUH6zkBOhIxNieaQ1zMOLwdVPiG7rk/teq+v9swfAd+5atQw2qqRcu4QrfifFNgjRY
         ADPjUvbXtdd3502vD9gWbPP1iYcBy9ITpb/i+ZI/0akm/PmvSym7SrA9QSl77rHPaVzt
         0uTg==
X-Gm-Message-State: AOAM532cUHQTFgW4a8s1KyNObOoEzo5Gma3xUtST/oHMrDB44fmszFyA
        vbwiSRe67kjYQdTs8LZjSBdU2w==
X-Google-Smtp-Source: ABdhPJz1b/E9tBP/pB4bUKn2ekqxvbKXfIAzaBvJQMlh60PGDAN1MGP18Ag/jAVnbMNq0n1H/1vbpA==
X-Received: by 2002:a9d:7459:: with SMTP id p25mr5038261otk.247.1639499966418;
        Tue, 14 Dec 2021 08:39:26 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j5sm64501oou.23.2021.12.14.08.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 08:39:26 -0800 (PST)
Subject: Re: linux-next: manual merge of the xarray tree with the kselftest
 tree
To:     broonie@kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211213222443.474487-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1dcd2d43-cf39-3b4c-49b5-138d94f34433@linuxfoundation.org>
Date:   Tue, 14 Dec 2021 09:39:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211213222443.474487-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 3:24 PM, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the xarray tree got a conflict in:
> 
>    tools/include/linux/kernel.h
> 
> between commits:
> 
>    d6e6a27d960f9 ("tools: Fix math.h breakage")
>    066b34aa5461f ("tools: fix ARRAY_SIZE defines in tools and selftests hdrs")
> 
> from the kselftest and origin trees and commit:
> 
>    f2aa11fd51440 ("tools: Fix math.h breakage")
> 
> from the xarray tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc tools/include/linux/kernel.h
> index 9701e8307db02,3e8df500cfbd4..0000000000000
> --- a/tools/include/linux/kernel.h
> +++ b/tools/include/linux/kernel.h
> 

Thank you. I will keep track of this when I send pull request.

thanks,
-- Shuah
