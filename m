Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627B1585CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiGaCeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGaCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 22:34:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0513E12;
        Sat, 30 Jul 2022 19:34:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z20so1785475ljq.3;
        Sat, 30 Jul 2022 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T481nvKuJ0ZTtRo/nf05qojcNx9GtNMP4sCJDBL+oLQ=;
        b=DTGDdewi7Ruokf1EYnkRlH8lX3VbWOoeATFlk05uc3Gu1p63jpPWePHa8NrNOBo19M
         Mi0jWpOVxA+dGf2JJtqijlJNDoAjLKLfuR0Vkp3oFO2sVLVrTXSv97Xw91kK+Rn54Kp6
         O7UXGI4+zZ+WKmIyN6Vpj6SEQKPrT7VvFAdqsPG2d8UFp1H/aqqWkBqhUiCmsQG6UkCP
         +cw9EN/tCIjt4wP5Opew/7l3npzALT0iQ9LNqswu016+FkHl09KNJYH86CGzIBKfc2zl
         ufy6pPKD0qjes1XJMmx+ygJJHp7Z5jCCu/3YvHqbRl9EBfAK3GzeSvgpPt14jFYNtF3H
         65Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T481nvKuJ0ZTtRo/nf05qojcNx9GtNMP4sCJDBL+oLQ=;
        b=hTK6fJ3OBFT7jBmu1IgsFFLa3SBWWbjM/V45elpm5cbQCXd3B/0AeOxgc4fyV1cHrM
         4oJi9TBjdLyL4+W8XfscRNIx2Qd5aBPiF2eFNzFWnpmyXBd1dWKFFEbv8HtBQeVEI4l+
         QG47Hf/0jqo69ca2aubmD1y0mU28t1Gtq15L+ZgWjp6CQ63fcyRLpT6vXr5KHNhGp716
         /URaBqTJzeTHNmJA7EVkUBwHb3x//9ii7r7ToxiLQzvky8Wl4keI8w+oq2qkpQ1OWebd
         L2H1ziJrT9AuiQu7UIIUqJm3dLxp0NYUhuGn4W8ZECja1N7oEX3/wFfLA4tT7+oBjkOR
         BY7A==
X-Gm-Message-State: AJIora/2vOLp6+05lLFuC1Oqn+Sa5xEFaJ9noSBqbMdp+aEWe1jzjCXC
        p952T5iN6PGTyuoNJEBoNHoUAi8N3OP2s9nHLI0=
X-Google-Smtp-Source: AGRyM1s3ny6HptAiq4uyxyVpT08ei7svf8yVJNkvTVWiEdJMv6AYFkBq/Jvq+Af/WmrU6HvZ2Ut/afFXRzSz6EzXUJk=
X-Received: by 2002:a05:651c:886:b0:25e:3440:9518 with SMTP id
 d6-20020a05651c088600b0025e34409518mr3331600ljq.248.1659234867669; Sat, 30
 Jul 2022 19:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com> <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
 <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com>
In-Reply-To: <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Sun, 31 Jul 2022 03:34:16 +0100
Message-ID: <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog device
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
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

On Tue, Jul 26, 2022 at 8:48 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> On 26.07.22 02:21, Alexey Klimov wrote:
> > On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> >
> > [..]
> >
> >> Anyway, driver looks good to me, nice work!
> >>
> >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Thanks, Greg. If you don't mind I'll use your tag in next version
> > after making changes suggested by Guenter since there will be no
> > significant functional changes. If code will change a lot, then the
> > process (Documentation/process/submitting-patches.rst) will require me
> > to drop the tag.
>
> Hi,
>
> while thinking about this a question arose. How does this
> device react to a USB reset? A watchdog that can be disabled
> by a simple reset does not like very reliable to me.
> Do you need to implement pre/post_reset() ?

You're right. Upon reset the watchdog is disabled even if it was active before.
Adding empty ->pre_reset() and ->post_reset() helps to avoid that, but
looking at Documentation and other drivers it seems that I need to do:
in pre_reset():
mutex_lock() to block any other I/O to the usb device;
__usb_streamlabs_wdt_cmd(STOP) to stop the watchdog;
and do not unlock the mutex;

in post_reset():
if (watchdog_active())
        __usb_streamlabs_wdt_cmd(START);
mutex_unlock() to allow other's I/O to the usb deivce.

Seems right?

Best regards,
Alexey
