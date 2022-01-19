Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200AA493D03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355711AbiASPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:22:40 -0500
Received: from outbound3.eu.mailhop.org ([52.29.21.168]:20696 "EHLO
        outbound3.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355803AbiASPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:22:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642604776; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=XmJULg7KcEsaAaNVIau0nr+3RqdjTMF7EPD+qQzoldcmZAh7cNxSVCsZ7INWh5yKqbSX56p2YCXG3
         sWtgv3aYaB6xeKUEb2io7X1VxBKX/stnD7snv4Jvee8+m1aGr/REB8VpC2hx805sFtOSLMQ65ooT0X
         UyVIxM6zn6GacF+jeeRHAOVWMcKR/Z3hjB0lhu88J5YiyW7HZsrfuhGZPPEiGUNLn7OMWbIqPCCaH7
         ujKpfWZdvzwdoalVB5qozPwn4siRJLpduTcc3oz/z3FN48LFkf109ABPMSJln2KRyIcMMuMS346rYY
         18rLeK50laBEbqzClBqlzWXXyVvSZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=xKcGXC5UN2NwkPJrRpedUdXpH3K121N9tHO7S7nhcBQ=;
        b=D+QOjciww+Dka5r7dfyw07WWl75WFkX0wqPYKO8IFWnEAYQQK1dZ5jzztbY4Mj53Dd5SvH6XJecjw
         jLypbGN6BTLZ/Xwa2yjb+y2Er9Pq5hrn6ECPykbCRyEr67Qv7wSmEXmJ9X82puP9ycqdxXYKsLAzXZ
         Id7jGQqWhMpNFjrPFcyVoUZKdG0vUBcrv1gpeXqvdpTuhHJgDx24cByK75hGy1DiiJzNu5o/fG3Qv0
         KEQEDM8JSm8iiET4CxUTYOA7E9ARzBEoQRpJGLRdwguizoK4LKvfF0IYDfiYKdy3lUar0aco4XBl0b
         XApxbsCTLs/ofBJ+jBB1r+J9jyrQ2HQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=xKcGXC5UN2NwkPJrRpedUdXpH3K121N9tHO7S7nhcBQ=;
        b=BcLT82Y/1rcgNQu3U9ScUtmrhIv4jV67PRF3CeVDj1oq4Q9FsmYxulno70Xhdev93EWnVu92jDNrt
         uDMEeI4pM835cgf2rmZ0+uDqKlaP0dRvXq7/IO9zM5tDTkF2JhzhggqBmaZyxi/m4Xta26vQWOaezI
         lPrdR4Dj31elnWq4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=xKcGXC5UN2NwkPJrRpedUdXpH3K121N9tHO7S7nhcBQ=;
        b=fBBbq/RhuKo8xz+BjEVFrwo0c4C5bqsWZS+Z+TgQg+4S7heoONiN9WC8WGe4n9ODZg75BtyYYsV5V
         PiGzwtLGM3SZdq0XCbw1DU0PmdxyqAOaOhuByU+XWpPOnXj3bItofFdKz82Ht7H6Bg4ZiwMTw96zD3
         oiNAOa5Rz+pYOsUWHcgp7EfZ0keOyestZuH5py5Emn+KNMkorSqMOCte5xQ91MKyTwpzdSP5oBspXc
         mehik1F/Cz0GyA7gKiKy/4kk5vpL9AYQ6IC9Xosg5374GZ8xhT4v+CutRs+4PG75I3QlYW9fZny4XX
         nxeDzERRrGIPgTIaO/d2+wQDcg0YAlg==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 51bf6f5a-7939-11ec-9564-95b64d6800c5
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound3.eu.mailhop.org (Halon) with ESMTPSA
        id 51bf6f5a-7939-11ec-9564-95b64d6800c5;
        Wed, 19 Jan 2022 15:06:05 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1nACXC-00599H-8i; Wed, 19 Jan 2022 17:06:02 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
References: <20220119110839.33187-1-deller@gmx.de>
        <20220119110839.33187-3-deller@gmx.de> <Yef0j8+DBbwC7Kjv@kroah.com>
        <Yef15k2GtC40aJEu@kroah.com>
        <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
        <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
        <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
        <CAKMK7uEb53iu_HxYSnFZ59j=vXQdMvTWT7xosEo85XkAwzDMnA@mail.gmail.com>
Date:   Wed, 19 Jan 2022 16:05:59 +0100
In-Reply-To: <CAKMK7uEb53iu_HxYSnFZ59j=vXQdMvTWT7xosEo85XkAwzDMnA@mail.gmail.com>
        (Daniel Vetter's message of "Wed, 19 Jan 2022 15:34:06 +0100")
Message-ID: <8735ljkboo.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Wed, Jan 19, 2022 at 3:01 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> Irrespective of this code being buggy or not buggy I think the bigger
> pictures, and really the reason I want to see as much code ditched
> from the fbdev/fbcon stack as we possible can, are very clear:
>
> - it's full of bugs
> - there's no test coverage/CI to speak of
> - it's very arcane code which is damn hard to understand and fix issues within
> - the locking is busted (largely thanks to console_lock, and the
> effort to make that reasonable from -rt folks has been slowly creeping
> forward for years).
>
> Iow this subsystem is firmly stuck in the 90s, and I think it's best
> to just leave it there. There's also not been anyone actually capable
> and willing to put in the work to change this (pretty much all actual
> changes/fixes have been done by drm folks anyway, like me having a
> small pet project to make the fbdev vs fbcon locking slightly less
> busted).

Saying it's stuck in the 90ies, and actively trying to prevent
Helge from taking over maintainership at the same time looks odd.
I think Helge should at least get a chance to fix the issues. If the
state is still the same in a year or so it should be discussed again.

> The other side is that being a maintainer is about collaboration, and
> this entire fbdev maintainership takeover has been a demonstration of
> anything but that. MAINTAINERS entry was a bit confusing since defacto
> drm has been maintaining it for years.

It was marked as 'Orphaned'. Anyone is free to send a Patch/PR to take
over maintainership. If you have strong opinions about that code (And you
obviously have reading your mail, set it to 'maintained' and care about
it. Everything else is just wrong in my opinion.

/Sven
