Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93C54F64A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiDFQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiDFQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:03:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43954967D8;
        Wed,  6 Apr 2022 06:34:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot30so4242137ejb.12;
        Wed, 06 Apr 2022 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yoT8S//D770vY3WgW13o5h7gy26zZL3xUZVY0D1xI6I=;
        b=OKY/Oe2bpatMWaw7vBgaG0P60ZrBk2oUeIRtq6TjKIsKtgU33Bi98lS9vRxfBOVs12
         sBgypLxIrid8xr32V6QtCPgDBenafkPoly7NKF1tkA8amXEgxdCZKHcQh+ww6J+shesQ
         3ufPIoLM2G7cdngFuZdX5hlWxVJXEwkqCa6FImka3W4SALriS0RlRcFFeKJBsdQGy+4C
         MGBk9SBOzbekOm1IxDpGeSxvwARzlPVTsLbgK+xbdiNHkddo/GDrsO5CNYcslprWntAt
         Vqa4ysQ+jZ2gG7C2CKmWZ0LrPrnMZsMdHAr2Jsb4rW1BaT6BIV8nGziTKPXGIoLWZAm5
         1Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yoT8S//D770vY3WgW13o5h7gy26zZL3xUZVY0D1xI6I=;
        b=plzIuRlsUkzhDhDI2kVKZ/mbs6yJkCBpc2MsochAmbYQTzqpIUht5NnodKRe+7UO1C
         ZXnTpk8GcfraLHFRN8PgyOoUO/zO9bkM8EKrrv+lb4NWXaRxk7aMPOzYMMszKqI7Yv+p
         xGJhh3oTM2DAxMlfxktP1zO04Yng6estD8Lf5S6wjeMBlAVB9JGxxEwGymGuPi7DuxLV
         AlqbgdpAwkjXgAPANPvJ/d/Ef5BMvrPzfgFWqqvXKVbhncvTbhZqZ/FoTjZ+lVmXdKpu
         Z70rBZZoGLwZvcoJlGEd5JFYVxevhHHgBRqU+WHAbooqrJNvXnF5SQxtMOPjJUTyMqYg
         76ug==
X-Gm-Message-State: AOAM530eWYDUP0nNaPgCO0DVYhVOyBRi3XWoErzgRtfglzeBJ7IM/D55
        uIPnAi3gxUgqpWgOiz8YykGdw6C79XiVFJ8McbTBQs90ssifkw==
X-Google-Smtp-Source: ABdhPJx5i2eoEp7I2rY0229o1dYOKIKuh1vnzQC48AwjR8p6JjH3s9hUSj0yFqtcgLd4+fE8BGA4QYWpey/PVg6NVxs=
X-Received: by 2002:a17:907:7704:b0:6cf:48ac:b4a8 with SMTP id
 kw4-20020a170907770400b006cf48acb4a8mr8213309ejc.305.1649252094031; Wed, 06
 Apr 2022 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
 <eefa63b3-2a4d-4470-9a4e-517087ebcfaf@collabora.com> <CAHCN7xL2uZTMy30FGfDkDK4Lym6wvfr_MTv7QwtchrkTXMQiuw@mail.gmail.com>
 <79a9c925-d930-ad23-dc53-9ebc16d1328a@collabora.com> <3f778844-f655-74a7-0a00-05caa84eca35@collabora.com>
 <CAHCN7xLy2381AFLWhLxk5YuRV7C=OwLX=XPXONX8sbkg-SqMjA@mail.gmail.com>
 <CAHCN7xJWQa-uXb0-+CSvAr1JhFmQYt80Q=uGvaY8uyptNcfbgw@mail.gmail.com>
 <163202bd-ea51-e80a-1481-568fae25b045@collabora.com> <CAHCN7x+AwNauiyaVL=NGARkmxWOL9uLS5-AO4TjkvLGNQ=3r+Q@mail.gmail.com>
 <bb462ee8-7bf9-5574-7cc2-098cc66e5ef0@collabora.com> <CAHCN7x+DTjeP7zQJYPyqzdz=hXWjz6Br0v1sWh4n1J3TJPb+9g@mail.gmail.com>
 <8d23c99a-4ad0-e65a-0134-12f5d119e8bb@collabora.com> <CAHCN7x+YuXFrMe6dYo_VhkG7ey1jcPTpOMCM1=qoTivZO9U2Rw@mail.gmail.com>
 <f495aa2b-81f7-a3cd-a6dd-cc5ae5f0a81f@collabora.com> <439e5c67e66dfff8f44f63787e2cdb8379f87446.camel@ndufresne.ca>
 <a1069c94-4c3c-ee4d-738a-752bb1d12dac@collabora.com>
In-Reply-To: <a1069c94-4c3c-ee4d-738a-752bb1d12dac@collabora.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 6 Apr 2022 08:34:42 -0500
Message-ID: <CAHCN7x+hvYjoZFA6uaTXq-XfLMck-ht7Z-VzzvGpkh7H7BBbEQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Move HEVC stateless controls out of staging
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, kernel <kernel@collabora.com>,
        knaerzche@gmail.com, jc@kynesim.co.uk
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

On Wed, Apr 6, 2022 at 8:05 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 06/04/2022 =C3=A0 15:02, Nicolas Dufresne a =C3=A9crit :
> > Le mercredi 06 avril 2022 =C3=A0 14:50 +0200, Benjamin Gaignard a =C3=
=A9crit :
> >>> default=3D1 value=3D1
> >>> 1: Frame-Based
> >>>                    hevc_start_code 0x00a40a96 (menu)   : min=3D1 max=
=3D1
> >>> default=3D1 value=3D1
> >>> 1: Annex B Start Code
> >> It is the same so that suggest the issue is coming from GStreamer plug=
in.
> > Can you report the GStreamer commit hash you have building on ? Also pl=
ease
> > validate the creation date of the plugin (libgstv4l2codecs.so) against =
your
> > source update date. Reminder that GStreamer is now mono-repo (just in c=
ase).
> >
> > https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC=
_aligned_with_kernel_5.15
> > Hash: 54b7c1f98084c85d103446cc3f2edce42ad53b0f
> >
> > Benjamin, can you confirm you have no local changes and this is the has=
h you are
> > building from ?
>
> Yes that is the hash I'm using without local changes

I was on (gstreamer-HEVC_aligned_with_kernel_5.15) with a hash of
4b78eaa48c0c924afd57f85c47396b77497e69f8

Benjamin's hash wasn't listed before, but I did a git pull, and now it is.

I've checked out that hash, and I am rebuilding it now. I'll report my
findings when it's done.  It's building on the imx8mq, so it may take
some time.

adam

>
> Benjamin
>
> >
> > regards,
> > Nicolas
> >
