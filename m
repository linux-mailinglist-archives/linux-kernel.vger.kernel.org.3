Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC647EDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352221AbhLXJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:21:39 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50849 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352184AbhLXJVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:21:36 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5A710C000C;
        Fri, 24 Dec 2021 09:21:31 +0000 (UTC)
Date:   Fri, 24 Dec 2021 10:22:26 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Joe Perches <joe@perches.com>
Cc:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
Message-ID: <20211224092226.vmqkmybpx4zodezt@uno.localdomain>
References: <m3ee63hkuu.fsf@t19.piap.pl>
 <m35yrfhkaf.fsf@t19.piap.pl>
 <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
 <20211223184856.v34ecibwzepahsju@uno.localdomain>
 <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe

On Thu, Dec 23, 2021 at 12:13:10PM -0800, Joe Perches wrote:
> On Thu, 2021-12-23 at 19:48 +0100, Jacopo Mondi wrote:
> > The media subsystem requires to validate patches with
> >
> >         ./scripts/checkpatch.pl --strict --max-line-length=80
> >
> > We longly debated this and I believe it's now generally accepted to go
> > over 80 when it makes sense, but not regularly span to 120 cols like
> > in the previous version.
>
> Where is this documented and do you have a link to the debate?

It's in the subsystem maintainer profile
Documentation/driver-api/media/maintainer-entry-profile.rst

Where of course some exceptions are listed but it's anyway enforced
that "efforts should be made towards staying within 80
characters per line"

    - on strings, as they shouldn't be broken due to line length limits;
    - when a function or variable name need to have a big identifier name,
      which keeps hard to honor the 80 columns limit;
    - on arithmetic expressions, when breaking lines makes them harder to
      read;
    - when they avoid a line to end with an open parenthesis or an open
      bracket.

The debate I mentioned was specifically on the previous version of the
driver where me and Krzysztof shown quite different understanding of
coding style requirements.
https://patchwork.linuxtv.org/project/linux-media/patch/m3fstfoexa.fsf@t19.piap.pl/

That lead me to submit this
https://patchwork.linuxtv.org/project/linux-media/patch/20211013092005.14268-1-jacopo@jmondi.org/
which I never managed to re-send, my bad.


>
> The archive for the i2c mailing list doesn't show much debate:
>
> https://lore.kernel.org/linux-i2c/?q=%2280+columns%22
> https://lore.kernel.org/linux-i2c/?q=%22line+length%22
>
> Perhaps there should be a MAINTAINERS P: entry for this requirement.
>
> From MAINTAINERS:
>
> 	P: Subsystem Profile document for more details submitting
> 	   patches to the given subsystem. This is either an in-tree file,
> 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
> 	   for details.
>
>
