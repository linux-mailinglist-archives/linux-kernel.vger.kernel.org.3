Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35556461131
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhK2Jiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhK2Jgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:36:50 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2AC06137C;
        Mon, 29 Nov 2021 01:18:18 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a11so16342449ilj.6;
        Mon, 29 Nov 2021 01:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SqMBvNhyCqzRjhWKuJ4mMsS2WmlVHNR8XpgmOXAnNQk=;
        b=oHko/lsWrXd6S8QAAKvjducfTT+/fEue6gjqUIdkLyFf794yYvR+rb8p8M0yjVKOuu
         ipq93m7/w2yZ8fTsrh+M+AeNLeibSMNr8aTujy8keYfHxS9nQHG7RrbyHqyk7GXnFNZN
         8VbgV7DwfMIN498KYUl2P7PI/uIDsnIhf/zVlZeihatxaDK+3IjMATq02Hk4wALVm8us
         6H+1CZ/w9iCUIEyaXiMnHbuyJa6dh2a0V2WUayzGj9MhT+uqGf5nQhTkEVv0Y5l5RkIM
         eER/au6wNmM0Y4EXtEJYrHsq5DCVxN7fn/f2MpyspEQSakSLZ487gpt4HRrQ5KNSMJcB
         nDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SqMBvNhyCqzRjhWKuJ4mMsS2WmlVHNR8XpgmOXAnNQk=;
        b=qCV5JnX2vQCVjNJtIUPeTeJceedSvTdve4dSrj4DnADFJvvYbTocoz3L9fObaIfhYF
         4f1Vs9gN4nVh4ym/eVV1aTQd9aLgdPqhXjtyL+oKIuZHCoE7DgsKNJRwGzQ8Nj978o8Q
         y+d9QkqMExiJDVaSYSs6sUFvYpzTdkafDhuwwk4l4Q7OiAgfS1RhBDhW7EfpstbJXgSv
         tsGGtmJW2TqWnJEpenCVNVraI24l37PVP+TuUoP8US1J7ecNVgpa0SumOkHC6/WNsHAY
         G9337UxQVi3J8jA2t9ZgQlEz2000e5CCj6ZuJufa+muERrO3RajdzBBiLS655uPWjt5t
         AGaA==
X-Gm-Message-State: AOAM531S693uYu4UlA1MOJ+uiBSUMiCKxIs8GiZQKBwfyFluqLWMpu2P
        E21yqCSSR8sXjgq6HX7nwna5yBeJ8HAJDVy6KUw=
X-Google-Smtp-Source: ABdhPJxKy85jr+4OTA+lFMU8Ng/qSVe5OOdGUATyeprda6Cf+1J2wTAtbQe48xFacvJbTpB0zUAeraH0E4yhnmsbv0E=
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr19116261ilv.1.1638177498304;
 Mon, 29 Nov 2021 01:18:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUXzoQ4Rkms6WbLnnY7WSbcgt9t4vNTu17qyTQTLr6d1sw@mail.gmail.com>
 <CA+icZUUqw-LSJOrGYbmjMv8tHEN_eoq4nbgr8BxspQRFxNjVrA@mail.gmail.com>
 <CA+icZUUWj_-jgiA=NCmSP5zgk_fcEFN5+vKn7jLOFpbdQepSyw@mail.gmail.com> <18efeb0222687d9886b2b83eb4090f08d0493d9f.camel@intel.com>
In-Reply-To: <18efeb0222687d9886b2b83eb4090f08d0493d9f.camel@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 29 Nov 2021 10:17:41 +0100
Message-ID: <CA+icZUVT9YDReJDjggVOLkHGXf3zRZB=WZweSRQ1AzmZNW4-+w@mail.gmail.com>
Subject: Re: [Linux v5.15 final] Call-trace iwlwifi and/or mac80211 (was
 [Linux v5.15-rc6] mac80211 warnings with iwlwifi)
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:14 AM Coelho, Luciano
<luciano.coelho@intel.com> wrote:
>
> On Sat, 2021-11-27 at 22:13 +0100, Sedat Dilek wrote:
> > Hi,
> >
> > Just jumped to the latest Debian-kernel...
> >
> > $ cat /proc/version
> > Linux version 5.15.0-2-amd64 (debian-kernel@lists.debian.org) (gcc-11
> > (Debian 11.2.0-12) 11.2.0, GNU ld (GNU Binutils for Debian) 2.37) #1
> > SMP Debian 5.15.5-1 (2021-11
> > -26)
> >
> > ...and still see these issues:
> >
> > [Sat Nov 27 21:57:20 2021] iwlwifi 0000:01:00.0: RF_KILL bit toggled
> > to enable radio.
> > [Sat Nov 27 21:57:20 2021] iwlwifi 0000:01:00.0: reporting RF_KILL
> > (radio enabled)
> > [Sat Nov 27 21:57:20 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
> > [Sat Nov 27 21:57:20 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Error sending
> > REPLY_SCAN_ABORT_CMD: time out after 2000ms.
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Current CMD queue
> > read_ptr 35 write_ptr 36
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Loaded firmware
> > version: 18.168.6.1 6000g2b-6.ucode
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: HCMD_ACTIVE already
> > clear for command REPLY_SCAN_ABORT_CMD
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | OK
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | uPc
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | branchlink1
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | branchlink2
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | interruptlink1
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | data1
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | data2
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | line
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | tsf low
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | time gp2
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | time gp3
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | uCode version
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | hw version
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | board version
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | hcmd
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr0
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr1
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr2
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr3
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr4
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr_pref
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | wait_event
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | lmpm_pmg_sel
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: 0x00000000 | flow_handler
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Start IWL Event Log
> > Dump: nothing in log
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Command REPLY_RXON
> > failed: FW Error
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Error clearing
> > ASSOC_MSK on BSS (-5)
> > [Sat Nov 27 21:57:27 2021] ieee80211 phy0: Hardware restart was requested
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
> > [Sat Nov 27 21:57:27 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
> > [Sat Nov 27 21:57:32 2021] iwlwifi 0000:01:00.0: Failed to load firmware chunk!
>
> [...]
>
> > > > Can you mac80211 and/or iwlwifi maintainers look at this, please?
> > > >
> > > > Attached are my kernel-config and full dmesg-log.
> > > >
> > > > If you need further information, please let me know.
>
> Can you please file a bug in bugzilla about this? Then it's easier for
> us to track and assign.
>
> Thanks for reporting! We'll try to come up with a fix asap.
>

Hi Luca,

Thanks for taking care.

Do you have me the bugzilla URL, please?

What information shall I attach and/or are relevant?

Regards,
- Sedat -
