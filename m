Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB6487871
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347653AbiAGNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347641AbiAGNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:45:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDDC061574;
        Fri,  7 Jan 2022 05:45:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id iy13so5243803pjb.5;
        Fri, 07 Jan 2022 05:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i+lccBWZs92uwFfTHiY+C7P7w5QeQD6HvfPbWszHYKA=;
        b=WB3POu3MvaFnI14GT7AEAhJA/EAkXen3J6K8rXO3cqKNeQkXI9mDdbPRNyD1fhY/QK
         mtQWQ6U+2TGtgvsWxlCwm/3PcnfLxpEjCm/EKgBhhvJrO32HKufu6u6QAKs4zmgzQBSZ
         7t47bObKphlzgKBH126EHAk3y9nruMzegPyh1Leze8Sve6MGC/2Rd8dg1v0WGuRAyge0
         wTJiPEeXWSJw7Jbv3IR7gaOND9MhQPwp1JZ1yWO2OTcVQN1It7q1dGkUvKR1Zna5ziQO
         3p7rSTKmCZUCzNyxXc7dv3hhKCj/puhMyyHsu7+zpzYVFB90hXX86d/OMAPuRFIbLcvM
         EiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+lccBWZs92uwFfTHiY+C7P7w5QeQD6HvfPbWszHYKA=;
        b=M1vnVxzJiA3BoNi0Pn9ICSz/5/4qcBNfdcfsk8mHwTJt7z9h7Ipi6WNqS00Dl+08PH
         51+Qbzje1nK/T/xR38Yaw3N1UY1eCNFT/oVoOU271EnS6gadM6U4YEhOOFtqJARY4ta8
         dKdTnJxLLOiSV4r/HSqs/Iv0A8hksABbbjFN1OxFNGv1RqX4ZvbX3jc97XBYYoo6YfXH
         uPw41DDC+iaQmvCxAVtfmuTsDx24xQk7D0fFPRMepFqRA9vAGHvfXzJ/3ovRDgfWoWHU
         J6RPlPcTLlK5oMJLW8VIL2ZHHj7adYO6HbsMkXt0D2GAmaLZrlokQMxs3oUW0++OFteP
         69Rw==
X-Gm-Message-State: AOAM533zgBuWNesIau2k/oPcNXnQOrPWb4wYBFaixbaTxDeCXQXGHmVD
        GhCa0Q2aau2s9oloQUrU5Jo=
X-Google-Smtp-Source: ABdhPJzN3koh93SG9baH8JM1gF3tNPNzQNNPHi3o3DE2ULeT07sBlCdaPY/yvvCkBZLgGgUAzCQ7iQ==
X-Received: by 2002:a17:903:22c2:b0:148:fcc0:aae8 with SMTP id y2-20020a17090322c200b00148fcc0aae8mr64042522plg.148.1641563152990;
        Fri, 07 Jan 2022 05:45:52 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e30sm4566471pgb.10.2022.01.07.05.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 05:45:52 -0800 (PST)
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
Date:   Fri, 7 Jan 2022 22:45:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 20:42:00 +0900, Akira Yokosawa wrote:
> This patch set improves conversions of DOT -> PDF and SVG -> PDF
> for PDF docs.

Gentle ping.

Mauro, any comments?

> 
> * DOT -> PDF conversion
> 
> Current scheme uses "dot -Tpdf" (of graphviz).
> 
> Cons:
>   - openSUSE's dot(1) does not support -Tpdf.
>   - Other distro's dot(1) generates PDFs with unnecessarily wide
>     margins for inclusion into LaTeX docs.
> 
> Patch 1/4 changes the route to the following two steps:
> 
>   1. DOT -> SVG by "dot -Tsvg"
>   2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1)
> 
> Pros:
>   - Improved portability across distros
>   - Less space around graphs in final PDF documents
> 
> Con:
>   - On systems without rsvg-convert, generated PDF will be of raster
>     image.
> 
> Patch 2/4 avoids raster-image PDF by using "dot -Tpdf" on systems where
> the option is available.
> 
> * SVG -> PDF conversion
> 
> Current scheme uses convert(1) (of ImageMagick)

I was not aware of security concerns regarding ImageMagick until
Christoph brought them up in another thread [1].

[1]: https://lore.kernel.org/linux-doc/20220104131952.GA21933@lst.de/

Now I can add another Con as bellow.

> 
> Cons:
    - ImageMagick is not allowed to read/write PDF by default under
      Debian/Ubuntu and Gentoo systems.  The policy is a band-aide
      fix to its security issues.
>   - Generated PDFs are of raster image.  Some of them look blurry.
>   - Raster images tend to be large in size.
>   - convert(1) delegates SVG decoding to rsvg-convert(1).
>     It doesn't cover full range of Inkscape-specific SVG features
>     and fails to convert some of SVG figures properly.

        Thanks, Akira

> 
> Improper conversions are observed with SVGs listed below (incomplete,
> conversion quality depends on the version of rsvg-convert):
>   - Documentation/userspace-api/media/v4l/selection.svg
>   - Documentation/userspace-api/media/v4l/vbi_525.svg
>   - Documentation/userspace-api/media/v4l/vbi_625.svg
>   - Documentation/userspace-api/media/v4l/vbi_hsync.svg
>   - Documentation/admin-guide/blockdev/drbd/DRBD-8.3-data-packets.svg
>   - Documentation/admin-guide/blockdev/drbd/DRBD-data-packages.svg
> 
> If you have Inkscape installed as well, convert(1) delegates SVG
> decoding to inkscape(1) rather than to rsvg-convert(1) and SVGs listed
> above can be rendered properly.
> 
> So if Inkscape is required for converting those SVGs properly, why not
> use it directly in the first place?
> 
> Patches 3/4 and 4/4 add code to utilize inkscape(1) for SVG -> PDF
> conversion when it is available.  They don't modify any existing
> requirements for kernel-doc.
> 
> Patch 3/4 adds the alternative route of SVG -> PDF conversion by
> inkscape(1).
> Patch 4/4 delegates warning messages from inkscape(1) to kernellog.verbose
> as they are likely harmless in command-line uses.
> 
> Pros:
>   - Generated PDFs are of vector graphics.
>   - Vector graphics tends to be smaller in size and looks nicer when
>     zoomed in.
>   - SVGs drawn by Inkscape are fully supported.
> 
> On systems without Inkscape, no regression is expected by these two
> patches.
> 
> Changes since v1 (as of Patch 5/3) [1]:
> 
> - Reorder and merge patches to reduce/eliminate regression windows of
>   raster-image PDF and stderr redirection.
>     v1        v2
>     1/3       1/4
>     4/3       2/4
>     2/3       3/4
>     3/3+5/3   4/4
> 
> - Massage kernellog.verbose/warn messages. They now show command(s)
>   used in DOT -> PDF conversion.
> 
> - Pass actual exit code of inkscape(1) to kernellog.warn.
> 
> FWIW, diff of v1 vs. v2 follows:
> 
> --------------------------------------------------------------
[...]

