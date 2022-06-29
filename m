Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FEE55FC36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiF2Jix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiF2Jiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:38:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302E34BA9;
        Wed, 29 Jun 2022 02:38:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p136so20720913ybg.4;
        Wed, 29 Jun 2022 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mp9zxdJA2OiJQ0Bm/ests6Z63/2Q0ti9RtwNUquGFRo=;
        b=IFao+2AYHUbGngbGMkpysU7lxBAq1aMdiKx/lOIIZZAQihhn26dj70C25CwSxluteD
         vrbECs/A2IP1WpQbMhOd2+RxA8FpwfaaSjhsy0c3BliB1cVh7nCSt0F20efB/k4JWQwP
         LbCwrDBT3PWuO2J5b0UQFwy3YeNPXoiA17PS8/bZ15SmkxCoGDGsDScHdRwDlsvSTwpU
         Z0+d7SbbxNe0d3xr4xVr+vGQ0MMDlg2iTgdPIghyM6bi8Zw1mohl7Gk+Ue7nxMs/eIGS
         3njEnGiBLSIJcr/RVb8UopXhy1dDuvW4Uok6v6yLyBwTTNRI3AgSaqB1fXNOwfgTNgCx
         MjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mp9zxdJA2OiJQ0Bm/ests6Z63/2Q0ti9RtwNUquGFRo=;
        b=HZRRWNCPKLSA/gaOGTq5pZrX+2d073RTcqqeX846JtKF1ZNQHnpcULNGf3wOxkkeNv
         LiuBjZDoiLakE6pdn+YMZhB7H/wjjM0f4WyhkNrzKBZtFw6hxhNWzGSeqSfXy6+y2eZM
         xhRm4gaMoNUoJuk5KC518NIA2sAn0YzRRWAxY/TFIK1OH50u6BUwF2ShbWIkbJgBa2EU
         4Elqh1mpYREa8YIqsgm2rQwO21KwHU2c49gZD4lsMXeJjvBIerEXoue/BzgAHoSbh1sl
         d4sPc9fpZEq/cn1SHb8Sj46rAnCWh+ZJm5xLcZvyEuMj19I7/fddpYqltVX3VgBrW+Oj
         d++w==
X-Gm-Message-State: AJIora+Bmw1waX7FksHWOr2qSzLcfynhZp+DzP4h2IXmUkNaUSA5ulsm
        GjRxgVyxWI0UhdhAf9d9U7gXtumN+OCzSJH86ME=
X-Google-Smtp-Source: AGRyM1t0jclxfUgNzIBmXnSCV5p7R6oe7jERPq3hhJWC502aEDRixKkM8YD13FfB79/wD2sfobB9m8Jvf++KMJEal94=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr2308428ybg.79.1656495529385; Wed, 29
 Jun 2022 02:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
 <20220628134234.53771-3-ilpo.jarvinen@linux.intel.com> <YrtxxqnQ5fZKsUoY@smile.fi.intel.com>
 <c2959ca9-5817-f843-4a9b-95c8ffad9fca@linux.intel.com>
In-Reply-To: <c2959ca9-5817-f843-4a9b-95c8ffad9fca@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 11:38:04 +0200
Message-ID: <CAHp75VfpCE5xXDYhNX2ro49NnnBn+RUMn7ZozWLiSzT=VQe5Xw@mail.gmail.com>
Subject: Re: [PATCH 2/4] serial: 8250_dw: Rename offset to reg_offset
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 9:52 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
>
> > On Tue, Jun 28, 2022 at 04:42:32PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > Get 'offset' variable out of the way of parameter named 'offset',
> > > rename it to 'reg_offset'. This is very short lived change as

a very

> > > reg_offset is going to be soon removed.
> >
> > I'm not sure why this change then even needed...
>
> I could either:
>     1) create one large patch doing many thing (2+3 or 2+3+4)
>  or
>     2) add the 'offset' parameter with some other name first and rename i=
t
>        to its final name after local var 'offset' is eliminated by patch =
4
>  or
>     3) rename local var 'offset' first out of the way so that I can add
>        'offset' parameter in patch 3 (=3Dthis patch)
>
> If I just drop patch 2 and only do 3, it won't build because 'offset'
> variable appears twice (as arg and local var).

Now I got it, thanks. See one remark above.

--=20
With Best Regards,
Andy Shevchenko
