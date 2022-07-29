Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93ED584A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiG2Dvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiG2Dvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:51:32 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151D4AD42
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:51:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-322b5199358so36593137b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhvxyYsWTQqC9Gm8wP/8rb/nF1GRUx4/FKdDJYpHwI8=;
        b=QJC6TIISriSHw4s3GOGwdFqx4V/oFS6/BrSJWZuFqOAYgAx+XjxP+W3NZd+FwwWZDI
         62NUM0HZZfkMzeyO9q1ELu97xCZB6D8Je9HPvq7JJlhuMq7qM+6GzM2A/jsdu13UV+H7
         bfl7S5YQTOIkC3/I/DKm1aZsqH6DvqMxBb2aMotvXv010MxUMYKGkb57MHRgb+v5+smc
         QXsTX2ZdO3rjzpoNP7HR7GlnU7PSkhWL64s/D8NjedPVyEJbNSY7g0sZopwK8basGg/h
         n9QM/A7tPVpeRDu7VYL/6GSu9vWoHIhWubfPVuE8OCF1r+hibOZOoXvuHwVMLEDfzwuK
         40LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhvxyYsWTQqC9Gm8wP/8rb/nF1GRUx4/FKdDJYpHwI8=;
        b=TUUCqr4erfd+jJPKiUMwFzTq1z8baPslauBPC0AQf/COicQ1A2WFyBDsAsyjwOzF62
         021xoggm4ppmBp41a17O+/hnAIpRLd34rmKgRdMpOBumwVgtfIjjJb/cCL/cBuN/m9SN
         sbCah/tu8WGQCoAaL/t2L1g7DJAdRwSOILr6QLpYebZB5ZqT64zLdz3q7wJqWiWPO/6O
         BWd+KqjlxxwaeUrrMPrJ4wzRYzEF61X4qkd+mJ8rcwElH4xE2HEqWNW6CMaM9Rs5TEb/
         ZYwi8HjZjsn6Px+rsecWWCGkpmKtmMFEDd0cAw6zVlyi1iwMvXKu6rdekJiIkEvMuv2N
         5viA==
X-Gm-Message-State: ACgBeo0PEWzOG0ZZ0bEDy/EJnE1esDGFIft8WPo65F06JWS4pvA47y0d
        eZxzJhVFOu4ChsBlizuqEdNf5WoFQSpWwxmgoro=
X-Google-Smtp-Source: AA6agR6Ts/5ETt0ZM3Pvy14Ws59Nn7wtfoIpHbVtVhBjPF6HDnAGkIYCCBJMQLpQ5gibFOpQqk4ll0DkARUSBjczx7o=
X-Received: by 2002:a0d:da02:0:b0:31c:a0e9:4165 with SMTP id
 c2-20020a0dda02000000b0031ca0e94165mr1564021ywe.439.1659066689699; Thu, 28
 Jul 2022 20:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220718120149.GD2338@kadam> <20220719055047.322355-3-ztong0001@gmail.com>
 <YtalnN70xXy3PNNN@kroah.com> <CAA5qM4A7-hCf8hZq4M8O5havY29PYqym1_TNrWJvcc-LWbLnmA@mail.gmail.com>
 <YuDdHMaB6jWARQzA@kroah.com>
In-Reply-To: <YuDdHMaB6jWARQzA@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 28 Jul 2022 20:51:19 -0700
Message-ID: <CAA5qM4DHbmTzZ7Yv-zEYx=3bu_TOZ1hKfe5dDgZ7DhG=ZPpORA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] staging: rtl8192u: move debug files to debugfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 19, 2022 at 11:30:48PM -0700, Tong Zhang wrote:
> > On Tue, Jul 19, 2022 at 5:53 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 18, 2022 at 10:50:37PM -0700, Tong Zhang wrote:
> > > > There are 4 debug files created under /proc/net/[Devname]. Devname could
> > > > Due to this is purely for debuging as files are created read only,
> > > > move this to debugfs like other NIC drivers do instead of using procfs.
> > > > This is also to prepare for address rmmod warn issue.
> > >
> > > Minor comments based on good debugfs usage:
> > >
> > > > --- a/drivers/staging/rtl8192u/r8192U.h
> > > > +++ b/drivers/staging/rtl8192u/r8192U.h
> > > > @@ -1061,6 +1061,9 @@ typedef struct r8192_priv {
> > > >       struct delayed_work gpio_change_rf_wq;
> > > >       struct delayed_work initialgain_operate_wq;
> > > >       struct workqueue_struct *priv_wq;
> > > > +
> > > > +     /* debugfs */
> > > > +     struct dentry *debugfs_dir;
> > >
> > > Why do you need to save this dentry?  Can't you just look it up when you
> > > want to remove the files?
> > >
> > > > +void rtl8192_debugfs_init(struct net_device *dev)
> > > >  {
> > > > -     struct proc_dir_entry *dir;
> > > > +     struct dentry *dir;
> > > > +     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> > >
> > > No need to cast this.  Same for later on in this file.
> > >
> > > > -     if (!rtl8192_proc)
> > > > +     dir = debugfs_create_dir(dev->name, NULL);
> > > > +     if (IS_ERR(dir))
> > > >               return;
> > >
> >
> > I'm reading this code and your comment again.
> > Adding this check will avoid calling into debugfs_create_file() and 4
> > function calls and doing checks from there, probably will save a
> > couple of CPU cycles and avoid branch prediction penalty if there is
> > any.
> > I don't think the compiler can optimize for this case though it's not
> > performance critical. Anyho I personally feel it is better to keep
> > this.
>
> It's not an optimization issue, it's a "we never care about the results
> of a call to debugfs_*() issue".
>
> That's all, debugfs is intended to be easy to use, and you should never
> care about the return values of if it worked or not, so your code should
> not check it and do anything different based on it.
>
> Yes, it's not like "normal" kernel code, but debugfs is not normal at
> all, and should never expect to work as it's only for debugging.

Hi Greg,
Thanks for your review. I am mostly on the same page with you.
IMHO, since Ubuntu(or Debian derivative in general?) enables debugfs by default,
I think we need to make those ``debug''' code work although they might
not be designed to be used like this.
To my limited knowledge, iotop actually uses debugfs to show IO utilization.
(There might be more though)
Anyway, I incorporated your review and sent it as v3.
Thanks again!
- Tong

>
> thanks,
>
> greg k-h
