Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7694719EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhLLL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:57:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C14C061714;
        Sun, 12 Dec 2021 03:57:26 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r130so12610140pfc.1;
        Sun, 12 Dec 2021 03:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vIl20/h83gPX8DqX2Q2jOQdMMAQs+Q+Ug9e7SVCSWY=;
        b=kym3K/3ZDRMl98nMaU9H3Iw01LoM7f37qj612HnxBUt9S9iJGIh1Qr1bfwTn2E5M+h
         SUVnc6vXL6VDI5Ka7lBXnpyyEZMfyFd2laBp/NP2+03CZyXQqjdTo2E/TaS3rmQH2/+r
         7LeJH/vqHOStmWcOEZORTDAog7Euzojb1nVcYxhAgvyncVRBdyzkSi4CyslcIOxpB4zR
         hBoYDQ+PpRAeY/iIZo1sK/A3poquw14gNEK01HmwA4c8Im3OsOz3+1YOH+R1FvsQXrn8
         LRYWPAOuHgnMWWCe5ji6NKdEwWCJuJXy9bEJVjXdzlePZTveKYH7NvWpw7vueRRzrKTk
         GGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vIl20/h83gPX8DqX2Q2jOQdMMAQs+Q+Ug9e7SVCSWY=;
        b=tso2JqZJ/EgkJsEe0JdksG7Az29aMAIieeHoamU7ZZtk1MK1kSRkJNOEPOPFgaD0Zf
         1vuRbIcVZBivsZIGq8mLqFnvyuwxxrtGziXG8/MDO+11dnw9I/eH85AFm05r+q1os5TT
         3mFHHSNWy3CutJqw2YUl28PJ5m8pHKxbVnydpH6CBzdXKzlfxN+IPSPJgEV5i31/zuY0
         L+pKp6ERRXtEyCvHBT+I+EBCKuL8VEhXqgtGyzO4YyXq3ruUJUds/hWr+JgyBe76ndco
         26ZQnkhsJof5phl2RZS0eUXZ1FnQSx2reKOcV48aF37pTJuR1pA59mWRGCIm1nhXLqYO
         oPZQ==
X-Gm-Message-State: AOAM530s+qGyCP+KEUGPcJOihDJQ6C0t8thqoy2dj5/TwyczpIeZbk9b
        eP1YUnBvvhmbMmmiekn/Jt08XH/tuEQ=
X-Google-Smtp-Source: ABdhPJzlcGdV2tFdchMNaUGeQNXY/glNCzcB30U83c/T8OFnJIukA8XaguWL5YBRQ7R9aNmCIz/X5w==
X-Received: by 2002:a05:6a00:23c4:b0:49f:e054:84cb with SMTP id g4-20020a056a0023c400b0049fe05484cbmr28062955pfc.63.1639310246164;
        Sun, 12 Dec 2021 03:57:26 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f8sm9491836pfc.77.2021.12.12.03.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 03:57:25 -0800 (PST)
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
 <20211212113813.058e99fc@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8840a859-ca57-c49a-f542-0a37401ccdfc@gmail.com>
Date:   Sun, 12 Dec 2021 20:57:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211212113813.058e99fc@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 11:38:13 +0100, Mauro Carvalho Chehab wrote:

Hi Mauro,

I didn't expect such a quick response.
Thank you so much!

> Em Sun, 12 Dec 2021 16:59:53 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> This patch set improves conversions of DOT -> PDF and SVG -> PDF
>> for PDF docs.
>>
>> * DOT -> PDF conversion
> 
> First of all, package requirement for docs generation should be auto
> discovered by:
> 
> 	scripts/sphinx-pre-install

Please note that this update does not change any requirement.
I think you are worried by the possible degradation of DOT rendering
without rsvg-convert.  Please see comments below.

> 
> and should not break the ones detected by check_distros() and that
> supports PDF generation.
> 
>>
>> Current scheme uses "dot -Tpdf" (of graphviz).
>>
>> Cons:
>>   - openSUSE's dot(1) does not support -Tpdf.
> 
> I'm sure I tested pdf generation in the past with openSUSE by the
> time I wrote sphinx-pre-install script. Perhaps some change at either
> openSUSE or at the docs makefile broke support for it.

dot -T? on openSUSE Tumbleweed says (long line folded):

Format: "?" not recognized. Use one of: canon cmap cmapx cmapx_np dot dot
_json eps fig gd gd2 gif gv imap imap_np ismap jpe jpeg jpg json json0 mp
 pic plain plain-ext png pov ps ps2 svg svgz tk vml vmlz vrml wbmp xdot
 xdot1.2 xdot1.4 xdot_json

There is no "pdf" here.

> 
>>   - Other distro's dot(1) generates PDFs with unnecessarily wide
>>     margins for inclusion into LaTeX docs.
>>
>> Patch 1/3 changes the route to two steps:
>>
>>   1. DOT -> SVG by "dot -Tsvg"
>>   2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1).
> 
> rsvg-convert is not present on Fedora (nor on RHEL and CentOS), as far
> as I'm aware.

It is provided in the "librsvg2-tools" package, which is suggested by
sphinx_pre_install.
So once you have it installed on Fedora/RHEL/CentOS, this change won't
cause any regression.

Don't you agree?

> 
>> Pros:
>>   - Improved portability across distros
>>   - Less space for graphs in final PDF documents
>>
>> Con:
>>   - On systems without rsvg-convert, generated PDF will be of raster
>>     image.
> 
> Raster images are a very bad idea. Why don't keep use "dot -Tpdf" when
> supported by the system? instead of falling back to raster images?

I suppose I am able to do so.  I just thought installing rsvg-convert
wouldn't be that difficult.
I can add a patch in v2 if you insist that is necessary.

> 
>> * SVG -> PDF conversion
>>
>> Current scheme uses convert(1) (of ImageMagick)
>>
>> Cons:
>>   - Generated PDFs are of raster image.  Some of them look blurry.
>>   - Raster image tends to be large in size.
>>   - convert(1) delegates SVG decoding to rsvg-convert(1).
>>     It doesn't cover full range of Inkscape specific SVG features
>>     and fails to convert some of SVG figures properly.
>>
>> Failed conversions are observed with:
>>   - Documentation/userspace-api/media/v4l/selection.svg
>>   - Documentation/userspace-api/media/v4l/vbi_525.svg
>>   - Documentation/userspace-api/media/v4l/vbi_625.svg
> 
> What do you mean by failed? With the current way, the VBI ones
> seem OK to me:
> 
> 	https://linuxtv.org/downloads/v4l-dvb-apis-new/pdf/media.pdf

By "fail", I meant "fail to render properly.

selection.svg is rendered on page 810 in your PDF.
I think the mask strap is lost in the figure.
Well, selection.svg has Inkscape specific elements for the strap.
So it is not rendered in a browser, either.

If you open it in Inkscape, I think you will see the difference.
Actually speaking, I have edited selection.svg so that it can
be rendered in a browser.  My plan is to send it as an independent
patch once this patch set is accepted.

Figures 10, 11, and 12 on pages 1031 and 1032 don't look good
either.  Do you see what I mean?

> 
> (This is daily updated. On today's build the raw VBI ones are in
> page 1031/1032)
> 
> Do you mean that your changes caused a regression there?

Of course not!

> 
>> If you have Inkscape installed as well, convert(1) delegates SVG
>> decoding to inkscape(1) and the above SVGs are rendered correctly.
>>
>> So if Inkscape is required for converting those SVGs, why not use it
>> directly in the first place?
> 
> I remember that the main focus were to be able to generate PDF at the
> major distros. It should be OK to use whatever tool, provided that it
> won't cause regressions with such distros. Not that is should matter
> much for the others, but my particular interest is that it shouldn't
> cause regressions neither on Debian nor on Fedora, as those are the 
> ones I use for PDF generation. Debian is used at linuxtv.org, where we
> do automate builds for PDF, ePUB and HTML. Fedora is what I used locally,
> in order to test and fix issues on media PDF document output.

I have tested this change on Debian and Fedora systems as well as
openSUSE, Arch, and other distros.
I'd say it works flawlessly.

I'd appreciate if you could give a try on your systems.

Thanks for your feedback.
I am willing to improve the quality of the PDF docs further.

        Thanks, Akira

> 
>> Patch 2/3 adds a route of SVG -> PDF conversion by inkscape(1).
>> Patch 3/3 hides warning messages from inkscape(1) which are harmless
>> in command-line uses.
>>
>> Pros:
>>   - Generated PDFs are of vector graphics.
>>   - Vector graphics tends to be smaller in size and keeps looking nice
>>     while zoomed in.
>>   - SVGs drawn by Inkscape are fully supported.
>>
>> On systems without Inkscape, there won't be any change in behavior.
>>
>>         Thanks, Akira
>> --
>> Akira Yokosawa (3):
>>   docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
>>   docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion
>>   docs: sphinx/kfigure.py: Redirect warnings from inkscape to /dev/null
>>
>>  Documentation/sphinx/kfigure.py | 109 ++++++++++++++++++++++++++++----
>>  1 file changed, 97 insertions(+), 12 deletions(-)
>>
>>
>> base-commit: a32fa6b2e8b4e0b8c03f5218afa0649e188239c5
> 
> 
> 
> Thanks,
> Mauro
> 
