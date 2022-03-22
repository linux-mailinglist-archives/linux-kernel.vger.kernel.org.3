Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C744E4157
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiCVOb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiCVObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:31:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E96A033;
        Tue, 22 Mar 2022 07:30:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o10so17845373ejd.1;
        Tue, 22 Mar 2022 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n8t1dnR803GS4DcmePZxEgPndEBN5PcTpexwHu5EiSc=;
        b=dmizTs7zxk1hhLYRs9AwGQJ8/OyjsLl5o8Jyy3Q7IxgnA1GokvStcSDZYMKLDkY0WK
         csSZBYQCTuxRyYJoCYTfl6+Rq+hrw/Hy4jEB8YtvEoxgHKd2M3Z6dw2dLpEGl61pE5j9
         xBLW4Jf6LcR3HTlRT2dacIGnVo+nCNhuCIbhW+IrfTeOBuYco/+NZG+CYAtVND5vSU8P
         NResCI34R2TUAhCoRz4Qo00rDZ/pxQFx7MokCYVyoQJJgcw/Y1q8oU4c3rRI29CCLzTb
         WKgM2WCHc6f0OBz2pL1BWQE5mUceVOiVQeM0veSkapVqO4y7K0NDxfdCuNkZddUhNi2n
         b7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n8t1dnR803GS4DcmePZxEgPndEBN5PcTpexwHu5EiSc=;
        b=nNqiP6pjRFtNc9PBaOTCwtSfjPGSDHzaSi3MrH8OjfNUXXr+1BSyJbO1d2ozIFyvXM
         1d8+UtbuolFV/nUS7odJF/CHE5pX5Ovt4tqjCWPqEhG1ilJFKKX0SX1dpKu5lEEZHZe0
         ve3RV+yIZ2XxJWOFRD/HQDprUTdiFV+nPnYYta19EFO/LMKUd4ym5YTaVYRcexovF3ah
         3vMp8/mxc2AUP+LjNtXgojx6UvBLPOgXL7OlIh2KEn3sYzfZB2kClTQEUJdswCV8tLdl
         z1C49iYC35kLFzTZmUxk0BYQ8ZxRJHiRXO7Y9rQev+MtbKZvhAVFBDXa81KDeT5TOXnJ
         /Ghw==
X-Gm-Message-State: AOAM532L53IWcg8rqsXEALEVHByWh3Ffpp7OgwlC3+KCQjfGcntZwogl
        7fxHZolNhoA546uwe3jwTFLLB9/+GG1bTmTiZarGqcGGUfo=
X-Google-Smtp-Source: ABdhPJwso+n07HmH0IlW7nmSddH3CFAMkpKeaBLNQSuPhMe+Dv5Q1yIHYUNDWIcP8/xVQPODOApVZrgkpW/gONfjLSs=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr25687772ejc.636.1647959419419; Tue, 22
 Mar 2022 07:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220321163055.4058-1-pali@kernel.org>
In-Reply-To: <20220321163055.4058-1-pali@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 16:29:08 +0200
Message-ID: <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 21, 2022 at 11:07 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Support for UPF_SPD_* flags is currently broken in more drivers for two
> reasons. First one is that uart_update_timeout() function does not

the uart_update_timeout()

> calculate timeout for UPF_SPD_CUST flag correctly. Second reason is that
> userspace termios structre is modified by most drivers after each

structure

...

> (error handling was ommited for simplification)

omitted

> After calling set_active_spd_cust_baud() function SPD custom divisor
> should be active and therefore is_spd_cust_active() should return true.
>
> But it is not active (cfgetospeed does not return B38400) and this patch
> series should fix it. I have tested it with 8250 driver.

drivers

> Originally Johan Hovold reported that there may be issue with these
> ASYNC_SPD_FLAGS in email:
> https://lore.kernel.org/linux-serial/20211007133146.28949-1-johan@kernel.=
org/
>
>
> Johan, Greg, could you please test these patches if there is not any
> regression?

I'm wondering why we are still supporting this ugly hack?
Doesn't BOTHER work for you?

I would rather expect to have this removed completely.

--=20
With Best Regards,
Andy Shevchenko
