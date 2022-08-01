Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25937586300
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbiHADIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbiHADHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:07:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B10C140F7;
        Sun, 31 Jul 2022 20:06:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h12so10886505ljg.7;
        Sun, 31 Jul 2022 20:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i8Jz3BTpeGtJm3GK1eZ2YEROBIkhtZGeBw2QJDaLLNA=;
        b=enp33M/PYqZZWP0JCm+W22PFu64pswsfAPsbjwZwGdhGBIiP4AdLhoVUVYHFKgPija
         AtVBscG379ZzIqvFl4cSz2Jkavm6q+6t9BJzKrgxcW0F+IKIrI2+EC7XGsk0Tel72t70
         izUVT9m520ipG7gQhsf3+QerUHQNQldcYTiNgmI8DhrlBEXJrvhiYlKIuR67mPhGK48F
         J0j7SYexnJ5VUhrIONSGT18tF7R9q7i/qHwR4KQEQsMgpqhxwJFoljJX/t3/bBOWovjb
         tw0ypiWlp8gREGsDA9FQ5Nm+vNMWTMr7u1/BZnv7NsPhOwG9ACDDGl/3pyeGN+DUtML8
         awrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i8Jz3BTpeGtJm3GK1eZ2YEROBIkhtZGeBw2QJDaLLNA=;
        b=FFq1Gt4U5ZjaS6lD4NU1j63LG3FaSGVjdnbaWkxskhn1j8b3PhCUdpGAuEAeMYVS7m
         lkXVlEWQHG1/rn/Z2lAnVF4xXclRNZA7MeD+SHGuJy9326Xrxul78Sdt5HIXZPU4Wue3
         0y+65j4+PY4SrIRKQFg2ku1o/E1Shbu+tZG5kc/KRwrFTq0rPOKL9snh0Vf0H64GlTs8
         Zmd9isRN+8GYWXVyj8+6KJGxqxb+yM0oay6FNu6W7xLGqxOfxh9wxO0VMSGh8BRDjMmt
         r4QN+8YMbyubS81drGyX/At8reQusyhfzhw6GOPn1AlfJqOgX5k0zlVMTFPSCEgmlUpZ
         9n1A==
X-Gm-Message-State: AJIora9/NM3/EhuI+p9pg8r3rTWvmn1IEYaMo32+KoGJQOpfOBLBYJ2b
        6k8Ie7UGh8e0xR/CDpUGfrqqoM8xIFFLBRVAc5M=
X-Google-Smtp-Source: AGRyM1snToAwo4WDxw3adVyp2XTk7wwifj2+D/vHcQ6rEwSnlSvVmgqvySbnyKGu0Y2DxTfTylBX+94b6+X2543nj18=
X-Received: by 2002:a05:651c:1250:b0:25e:954:97b8 with SMTP id
 h16-20020a05651c125000b0025e095497b8mr4470467ljh.215.1659323212444; Sun, 31
 Jul 2022 20:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com> <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
 <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com> <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
 <20220731082055.GA4008925@roeck-us.net>
In-Reply-To: <20220731082055.GA4008925@roeck-us.net>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Mon, 1 Aug 2022 04:06:41 +0100
Message-ID: <CALW4P+JMH3WEwT1BuYRG2TVqdfsAm1qS0PZs40Vvw80Pdq4yTQ@mail.gmail.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog device
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Oliver Neukum <oneukum@suse.com>,
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

On Sun, Jul 31, 2022 at 9:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Jul 31, 2022 at 03:34:16AM +0100, Alexey Klimov wrote:
> > On Tue, Jul 26, 2022 at 8:48 AM Oliver Neukum <oneukum@suse.com> wrote:
> > >
> > > On 26.07.22 02:21, Alexey Klimov wrote:
> > > > On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >>
> > > >> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> > > >
> > > > [..]
> > > >
> > > >> Anyway, driver looks good to me, nice work!
> > > >>
> > > >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Thanks, Greg. If you don't mind I'll use your tag in next version
> > > > after making changes suggested by Guenter since there will be no
> > > > significant functional changes. If code will change a lot, then the
> > > > process (Documentation/process/submitting-patches.rst) will require me
> > > > to drop the tag.
> > >
> > > Hi,
> > >
> > > while thinking about this a question arose. How does this
> > > device react to a USB reset? A watchdog that can be disabled
> > > by a simple reset does not like very reliable to me.
> > > Do you need to implement pre/post_reset() ?
> >
> > You're right. Upon reset the watchdog is disabled even if it was active before.
> > Adding empty ->pre_reset() and ->post_reset() helps to avoid that, but
> > looking at Documentation and other drivers it seems that I need to do:
> > in pre_reset():
> > mutex_lock() to block any other I/O to the usb device;
> > __usb_streamlabs_wdt_cmd(STOP) to stop the watchdog;
> > and do not unlock the mutex;
> >
> > in post_reset():
> > if (watchdog_active())
> >         __usb_streamlabs_wdt_cmd(START);
> > mutex_unlock() to allow other's I/O to the usb deivce.
> >
> > Seems right?
> >
> Not necessarily. Is other code doing something similar ?
> Using a mutex like this creates the risk for hung tasks.

If other code means drivers in tree, then yes.
Examples are drivers/usb/storage/usb.c, usbtmc.c, synaptics_usb.c,
vub300.c, zd_usb.c, usb-skeleton.c, etc.

I'll check the Alan's suggestion and will try to implement that.

Best regards,
Alexey
