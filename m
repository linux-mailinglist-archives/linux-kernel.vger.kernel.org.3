Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B165AA83C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiIBGqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIBGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:45:57 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14EA55086;
        Thu,  1 Sep 2022 23:45:55 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11ee4649dfcso2694215fac.1;
        Thu, 01 Sep 2022 23:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rlXP+ocmg89sPZ1bmKzKz6efUiniZ6ZzHPfVaxpHFX8=;
        b=bFDx2kpvIwFj2ETSs5V8rxmCxcuVafyTeks+fjbRKyY3gDd6rsmHOAIRc4LNLBG3gK
         I/4h3od74fQQPcWj8GvdiC4ku0mhPAOXTMz2v/a0AiLq9i0NNzzMcGYZUJg5xqwyFQFE
         D9jDC2oBtW/6YIqI9T4ATQH0JfcTebRUHzjDbwXGVzlFXi6wXpUIc3lued7CaHxZIn6b
         H+0neOtXD5vRvG5bwdr++c4CXWG9Y4aCpZI3kamnVTSNBK94fFbZJltbk4rGtzU22pFt
         2x19sJiVleWQOIIhcILfCK8/lXMJgtca8D7YFqTfwIodS0pEJ8AT6QnMY8/m0jp5p4Hq
         5yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rlXP+ocmg89sPZ1bmKzKz6efUiniZ6ZzHPfVaxpHFX8=;
        b=TF6t3jj13LBME0jE6T702Gyq4N2eq5IIzP0rI8+YEYCKEjVl5B0pRApfFdjFxAhvFk
         PvODYh8ewVaKDRARruidw6T01/K7JaXGjcG1o0YbrwM/4DQyISBdr6uI2QhxagljuAxT
         QXKZvSNEwEbdU7xLhxrZsy6w0cY6wzgKNtEAFLD0YVOnMt5jpzOf9S6Gt/yfmQa0ks7W
         m5Izxt53boQq+B56CXOIZIFir7ZGdXIJJDBQXZy4Wu1e++f3UaqaqWmLmAklyHeFFIjh
         fyD6QQRv64MI+HGwdTYdd5OPM/WRSps+FAb36wcSoVnt3BuvHEavWBFTo1TNpjoxyyNo
         7mMw==
X-Gm-Message-State: ACgBeo2jyB4eibySrFrud766EI9s2UA1zFXZ63rKeROk8RFJ9j74apqU
        mhcX46HRw3qHbEi/yK2YKZs4HnhZGLWsuSF5AH2HrEQW
X-Google-Smtp-Source: AA6agR6Zo3evGR+2YXy5LUCwkmPx1++5D42OI6vkf9XghwQ5PzCIbbI0vxi1/UdIxcokwVS0YYnUS0I+YVMlPuEqX3c=
X-Received: by 2002:a54:488e:0:b0:344:cafe:fba1 with SMTP id
 r14-20020a54488e000000b00344cafefba1mr1237782oic.237.1662101155108; Thu, 01
 Sep 2022 23:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com>
In-Reply-To: <CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com>
From:   nyanpasu <nyanpasu256@gmail.com>
Date:   Thu, 1 Sep 2022 23:45:43 -0700
Message-ID: <CAL57YxbXsr=utsoi3vN-MkDz62Q37vVGWLZxGatk=hvPNLGB+A@mail.gmail.com>
Subject: Re: Bug: Elan v3 touchpad's reported size is half of actual touch coordinates
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug has not been resolved, and is reappearing on my system with
each kernel update, requiring that I rebuild and reinstall the kernel
module. Can a fix be implemented?

On Mon, Jul 18, 2022 at 2:34 PM nyanpasu <nyanpasu256@gmail.com> wrote:
>
> I noticed that on Linux 5.18.11, on my laptop (Dell Inspiron 15R SE
> 7520) with an Elan v3 touchpad (dmesg says "with firmware version
> 0x450f02"), the reported size of my touchpad (in userspace by calling
> mtdev_configure() and libevdev_get_abs_maximum(), in kernel space
> elantech_device_info::x_max/y_max, either way 1470 by 700) is half
> that of the actual touch range (2940 by 1400), and the upper half of
> my touchpad reports negative values. As a result, with the Synaptics
> X11 driver set to edge scrolling mode, the entire right half of my
> touchpad has x-values past evdev's reported maximum size, and acts as
> a giant scrollbar!
>
> The bug arises due to an error in drivers/input/mouse/elantech.c
> (which has been unchanged since 2021, in both torvalds and
> dtor/input).
>
> In this file, elantech_init_ps2() first calls
> elantech_query_info(struct psmouse *psmouse, struct
> elantech_device_info *info), which calls elantech_set_properties() to
> initialize info->hw_version = 3, then on version 3 touchpads requests
> ETP_FW_ID_QUERY to initialize info->x_max and y_max.
>
> Afterwards, elantech_init_ps2() calls elantech_setup_ps2(struct
> psmouse *psmouse, struct elantech_device_info *info), which calls
> elantech_set_absolute_mode(struct psmouse *psmouse), which if
> (etd->info.set_hw_resolution) (true on my machine), writes 0x0b to
> etd->reg_10 and sends it to the hardware.
>
> The problem is that elantech_setup_ps2() ->
> elantech_set_absolute_mode() sets up absolute mode and doubles the
> hardware resolution (doubling the hardware's maximum reported x/y
> coordinates and its response to ETP_FW_ID_QUERY), *after*
> elantech_query_info() fetches the touchpad coordinate system size
> using ETP_FW_ID_QUERY, which gets cached and reported to userspace
> through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the touchpad size
> reported to userspace (and used to subtract vertical coordinates from)
> is half the maximum position of actual touches.
>
> I've considered and implemented multiple possible fixes to this issue.
>
> The easiest solution (or hack) is for elantech_set_absolute_mode() to
> first write reg_10 to hardware, then if (etd->info.set_hw_resolution)
> is true, call elantech_query_info() a second time. However this
> re-requests device firmware version etc. and rewrites state, which I
> dislike because it could theoretically change fields in
> elantech_device_info you didn't mean to.
>
> You can't enable absolute mode first before calling
> elantech_query_info(), because elantech_query_info() is responsible
> for probing hardware and identifying if it's v3, and
> elantech_set_absolute_mode() depends on it.
>
> You *could* make elantech_query_info() only query the hardware version
> before returning, then enable absolute mode before calling a new
> function to identify the touchpad size. I did not take this approach
> because I didn't know how much code to move from elantech_query_info()
> into a new function called after elantech_set_absolute_mode()
> (everything up to ETP_ICBODY_QUERY probably not, ETP_FW_ID_QUERY
> definitely should be, and probably elantech_get_resolution_v4's
> ETP_RESOLUTION_QUERY for consistency). I think it's safe to move only
> "query range information" and possibly "check for the middle button:
> DMI matching or new v4 firmwares", and elantech_get_resolution_v4()
> (for consistency), to after elantech_set_absolute_mode(). However,
> this change affects the order of hardware commands on all hardware
> (not just the v3 Elan I have), and I cannot verify it works on other
> Elan touchpads.
>
> The most surgical fix I could think of (minimizing changes to behavior
> from the current Linux driver), is fetching *only* ETP_FW_ID_QUERY
> (touchpad size) a second time after elantech_set_absolute_mode()
> enables absolute mode and double-size mode. I have a local clone of
> Linux, which I edited to split out the ETP_FW_ID_QUERY request into a
> helper function elantech_query_range_v3(), which gets called by
> elantech_query_info() before boosting resolution, and by
> elantech_set_absolute_mode() after/if it boosts resolution. I built
> drivers/input/mouse and installed the resulting psmouse.ko, which
> fixes the bug (the touchpad size reported to userspace is 2940 by
> 1400, matching the range of touch events) and fixes edge scrolling.
> Should I submit this patch (alongside patches removing
> elantech_data::y_max/width which are redundant with
> elantech_data::info.y_max/width) or not?
>
> However I do not know how the Windows Dell/Elan v3 driver (or other
> hardware versions' drivers) initialize the touchpad and driver,
> specifically what order it sends various queries. I only have an Elan
> v3 touchpad (no other Elan hardware/driver pairs, just Alps and
> Synaptics) to study, do not have a logic analyzer to read the commands
> off the wire (though perhaps I could rig one up fast enough for PS/2
> using a Pi's GPIO pins), and have not tried decompiling that driver in
> Ghidra (which may not be clean-room safe, but I don't know if the
> current driver is clean-room or not, since elantech.rst mentions
> "name[s] given in the Dell-provided driver"). Is it critical to match
> the Windows driver's command order, or can we use any order that
> works?
>
> (Out of curiosity, given that PS/2 runs at <20 KHz and the Elan driver
> is written with blocking calls, is mouse processing code run in a
> dedicated kernel thread to avoid blocking other kernel tasks? I'm not
> an experienced kernel developer but a drive-by contributor, so I don't
> quite know how kernel concurrency works.)
>
> (Note I'm not subscribed to linux-input or linux-kernel, please CC me
> in replies.)
