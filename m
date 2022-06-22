Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64096554791
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357868AbiFVLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiFVLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:39:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A43DA7A;
        Wed, 22 Jun 2022 04:38:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s185so10117424pgs.3;
        Wed, 22 Jun 2022 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Xm/Cc+WjGF9w38efHz8/Fdpd8CEJGg3+KIj5FlQGUn4=;
        b=kjyc3M4P88ac4PQDaSHnFeRSV92PtWd5FYdJuDyKlm7i2vrDqqEcuWo1WMvs2uP5jL
         Bs8eTfIXWis+VCWswkAIbiyFg9rPT5uEec2oqyvdCvtGyHeCU35xsebKyWgjJrHn261q
         8eHi3jS6PY7atMpqYKac3CeXGKzzu5uYOedsM86gX6OgzsULoCkGtgS8b/PKh5KK/3ta
         7JUUKIKPVB+n2Yj6HHJpbitTw3rTUewR1jgxaYM9bT/21bP2C2n70RpDJ4HWW3FLM4U0
         /rQH6JiaetT+R0trfcd51LsPn5YbmWo7AFbwhEv5+3ZorxdUzhtW9AVTF27XkEH2BlTn
         ZdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Xm/Cc+WjGF9w38efHz8/Fdpd8CEJGg3+KIj5FlQGUn4=;
        b=dvhBCkuQ3U2Hyqr0GVnUW8/7D5nQk9T+OGDbBuDP6/XpoIeQwJaJHr4Bho4r1RC3Sj
         lcwZUeXYxKOIgzPfnDH1dbGqdWpd0qDfKA/vvOHMA8j2gvvuoUagXpyNPmt0Aobzg4Ra
         0BtcOe9a7BI3dCvYLYFAbNOGYFqBbVHgbE0lNwD6FEvL1m7NkMvM1qLYicDK9HUH/xXh
         KRC+psaq0SdSmOEYcwhZ/dsuzmBJouQZ6WXPr3TqU7EnRF5v2t4Cfp8ZW2QHgs0wK3id
         8N6d/xjqEjB0Oke5SPgibXWeZBYlazcVzO4Xgy2fXl1emtZmrjWv+p1zvpM3bp+vpUsZ
         XVaw==
X-Gm-Message-State: AJIora/82PT0kiMcX4Dhf9W6Hgw3X8DGtJWfCAgOGJ+tvg2EONnJvfYe
        3hrujiCHBFqM8SWFvyBDY+V6ucyhIZ+VJd/u6nvG2LO1/Qw=
X-Google-Smtp-Source: AGRyM1uatdmC3STj9aZKvdy0Gb+9xl4YQYQ5ccF9nX7utIXXbPsFQZ/dfIB5p9n2nb+4r0gV+XsyrvZXlTt3kCmkOjA=
X-Received: by 2002:a05:6a00:1a87:b0:51c:29f1:13a0 with SMTP id
 e7-20020a056a001a8700b0051c29f113a0mr35297086pfv.13.1655897919907; Wed, 22
 Jun 2022 04:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
In-Reply-To: <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Wed, 22 Jun 2022 20:39:20 +0900
Message-ID: <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     linux-media@vger.kernel.org, mchehab@kernel.org,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alls

How is my kernel modification going ?
Can you check my kernel modification ?
and give me the feedback ?

2022=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:54, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Dear Alls
>
> Can you check the Below E-mail ?
> Can you share how is the below patch going ?
>
> ---------- Forwarded message ---------
> =EB=B3=B4=EB=82=B8=EC=82=AC=EB=9E=8C: =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsu=
yoo0215@gmail.com>
> Date: 2022=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84=
 3:36
> Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
> To: <mchehab@kernel.org>
> Cc: <0215yys@hanmail.net>, <yongsu.yoo@lge.com>, =EC=9C=A0=EC=9A=A9=EC=88=
=98 <yongsuyoo0215@gmail.com>
>
>
> Dear Mauro Carvalho Chehab
> My name is YongSu Yoo
>
> I found an incorrect logic at the function of dvb_ringbuffer_pkt_next in
> /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c.
> I correct the bug like the attached file (
> 0001-media-dvb_ringbuffer-Fix-a-bug-in-dvb_ringbuffer.c.patch ).
> Please check the attached file.
>
> Thank you
