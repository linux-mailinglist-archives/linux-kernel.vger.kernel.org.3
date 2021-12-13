Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9296F4721FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhLMHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhLMHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:53:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D22C061748;
        Sun, 12 Dec 2021 23:53:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u17so10569454plg.9;
        Sun, 12 Dec 2021 23:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E7mXB7QgVV2bvYYxMKcO5csIxbT0JJKHqkP+7lZmOOY=;
        b=KYNtAlBIYGNNQecVW5YOdzlyd2yPX3FGSJ2UA5D2ykToM6/S8tAGtvTAy1UmChltHp
         eld4OOiQVin5UlsavS5EwBjv1YBt9yXG/2xY5aItl1QKVlZJFgw9L5W1ilbc3Nfh0QSC
         MfXa6MgqrzinNZT+CiipwbsDvVz5mHPGYfKIRYm1D/V7nN5oehjU8iYTid6pvi9dpOCJ
         5xxOpV9yt/K4a8hn6zrRPjRlSYeuk4qJJQSXXz2lMRKhJGGdQecurBont2k8SmQ3OW38
         4oXl+uDFwv+5AO5bq5BdgLbK9xL74q1h5Dud0JbWj3VrB/UU0crOL8HyRNj4rIbR8MZl
         0gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E7mXB7QgVV2bvYYxMKcO5csIxbT0JJKHqkP+7lZmOOY=;
        b=tehpWfppHD/AFvZYV+npmrkICx6OmVMqBscTgLtQ0pETqbJfMiuQT7Cfy08Ir7w/D+
         cSRR+mIvWHBiRdR3yAQo0JsY7411cePZFdUoyj8y1iNYRJCQCqrec+gOCWh3TyMv2b+f
         XcGMGfU1WWkz7V4Catp3LgQJuQ3YQ20pU6zYRKAm39WxjYQH2IdvljElPSk2/CPhjTUJ
         nV8WZ4GrNxELKRAGq0HZruW28RHL+eXH546SrU9UsYI2nZnxaVQM27b9XeEkhVQVkdZf
         AIAu4hni/qu7Hx9DzgUFl5glDcRrxIWQuQfgWiOL3YZsHM6r5Ql8nnr/M1n4RKGQ6bSZ
         wb3w==
X-Gm-Message-State: AOAM533+sdbP5ocQtd2cAHDhFqEDQ7dOf9dQArguhYLsBB+KXG+O3rGE
        89XElSoVpIhUa2pSK5QWNqA=
X-Google-Smtp-Source: ABdhPJxwxkzO5B+pKxqKjYZjfrkOEtTrdSzYBUOZBO2p2yCvSJcgcVaY/nZS/UcLI//Jgu4yLeDiBQ==
X-Received: by 2002:a17:903:1208:b0:143:e4e9:4ce3 with SMTP id l8-20020a170903120800b00143e4e94ce3mr93325766plh.21.1639381992088;
        Sun, 12 Dec 2021 23:53:12 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h20sm9373362pgh.13.2021.12.12.23.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:53:11 -0800 (PST)
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
 <20211212113813.058e99fc@coco.lan>
 <8840a859-ca57-c49a-f542-0a37401ccdfc@gmail.com>
 <20211213073327.11191087@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <60d50d23-e236-1105-dc2c-d6daca70e326@gmail.com>
Date:   Mon, 13 Dec 2021 16:53:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213073327.11191087@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 07:33:27 +0100, Mauro Carvalho Chehab wrote:
> Em Sun, 12 Dec 2021 20:57:23 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Sun, 12 Dec 2021 11:38:13 +0100, Mauro Carvalho Chehab wrote:
>>
>> Hi Mauro,
>>
>> I didn't expect such a quick response.
>> Thank you so much!
>>
>>> Em Sun, 12 Dec 2021 16:59:53 +0900
>>> Akira Yokosawa <akiyks@gmail.com> escreveu:
>>>   
>>>> This patch set improves conversions of DOT -> PDF and SVG -> PDF
>>>> for PDF docs.
>>>>
>>>> * DOT -> PDF conversion  
>>>
>>> First of all, package requirement for docs generation should be auto
>>> discovered by:
>>>
>>> 	scripts/sphinx-pre-install  
>>
>> Please note that this update does not change any requirement.
> 
> Ok.
> 
>> I think you are worried by the possible degradation of DOT rendering
>> without rsvg-convert.  Please see comments below.
>>
>>>
>>> and should not break the ones detected by check_distros() and that
>>> supports PDF generation.
>>>   
>>>>
>>>> Current scheme uses "dot -Tpdf" (of graphviz).
>>>>
>>>> Cons:
>>>>   - openSUSE's dot(1) does not support -Tpdf.  
>>>
>>> I'm sure I tested pdf generation in the past with openSUSE by the
>>> time I wrote sphinx-pre-install script. Perhaps some change at either
>>> openSUSE or at the docs makefile broke support for it.  
>>
>> dot -T? on openSUSE Tumbleweed says (long line folded):
>>
>> Format: "?" not recognized. Use one of: canon cmap cmapx cmapx_np dot dot
>> _json eps fig gd gd2 gif gv imap imap_np ismap jpe jpeg jpg json json0 mp
>>  pic plain plain-ext png pov ps ps2 svg svgz tk vml vmlz vrml wbmp xdot
>>  xdot1.2 xdot1.4 xdot_json
>>
>> There is no "pdf" here.
> 
> Tumbleweed is a rolling distribution. Something could have changed since
> when I added support for it. Anyway, the script could check the output of
> it to enable/disable pdf via dot (not saying it is worth or not).

I found a related message of yours in the lore archive:

   https://lore.kernel.org/all/20170715162741.0e4f1298@vento.lan/

It has no follow-up messages though.
Do you remember something further about dot(1) on Tumbleweed?


>>>   
>>>>   - Other distro's dot(1) generates PDFs with unnecessarily wide
>>>>     margins for inclusion into LaTeX docs.
>>>>
>>>> Patch 1/3 changes the route to two steps:
>>>>
>>>>   1. DOT -> SVG by "dot -Tsvg"
>>>>   2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1).  
>>>
>>> rsvg-convert is not present on Fedora (nor on RHEL and CentOS), as far
>>> as I'm aware.  
>>
>> It is provided in the "librsvg2-tools" package, which is suggested by
>> sphinx_pre_install.
>> So once you have it installed on Fedora/RHEL/CentOS, this change won't
>> cause any regression.
>>
>> Don't you agree?
> 
> Yeah, I missed that. Thanks for reminding me about that ;-)

You are welcome.

> 
>>>   
>>>> Pros:
>>>>   - Improved portability across distros
>>>>   - Less space for graphs in final PDF documents
>>>>
>>>> Con:
>>>>   - On systems without rsvg-convert, generated PDF will be of raster
>>>>     image.  
>>>
>>> Raster images are a very bad idea. Why don't keep use "dot -Tpdf" when
>>> supported by the system? instead of falling back to raster images?  
>>
>> I suppose I am able to do so.  I just thought installing rsvg-convert
>> wouldn't be that difficult.
>> I can add a patch in v2 if you insist that is necessary.

I'm working on a test of "dot -Tpdf".
I'll post it as a follow-up of [PATCH 4/3] to this patch set when
it's ready.
It will be slightly different from your suggestion.
"dot -Tpdf" will be used only when both of rsvg-convert(1) and inkscape(1)
are unavailable, and "-Tpdf" is supported.
I think this is sufficient for preventing regressions on existing
systems.

>>
>>>   
>>>> * SVG -> PDF conversion
>>>>
>>>> Current scheme uses convert(1) (of ImageMagick)
>>>>
>>>> Cons:
>>>>   - Generated PDFs are of raster image.  Some of them look blurry.
>>>>   - Raster image tends to be large in size.
>>>>   - convert(1) delegates SVG decoding to rsvg-convert(1).
>>>>     It doesn't cover full range of Inkscape specific SVG features
>>>>     and fails to convert some of SVG figures properly.
>>>>
>>>> Failed conversions are observed with:
>>>>   - Documentation/userspace-api/media/v4l/selection.svg
>>>>   - Documentation/userspace-api/media/v4l/vbi_525.svg
>>>>   - Documentation/userspace-api/media/v4l/vbi_625.svg  
>>>
>>> What do you mean by failed? With the current way, the VBI ones
>>> seem OK to me:
>>>
>>> 	https://linuxtv.org/downloads/v4l-dvb-apis-new/pdf/media.pdf  
>>
>> By "fail", I meant "fail to render properly.
>>
>> selection.svg is rendered on page 810 in your PDF.
>> I think the mask strap is lost in the figure.
>> Well, selection.svg has Inkscape specific elements for the strap.
>> So it is not rendered in a browser, either.
> 
> Ok, so we should fix selection.svg to address such issues. The same applies
> to other images and graphs. That may include properly setting the margins.

SVGs of the other images and graphs are rendered properly in a browser.
So I don't think those need fixes.  I'd say it's defects of
rsvg-convert, which the Gnome project might or might not be willing
to fix.  Or might have been fixed in a later versions of librsvg.
Why don't you open an issue at https://gitlab.gnome.org/GNOME/librsvg ?

> 
>> If you open it in Inkscape, I think you will see the difference.
>> Actually speaking, I have edited selection.svg so that it can
>> be rendered in a browser.  My plan is to send it as an independent
>> patch once this patch set is accepted.
> 
> No matter if this is merged or not, if you find an issue at the images
> at the media docs, please send them to linux-media@vger.org.

OK. I'll compose a proper change log for it and post it later this
week or next.
(I'm not a type of person who is good at doing several things in
parallel.)

And the most easy fix is to install Inkscape on your system for
the daily build.
Then, convert(1) picks inkscape(1) for SVG rendering and you will
see right ones (of raster images, though).

You know, ImageMagick prefers inkscape over rsvg-convert.
I think it is the right thing to do in kfigure.py as well.

> 
>>
>> Figures 10, 11, and 12 on pages 1031 and 1032 don't look good
>> either.  Do you see what I mean?
>>
>>>
>>> (This is daily updated. On today's build the raw VBI ones are in
>>> page 1031/1032)
>>>
>>> Do you mean that your changes caused a regression there?  
>>
>> Of course not!
>>
>>>   
>>>> If you have Inkscape installed as well, convert(1) delegates SVG
>>>> decoding to inkscape(1) and the above SVGs are rendered correctly.
>>>>
>>>> So if Inkscape is required for converting those SVGs, why not use it
>>>> directly in the first place?  
>>>
>>> I remember that the main focus were to be able to generate PDF at the
>>> major distros. It should be OK to use whatever tool, provided that it
>>> won't cause regressions with such distros. Not that is should matter
>>> much for the others, but my particular interest is that it shouldn't
>>> cause regressions neither on Debian nor on Fedora, as those are the 
>>> ones I use for PDF generation. Debian is used at linuxtv.org, where we
>>> do automate builds for PDF, ePUB and HTML. Fedora is what I used locally,
>>> in order to test and fix issues on media PDF document output.  
>>
>> I have tested this change on Debian and Fedora systems as well as
>> openSUSE, Arch, and other distros.
>> I'd say it works flawlessly.
>>
>> I'd appreciate if you could give a try on your systems.
> 
> I'll try to run some tests today.

Thanks!

> 
>> Thanks for your feedback.
>> I am willing to improve the quality of the PDF docs further.
>>
>>         Thanks, Akira
>>
>>>   
>>>> Patch 2/3 adds a route of SVG -> PDF conversion by inkscape(1).
>>>> Patch 3/3 hides warning messages from inkscape(1) which are harmless
>>>> in command-line uses.
>>>>
>>>> Pros:
>>>>   - Generated PDFs are of vector graphics.
>>>>   - Vector graphics tends to be smaller in size and keeps looking nice
>>>>     while zoomed in.
>>>>   - SVGs drawn by Inkscape are fully supported.
>>>>
>>>> On systems without Inkscape, there won't be any change in behavior.
>>>>
>>>>         Thanks, Akira
>>>> --
>>>> Akira Yokosawa (3):
>>>>   docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
>>>>   docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion
> 
> 
>>>>   docs: sphinx/kfigure.py: Redirect warnings from inkscape to /dev/null
> 
> It sounds too risky to redirect stderr to /dev/null. Yeah, here, the output
> of inkscape is too crowd of warnings. Hacking it with a 
> SPHINX_SHOW_INKSCAPE_WARN variable also seems a bad idea.

Good points!

> 
> Not sure how this could be solved.

We might be able to filter warning messages from inkscape and display
only those we don't expect.

I'm not sure maintaining such a list of harmless messages might
be too much for us or not.

Anyway, I'll give it a try.

        Thanks, Akira

> 
> Thanks,
> Mauro
> 
