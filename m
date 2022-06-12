Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30041547833
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiFLBeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 21:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiFLBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 21:34:07 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3B831505;
        Sat, 11 Jun 2022 18:34:04 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ef5380669cso22463737b3.9;
        Sat, 11 Jun 2022 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7nh5YsWIGsFsPy8I0BiGnoKKyplcIhWUAiplzAUB5c=;
        b=UhCtc2uk4yXd3pZsgLsQjOBST2tQqu/Nj6qioLNjUb5iD0TRuf9YJeRrrb5Z9Pb1mX
         pemjMi+RckeyR5RcbI3c6ij1+OwtXovkFI7fnL7lPhhvF9CnW26IGa3sGuYM3ciOAF/8
         /jY/FIqROdBWSHJlAoCFd4AayvtIpMuMQHs8ED7I+huJzaqKASSUBLmYjibLM4egb+dG
         QwHUIIV+6auVVUaFKkg4cq4nckdyj5PI/rkZiSEVwrggjCgeq3QxVfae5YKHN4JRD6CU
         rWwA7SIzpW+MlA1M8tJwjYZ1ZSWuALM5fu+q0yiRkrKE7qenexjuIGpmrg8WAnRMdEKl
         T9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7nh5YsWIGsFsPy8I0BiGnoKKyplcIhWUAiplzAUB5c=;
        b=etNbHny0km/vkAFbBKPFMhR6iQmiYAOznHc9uWaAT5d1j2aDftHeuaxhMExnKMUrK2
         ToBmtFMm8GmIuGKScIngTM1TphuHWY7Z0yPEoF8VJzJwtny48hM9is0IUL//IUBxWD7O
         4J0yxTlFodS2EDbrqr6uUAvNdX5dgpLsyA2+hBq/c24dToc9gOf10iXhNKbrKNvABPD2
         DIRW0paSaO9ls4jtDKJzZVOneYCegLYkyR7teLAvrFf4cfuZdvBmtX1Eg69wS8ZTjsmr
         JJbw9PKEW86T3JpIOItb7FHjkrXxNgXHAeXfRMGF4lSXuADqeomh5aV2csJlJfycBpY/
         wZjA==
X-Gm-Message-State: AOAM533TvgZp+vvdN4wjrv/qGfupomiiW+zmRpJbW7MA10qeR+6lBdDe
        ymGLHQZFGYauyC3akpASzwctEpo3IYN9mp1FZcQ1rAkWJJciPQ==
X-Google-Smtp-Source: ABdhPJyClOpGoBxj8F52APO3pVxuHCYZl8sesBE4iHIiJnR7gmjFrFQ43WoQFGh7fYvb1wZFP7mDNWdYOfkoMI9vIsM=
X-Received: by 2002:a0d:e291:0:b0:313:8b2a:1eac with SMTP id
 l139-20020a0de291000000b003138b2a1eacmr18660117ywe.518.1654997643250; Sat, 11
 Jun 2022 18:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220602213544.68273-1-max@enpas.org> <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <20220611151551.5024f51e.max@enpas.org> <CAMZ6RqLb3irjBrpiOv23Hg6vVpzK4d31Pvat2AOS3EC0+e_=3A@mail.gmail.com>
 <20220611184157.06271432.max@enpas.org>
In-Reply-To: <20220611184157.06271432.max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 12 Jun 2022 10:33:51 +0900
Message-ID: <CAMZ6RqKzO7ya3Z-fx+FZ5vAsOy0B9Ec8TRagjysJEK0i4Z3asw@mail.gmail.com>
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun. 12 juin 2022 at 01:42, Max Staudt <max@enpas.org> wrote:
> On Sat, 11 Jun 2022 23:42:39 +0900
> Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > > > Are elm327 and can327 synonymous?
> > >
> > > No. ELM327 is the OBD interpreter chip, made by ELM Electronics,
> > > that my driver, can327, speaks to.
> > >
> > > If you have an idea for a catchier name, please let me know while
> > > it's not upstream yet ;)
> > >
> > > I only changed the driver name from elmcan to can327 because I
> > > wanted to emphasise that it's not something official done by ELM.
> >
> > I think it is common to name the driver after the hardware regardless
> > if it is official or not.
> > You have many drivers named after companies without their blessing
> > (random example: hid-nintendo, pretty sure Nintendo did not
> > participate in the making of this).
> > And it makes it easier to research.
>
> I agree, hence the original name. I don't want to pick a fight with
> anyone though, and a good alternative does exist (can327), so I prefer
> to play it safe, at least this time.
>
> IMHO, to anyone who knows what an ELM327 is and who is looking for this
> driver, the "327" in the name is very likely to hint at what it is. Not
> many CAN devices are called 327 ;)
>
> There are also several compatible parts with extended features, so
> locking in on the original chip's name may be counter productive anyway.

Generally speaking, I would be worried if everyone started to rename
the drivers. What if I named my driver can58x instead of es58x and
what if Marc named his driver can251xfd instead of mcp251xfd? Things
will start to be really confusing.
But I did a quick search. Several clones also use the name can327. So
in your particular case, I think this renaming is kind of acceptable.

>
> > > > Nitpick but I would prefer ascending order: 1.3 then 1.4, then
> > > > 1.4b and so on.
> > >
> > > Hm. Fair enough. In return, please let me explain my thinking -
> > > maybe you find it useful:
> > >
> > > With reverse ordering, you can start from the top, and then continue
> > > down the list until you hit your own device's version version. As
> > > you go further down, more limitations will accumulate, until you
> > > stop reading when reaching your device's version. Everything below
> > > can be ignored.
> > >
> > > Matter of preference indeed. If you insist, I'll change it around.
> >
> > Here, we enter the domain of taste and colours. I gave you my
> > preferences. Use it as an input and make the final decision. It is
> > already really great that you took time to write the documentation.
>
> Thanks! I'll think about it until I release v8.
>
>
> > > > > +At present, can327 does not evaluate this response and silently
> > > > > assumes +that all commands are recognized. It is structured such
> > > > > that it will +degrade gracefully when a command is unknown. See
> > > > > the sections above on +known limitations for details.
> > > >
> > > > This information is repeted twice whithin a dozen of lines. When I
> > > > read it, it was still fresh in my memory. Removing this paragraph
> > > > won't hurt, I think.
> > >
> > > The reason why I repeated it is for casual readers that don't read
> > > the entire document top to bottom. Or who may have done so, and
> > > then jump into the middle of it - e.g. only reading this
> > > "Communication example" section.
> >
> > This indeed applies to long documents. Yours is succinct enough not to
> > have this issue.
> >
> > > Do you still want me to remove the dupe?
> >
> > Same as above, I won't force you. You can make an educated choice to
> > keep it or not based on the feedback I provided you.
>
> Okay. With the new section ordering, I'll shorten it to a mention, and
> refer to the known limitations below. I prefer to still mention it, as
> the actual description only comes later. Kind of like having to declare
> functions that are only defined after a call site.
>
>
> > > Thanks, will do. I may wait for your cleanup patches to appear,
> > > though.
> >
> > The v5 of my cleanup is already in the master branch of
> > linux-can-next:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/
> >
> > But you might have a conflict on drivers/net/can/Kconfig so better to
> > wait for the v6 (or apply my patches manually if you are in a hurry).
>
> Your v6 just hit linux-can-next, so I'll rebase on that.
>
>
> > > > So here, you never loopback the skb. For what I understand, the
> > > > controller does not provide such loopback features.
> > > >
> > > > However, local loopback is a core part of SocketCAN Concept, c.f.:
> > > > https://docs.kernel.org/networking/can.html#local-loopback-of-sent-frames
> > > >
> > >
> > > That part of the documentation links onto itself because two
> > > sections bear the same name :(
> >
> > Loopback doc links onto itself? Or should I say that it *loopbacks*
> > onto itself? Don't know if the pun is intended but find it funny.
>
> Kinda like googling "recursion" ;)
>
> What are the odds that this mistake happened for the loopback topic!
>
> No but seriously, there are two sections called "Local Loopback of Sent
> Frames", and while they are meant to reference each other, the one in
> local-loopback-of-sent-frames references itself
> (socketcan-local-loopback1) instead of socketcan-local-loopback2 .
>
> I'll send a patch...

Thanks!

>
> > Do as you prefer. If you do not want the mainstream release to be
> > further delayed, I think it is fully acceptable to go with the lazy
> > direct loopback as I suggested and then later on provide a new patch.
>
> I agree, I'd rather leave the code as-is now, and fix it incrementally.
> Especially since you've reviewed it so thoroughly, and I don't want to
> unravel this again, and it works well enough as-is. After all, the
> documentation does start by saying that there are no guarantees ;)
>
> Do you see any problem with leaving it as-is, i.e. not setting
> IFF_ECHO, and thus having the CAN stack do the the for us? As far as I
                                                 ^^^
do the what?
> can see, it is equivalent...

It seems a part of your answer is missing. I do not get what
alternative solution you are considering instead of using IFF_ECHO.
What I propose should be a three line fix: add the IFF_ECHO, use the
can_put_echo_skb() and the can_get_echo_skb().

If leaving it as-is, can327 will behave differently than the other
drivers. For example, candump will only record the RX frames when
users expect to see both TX and RX. So that's my real concern.

The other thing is that the can_put_echo_skb() and can_get_echo_skb()
do some other operations. For example, can_get_echo_skb() returns a
length of zero for the RTR frames. If you do not use those helper
functions, you have to do the check by hand and only increment
stats->tx_bytes if the frame is not an RTR one.

If you leave it as is, then just fix the RTR length e.g. like that:
https://elixir.bootlin.com/linux/v5.18/source/drivers/net/can/vcan.c#L95

>
> > I am happy with your answers. I let you make the final call on all of
> > my nitpicks and do what you think is best. Because I am done with the
> > review please add the following to your next version:
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> Woohoo! 8 years after getting the hardware and working on it on and
> off, this project is nearing the finish line. Thank you!

You are welcome!

Yours sincerely,
Vincent Mailhol
