Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D354CBA22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiCCJZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiCCJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:25:50 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1736B40;
        Thu,  3 Mar 2022 01:25:04 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id gm1so3632152qvb.7;
        Thu, 03 Mar 2022 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNW5LS4vhAwkIaVU+2IP0rY0q8Okjc/r0hmM5gzh7KU=;
        b=Ts1UbuXzl4NSXZMOXmc88YX7HmSMmmr/tiddGJYBwWw5mR5PtLO2wkjRacVSe7nTfe
         zU1aZyvykIgjQpFoAPGre8A1slhPWZTi1TVJd5upP4VI1GGNcSZR2wuKrEndQeJndw/H
         B6grXZaacOhTQ86OiWSRx/jlcYrYuGC/87w1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNW5LS4vhAwkIaVU+2IP0rY0q8Okjc/r0hmM5gzh7KU=;
        b=geQSRFe6Fi6oZff4VdnxQmGaGMq0apqxzGFnE0zo/XBn2mhWzYqJfuY1cr4J8xbBAz
         d1xpxRBjUKjzWg4DPleZow2bsC+jFQdwEkatXc2LAoBKXHfXKUW04Vn57gmYFU1DX5BJ
         Sb81a/48PO3n6NuZfc7PBEXFNRccbtOjAWfC6Qht6jSuI9T3chOsAYUDUwOECO7bWjW6
         zEzEhdeIFWbpC5ucmghyexSz/6yfvyHKE11a72qyC82ADsh5kdZF2ValQqY7oCKkvwJi
         HyvvOwJCIeezBvGBGMp3ZJXdEvK3Hr5aphbXbS/0tJg2deSoyO3IQO8qYH25Ku1wH8hS
         lGfA==
X-Gm-Message-State: AOAM5328f9ooyE1/Zvb28q2YqPbFxUzhTHatXnqKoxAVB0kmk7KpHNh9
        B+bgFVqG0O9wb4npI/Hj1I5EqODWJQwU1dkQ4gA=
X-Google-Smtp-Source: ABdhPJyOi/7U0YJ/wIJevTXD8zhlCiS7cwxhklzH0U5oMUwKh/uxLXtK0TqP5HXlA4zB0StmRaEyJEzhxelasXBOrm4=
X-Received: by 2002:a05:6214:1769:b0:432:dc20:f006 with SMTP id
 et9-20020a056214176900b00432dc20f006mr18286473qvb.130.1646299503959; Thu, 03
 Mar 2022 01:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20220301224446.21236-1-eajames@linux.ibm.com> <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com> <YiCHPuNkMuO4uARu@hovoldconsulting.com>
In-Reply-To: <YiCHPuNkMuO4uARu@hovoldconsulting.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Mar 2022 09:24:51 +0000
Message-ID: <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
To:     Johan Hovold <johan@kernel.org>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 09:15, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Mar 03, 2022 at 08:52:29AM +0000, Joel Stanley wrote:
> > On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> > > > IBM manufactures a PL2303 device for UPS communications. Add the vendor
> > > > and product IDs so that the PL2303 driver binds to the device.
> > > >
> > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > ---
> > > > Changes since v1:
> > > >  - Fix commit message Signed-off-by ordering.
> > >
> > > Almost there. You're still missing a Co-developed-by tag, a From line,
> > > or both.
> >
> > It's neither. This patch was applied to a tree by myself, and I asked
> > Eddie to send it to mainline for merging.
>
> Then you are missing a From line. As the patch looks like know, Eddie is
> considered the author and not you.

You are incorrect. Eddie is the author.

>
> > Given it's come through me, and now has been sent to you, I think the
> > chain of s-o-b is appropriate.
>
> So the chain of SoB is correct, but the authorship is not.
>
> You can use git-format-patch and git-send-email to avoid this kind of
> problems, but just manually inserting a From line in the body of the
> mail works too.
>
> Johan
