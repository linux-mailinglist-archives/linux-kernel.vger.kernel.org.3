Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4C4772FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhLPNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhLPNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:18:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B3C061574;
        Thu, 16 Dec 2021 05:18:10 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so64413000ybg.9;
        Thu, 16 Dec 2021 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZPqCPeKkF5/1MPYiuOGy4JgZ/F6BznknqA4rnfWZkI=;
        b=ahY1UDGTLwLl0X7LxleqPM1c/pjUKL+DAViFxHjNO9mU2FeRmBt8QX37I3se6mS+gB
         EZI/ZcoRmhfUE0IWvWS6Ou15q/5BHq5FA2JUh+d7EsZn10TxUShun0zrEoR95guAKGDd
         X++TWK44N+lFUw3iqNpN+UvNsYE5fBwImD8wTuIbxUlCvskH17iYwzUUHigsqaaB2Vo1
         pQzRuGZact0tfxZwYbTG39ve2gYv+TFFSpy3qzWy19SogaqzEB1oo+dtOGaEm0ofKi2a
         JsDs9ks+yzCz8tuM9/sy9useY/8afoqsBHefJIVpF40nxTIP8gLLm/o+qpBI3iprR7UR
         eX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZPqCPeKkF5/1MPYiuOGy4JgZ/F6BznknqA4rnfWZkI=;
        b=sWfJ4eKbcFjYwrPvGAgZ315aK2AJbsL4sh0Lm5qTr7kxxwclbnkJadzMDkcd8Z5mdB
         v5eI9IYNMPz+LySBK8fprpq4j/A7713dVJrqYffRa3t6G4RDGBBouTe+KyeDsg56IB8V
         g9I3eU7yoZ9grg3f4Rb3wvMgXUP/0uEamCRgd3ptA14hg3V67ehryF5UxlhhBl5Za9g0
         mlgoyvntCG/FF7V264GS7ndAixFDWTfIs/NMLypVjtnf2dIgDtPNa82IenJ1fwkYvi/5
         Wgrr9lnqUf6FnuypNfxbk6oeakbTV64XBwFuQHdN424CZIB0zN3+ix6eyuujiAGuho+2
         e+iw==
X-Gm-Message-State: AOAM532AYCI41+7yNZChZACktNOB+2fkjm4uYRYtvt6jaCKipa5JjnMm
        Tjsh+IM4dlq852LDAaGbpD4Oq18B5tV2Ambf1xT78p1dZwI=
X-Google-Smtp-Source: ABdhPJx+q2LUYLRFLsp4KRRdV3c8S9ru3NDUyZ+gyniTmQpgOReqb9DYNfRD1VRB/+X3evUVojBN+2fCqcf8P1rtVfc=
X-Received: by 2002:a25:dfd1:: with SMTP id w200mr12467763ybg.359.1639660689172;
 Thu, 16 Dec 2021 05:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
 <20211216122311.0c9d154e@coco.lan> <Ybsrdll5sqIakINT@kroah.com> <20211216131522.4e7b148d@coco.lan>
In-Reply-To: <20211216131522.4e7b148d@coco.lan>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 16 Dec 2021 14:17:59 +0100
Message-ID: <CAKXUXMwoMV_QrZjDtkjLMfsJAFN39ZQsZi3sh_iFsE8szEKTtQ@mail.gmail.com>
Subject: Re: [PATCH] media: prefer generic SPDX-License expression to
 deprecated one
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 1:15 PM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> Em Thu, 16 Dec 2021 13:05:10 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
>
> > On Thu, Dec 16, 2021 at 12:23:11PM +0100, Mauro Carvalho Chehab wrote:
> > > Em Thu, 16 Dec 2021 11:31:32 +0100
> > > Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> > >
> > > > Commit 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier") and
> > > > commit e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> > > > introduce the SPDX-License expression LGPL-2.1-or-later for some files.
> > > >
> > > > The command ./scripts/spdxcheck.py warns:
> > > >
> > > >   drivers/media/dvb-core/dmxdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > > >   drivers/media/dvb-core/dvb_demux.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > > >   drivers/media/dvb-core/dvbdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > > >   drivers/media/common/b2c2/flexcop.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > > >
> > > > The preferred SPDX expression for LGPL-2.1 or any later version is with
> > > > the more generic "+"-extension for "any later version", so: LGPL-2.1+
> > > >
> > > > This makes spdxcheck happy again.
> > >
> > > It doesn't sound right to apply such patch.
> > >
> > > See, the latest SPDX version uses LGPL-2.1-or-later:
> > >
> > >     https://spdx.org/licenses/LGPL-2.1-or-later.html
> > >
> > > And it deprecated LGPL-2.1+:
> > >
> > >     https://spdx.org/licenses/LGPL-2.1+.html
> > >
> > > So, those files are perfectly fine with regards to SPDX, and are
> > > adherent to its latest specs. We do need the latest specs on media,
> > > as our documentation is under GFDL-1.1-no-invariants-or-later, which
> > > only exists on newer SPDX versions.
> > >
> > > So, the right thing to do here seems to fix spdxcheck.py, letting it
> > > either allow both variants (as we probably don't want to replace it
> > > everywhere) or to emit a warning if the deprecated ones are used.
> >
> > No, we are not going to add a "warning" for older SPDX versions like
> > that, otherwise the majority of the kernel will start spitting out
> > warnings.
> >
> > Let's worry about actually fixing all of the files that do NOT have SPDX
> > tags before even considering to move to a newer version of the spec.  We
> > started this work before the FSF made the crazy change to their tags,
> > let's not worry about any deprecated issues at the moment.
>
> Yeah, agreed.
>

Sorry, I first read the section Deprecated License Identifiers on
https://spdx.org/licenses/, where it stated:

Release 2.0 of the SPDX Specification introduced License Expressions
that supports the ability to identify common variations of
SPDX-identified licenses without the need to define each potential
variation as a distinct license on the SPDX License List. This new
syntax supports the ability to declare an SPDX-identified license
exception using the "WITH" operator (e.g. GPL-2.0-or-later WITH
Autoconf-exception-2.0), as well as the ability to use a simple "+"
operator after a license short identifier to indicate "or later
version". SPDX has defined a list of license exceptions to use after
the "WITH" operator. As a result, a number of licenses formerly
included on the SPDX License List have been deprecated, and correct
usage employs the License Expression syntax as of v2.0.

So, I assumed the "+" operator is the right thing...

But, if I would have just read the next sentence; I would have noticed
that SPDX did a flip backwards on GNU licenses:

Release 3.0 replaced previous Identifiers for GNU licenses with more
explicit Identifiers to reflect the "this version only" or "any later
version" option specific to those licenses. As such, the previously
used Identifiers for those licenses are deprecated as of v3.0.

Now, I did some more digging into this whole SPDX spec evolution...
And in the section Allowing later versions of a license on
https://spdx.dev/ids/, it explains that this later version aspect is
different for GNU and non-GNU Licenses... with a rationale from the
GNU blog... I got it now.

So, sorry for the noise. This patch can be ignored.

Lukas
