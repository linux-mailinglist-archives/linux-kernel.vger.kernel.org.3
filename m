Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3B4A5A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiBAKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:32:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:46819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234907AbiBAKck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643711530;
        bh=UL1I6BedOSrZvW04M6UxEwzTxNyQYKOszjsSogxrGPg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KNB0a8d0/WcQh/COivcOJp9R38T2AuJkCGnRWHlOuWjgBy89LQJtfAm0q2FfdKNkj
         t0fkLcP6ac9ooDa8uxMcDh0fs0b7dllT4Hf8aTw14C/sCYrJsTBgi6ZmBN39LAuwfc
         ABQr5PTheNGJBepEQiqzWR+IZS7BgNtGe0angRys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.146.124]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1n3b6Z0LBh-00BMez; Tue, 01
 Feb 2022 11:32:10 +0100
Message-ID: <cd93926d-79a8-2d89-7587-fde55f5973bd@gmx.de>
Date:   Tue, 1 Feb 2022 11:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D/iwpiN/cMRkAmhJk6GTZ6lqXirhByMOTDwuxp31ezrAQFTjZW+
 oDrUoUTu4NwA+pVVR4/A5EnlGw7QJfOIpipQDN6GA9goXVmrKy+V1KEgB2d8+nKXE6rgqCh
 6BQwhO/rA/vonViUoddHAjTcKPiRrc0JOkIBaKk/k2VKHcQ0TGBEbY4n4PL836qg7D/LTwA
 SxMCu1SgTmRDMVNLUJtag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ffpo4UgjYgM=:gVKKT31Txl5VSiQKMJlC6E
 8smnpgNihWQ94TorQdk8QRfOxYVcllONa75m2Uum/ELwGHgUHvk1ol+MU/eooenx+splAxngA
 NzwoIJLhLbALSKoX5VxT0ofUotsqQ9Jxs3MksKKPUkM10VqXt9un3aQS3yQlWbEzO2ZSOlrxn
 jUNrqaSD7Gtjq3O1FE2h/q/DXSMnEWCovnIJUtazBpTdSeeq4Cq//tWZKGn3sdxgLEW9tSjy5
 SUUXXfQmecJ8QqRMfINb7QCups++BEZXPryP8BpzEi2NxGaHBSJmV3rssBp8S4GTbLQUCNGvA
 +3PVH+nl7nBPCP+4NtqMcleuHm9yHuOU3WF0BemFsvmbVDv10BDTdvs+tfblhSBh6ShIYajjN
 Ob0/a5JOhxEq1BWo16BjGi3lr3jOV6rek4RsYO8b5XNgtd/k7LKuaVHb9iIDqNC3cSzTLV1IE
 UM4+BdW5Iy/lCPf4u3NXl9/dpeZuhMa/g14AoSWRrlHqXyRLB+m/4vBdKONjT2Ly0O8P1Gver
 kdeltLN61OiYaK4YTSrGWRNq0g3ANUlQjCq0OciFhPlF+QhbA6Scz9ixxVlHDcKD4m+Aig8ER
 xm/LYHM93G99mL2Fvy40ZMI4zr3D9jIeu2QhFZVRpr06FYD4MwBzxk+z6jkZhnx+DyFcvolxp
 mj+eofB7b3OQQYf08arqSFgmg/hGekVHPH2mcCgldnfwMOMtrwWHiRgcb1VvRZkhojaMJClDq
 p6DSjd8+BV3fG/EIQDAIhE0JMswRTnu9esQyGGVyTFMIaTWaZuCDrwop57uEi93SKPyNjLNra
 cXkjsyryjpr3T5Cmiq5vNNLhHKIQgNUTOxQGrHhreCVFw620HAcfapm/62ySEQMB0ogxuirMN
 FTuNQhIIHBLrICLyW+Pk3oK/7rdx99dTJzFs4qqEawOWF7J/A3mO7Pm6uO8aRF+NlWVy7BB1I
 ymupXTJSX1az4Wzo4lz5HTBf6sUQYLQp0s3Vql72zHtFOqTrLp7Wrp+5r3mQ6zUOFPQHOQGtf
 S/ffOOj6xUQ3WezKzCvzEGkx9Dt8CyOCt1Rf9NJrvYUfCUtCuZzEnOziu9cTyJcF4uvpYSgHt
 tui5wff10Cyyd0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 22:05, Daniel Vetter wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
>
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
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

Yes, agreed.

Acked-by: Helge Deller <deller@gmx.de>

Since the code is used by drm and existing fbdev drivers,
please just make sure to not break fbdev...

Thanks!
Helge

>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: DRI Development <dri-devel@lists.freedesktop.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..49809eaa3096 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7573,6 +7573,12 @@ S:	Maintained
>  W:	http://floatingpoint.sourceforge.net/emulator/index.html
>  F:	arch/x86/math-emu/
>
> +FRAMEBUFFER CORE
> +M:	Daniel Vetter <daniel@ffwll.ch>
> +F:	drivers/video/fbdev/core/
> +S:	Odd Fixes
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +
>  FRAMEBUFFER LAYER
>  M:	Helge Deller <deller@gmx.de>
>  L:	linux-fbdev@vger.kernel.org
>

