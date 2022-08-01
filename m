Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ACB586334
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiHAEAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:00:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF561B1F0;
        Sun, 31 Jul 2022 21:00:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u3so12649495lfl.3;
        Sun, 31 Jul 2022 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n9CkTzrmV50rz/zYav9x+RF/pPnwcqb7p6AKMW3GDVE=;
        b=bYLg1gqyddQb/fdJtaz6CifAlxNtwd60RjS3APsY8uavHzjSp6HUjWINovZZBfbyqO
         vGZU4d3HuQDSF49FkDG9kXlS3DMv5dqV6sl86fT4MrFwPO1P6JYW2QyXt0NKWurueYqd
         FziDt1wWzmUAmCx+qE2hKM6th5NnKTNAl9Cn7QXkRMGVdn6ldEThi/opanrtq5yVXBPC
         +kBCSngHe1b4AxfYQtfZvLwC4mKAKwQHJwQ+JOwb4kBICPxpKCKJIBKey09tv64ovDcZ
         LkKD0XsTVtrA3CTcQeFPTZw45EarLdOpZzTACndcNOKk1ZI9X2oZfr9T8Sk/EnCThEVL
         GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n9CkTzrmV50rz/zYav9x+RF/pPnwcqb7p6AKMW3GDVE=;
        b=cBDQX7Y6UO8IfuFIGahIwnFgdoQN+NKgmVoklcDYn7pgHbJU86Epj9zfZQ7e+1hcbb
         v1/tscJ1H/ulEz/lDlGmfChNRnj3MExR4PgRRozxpaeRzcVDG1werxpqYzWazewUI9tz
         H/VKDbj7n0qTfeqTcsNHfkNRxXhHlaEfhGWR1UNTewVUzpYMOxk4LISC71PxlZNRydsj
         lQuZBwxO+MyrLUP1J4pxmiU1D/arWxvoS3C3bAp6KoOqIv60Q4owTAofSMJ2ZzOBiIyF
         1g15Icl9PqGQXvWtJSnqSjyVDfUw/oaZC0wGmc2bEAqLSl43Ep8R2FnJ/6sUiCn3XSpt
         pvHQ==
X-Gm-Message-State: ACgBeo0EH7Au5t76kdad3PmY2AdTuIsrpMrmVAH9Hz+KMathRzCBI2Mr
        XfxCxjsXzX384FbImeHwhl7Qe/0pHNrbW5FXikU=
X-Google-Smtp-Source: AGRyM1ucrIu40q63iE3W2g1r6fsomMMm1BVU7gCAY/74Pyu/8YsE8j95gMs/4Q1fxQpDsCAEJHsZMMCXZ5A3PBHgfu4=
X-Received: by 2002:a05:6512:10c1:b0:48a:b8cb:ef2d with SMTP id
 k1-20020a05651210c100b0048ab8cbef2dmr4811968lfg.384.1659326442204; Sun, 31
 Jul 2022 21:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com> <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
 <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com> <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
 <20220731082055.GA4008925@roeck-us.net> <YuaO5Gx84zonjq7X@rowland.harvard.edu>
In-Reply-To: <YuaO5Gx84zonjq7X@rowland.harvard.edu>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Mon, 1 Aug 2022 05:00:30 +0100
Message-ID: <CALW4P+JiHWMchE+bq1UMTaW78YXo42_069vcimjE=och=7havg@mail.gmail.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thank you for your responses here and in another email thread.

On Sun, Jul 31, 2022 at 3:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sun, Jul 31, 2022 at 01:20:55AM -0700, Guenter Roeck wrote:
> > On Sun, Jul 31, 2022 at 03:34:16AM +0100, Alexey Klimov wrote:
> > > On Tue, Jul 26, 2022 at 8:48 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > >
> > > > On 26.07.22 02:21, Alexey Klimov wrote:
> > > > > On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >>
> > > > >> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> > > > >
> > > > > [..]
> > > > >
> > > > >> Anyway, driver looks good to me, nice work!
> > > > >>
> > > > >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > > > Thanks, Greg. If you don't mind I'll use your tag in next version
> > > > > after making changes suggested by Guenter since there will be no
> > > > > significant functional changes. If code will change a lot, then the
> > > > > process (Documentation/process/submitting-patches.rst) will require me
> > > > > to drop the tag.
> > > >
> > > > Hi,
> > > >
> > > > while thinking about this a question arose. How does this
> > > > device react to a USB reset? A watchdog that can be disabled
> > > > by a simple reset does not like very reliable to me.
> > > > Do you need to implement pre/post_reset() ?
> > >
> > > You're right. Upon reset the watchdog is disabled even if it was active before.
> > > Adding empty ->pre_reset() and ->post_reset() helps to avoid that, but
> > > looking at Documentation and other drivers it seems that I need to do:
> > > in pre_reset():
> > > mutex_lock() to block any other I/O to the usb device;
> > > __usb_streamlabs_wdt_cmd(STOP) to stop the watchdog;
> > > and do not unlock the mutex;
> > >
> > > in post_reset():
> > > if (watchdog_active())
> > >         __usb_streamlabs_wdt_cmd(START);
> > > mutex_unlock() to allow other's I/O to the usb deivce.
> > >
> > > Seems right?
> > >
> > Not necessarily. Is other code doing something similar ?
> > Using a mutex like this creates the risk for hung tasks.
>
> Are mutexes intended to be used in situations where one function
> acquires the lock, then returns, and then a different function releases
> the lock?  I'm not sure about this.
>
> Perhaps a good old semaphore would be more appropriate.  But it's clear
> that I/O to the device does need to be mutually exclusive with resets,
> one way or another.

Thanks for the idea, I'll look into implementing this.
Also, just to let you know there are a lot of drivers who do mutex
lock in pre_reset and mutex release in post_reset.
And there is 16-years old commit 47104b0dd32cec467574822b0dc3517b3de3f0ad
Maybe usb skeleton driver could be updated as well.

Best regards,
Alexey
