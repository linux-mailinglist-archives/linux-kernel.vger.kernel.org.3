Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD74A6FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbiBBLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:18:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53776 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBBLSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:18:49 -0500
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 705492F3;
        Wed,  2 Feb 2022 12:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643800728;
        bh=Fze3IjD9I12d7wjCEcEq9u8vjeNKqEjIfhxOdCPyiIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t2W1deen/IXaDZlIuuEyTvRmRkM7qZ2GIPbaEEVSJg5ZRykeGHTApODbTGRMTijlS
         DXacsSebe0jButuW3K4bqD7eh9DME8ZhudAMR5My5jUfIHtazf+iJ41GhuoAUqIw5c
         lM9xWE6k1HIwIvax4CWuoQcW0tgygUO6G9sf5CXU=
Message-ID: <801ccc6c-a70b-abe6-bab3-baa75a1203f1@ideasonboard.com>
Date:   Wed, 2 Feb 2022 13:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sven Schnelle <svens@stackframe.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 23:05, Daniel Vetter wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
> 
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>      35  Daniel Vetter
>      23  Linus Torvalds
>      10  Hans de Goede
>       9  Dave Airlie
>       6  Peter Rosin
> 
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
> 
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

