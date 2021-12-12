Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8C47192F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhLLH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLLH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:59:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19AEC061714;
        Sat, 11 Dec 2021 23:59:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z6so12277878pfe.7;
        Sat, 11 Dec 2021 23:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ioi42BQ6vHLIjYS1+OM6J++/wIyDwKpFVwDudzXdcWY=;
        b=LFapcroOPUAlIzAi/yrdDlejzL+u8oHR6Nj+kXFPOfscgNU2CKIPaGkSjlUnd1t14r
         yzOHwWYiZ0NwqmCsg60TOCEYccjJvw6XJk8DUodq/QaFjLS0/COuCE9ZmDP8eGpp48hl
         A5iQv1WHeRx7NsKdolF4JDKsXryBIb+tyjI9+bGJEzgF4HHC5T5g2r8EyyyUf0aiY7VO
         EeJYfR1yEX/ebt5rHwGWREIgiznq6wdAm3H7r5jx4s6qZB2Ydl8b6eWxITF8aB6Zsa7x
         VUnUvXnp/LHjwA73XLDVq8BKCTQEBL9IVXZD3B8rYUM4llZlNLBhgEyn2ienMPfqVUcU
         VKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ioi42BQ6vHLIjYS1+OM6J++/wIyDwKpFVwDudzXdcWY=;
        b=HtJFeL0pUFYiidZ3xN7eYsxI31AMHDaze4sqeBEX7r+lYK1aUon9Iq83EvB37hVMYv
         uTqmZMAXDFOSwMN/h9eQJWOcb4JkL5crIgzLrCQGgH5W5WXaH7K+C6FZqLmVVm5Jk/7/
         Y5WKt8g/XYUimFgCAHh7/y+0spCTHh2q0/0SqpomT9o3h8HKT9roGgXjQ931aHLy89Z4
         6cZSB6cuzVBTeI4Qa3lsMJbtCM6P6nWLj/I0qTRK/C1ugpL1UtF5HvtjRgiQZKxL1BMr
         2bJK5dxudqJRVJRaOVFFXx26U/d1ein6zDHSd67n4EsmT4MoAKGMjNTXMZ8GEeuw2zBF
         NeCQ==
X-Gm-Message-State: AOAM532jr3Lg4H/CE7R5IUGhG7N3te2bprDIVp6dwBtFxBLCyZbXEHDs
        AuU94W0CT5NQIY6SkDdIlPWv9fDxvz4=
X-Google-Smtp-Source: ABdhPJxDkERkWD8OMwnTmiTwjd90Sf8zIM6LHD9t3XrsNNG00JAgvqtzd601F7vZKkwhgQYDVV13JA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr47675032pgc.478.1639295997327;
        Sat, 11 Dec 2021 23:59:57 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i9sm3149198pgc.27.2021.12.11.23.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 23:59:56 -0800 (PST)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
Message-ID: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
Date:   Sun, 12 Dec 2021 16:59:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set improves conversions of DOT -> PDF and SVG -> PDF
for PDF docs.

* DOT -> PDF conversion

Current scheme uses "dot -Tpdf" (of graphviz).

Cons:
  - openSUSE's dot(1) does not support -Tpdf.
  - Other distro's dot(1) generates PDFs with unnecessarily wide
    margins for inclusion into LaTeX docs.

Patch 1/3 changes the route to two steps:

  1. DOT -> SVG by "dot -Tsvg"
  2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1).

Pros:
  - Improved portability across distros
  - Less space for graphs in final PDF documents

Con:
  - On systems without rsvg-convert, generated PDF will be of raster
    image.


* SVG -> PDF conversion

Current scheme uses convert(1) (of ImageMagick)

Cons:
  - Generated PDFs are of raster image.  Some of them look blurry.
  - Raster image tends to be large in size.
  - convert(1) delegates SVG decoding to rsvg-convert(1).
    It doesn't cover full range of Inkscape specific SVG features
    and fails to convert some of SVG figures properly.

Failed conversions are observed with:
  - Documentation/userspace-api/media/v4l/selection.svg
  - Documentation/userspace-api/media/v4l/vbi_525.svg
  - Documentation/userspace-api/media/v4l/vbi_625.svg

If you have Inkscape installed as well, convert(1) delegates SVG
decoding to inkscape(1) and the above SVGs are rendered correctly.

So if Inkscape is required for converting those SVGs, why not use it
directly in the first place?

Patch 2/3 adds a route of SVG -> PDF conversion by inkscape(1).
Patch 3/3 hides warning messages from inkscape(1) which are harmless
in command-line uses.

Pros:
  - Generated PDFs are of vector graphics.
  - Vector graphics tends to be smaller in size and keeps looking nice
    while zoomed in.
  - SVGs drawn by Inkscape are fully supported.

On systems without Inkscape, there won't be any change in behavior.

        Thanks, Akira
--
Akira Yokosawa (3):
  docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
  docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion
  docs: sphinx/kfigure.py: Redirect warnings from inkscape to /dev/null

 Documentation/sphinx/kfigure.py | 109 ++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 12 deletions(-)


base-commit: a32fa6b2e8b4e0b8c03f5218afa0649e188239c5
-- 
2.17.1

