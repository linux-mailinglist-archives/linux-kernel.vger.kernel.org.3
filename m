Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC0484C38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiAEBrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiAEBrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:47:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0B0C061761;
        Tue,  4 Jan 2022 17:47:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so1754579pjd.1;
        Tue, 04 Jan 2022 17:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=imp118HYV1DWxGEsD11+Hr9WN13p66zmRTK4oaqzyEI=;
        b=QeeZJC10u29P10Hhw8hCsqdJCccO1JRoyF5h5i7jm928CC1V1UDbtKcFHGLWuyBxs6
         EtskkFxpJDjxbo5oa1uZHWrMFOVuleTNBE5ArMkE//ycbuwyTa++2sbtNpqy3U/Q83bV
         /8IPeNnjvimLuuLcrqbiqjaLKSkZ5Stb9AiBVL3ar4RKWZODNckvdQuLf9kYpDiCTyt1
         MEAIDkaronOAExex4xhY5bR+5U8O0J3c6BWWl1Gq2Q8ekWGezqXLc6R7kq974jsfZ9zJ
         H0a5uvjHF9W8pm7u3NKkZ6bQcam+0h7Iq2NyeIJmAH79PRQTKKos8ZPq//SZCfaisXlL
         zA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=imp118HYV1DWxGEsD11+Hr9WN13p66zmRTK4oaqzyEI=;
        b=Xn8kEbGjJiYXbpFVpNonhXi2flnrTH3O5h1iBNvNCkdiBxmhVXOu9a6O2SAqpx2Px8
         i8jpHtDON6gQ7gdnLuaxljt1LRL6PtdDXkvD18uI4kDtguCVnQheKOo6VgGpSmQiXmnJ
         UNG5/wH6UxJJ4AjlnLaUeq/0iT9tY9xo3rIFKbYqbR6xpUx6tbklyINeSa5I1CZMY8Yv
         42bzcypta13/tJSRdqfy7YKkOzchYm0+RN1KYX2k2odQMflZuMXVXTm5XIbFaYEOycjB
         iJxqpr8qSB/XkuuwSPS8LB1aLcktILwceESQYu1D77pQ9ywAnQicgUA2gSiY628Qwgul
         HqrQ==
X-Gm-Message-State: AOAM531iUPeK7AFeXbjdE+uHmSyZWSkw15bSes2W1YE7SsXRdivtJrjn
        Ijm+MxIJObrO5jot7tnSZfk=
X-Google-Smtp-Source: ABdhPJxK+SOHC1JtJMLS7Q3ZUg+dFjbvROILI6t0Jv6yyGDaUlnlIGok24OG4JES6cx9cLqBVKru+g==
X-Received: by 2002:a17:903:22ca:b0:149:b1e2:a8ca with SMTP id y10-20020a17090322ca00b00149b1e2a8camr17704930plg.46.1641347263445;
        Tue, 04 Jan 2022 17:47:43 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h5sm524862pjc.27.2022.01.04.17.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 17:47:43 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
 <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com>
 <20220104131952.GA21933@lst.de>
 <2fb003aa-545c-31a4-1466-8c3c3fc708fb@gmail.com>
Message-ID: <0ee407a1-ff5a-4c04-a99e-045cfe90d850@gmail.com>
Date:   Wed, 5 Jan 2022 10:47:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2fb003aa-545c-31a4-1466-8c3c3fc708fb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 22:46:57 +0900, Akira Yokosawa wrote:
> On Tue, 4 Jan 2022 14:19:52 +0100, Christoph Hellwig wrote:
>> On Tue, Jan 04, 2022 at 06:31:01PM +0900, Akira Yokosawa wrote:
>>> Hi, getting back to the error message, I remember seeing a similar error
>>> when I failed to permit PDF output of ImageMagick.
>>>
>>> What I did back then was this (as root):
>>>
>>>  # cd /etc/ImageMagick-6  
>>>  # sed -i 's+policy domain="coder" rights="none" pattern="PDF"+policy domain="coder" rights="read|write" pattern="PDF"+' policy.xml ; \
>>>
>>> In case this resolves your issue.
>>
>> I've definitively seen permission denied errors earlier in the (rather
>> noisy) build log.  But I absolutely do not feel comfortable changing
>> global security policies for a kernel build, especially for something
>> like ImageMagic that had its fair share of security issues.  Is there any
>> way to side step this by using a different tool?
>>
> 
> See my pending patch set at:
> 
>     https://lore.kernel.org/linux-doc/e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com
>     [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
> 
> This uses Inkscape if it is available instead of ImageMagick.
> No imagemagick nor librsvg2-bin is required.
> As long as if you can trust Inkscape...
> 
> Good luck!

Alternatively, you can avoid ImageMagick by installing
graphicsmagick-imagemagick-compat instead of imagemagick.

I'm not sure what you think of GraphicsMagick, though.

If you'd like to try, do:

    $ sudo apt install graphicsmagick-imagemagick-compat ghostscript gsfonts-x11

This will remove ImageMagick.
(You have ghostscript and gsfonts-x11 already installed, I guess.)

        Thanks, Akira

> 
>         Thanks, Akira
> 
