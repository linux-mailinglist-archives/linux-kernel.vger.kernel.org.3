Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05BB497DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiAXLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:11:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:34625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbiAXLLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643022689;
        bh=vaZNWsffgiWonS7sv+nwaASVuPIvGSGB1y3edNq9IZY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RDHyhteYw11inncsGEVHi+veROG9TJqZIq6Z0cYRN2cKW6BA1i7ZgUv1eQD3wrted
         D14gxsfFT7RQAy98mVuEYZ3M7cxtrQPCREH4aoDi6BsulvAwT6HhhUhzonB436jvXL
         nMDerl86tVzSoAYIXJSJGqCWcaz9WNbe4BEzn6jU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.96]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49lJ-1mCbA019FZ-0102SK; Mon, 24
 Jan 2022 12:11:29 +0100
Message-ID: <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
Date:   Mon, 24 Jan 2022 12:10:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cQ2CXc5PlbnzvHYLeF6mCJSXPAtiiC9YrH66NvSERb+BiDbK1v9
 P7yUcMSr3eAdFeElKrC/xIw6gFIsFQS+gBOXBuEE2ziyCNRTRiVmvnNWj7Z5pOYv4J9Tax5
 4eSRI8ilt1JwpYdIikIUWzPu9XjGSQfhR7pvjfclo0M3EmXnPBS9oSGSqAYtP+XLklC4cX3
 /6p6gpoxNYBD/TL95nOJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XvILxYcelpA=:O2OubiAtE69DCEvdExI5WC
 fdNlOP/VgZRKZhbZ/5AnwvP6yKgvQkzcjmkyYI4aDUvmwDL/1iVo9s+8GWrBskPza7F10ldwS
 v2R9f16c1nCPFroOOlu14KVNkPFNQvZe0a3TB+U18bj3JEAw5E++OJSBz9uatSOf0UqjYDjBq
 kzL/dq+tOYyYt07Qhda81wZkszpNJpVy07C/pMiyPfce2Zxivz192mW6f+55WWQ007lm1KDJJ
 05tIATNvsSCNlUCaVNJ2NjB3exfsJBVwQhkWAVyMjShZwHaHBAP04SdoVI0UOQrp7hG4XjFFR
 d5AYtkp1uLoJXAJPJ4GLK6t1ACBH5hxSz9cgfH5X2UxheC2I1f3l84eqISxm6Fdzm0pyDnjru
 uesumOeMVefpY5fTkztAPvNcmkh9rxZiRyzTFLLodFMJRY0FHr1KpTEZ3KO0m8GkDMYnTtZrZ
 9GhV1tnl72FA1mdGHZ2lzKkBwChjuIZw3HkpCLCg9+BOuqEgCV1+6R7auHejdVG6CY2GzmP/s
 v9kYGJxtpNiqmQ6kGedAGgHeRMPDIm4yuwdPa0WamUkxsaBONflJmuOq7Ke24TV/cVWUEra2G
 NnL1SwP683e5islyrVashAdhm+zS+d37XkbGnftuOIvl6KHApET0IVDL0/dMyPMN/Y9AkxKvd
 lJofOoECF5zNirmVo8TUUBlq/0ejqSGcDKlnoeIV2tOShvSgz2lc6Qvb73ye7+aFPRKkKtnTw
 awl3EU6gBVOLWgiE/tHpwSC8G99L+kP4zrkq3xcSAWdCxZRVtxm81WXUpEIgIDeDtL1zaN12N
 oKhPMgiSOEKHoJvGW64hZaks3RIKsIAWSdEt0TG1Y/eWFzl+UZaYp611zm1f7ryBDviK4iGCT
 JtesXkLCFCtpxRnhRtIuzCzkiMpMvOxxNJ+I55fLgmEb196zJf3RvrtzYYCGdLv2TRlYxag4B
 nP1Ga12edfsWBYEVb1gk6m8Vcl6QszgmoVEQ1HuNy8QyHZY8RnspgENwhcpSzv5F9bkBG2X3/
 7WjXpwVseDBG3KnWSphbpWSDbxE1VnniM/GumTKPWBtcrwNDhvL+imJMz4Ue3KMdOIMEjwZ09
 tDJ89YqZHe/38k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 08:20, Gerd Hoffmann wrote:
>>> So if this really has to come back then I think the pragmatic approach=
 is
>>> to do it behind a CONFIG_FBCON_ACCEL, default n, and with a huge warni=
ng
>>> that enabling that shouldn't be done for any distro which only enables
>>> firmware and drm fbdev drivers.
>>
>> Thanks for coming back on this, but quite frankly I don't understand
>> that request. How should that warning look like, something along:
>> "BE WARNED: The framebuffer text console on your non-DRM supported
>> graphic card will then run faster and smoother if you enable this optio=
n."
>> That doesn't make sense. People and distros would want to enable that.
>
> Nope.  Most distros want disable fbdev drivers rather sooner than later.
> The fbdev drivers enabled in the fedora kernel today:
>
> 	CONFIG_FB_VGA16=3Dm
> 	CONFIG_FB_VESA=3Dy
> 	CONFIG_FB_EFI=3Dy
> 	CONFIG_FB_SSD1307=3Dm
>
> CONFIG_FB_VESA + CONFIG_FB_EFI will go away soon, with simpledrm taking
> over their role.

That's Ok.
Nevertheless, some distros and platforms will still need fbdev drivers for
various reasons.


>> And if a distro *just* has firmware and drm fbdev drivers enabled,
>> none of the non-DRM graphic cards would be loaded anyway and this code
>> wouldn't be executed anyway.
>
> Yes, exactly.  That's why there is no point in compiling that code.

As long as you have a graphic card which is not supported by DRM you still=
 need it.

Here is my proposed way forward:
a) I will resend the patches which reverts the remove-fbcon-hardware-scoll=
ing patches
   to the mailing lists. I'll adjust the stable tags and update the commit=
 messages.
b) Then after some days I'll include it in the fbdev for-next git branch. =
That way it's
   included in the various build & test chains.
c) If everything is working well, I'll push that change during the next me=
rge window
   for kernel 5.18. If problems arise we will need to discuss.

While the patches are in the fbdev git tree we should decide how to exclud=
e code
which is not needed for DRM.

What about this proposal:
a) adding a Kconfig option like:
   CONFIG_FB_DRIVERS - enable if you need the fbdev drivers. For DRM-only =
this should be disabled.
b) Add to every native fbdev driver a "depends on FB_DRIVERS" in the Kconf=
ig files.
c) That way we can use "#if defined(CONFIG_FB_DRIVERS).." to exclude code =
in fbcon which
   isn't needed by DRM.

Thoughts?

Helge
