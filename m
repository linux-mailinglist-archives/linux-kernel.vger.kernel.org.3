Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9355765E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiFWJL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiFWJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:11:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F036E18;
        Thu, 23 Jun 2022 02:11:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k127so13317419pfd.10;
        Thu, 23 Jun 2022 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I4ccaHhoovprD3iVhskXuHk/EsoG0EupnyPDdxO9s0o=;
        b=jR2ZDFt/AWjx+HZ/oGEGnMoHS6cydfh34+17sQGqE6zmiCYEneG6r5EyiLKJr/172z
         cnIy6Ahpxd1iqKKFC49j1jbet/UyBnduJZA6qKgQz3Kx0K4QExo95LLZ/yRnQV/071su
         Rq+KrArGkMRYmHnS+knp4x4GQQOXocPup0g2h6xIHaDSvjb4lATKbpNr+Y1uAngs2Eez
         yiEqS5YNKUYkSWEfeIj4jgYnkIWmyP0xmL8lQ2RbmssZGGLZ0w9/zlvHZYEgnu6WNslL
         jByCrORcNE/HlZkmPV8Vb0FuTxOhrdQ0m/TUSVCsAO0CKjYepOVzfAr98/j5Z1kPbwvc
         g1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I4ccaHhoovprD3iVhskXuHk/EsoG0EupnyPDdxO9s0o=;
        b=VuGi4iPlSh7pooZaAzyZ3KzWcBcT+DOFAAkMKztwVL8tK8EReVHWBzROY+9r7Xz+jJ
         dtdDQSjoJBaKchS544Q4xUNidmsLztg4c0XJlx6qesC5lPWRfdjDgh3iQ1ALTMi9Rzaq
         v3lyMOfqH708D292/FpVhfSeAZkkeiGo1ssTaijqdmNQ6oZlYA+Ic7EY39lDuy+Pv9c7
         LYXbWdy+GQOAx9v4DCnUOiuEZ/TFKboEc88b6OXpzzPJiKY8jgfIxVX8Ha1xpLL+aYoe
         LKyKT+e7MMu20SP0BYm+/ji/zhv1CwXlgtltI0JDp59Am1ryu9JTOdgVZn6cTACZU0Ur
         HNcg==
X-Gm-Message-State: AJIora/IcDe+6CwEv5vde5ikmkaZ5yF5KpFEJGW7uBOAEkaW8XDrH5o8
        fkxGzPbRGmD3ueRmcYYtG8EUbC1bJppz3MthNRB3LwPF+Aa4UK1w
X-Google-Smtp-Source: AGRyM1v2Pir4+VBd8h5wwYzEtipTh8UQ3t/a6WaI7nkIjJ2K2k0y8M9U8i2uH8kMZQUiK/JDu/vs+wFH3PH/E5Tmkr4=
X-Received: by 2002:a05:6a00:1591:b0:525:3b0d:85d7 with SMTP id
 u17-20020a056a00159100b005253b0d85d7mr11595458pfk.51.1655975510978; Thu, 23
 Jun 2022 02:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus> <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
In-Reply-To: <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Thu, 23 Jun 2022 18:11:40 +0900
Message-ID: <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org
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

Dear Kieran Bingham

I sent E-mail again by Linux terminal by using the command " ... git
send-email .."
I believe that you will surely get the diff file.

Thank you

2022=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:12, =
Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Kieran,
>
> The consumed variable should not be negative. This bug has been there
> since the beginning of the GIT at Linux from what I can see.
>
> +1
>
> --HPS
>
>  From 108c6acb2cc4bc4314b96f6f254a04b2873a096c Mon Sep 17 00:00:00 2001
> From: YongSu Yoo <yongsuyoo0215@gmail.com>
> Date: Sun, 22 May 2022 04:53:12 +0000
> Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
>
> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> The function dvb_ringbuffer_pkt_next in
> /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
> which searches the idx of the next valid packet in the ring
> buffer of the ca->slot_info[slot].rx_buffer at
> /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
> has the following problem.
> In calculating the amounts of the consumed address of the ring
> buffer, if the read address(rbuf->pread) of the ring buffer is
> smaller than the idx, the amounts of the searched address
> should be (idx - rbuf->pread),
> whereas if the read address(rbuf->pread) of the ring buffer is
> larger than the idx, the amounts of the consumed address should
> be (idx - rbuf->pread + rbug->size). But there exists an
> incorrect logic that the rbug-size was not properly added on
> (idx - rbug->pread) in the later case. With this commit, we
> fixed this bug.
> ---
>   drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c
> b/drivers/media/dvb-core/dvb_ringbuffer.c
> index d1d471af0636..7d4558de8e83 100644
> --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct
> dvb_ringbuffer *rbuf, size_t idx, size_t*
>                 idx =3D (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZE) % r=
buf->size;
>         }
>
> -       consumed =3D (idx - rbuf->pread) % rbuf->size;
> +       consumed =3D (idx - rbuf->pread);
> +       if (consumed < 0)
> +               consumed +=3D rbuf->size;
>
>         while((dvb_ringbuffer_avail(rbuf) - consumed) >
> DVB_RINGBUFFER_PKTHDRSIZE) {
>
> --
> 2.17.1
