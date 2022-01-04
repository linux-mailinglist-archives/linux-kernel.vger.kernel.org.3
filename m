Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2714B48494D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiADU2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiADU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:28:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D3C061761;
        Tue,  4 Jan 2022 12:28:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z3so27819412plg.8;
        Tue, 04 Jan 2022 12:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QHPRYvRcbE0iEr+5e4ys6CCGWo4CR4Fzq9a27ajmsYg=;
        b=eeFnDfOMDOPN3tOn72YqxDTucc58DzQH1ieZNBKnUfR8l5vZ9CYghXO7vWg/PaER/Z
         TgTmGqGq76x2rRSQ/SpnWghETsZA50hZCI3XdW5pA2pbqYKVCwyEE2PzAmNW0652CSxM
         5BWJZ14QiobUW4QYkz58N08KbJPOZyqCsm8KbTefVGrQ8EtMBW9AsSLmvf/uQrP2w7YE
         7SYk+cTdksWSXjbQhZ9Wd7fyDvQGEhjNLqS0/2ZqUqoi/EQNM4RYeaL3mDzxSaoEBcIn
         K4LkmtpNi+GGEc84NMV3AV6n77XZIOB+rM6rFKa7ptLtxZ9spsG7TQ3MzPyzg9e2JVV8
         ROlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QHPRYvRcbE0iEr+5e4ys6CCGWo4CR4Fzq9a27ajmsYg=;
        b=Oxq+d4XVj6/jpyiiNiIw3QTC5ffTxRXLhKZQGnOxjQvUTZuyrl28X02Af38SVbJBbc
         rC5PnuzNRGW/1GHBgyiUGLDSmuQ2SEHzSEU5HDYoXbwXT82M9ATWJ1ZfCZXo0ZpSne7q
         ADgjxb5J25jRNvkx7SaYWsG8AV7uXkp7IjJMKRYSeyz6VVe3jeUkaXFmeN/SfOLpLld0
         UFshEqgydeJNEGdEsVHDpL5Zr9/WRkFJqfQRF8TjVy5aetl19KqtMeK9rrLHhhbsI8in
         DSL/SU/0tBJlna679/K0Qsrv9iSzZBUNfzWve0830A+3Iv7DMT+hFxrXw18pmW2KfQCF
         Jf6A==
X-Gm-Message-State: AOAM531rxOHBF/Xv4WFbxHE4JI1SNIVKPxm2+ZCmFNSas3TdNDYOkGKT
        k639jhGhCVHXM8v+vEkSeRI=
X-Google-Smtp-Source: ABdhPJxOfE4pREy4hpxCC8MXsFsP9ZVCGF+FMRxo/z+prhm9z9YJshj4d67upTKZeI17XYI2xGtj7Q==
X-Received: by 2002:a17:902:e84e:b0:149:a908:1698 with SMTP id t14-20020a170902e84e00b00149a9081698mr21607121plg.0.1641328115195;
        Tue, 04 Jan 2022 12:28:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9f19:94d6:5b13:7607])
        by smtp.gmail.com with ESMTPSA id 32sm35740096pgs.48.2022.01.04.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:28:34 -0800 (PST)
Date:   Tue, 4 Jan 2022 12:28:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Felix Singer <felixsinger@posteo.net>,
        Matt DeVillier <matt.devillier@gmail.com>
Subject: Re: Upstream support of Google Chromebook keyboards (udev,
 xkeyboard-config)?
Message-ID: <YdSt8Gi69mtJS6dt@google.com>
References: <41f9d4f9-eb3a-7a5d-3d69-5361dd9124fc@molgen.mpg.de>
 <YdOOElXuwxkKlU59@google.com>
 <2dc1017e-7e81-83d0-73f3-c2b144aefe74@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dc1017e-7e81-83d0-73f3-c2b144aefe74@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jan 04, 2022 at 04:31:59PM +0100, Paul Menzel wrote:
> Dear Dmitry,
> 
> 
> Am 04.01.22 um 01:00 schrieb Dmitry Torokhov:
> 
> > On Mon, Dec 27, 2021 at 05:18:44PM +0100, Paul Menzel wrote:
> 
> > > Installing a non-Chromium OS distribution like Debian on a Google
> > > Chromebook, in this case a Dell Latitude 5400 Chrome (google/sarien), not
> > > all keys work as expected.
> > 
> > Looking at the issues you are referencing you are flashing a 3rd party
> > firmware on the device so I am unable to comment on behavior of that
> > firmware, however:
> 
> Not quite, I only flash the RW_LEGACY section, so only the payload is
> changed as the vendor firmware unfortunately does not ship with a
> depthcharge alternative making booting another operating system impossible.
> (Or I missed something.)

If you adjust the way you do kernel install (by altering or providing an
alternative to /sbin/installkernel) you can keep Chrome OS partition
scheme and write kernel image to KERN_A or KERN_B partition... Some
people do that.

> 
> > > 1.  Non-working super key and two function keys on Google Chromebook Dell
> > > Latitute 5400 Chrome (google/sarien) [1]
> > 
> > There is no "super" key on Chromebooks.
> 
> Sorry for mixing the terminology. (On the identical in design Dell Latitude
> 5400 it is that key.)

Right, I am only talking about Chromebooks.

> 
> > The "globe" key you see is supposed to select next keyboard layout.
> 
> Oh, interesting choice.
> 
> > This is the udev hwdb entry that we have for Sarien/Arcada devices in
> > our tree: >
> > # Copyright 2019 The Chromium OS Authors. All rights reserved.
> > # Distributed under the terms of the GNU General Public License v2
> > 
> > #
> > # Special keyboard mapping for the Sarien project. The keyboard emits both
> > # function and action scan codes depending on Fn-modifier key.
> > 
> > evdev:atkbd:dmi:bvn*:bvr*:bd*:svnDell*:pnSarien:pvr*
> > evdev:atkbd:dmi:bvn*:bvr*:bd*:svnDell*:pnArcada:pvr*
> >   KEYBOARD_KEY_ea=back
> >   KEYBOARD_KEY_e7=refresh
> >   KEYBOARD_KEY_d5=full_screen
> >   KEYBOARD_KEY_d6=scale
> 
> (As I was unfamiliar with `scale`, after pressing it, you see an overview of
> the currently opened windows on the current virtual desktop.)
> 
> >   KEYBOARD_KEY_95=brightnessdown
> >   KEYBOARD_KEY_91=brightnessup
> >   KEYBOARD_KEY_a0=mute
> >   KEYBOARD_KEY_ae=volumedown
> >   KEYBOARD_KEY_b0=volumeup
> >   KEYBOARD_KEY_8b=switchvideomode
> >   KEYBOARD_KEY_d8=sleep
> >   KEYBOARD_KEY_d4=kbd_layout_next
> > 
> > (Note that on Chrome OS we are transitioning from F1-F10 being primary
> > key codes emitted by the kernel to what we call "action" codes - back,
> > refresh, etc).
> 
> Thank you, in what Chromium repository is that file?

You can find it here:

https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/refs/heads/main/overlay-sarien/chromeos-base/chromeos-bsp-sarien/files/81-sarien-keyboard.hwdb

If you look through other overlays you will find a couple more adding
"assistant" key definitions to Pixelbook and Pixelbook Go.

> Do you know the reason, why these are not upstreamed to udev/systemd?

Just an oversight I think.

> 
> > > 2.  Wrong caps lock key and function key mappings on Google Chromebook Dell
> > > Latitute 5400 Chrome (google/sarien) [2]
> > 
> > There is no CapsLock on Chromebooks either. We are using "search" or
> > "launcher" key which is actually Left Meta in place of CapsLock.
> 
> Yes, that is what I described in the bug report.

What I am trying to say is that for Chromebooks this is not a bug but
rather how they are supposed to work.

> 
> > > Peter replied, this should be fixed in udev, so it’s not directly related to
> > > the Linux kernel, as the Linux kernel exposes the scancodes(?) just fine.
> > > But what is the upstream process for this in general? Chromium OS carries
> > > `91-chromeos-keyboard.rules` for example.
> > > 
> > > systemd/udev currently has an entry for two Google Chromebook models in
> > > `hwdb.d/60-keyboard.hwdb` [4]:
> > > 
> > >      ######################### FIXED MODEL DEVICES #############################
> > >      # This section lists devices which require special handling in their key
> > >      # code to keysym mapping by setting the xkb model.
> > >      # The model must be an xkb compatible model (defined with XKB_FIXED_MODEL).
> > > 
> > >      # Chromebooks
> > >      evdev:atkbd:dmi:bvn*:bvr*:bd*:svnHewlett-Packard*:pnFalco:pvr*
> > >      evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pnPeppy:pvr*
> > >       XKB_FIXED_MODEL="chromebook"
> > 
> > Yes, that is the right place for it. You submit a PR against systemd
> > with the new mappings.
> 
> From `/usr/share/X11/xkb/symbols/inet` from *xkb-data* 2.33-1:
> 
> ```
> partial alphanumeric_keys
> xkb_symbols "chromebook" {
>         include "level3(ralt_switch)"
>         key <FK01> {    [ XF86Back ] };
>         key <FK02> {    [ XF86Forward ] };
>         key <FK03> {    [ XF86Reload ] };
>         key <FK04> {    [ F11 ] };
> //        key <FK05> {    [ F5, F5, F5, F5 ] }; // Overview key
>         key <FK06> {    [ XF86MonBrightnessDown ] };
>         key <FK07> {    [ XF86MonBrightnessUp ] };
>         key <FK08> {    [ XF86AudioMute ] };
>         key <FK09> {    [ XF86AudioLowerVolume ] };
>         key <FK10> {    [ XF86AudioRaiseVolume ] };
>         key <BKSP> {    [ BackSpace, BackSpace, Delete ] };
>         key <UP>   {    [ Up, Up, Prior, Up ] };
>         key <DOWN> {    [ Down, Down, Next, Down ] };
>         key <LEFT> {    [ Left, Left, Home, Left ] };
>         key <RGHT> {    [ Right, Right, End, Right ] };
>         key <LWIN> {    [ Super_L, Super_L, Caps_Lock, Super_L ] };
> ```
> 
> This layout is different from the one used on google/sarien. How many
> different layouts are there, and how do you organize them in Chromium OS?

We have 4 hard-coded ones:

- classic one - back, forward, refresh, full screen, scale/overview,
  brightness up, brightness down, mute, volume up, volume down, sleep.
- "Pixelbook" - no forward key, play/pause between brightness up and
  mute key
- sarien/arcada - as shown in the mapping above
- drallion (followup to sarien) - same as sarien, with the exception
  that units with privacy screen have privacy screen toggle on what is
  typically F12 instead of mirror/switchvideomode.

Newer devices have key map for internal keyboard specified via ACPI
(see drivers/input/keyboard/atkbd.c::atkbd_get_keymap_from_fwnode()) and
therefore we no longer need static ones when we want to add or remove
some keys from the top row.

Hope this helps.

-- 
Dmitry
