Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2D57FC68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiGYJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiGYJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:28:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB015FDE;
        Mon, 25 Jul 2022 02:28:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 12so9636488pga.1;
        Mon, 25 Jul 2022 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2dQ4X+cnbRMhJUY1XStndY/FJOOpWqDR+QCfVKqyoXE=;
        b=ZTQG6lf+5pveOyQc45gwAZPRhu7HPhVhG6/+JqYzJi11DP69MC1KWwwSfYeir2xGJV
         Yg2H3jOELwrz8532PcrOrrfl2qwBBYXUT0hJul2kSXPV8j+cAo/GG4AA6OqP3vUHjNOs
         J5IxJaO+VqWlqKTA5d5HXmR4+/qigaxlU1iShtJQHDbmJx7k+LhK02qy01HaSVaDEhTw
         7nAfbqQPQRQiUAMMYe1ADaQtmvDbyLuKgEdCGu2FngcOaDstfQjqxEctQvwgPNVu3Ziv
         cg/9hbSaHT23O0A4MoLPyWs7SObbXNwIaSmLEhiDb9fnK7klPAOwiyG3iQ9WkAZ+USgU
         GNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2dQ4X+cnbRMhJUY1XStndY/FJOOpWqDR+QCfVKqyoXE=;
        b=BW6WDZ4CkRz4XYipmrOknfvSp93Qabaq239aWjlOPzQZCcJFwEjNBqjTe190Mx5E7Q
         qqhJ10R3X5uNpp52RDaZAprnNXYqyp+PI4+WSnvH/+LOOe7DK7KiR89qWIdYp11aNnRx
         tmlVTUVj+qI6o2JJrinzDiADdbxLyuOg4e795MlCt+qvMROy/b2PAD3FszCkNPvvgBLV
         imH7gE6RUbmEQqBiwAr6z24CuflN9mnJvFYr2idLy4SrUxWhSlUE+v9kyuppGYuK6ROU
         WOz1B6kZjP1FpYrIv/PB8pu4ZkGO0Xq8aCnnbvKpOL9Ww6syuUXVOGOlUpRfV395W1uR
         IbzA==
X-Gm-Message-State: AJIora/ylrP6KBmHkLStkkLd4QMneIw/QLI3igpWYGZUVqOIDBaXSBDA
        7zi9/e9s90y1rUA3eP9q5kbUSCfkL7UmZucI3uxf7WbF/3E=
X-Google-Smtp-Source: AGRyM1vdBqu4ALX2CG//iGU1ZAnLFFN7tKb8l2U6533sarrqo9w+RCwH7pFryXwirWD7oT1fb1jVOhagImiI1WBjjmM=
X-Received: by 2002:a05:6a00:158d:b0:52b:18a4:c73a with SMTP id
 u13-20020a056a00158d00b0052b18a4c73amr11812006pfk.51.1658741279658; Mon, 25
 Jul 2022 02:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220623103543.4138-1-yongsuyoo0215@gmail.com>
 <CANXPkT49g7_YaL3rABY5Uhohz=EPgPqOL2tb6K4SHsWmshtysw@mail.gmail.com>
 <a3d44193-68f1-81a6-6baa-19e8403c5cd6@selasky.org> <CANXPkT6cffk3uQm6fRiPpe2rvHzzvDKgwhYnQh+TVcBo_Dw=uQ@mail.gmail.com>
In-Reply-To: <CANXPkT6cffk3uQm6fRiPpe2rvHzzvDKgwhYnQh+TVcBo_Dw=uQ@mail.gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Mon, 25 Jul 2022 18:27:49 +0900
Message-ID: <CANXPkT5t114TXscVMLeU9bk3qxi8mXbUPF_FEY8cabxxp6ZwxA@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All

2 months have already passed since I sent the first E-mail.
Can you pay your attention to this patch ?
Can you take care of this patch ?

2022=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:36, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Dear Hans Petter Selasky
> Thank you for your response and good advice and informations
>
> Dear All
> How is this patch going ?
> Is there anyone who can share the current status ?
>
> 2022=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:42=
, Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > On 6/26/22 23:11, =EC=9C=A0=EC=9A=A9=EC=88=98 wrote:
> > > Hi ~
> > >
> > > How is this patch going ?
> > > Can you share current status ?
> > >
> > > Thank you
> > >
> >
> > Hi Yongsu,
> >
> > Linux guys can sometimes take a long time to include patches speaking
> > weeks and months. For now I've added your patch to multimedia/webcamd
> > (v5.17.1.1) which runs under FreeBSD 13.1 (not Linux).
> >
> > https://github.com/hselasky/webcamd/commit/0e4d4959a2aea2e6a88d316eb943=
592fe0b23d09
> >
> > --HPS
