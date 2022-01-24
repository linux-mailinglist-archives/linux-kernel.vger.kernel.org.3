Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AF1498391
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbiAXPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:31:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:46439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239105AbiAXPbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643038243;
        bh=0HDaa8ybzAU3WahzXsoJL/1AGix1sCiymZJmVtib/YY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=POJNcweazGJQnB5ck0iuQoSUgsdehlB/3SIXnB4wz21ejzxlWPRsItBs6aIX4W2Gl
         XDnr3olJnJRp/aI/73nPJ4ma2jeZJ52Buzayrv9bmlxIXv76ndOK3k7EIr5PO83S4h
         CDDhZ3IS6Dsuc1hTsgw60xipLp3c9mXHrvQ+4aZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.96]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1moLe12XbC-00WY0w; Mon, 24
 Jan 2022 16:30:43 +0100
Message-ID: <de6e06e1-f293-1c98-7898-b5d52c400b59@gmx.de>
Date:   Mon, 24 Jan 2022 16:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
 <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
 <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
 <2fc200bb-4b40-7833-31c9-90a78512b601@redhat.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <2fc200bb-4b40-7833-31c9-90a78512b601@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D47fAUTkxrhoBsLC8ZEQMrVPeldhoeO7xA5iYubuNtsUdu1RaLF
 H0nJStLonxAyXhSltp94/rMAgm6y95mtSV7oDmrh0n8LwBx1JTcQvFn8LsYlmpmOPljOu8/
 KXIlPqXLduRe0mLga9vA7uo6N7+w+dfzffUVJySwGQo9fCywOWrP+AB+VXMtJFR0BHW+i7d
 YHAcXKSZPcnZUUzbtNdUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpnOdBYXFhY=:5S8n7Yl+ZL6mBPKg1QS35L
 F2iXhWM+VfhCnsQ8ESinVeG/5FXG8USbAATlwo1jDSpeAhOcS2hj5kE949+WcQkJfH3a+94fk
 iRJDDYLyuKkexkng0yEkD+NRMdNjlBLvHtoi9LLYqHq35el/ZDOotqrjbIawnVKScth3ciul8
 iKni7/XdEOeEGQ3zM/v4Xu68XMkLp/uWkL2bFhuXPSRzB+5+Ptk+T14AjY4r3q6JFG1q1Un9q
 3TC9T/9LBIMyLGomWXOt/L864pbd87W1IpqT0FbZ/Y7FdVeH8ZZpcfqOaxLQNJXSeMzN+FVkt
 0WqkxFfpMqt2iPIkjajeouCYPAEajn6Hmcb3t//MrMojYnqTeySNofoOstEWgqJdYykGCrV8P
 cKeoZayK4l4GyyVdqOC0sf1B9MEZfoudA7uvNY88+dfkPT8/kz4kNwZ0AuFwHtycxFhFHcyci
 /cLJ1AAkZ6/HcOEKn/+ueZ0yIUYtexIY8AE7FR3Tpt06mGXd4OeUp4BiJmDC31jUHvyKzpg7u
 wIhQBz64p8X7zHrGEWvWk+xz5V8Vb60oJgyuBNpEtBYvxpQNpCHKqYLWWQ6uEFFPMh9imeqDK
 zEcr92JRH4B3umFFqI/NdIP3dCLndpABxN9RMkPm0EQf+snyaSym9Ita8noPhSfhZQU3vkO9R
 0lB9/oAleQI7y+1BBdRrAGY4LDgwWFfPhPKvO17HGJdF69HNqW4o4hzOAUdY5TQ7ujtFqsB6i
 aqPZVUh+ELrJXMd1ADKbmZ5jWX1fbxDS/rapwWbO51Z/NWwM2Wjpa4UYGNpMlBfFcVedABHT9
 2mcBH6T3/pz+L0suKh1xwcu/9RHG7NzcS8CdL2xJ9aht8j8i1NnZ2Hq8sqmSi9jRQj7MZZJ2c
 u5vKZ8JJD78VZjRsbv6jIU5JoTS8jrpyh1yanMC92SHTs1SmWeXHAAbye0KCnUwzqfm/Y9Sm0
 xWc/CqiMJEt/Oa3pui/5KbxPxpjwiN7pq07snWc7GLZeyMpFT4nOCP+TDV+KJwh2MjKJeyQWh
 mW07wSCMBPW7feiccCtPq2dRUV9oJbTNhV0bz15kM2J7BzdGLbZOK/ifJB0OKLU4r1LXI2b2S
 eyKJkPT3Gg03gw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 12:50, Javier Martinez Canillas wrote:
> On 1/24/22 12:33, Thomas Zimmermann wrote:
>
> [snip]
>
>>> Thoughts?
>>
>> I can't say I approve keeping fbdev alive, but...
>>
>> With fbdev emulation, every DRM driver is an fbdev driver too. So
>> CONFIG_FB_DRIVER is somewhat misleading. Better add an option like
>> CONFIG_FBCON_HW_SCROLLING and have it selected by the fbdev drivers tha=
t
>> absolutely need HW acceleration. That option would then protect the rsp
>> code.

I'm not a fan of something like CONFIG_FBCON_HW_SCROLLING, but I'm not
against it either.
For me it sounds that this is not the real direction you want to go,
which is to prevent that any other drivers take the framebuffer before
you take it with simpledrm or similiar.
CONFIG_FBCON_HW_SCROLLING IMHO just disables the (from your POV) neglectab=
le accleration part.
With an option like CONFIG_FB_DRIVER (maybe better: CONFIG_FB_LEGACY_DRIVE=
RS)
it's an easy option for distros to disable all of the legacy drivers
from being built & shipped.

Instead of CONFIG_FBCON_HW_SCROLLING we could also choose
CONFIG_FBCON_LEGACY_ACCELERATION, because it includes fillrect() as well..=
.

> Agreed that this option would be better and allow distros
> to disable the code that was reverted.

Yes, but IMHO it doesn't hurt either to leave it in.
It doesn't break anything at least.
Anyway...

Helge
