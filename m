Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B87483956
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiADAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiADAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:00:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD49C061761;
        Mon,  3 Jan 2022 16:00:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u20so30662037pfi.12;
        Mon, 03 Jan 2022 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dK21mIGORj0/9MnxfJAN9rJMFqp9YwgpsAaZ0YwupJ0=;
        b=PEFyB2y+rikSCEhzLMrLDC6JUltEWl3FA9BMYZtxTkTtA6lmKnNKgyNajS/8kiI3it
         nKt1+mZlnvtifXZAEC3LTUNPq5b51Yu04egS2Z3jXM7wFytMx97zJCqwcoqhf7C+DinO
         i4ZvQcA4pIZ/29Jm3+BXcDox4+YEbFA5TaKwDYIRAiTI5ER8rxtnbJU0rpsGQV1w8OGt
         uU2Hf1YRf0oD8y0zCoebpRz90ms0ks4l067S16IFar2jEhEV2fxM/Qg1io5v/DgcKdNG
         B7oD4/F8IMaqsUAhGKeN2SUzedFtqjTN9jwnR44H9AzVBrbLlmEQMOUm2v7EbILXlJ3R
         Si/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dK21mIGORj0/9MnxfJAN9rJMFqp9YwgpsAaZ0YwupJ0=;
        b=IR1O2dFc+lfT1tg7sXRKyjeQ19/YinKD2TjAAq6a9s6TzKf9JsED2dfksGd+9tHCkA
         f3yeXWqvMX3qF8nz86SX/5tPgffsY6FbUQdlfLBRu7pi+6T51EHj0X86Ktvu98jBxHx4
         lPMwgT0oZq53DTTDd9Y/9OZcqyZCaLBapas49MZNXgpHBZ8h332Ijsjmau0YsENp3blQ
         cPLmHOEqT5oUnQMfNKi0fCq8rUadjI5V/TUf+coo0BYDmBi6VfwEaqvQSsthNnWjp8IR
         EvcIV7ibLgac89Njw+wsV0Sb3MFdSkDPb/7nU/+ANsZxI69yZB0tl/G+F+nQd5uw6aT8
         Ly8Q==
X-Gm-Message-State: AOAM531BUjrxRpokUeqzz7jNjAZkP5sGiO/nJM13HUGXgu9B0eGuGh+x
        30GOYn+6rCYyPhJ05HE8Z20=
X-Google-Smtp-Source: ABdhPJzAzA6W7S2xt0tKZ7VPj4qY7YtFYkLe6WXZt/yfjcjwYFEm/810sSh2Tj62da1CaiKyBhQUVw==
X-Received: by 2002:a65:679a:: with SMTP id e26mr42060845pgr.280.1641254422036;
        Mon, 03 Jan 2022 16:00:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a7d6:43d7:bbe3:3573])
        by smtp.gmail.com with ESMTPSA id b11sm42106435pfv.39.2022.01.03.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 16:00:21 -0800 (PST)
Date:   Mon, 3 Jan 2022 16:00:18 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Felix Singer <felixsinger@posteo.net>,
        Matt DeVillier <matt.devillier@gmail.com>
Subject: Re: Upstream support of Google Chromebook keyboards (udev,
 xkeyboard-config)?
Message-ID: <YdOOElXuwxkKlU59@google.com>
References: <41f9d4f9-eb3a-7a5d-3d69-5361dd9124fc@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f9d4f9-eb3a-7a5d-3d69-5361dd9124fc@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Dec 27, 2021 at 05:18:44PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Installing a non-Chromium OS distribution like Debian on a Google
> Chromebook, in this case a Dell Latitude 5400 Chrome (google/sarien), not
> all keys work as expected.

Looking at the issues you are referencing you are flashing a 3rd party
firmware on the device so I am unable to comment on behavior of that
firmware, however:

> 
> 1.  Non-working super key and two function keys on Google Chromebook Dell
> Latitute 5400 Chrome (google/sarien) [1]

There is no "super" key on Chromebooks. The "globe" key you see is
supposed to select next keyboard layout. This is the udev hwdb entry
that we have for Sarien/Arcada devices in our tree:

# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

#
# Special keyboard mapping for the Sarien project. The keyboard emits both
# function and action scan codes depending on Fn-modifier key.

evdev:atkbd:dmi:bvn*:bvr*:bd*:svnDell*:pnSarien:pvr*
evdev:atkbd:dmi:bvn*:bvr*:bd*:svnDell*:pnArcada:pvr*
 KEYBOARD_KEY_ea=back
 KEYBOARD_KEY_e7=refresh
 KEYBOARD_KEY_d5=full_screen
 KEYBOARD_KEY_d6=scale
 KEYBOARD_KEY_95=brightnessdown
 KEYBOARD_KEY_91=brightnessup
 KEYBOARD_KEY_a0=mute
 KEYBOARD_KEY_ae=volumedown
 KEYBOARD_KEY_b0=volumeup
 KEYBOARD_KEY_8b=switchvideomode
 KEYBOARD_KEY_d8=sleep
 KEYBOARD_KEY_d4=kbd_layout_next


(Note that on Chrome OS we are transitioning from F1-F10 being primary
key codes emitted by the kernel to what we call "action" codes - back,
refresh, etc).

> 2.  Wrong caps lock key and function key mappings on Google Chromebook Dell
> Latitute 5400 Chrome (google/sarien) [2]

There is no CapsLock on Chromebooks either. We are using "search" or
"launcher" key which is actually Left Meta in place of CapsLock.

> 
> Peter replied, this should be fixed in udev, so it’s not directly related to
> the Linux kernel, as the Linux kernel exposes the scancodes(?) just fine.
> But what is the upstream process for this in general? Chromium OS carries
> `91-chromeos-keyboard.rules` for example.
> 
> systemd/udev currently has an entry for two Google Chromebook models in
> `hwdb.d/60-keyboard.hwdb` [4]:
> 
>     ######################### FIXED MODEL DEVICES
> #############################
>     # This section lists devices which require special handling in their key
>     # code to keysym mapping by setting the xkb model.
>     # The model must be an xkb compatible model (defined with
> XKB_FIXED_MODEL).
> 
>     # Chromebooks
>     evdev:atkbd:dmi:bvn*:bvr*:bd*:svnHewlett-Packard*:pnFalco:pvr*
>     evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pnPeppy:pvr*
>      XKB_FIXED_MODEL="chromebook"

Yes, that is the right place for it. You submit a PR against systemd
with the new mappings.

> 
> The Dell Chromebooks, unfortunately, also use the embedded controller with
> Dell’s proprietary firmware (Wilco(?)), and not Chrome EC making special
> handling necessary. `91-chromeos-keyboard.rules` has
> 
>     # Wilco keyboard (5220W-C) for Chrome OS
>     SUBSYSTEM=="input", \
>       ATTRS{idVendor}=="413c", ATTRS{idProduct}=="2510", \
>       ENV{CROS_KEYBOARD_TOP_ROW_LAYOUT}="3", \
>       ENV{ID_INPUT_KEYBOARD}="1"

This is only needed on Chrome OS to let Chrome know how to map the
"action" scancodes back to F1-F10 when they are chorded with "launcher"
key. This is Chrome on Chrome OS-specfic behavior and is of no interest
to other parties.

Thanks.
 
-- 
Dmitry
