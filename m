Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D779447EED0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352666AbhLXMam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:30:42 -0500
Received: from relay037.a.hostedemail.com ([64.99.140.37]:44483 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233709AbhLXMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:30:41 -0500
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 3891160225;
        Fri, 24 Dec 2021 12:30:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id D5E8A60010;
        Fri, 24 Dec 2021 12:30:33 +0000 (UTC)
Message-ID: <6c81ef5a8407d9bb782dfbc9365a4c0658b667ca.camel@perches.com>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
From:   Joe Perches <joe@perches.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Fri, 24 Dec 2021 04:30:36 -0800
In-Reply-To: <20211224092226.vmqkmybpx4zodezt@uno.localdomain>
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
         <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
         <20211223184856.v34ecibwzepahsju@uno.localdomain>
         <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
         <20211224092226.vmqkmybpx4zodezt@uno.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.40
X-Stat-Signature: ntueftf8c8fe318h6twwqznih8ozu61d
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D5E8A60010
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18P/ub0aaE+1Mahwx3jULEDVjviyMM0zd8=
X-HE-Tag: 1640349033-706551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-24 at 10:22 +0100, Jacopo Mondi wrote:
> Hi Joe

hi again.

> On Thu, Dec 23, 2021 at 12:13:10PM -0800, Joe Perches wrote:
> > On Thu, 2021-12-23 at 19:48 +0100, Jacopo Mondi wrote:
> > > The media subsystem requires to validate patches with
> > > 
> > >         ./scripts/checkpatch.pl --strict --max-line-length=80
> > > 
> > > We longly debated this and I believe it's now generally accepted to go
> > > over 80 when it makes sense, but not regularly span to 120 cols like
> > > in the previous version.
> > 
> > Where is this documented and do you have a link to the debate?
> 
> It's in the subsystem maintainer profile
> Documentation/driver-api/media/maintainer-entry-profile.rst
> 
> Where of course some exceptions are listed but it's anyway enforced
> that "efforts should be made towards staying within 80
> characters per line"
> 
>     - on strings, as they shouldn't be broken due to line length limits;
>     - when a function or variable name need to have a big identifier name,
>       which keeps hard to honor the 80 columns limit;
>     - on arithmetic expressions, when breaking lines makes them harder to
>       read;
>     - when they avoid a line to end with an open parenthesis or an open
>       bracket.
> 
> The debate I mentioned was specifically on the previous version of the
> driver where me and Krzysztof shown quite different understanding of
> coding style requirements.
> https://patchwork.linuxtv.org/project/linux-media/patch/m3fstfoexa.fsf@t19.piap.pl/

Thanks for that.

> That lead me to submit this
> https://patchwork.linuxtv.org/project/linux-media/patch/20211013092005.14268-1-jacopo@jmondi.org/

That too.

FWIW, I believe using more than 100 columns or so makes it more
difficult to track quickly and efficiently to the next line.
Reading with multiple visual saccades on a single line is slow.

And IMO:

o reverse xmas tree declarations is quite a poor style requirement
o single line c99 // comments should be encouraged/preferred
o identifiers longer than 20 characters or so should be discouraged


